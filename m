Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876BCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 08:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2269E21874
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 08:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sl/ONcYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCaIpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 04:45:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33916 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfCaIpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 04:45:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so7880902wrq.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TOrTGnov2p3/JNAo/vmLtgIjzC628onWE6o6AV0WUEI=;
        b=Sl/ONcYETMdQpeUT7qDnQ0sKT5FXvvSx/inwdSSIT6pyW+rJCWVE1gf6STQoMRUKnN
         l01YzxKfNmhpnJTxqQzWYz5d85mIlV+BL0BidXVv0zSpeH5+peyZt0LJBVCmJCcIeUSa
         d11ateBg4yLRwy4pLGKCHCcWbWLfH7SokXJmJ/AL0ZaJr1B35eUULB0hqIKbKDCZCTd7
         mDzQuzflpSBsxXKwpbrtDHZcpYosbENyAO90+kMcXGKttQ5DQB6Xup2ViHvxQ+SsZcgj
         eVIluXsx+OEL3ELbzmpKX3AlfHxq6JXb46VCxPtWbjzjZE6/cSN7FuD/x73vRqfCXxKR
         HVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TOrTGnov2p3/JNAo/vmLtgIjzC628onWE6o6AV0WUEI=;
        b=cyzVcS0PAjLpjaJ070RlDDssg8ef5f9fz9Mqn0GDvXf6IKAb7Q0003UvDlmJbb17J1
         a9jChAoW8Wu+dOCDLtoky2LVaKGlEl6NbcbyjO6Uxp1+igBXxCJdJTfNoO6M9O881DBN
         B+zdx6VGk9l9QWV7QVb/gYUpGEBJACLXT7ZdutWEo7vfurmkjUosREfQHljSyQF7EXvE
         osM6MCIqjYFs1Zg1Q8kWQfkkQcnXPXi8sOkoneDbt9FFT0MouQ5NdukDYcvYfKDOW7Od
         dnUwDxCZ48bWSMUqoVrE8KLgRtlEvrty5W4Fa5COainUAqodU0TnzKVZyXE45HYr9v6W
         ReuA==
X-Gm-Message-State: APjAAAXBYyCV/ZBf2t2tIPi0Gi3iByo/8DpHdRFxKHopC9vCHZnYDnFo
        ExaydDAiSm780zWX5u0Q5EpLQ04c/ks=
X-Google-Smtp-Source: APXvYqy09VR4Nkz/Hob62EC6TL2mgOnuxHdfHMtZPrKFaXhlkiUCV//bKmY2RZft9jATlQ5Y50m4TQ==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr29723103wrn.89.1554021916492;
        Sun, 31 Mar 2019 01:45:16 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 204sm13802056wmc.1.2019.03.31.01.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 01:45:15 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: remove trailing blank line from EOF
Date:   Sun, 31 Mar 2019 11:45:14 +0300
Message-Id: <20190331084514.6122-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIT does not like extra blank lines at the end of the file, so this patch
removes those lines.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_masks.h   | 1 -
 .../misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h      | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_masks.h  | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_masks.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_masks.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h      | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h      | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_masks.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_masks.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme_masks.h        | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_masks.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h      | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h         | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mmu_masks.h        | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h         | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_masks.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h    | 1 -
 .../misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h   | 1 -
 .../habanalabs/include/goya/asic_reg/psoc_global_conf_masks.h    | 1 -
 .../habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h     | 1 -
 .../misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h    | 1 -
 .../misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h    | 1 -
 .../misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h  | 1 -
 .../misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h  | 1 -
 .../misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h  | 1 -
 .../misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h  | 1 -
 .../misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h  | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/stlb_masks.h       | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h        | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_masks.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_masks.h  | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h   | 1 -
 .../misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_masks.h   | 1 -
 .../misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_masks.h  | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_masks.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h    | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h   | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h     | 1 -
 drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h     | 1 -
 91 files changed, 91 deletions(-)

diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_masks.h
index 2cf5c46b6e8e..4e0dbbbbde20 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_masks.h
@@ -188,4 +188,3 @@
 #define CPU_CA53_CFG_ARM_PMU_EVENT_MASK                              0x3FFFFFFF
 
 #endif /* ASIC_REG_CPU_CA53_CFG_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
index 840ccffa1081..f3faf1aad91a 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
@@ -58,4 +58,3 @@
 #define mmCPU_CA53_CFG_ARM_PMU_1                                     0x441214
 
 #endif /* ASIC_REG_CPU_CA53_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
