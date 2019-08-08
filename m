Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF03C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4DC2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RtAidmmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfHHL6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:58:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38433 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfHHL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:58:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so55660360edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mhO+hgPBV+VLoBe4FkLMr7mrrkAfMlf4RoVKrIDPI8U=;
        b=RtAidmmqIIva4EOO0Ms7+a5chcAGS7/yKnSnvq39J/g3vx0a+JVWFjbQb+KC211qET
         loJwSr4SQzfx6oDGn37n+bXY3zmhi4MoYZmqdkOMwoDDYZqyyWd+XO5simV3pT/raCp2
         F90mSqfkHi4PKIqiR/ORYKx+1b/TTuD7ygW1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mhO+hgPBV+VLoBe4FkLMr7mrrkAfMlf4RoVKrIDPI8U=;
        b=LE8+pByW9ybKJODPj7xbvN8/KOUhOYPFpIF/hf+XMefkUinjQZuebFxCmelBN8NIvo
         5qcj2uuyhfsUFdb3KCVTksjhbusigjxpwt4dpzR0oXN0XAG0+nliIe6szYC3xYkw5AmQ
         PVG9MXNb0Uhmac3j6YOiQOG2K3eLKRvd/j3YOByv7zY82swgaPkpeBBZBJJnLaw8op3W
         9RKRDR0Dc5ciEu/YsyoDenXmVxXWx/cQvidjnM6Cl8AoKMif2pm14kXsinocWBuGgJFg
         rSghZBlF/ixPPI8Ck2k8K9pUv4cNjd9ocPVBCatSQXDVMxxTmCgz1KnFCm38EPMn1c4A
         g/Cg==
X-Gm-Message-State: APjAAAVh/P6gn03uoXPNyXt3CRBnTV+y+B4tvHHz5VVK8oD1iLwOQy2B
        pICXHQlliIfz+fsFe6vmdVUsqg==
X-Google-Smtp-Source: APXvYqw9uraKM7qWqZW0Dg09fB6Nm02V7GB56xhaxehSuiymr4qKYwchHDPZ5RvXrNR5LEVxCZukiQ==
X-Received: by 2002:a17:906:ccc3:: with SMTP id ot3mr13167350ejb.113.1565265491478;
        Thu, 08 Aug 2019 04:58:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d12sm21361343edp.16.2019.08.08.04.58.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 04:58:10 -0700 (PDT)
Date:   Thu, 8 Aug 2019 13:58:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190808115808.GN7444@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Rob Clark <robdclark@chromium.org>, Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190805211451.20176-1-robdclark@gmail.com>
 <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806155044.GC25050@lst.de>
 <CAJs_Fx6uztwDy2PqRy3Tc9p12k8r_ovS2tAcsMV6HqnAp=Ggug@mail.gmail.com>
 <20190807062545.GF6627@lst.de>
 <CAKMK7uH1O3q8VUftikipGH6ACPoT-8tbV1Zwo-8WL=wUHiqsoQ@mail.gmail.com>
 <20190808095506.GA32621@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808095506.GA32621@lst.de>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:55:06AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 07, 2019 at 10:48:56AM +0200, Daniel Vetter wrote:
> > >    other drm drivers how do they guarantee addressability without an
> > >    iommu?)
> > 
> > We use shmem to get at swappable pages. We generally just assume that
> > the gpu can get at those pages, but things fall apart in fun ways:
> > - some setups somehow inject bounce buffers. Some drivers just give
> > up, others try to allocate a pool of pages with dma_alloc_coherent.
> > - some devices are misdesigned and can't access as much as the cpu. We
> > allocate using GFP_DMA32 to fix that.
> 
> Well, for shmem you can't really call allocators directly, right?

We can pass gfp flags to shmem_read_mapping_page_gfp, which is just about
enough for the 2 cases on intel platforms where the gpu can only access
4G, but the cpu has way more.

> One thing I have in my pipeline is a dma_alloc_pages API that allocates
> pages that are guaranteed to be addressably by the device or otherwise
> fail.  But that doesn't really help with the shmem fs.

Yeah, the other drivers where the shmem gfp trick doesn't work copy
back&forth between the dma-able pages and the shmem swappable pages as
needed in their shrinker/allocation code. I guess ideal would be if we
could fuse the custom allocator somehow directly into shmem.

Otoh once you start thrashing beyond system memory for gfx workloads it's
pretty hopeless anyway, and speed doesn't really matter anymore.

> > Also modern gpu apis pretty much assume you can malloc() and then use
> > that directly with the gpu.
> 
> Which is fine as long as the GPU itself supports full 64-bit addressing
> (or always sits behind an iommu), and the platform doesn't impose
> addressing limit, which unfortunately some that are shipped right now
> still do :(

Yes, the userspace api people in khronos are occasionally a bit optimistic
:-)

> But userspace malloc really means dma_map_* anyway, so not really
> relevant for memory allocations.

It does tie in, since we'll want a dma_map which fails if a direct mapping
isn't possible. It also helps the driver code a lot if we could use the
same low-level flushing functions between our own memory (whatever that
is) and anon pages from malloc. And in all the cases if it's not possible,
we want a failure, not elaborate attempts at hiding the differences
between all possible architectures out there.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
