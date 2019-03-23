Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ACCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E2C218B0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCWTCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:02:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42708 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfCWTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:02:37 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7luT-0006MN-2v; Sat, 23 Mar 2019 20:02:25 +0100
Date:   Sat, 23 Mar 2019 20:02:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
cc:     linux-kernel@vger.kernel.org, Craig Bergstrom <craigb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Sean Young <sean@mess.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/1] x86/mm: Fix limit mmap() of /dev/mem to valid physical
 addresses
In-Reply-To: <20190318224653.26549-2-rcampbell@nvidia.com>
Message-ID: <alpine.DEB.2.21.1903231840100.1798@nanos.tec.linutronix.de>
References: <20190318224653.26549-1-rcampbell@nvidia.com> <20190318224653.26549-2-rcampbell@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ralph,

On Mon, 18 Mar 2019, rcampbell@nvidia.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> If CONFIG_DEBUG_VIRTUAL is enabled, a read or write to /dev/mem can
> trigger a VIRTUAL_BUG_ON() depending on the value of high_memory.
> For example:
> 
> read_mem()
>   valid_phys_addr_range(p=401f1550, count=8)
>     __pa(high_memory)
>       __phys_addr(x=ffffc88000000000)
>         // __START_KERNEL_map = ffffffff80000000
>         // y = ffffc88000000000 - ffffffff80000000
>         VIRTUAL_BUG_ON(phys_addr_valid(400000000000))
>           // boot_cpu_data.x86_phys_bits=46

I have no idea why all the irrelevant information in this example would be
helpful, but after extracting the meat I think I know what you want to say.

> Since by design high_memory is outside the range of valid physical
> addresses, use the non-error checking version __pa_nodebug(high_memory).

high_memory is not outside the range of valid physical addresses by
design. It's only outside when memory is populated right at the end of the
physical address space.

So what you really want to say in the changelog is:

 valid_phys_addr_range() is used to sanity check the physical address range
 of an operation, e.g. access to /dev/mem. It uses __pa(high_memory)
 internally.
 
 If memory is populated at the end of the physical address space, then
 __pa(high_memory) is outside of the physical address space because:

     high_memory = (void *)__va(max_pfn * PAGE_SIZE - 1) + 1;

 For the comparison in valid_phys_addr_range() this is not an issue, but if
 CONFIG_DEBUG_VIRTUAL is enabled, __pa() maps to __phys_addr(), which
 verifies that the resulting physical address is within the valid physical
 address space of the CPU. So in the case that memory is populated at the
 end of the physical address space, this is not true and triggers a
 VIRTUAL_BUG_ON().

 Use ... instead, because ...

> Fixes: be62a32044061cb4a3b70a10598e093f1319102e ("x86/mm: Limit mmap() of

Please limit the sha1 to the first 12 characters.

> /dev/mem to valid physical addresses")
>

No newline between Fixes and the rest please.

> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -230,7 +230,7 @@ bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
>  /* Can we access it for direct reading/writing? Must be RAM: */
>  int valid_phys_addr_range(phys_addr_t addr, size_t count)
>  {
> -	return addr + count <= __pa(high_memory);
> +	return addr + count <= __pa_nodebug(high_memory);

This lacks a comment. Aside of that I think there is no point in using
__pa(high_memory) here. This is all about the physical address range. So
this can be simply expressed via:

	return addr + count <= max_pfn * PAGE_SIZE;

which is much more obvious.

Thanks,

	tglx
