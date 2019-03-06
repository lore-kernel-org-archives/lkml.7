Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D58C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3537E20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="MyjgEF8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfCFMCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:02:06 -0500
Received: from tomli.me ([153.92.126.73]:46566 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbfCFMCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:02:04 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 8ef2bf1e;
        Wed, 6 Mar 2019 12:02:02 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Wed, 06 Mar 2019 12:02:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=17tJ+LRyo7NePFlBvhmpIAFh7/EROGjz26SLZpRTBYk=; b=MyjgEF8xFMA4gUUzK0fMkGKS7cEmhocL1cEJz+3xWQkWF1oIc6Ivgk5cXKWosfXFFnEQmk3b01E+gihpu7217/mIF9njqRnnLg4GWpWonTy3Hai06iAPuPP7r0qI+zJ8YpUUj/TZK7cOJwdKjdMA5Ohbut0Q5vYdmvwywJw7aCEspC6QET7fu185s+6dSNsHuBHS4lxaB9K0lR84yCuNWlQTFX/YdbgIdpxd6OAjws/X1vgKVBoXRrxWze4l6RsuZVNWNYXubdauiWriL+CbS/yuSpO9ZMXu3dtZMGWQNoLP959fomkpaA9fUbI7NV8MJmL9cQTWQ2gO+XJj+324Sw==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] mips: loongson64: remove yeeloong_report_lid_status from pm.c
Date:   Wed,  6 Mar 2019 20:01:10 +0800
Message-Id: <20190306120113.648-5-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306120113.648-1-tomli@tomli.me>
References: <20190306120113.648-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some complicated logic in lemote-2f/pm.c. During wakeup, it
creates a delayed_work to execute a callback to the function
yeeloong_report_lid_status(). It's only purpose is to report the current
status of the laptop lid switch, and this callback function was not
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

