Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85946208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jYgWhBde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfHLPK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:10:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfHLPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c3bQwvEBKBc0pEEHbp7FCzV/9a7dwVZ1tfrux53aQUk=; b=jYgWhBdeygmMrmgiIfP4I/TdO
        Ng/+m9UFICPIWdpQpn87luEmnGnHsT0D4NhynrQsF1RI2UO9sd2y58mGBuAP8lole6dISaAFGFo0Y
        7OlXkXD/H/PM0dVsmodbKu5KJVjP7AQMVEeluLGto2VNcV8tM8kZop3KJu8e555pDxu5ip0EMyE16
        gGxzR379ivWAHtliDLkHevf+cc6Ezq88GcRxRCj6unpsXVaBkQYcDZiofRfCq371ReeJTzO/T12Ih
        o55L1GOfElemhDjtVad7hpNu/yr8fLLGpdEwrOKFFDsqstJUVMPlU2waSEdLINCeBu91lyUBCS+rO
        /J4ePhi7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxByE-0001gG-Rz; Mon, 12 Aug 2019 15:10:50 +0000
Date:   Mon, 12 Aug 2019 08:10:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Hu <nickhu@andestech.com>
Cc:     alankao@andestech.com, paul.walmsley@sifive.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, green.hu@gmail.com, deanbo422@gmail.com,
        tglx@linutronix.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, Anup.Patel@wdc.com,
        gregkh@linuxfoundation.org, alexios.zavras@intel.com,
        atish.patra@wdc.com, zong@andestech.com, kasan-dev@googlegroups.com
Subject: Re: [PATCH 2/2] riscv: Add KASAN support
Message-ID: <20190812151050.GJ26897@infradead.org>
References: <cover.1565161957.git.nickhu@andestech.com>
 <88358ef8f7cfcb7fd01b6b989eccaddbe00a1e57.1565161957.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88358ef8f7cfcb7fd01b6b989eccaddbe00a1e57.1565161957.git.nickhu@andestech.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. KASAN can't debug the modules since the modules are allocated in VMALLOC
> area. We mapped the shadow memory, which corresponding to VMALLOC area,
> to the kasan_early_shadow_page because we don't have enough physical space
> for all the shadow memory corresponding to VMALLOC area.

How do other architectures solve this problem?

> @@ -54,6 +54,8 @@ config RISCV
>  	select EDAC_SUPPORT
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select GENERIC_STRNCPY_FROM_USER if KASAN

Is there any reason why we can't always enabled this?  Also just
enabling the generic efficient strncpy_from_user should probably be
a separate patch.

> +	select HAVE_ARCH_KASAN if MMU

Based on your cover letter this should be if MMU && 64BIT

>  #define __HAVE_ARCH_MEMCPY
>  extern asmlinkage void *memcpy(void *, const void *, size_t);
> +extern asmlinkage void *__memcpy(void *, const void *, size_t);
>  
>  #define __HAVE_ARCH_MEMMOVE
>  extern asmlinkage void *memmove(void *, const void *, size_t);
> +extern asmlinkage void *__memmove(void *, const void *, size_t);
> +
> +#define memcpy(dst, src, len) __memcpy(dst, src, len)
> +#define memmove(dst, src, len) __memmove(dst, src, len)
> +#define memset(s, c, n) __memset(s, c, n)

This looks weird and at least needs a very good comment.  Also
with this we effectively don't need the non-prefixed prototypes
anymore.  Also you probably want to split the renaming of the mem*
routines into a separate patch with a proper changelog.

>  #include <asm/tlbflush.h>
>  #include <asm/thread_info.h>
>  
> +#ifdef CONFIG_KASAN
> +#include <asm/kasan.h>
> +#endif

Any good reason to not just always include the header?

> +
>  #ifdef CONFIG_DUMMY_CONSOLE
>  struct screen_info screen_info = {
>  	.orig_video_lines	= 30,
> @@ -64,12 +68,17 @@ void __init setup_arch(char **cmdline_p)
>  
>  	setup_bootmem();
>  	paging_init();
> +
>  	unflatten_device_tree();

spurious whitespace change.

> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 23cd1a9..9700980 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -46,6 +46,7 @@ SECTIONS
>  		KPROBES_TEXT
>  		ENTRY_TEXT
>  		IRQENTRY_TEXT
> +		SOFTIRQENTRY_TEXT

Hmm.  What is the relation to kasan here?  Maybe we should add this
separately with a good changelog?

> +++ b/arch/riscv/mm/kasan_init.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0

This probably also wants a copyright statement.

> +	// init for swapper_pg_dir

Please use /* */ style comments.
