Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B793AC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83165214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552425013;
	bh=H6mm2ohA+0URG/wwkolAH97h2gbYbvKlFEkgkkMVVvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qmV0eiHNyHvr9PU0CZH7LFucKcfIDnYXvcqIUX0mNg4B4nP6oH/AnUmvhvUb1wB6w
	 3oT3yxICK9rWkdzG725StyGxQVzOUfghNE25ehsNsEREmsdAZYGFoWUYZsudVHv0ji
	 TAFIdcRtzKe5e42GQit6fWYgJMh0/sJvH95+31f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCLVKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:10:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:10:11 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCA49E3C;
        Tue, 12 Mar 2019 21:10:09 +0000 (UTC)
Date:   Tue, 12 Mar 2019 14:10:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     catalin.marinas@arm.com, agraf@suse.de, paulus@ozlabs.org,
        benh@kernel.crashing.org, pe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kmemleak: skip scanning holes in the .bss section
Message-Id: <20190312141008.39eca5a0f03aaf2b86178ae9@linux-foundation.org>
In-Reply-To: <20190312191412.28656-1-cai@lca.pw>
References: <20190312191412.28656-1-cai@lca.pw>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 15:14:12 -0400 Qian Cai <cai@lca.pw> wrote:

> The commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
> kvm_tmp[] into the .bss section and then free the rest of unused spaces
> back to the page allocator.
> 
> kernel_init
>   kvm_guest_init
>     kvm_free_tmp
>       free_reserved_area
>         free_unref_page
>           free_unref_page_prepare
> 
> With DEBUG_PAGEALLOC=y, it will unmap those pages from kernel. As the
> result, kmemleak scan will trigger a panic below when it scans the .bss
> section with unmapped pages.
> 
> Since this is done way before the first kmemleak_scan(), just go
> lockless to make the implementation simple and skip those pages when
> scanning the .bss section. Later, those pages could be tracked by
> kmemleak again once allocated by the page allocator. Overall, this is
> such a special case, so no need to make it a generic to let kmemleak
> gain an ability to skip blocks in scan_large_block().
> 
> BUG: Unable to handle kernel data access at 0xc000000001610000
> Faulting instruction address: 0xc0000000003cc178
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA pSeries
> CPU: 3 PID: 130 Comm: kmemleak Kdump: loaded Not tainted 5.0.0+ #9
> REGS: c0000004b05bf940 TRAP: 0300   Not tainted  (5.0.0+)
> NIP [c0000000003cc178] scan_block+0xa8/0x190
> LR [c0000000003cc170] scan_block+0xa0/0x190
> Call Trace:
> [c0000004b05bfbd0] [c0000000003cc170] scan_block+0xa0/0x190 (unreliable)
> [c0000004b05bfc30] [c0000000003cc2c0] scan_large_block+0x60/0xa0
> [c0000004b05bfc70] [c0000000003ccc64] kmemleak_scan+0x254/0x960
> [c0000004b05bfd40] [c0000000003cdd50] kmemleak_scan_thread+0xec/0x12c
> [c0000004b05bfdb0] [c000000000104388] kthread+0x1b8/0x1c0
> [c0000004b05bfe20] [c00000000000b364] ret_from_kernel_thread+0x5c/0x78
> Instruction dump:
> 7fa3eb78 4844667d 60000000 60000000 60000000 60000000 3bff0008 7fbcf840
> 409d00b8 4bfffeed 2fa30000 409e00ac <e87f0000> e93e0128 7fa91840
> 419dffdc
> 

hm, yes, this is super crude.  I guess we can turn it into something
more sophisticated if another caller is identified.

> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -237,6 +237,10 @@ static int kmemleak_skip_disable;
>  /* If there are leaks that can be reported */
>  static bool kmemleak_found_leaks;
>  
> +/* Skip scanning of a range in the .bss section. */
> +static void *bss_hole_start;
> +static void *bss_hole_stop;
> +
>  static bool kmemleak_verbose;
>  module_param_named(verbose, kmemleak_verbose, bool, 0600);
>  
> @@ -1265,6 +1269,18 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
>  }
>  EXPORT_SYMBOL(kmemleak_ignore_phys);
>  
> +/**
> + * kmemleak_bss_hole - skip scanning a range in the .bss section
> + *
> + * @start:	start of the range
> + * @stop:	end of the range
> + */
> +void kmemleak_bss_hole(void *start, void *stop)
> +{
> +	bss_hole_start = start;
> +	bss_hole_stop = stop;
> +}

I'll make this __init.

>  /*
>   * Update an object's checksum and return true if it was modified.
>   */
> @@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
>  
>  	/* data/bss scanning */
>  	scan_large_block(_sdata, _edata);
> -	scan_large_block(__bss_start, __bss_stop);
> +
> +	if (bss_hole_start) {
> +		scan_large_block(__bss_start, bss_hole_start);
> +		scan_large_block(bss_hole_stop, __bss_stop);
> +	} else {
> +		scan_large_block(__bss_start, __bss_stop);
> +	}
> +
>  	scan_large_block(__start_ro_after_init, __end_ro_after_init);
>  
>  #ifdef CONFIG_SMP

