Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12FF213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QtGreQaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfCRUri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:47:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36021 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfCRUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:47:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so14125391wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0873ZLskCB6Lvg+syhxqGIBY5YOohbYE2wenaTl30+w=;
        b=QtGreQaPHla07Yp+mGiHlv3HE2rnqgE7Ji7JfX3ujMrf6GxlwfHLXUY1LhjBUhYAvW
         PjpAM9wdto38jH6IF6kpeqeLgFhcL4WdLR/hHzO8cAFqrC3oBAhyx1tVsZ06gYqIvxv3
         EuvsJbAFtVbLoKKRsgwiJpTDsM7R4Ce5x52PrNmy2BmuIQvBy6piur162MyYCaR8rP9a
         NWkZ+/POi3kzOO/WlZpco6FqcwOJqnlgtA+BlW6YpJuJ11nV8z7wMNDARxG+EfL4s/K/
         e+HStdIuNJYYL2tn0UXh8XYp0YQtemd6tkB291/MU2Ia3QzbKutQe+TH48+nc4CB2gXh
         lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0873ZLskCB6Lvg+syhxqGIBY5YOohbYE2wenaTl30+w=;
        b=TYnee8LzXViWKISzW4jMz2mHoIR7VHWUhk6azy6/ltnXqRQAZIHJ8zlnFsWio7NcfH
         zN0IPYs2+Xc4lLYZRQh9H+N6O+tgXbcBA9iVrwgp3eIZDRfR00qku2k3++l/7v2oChtH
         UlMtQaEf1GuHRmst2ywXKHCZoUJz7m9bPonyY0HTf4pY05O4tXoWizIYkZ8fOhfUFi8j
         XtSiYE1UUS45Uezsc8Q+8uWbgqNnAsCtPkHyH/cetLf+cwoPyU/teM1uDnoowdznfc9P
         BCE/KhFDp8Cduj27maxAUvifRQrgDuZdc5u3OXu2pS63pAFmYWzF9Cz48kkGgvl5mnlm
         E4Tw==
X-Gm-Message-State: APjAAAV9z8QYXO2Z+zZK3vtWxQUcER86HKGSiwVxn/RFAynnntTSWf+H
        NUzufntc7lB2SDW51FrqTRo=
X-Google-Smtp-Source: APXvYqyg9XphgCbZpbnjd28jfUaYDrWSVUE7pZocWpFznrc+9Gl/E/JaIExeGJ7Ymx5XIxgcE0bOGQ==
X-Received: by 2002:adf:84c6:: with SMTP id 64mr14357276wrg.246.1552942050247;
        Mon, 18 Mar 2019 13:47:30 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900918378ACFECF051C.dip0.t-ipconnect.de. [2003:dc:d739:9900:9183:78ac:fecf:51c])
        by smtp.googlemail.com with ESMTPSA id y12sm224849wma.44.2019.03.18.13.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 13:47:29 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        bbrezillon@kernel.org, miquel.raynal@bootlin.com
Cc:     liang.yang@amlogic.com, richard@nod.at, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] mtd: rawnand: meson: fix a potential memory leak in meson_nfc_read_buf
Date:   Mon, 18 Mar 2019 21:47:22 +0100
Message-Id: <20190318204722.9901-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318204722.9901-1-martin.blumenstingl@googlemail.com>
References: <20190318204722.9901-1-martin.blumenstingl@googlemail.com>
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
Acked-by: Liang Yang <liang.yang@amlogic.com>
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

