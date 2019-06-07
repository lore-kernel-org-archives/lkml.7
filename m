Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B94C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2599D214AE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922355;
	bh=lBUcbMCukAdxXX+qqRGYcXnacZxroOCWYxvBwQZ+3Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/8ipjWUr5l08zu5JP/KykqFLwabx1uQSqncMWJOLXNkOAu18hQnIuhNVvY+Rgzym
	 8zWizb3ifU6/WdgIkyVPYEG52e3J9Ue0AuTTBA0OKeh7nOLA7P67YzMKhEscf9t6ss
	 /XFSkmCV83U40a++ZofL/UQnv50MWQvFvIQJfV4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfFGPpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731307AbfFGPpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:45:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA3E214AE;
        Fri,  7 Jun 2019 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922351;
        bh=lBUcbMCukAdxXX+qqRGYcXnacZxroOCWYxvBwQZ+3Jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bApgsdueadUN9SireUcFLwtpnGObAhyuS5f9aFktKYTjYisHwexy18b0hj4nfcYw5
         6MuXIsrz75mmOJKJBkzMYWJHVMkXRM4veskKMhRyH0RO7LdUDcPw232/HjxkGkyQE0
         gawFEqET0HiRHLqGiIFhzVTue0xtoNG1+owylEhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.19 56/73] drm/tegra: gem: Fix CPU-cache maintenance for BOs allocated using get_pages()
Date:   Fri,  7 Jun 2019 17:39:43 +0200
Message-Id: <20190607153855.290415436@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153848.669070800@linuxfoundation.org>
References: <20190607153848.669070800@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

commit 61b51fb51c01a519a249d28ec55c6513a13be5a3 upstream.

The allocated pages need to be invalidated in CPU caches. On ARM32 the
DMA_BIDIRECTIONAL flag only ensures that data is written-back to DRAM and
the data stays in CPU cache lines. While the DMA_FROM_DEVICE flag ensures
that the corresponding CPU cache lines are getting invalidated and nothing
more, that's exactly what is needed for a newly allocated pages.

This fixes randomly failing rendercheck tests on Tegra30 using the
Opentegra driver for tests that use small-sized pixmaps (10x10 and less,
i.e. 1-2 memory pages) because apparently CPU reads out stale data from
caches and/or that data is getting evicted to DRAM at the time of HW job
execution.

Fixes: bd43c9f0fa1f ("drm/tegra: gem: Map pages via the DMA API")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/tegra/gem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -204,7 +204,7 @@ static void tegra_bo_free(struct drm_dev
 {
 	if (bo->pages) {
 		dma_unmap_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			     DMA_BIDIRECTIONAL);
+			     DMA_FROM_DEVICE);
 		drm_gem_put_pages(&bo->gem, bo->pages, true, true);
 		sg_free_table(bo->sgt);
 		kfree(bo->sgt);
@@ -230,7 +230,7 @@ static int tegra_bo_get_pages(struct drm
 	}
 
 	err = dma_map_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			 DMA_BIDIRECTIONAL);
+			 DMA_FROM_DEVICE);
 	if (err == 0) {
 		err = -EFAULT;
 		goto free_sgt;