index f23cb3e41c30..cf657918962a 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
@@ -46,4 +46,3 @@
 #define mmCPU_IF_AXI_SPLIT_INTR                                      0x442130
 
 #endif /* ASIC_REG_CPU_IF_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
index 8fc97f838ada..8c8f9726d4b9 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
@@ -102,4 +102,3 @@
 #define mmCPU_PLL_FREQ_CALC_EN                                       0x4A2440
 
 #endif /* ASIC_REG_CPU_PLL_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
index 61c8cd9ce58b..0b246fe6ad04 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
@@ -206,4 +206,3 @@
 #define mmDMA_CH_0_MEM_INIT_BUSY                                     0x4011FC
 
 #endif /* ASIC_REG_DMA_CH_0_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
index 92960ef5e308..5449031722f2 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
@@ -206,4 +206,3 @@
 #define mmDMA_CH_1_MEM_INIT_BUSY                                     0x4091FC
 
 #endif /* ASIC_REG_DMA_CH_1_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
index 4e37871a51bb..a4768521d18a 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
@@ -206,4 +206,3 @@
 #define mmDMA_CH_2_MEM_INIT_BUSY                                     0x4111FC
 
 #endif /* ASIC_REG_DMA_CH_2_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
index a2d6aeb32a18..619d01897ff8 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
@@ -206,4 +206,3 @@
 #define mmDMA_CH_3_MEM_INIT_BUSY                                     0x4191FC
 
 #endif /* ASIC_REG_DMA_CH_3_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
index 400d6fd3acf5..038617e163f1 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
@@ -206,4 +206,3 @@
 #define mmDMA_CH_4_MEM_INIT_BUSY                                     0x4211FC
 
 #endif /* ASIC_REG_DMA_CH_4_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_masks.h
index 8d965443c51e..f43b564af1be 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_masks.h
@@ -102,4 +102,3 @@
 #define DMA_MACRO_RAZWI_HBW_RD_ID_R_MASK                             0x1FFFFFFF
 
 #endif /* ASIC_REG_DMA_MACRO_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
index 8bfcb001189d..c3bfc1b8e3fd 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
@@ -178,4 +178,3 @@
 #define mmDMA_MACRO_RAZWI_HBW_RD_ID                                  0x4B0158
 
 #endif /* ASIC_REG_DMA_MACRO_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_masks.h
index 9f33f351a3c1..bc977488c072 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_masks.h
@@ -206,4 +206,3 @@
 #define DMA_NRTR_NON_LIN_SCRAMB_EN_MASK                              0x1
 
 #endif /* ASIC_REG_DMA_NRTR_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
index d8293745a02b..c4abc7ff1fc6 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
@@ -224,4 +224,3 @@
 #define mmDMA_NRTR_NON_LIN_SCRAMB                                    0x1C0604
 
 #endif /* ASIC_REG_DMA_NRTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_masks.h
index 10619dbb9b17..b17f72c31ab6 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_masks.h
@@ -462,4 +462,3 @@
 #define DMA_QM_0_CQ_BUF_RDATA_VAL_MASK                               0xFFFFFFFF
 
 #endif /* ASIC_REG_DMA_QM_0_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
index c693bc5dcb22..bf360b301154 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
@@ -176,4 +176,3 @@
 #define mmDMA_QM_0_CQ_BUF_RDATA                                      0x40030C
 
 #endif /* ASIC_REG_DMA_QM_0_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
index da928390f89c..51d432d05ac4 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
@@ -176,4 +176,3 @@
 #define mmDMA_QM_1_CQ_BUF_RDATA                                      0x40830C
 
 #endif /* ASIC_REG_DMA_QM_1_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
index b4f06e9b71d6..18fc0c2b6cc2 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
@@ -176,4 +176,3 @@
 #define mmDMA_QM_2_CQ_BUF_RDATA                                      0x41030C
 
 #endif /* ASIC_REG_DMA_QM_2_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
index 53e3cd78a06b..6cf7204bf5cc 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
@@ -176,4 +176,3 @@
 #define mmDMA_QM_3_CQ_BUF_RDATA                                      0x41830C
 
 #endif /* ASIC_REG_DMA_QM_3_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
index e0eb5f260201..36fef2682875 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
@@ -176,4 +176,3 @@
 #define mmDMA_QM_4_CQ_BUF_RDATA                                      0x42030C
 
 #endif /* ASIC_REG_DMA_QM_4_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
