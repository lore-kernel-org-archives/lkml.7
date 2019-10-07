Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63325ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D22B20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6pA7nAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfJGScM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:32:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45831 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGScL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:32:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so20597725qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3rnbgFnuJ98U2STRa9CikKX4jXSjq4U8XYYbtubS7J8=;
        b=O6pA7nAG8ZfanaMkDBZItX1pIMYhKT0fhFjw90lBs34r8Mshe0qIxKB3Dci2mITiih
         NVdOqeJQG36TF2YAvneq/c7wSpf76fxc7uHl7t9HI054TaKztCb5MzYkgAcKI/53yfxs
         izY/eF/PtzBbiTR2lNCjzgP6UDu9C/EsvlqJXR9ZHAOshoG8iN569Dnq6Xjs/+adR9V0
         Pvba105YGdGX4fWVtjuMzYQCY0TzOjrbdqOSxZtJgz2kiLeLbXD9SAeIK2pLREm7ymGa
         8ON88jhIv7kdPyFfZcTrQU5WU9DTyolHkZ/OEPJ5ezEWhMP0FM4ttET1k/Yzk1Yjg1jv
         isHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3rnbgFnuJ98U2STRa9CikKX4jXSjq4U8XYYbtubS7J8=;
        b=LXf5Smbx9U1Z5fKE7N/3guOeVz6Ho0Ln229wJ+MNvlBsXzIysRmtEmC9rsPZ7aAPcf
         9qgE4+qWSzRdrxZuRNXxoH5mXpmheGl+FBIey3rFROCcFtJBVaLiGdL5Njootk1yKdFg
         ECw7oCYVswXLMhx2Jdu/RMgMhUrHCemxEoWuihqKLqYdta/FB2g5o7qZYh17iOlJ+BLY
         k8J/2pUibqQtafQ+8Vb6+Yi3iq1YNjt3/1O9cZSA6RJt/ZZnAFhsZd6in6pr97K6KoCJ
         E5HRE1npB5luHaDW0h67yVqpZq4pT86P2nwRNGCOWLsgRIX01Zb8/ckweFcXYmVeXNUy
         CuBg==
X-Gm-Message-State: APjAAAXSKtjzzrQaKCwYgoRDp8vjB3lHWYx1mkORM3mx6Mx5K1V2is7g
        dX37yFluzPTRT0NS5XjSqkg=
X-Google-Smtp-Source: APXvYqwydeqYAkBJGUUDSKOHyrPiENQl/bxwRYRR4luRVdClTnpwRFsFOPSgbyJfTuIIYZmDcmE81g==
X-Received: by 2002:aed:21d1:: with SMTP id m17mr32105904qtc.17.1570473129811;
        Mon, 07 Oct 2019 11:32:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n21sm8251568qka.83.2019.10.07.11.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:32:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Oct 2019 14:32:07 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007183206.GA13589@rani.riverdale.lan>
References: <20191007022454.GA5270@rani.riverdale.lan>
 <20191007073448.GA882@lst.de>
 <20191007175430.GA32537@rani.riverdale.lan>
 <20191007175528.GA21857@lst.de>
 <20191007175630.GA28861@infradead.org>
 <20191007175856.GA42018@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20191007175856.GA42018@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Oct 07, 2019 at 01:58:57PM -0400, Arvind Sankar wrote:
> On Mon, Oct 07, 2019 at 10:56:30AM -0700, Christoph Hellwig wrote:
> > On Mon, Oct 07, 2019 at 07:55:28PM +0200, Christoph Hellwig wrote:
> > > On Mon, Oct 07, 2019 at 01:54:32PM -0400, Arvind Sankar wrote:
> > > > It doesn't boot with the patch. Won't it go
> > > > 	dma_get_required_mask
> > > > 	-> intel_get_required_mask
> > > > 	-> iommu_need_mapping
> > > > 	-> dma_get_required_mask
> > > > ?
> > > > 
> > > > Should the call to dma_get_required_mask in iommu_need_mapping be
> > > > replaced with dma_direct_get_required_mask on top of your patch?
> > > 
> > > Yes, sorry.
> > 
> > Actually my patch already calls dma_direct_get_required_mask.
> > How did you get the loop?
> 
> The function iommu_need_mapping (not changed by your patch) calls
> dma_get_required_mask internally, to check whether the device's dma_mask
> is big enough or not. That's the call I was asking whether it needs to
> be changed.

Yeah the attached patch seems to fix it.

--ReaqsoxgOBHFXBhH
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-iommu-vt-d-Return-the-correct-dma-mask-when-we-are-b.patch"

From 074e8cc145dde514427c40124913a90c4552dd6e Mon Sep 17 00:00:00 2001
From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Mon, 7 Oct 2019 14:19:12 -0400
Subject: [PATCH] iommu/vt-d: Return the correct dma mask when we are bypassing
 the IOMMU

We must return a mask covering the full physical RAM when bypassing the
IOMMU mapping. Also, in iommu_need_mapping, we need to check using
dma_direct_get_required_mask to ensure that the device's dma_mask can
cover physical RAM before deciding to bypass IOMMU mapping.

Fixes: 249baa547901 ("dma-mapping: provide a better default ->get_required_mask")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/iommu/intel-iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3f974919d3bd..79e35b3180ac 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3471,7 +3471,7 @@ static bool iommu_need_mapping(struct device *dev)
 		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
 			dma_mask = dev->coherent_dma_mask;
 
-		if (dma_mask >= dma_get_required_mask(dev))
+		if (dma_mask >= dma_direct_get_required_mask(dev))
 			return false;
 
 		/*
@@ -3775,6 +3775,13 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	return nelems;
 }
 
+static u64 intel_get_required_mask(struct device *dev)
+{
+	if (!iommu_need_mapping(dev))
+		return dma_direct_get_required_mask(dev);
+	return DMA_BIT_MASK(32);
+}
+
 static const struct dma_map_ops intel_dma_ops = {
 	.alloc = intel_alloc_coherent,
 	.free = intel_free_coherent,
@@ -3787,6 +3794,7 @@ static const struct dma_map_ops intel_dma_ops = {
 	.dma_supported = dma_direct_supported,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
+	.get_required_mask = intel_get_required_mask,
 };
 
 static void
-- 
2.21.0


--ReaqsoxgOBHFXBhH--
