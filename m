Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E30C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A564120643
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWMoFiNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfDLHoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:44:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38037 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:44:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so4786643pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DKPxOJLCVge0IPyzUTO3MGJfjjfqSnkBvwJHFlZXiKE=;
        b=ZWMoFiNSYNGhe0meVdCT+0jsnleSIlrzbWVZCvKoSh0dODyZs0RCgB2L/Oz90KxGea
         BwQGpOHJC6oVu0fEgdktLNtiQY4KgQ1rBJOFMWxhDFh1xAfeH+ujD3EsNwB9+kor8lCC
         x0XJ0gBdVCX5zGd9VBvl5mY3fpBL1b/gLMfd2EQuUPMvsPUWJHkP+laRA5X8kPaiePqZ
         ZcD/B3rzDUmds6rzQGC74TgV3RwS4Y12USPhm+lUOsfLqc46N58Wst2v1jSe0KK5XxQ2
         42dEFZcyzzdM5miyKozdDbK2SHwWWTiyAr+ROJ5lRamERZu3ADPPjfIycJS/d5j2lyyw
         Eu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DKPxOJLCVge0IPyzUTO3MGJfjjfqSnkBvwJHFlZXiKE=;
        b=ngp1VBCjhnk1rjCATNIp9iWKoeqiju5gvUyLGlB65LYDKnkTdvY4r1KoF2MbiAfWq+
         vcvhKLTnzI3Fp+TQJ/iRaCpqccG7QgI7DR9YFq9/IyYbJbNhOLSEh/QO0r8bYezug2vV
         SFxxpp3Q4RCUc+J0qkDHSiYAklGKBXEursylo1OW4eKcnLzHkxdNNa7KNqjPKdYkuiZY
         PHwoW6C8pCAC4hAFNG2FQitzGTo5AHibX1J1v6WjDMJZwpzj7U8nPTxLjFwNe5Iltol7
         TWvkw96EmgcnWHe/WQzqetd/6fnsJ7e8J1XGslJepBzQFHbIDJyBEsG47No40IobT+4O
         LdLg==
X-Gm-Message-State: APjAAAWyOCqGFzjTeo1CxL9WdbumCcl56Cnm+c6FIejcGfCnODPqyOdZ
        L1V12MkDnLdkkvobpkjEWGspnsKsm5j0+w==
X-Google-Smtp-Source: APXvYqxuvqE3k2Pfiqrkm6dg4Hal98AplsHmrd1aB9ji6GeIMbDocBdcAm1HO3MgXsoD7MYZsq1NQw==
X-Received: by 2002:a63:158:: with SMTP id 85mr52024851pgb.351.1555055047095;
        Fri, 12 Apr 2019 00:44:07 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id x24sm55641791pfn.128.2019.04.12.00.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 00:44:06 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>
Subject: [PATCH] Drivers: misc: fix out-of-bounds access in function param_set_kgdbts_var
Date:   Fri, 12 Apr 2019 15:45:06 +0800
Message-Id: <1555055106-31728-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

There is an out-of-bounds access to "config[len - 1]" array when the
variable "len" is zero.

See commit dada6a43b040 ("kgdboc: fix KASAN global-out-of-bounds bug
in param_set_kgdboc_var()") for details.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
---
 drivers/misc/kgdbts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index de20bda..8b01257 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1135,7 +1135,7 @@ static void kgdbts_put_char(u8 chr)
 static int param_set_kgdbts_var(const char *kmessage,
 				const struct kernel_param *kp)
 {
-	int len = strlen(kmessage);
+	size_t len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdbts: config string too long\n");
@@ -1155,7 +1155,7 @@ static int param_set_kgdbts_var(const char *kmessage,
 
 	strcpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
-	if (config[len - 1] == '\n')
+	if (len && config[len - 1] == '\n')
 		config[len - 1] = '\0';
 
 	/* Go and configure with the new params. */
-- 
1.9.1

