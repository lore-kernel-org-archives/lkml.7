Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F413C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EBF20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DHo8MTk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfC0FPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:15:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45317 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfC0FPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:15:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so8296047pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 22:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3TJ7NxXlWd2gqdvA7ApFmupxYWdtnCpzncSRssaca8=;
        b=DHo8MTk7n4TSGqGeqDv51Q69GSLUHk7zfChkGMPBLSaHP1ofsQLu+fmVmqt6JKlbmG
         bvPFJtyDIZmXTwDynfhNcRG5F+jMTtzCdYBx7EUMRnuuSNLONXBnehua9+P6pCx1JpeB
         qS7oj+rrHvcg8NRtcW5SkhQ2Tifgw6fEZ+Xzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3TJ7NxXlWd2gqdvA7ApFmupxYWdtnCpzncSRssaca8=;
        b=dZd655u2eBLaU1HQaPumnXJCUP++EXPBdftOH9WZp5sFqm3y2dugaB0NslFK//8mDq
         mXCOo0S98PdcZoesQydN+Me4g3BohD5xs4VR/dw+/GVowhbnc+RLeNvIrVlE0HT9FiNR
         avtupc+IEm6WmaobOFqdnndES7jnu/YZ9G3bKl2fDX+yYU29g+GO7fuMh44qIHHHRKdG
         NcxqfvIAzz5eQahCNyu6GFwfEjtJ+LAyV6OZhLPfX2X7cYGBtCF9vdfgJQGKRoJTC6tA
         hBvMj2Jc/xikhzdv37ZNrAtCBH9G7DmTaPFeKGXDjJbp9ScXwDj+VCFRe9mvP6A6q6eq
         n3WA==
X-Gm-Message-State: APjAAAWETfKiEfBL3uKsDh4RnCWedhtxKWKOIiCjUVR1iXNdgWLFwBiU
        oqLOpAHLkjJ1+DPQmRP7Gci/5w==
X-Google-Smtp-Source: APXvYqxyh7DssKZYjrLD3POUO7s81hg8+vK45QCp0vDwdDUqCEl8I/Jv71BRx/L4G3CFOztgM8rgEw==
X-Received: by 2002:a65:448b:: with SMTP id l11mr8955790pgq.185.1553663717002;
        Tue, 26 Mar 2019 22:15:17 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id k72sm58622609pfb.122.2019.03.26.22.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:15:16 -0700 (PDT)
From:   Peter Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 3/7] remoteproc: mt8183: add reserved memory manager API
Date:   Wed, 27 Mar 2019 13:14:45 +0800
Message-Id: <20190327051450.16222-4-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190327051450.16222-1-pihsun@chromium.org>
References: <20190327051450.16222-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erin Lo <erin.lo@mediatek.com>

Add memory table mapping API for other driver to lookup
reserved physical and virtual memory

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v6:
 - No change.

Changes from v5:
 - No change.

Changes from v4:
 - New patch.
---
 drivers/remoteproc/mtk_scp.c          | 111 ++++++++++++++++++++++++++
 include/linux/platform_data/mtk_scp.h |  20 +++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index a84d69ae6c53..ca45cb729bd3 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -331,6 +331,113 @@ void *scp_mapping_dm_addr(struct platform_device *pdev, u32 mem_addr)
 }
 EXPORT_SYMBOL_GPL(scp_mapping_dm_addr);
 
