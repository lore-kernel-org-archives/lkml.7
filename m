Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0207C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484D2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565801436;
	bh=rr5Yx5jWWXjv1elleVvNixlj9ZG6FWWLR96+BvLKJTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z0iW2YGCd2kwM/XUIif9cUU9JfX+9kjtXgo/qWeDg1mF1unbeY93hyo6ERufS0TX9
	 ze5fon9a33rC4vEBN3eht2ouiXXe+I9nI22iwanNqr1suQcXWzdcjGGC63gt07qfru
	 cUNO0IAEg+CpYWIwdktneXShMjCNMmNzYsUg3bbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfHNQuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfHNQuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:50:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9E3620665;
        Wed, 14 Aug 2019 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565801434;
        bh=rr5Yx5jWWXjv1elleVvNixlj9ZG6FWWLR96+BvLKJTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zBfq3Ps7UwSWeCBHg3Nhawrm70s4X1Ue1TkGDjnU3dH4GLcUTa5FVXhY96bYLfpB8
         tRUlGr9jER91hBRTzXAdKwH74CVEhNn+wG6BowZd/CrQDTszU23WMSsrbNDPq+QLAt
         Vf28F+ZsRzV3ndHNS3F6DKCdEHuQm7I+TYv2MDF0=
Date:   Wed, 14 Aug 2019 17:50:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: unexport set_memory_x and set_memory_nx
Message-ID: <20190814165029.yfmpopn34vxpnmte@willie-the-truck>
References: <20190813090146.26377-1-hch@lst.de>
 <20190813090146.26377-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813090146.26377-2-hch@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:01:41AM +0200, Christoph Hellwig wrote:
> No module currently messed with clearing or setting the execute
> permission of kernel memory, and none really should.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/mm/pageattr.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 03c53f16ee77..9ce7bd9d4d9c 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -128,7 +128,6 @@ int set_memory_nx(unsigned long addr, int numpages)
>  					__pgprot(PTE_PXN),
>  					__pgprot(0));
>  }
> -EXPORT_SYMBOL_GPL(set_memory_nx);
>  
>  int set_memory_x(unsigned long addr, int numpages)
>  {
> @@ -136,7 +135,6 @@ int set_memory_x(unsigned long addr, int numpages)
>  					__pgprot(0),
>  					__pgprot(PTE_PXN));
>  }
> -EXPORT_SYMBOL_GPL(set_memory_x);

arm64 allmodconfig and defconfig are happy with this, so I'll pick it up
for 5.4 if that's ok with you?

Will
