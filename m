Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62067CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4272A2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfJUP4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:56:38 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44861 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbfJUP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:56:37 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B013660002;
        Mon, 21 Oct 2019 15:56:35 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: disallow update interrupts when time is invalid
Date:   Mon, 21 Oct 2019 17:56:31 +0200
Message-Id: <20191021155631.3342-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021155631.3342-1-alexandre.belloni@bootlin.com>
References: <20191021155631.3342-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never enable update interrupts when the time set on the rtc is invalid.
In that case, also avoid enabling the emulation because it will fail for
the same reason.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index f8b7c004d6ec..bd8034b7bc93 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -545,7 +545,7 @@ EXPORT_SYMBOL_GPL(rtc_alarm_irq_enable);
 
 int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 {
-	int err;
+	int rc = 0, err;
 
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
@@ -570,7 +570,9 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		struct rtc_time tm;
 		ktime_t now, onesec;
 
-		__rtc_read_time(rtc, &tm);
+		rc = __rtc_read_time(rtc, &tm);
+		if (rc)
+			goto out;
 		onesec = ktime_set(1, 0);
 		now = rtc_tm_to_ktime(tm);
 		rtc->uie_rtctimer.node.expires = ktime_add(now, onesec);
@@ -582,6 +584,16 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 
 out:
 	mutex_unlock(&rtc->ops_lock);
+
+	/*
+	 * __rtc_read_time() failed, this probably means that the RTC time has
+	 * never been set or less probably there is a transient error on the
+	 * bus. In any case, avoid enabling emulation has this will fail when
+	 * reading the time too.
+	 */
+	if (rc)
+		return rc;
+
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	/*
 	 * Enable emulation if the driver returned -EINVAL to signal that it has
-- 
2.21.0