index 0a743817aad7..4ae7fed8b18c 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
@@ -102,4 +102,3 @@
 #define mmIC_PLL_FREQ_CALC_EN                                        0x4A3440
 
 #endif /* ASIC_REG_IC_PLL_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
index 4408188aa067..6d35d852798b 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
@@ -102,4 +102,3 @@
 #define mmMC_PLL_FREQ_CALC_EN                                        0x4A1440
 
 #endif /* ASIC_REG_MC_PLL_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_masks.h
index 687bca5c5fe3..6c23f8b96e7e 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_masks.h
@@ -650,4 +650,3 @@
 #define MME1_RTR_NON_LIN_SCRAMB_EN_MASK                              0x1
 
 #endif /* ASIC_REG_MME1_RTR_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
index c248339a1cbe..122e9d529939 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
@@ -328,4 +328,3 @@
 #define mmMME1_RTR_NON_LIN_SCRAMB                                    0x40604
 
 #endif /* ASIC_REG_MME1_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
index 7a2b777bdc4f..00ce2252bbfb 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
@@ -328,4 +328,3 @@
 #define mmMME2_RTR_NON_LIN_SCRAMB                                    0x80604
 
 #endif /* ASIC_REG_MME2_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
index b78f8bc387fc..8e3eb7fd2070 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
@@ -328,4 +328,3 @@
 #define mmMME3_RTR_NON_LIN_SCRAMB                                    0xC0604
 
 #endif /* ASIC_REG_MME3_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
index d9a4a02cefa3..79b67bbc8567 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
@@ -328,4 +328,3 @@
 #define mmMME4_RTR_NON_LIN_SCRAMB                                    0x100604
 
 #endif /* ASIC_REG_MME4_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
index 205adc988407..0ac3c37ce47f 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
@@ -328,4 +328,3 @@
 #define mmMME5_RTR_NON_LIN_SCRAMB                                    0x140604
 
 #endif /* ASIC_REG_MME5_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
index fcec68388278..50c49cce72a6 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
@@ -328,4 +328,3 @@
 #define mmMME6_RTR_NON_LIN_SCRAMB                                    0x180604
 
 #endif /* ASIC_REG_MME6_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_masks.h
index a0d4382fbbd0..fe7d95bdcef9 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_masks.h
@@ -370,4 +370,3 @@
 #define MME_CMDQ_CQ_BUF_RDATA_VAL_MASK                               0xFFFFFFFF
 
 #endif /* ASIC_REG_MME_CMDQ_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
index 5c2f6b870a58..5f8b85d2b4b1 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmMME_CMDQ_CQ_BUF_RDATA                                      0xD930C
 
 #endif /* ASIC_REG_MME_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme_masks.h
index c7b1b0bb3384..1882c413cbe0 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme_masks.h
@@ -1534,4 +1534,3 @@
 #define MME_SHADOW_3_E_BUBBLES_PER_SPLIT_ID_MASK                     0xFF000000
 
 #endif /* ASIC_REG_MME_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_masks.h
index d4bfa58dce19..e464e381555c 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_masks.h
@@ -462,4 +462,3 @@
 #define MME_QM_CQ_BUF_RDATA_VAL_MASK                                 0xFFFFFFFF
 
 #endif /* ASIC_REG_MME_QM_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
index b5b1c776f6c3..538708beffc9 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmMME_QM_CQ_BUF_RDATA                                        0xD830C
 
 #endif /* ASIC_REG_MME_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
index 9436b1e2705a..0396cbfd5c89 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
@@ -1150,4 +1150,3 @@
 #define mmMME_SHADOW_3_E_BUBBLES_PER_SPLIT                           0xD0BAC
 
 #endif /* ASIC_REG_MME_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mmu_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/mmu_masks.h
index 3a78078d3c4c..c3e69062b135 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mmu_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mmu_masks.h
@@ -140,4 +140,3 @@
 #define MMU_ACCESS_ERROR_CAPTURE_VA_VA_31_0_MASK                     0xFFFFFFFF
 
 #endif /* ASIC_REG_MMU_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
index bec6c014135c..7ec81f12031e 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
@@ -50,4 +50,3 @@
 #define mmMMU_ACCESS_ERROR_CAPTURE_VA                                0x480040
 
 #endif /* ASIC_REG_MMU_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_masks.h
index 209e41402a11..ceb59f2e28b3 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_masks.h
@@ -206,4 +206,3 @@
 #define PCI_NRTR_NON_LIN_SCRAMB_EN_MASK                              0x1
 
 #endif /* ASIC_REG_PCI_NRTR_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
