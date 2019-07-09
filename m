Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7140DC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEFE216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ngXc4HMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGIH0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:26:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39130 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfGIH0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:26:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so8850879pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDm33LlUdrMo6gFn/4JDsHhLY06uoHh8tmnAA8K/bdA=;
        b=ngXc4HMpLWpfA6EwT1TZqkc+jqAf4XDue+cqaEa0XqSeQt/I7AW0kuNfNGYT0vgQfm
         24IG5HTuvrMNWSm2H0hz61DwrtyyHvbmpPTUrxUeCyEr1fcuDBq8cgVo87ARwII3JUzn
         KZ1PlpLypc3FScF+mDW/l0Zaxlir3D5QMDpCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDm33LlUdrMo6gFn/4JDsHhLY06uoHh8tmnAA8K/bdA=;
        b=pNoBZUXugVHZ5DYJw2jRHXiDf6R/a7x8iHEEl2R0iNGmCSAj+sVgd2EiF5MuYOt+Ks
         WP48ZQje8i+7wWnaGrCBqxcm5r6l1GmbpDAmSMIiQseJu1ATuz9q+fLTSIE79sRwM/je
         Q79ji8nxkYcI35h4nKG23/xFBa9/ZXTEUadaBg3/ukj5kvryhdQpqwNp6UGfcQPaOMKh
         zqQcUoiGQrBK46eHCyOYswTmPZoNW5TBTRY+ZwNe3o/DdfD4rY3KEzxvpN8LhMVck0pm
         dea7BMkybcFnRLcNJzmFjEBBZ0uSHAjtShsNGN/7xTHEgEvFQHD+yFNaol7++m6aFwCk
         0B4w==
X-Gm-Message-State: APjAAAWmCpWj3f4aPFKDlyVXKkM5EAPCGZqy/h+v6sCgTo71zgXdxZ01
        6Vjnk631NxbKQbpRQKhg/LybzA==
X-Google-Smtp-Source: APXvYqwv1Qh8/qoHBpIzltk0kzqL1evNERu+ncHmZdzStKvqq25k2eRbB1sQb0XtHlFAqsxqjCotgQ==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr28238657pgh.24.1562657181249;
        Tue, 09 Jul 2019 00:26:21 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 81sm12738135pfx.111.2019.07.09.00.26.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 00:26:20 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
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
Subject: [PATCH v13 3/5] remoteproc: mt8183: add reserved memory manager API
Date:   Tue,  9 Jul 2019 15:25:27 +0800
Message-Id: <20190709072547.217957-4-pihsun@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190709072547.217957-1-pihsun@chromium.org>
References: <20190709072547.217957-1-pihsun@chromium.org>
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
 drivers/remoteproc/mtk_scp.c          | 136 ++++++++++++++++++++++++++
 include/linux/platform_data/mtk_scp.h |  24 +++++
 2 files changed, 160 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 4713574d1aa2..dec271f69423 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -358,6 +358,138 @@ void *scp_mapping_dm_addr(struct platform_device *pdev, u32 mem_addr)
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
+		.size = 0x200000, /*2MB*/
+	},
+	{
+		.num = SCP_ISP_MEM2_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x800000, /*8MB*/
+	},
+	{
+		.num = SCP_DIP_MEM_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x900000, /*9MB*/
+	},
+	{
+		.num = SCP_MDP_MEM_ID,
+		.start_phys = 0x0,
+		.start_virt = 0x0,
+		.size = 0x600000, /*6MB*/
+	},
+	{
+		.num = SCP_FD_MEM_ID,
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
+	scp_mem_size = (phys_addr_t) (scp->dram_size - MAX_CODE_SIZE);
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
@@ -385,6 +517,10 @@ static int scp_map_memory_region(struct mtk_scp *scp)
 		return -EBUSY;
 	}
 
+#if SCP_RESERVED_MEM
+	scp_reserve_mem_init(scp);
+	scp_reserve_memory_ioremap(scp);
+#endif
 	return 0;
 }
 
diff --git a/include/linux/platform_data/mtk_scp.h b/include/linux/platform_data/mtk_scp.h
index b81ac5c7d320..96e56fdd0917 100644
--- a/include/linux/platform_data/mtk_scp.h
+++ b/include/linux/platform_data/mtk_scp.h
@@ -138,4 +138,28 @@ unsigned int scp_get_venc_hw_capa(struct platform_device *pdev);
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
2.22.0.410.gd8fdbe21b5-goog

