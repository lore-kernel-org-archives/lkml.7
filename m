Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA06CA9EBE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43D6214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfJ1I2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:28:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14001 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731531AbfJ1I2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:28:35 -0400
X-UUID: b2a832a6753443ada0c8034c0fa9afb8-20191028
X-UUID: b2a832a6753443ada0c8034c0fa9afb8-20191028
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 264541232; Mon, 28 Oct 2019 16:28:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 16:28:28 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 16:28:24 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <cui.zhang@mediatek.com>,
        Guangming Cao <guangming.cao@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH 01/13] dt-bindings: mediatek: Add bindings for MT6779
Date:   Mon, 28 Oct 2019 16:28:08 +0800
Message-ID: <20191028082820.20221-2-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191028082820.20221-1-chao.hao@mediatek.com>
References: <20191028082820.20221-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds description for MT6779 IOMMU.

MT6779 has two iommus, they are MM_IOMMU and APU_IOMMU which
use ARM Short-Descriptor translation format.

The MT6779 IOMMU hardware diagram is as below, it is only a brief
diagram about iommu, it don't focus on the part of smi_larb, so
I don't describe the smi_larb detailedly.

			     EMI
			      |
	   --------------------------------------
	   |					|
        MM_IOMMU                            APU_IOMMU
	   |					|
       SMI_COMMOM-----------		     APU_BUS
          |		   |			|
    SMI_LARB(0~11)  SMI_LARB12(FAKE)	    SMI_LARB13(FAKE)
	  |		   |			|
	  |		   |		   --------------
	  |		   |		   |	 |	|
   Multimedia engine	  CCU		  VPU   MDLA   EMDA

All the connections are hardware fixed, software can not adjust it.

From the diagram above, MM_IOMMU provides mapping for multimedia engine,
but CCU is connected with smi_common directly, we can take them as larb12.
APU_IOMMU provides mapping for APU engine, we can take them larb13.
Larb12 and Larb13 are fake larbs.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 .../bindings/iommu/mediatek,iommu.txt         |   2 +
 include/dt-bindings/memory/mt6779-larb-port.h | 217 ++++++++++++++++++
 2 files changed, 219 insertions(+)
 create mode 100644 include/dt-bindings/memory/mt6779-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index ce59a505f5a4..c1ccd8582eb2 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -58,6 +58,7 @@ Required properties:
 - compatible : must be one of the following string:
 	"mediatek,mt2701-m4u" for mt2701 which uses generation one m4u HW.
 	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
+	"mediatek,mt6779-m4u" for mt6779 which uses generation two m4u HW.
 	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
 						     generation one m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
@@ -78,6 +79,7 @@ Required properties:
 	Specifies the mtk_m4u_id as defined in
 	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
 	dt-binding/memory/mt2712-larb-port.h for mt2712,