index 447e5d4e7dc8..dd067f301ac2 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
@@ -224,4 +224,3 @@
 #define mmPCI_NRTR_NON_LIN_SCRAMB                                    0x604
 
 #endif /* ASIC_REG_PCI_NRTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
index daaf5d9079dc..35b1d8ac6f63 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
@@ -240,4 +240,3 @@
 #define mmPCIE_AUX_PERST                                             0xC079B8
 
 #endif /* ASIC_REG_PCIE_AUX_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
index 8eda4de58788..9271ea95ebe9 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
@@ -102,4 +102,3 @@
 #define mmPSOC_EMMC_PLL_FREQ_CALC_EN                                 0xC70440
 
 #endif /* ASIC_REG_PSOC_EMMC_PLL_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_masks.h
index d4bf0e1db4df..324266653c9a 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_masks.h
@@ -444,4 +444,3 @@
 #define PSOC_GLOBAL_CONF_PAD_SEL_VAL_MASK                            0x3
 
 #endif /* ASIC_REG_PSOC_GLOBAL_CONF_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
index cfbdd2c9c5c7..8141f422e712 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
@@ -742,4 +742,3 @@
 #define mmPSOC_GLOBAL_CONF_PAD_SEL_81                                0xC4BA44
 
 #endif /* ASIC_REG_PSOC_GLOBAL_CONF_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
index 6723d8f76f30..4789ebb9c337 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
@@ -102,4 +102,3 @@
 #define mmPSOC_MME_PLL_FREQ_CALC_EN                                  0xC71440
 
 #endif /* ASIC_REG_PSOC_MME_PLL_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
index abcded0531c9..27a296ea6c3d 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
@@ -102,4 +102,3 @@
 #define mmPSOC_PCI_PLL_FREQ_CALC_EN                                  0xC72440
 
 #endif /* ASIC_REG_PSOC_PCI_PLL_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
index 5925c7477c25..66aee7fa6b1e 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
@@ -140,4 +140,3 @@
 #define mmPSOC_SPI_RSVD_2                                            0xC430FC
 
 #endif /* ASIC_REG_PSOC_SPI_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
index d56c9fa0e7ba..2ea1770b078f 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
@@ -80,4 +80,3 @@
 #define mmSRAM_Y0_X0_RTR_DBG_L_ARB_MAX                               0x201330
 
 #endif /* ASIC_REG_SRAM_Y0_X0_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
index 5624544303ca..37e0713efa73 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
@@ -80,4 +80,3 @@
 #define mmSRAM_Y0_X1_RTR_DBG_L_ARB_MAX                               0x205330
 
 #endif /* ASIC_REG_SRAM_Y0_X1_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
index 3322bc0bd1df..d2572279a2b9 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
@@ -80,4 +80,3 @@
 #define mmSRAM_Y0_X2_RTR_DBG_L_ARB_MAX                               0x209330
 
 #endif /* ASIC_REG_SRAM_Y0_X2_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
index 81e393db2027..68c5b402c506 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
@@ -80,4 +80,3 @@
 #define mmSRAM_Y0_X3_RTR_DBG_L_ARB_MAX                               0x20D330
 
 #endif /* ASIC_REG_SRAM_Y0_X3_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
index b2e11b1de385..a42f1ba06d28 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
@@ -80,4 +80,3 @@
 #define mmSRAM_Y0_X4_RTR_DBG_L_ARB_MAX                               0x211330
 
 #endif /* ASIC_REG_SRAM_Y0_X4_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/stlb_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/stlb_masks.h
index b4ea8cae2757..94f2ed4a36bd 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/stlb_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/stlb_masks.h
@@ -114,4 +114,3 @@
 #define STLB_SRAM_INIT_BUSY_DATA_MASK                                0x10
 
 #endif /* ASIC_REG_STLB_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
index 0f5281d3e65b..35013f65acd2 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
@@ -52,4 +52,3 @@
 #define mmSTLB_SRAM_INIT                                             0x49004C
 
 #endif /* ASIC_REG_STLB_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_masks.h
index e5587b49eecd..89c9507a512f 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_masks.h
@@ -1604,4 +1604,3 @@
 #define TPC0_CFG_FUNC_MBIST_MEM_LAST_FAILED_PATTERN_MASK             0x70000000
 
 #endif /* ASIC_REG_TPC0_CFG_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
