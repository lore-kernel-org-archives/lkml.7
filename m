Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5992173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCYVH/nW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfC1Hrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:47:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37492 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1Hrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:47:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so2123373ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R0kNkLex1+77ZCVGLb99mVxwEPvFRePmbL5QDdb+QKQ=;
        b=uCYVH/nWcjyVxWRe7dlsfl8UL77Fl8y/yZWrP4FmCYZzwy55lZrqZGU78G9OKaDYFE
         1kvzpP4XuP1YRfFscc7gR07SCrWwk3eQJzq9zhlMNj76MiLpVtTjvXWjCoBDiIJthjSW
         FHqA4+WAbKeQOJCcypf6hTs23yU+UXh7czqMaSRTq/4DS0MO4NJEqoibTqn7G1+kOIv2
         OqraTm9MEwWYa70gyNyWnxmDq2uMdhgmJWQftpF0h4rCITYImHqxG5jw2OFN2Y6sFbbM
         +Re8bPcGLjr+phAhTeb3MN1Vrncwwah8pR8BDg5862jcLvXnaJEX8CIShqwqdsb5xICR
         83kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R0kNkLex1+77ZCVGLb99mVxwEPvFRePmbL5QDdb+QKQ=;
        b=Ytj6z8g7hYx058Xdesb9mRiYvne82gt7HJBL+sQ4EwQazVN01dZP9GXzfe31zm3woS
         qRB3luHW+q0EU8PP6FVGUwKLGbNSrCq5/7v3O8DWlXtPN1cT3s5/Er7tnnoVq91YkGXO
         X2k3mjLcf3N7uqJRlGHbX9QbXpWZj6pjkRgRoDYNVyDZP8rCB2cJMQmFS+NEdOSdXluQ
         Ot/SlPAqYxB5e7qwZs7bd97zVkH6bq3aEfp4KLlvsUbmVvySbt37MO1FXnFcS89CcjKK
         luZHMEYPApIa/sSiDhFPokl+/oZ/EefXA8iDQgneFW0hc+9pFf/m7V+QwZCO/vFhL9cj
         9GHQ==
X-Gm-Message-State: APjAAAVrGaaEoavZWSPPDZCe2QQEIdpoCs5b1NCSe59hm8zI2giA6HGn
        kidAu7VBUQRJbmbaM7qE7Jc=
X-Google-Smtp-Source: APXvYqxyz0F66ufsARza4btQHCNtrOYqkYhxxFSh07FMgw+dS8tPvTWyWI67+aczrUQ1IXJWPISdTg==
X-Received: by 2002:a25:b9cb:: with SMTP id y11mr33057897ybj.340.1553759261114;
        Thu, 28 Mar 2019 00:47:41 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 201sm7856151ywp.84.2019.03.28.00.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 00:47:40 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        yuzibode@126.com
Subject: [PATCH V2] misc: fastrpc: add checked value for dma_set_mask
Date:   Thu, 28 Mar 2019 03:47:37 -0400
Message-Id: <20190328074737.9185-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There be should check return value from dma_set_mask to throw some info
if fail to set dma mask.

Detected by CoverityScan, CID# 1443983:  Error handling issues (CHECKED_RETURN)

Fixes:f6f9279f2bf0 (misc: fastrpc: Add Qualcomm fastrpc basic driver model)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
V2: rebase misc tree
---
 drivers/misc/fastrpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 39f832d27288..36d0d5c9cfba 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1184,6 +1184,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	struct fastrpc_session_ctx *sess;
 	struct device *dev = &pdev->dev;
 	int i, sessions = 0;
+	int rc;

 	cctx = dev_get_drvdata(dev->parent);
 	if (!cctx)
@@ -1213,7 +1214,11 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	}
 	cctx->sesscount++;
 	spin_unlock(&cctx->lock);
-	dma_set_mask(dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask(dev, DMA_BIT_MASK(32));
+	if (rc) {
+		dev_err(dev, "32-bit DMA enable failed\n");
+		return rc;
+	}

 	return 0;
 }
--
2.11.0

