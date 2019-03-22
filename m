Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84078C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A5921900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257175;
	bh=DA5NstBC0eiAaN4rojVdIbNNkS4vRrnNzSDgtDd8gv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K0o0So6Jdi5993rb9zTbCiCtMtZGQViz0tSfA2Ct4pvp//6NXH6f+bTt9v/ywEv7y
	 x5NblAT5R8P/Ai0GL3CpJHIqTxnBrVGFOpK153ZUQiN9WcEKGCDdKwihQdI7Ymi0Aj
	 H3H1tL078PPepCG4h9gqKFvXyMr4Nd5o39Par2Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390625AbfCVMTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390458AbfCVMT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB97D2054F;
        Fri, 22 Mar 2019 12:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257166;
        bh=DA5NstBC0eiAaN4rojVdIbNNkS4vRrnNzSDgtDd8gv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wj2+xVZN940sxGE/oQp0Pv63v7o09/BO0ye9+Pnh5pWN7sIRbXqU/CqiqLCehqJ4C
         zOBYg4m/Li2UwEMiPjGmzC/xEkHghamiV/+nhP+qT9wCoH6RxrvvDl8mnJ6EB+XKku
         i/a8uzWuiXFVQWnq5mEkbw4B95QnD3oHoAEme0sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.0 125/238] swiotlb: Introduce swiotlb_max_mapping_size()
Date:   Fri, 22 Mar 2019 12:15:44 +0100
Message-Id: <20190322111305.886443361@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joerg Roedel <jroedel@suse.de>

commit abe420bfae528c92bd8cc5ecb62dc95672b1fd6f upstream.

The function returns the maximum size that can be remapped
by the SWIOTLB implementation. This function will be later
exposed to users through the DMA-API.

Cc: stable@vger.kernel.org
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/swiotlb.h |    5 +++++
 kernel/dma/swiotlb.c    |    5 +++++
 2 files changed, 10 insertions(+)

--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -76,6 +76,7 @@ bool swiotlb_map(struct device *dev, phy
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
+size_t swiotlb_max_mapping_size(struct device *dev);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
@@ -95,6 +96,10 @@ static inline unsigned int swiotlb_max_s
 {
 	return 0;
 }
+static inline size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return SIZE_MAX;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -662,3 +662,8 @@ swiotlb_dma_supported(struct device *hwd
 {
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
+
+size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
+}