+	dt-binding/memory/mt6779-larb-port.h for mt6779,
 	dt-binding/memory/mt8173-larb-port.h for mt8173, and
 	dt-binding/memory/mt8183-larb-port.h for mt8183.
 
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
new file mode 100644
index 000000000000..8b7f2d2446ea
--- /dev/null
+++ b/include/dt-bindings/memory/mt6779-larb-port.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Chao Hao <chao.hao@mediatek.com>
+ */
+
+#ifndef _DTS_IOMMU_PORT_MT6779_H_
+#define _DTS_IOMMU_PORT_MT6779_H_
+
+#define MTK_M4U_ID(larb, port)		 (((larb) << 5) | (port))
+
+#define M4U_LARB0_ID			 0
+#define M4U_LARB1_ID			 1
+#define M4U_LARB2_ID			 2
+#define M4U_LARB3_ID			 3
+#define M4U_LARB4_ID			 4
+#define M4U_LARB5_ID			 5
+#define M4U_LARB6_ID			 6
+#define M4U_LARB7_ID			 7
+#define M4U_LARB8_ID			 8
+#define M4U_LARB9_ID			 9
+#define M4U_LARB10_ID			 10
+#define M4U_LARB11_ID			 11
+#define M4U_LARB12_ID			 12
+#define M4U_LARB13_ID			 13
+
+/* larb0 */
+#define M4U_PORT_DISP_POSTMASK0		 MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_OVL0_HDR		 MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_OVL1_HDR		 MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_OVL0		 MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_OVL1		 MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_DISP_PVRIC0		 MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_DISP_RDMA0		 MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_DISP_WDMA0		 MTK_M4U_ID(M4U_LARB0_ID, 7)
+#define M4U_PORT_DISP_FAKE0		 MTK_M4U_ID(M4U_LARB0_ID, 8)
+
+/* larb1 */
+#define M4U_PORT_DISP_OVL0_2L_HDR	 MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_DISP_OVL1_2L_HDR	 MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_DISP_OVL0_2L		 MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_DISP_OVL1_2L		 MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_DISP_RDMA1		 MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_MDP_PVRIC0		 MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_MDP_PVRIC1		 MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_MDP_RDMA0		 MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_MDP_RDMA1		 MTK_M4U_ID(M4U_LARB1_ID, 8)
+#define M4U_PORT_MDP_WROT0_R		 MTK_M4U_ID(M4U_LARB1_ID, 9)
+#define M4U_PORT_MDP_WROT0_W		 MTK_M4U_ID(M4U_LARB1_ID, 10)
+#define M4U_PORT_MDP_WROT1_R		 MTK_M4U_ID(M4U_LARB1_ID, 11)
+#define M4U_PORT_MDP_WROT1_W		 MTK_M4U_ID(M4U_LARB1_ID, 12)
+#define M4U_PORT_DISP_FAKE1		 MTK_M4U_ID(M4U_LARB1_ID, 13)
+
+/* larb2-VDEC */
+#define M4U_PORT_HW_VDEC_MC_EXT          MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_HW_VDEC_UFO_EXT         MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_HW_VDEC_PP_EXT          MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT     MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT     MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT      MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_HW_VDEC_TILE_EXT        MTK_M4U_ID(M4U_LARB2_ID, 6)
+#define M4U_PORT_HW_VDEC_VLD_EXT         MTK_M4U_ID(M4U_LARB2_ID, 7)
+#define M4U_PORT_HW_VDEC_VLD2_EXT        MTK_M4U_ID(M4U_LARB2_ID, 8)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT      MTK_M4U_ID(M4U_LARB2_ID, 9)
+#define M4U_PORT_HW_VDEC_UFO_ENC_EXT     MTK_M4U_ID(M4U_LARB2_ID, 10)
+#define M4U_PORT_HW_VDEC_RG_CTRL_DMA_EXT MTK_M4U_ID(M4U_LARB2_ID, 11)
+
+/*larb3-VENC*/
+#define M4U_PORT_VENC_RCPU		 MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_VENC_REC		 MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_VENC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		 MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		 MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_VENC_NBM_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_VENC_NBM_RDMA_LITE	 MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_JPGENC_Y_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_JPGENC_C_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 8)
+#define M4U_PORT_JPGENC_Q_TABLE		 MTK_M4U_ID(M4U_LARB3_ID, 9)
+#define M4U_PORT_JPGENC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 10)
+#define M4U_PORT_JPGDEC_WDMA		 MTK_M4U_ID(M4U_LARB3_ID, 11)
+#define M4U_PORT_JPGDEC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 12)
+#define M4U_PORT_VENC_NBM_WDMA		 MTK_M4U_ID(M4U_LARB3_ID, 13)
+#define M4U_PORT_VENC_NBM_WDMA_LITE	 MTK_M4U_ID(M4U_LARB3_ID, 14)
+#define M4U_PORT_VENC_CUR_LUMA		 MTK_M4U_ID(M4U_LARB3_ID, 15)
+#define M4U_PORT_VENC_CUR_CHROMA	 MTK_M4U_ID(M4U_LARB3_ID, 16)
+#define M4U_PORT_VENC_REF_LUMA		 MTK_M4U_ID(M4U_LARB3_ID, 17)
+#define M4U_PORT_VENC_REF_CHROMA	 MTK_M4U_ID(M4U_LARB3_ID, 18)
+
+/*larb4-dummy*/
+
+/*larb5-IMG*/
+#define M4U_PORT_IMGI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 0)
+#define M4U_PORT_IMGBI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 1)
+#define M4U_PORT_DMGI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 2)
+#define M4U_PORT_DEPI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 3)
+#define M4U_PORT_LCEI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 4)
+#define M4U_PORT_SMTI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 5)
+#define M4U_PORT_SMTO_D2		 MTK_M4U_ID(M4U_LARB5_ID, 6)
+#define M4U_PORT_SMTO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 7)
+#define M4U_PORT_CRZO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 8)
+#define M4U_PORT_IMG3O_D1		 MTK_M4U_ID(M4U_LARB5_ID, 9)
+#define M4U_PORT_VIPI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 10)
+#define M4U_PORT_WPE_RDMA1		 MTK_M4U_ID(M4U_LARB5_ID, 11)
+#define M4U_PORT_WPE_RDMA0		 MTK_M4U_ID(M4U_LARB5_ID, 12)
+#define M4U_PORT_WPE_WDMA		 MTK_M4U_ID(M4U_LARB5_ID, 13)
+#define M4U_PORT_TIMGO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 14)
+#define M4U_PORT_MFB_RDMA0		 MTK_M4U_ID(M4U_LARB5_ID, 15)
+#define M4U_PORT_MFB_RDMA1		 MTK_M4U_ID(M4U_LARB5_ID, 16)
+#define M4U_PORT_MFB_RDMA2		 MTK_M4U_ID(M4U_LARB5_ID, 17)
+#define M4U_PORT_MFB_RDMA3		 MTK_M4U_ID(M4U_LARB5_ID, 18)
+#define M4U_PORT_MFB_WDMA		 MTK_M4U_ID(M4U_LARB5_ID, 19)
+#define M4U_PORT_RESERVE1		 MTK_M4U_ID(M4U_LARB5_ID, 20)
+#define M4U_PORT_RESERVE2		 MTK_M4U_ID(M4U_LARB5_ID, 21)
+#define M4U_PORT_RESERVE3		 MTK_M4U_ID(M4U_LARB5_ID, 22)
+#define M4U_PORT_RESERVE4		 MTK_M4U_ID(M4U_LARB5_ID, 23)
+#define M4U_PORT_RESERVE5		 MTK_M4U_ID(M4U_LARB5_ID, 24)
+#define M4U_PORT_RESERVE6		 MTK_M4U_ID(M4U_LARB5_ID, 25)
+
+/*larb6-IMG-VPU*/
+#define M4U_PORT_IMG_IPUO		 MTK_M4U_ID(M4U_LARB6_ID, 0)
+#define M4U_PORT_IMG_IPU3O		 MTK_M4U_ID(M4U_LARB6_ID, 1)
+#define M4U_PORT_IMG_IPUI		 MTK_M4U_ID(M4U_LARB6_ID, 2)
+
+/*larb7-DVS*/
+#define M4U_PORT_DVS_RDMA		 MTK_M4U_ID(M4U_LARB7_ID, 0)
+#define M4U_PORT_DVS_WDMA		 MTK_M4U_ID(M4U_LARB7_ID, 1)
+#define M4U_PORT_DVP_RDMA		 MTK_M4U_ID(M4U_LARB7_ID, 2)
+#define M4U_PORT_DVP_WDMA		 MTK_M4U_ID(M4U_LARB7_ID, 3)
+
+/*larb8-IPESYS*/
+#define M4U_PORT_FDVT_RDA		 MTK_M4U_ID(M4U_LARB8_ID, 0)
+#define M4U_PORT_FDVT_RDB		 MTK_M4U_ID(M4U_LARB8_ID, 1)
+#define M4U_PORT_FDVT_WRA		 MTK_M4U_ID(M4U_LARB8_ID, 2)
+#define M4U_PORT_FDVT_WRB		 MTK_M4U_ID(M4U_LARB8_ID, 3)
+#define M4U_PORT_FE_RD0			 MTK_M4U_ID(M4U_LARB8_ID, 4)
+#define M4U_PORT_FE_RD1			 MTK_M4U_ID(M4U_LARB8_ID, 5)
+#define M4U_PORT_FE_WR0			 MTK_M4U_ID(M4U_LARB8_ID, 6)
+#define M4U_PORT_FE_WR1			 MTK_M4U_ID(M4U_LARB8_ID, 7)
+#define M4U_PORT_RSC_RDMA0		 MTK_M4U_ID(M4U_LARB8_ID, 8)
+#define M4U_PORT_RSC_WDMA		 MTK_M4U_ID(M4U_LARB8_ID, 9)
+
+/*larb9-CAM*/
+#define M4U_PORT_CAM_IMGO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 0)
+#define M4U_PORT_CAM_RRZO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 1)
+#define M4U_PORT_CAM_LSCI_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 2)
+#define M4U_PORT_CAM_BPCI_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 3)
+#define M4U_PORT_CAM_YUVO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 4)
+#define M4U_PORT_CAM_UFDI_R2_C		 MTK_M4U_ID(M4U_LARB9_ID, 5)
+#define M4U_PORT_CAM_RAWI_R2_C		 MTK_M4U_ID(M4U_LARB9_ID, 6)
+#define M4U_PORT_CAM_RAWI_R5_C		 MTK_M4U_ID(M4U_LARB9_ID, 7)
+#define M4U_PORT_CAM_CAMSV_1		 MTK_M4U_ID(M4U_LARB9_ID, 8)
+#define M4U_PORT_CAM_CAMSV_2		 MTK_M4U_ID(M4U_LARB9_ID, 9)
+#define M4U_PORT_CAM_CAMSV_3		 MTK_M4U_ID(M4U_LARB9_ID, 10)
+#define M4U_PORT_CAM_CAMSV_4		 MTK_M4U_ID(M4U_LARB9_ID, 11)
+#define M4U_PORT_CAM_CAMSV_5		 MTK_M4U_ID(M4U_LARB9_ID, 12)
+#define M4U_PORT_CAM_CAMSV_6		 MTK_M4U_ID(M4U_LARB9_ID, 13)
+#define M4U_PORT_CAM_AAO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 14)
+#define M4U_PORT_CAM_AFO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 15)
+#define M4U_PORT_CAM_FLKO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 16)
+#define M4U_PORT_CAM_LCESO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 17)
+#define M4U_PORT_CAM_CRZO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 18)
+#define M4U_PORT_CAM_LTMSO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 19)
+#define M4U_PORT_CAM_RSSO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 20)
+#define M4U_PORT_CAM_CCUI		 MTK_M4U_ID(M4U_LARB9_ID, 21)
+#define M4U_PORT_CAM_CCUO		 MTK_M4U_ID(M4U_LARB9_ID, 22)
+#define M4U_PORT_CAM_FAKE		 MTK_M4U_ID(M4U_LARB9_ID, 23)
+
+/*larb10-CAM_A*/
+#define M4U_PORT_CAM_IMGO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 0)
+#define M4U_PORT_CAM_RRZO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 1)
+#define M4U_PORT_CAM_LSCI_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 2)
+#define M4U_PORT_CAM_BPCI_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 3)
+#define M4U_PORT_CAM_YUVO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 4)
+#define M4U_PORT_CAM_UFDI_R2_A		 MTK_M4U_ID(M4U_LARB10_ID, 5)
+#define M4U_PORT_CAM_RAWI_R2_A		 MTK_M4U_ID(M4U_LARB10_ID, 6)
+#define M4U_PORT_CAM_RAWI_R5_A		 MTK_M4U_ID(M4U_LARB10_ID, 7)
+#define M4U_PORT_CAM_IMGO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 8)
+#define M4U_PORT_CAM_RRZO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 9)
+#define M4U_PORT_CAM_LSCI_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 10)
+#define M4U_PORT_CAM_BPCI_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 11)
+#define M4U_PORT_CAM_YUVO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 12)
+#define M4U_PORT_CAM_UFDI_R2_B		 MTK_M4U_ID(M4U_LARB10_ID, 13)
+#define M4U_PORT_CAM_RAWI_R2_B		 MTK_M4U_ID(M4U_LARB10_ID, 14)
+#define M4U_PORT_CAM_RAWI_R5_B		 MTK_M4U_ID(M4U_LARB10_ID, 15)
+#define M4U_PORT_CAM_CAMSV_0		 MTK_M4U_ID(M4U_LARB10_ID, 16)
+#define M4U_PORT_CAM_AAO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 17)
+#define M4U_PORT_CAM_AFO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 18)
+#define M4U_PORT_CAM_FLKO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 19)
+#define M4U_PORT_CAM_LCESO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 20)
+#define M4U_PORT_CAM_CRZO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 21)
+#define M4U_PORT_CAM_AAO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 22)
+#define M4U_PORT_CAM_AFO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 23)
+#define M4U_PORT_CAM_FLKO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 24)
+#define M4U_PORT_CAM_LCESO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 25)
+#define M4U_PORT_CAM_CRZO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 26)
+#define M4U_PORT_CAM_LTMSO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 27)
+#define M4U_PORT_CAM_RSSO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 28)
+#define M4U_PORT_CAM_LTMSO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 29)
+#define M4U_PORT_CAM_RSSO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 30)
+
+/*larb11-CAM-VPU*/
+#define M4U_PORT_CAM_IPUO		 MTK_M4U_ID(M4U_LARB11_ID, 0)
+#define M4U_PORT_CAM_IPU2O		 MTK_M4U_ID(M4U_LARB11_ID, 1)
+#define M4U_PORT_CAM_IPU3O		 MTK_M4U_ID(M4U_LARB11_ID, 2)
+#define M4U_PORT_CAM_IPUI		 MTK_M4U_ID(M4U_LARB11_ID, 3)
+#define M4U_PORT_CAM_IPU2I		 MTK_M4U_ID(M4U_LARB11_ID, 4)
+
+#define M4U_PORT_CCU0			 MTK_M4U_ID(M4U_LARB12_ID, 0)
+#define M4U_PORT_CCU1			 MTK_M4U_ID(M4U_LARB12_ID, 1)
+
+#define M4U_PORT_VPU			 MTK_M4U_ID(M4U_LARB13_ID, 0)
+#define M4U_PORT_MDLA			 MTK_M4U_ID(M4U_LARB13_ID, 1)
+#define M4U_PORT_EDMA			 MTK_M4U_ID(M4U_LARB13_ID, 2)
+
+#define M4U_PORT_UNKNOWN		 (M4U_PORT_EDMA + 1)
+
+#endif
-- 
2.18.0

