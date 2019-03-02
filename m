Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98B6C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADBD20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="rbwmQQ7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCBRyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:54:11 -0500
Received: from tomli.me ([153.92.126.73]:41934 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCBRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 12:54:09 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id a1b095aa;
        Sat, 2 Mar 2019 17:54:06 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Mar 2019 17:54:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=vD8wIHxTaA+QFi1c9PDntjTUfB+mxBi+vzJRThgV/9Y=; b=rbwmQQ7TIVKg5CkoAZ2tiCPZ/LpfuAwIt2TQpeam6a4oohfJUqVmAMMqixF3PlgWw6T0ZJqoTChF0yJ2QQUsVuINJtvXxRcwg6xJ2bTlMhJItMWnIEWninrn2qZdg3eYJdTRzWy31pc55GDj0qRUsol7xORUJ1wu96eFzAdNZ2vdGNpW3yS2+gafYRMQgk0lcFuZ7KbwwIw/kQoUE5f+RcS3VTnkOVw5Wxi+eMmtMR6z7w+PS4GENs1K7qXZwGudNY/o4i3KWidxumwLg/bMeU3fEXSTx+4feY/LJj4L73IA2nfPj9QCOTVqqC1xdEkYpJTWL3JPXDf2XUCMU4v1mA==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mips: loongson64: remove yeeloong_report_lid_status from pm.c
Date:   Sun,  3 Mar 2019 01:53:31 +0800
Message-Id: <20190302175334.5103-5-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190302175334.5103-1-tomli@tomli.me>
References: <20190302175334.5103-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some complicated logic in lemote-2f/pm.c. During wakeup, it
creates a delayed_work to execute a callback to the function
yeeloong_report_lid_status(). It's only purpose is to report the current
status of the laptop lid switch, and this callback function wan not
implemented in the mainline kernel.

This level of overenginnering hardly makes sense. All we need is to report
the laptop lid switch unconditionally upon wakeup in the future PM code,
which is being worked on.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 arch/mips/loongson64/lemote-2f/pm.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/mips/loongson64/lemote-2f/pm.c b/arch/mips/loongson64/lemote-2f/pm.c
index 4ee7e9864700..ebe4b57535f0 100644
--- a/arch/mips/loongson64/lemote-2f/pm.c
+++ b/arch/mips/loongson64/lemote-2f/pm.c
@@ -80,17 +80,6 @@ void setup_wakeup_events(void)
 	}
 }
 
-static struct delayed_work lid_task;
-static int initialized;
-/* yeeloong_report_lid_status will be implemented in yeeloong_laptop.c */
-sci_handler yeeloong_report_lid_status;
-EXPORT_SYMBOL(yeeloong_report_lid_status);
-static void yeeloong_lid_update_task(struct work_struct *work)
-{
-	if (yeeloong_report_lid_status)
-		yeeloong_report_lid_status(KB3310B_BIT_LID_DETECT_ON);
-}
-
 int wakeup_loongson(void)
 {
 	int irq;
@@ -119,17 +108,6 @@ int wakeup_loongson(void)
 			lid_status = kb3310b_read(KB3310B_REG_LID_DETECT);
 			/* wakeup cpu when people open the LID */
 			if (lid_status == KB3310B_BIT_LID_DETECT_ON) {
-				/* If we call it directly here, the WARNING
-				 * will be sent out by getnstimeofday
-				 * via "WARN_ON(timekeeping_suspended);"
-				 * because we can not schedule in suspend mode.
-				 */
-				if (initialized == 0) {
-					INIT_DELAYED_WORK(&lid_task,
-						yeeloong_lid_update_task);
-					initialized = 1;
-				}
-				schedule_delayed_work(&lid_task, 1);
 				return 1;
 			}
 		}
-- 
2.20.1

