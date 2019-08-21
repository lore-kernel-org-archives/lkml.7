Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347D5C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D292339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566402590;
	bh=BZ4tsVVE8eVOOxdzgMCo8Z11/xvYaSj85B5Wg6POF9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iQzec3JAXC8XzP5gzqe/E6oBZtxUSis2dq3qJu28p1ichlpcPoGyYZybvcxVxDrGV
	 v5dzFj1UiPZbutH4lXxl54rijC9oibY2fqG02S6CLbEOvt2fKi17pdgpRldJpGF9I2
	 2F/406XRH6YOI47btigx4ou5F7aNY1nlb1oasMhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfHUPtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbfHUPts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:49:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C361922DA7;
        Wed, 21 Aug 2019 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566402587;
        bh=BZ4tsVVE8eVOOxdzgMCo8Z11/xvYaSj85B5Wg6POF9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3eFteCqRTqRIOtU/Fg4d0rBnyDcEYHwf3i2H+M85YKQICqt8jXw7PE/EYSVRAqyh
         2TNu2I0Xa9lsCwasUN1jQxxMvCi9rybb/JHZ6m1SJqM0aJLG+mayeTwkC1QmPd0LUc
         Zu1cS45GMImuV+iGffJeeFEgTrLSM2TFO6vbZERQ=
Date:   Wed, 21 Aug 2019 16:49:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: consolidate pgtable_cache_init() and pgd_cache_init()
Message-ID: <20190821154942.js4u466rolnekwmq@willie-the-truck>
References: <1566400018-15607-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566400018-15607-1-git-send-email-rppt@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:06:58PM +0300, Mike Rapoport wrote:
> Both pgtable_cache_init() and pgd_cache_init() are used to initialize kmem
> cache for page table allocations on several architectures that do not use
> PAGE_SIZE tables for one or more levels of the page table hierarchy.
> 
> Most architectures do not implement these functions and use __week default
> NOP implementation of pgd_cache_init(). Since there is no such default for
> pgtable_cache_init(), its empty stub is duplicated among most
> architectures.
> 
> Rename the definitions of pgd_cache_init() to pgtable_cache_init() and drop
> empty stubs of pgtable_cache_init().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---

[...]

> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> index 7548f9c..4a64089 100644
> --- a/arch/arm64/mm/pgd.c
> +++ b/arch/arm64/mm/pgd.c
> @@ -35,7 +35,7 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  		kmem_cache_free(pgd_cache, pgd);
>  }
>  
> -void __init pgd_cache_init(void)
> +void __init pgtable_cache_init(void)
>  {
>  	if (PGD_SIZE == PAGE_SIZE)
>  		return;

[...]

> diff --git a/init/main.c b/init/main.c
> index b90cb5f..2fa8038 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -507,7 +507,7 @@ void __init __weak mem_encrypt_init(void) { }
>  
>  void __init __weak poking_init(void) { }
>  
> -void __init __weak pgd_cache_init(void) { }
> +void __init __weak pgtable_cache_init(void) { }
>  
>  bool initcall_debug;
>  core_param(initcall_debug, initcall_debug, bool, 0644);
> @@ -565,7 +565,6 @@ static void __init mm_init(void)
>  	init_espfix_bsp();
>  	/* Should be run after espfix64 is set up. */
>  	pti_init();
> -	pgd_cache_init();
>  }

AFAICT, this change means we now initialise our pgd cache before
debug_objects_mem_init() has run. Is that going to cause fireworks with
CONFIG_DEBUG_OBJECTS when we later free a pgd?

Will
