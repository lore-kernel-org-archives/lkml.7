Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E9CC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 07:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672482173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 07:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2WcM44h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfHRHeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 03:34:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36862 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfHRHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 03:34:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so5344959pfi.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PSPB7brmWubpWruh1lB/hweaDv6zJwTFWV8CbU/p38o=;
        b=X2WcM44hKVObSuUIDqKlPoK+wf4DC1kuHOL/Ms+lMtLcK/cyjEu3JXUA5MlRzUXvqy
         IK9XXwvs8/LYXgaAqaWPr1qtM7pLOjbBKXb51atJXDlUGLB49vfwvLeCpaUPI5f3dOyt
         rfzEs3d9eYDcYs51R8Ghmnf6q99X5+ulQ4UTT4BCbfGds6T8DOMIo8MrtALi0W3r7PmX
         4p80NpE30Q9BHu2MqMNefd6PjmSt9ofxfBTyJSH66hURbh8jq+maMeoWk6ko6QOlpHOd
         whYbvXSr4cPnbagJ4xZ1w50CsEN5xSjqXQhh0Us3Qa316pdt4K7NQKr7xp35aKsloLqs
         rPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PSPB7brmWubpWruh1lB/hweaDv6zJwTFWV8CbU/p38o=;
        b=r1gFt7A/oh/FUpBOh179nPmGjjJSpl4FzrI9HTGruTzasiS4BlxPGVcNVCCIYXKjVW
         I1DxG0ZN5IZksskVrjmS4mWzbMcxJlGJiOe0PPiMwTC+ksqmGdYfMUlksPgMWjpF/OFP
         htY0aLnh6ta+tXc74tef7TQCDXFQeSH59MaBNnlyaK5k8anq9q9IH18t1jO0YvIvWlkv
         Zuo0jz5LbtA8dp1H1oJTjlvWP9czxCxRcUkVLY/udTHClkTkIp0BKaayiDp+mewzO3ML
         5JFJBsVEX/QVdEnIfqe8PfZxKMoy8rfWYW0Ln8s0iWu5LS6dO1cbrLf9qVFWGc/AzQAV
         NzUA==
X-Gm-Message-State: APjAAAXMHPdgZqVTHt5mPq2ef40lQietbGc3hS0AnQm/IAbBZmFAERic
        1m6CrrjbowOSWglxaNM9Lys=
X-Google-Smtp-Source: APXvYqy9nQfZDDnGbXo4QMPoZLba5GtRh09t9XlqH0bzIznKSRO3gLYUme3NMK92GeAyttfxGih7bg==
X-Received: by 2002:a63:db45:: with SMTP id x5mr14679632pgi.293.1566113683023;
        Sun, 18 Aug 2019 00:34:43 -0700 (PDT)
Received: from localhost.localdomain ([106.51.109.255])
        by smtp.gmail.com with ESMTPSA id m4sm15012778pgs.71.2019.08.18.00.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 00:34:42 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jonathan@buzzard.org.uk
Cc:     joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v2] toshiba: Add correct printk log level while emitting error log
Date:   Sun, 18 Aug 2019 13:04:31 +0530
Message-Id: <1566113671-8743-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <c3f3f8394a018bab44081b00563ab3aa4b1aca22.camel@perches.com>
References: <c3f3f8394a018bab44081b00563ab3aa4b1aca22.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk functions are invoked without specifying required
log level when printing error messages. This commit replaces
all direct uses of printk with their corresponding pr_err/info/debug
variant.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v2:
- Replaced all printk(KERN_ERR with pr_err(
- Replaced all printk(KERN_INFO with pr_info(
- Replaced all printk(KERN_DEBUG with pr_debug(

Only v2 needs to be taken in, v1 can be dropped.

 drivers/char/toshiba.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
index 0bdc602..98f3150 100644
--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -373,7 +373,7 @@ static int tosh_get_machine_id(void __iomem *bios)
 		   value. This has been verified on a Satellite Pro 430CDT,
 		   Tecra 750CDT, Tecra 780DVD and Satellite 310CDT. */
 #if TOSH_DEBUG
-		printk("toshiba: debugging ID ebx=0x%04x\n", regs.ebx);
+		pr_debug("toshiba: debugging ID ebx=0x%04x\n", regs.ebx);
 #endif
 		bx = 0xe6f5;
 
@@ -417,7 +417,7 @@ static int tosh_probe(void)
 
 	for (i=0;i<7;i++) {
 		if (readb(bios+0xe010+i)!=signature[i]) {
-			printk("toshiba: not a supported Toshiba laptop\n");
+			pr_err("toshiba: not a supported Toshiba laptop\n");
 			iounmap(bios);
 			return -ENODEV;
 		}
@@ -433,7 +433,7 @@ static int tosh_probe(void)
 	/* if this is not a Toshiba laptop carry flag is set and ah=0x86 */
 
 	if ((flag==1) || ((regs.eax & 0xff00)==0x8600)) {
-		printk("toshiba: not a supported Toshiba laptop\n");
+		pr_err("toshiba: not a supported Toshiba laptop\n");
 		iounmap(bios);
 		return -ENODEV;
 	}
@@ -486,7 +486,7 @@ static int __init toshiba_init(void)
 	if (tosh_probe())
 		return -ENODEV;
 
-	printk(KERN_INFO "Toshiba System Management Mode driver v" TOSH_VERSION "\n");
+	pr_info("Toshiba System Management Mode driver v" TOSH_VERSION "\n");
 
 	/* set the port to use for Fn status if not specified as a parameter */
 	if (tosh_fn==0x00)
-- 
2.7.4

