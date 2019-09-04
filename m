Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42182C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1312A23402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n5cwh721"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfIDGRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:17:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46875 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfIDGRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:17:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so10611688pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zH6rxHe/RfCiNo3P8Z82MRVb/Q/brp4tjzWfoelyxTg=;
        b=n5cwh721WmaLCF3EeyuQvzlbKk2Iafmyfa6zFyaRBVl9QQJg5ddwQiIG/EcC8LTDgA
         SUFoEtCoszIjC0rtsT5fQIt+2A7mjUuLd0Y4kpOkv6XqkshKQBtCwyxkZ5GrCHEVKRNI
         C7Ge228S6TnJWZ9PQ/Xf2Php3gumhwDIfKcOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH6rxHe/RfCiNo3P8Z82MRVb/Q/brp4tjzWfoelyxTg=;
        b=TxbEad9uBZ+kjqZ+54zm2QAZ1lmGvGdDOy+iuiGhaTaD9yJpeLLJ2eBw3SqyJZQLhB
         rdloRePwm7D9tBlPnuhXn02vOR5ykuediTOSJhji83Bnj3t3uDNpcPUPXKOYI0RM28z6
         zOA73MVlx7jApZTAVrfHLxmExE4GUi6G3EyefYlrbX1Nanp7uJgNueG5nMhyCn1Ry6UO
         3p9x8/oSJhXGOVLOpcPFEn8TLxUlYHpqPTO9GQuEdyhPTKvnvW6786NImoDOEG9sfhTu
         p0fHY4auT959tnQXTx0tCQejvNimte4MJmd8SfNOBRsXJxMZmU7RKEB0E/C21mV+UfxI
         tlmg==
X-Gm-Message-State: APjAAAVpuk8irirzPDi5vptaEvrfOFBamBRl9f04+LsrQlcdwRaKTZ0w
        CJ3vqdqV++TO08k4UGXmKApCLQ==
X-Google-Smtp-Source: APXvYqy4Jq7EJKf9+aoMML3pJWOrIMJyJCzetbHtudu7VZ2MSBaQ7nudz3TCLnKuIQGxhUBlRyaNVw==
X-Received: by 2002:a63:7887:: with SMTP id t129mr33938120pgc.309.1567577828759;
        Tue, 03 Sep 2019 23:17:08 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id r2sm27248750pfq.60.2019.09.03.23.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 23:17:08 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v17 3/5] remoteproc: mt8183: add reserved memory manager API
Date:   Wed,  4 Sep 2019 14:16:41 +0800
Message-Id: <20190904061649.69099-4-pihsun@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190904061649.69099-1-pihsun@chromium.org>
References: <20190904061649.69099-1-pihsun@chromium.org>
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
Changes from v16, v15:
 - No change.

Changes from v14:
 - Fix a typo in variable name in DEBUG section.

Changes from v13:
 - Add one more reserved region.
 - Rename scp_get_reserve_* to scp_get_reserved_*.
 - Minor fixes addressing comment.

Changes from v12:
 - Reformat a line to fit 80 character width.

Changes from v11:
 - No change.

Changes from v10:
 - Fix some type mismatch warnings when printing debug messages.

Changes from v9:
 - No change.

Changes from v8:
 - Add more reserved regions for camera ISP.

Changes from v7, v6, v5:
 - No change.

Changes from v4:
 - New patch.
---
 drivers/remoteproc/mtk_scp.c       | 145 +++++++++++++++++++++++++++++
 include/linux/remoteproc/mtk_scp.h |  25 +++++
 2 files changed, 170 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 99e226f38ca4..ce4acffbb115 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -374,11 +374,142 @@ void *scp_mapping_dm_addr(struct platform_device *pdev, u32 mem_addr)
 }
 EXPORT_SYMBOL_GPL(scp_mapping_dm_addr);
 
