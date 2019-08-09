Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B715C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F184E208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQOagqHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405813AbfHIHLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:11:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35355 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405601AbfHIHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:11:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so44594198plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjwZNlktHghstpxixs3rvpStFdmZYyLz/JzoPP3gLRc=;
        b=KQOagqHHx1/8wVn2eGgM9qF1OnlzjsplWUmA0IrMsWeS7N05lMCyDGlo3aIdoGEVOQ
         qk/DYh5a1sv6ID7/o25lOJbzCFk9eGxFOSxwwd/2w8NvnphRK96MOkD/PeWk8j7dznXL
         xXwSEkSod1tfb1YBIhx7WJ18nkcVYWSD1QLmuH3VXfv8d/aUFmhSF0vu6jwzo24EWzSO
         1wukn1M3lTG23xpTd6mqAMmqVxmFSdAMJr+iZGR2dboMe+SkVDdbxGrgGUCIG/Ee1jRG
         gBxMWlr0A6oDN4GkzLrPieSAYYkeGlu3VgZImnqGbQUOp7DNsL1sAKztqipW6kQegHzb
         a0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjwZNlktHghstpxixs3rvpStFdmZYyLz/JzoPP3gLRc=;
        b=eqgwsyOGPx8b9X3jlGhUMKtSV3ehUPtGJAoK5AkwP9p4WKi4EGxirFGv2xugSMh7Uw
         hPOpt0qOnXTR5+VhfI2fdKbRw59+AWOCTV/UvRl5VEWupJ6ZI+TJ5WugtYxisnOG3SuD
         hl5swMqaMwr7ZhLf9ZEb98b89lZyWlGuf5y/EghdeZwwLbB4z395BRe+eRj80rKUAwRR
         F/OJ/gFupKL2esG2OWYPhSnoAo+YUCqUHuqTeSYxRm71AG3j+9L6yP1zkkIflemhgR+P
         +848EgHhZrnLh0Xg3GaLXRFssqfkkUeGXmGd/G9bbkWGT1VGmK7H9unrHiw9XWtz/uGa
         w9cw==
X-Gm-Message-State: APjAAAUQIXznCuf+mfL2t9Z4Gqs13+VxGpBwyWKpbvC6rLzH8fePVm36
        ERjyKYjUcJzbKPkHia9TeXvOn/goDMUJRQ==
X-Google-Smtp-Source: APXvYqwipRn4f40BsFSsZTBr98JqcBPcTzpWV0/hSYU1ENFr90IexVgrrMXlma0Kj19PKoqH2jMK1g==
X-Received: by 2002:a17:902:461:: with SMTP id 88mr7653273ple.296.1565334676707;
        Fri, 09 Aug 2019 00:11:16 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a16sm105506801pfd.68.2019.08.09.00.11.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:11:16 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 8/8] watchdog: Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:11:11 +0800
Message-Id: <20190809071111.17496-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/watchdog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..ac7a4b5f856e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -70,13 +70,13 @@ void __init hardlockup_detector_disable(void)
 
 static int __init hardlockup_panic_setup(char *str)
 {
-	if (!strncmp(str, "panic", 5))
+	if (str_has_prefix(str, "panic"))
 		hardlockup_panic = 1;
-	else if (!strncmp(str, "nopanic", 7))
+	else if (str_has_prefix(str, "nopanic"))
 		hardlockup_panic = 0;
-	else if (!strncmp(str, "0", 1))
+	else if (str_has_prefix(str, "0"))
 		nmi_watchdog_user_enabled = 0;
-	else if (!strncmp(str, "1", 1))
+	else if (str_has_prefix(str, "1"))
 		nmi_watchdog_user_enabled = 1;
 	return 1;
 }
-- 
2.20.1

