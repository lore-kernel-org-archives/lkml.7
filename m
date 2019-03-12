Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B230214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ihgNATVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCLTTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:19:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39660 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfCLTTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:19:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so3934434qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fc9YZuIzh6N9HjS8mAKym/k4q5CUcO4B2pCsB919vh0=;
        b=ihgNATVjmlS9eNRpEE+MQmgRwKesa0sr/AEe9v3ZyUlT0D1vTxqICgOyMyi9AyLGCW
         qrhpMT4xIseDx4yBztt98RXbnNv1R2gIo7Z3gJavJRc1a3POX780RlD+EaZoghASSVFu
         8j/c/1mT5FL7twSOBKh01awSA9+NFwy6X7XT2y//VsweODx5JzKljV4CpWcW4hZ/ZSvx
         RAWOvUvmdfCW3p4HhCgXZ4RQbJAQhq5Anyxruf/nZwng/lxax30u/f2gkxnUh28eR8gO
         d5JA9Xq0bhPRGINbNQ4lO4Deo0ETIk25AbOJh7AsxaopnvmIv5Pzfk8628lipKB+1IDG
         187Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fc9YZuIzh6N9HjS8mAKym/k4q5CUcO4B2pCsB919vh0=;
        b=mRilvv8MRFzA0c/ckbbFStVlQKqPbSfhhcnwYbdhbZkm9Ns+mI6kbAm3kg/8iDaT1R
         iRKWyClGDRRUHSc6HBlXSzeJBPZmEvLFzMUFSWxbdMa6DWu5FwmgepIY3PoZIx+XAxpz
         6P57CDgx4QWKH67IT7ebpOXtQGgCs7uqfXpj6PWlAZhRu3PzuCh9laAPbe7Rl2/iDnzJ
         xrDsFU+MAl/qnEo++5aQGqseNQAgNGY+bTWTMmytQORabKy/tdAlDpoZZGxY0S2o0iGV
         RskOoh1J89Uuk56QYU5NulPii243EIqwIz/gDckJ7VWjur4SiWmnN4TgvMjlmOLKUgZt
         sRtg==
X-Gm-Message-State: APjAAAWmjyqpCw6Yqpuhhe2VL77gL6PGX4Xyv4O3QMhLn+iiflbJHc5B
        Lf2T4PGg6r4b5Lqvg1u9+xE/yOPVhEE=
X-Google-Smtp-Source: APXvYqxduyXOPKXauvGcg5CmEA1uBSzc0dkaSOQAssQYeG1T6kX5lyI5h4vsIwV0RBj4VEZXvx02yg==
X-Received: by 2002:ac8:1aa6:: with SMTP id x35mr32098263qtj.218.1552418393237;
        Tue, 12 Mar 2019 12:19:53 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w37sm5075030qtw.27.2019.03.12.12.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 12:19:52 -0700 (PDT)
Message-ID: <1552418391.26196.1.camel@lca.pw>
Subject: Re: [PATCH] kmemleak: skip scanning holes in the .bss section
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 12 Mar 2019 15:19:51 -0400
In-Reply-To: <20190312191412.28656-1-cai@lca.pw>
References: <20190312191412.28656-1-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing some email addresses.

On Tue, 2019-03-12 at 15:14 -0400, Qian Cai wrote:
> The commit 2d4f567103ff ("KVM: PPC: Introduce kvm_tmp framework") adds
> kvm_tmp[] into the .bss section and then free the rest of unused spaces
> back to the page allocator.
> 
> kernel_init
>   kvm_guest_init
>     kvm_free_tmp
>       free_reserved_area
>         free_unref_page
>           free_unref_page_prepare
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
> REGS: c0000004b05bf940 TRAP: 0300   Not tainted  (5.0.0+)
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
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/powerpc/kernel/kvm.c |  3 +++
>  include/linux/kmemleak.h  |  4 ++++
>  mm/kmemleak.c             | 25 ++++++++++++++++++++++++-
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index 683b5b3805bd..5cddc8fc56bb 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/pagemap.h>
> +#include <linux/kmemleak.h>
>  
>  #include <asm/reg.h>
>  #include <asm/sections.h>
> @@ -712,6 +713,8 @@ static void kvm_use_magic_page(void)
>  
>  static __init void kvm_free_tmp(void)
>  {
> +	kmemleak_bss_hole(&kvm_tmp[kvm_tmp_index],
> +			  &kvm_tmp[ARRAY_SIZE(kvm_tmp)]);
>  	free_reserved_area(&kvm_tmp[kvm_tmp_index],
>  			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
>  }
> diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
> index 5ac416e2d339..3d8949b9c6f5 100644
> --- a/include/linux/kmemleak.h
> +++ b/include/linux/kmemleak.h
> @@ -46,6 +46,7 @@ extern void kmemleak_alloc_phys(phys_addr_t phys, size_t
> size, int min_count,
>  extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
>  extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
>  extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
> +extern void kmemleak_bss_hole(void *start, void *stop);
>  
>  static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
>  					    int min_count, slab_flags_t
> flags,
> @@ -131,6 +132,9 @@ static inline void kmemleak_not_leak_phys(phys_addr_t
> phys)
>  static inline void kmemleak_ignore_phys(phys_addr_t phys)
>  {
>  }
> +static inline void kmemleak_bss_hole(void *start, void *stop)
> +{
> +}
>  
>  #endif	/* CONFIG_DEBUG_KMEMLEAK */
>  
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 707fa5579f66..42349cd9ef7a 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -237,6 +237,10 @@ static int kmemleak_skip_disable;
>  /* If there are leaks that can be reported */
>  static bool kmemleak_found_leaks;
>  
> +/* Skip scanning of a range in the .bss section. */
> +static void *bss_hole_start;
> +static void *bss_hole_stop;
> +
>  static bool kmemleak_verbose;
>  module_param_named(verbose, kmemleak_verbose, bool, 0600);
>  
> @@ -1265,6 +1269,18 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
>  }
>  EXPORT_SYMBOL(kmemleak_ignore_phys);
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
> +
>  /*
>   * Update an object's checksum and return true if it was modified.
>   */
> @@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
>  
>  	/* data/bss scanning */
>  	scan_large_block(_sdata, _edata);
> -	scan_large_block(__bss_start, __bss_stop);
> +
> +	if (bss_hole_start) {
> +		scan_large_block(__bss_start, bss_hole_start);
> +		scan_large_block(bss_hole_stop, __bss_stop);
> +	} else {
> +		scan_large_block(__bss_start, __bss_stop);
> +	}
> +
>  	scan_large_block(__start_ro_after_init, __end_ro_after_init);
>  
>  #ifdef CONFIG_SMP
