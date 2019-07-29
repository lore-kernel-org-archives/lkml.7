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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13C1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85A02171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+Q4hSFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfG2PPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:15:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36485 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfG2PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:15:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so28418694pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZw5zJlUaHZqjTi8v7H9aY2VgBMCyLLOX5E3euuUe8A=;
        b=A+Q4hSFeN/v8VhH2QhtaBTcxMp1KevW34tUAFJnIfjOabcdYI5JZPWNZt4C1xVYR5b
         Q+8C1vWoO0X8bW4h7I8bb4nvqr5DDBnXps/erEkKudRObCxl3XDdS/9yRgDVIN5dA7P2
         JkoPYysUudx9eQZrRiWKggKgdWPt4Cz46niYOSdH4FYIMVF67rLEj32mxvEGyXP9xNqo
         ARVQdvqpMbyKNxS9ttPjUgQVya65z00IKE2HqH89cbIxi2l6jAM3AgLGauFnVJOgkQ/t
         VdP7YdL2JaYvUGPBx7dsPNyDzbEtC48OS8FxdedCO0za6CCsqF+D+J/yZFWSbRAtrCzh
         cc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZw5zJlUaHZqjTi8v7H9aY2VgBMCyLLOX5E3euuUe8A=;
        b=Togf3AIa2LjUrXrxAiXF0s+mX2zR3rSEVjc5SJMykmIWLY4ezkPtJJo8KJLBjP9ayk
         h13bjvG+oiurmOyiYSmWjIUavAJ58iX1vi8obQ+7/xdOKgbLfiWjQWI+CzaWM9dwt+Ns
         9zeASzaYRQb49FbLRNcXJnm25Ocjz58Je3nQXvmSKm2N2ajsy3+B1tZug5XCRZouxy6x
         Q0fcnHFHw/pgZ41yXrjCCfzcXY2W3LQpljsyOqQSunPlnFuokZC7nA349KgbZrIiF/e4
         jvQrTKUatkN1yG5NSBLl2nWbBAObAaBZqWIJRdlmJ2xsAwxsNMuKiBBenEtY3YY/j+0v
         jkRw==
X-Gm-Message-State: APjAAAVSLu0K0L3NTnpTTOnlWH6+TkqvNGM3/IrEUsY/Bk8LPotHgcIv
        vNg2EHK9RDk+Nqz0v6Id2gMadzrwQlk=
X-Google-Smtp-Source: APXvYqxES8bUCkCu4Ofmhlv0jhodKV0iMkhe8omZ/+or1DrB+WtjdiSHeipQUZGVKOf7PKm9UlgmJw==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr62169605pgr.62.1564413331402;
        Mon, 29 Jul 2019 08:15:31 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id y194sm29691319pfg.116.2019.07.29.08.15.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:15:30 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 11/12] userns: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:15:27 +0800
Message-Id: <20190729151527.9822-1-hslester96@gmail.com>
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
 kernel/user_namespace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 8eadadc478f9..4a06ba563531 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1153,11 +1153,10 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 
 	/* What is being requested? */
 	ret = -EINVAL;
-	if (strncmp(pos, "allow", 5) == 0) {
+	if (str_has_prefix(pos, "allow")) {
 		pos += 5;
 		setgroups_allowed = true;
-	}
-	else if (strncmp(pos, "deny", 4) == 0) {
+	} else if (str_has_prefix(pos, "deny")) {
 		pos += 4;
 		setgroups_allowed = false;
 	}
-- 
2.20.1

