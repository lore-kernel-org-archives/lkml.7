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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14707C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE822171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+CMiNRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfG2POq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:14:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39326 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfG2POq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:14:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so27681222pls.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRGM4lI5cHNNvDlFzhCg6EnRKA/S87KjOkBtW2kwimI=;
        b=M+CMiNRwouV5a2XGOvuZRpYzsyEzlhra6t7+euc6+g6d/Wl9OztufFd62inXh1DrFr
         Cxk4cS+I0VAEAO+q/IZt6aQk9uiRL+U/kWwaMHlQ/sb3JFiTf+Zqribg4DukpYBkkv4u
         GPEXcyAUnPvGgFFr0Y8v7k09pe6Gk4g9pATsPZjTvoEmrZHTwaqzImZGMNzyUX1s6QFF
         C6eVQC3iguN8gJ4Gw43wUe6UnTVdvydZFH1+r/2cDGt1iFWs5UbmTjFixZ5AItikSd43
         JATDm+3j0bATI0MqzeqQBKgfAb3ee4HSyhMnzZhWtPFOTN/w9vv9hpB5cMkXLtUJwyTN
         3pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aRGM4lI5cHNNvDlFzhCg6EnRKA/S87KjOkBtW2kwimI=;
        b=ZR4cLWA9Fz1HVbkpijunvlAbikzYKbzYXuq9YDM6PmxrcSSYsFFXZwPRBNh6t2LuPm
         feg4nfyEJ5dJN5talPSbuS4wdFTGRYMFK3HzEHMONC3DkGnwVGmkxnQex6siUank+8yU
         eatl4e6eIRPbD6CiBAl0JG3o0ZNYJA9KD3A3Fk+8Qhh2KROCHuX0a1wrwWLETXQcakaJ
         jC2ymMZ2VCnfBovmFAcTyOreTrkmfCeia2UV43SlRJQGlEJ5VkqF93KoELeLHjTRUqSy
         H2AC5jSkCIrOoF7uuOCHxfl6DlUTQaEzPGN/AUz2A2Spitwo8fMUaSUKfecB4HU2RmHM
         mFLg==
X-Gm-Message-State: APjAAAWQuV9qt9m4gHGrpUYAEJFaaXuI735BS+LnmOuDXKsALifms3EX
        GTkj9Xi+H8J9oq9ujRtjjbs=
X-Google-Smtp-Source: APXvYqzo4k1noD/lEHd8b22cl5IiGLfrZLG+AJGyL3asO8xVhm3MsmyEYiiKxQEu6zUMBjAiUqtf6Q==
X-Received: by 2002:a17:902:3341:: with SMTP id a59mr20182095plc.186.1564413285764;
        Mon, 29 Jul 2019 08:14:45 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a3sm64283930pfo.49.2019.07.29.08.14.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:14:45 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 06/12] module: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:14:41 +0800
Message-Id: <20190729151441.9552-1-hslester96@gmail.com>
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
 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 5933395af9a0..7defa2a4a701 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2251,7 +2251,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 		switch (sym[i].st_shndx) {
 		case SHN_COMMON:
 			/* Ignore common symbols */
-			if (!strncmp(name, "__gnu_lto", 9))
+			if (str_has_prefix(name, "__gnu_lto"))
 				break;
 
 			/* We compiled with -fno-common.  These are not
-- 
2.20.1

