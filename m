Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B9ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0820873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194858;
	bh=Q6EaTHXUZJ+A9ZOpvEPtSB0LVp/m+g/JevPvkuMDYe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vIWj1KyzgPf5JwSJccgVJicZaHQGTIjI+dav8iyDFOqU/LjoxvNZmGWLF1Sj9zkJx
	 Pfm7oQxxw0LA01+RMPSjKpLjc3dzQSw7Kz/NHDgalpHOvUnTTXJRPxsC6d0qk0KLrQ
	 4tuYLNWmxLxUgLe5tVl8WDLQDXWC0Olgk60nws28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfJPDA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbfJPDA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:00:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA5D20854;
        Wed, 16 Oct 2019 03:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194856;
        bh=Q6EaTHXUZJ+A9ZOpvEPtSB0LVp/m+g/JevPvkuMDYe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qx3o05KJQZGZrN0HgUJI3GmkNWw/R2WGNKL6xxxEPanMo+gX0DLd6aQk0eJOA3wsP
         xDsH36/1uMy6d/v1atqafEYJbtpQKoFXqEFc1chpMzq7pF+9Id5mZLVjbag6n0RV9H
         qmr+pLv4PT5WFRZ+p10cz4nZlcx3EwxnyQNC/Lt8=
Date:   Wed, 16 Oct 2019 04:00:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64: mm: Fix unused variable warning in
 zone_sizes_init
Message-ID: <20191016030051.4di67v6swlkz2wzy@willie-the-truck>
References: <20191015224304.20963-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015224304.20963-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:43:04PM -0700, Nathan Chancellor wrote:
> When building arm64 allnoconfig, CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> get disabled so there is a warning about max_dma being unused.
> 
> ../arch/arm64/mm/init.c:215:16: warning: unused variable 'max_dma'
> [-Wunused-variable]
>         unsigned long max_dma = min;
>                       ^
> 1 warning generated.
> 
> Add an ifdef around the variable to fix this.
> 
> Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/arm64/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 44f07fdf7a59..c3d6657b9942 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -212,7 +212,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	struct memblock_region *reg;
>  	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
>  	unsigned long max_dma32 = min;
> +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA)
>  	unsigned long max_dma = min;
> +#endif

This looks bogus to me :/ You're referring to CONFIG_ZONE_DMA twice, and I
can't see how that symbol even exists on arm64.

Will
