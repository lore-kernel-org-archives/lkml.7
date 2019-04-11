Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFBEC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7F9206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDKOdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:33:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726644AbfDKOdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:33:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E985AF6D;
        Thu, 11 Apr 2019 14:33:34 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] rtc: ds1685: disable interrupts when moving work to work queue
Date:   Thu, 11 Apr 2019 16:33:23 +0200
Message-Id: <20190411143323.20945-3-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190411143323.20945-1-tbogendoerfer@suse.de>
References: <20190411143323.20945-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling of extended interrupts (kickstart, wake-up, ram-clear) is
moved off to a work queue, but the interrupts aren't acknowledged
in the interrupt handler. This leads to a deadlock, if driver
is used with interrupts. To fix this we now disable in irq handler
and re-enable it after work queue is done.

Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time clocks")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/rtc/rtc-ds1685.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 929f28375b87..5dabfa57bd2a 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -635,6 +635,7 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
 			 * to be minimized.  Schedule them into a workqueue
 			 * and inform the RTC core that the IRQs were handled.
 			 */
+			disable_irq_nosync(rtc->irq_num);
 			spin_unlock(&rtc->lock);
 			schedule_work(&rtc->work);
 			rtc_update_irq(rtc->dev, 0, 0);
@@ -741,6 +742,7 @@ ds1685_rtc_work_queue(struct work_struct *work)
 	ds1685_rtc_switch_to_bank0(rtc);
 
 	mutex_unlock(rtc_mutex);
+	enable_irq(rtc->irq_num);
 }
 /* ----------------------------------------------------------------------- */
 
-- 
2.13.7

