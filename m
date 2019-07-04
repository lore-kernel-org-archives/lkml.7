Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE5C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4420C2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDLkVrlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfGDCgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:36:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33460 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfGDCgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:36:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so2256081plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 19:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F9j6HjBRq5640gr+RHyU0iopfSX6KbJR8eZv/wK6uvA=;
        b=BDLkVrlZU7tQ/fOTHTVqWMvhw48pbAQRfhfVmBq+2ReEkzZge6HjPLkr5VePYYyGZ7
         t3IJ/8Uom3MV6hHiP2g8EqouT4qF7l30z4RJ6hq70xVm9L3dfsLT+gUbgwrqceN0QCG+
         hkOz+Fe6zHMxdTX7kfiYlfvgCfhYBiUUEztp71WoiYrjVV3OHFtLUqQ2bbBtt6E+V4pa
         ADSeHms4YMf69m0Q/f7gW0JsVoRvJyZjFY/opEPzXGZGo3fj0SGVGvWksAyKIfEktW28
         Q11LC0yrJSmNEpWuHTybiE0esrRTDcQ1yxD3m8/rnCgjOZmJi1Ykp0uKED/O5r2ASpOE
         Uolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F9j6HjBRq5640gr+RHyU0iopfSX6KbJR8eZv/wK6uvA=;
        b=hNs2v8vLVjI8hILhoZOHLZCPwLNY0pcmm29waUfWRceb8xQ6WXKXhyDQJoNRJgOJvd
         N991UGkzLJp7HHANxHpC4vUSyKM9bwjoNe7Yyum79vcx7+Pl8h7gRKHbwyPpS5Kz9qfu
         EOM/ZJx+s06W+WLlDAnB2aVolWeYPzLtgRuhAIEgOSVrrrKOpb4NbAvnImD1OcNPQR2u
         NT2vL+p8CERAzooepUNL8qys872RW4bla79HSTKs0nqApn8s9F6ERtdZFrsbnVZH+dKi
         eMIxoFr8YTah6PytECBiwU2eOoI7QBy1Y7+jIGCGGiW5ruJFobEZX5aAw0GMZX1YDZBF
         2wTw==
X-Gm-Message-State: APjAAAUFmCI2D0pwB1Zv9jfHGDL4C6SdxB7XRRpEA56plAsqYtG0HwvC
        Iy/Cn1pS6W2pKp0IC+Y+xcs=
X-Google-Smtp-Source: APXvYqzlowYW5uakGVvreE4w7gkLCuZWxUvJvmpKkZqKudW0Nb/PtpQvYDi7xvzF6R5/FmxiGj6hCg==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr45465477plb.26.1562207792465;
        Wed, 03 Jul 2019 19:36:32 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 14sm3554008pfy.40.2019.07.03.19.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:36:32 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 07/10] mailbox: using dev_get_drvdata directly
Date:   Thu,  4 Jul 2019 10:36:27 +0800
Message-Id: <20190704023627.4735-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

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