+#if SCP_RESERVED_MEM
+static phys_addr_t scp_mem_base_phys;
+static phys_addr_t scp_mem_base_virt;
+static size_t scp_mem_size;
+
+static struct scp_reserve_mblock scp_reserve_mblock[] = {
+	{
+		.num = SCP_ISP_MEM_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x200000, /*2MB*/
+	},
+	{
+		.num = SCP_ISP_MEM2_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x800000, /*8MB*/
+	},
+	{
+		.num = SCP_MDP_MEM_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x600000, /*6MB*/
+	},
+	{
+		.num = SCP_DIP_MEM_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x900000, /*9MB*/
+	},
+	{
+		.num = SCP_FD_MEM_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x100000, /*1MB*/
+	},
+	{
+		.num = SCP_FD_MEM2_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x100000, /*1MB*/
+	},
+};
+
+static int scp_reserve_mem_init(struct mtk_scp *scp)
+{
+	enum scp_reserve_mem_id_t id;
+	phys_addr_t accumlate_memory_size = 0;
+
+	scp_mem_base_phys = (phys_addr_t) (scp->phys_addr + MAX_CODE_SIZE);
+	scp_mem_size = scp->dram_size - MAX_CODE_SIZE;
+
+	dev_info(scp->dev,
+		 "phys:0x%llx - 0x%llx (0x%llx)\n",
+		 (unsigned long long)scp_mem_base_phys,
+		 (unsigned long long)(scp_mem_base_phys + scp_mem_size),
+		 (unsigned long long)scp_mem_size);
+	accumlate_memory_size = 0;
+	for (id = 0; id < SCP_NUMS_MEM_ID; id++) {
+		scp_reserve_mblock[id].start_phys =
+			scp_mem_base_phys + accumlate_memory_size;
+		accumlate_memory_size += scp_reserve_mblock[id].size;
+		dev_info(
+			scp->dev,
+			"[reserve_mem:%d]: phys:0x%llx - 0x%llx (0x%llx)\n", id,
+			(unsigned long long)scp_reserve_mblock[id].start_phys,
+			(unsigned long long)(scp_reserve_mblock[id].start_phys +
+					     scp_reserve_mblock[id].size),
+			(unsigned long long)scp_reserve_mblock[id].size);
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
+		(unsigned long long)scp_mem_base_virt,
+		(unsigned long long)(scp_mem_base_virt + scp_mem_size),
+		(unsigned long long)scp_mem_size);
+	for (id = 0; id < SCP_NUMS_MEM_ID; id++) {
+		scp_reserve_mblock[id].start_virt =
+			scp_mem_base_virt + accumlate_memory_size;
+		accumlate_memory_size += scp_reserve_mblock[id].size;
+	}
+	/* the reserved memory should be larger then expected memory
+	 * or scp_reserve_mblock does not match dts
+	 */
+	WARN_ON(accumlate_memory_size > scp_mem_size);
+	return 0;
+}
+phys_addr_t scp_get_reserved_mem_phys(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	}
+	return scp_reserve_mblock[id].start_phys;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserved_mem_phys);
+
+phys_addr_t scp_get_reserved_mem_virt(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	}
+	return scp_reserve_mblock[id].start_virt;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserved_mem_virt);
+
+size_t scp_get_reserved_mem_size(enum scp_reserve_mem_id_t id)
+{
+	if (id >= SCP_NUMS_MEM_ID) {
+		pr_err("[SCP] no reserve memory for %d", id);
+		return 0;
+	}
+	return scp_reserve_mblock[id].size;
+}
+EXPORT_SYMBOL_GPL(scp_get_reserved_mem_size);
+#endif
+
 static int scp_map_memory_region(struct mtk_scp *scp)
 {
 	struct device_node *node;
 	struct resource r;
 	int ret;
+#ifdef DEBUG
+	enum scp_reserve_mem_id_t id;
+#endif
 
 	node = of_parse_phandle(scp->dev->of_node, "memory-region", 0);
 	if (!node) {
@@ -401,6 +532,20 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 		return -EBUSY;
 	}
 
+#if SCP_RESERVED_MEM
+	scp_reserve_mem_init(scp);
+	scp_reserve_memory_ioremap(scp);
+#ifdef DEBUG
+	for (id = 0; id < SCP_NUMS_MEM_ID; id++) {
+		dev_info(scp->dev,
+			 "[mem_reserve-%d] phys:0x%llx,virt:0x%llx,size:0x%llx\n",
+			 id,
+			 scp_get_reserved_mem_phys(id),
+			 scp_get_reserved_mem_virt(id),
+			 scp_get_reserved_mem_size(id));
+	}
+#endif
+#endif
 	return 0;
 }
 
diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
index b80d8e3f7959..707556f6b899 100644
--- a/include/linux/remoteproc/mtk_scp.h
+++ b/include/linux/remoteproc/mtk_scp.h
@@ -138,4 +138,29 @@ unsigned int scp_get_venc_hw_capa(struct platform_device *pdev);
 void *scp_mapping_dm_addr(struct platform_device *pdev,
 			  u32 mem_addr);
 
+#define SCP_RESERVED_MEM	(1)
+#if SCP_RESERVED_MEM
+/* scp reserve memory ID definition*/
+enum scp_reserve_mem_id_t {
+	SCP_ISP_MEM_ID,
+	SCP_ISP_MEM2_ID,
+	SCP_MDP_MEM_ID,
+	SCP_DIP_MEM_ID,
+	SCP_FD_MEM_ID,
+	SCP_FD_MEM2_ID,
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
+extern phys_addr_t scp_get_reserved_mem_phys(enum scp_reserve_mem_id_t id);
+extern phys_addr_t scp_get_reserved_mem_virt(enum scp_reserve_mem_id_t id);
+extern size_t scp_get_reserved_mem_size(enum scp_reserve_mem_id_t id);
+#endif
+
 #endif /* _MTK_SCP_H */
-- 
2.23.0.187.g17f5b7556c-goog

