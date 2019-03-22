Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AC7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB77C2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257187;
	bh=8hVlGm2CmzmwOczz3reRT8TfuSFfUFa22jn8Whfs5SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mNiWekvXBldkOjh5L1w7AgWLI+7D6mghsH7SwyqASn1zzWxyXw5keRP8UpWKP5tzY
	 UPq2IDVrtJymgw2n/Zc/kP/GHeCbZMhCKITnfU5D8YTSI25Wj+FJO5g0hX8YfRxOZW
	 sVgkBw0AxJuNHGPl9GS18IIUxJEgDJo0AwmMyips=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390689AbfCVMTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390654AbfCVMTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A86B3218A1;
        Fri, 22 Mar 2019 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257183;
        bh=8hVlGm2CmzmwOczz3reRT8TfuSFfUFa22jn8Whfs5SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piY97JYDX0U2BB2YeToBs+oaoXG6e5T3/C4LgJuz+2lsALkOCnGyDTiYguSIM/B1l
         LvpzuGGz2gkn8F/Dt2WH2gAcj5mex5toTJZt3AwuILnCjJF2h6Q767TuHDwBYoyr82
         xNokwCFrRKl/nTIg9K/uJxa3cGS6Rl9ssZsFgXSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.0 126/238] swiotlb: Add is_swiotlb_active() function
Date:   Fri, 22 Mar 2019 12:15:45 +0100
Message-Id: <20190322111305.939960883@linuxfoundation.org>
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

commit 492366f7b4237257ef50ca9c431a6a0d50225aca upstream.

This function will be used from dma_direct code to determine
the maximum segment size of a dma mapping.

Cc: stable@vger.kernel.org
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/swiotlb.h |    6 ++++++
 kernel/dma/swiotlb.c    |    9 +++++++++
 2 files changed, 15 insertions(+)

--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -77,6 +77,7 @@ bool swiotlb_map(struct device *dev, phy
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
+bool is_swiotlb_active(void);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
@@ -100,6 +101,11 @@ static inline size_t swiotlb_max_mapping
 {
 	return SIZE_MAX;
 }
+
+static inline bool is_swiotlb_active(void)
+{
+	return false;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -667,3 +667,12 @@ size_t swiotlb_max_mapping_size(struct d
 {
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
+
+bool is_swiotlb_active(void)
+{
+	/*
+	 * When SWIOTLB is initialized, even if io_tlb_start points to physical
+	 * address zero, io_tlb_end surely doesn't.
+	 */
+	return io_tlb_end != 0;
+}


