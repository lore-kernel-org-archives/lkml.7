Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AF5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34F92075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfE1J1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:27:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:49702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbfE1J1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:27:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77336AE44;
        Tue, 28 May 2019 09:27:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 056F51E3F53; Tue, 28 May 2019 11:27:49 +0200 (CEST)
Date:   Tue, 28 May 2019 11:27:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, jack@suse.cz, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] mm: Move MAP_SYNC to asm-generic/mman-common.h
Message-ID: <20190528092748.GE9607@quack2.suse.cz>
References: <20190528091120.13322-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528091120.13322-1-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-05-19 14:41:20, Aneesh Kumar K.V wrote:
> This enables support for synchronous DAX fault on powerpc
> 
> The generic changes are added as part of
> commit b6fb293f2497 ("mm: Define MAP_SYNC and VM_SYNC flags")
> 
> Without this, mmap returns EOPNOTSUPP for MAP_SYNC with MAP_SHARED_VALIDATE
> 
> Instead of adding MAP_SYNC with same value to
> arch/powerpc/include/uapi/asm/mman.h, I am moving the #define to
> asm-generic/mman-common.h. Two architectures using mman-common.h directly are
> sparc and powerpc. We should be able to consloidate more #defines to
> mman-common.h. That can be done as a separate patch.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Looks good to me FWIW (I don't have much experience with mmap flags and
their peculirarities). So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes from V1:
> * Move #define to mman-common.h instead of powerpc specific mman.h change
> 
> 
>  include/uapi/asm-generic/mman-common.h | 3 ++-
>  include/uapi/asm-generic/mman.h        | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index abd238d0f7a4..bea0278f65ab 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -25,7 +25,8 @@
>  # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
>  #endif
>  
> -/* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
> +/* 0x0100 - 0x40000 flags are defined in asm-generic/mman.h */
> +#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
>  #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
>  
>  /*
> diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
> index 653687d9771b..2dffcbf705b3 100644
> --- a/include/uapi/asm-generic/mman.h
> +++ b/include/uapi/asm-generic/mman.h
> @@ -13,7 +13,6 @@
>  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
> -#define MAP_SYNC	0x80000		/* perform synchronous page faults for the mapping */
>  
>  /* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
>  
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
