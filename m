Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DB9C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE5206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="Lgc0eqQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfGDGI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:08:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46291 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGDGIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:08:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so4881514ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBbOD4rj/6MTcJXlkxHvsQxP2TTle1/H3CMZv+6B/V4=;
        b=Lgc0eqQT/R1b7aB33G0Mii0j7RL/EyMCalrdd4T10q3Jjz5O09wz4zBWC98iXtsiop
         EchLcnoTN51L/4mAn4u6U946gxTkqRcbtCDb77/uqaUklg0Gj5UGoi2XVEyEeMePmKgn
         W6o2kyY2vWziIvF1tyT2ONHLwEjhmCI/MKTf6cVumE3fXcylTQR0pvzQrlXhXRwuLLwn
         3zYkmfvRFsZEbb9aJkUvwEgPBMsDqBjyyJBKnP0LYcH8v3xGTEz4hVY7QYbYLnzUrL9W
         EfxVPI2R8Jrg6EMOt5lICmMBVnTW+r3KOBN8pHNt1m0Moci5yWYNqVc3jAPpmnEJtwaM
         wdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBbOD4rj/6MTcJXlkxHvsQxP2TTle1/H3CMZv+6B/V4=;
        b=R7s9GCmCTyr8Ykw+EW3BvhW4mevYKbUcbwywnayeh4wBdU+h+e1H/kiYEgjB427OGH
         TFEYa3BgvZadG/W05BBrdTtr5HB6QvGXHQRUL76eHlWQPK6yigeuwqSurgwguM4G5bRF
         txlnNgl2pTHiSjQPyHkx2Ji169NmNxLPbtxWIhCCE/R0Ac8LLnXvp8rLwjXDRCQaJHcm
         xBYs6sUdaFvJKeddCtk2tevwTLAa5SuSlAIgxUF/VY0MCrKa9oah1SSzHt1Uqr+ZyqOQ
         Fgg6HkbipSJAx3UyCo7E0D+Zm/LjNMMbpCI5N6fP7osMs5S3xBdfLOoZ9nBVKjOAestu
         x3JQ==
X-Gm-Message-State: APjAAAVHdMWLV+VClri3S19pgiDpF9bngqzqXmh37Gy9JG2dHDIOxxFN
        Mycts4svPT/XsCoDTDnJITLS4KPAZHji4Q==
X-Google-Smtp-Source: APXvYqzZ6BCDAqrYU1giJPNAZ8lJa99B9+Frb2uYcMzIN2R0XBOUIf9/8i9L44wd6Hw6HZ6yfzXASQ==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr23606824ljb.211.1562220501712;
        Wed, 03 Jul 2019 23:08:21 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id b4sm710440lfp.33.2019.07.03.23.08.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 23:08:21 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 3/3] staging: kpc2000: simplify comparison to NULL in fileops.c
Date:   Thu,  4 Jul 2019 08:08:11 +0200
Message-Id: <20190704060811.10330-4-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704060811.10330-1-simon@nikanor.nu>
References: <20190704060811.10330-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch warning "Comparison to NULL could be written [...]".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 7feb2fde0db2..48ca88bc6b0b 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -247,7 +247,7 @@ int  kpc_dma_open(struct inode *inode, struct file *filp)
 	struct dev_private_data *priv;
 	struct kpc_dma_device *ldev = kpc_dma_lookup_device(iminor(inode));
 
-	if (ldev == NULL)
+	if (!ldev)
 		return -ENODEV;
 
 	if (!atomic_dec_and_test(&ldev->open_count)) {
-- 
2.20.1