+#if SCP_RESERVED_MEM
+phys_addr_t scp_mem_base_phys;
+phys_addr_t scp_mem_base_virt;
+phys_addr_t scp_mem_size;
+
+static struct scp_reserve_mblock scp_reserve_mblock[] = {
+	{
+		.num = SCP_ISP_MEM_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x1400000,  /*20MB*/
+	},
+};
+
+static int scp_reserve_mem_init(struct mtk_scp *scp)
+{
+	enum scp_reserve_mem_id_t id;
+	phys_addr_t accumlate_memory_size = 0;
+
+	scp_mem_base_phys = (phys_addr_t) (scp->phys_addr + MAX_CODE_SIZE);
+	scp_mem_size = (phys_addr_t) (scp->dram_size - MAX_CODE_SIZE);
+
+	dev_info(scp->dev,
+		 "phys:0x%llx - 0x%llx (0x%llx)\n",
+		 scp_mem_base_phys,
+		 scp_mem_base_phys + scp_mem_size,
+		 scp_mem_size);
+	accumlate_memory_size = 0;
+	for (id = 0; id < SCP_NUMS_MEM_ID; id++) {
+		scp_reserve_mblock[id].start_phys =
+			scp_mem_base_phys + accumlate_memory_size;
+		accumlate_memory_size += scp_reserve_mblock[id].size;
+		dev_info(scp->dev,
+			 "[reserve_mem:%d]: phys:0x%llx - 0x%llx (0x%llx)\n",
+			 id, scp_reserve_mblock[id].start_phys,
+			 scp_reserve_mblock[id].start_phys +
+				 scp_reserve_mblock[id].size,
+			 scp_reserve_mblock[id].size);
+	}
+	return 0;
+}
+
+static int scp_reserve_memory_ioremap(struct mtk_scp *scp)
+{
+	enum scp_reserve_mem_id_t id;
+	phys_addr_t accumlate_memory_size = 0;
+
+	scp_mem_base_virt = (phys_addr_t)(size_t)ioremap_wc(scp_mem_base_phys,
+							    scp_mem_size);
+
+	dev_info(scp->dev,
+		 "virt:0x%llx - 0x%llx (0x%llx)\n",
+		(phys_addr_t)scp_mem_base_virt,
+		(phys_addr_t)scp_mem_base_virt + (phys_addr_t)scp_mem_size,
+		scp_mem_size);
+	for (id = 0; id < SCP_NUMS_MEM_ID; id++) {
+		scp_reserve_mblock[id].start_virt =
+			scp_mem_base_virt + accumlate_memory_size;
+		accumlate_memory_size += scp_reserve_mblock[id].size;
+	}
+	/* the reserved memory should be larger then expected memory
+	 * or scp_reserve_mblock does not match dts
+	 */
+	WARN_ON(accumlate_memory_size > scp_mem_size);
+#ifdef DEBUG
+	for (id = 0; id < NUMS_MEM_ID; id++) {
+		dev_info(scp->dev,
+			 "[mem_reserve-%d] phys:0x%llx,virt:0x%llx,size:0x%llx\n",
+			 id,
+			 scp_get_reserve_mem_phys(id),
+			 scp_get_reserve_mem_virt(id),
+			 scp_get_reserve_mem_size(id));
+	}
+#endif
+	return 0;
+}
+phys_addr_t scp_get_reserve_mem_phys(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	} else
+		return scp_reserve_mblock[id].start_phys;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserve_mem_phys);
+
+phys_addr_t scp_get_reserve_mem_virt(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	} else
+		return scp_reserve_mblock[id].start_virt;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserve_mem_virt);
+
+phys_addr_t scp_get_reserve_mem_size(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	} else
+		return scp_reserve_mblock[id].size;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserve_mem_size);
+#endif
+
 static int scp_map_memory_region(struct mtk_scp *scp)
 {
 	struct device_node *node;
@@ -358,6 +465,10 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 		return -EBUSY;
 	}
 
+#if SCP_RESERVED_MEM
+	scp_reserve_mem_init(scp);
+	scp_reserve_memory_ioremap(scp);
+#endif
 	return 0;
 }
 
diff --git a/include/linux/platform_data/mtk_scp.h b/include/linux/platform_data/mtk_scp.h
index dfda05051235..7625eede2e58 100644
--- a/include/linux/platform_data/mtk_scp.h
+++ b/include/linux/platform_data/mtk_scp.h
@@ -132,4 +132,24 @@ unsigned int scp_get_venc_hw_capa(struct platform_device *pdev);
 void *scp_mapping_dm_addr(struct platform_device *pdev,
 			  u32 mem_addr);
 
+#define SCP_RESERVED_MEM	(1)
+#if SCP_RESERVED_MEM
+/* scp reserve memory ID definition*/
+enum scp_reserve_mem_id_t {
+	SCP_ISP_MEM_ID,
+	SCP_NUMS_MEM_ID,
+};
+
+struct scp_reserve_mblock {
+	enum scp_reserve_mem_id_t num;
+	u64 start_phys;
+	u64 start_virt;
+	u64 size;
+};
+
+extern phys_addr_t scp_get_reserve_mem_phys(enum scp_reserve_mem_id_t id);
+extern phys_addr_t scp_get_reserve_mem_virt(enum scp_reserve_mem_id_t id);
+extern phys_addr_t scp_get_reserve_mem_size(enum scp_reserve_mem_id_t id);
+#endif
+
 #endif /* _MTK_SCP_H */
-- 
2.21.0.392.gf8f6787159e-goog

