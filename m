Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3A7CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D15214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvX8/Ifn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbfJWGcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:32:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36169 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387946AbfJWGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:32:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so9577286plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 23:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z3BS8hNGDisqpRfkHtgUnIkj8IIlWeTgWBdo/Yh3MnM=;
        b=RvX8/Ifnq61PEF8c6CKaESj1qOYiXBEd334mw+mpvXJQ20JFoFNJ7GsN7JgXCv8l33
         iXoLxyJb5PUOEH8uU2Vj3237vLqRtyhXhoJcH2MTynmzpY5HLm3YBDrDQnT6wVbpvxNs
         bpCF608uxh9vDHae94muG7hBj18psIv+EtzBDbMkgwoLbSSN1GcQVU71EUXt/0kZnVGj
         aFrhklHKikIm5vR0QmxWHcvjezDzF5N1wGiv/N2GcR+BHS+Z1C9Nu/B5NMgxvrrm0ZCL
         Zn+51xullfRKN9TK6os1IRf7oQLIDz1ximULFGGZAnlLDHTWnA9n+cO3tYb8jH58qD+J
         X2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z3BS8hNGDisqpRfkHtgUnIkj8IIlWeTgWBdo/Yh3MnM=;
        b=mdvKKzIDeiAOhJrfEgW3XjTud9GtgVeO8k1SWeVuJ9eqgYS+9Ok+7OFvbsgK4JQAzE
         QURnls4AFCFSJybcumYZFe8gcEV3YwNc3hc1MRTO2liDygpLyTNqKnhShU/FVpohuw1E
         1kLoBXiv8qSryyYHLN8CWDkZe3qDO2dN4eJW6LEcYbEb5GwZqqyCUmr+o7MjmnTZbXqy
         XHc1K18SdnKmnGIVQUH6CX7ZOSPNcf18MyVfnhTn1KQYhwPjs8XX5h99Jh8bkDbh5H+Q
         ksFO8qMwbrJ71MjPGBIMmxRi6CsuVXN9XwF8O4J6wBeDu6SAvfGGGV2k/ugaT6uNNnGB
         +vzQ==
X-Gm-Message-State: APjAAAUr7SAly8BNpSeKNWWrRzU/LdJDOGhY8ioZXULMh6Cu2nhcfF0U
        qPY1mwsn5xNCUl4GOb02UfcYWQ==
X-Google-Smtp-Source: APXvYqw1BwYa+pommJGiYoOew4lRqPcC8rXhOBMJmQZbR2TQP1VH5ipW1fFRFsH5X3Tz/bxtZMu+Tw==
X-Received: by 2002:a17:902:a70f:: with SMTP id w15mr7929063plq.146.1571812334654;
        Tue, 22 Oct 2019 23:32:14 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l93sm6695279pjb.6.2019.10.22.23.32.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 23:32:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com
Subject: [PATCH] dmaengine: sprd: Add wrap address support for link-list mode
Date:   Wed, 23 Oct 2019 14:31:32 +0800
Message-Id: <85a5484bc1f3dd53ce6f92700ad8b35f30a0b096.1571812029.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@unisoc.com>

The Spreadtrum Audio compress offload mode will use 2-stage DMA transfer
to save power. That means we can request 2 dma channels, one for source
channel, and another one for destination channel. Once the source channel's
transaction is done, it will trigger the destination channel's transaction
automatically by hardware signal.

In this case, the source channel will transfer data from IRAM buffer to
the DSP fifo to decoding/encoding, once IRAM buffer is empty by transferring
done, the destination channel will start to transfer data from DDR buffer
to IRAM buffer. Since the destination channel will use link-list mode to
fill the IRAM data, and IRAM buffer is allocated by 32K, and DDR buffer
is larger to 2M, that means we need lots of link-list nodes to do a cyclic
transfer, instead wasting lots of link-list memory, we can use wrap address
support to reduce link-list node number, which means when the transfer
address reaches the wrap address, the transfer address will jump to the
wrap_to address specified by wrap_to register, and only 2 link-list nodes
can do a cyclic transfer to transfer data from DDR to IRAM.

Thus this patch adds wrap address to support this case.

