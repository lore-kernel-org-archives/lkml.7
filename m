Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31945C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048F3206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WpT3fRrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbfCARjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:39:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36571 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCARi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:38:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so13036602wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7OjYhQ1sxkg2lrErPUHFawejB35OfwkS5HMv+Kb+3Oc=;
        b=WpT3fRrmmDGKLng1Pk9RdeeAjfVOrhpOxK+2rcL8c4ekji3V6VAE9E/fZWqQ9PsLsI
         R9fk0ZkieXy4+MTCF7ds+h1OLFLnhXyuNiMVdDtxnNoA1MtJunXl5Oql5FXHDCivyjOL
         t7HvwlxVHVZIhHVOtYjLpKH5UpCrbTN2GmJ4JNUtG6u7xHuBcWx2Ceu57gxzy71elwgK
         j7UiArbrcSZGtx0OyA7GHRXj3mvx197tnVI8n52kLFozqzEHfzLipo6SceOcM7SsjDrZ
         FseWprmhlF4/vFsJQ29Dh0vUKEqxtvUhPCP1bwV1dbt/rUK8upGapmQhRQ6nLTv2RD4p
         wvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7OjYhQ1sxkg2lrErPUHFawejB35OfwkS5HMv+Kb+3Oc=;
        b=rUVC6dXiDb9r2HWMFVbXaBPjTh06B9Uy2QFFRVrV/b4vC91p46l+eYA8POlqFFbOIT
         Twvb/wBd4CJ7G3tERBnx2UpvvcWQcR/N5uUrI3XAtwTCYPdrdxM8k/7eGMaqQ4nZ57It
         6dDsKRdLEvcgAtVjoHr7S7oyQJpTcfCKvS5T+/KQwfj/0PD+pyEr/LmsbPepJMSixwn0
         RytxQr+KMR87zVqs9SOp3BGjDkPQZL5QLpm/cHZy/6Pgt0r7QEyv4kdyzDXzcsmI3vF9
         eqqjNtgNuf8v3qeGjGl0uLtmJOOeXGyANs11Nv+OMgfhwNVnfN/2qvIbDDyajaQ+lS+t
         vMEA==
X-Gm-Message-State: AHQUAuYdT0+vAzmUZWyze8IZSzCZw7z+EwsSXguTyETzz9LEGmMzI/fP
        d2+zzqZbGFOQMuaqpW57ROw=
X-Google-Smtp-Source: APXvYqxPBMvwJOxGPJ2ezVujNqPpc/iom6/bkF4dQqhJATg6ewnFZIJtY02psxa/42QMHieOf6Sw5g==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr3767359wmg.136.1551461936366;
        Fri, 01 Mar 2019 09:38:56 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD7109200428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d710:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id y5sm48577069wrd.97.2019.03.01.09.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:38:55 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        liang.yang@amlogic.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] mtd: rawnand: meson: fix a potential memory leak in meson_nfc_read_buf
Date:   Fri,  1 Mar 2019 18:38:20 +0100
Message-Id: <20190301173820.30776-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190301173820.30776-1-martin.blumenstingl@googlemail.com>
References: <20190301173820.30776-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

meson_nfc_dma_buffer_setup() is called with the "info" buffer which is
allocated a few lines before using kzalloc(). If
meson_nfc_dma_buffer_setup() fails we need to free the allocated "info"
buffer instead of only freeing it upon success.

Fixes: 8fae856c53500a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index a1d8506b61c7..38db4fd61459 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -534,7 +534,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	ret = meson_nfc_dma_buffer_setup(nand, buf, len, info,
 					 PER_INFO_BYTE, DMA_FROM_DEVICE);
 	if (ret)
-		return ret;
+		goto out;
 
 	cmd = NFC_CMD_N2M | (len & GENMASK(5, 0));
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
@@ -542,6 +542,8 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	meson_nfc_drain_cmd(nfc);
 	meson_nfc_wait_cmd_finish(nfc, 1000);
 	meson_nfc_dma_buffer_release(nand, len, PER_INFO_BYTE, DMA_FROM_DEVICE);
+
+out:
 	kfree(info);
 
 	return ret;
-- 
2.21.0

