Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DB2C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE15E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfDPJeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:34:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:41622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726739AbfDPJeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C893BAE12;
        Tue, 16 Apr 2019 09:34:11 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: ds1685: remove dead code
Date:   Tue, 16 Apr 2019 11:34:03 +0200
Message-Id: <20190416093404.6785-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ds1685_rtc_begin_ctrl_access/ds1685_rtc_end_ctrl_access aren't used,
so get rid of it.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/rtc/rtc-ds1685.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 2f5194df239e..33781be58f16 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -192,42 +192,6 @@ ds1685_rtc_end_data_access(struct ds1685_priv *rtc)
 }
 
 /**
- * ds1685_rtc_begin_ctrl_access - prepare the rtc for ctrl access.
- * @rtc: pointer to the ds1685 rtc structure.
- * @flags: irq flags variable for spin_lock_irqsave.
- *
- * This takes several steps to prepare the rtc for access to read just the
- * control registers:
- *  - Sets a spinlock on the rtc IRQ.
- *  - Switches the rtc to bank 1.  This allows access to the two extended
- *    control registers.
- *
- * Only use this where you are certain another lock will not be held.
- */
-static inline void
-ds1685_rtc_begin_ctrl_access(struct ds1685_priv *rtc, unsigned long *flags)
-{
-	spin_lock_irqsave(&rtc->lock, *flags);
-	ds1685_rtc_switch_to_bank1(rtc);
-}
-
-/**
- * ds1685_rtc_end_ctrl_access - end ctrl access on the rtc.
- * @rtc: pointer to the ds1685 rtc structure.
- * @flags: irq flags variable for spin_unlock_irqrestore.
- *
- * This ends what was started by ds1685_rtc_begin_ctrl_access:
- *  - Switches the rtc back to bank 0.
- *  - Unsets the spinlock on the rtc IRQ.
- */
-static inline void
-ds1685_rtc_end_ctrl_access(struct ds1685_priv *rtc, unsigned long flags)
-{
-	ds1685_rtc_switch_to_bank0(rtc);
-	spin_unlock_irqrestore(&rtc->lock, flags);
-}
-
-/**
  * ds1685_rtc_get_ssn - retrieve the silicon serial number.
  * @rtc: pointer to the ds1685 rtc structure.
  * @ssn: u8 array to hold the bits of the silicon serial number.
-- 
2.13.7