[Baolin Wang changes the commit message]
Signed-off-by: Eric Long <eric.long@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c       |   13 +++++++++++++
 include/linux/dma/sprd-dma.h |    4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 32402c2..9a31a315 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -99,6 +99,7 @@
 /* DMA_CHN_WARP_* register definition */
 #define SPRD_DMA_HIGH_ADDR_MASK		GENMASK(31, 28)
 #define SPRD_DMA_LOW_ADDR_MASK		GENMASK(31, 0)
+#define SPRD_DMA_WRAP_ADDR_MASK		GENMASK(27, 0)
 #define SPRD_DMA_HIGH_ADDR_OFFSET	4
 
 /* SPRD_DMA_CHN_INTC register definition */
@@ -118,6 +119,8 @@
 #define SPRD_DMA_SWT_MODE_OFFSET	26
 #define SPRD_DMA_REQ_MODE_OFFSET	24
 #define SPRD_DMA_REQ_MODE_MASK		GENMASK(1, 0)
+#define SPRD_DMA_WRAP_SEL_DEST		BIT(23)
+#define SPRD_DMA_WRAP_EN		BIT(22)
 #define SPRD_DMA_FIX_SEL_OFFSET		21
 #define SPRD_DMA_FIX_EN_OFFSET		20
 #define SPRD_DMA_LLIST_END		BIT(19)
@@ -804,6 +807,8 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 	temp |= req_mode << SPRD_DMA_REQ_MODE_OFFSET;
 	temp |= fix_mode << SPRD_DMA_FIX_SEL_OFFSET;
 	temp |= fix_en << SPRD_DMA_FIX_EN_OFFSET;
+	temp |= schan->linklist.wrap_addr ?
+		SPRD_DMA_WRAP_EN | SPRD_DMA_WRAP_SEL_DEST : 0;
 	temp |= slave_cfg->src_maxburst & SPRD_DMA_FRG_LEN_MASK;
 	hw->frg_len = temp;
 
@@ -831,6 +836,12 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 		hw->llist_ptr = lower_32_bits(llist_ptr);
 		hw->src_blk_step = (upper_32_bits(llist_ptr) << SPRD_DMA_LLIST_HIGH_SHIFT) &
 			SPRD_DMA_LLIST_HIGH_MASK;
+
+		if (schan->linklist.wrap_addr) {
+			hw->wrap_ptr |= schan->linklist.wrap_addr &
+				SPRD_DMA_WRAP_ADDR_MASK;
+			hw->wrap_to |= dst & SPRD_DMA_WRAP_ADDR_MASK;
+		}
 	} else {
 		hw->llist_ptr = 0;
 		hw->src_blk_step = 0;
@@ -939,9 +950,11 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 
 		schan->linklist.phy_addr = ll_cfg->phy_addr;
 		schan->linklist.virt_addr = ll_cfg->virt_addr;
+		schan->linklist.wrap_addr = ll_cfg->wrap_addr;
 	} else {
 		schan->linklist.phy_addr = 0;
 		schan->linklist.virt_addr = 0;
+		schan->linklist.wrap_addr = 0;
 	}
 
 	/*
diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
index ab82df6..d09c6f6 100644
--- a/include/linux/dma/sprd-dma.h
+++ b/include/linux/dma/sprd-dma.h
@@ -118,6 +118,9 @@ enum sprd_dma_int_type {
  * struct sprd_dma_linklist - DMA link-list address structure
  * @virt_addr: link-list virtual address to configure link-list node
  * @phy_addr: link-list physical address to link DMA transfer
+ * @wrap_addr: the wrap address for link-list mode, which means once the
+ * transfer address reaches the wrap address, the next transfer address
+ * will jump to the address specified by wrap_to register.
  *
  * The Spreadtrum DMA controller supports the link-list mode, that means slaves
  * can supply several groups configurations (each configuration represents one
@@ -181,6 +184,7 @@ enum sprd_dma_int_type {
 struct sprd_dma_linklist {
 	unsigned long virt_addr;
 	phys_addr_t phy_addr;
+	phys_addr_t wrap_addr;
 };
 
 #endif
-- 
1.7.9.5

