Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5B9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71A7233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566372822;
	bh=+tFf0mJTLo96yTYYqbHdRoumDvEssXCzw62+md2MYD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yv/cHcteyeEGhLsV0Ku7tnusDHtmSLgOnwaPyEPn+RxCt0HeUGkOXMtCjhKalDWVc
	 FjuzoMMbZZX9cm61C07ih1BwZJxSwiqX++8XtRmKs+fCaw1apmE2uHO8zDwcPpgsMt
	 Lyp+EKsf2efTjcshPOFFTCMczmKhyacMt93XyDvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfHUHdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfHUHdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:33:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A347C2332A;
        Wed, 21 Aug 2019 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566372821;
        bh=+tFf0mJTLo96yTYYqbHdRoumDvEssXCzw62+md2MYD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4H1EFiOSPZTcw+U72R+MT/SkRIDDG5NH56gBRfds4Vsj8QWVp5c8syaxCCgU3rYT
         +0SlGG7GQouiQdZ6gYZsgRQmKEaasz1VNv2gdOfR9JwxZjc59DvcXBRHpdZXIXvuPh
         lgySo5SFuMMEijkzIll0PbWBDliFmstTPszklgfM=
Date:   Wed, 21 Aug 2019 08:33:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the iommu tree with the drm-misc tree
Message-ID: <20190821073335.db7wxxznhdnh2aal@willie-the-truck>
References: <20190821141640.7967ddcc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821141640.7967ddcc@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 02:16:40PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommu tree got a conflict in:
> 
>   drivers/gpu/drm/panfrost/panfrost_mmu.c
> 
> between commit:
> 
>   187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
> 
> from the drm-misc tree and commit:
> 
>   a2d3a382d6c6 ("iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->unmap()")
> 
> from the iommu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks. I don't think the conflict is as bad as it looks, there's just
clearly been a lot of changes to this file. The IOMMU changes are all
around the io-pgtable API, so there's an extra 'NULL' argument to
->unmap() and some new TLB invalidation functions in the renamed
'iommu_gather_ops' (now 'iommu_flush_ops').

Will
