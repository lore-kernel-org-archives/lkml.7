Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC18C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76962173B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eGW1pVA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404241AbfIFLzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:55:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33398 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404182AbfIFLzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:55:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id t11so3057984plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kv55BZnn02toQdz6kJnclO1x7RUZAYx9ZqQlXw9MFbw=;
        b=eGW1pVA6FgmcZ6zJNDohUT0Z1B3VbFHelf5Zix26sr+4tvawKYD346Nf2mmNVVYDHi
         niCnBRlj6FhRv8FxDKWqU0prp1mgcm2mft6s20X5+xdMY0lFuAJCiFRWc+L6mf+S1aYT
         njlmsvX8bjcaQrG95D2KZN+hadP5ibbXz3isA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kv55BZnn02toQdz6kJnclO1x7RUZAYx9ZqQlXw9MFbw=;
        b=LDxBpMXGEo64BVlRsBRr+9ycRsdweM9P7zxh9wMH4Drb2wlHtnUvCsX/T7zEZVpDCU
         QWtiKQhuzFEY0wOJCW5gZdr78jtsBWPd9pnfrPOnlcFldZ40SC7eny8coGM1zXZj25zg
         faBvdk4GgcaVS6Nv0Zx0dpnOAP7S6d/Ciy0c5o6VIm0nl6XBtYMTm+9SPYK5BiEswqB/
         qBribhauqOY/K0zsCh4YRR8vuDigVAuL2Q1iUYKOXrUc46P7gStptqtU9dtNaQCPhGdX
         VNLGM7gQ//TtUrxh2vELnjXQbN0PuEH6BPGsHKFfE2EeuieRynQnBBpZkeXrdKhr7NXJ
         2lBA==
X-Gm-Message-State: APjAAAXewj8BAXoEKnGITYh2pIucvI2FdpFssbPMEqFwUxJuGwEcsRhT
        ajVJJSb5xa/MWUvqSN2yqQ58/w==
X-Google-Smtp-Source: APXvYqyC5FMNkRM36lVldrFj5nOcN4Wyw8rYmXXE/IM8t7emC1crUrfOtvatZ4cgQsZy5ZAz5EJASg==
X-Received: by 2002:a17:902:744a:: with SMTP id e10mr8865982plt.239.1567770949864;
        Fri, 06 Sep 2019 04:55:49 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id o22sm3667394pjq.21.2019.09.06.04.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 04:55:49 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFC PATCH v2 07/13] media: mtk-vcodec: add SCP firmware ops
Date:   Fri,  6 Sep 2019 20:55:07 +0900
Message-Id: <20190906115513.159705-8-acourbot@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906115513.159705-1-acourbot@chromium.org>
References: <20190906115513.159705-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

Add support for communicating with the SCP firmware, which will be used
by MT8183.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
[acourbot: refactor, cleanup and split]
Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  3 ++
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  3 ++
 .../media/platform/mtk-vcodec/mtk_vcodec_fw.c | 51 +++++++++++++++++++
 .../media/platform/mtk-vcodec/mtk_vcodec_fw.h |  2 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index f6494f584354..53a9e016d989 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -226,6 +226,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(pdev->dev.of_node, "mediatek,vpu",
 				  &rproc_phandle)) {
 		fw_type = VPU;
+	} else if (!of_property_read_u32(pdev->dev.of_node, "mediatek,scp",
+					 &rproc_phandle)) {
+		fw_type = SCP;
 	} else {
 		mtk_v4l2_err("Could not get vdec IPI device");
 		return -ENODEV;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 6a2ae909d36b..1f40dd780f30 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -234,6 +234,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(pdev->dev.of_node, "mediatek,vpu",
 				  &rproc_phandle)) {
 		fw_type = VPU;
+	} else if (!of_property_read_u32(pdev->dev.of_node, "mediatek,scp",
+					 &rproc_phandle)) {
+		fw_type = SCP;
 	} else {
 		mtk_v4l2_err("Could not get vdec IPI device");
 		return -ENODEV;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
index a4361f57aedc..de22e16ad3a3 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
@@ -63,6 +63,48 @@ static const struct mtk_vcodec_fw_ops mtk_vcodec_vpu_msg = {
 	.ipi_send = mtk_vcodec_vpu_ipi_send,
 };
 
+static int mtk_vcodec_scp_load_firmware(struct mtk_vcodec_fw *fw)
+{
+	return rproc_boot(fw->rproc);
+}
+
+static unsigned int mtk_vcodec_scp_get_vdec_capa(struct mtk_vcodec_fw *fw)
+{
+	return scp_get_vdec_hw_capa(fw->pdev);
+}
+
+static unsigned int mtk_vcodec_scp_get_venc_capa(struct mtk_vcodec_fw *fw)
+{
+	return scp_get_venc_hw_capa(fw->pdev);
+}
+
+static void *mtk_vcodec_vpu_scp_dm_addr(struct mtk_vcodec_fw *fw,
+					u32 dtcm_dmem_addr)
+{
+	return scp_mapping_dm_addr(fw->pdev, dtcm_dmem_addr);
+}
+
+static int mtk_vcodec_scp_set_ipi_register(struct mtk_vcodec_fw *fw, int id,
+		mtk_vcodec_ipi_handler handler, const char *name, void *priv)
+{
+	return scp_ipi_register(fw->pdev, id, handler, priv);
+}
+
+static int mtk_vcodec_scp_ipi_send(struct mtk_vcodec_fw *fw, int id, void *buf,
+		unsigned int len, unsigned int wait)
+{
+	return scp_ipi_send(fw->pdev, id, buf, len, wait);
+}
+
+static const struct mtk_vcodec_fw_ops mtk_vcodec_rproc_msg = {
+	.load_firmware = mtk_vcodec_scp_load_firmware,
+	.get_vdec_capa = mtk_vcodec_scp_get_vdec_capa,
+	.get_venc_capa = mtk_vcodec_scp_get_venc_capa,
+	.map_dm_addr = mtk_vcodec_vpu_scp_dm_addr,
+	.ipi_register = mtk_vcodec_scp_set_ipi_register,
+	.ipi_send = mtk_vcodec_scp_ipi_send,
+};
+
 static void mtk_vcodec_reset_handler(void *priv)
 {
 	struct mtk_vcodec_dev *dev = priv;
@@ -96,6 +138,15 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_select(struct mtk_vcodec_dev *dev,
 		vpu_wdt_reg_handler(fw_pdev, mtk_vcodec_reset_handler,
 				    dev, rst_id);
 		break;
+	case SCP:
+		ops = &mtk_vcodec_rproc_msg;
+		fw_pdev = scp_get_pdev(dev->plat_dev);
+		rproc = rproc_get_by_phandle(rproc_phandle);
+		if (!rproc) {
+			mtk_v4l2_err("could not get vdec rproc handle");
+			return ERR_PTR(-EPROBE_DEFER);
+		}
+		break;
 	default:
 		mtk_v4l2_err("invalid vcodec fw type");
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
index a6edb3858e6e..c000bda70362 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
@@ -4,6 +4,7 @@
 #define _MTK_VCODEC_FW_H_
 
 #include <linux/remoteproc.h>
+#include <linux/remoteproc/mtk_scp.h>
 
 #include "../mtk-vpu/mtk_vpu.h"
 
@@ -11,6 +12,7 @@ struct mtk_vcodec_dev;
 
 enum mtk_vcodec_fw_type {
 	VPU,
+	SCP,
 };
 
 struct mtk_vcodec_fw;
-- 
2.23.0.187.g17f5b7556c-goog

