Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76CC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8403120869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmfQ5e6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfDMKdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46882 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDMKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so15084497wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRH71IOWRNq7SWypQqe9yqi6qKvNmCE6/mB75LpaASM=;
        b=bmfQ5e6Lnuyi01h99FIsy4XsnoiUnQ2xn4eGnR/cBDdbWxmvRF8vWqSfLKXadiz1gc
         auMZrfXVgx6FkCGbZe7u8ZFhDN+OYkIAG0qjpocVT7ZbndgRWD+7COAUr/QoArOiXsVG
         z65+rCTAZfuLURTrPn6y1CkXGZ3q5ntkXR6Isndo8wmxjrRSnraEfMq8ZF5ffOtjuYD0
         0/QOgbNaRCf23N1U1zBMJzedIxpOuuvjRqv6mBOk5esNV91KEOzfFr4hsVTS/3aP4u1Y
         IfTGbOIcNoqiiegwAethACl7j0wgT98OTxhAqX7czNOrzsOMdWg/9pNWGzndxZGtrR0p
         o/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRH71IOWRNq7SWypQqe9yqi6qKvNmCE6/mB75LpaASM=;
        b=bH2jetXMaY7+h6fuH7U7TEI1RmM+gcPNRtJRCiB5qmXNQtf3+KxHTtVIXPduMR/b23
         qDzSxXPPBl/r0LKChQParNBJ+0/b/pIEhCgNzSQdg29ms2uZIev7nC5a0TTO9SvDmPKC
         DhqgGFzLFEP1fbxA6h3ji5qkyvqo9Ll4Ql6W+C2dG3B3cxkkY04krw/ioS+Dz6uea4fh
         pKemJnEHiSpaEHhC7sjJjDiBUX9iuPen5dEMG0aM+qMZAZlq90vz+pOJCP0sD/rd/sjg
         ge85MsDWLPT+flv9K/4cE9LhqburV4xnlMh6kBOFoFGuCZzhY6jKVOVddFVqeGMJNN6p
         GXHA==
X-Gm-Message-State: APjAAAXwXzfpK6GY0UIPuaf2YNLXbymTS7U2rtb4eZDq3newyZeXqAJS
        bPWVlMrqvmMel4GweSSEt6kZrQ==
X-Google-Smtp-Source: APXvYqznSeOoIVqU31qgqq4c1FDp/zi10fIl+0gf2jgsgb8bz89ZZ+dlZ8GMPs7CP76Pm92TxGlA3Q==
X-Received: by 2002:a5d:428f:: with SMTP id k15mr41593763wrq.113.1555151593301;
        Sat, 13 Apr 2019 03:33:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 06/20] nvmem: sunxi_sid: Dynamically allocate nvmem_config structure
Date:   Sat, 13 Apr 2019 11:32:51 +0100
Message-Id: <20190413103305.9576-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The sunxi_sid driver currently uses a statically allocated nvmem_config
structure that is updated at probe time. This is sub-optimal as it
limits the driver to one instance, and also takes up space even if the
device is not present.

Modify the driver to allocate the nvmem_config structure at probe time,
plugging in the desired parameters along the way.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 15fbfab62595..75c1f48cb3d0 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -35,13 +35,6 @@
 #define SUN8I_SID_OP_LOCK	(0xAC << 8)
 #define SUN8I_SID_READ		BIT(1)
 
-static struct nvmem_config econfig = {
-	.name = "sunxi-sid",
-	.read_only = true,
-	.stride = 4,
-	.word_size = 1,
-};
-
 struct sunxi_sid_cfg {
 	u32	value_offset;
 	u32	size;
@@ -150,6 +143,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct nvmem_config *nvmem_cfg;
 	struct nvmem_device *nvmem;
 	struct sunxi_sid *sid;
 	int size;
@@ -172,14 +166,23 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	size = cfg->size;
 
-	econfig.size = size;
-	econfig.dev = dev;
+	nvmem_cfg = devm_kzalloc(dev, sizeof(*nvmem_cfg), GFP_KERNEL);
+	if (!nvmem_cfg)
+		return -ENOMEM;
+
+	nvmem_cfg->dev = dev;
+	nvmem_cfg->name = "sunxi-sid";
+	nvmem_cfg->read_only = true;
+	nvmem_cfg->size = cfg->size;
+	nvmem_cfg->word_size = 1;
+	nvmem_cfg->stride = 4;
+	nvmem_cfg->priv = sid;
 	if (cfg->need_register_readout)
-		econfig.reg_read = sun8i_sid_read_by_reg;
+		nvmem_cfg->reg_read = sun8i_sid_read_by_reg;
 	else
-		econfig.reg_read = sunxi_sid_read;
-	econfig.priv = sid;
-	nvmem = devm_nvmem_register(dev, &econfig);
+		nvmem_cfg->reg_read = sunxi_sid_read;
+
+	nvmem = devm_nvmem_register(dev, nvmem_cfg);
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
@@ -187,8 +190,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	if (!randomness)
 		return -ENOMEM;
 
-	econfig.reg_read(sid, 0, randomness, size);
-
+	nvmem_cfg->reg_read(sid, 0, randomness, size);
 	add_device_randomness(randomness, size);
 	kfree(randomness);
 
-- 
2.21.0

