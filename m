Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B98C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4662184B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9TLv1RL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfG2PPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:15:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43126 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfG2PPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:15:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so28199207pfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/hp4OYCVIASUt8ADEIu51CzpsXUC1BVA5mKItwwsBE=;
        b=U9TLv1RLwtmBgZTfoeXq0CgEz/u/mBsw5ETvjL0Mm89hqzOOC4qT4AD9fsFwwCwmdh
         zt7nm0isWTUJHEuWiz2Ve4m2blf2a/tr5g8REi77ljIsfL2QOwMoWI0rRNUb7JJ6rG2i
         K+V2STY5HitLH36evJ/cftuYdnJf/8upqAQCTkqsokk7urk5iQZI8k2+rGYrGOJ0Y28P
         LEWdW4pzU1BSO2OB2yUFFGKFoScB9Ng32EdEFJiYvjqPROj5Fbv0/VRZ8pHPf5TxO6KQ
         HZAftJoMTu3YrVP/knaaNQszAH4C8JFAIcw5i6cz+gT3DYk9w9MBKbCzOpZq0eDj5afw
         twkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/hp4OYCVIASUt8ADEIu51CzpsXUC1BVA5mKItwwsBE=;
        b=kQNDF4PV1ldzDCtJ51hEV96/RWQ58HBUbiGMFWrYAt2qy7B+Rm5pfz1XaBCffiTe7Z
         Cd9gCgpcmCBXYtfFYmHSoli5Sh2gMvfkcZvTiv0G+IwxGZChJ/i626bSdWlevTamm7MU
         cq2Z5SQDwcbuI++vx1tB5doKZBIIFMORMM/F8v8PGuspCF1armhESWtuSYJqgQKKYSjj
         ip/nN1OqAWRn+CL0yXHoFHq+d5hhP6BW3e306AgvHXtoYAqFTS/pBSwjYqFKTIUaSZv0
         7GZRuDFPNA2QY3DGRA0zl8l1OrsbCA+kTFWhdWVmv0vxc2PULLna5hoVDHpzxhfgTEVC
         LQVA==
X-Gm-Message-State: APjAAAWp2VlqjMvcm1wi+cSY51Lfiio4JGieC/tBMEcjIHuZHz/AA7Os
        k3VpnmLIhJzQ/LAe5lGpAXU=
X-Google-Smtp-Source: APXvYqydEOus2aS8b9RAwEUjypsJXRtr8cx4edqwYHIWbJpib18FHEqzwqBAjn+1ojrtZ9GBPqMTtg==
X-Received: by 2002:a65:43c2:: with SMTP id n2mr104849232pgp.110.1564413310188;
        Mon, 29 Jul 2019 08:15:10 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id f14sm62752969pfn.53.2019.07.29.08.15.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:15:09 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 08/12] printk: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:15:05 +0800
Message-Id: <20190729151505.9660-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/printk/braille.c | 4 ++--
 kernel/printk/printk.c  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index 1d21ebacfdb8..64f0fb8ef27d 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -11,10 +11,10 @@
 
 int _braille_console_setup(char **str, char **brl_options)
 {
-	if (!strncmp(*str, "brl,", 4)) {
+	if (str_has_prefix(*str, "brl,")) {
 		*brl_options = "";
 		*str += 4;
-	} else if (!strncmp(*str, "brl=", 4)) {
+	} else if (str_has_prefix(*str, "brl=")) {
 		*brl_options = *str + 4;
 		*str = strchr(*brl_options, ',');
 		if (!*str) {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..9e60dce4bdd5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -121,13 +121,13 @@ static int __control_devkmsg(char *str)
 	if (!str)
 		return -EINVAL;
 
-	if (!strncmp(str, "on", 2)) {
+	if (str_has_prefix(str, "on")) {
 		devkmsg_log = DEVKMSG_LOG_MASK_ON;
 		return 2;
-	} else if (!strncmp(str, "off", 3)) {
+	} else if (str_has_prefix(str, "off")) {
 		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
 		return 3;
-	} else if (!strncmp(str, "ratelimit", 9)) {
+	} else if (str_has_prefix(str, "ratelimit")) {
 		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
 		return 9;
 	}
-- 
2.20.1