index 2be28a63c50a..7d71c4b73a5e 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
@@ -884,4 +884,3 @@
 #define mmTPC0_CFG_FUNC_MBIST_MEM_9                                  0xE06E2C
 
 #endif /* ASIC_REG_TPC0_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_masks.h
index 9aa2d8b53207..9395f2458771 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_masks.h
@@ -370,4 +370,3 @@
 #define TPC0_CMDQ_CQ_BUF_RDATA_VAL_MASK                              0xFFFFFFFF
 
 #endif /* ASIC_REG_TPC0_CMDQ_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
index 3572752ba66e..bc51df573bf0 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmTPC0_CMDQ_CQ_BUF_RDATA                                     0xE0930C
 
 #endif /* ASIC_REG_TPC0_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_masks.h
index ed866d93c440..553c6b6bd5ec 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_masks.h
@@ -344,4 +344,3 @@
 #define TPC0_EML_CFG_DBG_INST_INSERT_CTL_INSERT_MASK                 0x1
 
 #endif /* ASIC_REG_TPC0_EML_CFG_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
index f1a1b4fa4841..8495479c3659 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
@@ -310,4 +310,3 @@
 #define mmTPC0_EML_CFG_DBG_INST_INSERT_CTL                           0x3040334
 
 #endif /* ASIC_REG_TPC0_EML_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_masks.h
index 7f86621179a5..43fafcf01041 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_masks.h
@@ -206,4 +206,3 @@
 #define TPC0_NRTR_NON_LIN_SCRAMB_EN_MASK                             0x1
 
 #endif /* ASIC_REG_TPC0_NRTR_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
index dc280f4e6608..ce3346dd2042 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
@@ -224,4 +224,3 @@
 #define mmTPC0_NRTR_NON_LIN_SCRAMB                                   0xE00604
 
 #endif /* ASIC_REG_TPC0_NRTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_masks.h
index 80d97ee3d8d6..2e4b45947944 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_masks.h
@@ -462,4 +462,3 @@
 #define TPC0_QM_CQ_BUF_RDATA_VAL_MASK                                0xFFFFFFFF
 
 #endif /* ASIC_REG_TPC0_QM_MASKS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
index 7552d4ba61fe..4fa09eb88878 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmTPC0_QM_CQ_BUF_RDATA                                       0xE0830C
 
 #endif /* ASIC_REG_TPC0_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
index 19894413474a..928eef1808ae 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
@@ -884,4 +884,3 @@
 #define mmTPC1_CFG_FUNC_MBIST_MEM_9                                  0xE46E2C
 
 #endif /* ASIC_REG_TPC1_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
index 9099ebd7ab23..30ae0f307328 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmTPC1_CMDQ_CQ_BUF_RDATA                                     0xE4930C
 
 #endif /* ASIC_REG_TPC1_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
index bc8b9a10391f..b95de4f95ba9 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmTPC1_QM_CQ_BUF_RDATA                                       0xE4830C
 
 #endif /* ASIC_REG_TPC1_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
index ae267f8f457e..0f91e307879e 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
@@ -320,4 +320,3 @@
 #define mmTPC1_RTR_NON_LIN_SCRAMB                                    0xE40604
 
 #endif /* ASIC_REG_TPC1_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
index 9c33fc039036..73421227f35b 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
@@ -884,4 +884,3 @@
 #define mmTPC2_CFG_FUNC_MBIST_MEM_9                                  0xE86E2C
 
 #endif /* ASIC_REG_TPC2_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
index 7a643887d6e1..27b66bf2da9f 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmTPC2_CMDQ_CQ_BUF_RDATA                                     0xE8930C
 
 #endif /* ASIC_REG_TPC2_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
index f3e32c018064..31e5b2f53905 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmTPC2_QM_CQ_BUF_RDATA                                       0xE8830C
 
 #endif /* ASIC_REG_TPC2_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
index 0eb0cd1fbd19..4eddeaa15d94 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
@@ -320,4 +320,3 @@
 #define mmTPC2_RTR_NON_LIN_SCRAMB                                    0xE80604
 
 #endif /* ASIC_REG_TPC2_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
index 0baf63c69b25..ce573a1a8361 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
@@ -884,4 +884,3 @@
 #define mmTPC3_CFG_FUNC_MBIST_MEM_9                                  0xEC6E2C
 
 #endif /* ASIC_REG_TPC3_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
index 82a5261e852f..11d81fca0a0f 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmTPC3_CMDQ_CQ_BUF_RDATA                                     0xEC930C
 
 #endif /* ASIC_REG_TPC3_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
