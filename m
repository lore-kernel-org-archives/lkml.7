Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B597C06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D41F208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8MepicQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGADYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 23:24:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45976 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfGADYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:24:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so6537617plb.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 20:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eYA3vKTta6LKS1D/XK4ZvRYQaXSF2BIW0Hf1nNsZli4=;
        b=D8MepicQN9u84HY/PmIe5HLoyHz6T4kQZZz8+uVOmBlwJh1NlN+OqWy5FNLX71wRLh
         ZO2g1VAETronF87ceXs5GHvyAb9tQzayvWI6Wl0TjmTQgL5gtaNl4e4Pw9IgiB/+Domz
         uV0ZrhdAucZeM0qVGqG5Ll6Gpqe78C8Zoz09i14knUkIkg3hbHZ9q4AQtOBO/ophn4lm
         W/Jq+CEM2HCum7xXsaKyumlz7YamGcAiX8i9n7JkiY7pRZvFJnPSPhhe00cSNGDrz0Nz
         NS0pZTycYNta0xcGoTWmdOR/SOa754zl+m2qqb5efqIYIsJqLpxuO/YmxWrx65+Dkd0H
         gkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eYA3vKTta6LKS1D/XK4ZvRYQaXSF2BIW0Hf1nNsZli4=;
        b=p4U+ep6e5HYVw0qBJ+JnO4vcqeXlLOmw/0pSoDwBb5Al4HFsGn3w/H7BJIP4kZAzhg
         ae4atBWljW/Vg/d5bPaygUCZkG1koZ6nuR/keQgG+yHEhjoX21K5q3fWQckBD42g3ZVT
         vot9edHbtZLlcS0lMMLZWsV9x8t5ZzvcpKS7bVO0sJLRwP+k3Leah0mDHs9z+0D9nwlk
         9Gq7m2PLzl8QWfoQ8cefCYTnOaKEpolrkuTBUYP/9Elv/xclkfuko9zWAK2dT2ieSW9S
         DhkKSNkDqAF5OZQbgPyVoC5jJ40/eqenn9XOaR+ElV8UTF+op/+EXzuxQkGHF3A5W4h7
         fuPQ==
X-Gm-Message-State: APjAAAWRt64oRsZkVXSGGXEDxuvg+7n4tPstikyokgY1Td5SumE75tEH
        gjRYGL78GXMvHBtKZbw+8fI9c5JkoTA=
X-Google-Smtp-Source: APXvYqySLGQhmtjaHuYtuPGDI1mFSZeQ7R5YkDextsKVLlbJcd1QzM84G8X4iolRiaEyBJqVrxD6jA==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr26319595plb.103.1561951461685;
        Sun, 30 Jun 2019 20:24:21 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u134sm9373816pfc.19.2019.06.30.20.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 20:24:21 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mailbox: Use dev_get_drvdata()
Date:   Mon,  1 Jul 2019 11:24:13 +0800
Message-Id: <20190701032413.26073-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_get_drvdata directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index a64116586b4c..0cfdd53d04a1 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1165,8 +1165,7 @@ static int flexrm_process_completions(struct flexrm_ring *ring)
 
 static int flexrm_debugfs_conf_show(struct seq_file *file, void *offset)
 {
-	struct platform_device *pdev = to_platform_device(file->private);
-	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
+	struct flexrm_mbox *mbox = dev_get_drvdata(file->private);
 
 	/* Write config in file */
 	flexrm_write_config_in_seqfile(mbox, file);
@@ -1176,8 +1175,7 @@ static int flexrm_debugfs_conf_show(struct seq_file *file, void *offset)
 
 static int flexrm_debugfs_stats_show(struct seq_file *file, void *offset)
 {
-	struct platform_device *pdev = to_platform_device(file->private);
-	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
+	struct flexrm_mbox *mbox = dev_get_drvdata(file->private);
 
 	/* Write stats in file */
 	flexrm_write_stats_in_seqfile(mbox, file);
-- 
2.11.0

