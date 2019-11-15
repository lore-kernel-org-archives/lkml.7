Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE042C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34992072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LAVtUmq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKOXhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:37:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfKOXhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OqKVo0yXVA9lDAxvu1xGTBxEeOj1XJuu88/C73k1zqg=; b=LAVtUmq5UEa4xrfqj4srF9dyX
        SOhHYMx2cjmqFnv6WbWW0CREvpVke6+qYhlCiVggV1Cy9f2BeacQxZmDI61MsnxObGa+DB7Ng2Rdj
        6ivfWYckwDaZZrNGG2uO2jZBTlBpTO7Uw0TDToTFZ+d5397VCQvgor2AUwzRT8Q64RA4nkDyOk3Ot
        MwH3A+WyusaEc2hRVHRxRPz680b5CCCVjiAMDJd+JxC14P53N41x4BmdXff+EfD9/ZqaBpMwAo63u
        HeUyt0CUZH+2I/8T2p1g88DVCoNj2JVH7u01iG8Z3cLzpCI6XUpfG959X57SmGOEoYdDsgQEBpLpL
        hFWu8eRuA==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVl9g-0002xG-Iu; Fri, 15 Nov 2019 23:37:32 +0000
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20191115181957.4e72c0a2@canb.auug.org.au>
 <20191115152352.ddc9539e80b0840d82c7e2db@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b797cde-1320-fa7e-3a71-156c2b0ca6a7@infradead.org>
Date:   Fri, 15 Nov 2019 15:37:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191115152352.ddc9539e80b0840d82c7e2db@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 3:23 PM, Andrew Morton wrote:
> On Fri, 15 Nov 2019 18:19:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> Hi all,
>>
>> [Also reported by Randy Dunlap]
>>
>> After merging the akpm-current tree, today's linux-next build (arm
>> multi_v7_defconfig) failed like this:
>>
>> mm/vmalloc.c: In function '__purge_vmap_area_lazy':
>> mm/vmalloc.c:1286:8: error: 'SHARED_KERNEL_PMD' undeclared (first use in this function)
>>  1286 |   if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
>>       |        ^~~~~~~~~~~~~~~~~
>> mm/vmalloc.c:1286:8: note: each undeclared identifier is reported only once for each function it appears in
>> mm/vmalloc.c:1286:29: error: implicit declaration of function 'boot_cpu_has' [-Werror=implicit-function-declaration]
>>  1286 |   if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
>>       |                             ^~~~~~~~~~~~
>> mm/vmalloc.c:1286:42: error: 'X86_FEATURE_PTI' undeclared (first use in this function)
>>  1286 |   if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
>>       |                                          ^~~~~~~~~~~~~~~
>>
>> Caused by commit
>>
>>   07ef40e149bf ("mm-vmalloc-fix-regression-caused-by-needless-vmalloc_sync_all-fix")
>>
>> SHARED_KERNEL_PMD, boot_cpu_has() and X86_FEATURE_PTI are only defined
>> for X86.
>>
>> I have reverted that commit for today.
> 
> Thanks.  So it has to be an ifdef.

Yes, that works.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> --- a/mm/vmalloc.c~mm-vmalloc-fix-regression-caused-by-needless-vmalloc_sync_all-fix-fix
> +++ a/mm/vmalloc.c
> @@ -1255,17 +1255,17 @@ static bool __purge_vmap_area_lazy(unsig
>  	if (unlikely(valist == NULL))
>  		return false;
>  
> -	if (IS_ENABLED(CONFIG_X86_PAE)) {
> -		/*
> -		 * First make sure the mappings are removed from all page-tables
> -		 * before they are freed.
> -		 *
> -		 * This is only needed on x86-32 with !SHARED_KERNEL_PMD, which
> -		 * is the case on a PAE kernel with PTI enabled.
> -		 */
> -		if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
> -			vmalloc_sync_all();
> -	}
> +#ifdef CONFIG_X86_PAE
> +	/*
> +	 * First make sure the mappings are removed from all pagetables before
> +	 * they are freed.
> +	 *
> +	 * This is only needed on x86-32 with !SHARED_KERNEL_PMD, which is the
> +	 * case on a PAE kernel with PTI enabled.
> +	 */
> +	if (!SHARED_KERNEL_PMD && boot_cpu_has(X86_FEATURE_PTI))
> +		vmalloc_sync_all();
> +#endif
>  
>  	/*
>  	 * TODO: to calculate a flush range without looping.
> _
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