index b05b1e18e664..e41595a19e69 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmTPC3_QM_CQ_BUF_RDATA                                       0xEC830C
 
 #endif /* ASIC_REG_TPC3_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
index 5a2fd7652650..34a438b1efe5 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
@@ -320,4 +320,3 @@
 #define mmTPC3_RTR_NON_LIN_SCRAMB                                    0xEC0604
 
 #endif /* ASIC_REG_TPC3_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
index d64a100075f2..d44caf0fc1bb 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
@@ -884,4 +884,3 @@
 #define mmTPC4_CFG_FUNC_MBIST_MEM_9                                  0xF06E2C
 
 #endif /* ASIC_REG_TPC4_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
index 565b42885b0d..f13a6532961f 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmTPC4_CMDQ_CQ_BUF_RDATA                                     0xF0930C
 
 #endif /* ASIC_REG_TPC4_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
index 196da3f12710..db081fc17cfc 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmTPC4_QM_CQ_BUF_RDATA                                       0xF0830C
 
 #endif /* ASIC_REG_TPC4_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
index 8b54041d144a..8c5372303b28 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
@@ -320,4 +320,3 @@
 #define mmTPC4_RTR_NON_LIN_SCRAMB                                    0xF00604
 
 #endif /* ASIC_REG_TPC4_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
index 3f00954fcdba..5139fde71011 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
@@ -884,4 +884,3 @@
 #define mmTPC5_CFG_FUNC_MBIST_MEM_9                                  0xF46E2C
 
 #endif /* ASIC_REG_TPC5_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
index d8e72a8e18d7..1e7cd6e1e888 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmTPC5_CMDQ_CQ_BUF_RDATA                                     0xF4930C
 
 #endif /* ASIC_REG_TPC5_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
index be2e68624709..ac0d3820cd6b 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmTPC5_QM_CQ_BUF_RDATA                                       0xF4830C
 
 #endif /* ASIC_REG_TPC5_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
index 6f301c7bbc2f..57f83bc3b17d 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
@@ -320,4 +320,3 @@
 #define mmTPC5_RTR_NON_LIN_SCRAMB                                    0xF40604
 
 #endif /* ASIC_REG_TPC5_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
index 1e1168601c41..94e0191c06c1 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
@@ -884,4 +884,3 @@
 #define mmTPC6_CFG_FUNC_MBIST_MEM_9                                  0xF86E2C
 
 #endif /* ASIC_REG_TPC6_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
index fbca6b47284e..7a1a0e87b225 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmTPC6_CMDQ_CQ_BUF_RDATA                                     0xF8930C
 
 #endif /* ASIC_REG_TPC6_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
index bf32465dabcb..80fa0fe0f60f 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmTPC6_QM_CQ_BUF_RDATA                                       0xF8830C
 
 #endif /* ASIC_REG_TPC6_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
index 609bb90e1046..d6cae8b8af66 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
@@ -320,4 +320,3 @@
 #define mmTPC6_RTR_NON_LIN_SCRAMB                                    0xF80604
 
 #endif /* ASIC_REG_TPC6_RTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
index bf2fd0f73906..234147adb779 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
@@ -884,4 +884,3 @@
 #define mmTPC7_CFG_FUNC_MBIST_MEM_9                                  0xFC6E2C
 
 #endif /* ASIC_REG_TPC7_CFG_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
index 65d83043bf63..4c160632fe7d 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
@@ -136,4 +136,3 @@
 #define mmTPC7_CMDQ_CQ_BUF_RDATA                                     0xFC930C
 
 #endif /* ASIC_REG_TPC7_CMDQ_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
index 3d5848d87304..0c13d4d167aa 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
@@ -224,4 +224,3 @@
 #define mmTPC7_NRTR_NON_LIN_SCRAMB                                   0xFC0604
 
 #endif /* ASIC_REG_TPC7_NRTR_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
index 25f5095f68fb..cbe11425bfb0 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
@@ -176,4 +176,3 @@
 #define mmTPC7_QM_CQ_BUF_RDATA                                       0xFC830C
 
 #endif /* ASIC_REG_TPC7_QM_REGS_H_ */
-
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
index 920231d0afa5..e25e19660a9d 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
@@ -102,4 +102,3 @@
 #define mmTPC_PLL_FREQ_CALC_EN                                       0xE01440
 
 #endif /* ASIC_REG_TPC_PLL_REGS_H_ */
-
-- 
2.17.1

