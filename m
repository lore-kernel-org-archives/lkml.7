Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9437C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C22121929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfCVWt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:49:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfCVWt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:49:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMnlLO758914
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:49:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMnl17758911;
        Fri, 22 Mar 2019 15:49:47 -0700
Date:   Fri, 22 Mar 2019 15:49:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-bddee90af621914f08a03d546419fc293e9140d8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        yuehaibing@huawei.com, daniel.lezcano@linaro.org,
        nicolas.ferre@microchip.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org,
          linux-arm-kernel@lists.infradead.org,
          nicolas.ferre@microchip.com, yuehaibing@huawei.com,
          daniel.lezcano@linaro.org
In-Reply-To: <20190322143940.12396-1-yuehaibing@huawei.com>
References: <20190322143940.12396-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/tcb_clksrc: Make
 tc_clksrc_suspend/resume() static
Git-Commit-ID: bddee90af621914f08a03d546419fc293e9140d8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bddee90af621914f08a03d546419fc293e9140d8
Gitweb:     https://git.kernel.org/tip/bddee90af621914f08a03d546419fc293e9140d8
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Fri, 22 Mar 2019 22:39:40 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 22:59:33 +0100

clocksource/drivers/tcb_clksrc: Make tc_clksrc_suspend/resume() static

Fix sparse warnings:

drivers/clocksource/tcb_clksrc.c:74:6: warning:
 symbol 'tc_clksrc_suspend' was not declared. Should it be static?
drivers/clocksource/tcb_clksrc.c:89:6: warning:
 symbol 'tc_clksrc_resume' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <nicolas.ferre@microchip.com>
Cc: <daniel.lezcano@linaro.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Link: https://lkml.kernel.org/r/20190322143940.12396-1-yuehaibing@huawei.com

---
 drivers/clocksource/tcb_clksrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 43f4d5c4d6fa..f987027ca566 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -71,7 +71,7 @@ static u64 tc_get_cycles32(struct clocksource *cs)
 	return readl_relaxed(tcaddr + ATMEL_TC_REG(0, CV));
 }
 
-void tc_clksrc_suspend(struct clocksource *cs)
+static void tc_clksrc_suspend(struct clocksource *cs)
 {
 	int i;
 
@@ -86,7 +86,7 @@ void tc_clksrc_suspend(struct clocksource *cs)
 	bmr_cache = readl(tcaddr + ATMEL_TC_BMR);
 }
 
-void tc_clksrc_resume(struct clocksource *cs)
+static void tc_clksrc_resume(struct clocksource *cs)
 {
 	int i;
 
