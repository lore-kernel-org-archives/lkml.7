Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F7DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1A4206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522159;
	bh=S48OnPQUChQ52xA7/74tcz2BhJqMh9f/iI1tCRR4sYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hyt7/AdSwBebmiiarLc/+Kgdq9BiMYDOR6vH8UUn/Z8w/OQQ8inFuWiRYjf8VOwKs
	 4w9e2OMYtAZ7K9JPbcshcsCg1+iKeKaHWj0ujQdy12g4LgmxcgpplLoJrs0Ep+BsMo
	 KOPasFtU6z/qtBNPl296Y/4SRRaVag+QaC0RxiN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfLPStS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfLPRxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:53:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A118206D3;
        Mon, 16 Dec 2019 17:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518796;
        bh=S48OnPQUChQ52xA7/74tcz2BhJqMh9f/iI1tCRR4sYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOJFSQosbPoVF4RQoSsod5sjc2A0WzAOTZoMKS7XMe6Tj4+T1ia2ThzNBtPadG6pb
         b2cB8G91Wqa+H0tYnhK6MeQKGoM/6Y2cXLfviSJeDIqMTkOeW56N3H0YWPoHIIub2+
         QRrIfMkcRC5QbgmgPkZrgxPtfc8/06gKakkTE7UU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 071/267] dma-mapping: fix return type of dma_set_max_seg_size()
Date:   Mon, 16 Dec 2019 18:46:37 +0100
Message-Id: <20191216174856.507692201@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit c9d76d0655c06b8c1f944e46c4fd9e9cf4b331c0 ]

The function dma_set_max_seg_size() can return either 0 on success or
-EIO on error. Change its return type from unsigned int to int to
capture this.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/dma-mapping.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 7bf3b99e6fbb1..9aee5f345e299 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -650,8 +650,7 @@ static inline unsigned int dma_get_max_seg_size(struct device *dev)
 	return SZ_64K;
 }
 
-static inline unsigned int dma_set_max_seg_size(struct device *dev,
-						unsigned int size)
+static inline int dma_set_max_seg_size(struct device *dev, unsigned int size)
 {
 	if (dev->dma_parms) {
 		dev->dma_parms->max_segment_size = size;
-- 
2.20.1



