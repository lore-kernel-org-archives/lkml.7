Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597BC20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KflKPus6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfC0Nbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:31:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33218 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfC0Nbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:31:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id b12so9978849pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mLHUvLUl5JoP1Ut8L87xfEd0NlI2Xu0jgPhDFdX5X0I=;
        b=KflKPus6sapVmTamnekpYwsNaSLWhI9W22GIhXqUa3kuVAEkg9PM4Gyep2VVW/VGPr
         /LkKYqKAT95qNVDQ3KqeS/DoPuMFxBk11Ob78XWVgdTkvCt7X/4SvlOTDvIy8zl+AAF5
         8Ihyz20aTcQvkom7Uza6cwC1B98K0/5fpgm5dKepsGfuUQJgRNQhrLWQIVr+GS+0urDn
         g7RwYogkgYQMVZh21WKSw1ALm3WasOghPsk98UtnYiA8iMU1FTEBgn7Dj8Bfyd/gV1Mh
         b+aJp8tuMM4R62RjrPywpb2cVbiJqpmW2X8ixxjLIZ1dXUMj1IzlpOl8OGFGTwkMi8MD
         CPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mLHUvLUl5JoP1Ut8L87xfEd0NlI2Xu0jgPhDFdX5X0I=;
        b=GZ5SDtVEHYpkXdls0iDnsTtrkZ+ewvrR1g29rMfABkIA273Ied3CTIVHs6f2xTQvHT
         xhMr2sSPR8D6+Ez6KdtNCj+32vwhCRViS4k78XgcV4hfzGIIhNbPhv3NzWq4WBCfZ8TN
         LS9tYjk0IXDNIuGkE52dxyXTXi5Jo7jMOyeEGRwbl08uJfOzCZ4GnZh6ysr3wsXXkOb4
         OoWDauQfwXxVIJM8HyDbncUTieMj8RN0iICYIuNbtnioUIhA76EoJTIUWc/qd3r6s9WL
         uqz65REXzWqBQrerHtPNPPVm2gwoyZNfp6jC0iURZNZpocr1VSYDSJkOiA7VJAST0EkS
         2PUg==
X-Gm-Message-State: APjAAAUbnnF8dCGHdEjTnggt7u+v4bb0qxfwhqJD5aIpg+ftqjmCGbej
        lBTOEMjhMKXe8QC9z5FTlY4=
X-Google-Smtp-Source: APXvYqxcwiEj3CITu/8MpR2E6faLNUm6oCbJ2+p3joBbFTwUNjsKVG48mP/Wk1fTB5ipOD9Hi/z6yg==
X-Received: by 2002:a62:3892:: with SMTP id f140mr29760411pfa.128.1553693500069;
        Wed, 27 Mar 2019 06:31:40 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b26sm32476954pgn.4.2019.03.27.06.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 06:31:39 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     georgi.djakov@linaro.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] interconnect: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed, 27 Mar 2019 09:31:37 -0400
Message-Id: <20190327133137.6743-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/interconnect/core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 6005a1c189f6..871eb4bc4efc 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -90,18 +90,7 @@ static int icc_summary_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int icc_summary_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, icc_summary_show, inode->i_private);
-}
-
-static const struct file_operations icc_summary_fops = {
-	.open		= icc_summary_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(icc_summary);
 
 static struct icc_node *node_find(const int id)
 {
-- 
2.17.0

