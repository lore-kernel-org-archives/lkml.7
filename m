Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D49F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GsP1PSkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbfC0SWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:22:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403816AbfC0SWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p7uJNRLkzeeNJQDM4SyzmPlQbirmlbL45c4zuRXPsDc=; b=GsP1PSkKCM3pKHBQoPlZ6U28O
        p7kN3WPwHv2Ayga/YUdwllSSRNfrRZDjXDr6XKNHjs72DF8Bq71fI7ZJ5tqFi8MTOO+xsM6nvRqEt
        yphYGTt3bEDJAUcNFhtBV50f4zqN9fzKU9pyTlijQCa+r5YDvSvtZjz1e4EkPCQG5GrreXvXQBDwv
        rGhTGKVG545O5Gx1e9+8nIQyoP/5Hjg/mFm/V/gatooBIn2wADh+sz8/qcqinBr91u+VLItmb6kWb
        StTLEYhh50ngqYJ9fhOZhgCmFzZgBAYd9ZsyVBZtXNJqEm6AMp185aMwJaTHmYhc5wgPihAYpuiq3
        39u185IDg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9DBW-0001Q1-GP; Wed, 27 Mar 2019 18:21:58 +0000
Date:   Wed, 27 Mar 2019 11:21:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190327182158.GS10344@bombadil.infradead.org>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
 <20190327172955.GB17247@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327172955.GB17247@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 05:29:57PM +0000, Catalin Marinas wrote:
> On Wed, Mar 27, 2019 at 09:44:32AM +0100, Michal Hocko wrote:
> > As long as there is an implicit __GFP_NOFAIL then kmemleak is simply
> > broken no matter what other gfp flags you play with. Has anybody looked
> > at some sort of preallocation where gfpflags_allow_blocking context
> > allocate objects into a pool that non-sleeping allocations can eat from?
> 
> Quick attempt below and it needs some more testing (pretty random pick
> of the EMERGENCY_POOL_SIZE value). Also, with __GFP_NOFAIL removed, are
> the other flags safe or we should trim them further?

Why not use mempool?

>  #define gfp_kmemleak_mask(gfp)	(((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
>  				 __GFP_NORETRY | __GFP_NOMEMALLOC | \
> -				 __GFP_NOWARN | __GFP_NOFAIL)
> +				 __GFP_NOWARN)

Why GFP_NORETRY?  And if I have specified one of the other retry policies
in my gfp flags, you should presumably clear that off before setting
GFP_NORETRY.

