Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035E7C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CE322B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077708;
	bh=lUeKdsbS/fpjRHY+5vnLtxwUqjo+08ew+DKoQTd68/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WPXNkNmC1xCiSuxBlKYuNU3gtilEjXQ07KcAVVZUMe3vQEEGXyJq1lHQA05YLhS7S
	 Ci+u8s/WqXL1kTCSPQpEn7I/wYR1kpqDr1drAZBlJMEG3mDhDNx3HCwxTWMk01TUMw
	 y3Qv+ZGtjwyaR8/Jg3htZBLDkWzRdcIpFc1znyvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbfLKPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732036AbfLKPVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:21:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8320D22527;
        Wed, 11 Dec 2019 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077703;
        bh=lUeKdsbS/fpjRHY+5vnLtxwUqjo+08ew+DKoQTd68/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOLy0E1Q9ecBZID+jgkhVsZ3SnKp8g6pJ27frN28UsRsLLhnGj84pcxN1o/xQBfIn
         aoOIQPz7VfeCHldaPirfccDGpZiwydKW+EEx0Vxp5mfk9d1GVIE0oVtARcp3l5H8WA
         rR7QgAfVfB7VG7wl3OJspqir2vIMz0MZy685Prjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 111/243] dma-mapping: fix return type of dma_set_max_seg_size()
Date:   Wed, 11 Dec 2019 16:04:33 +0100
Message-Id: <20191211150346.624706141@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
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
index 1db6a6b46d0d3..669cde2fa8723 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -674,8 +674,7 @@ static inline unsigned int dma_get_max_seg_size(struct device *dev)
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



