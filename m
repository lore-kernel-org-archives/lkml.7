Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F47EC31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17762085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfFQByq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 21:54:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfFQByp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 21:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0074E3086220;
        Mon, 17 Jun 2019 01:54:45 +0000 (UTC)
Received: from localhost (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56A58619CE;
        Mon, 17 Jun 2019 01:54:43 +0000 (UTC)
Date:   Mon, 17 Jun 2019 09:54:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH v2 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Message-ID: <20190617015441.GA22289@MiWiFi-R3L-srv>
References: <cover.1560546537.git.thomas.lendacky@amd.com>
 <284d3650e2dae50d5645310a8b49664398fe5223.1560546537.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284d3650e2dae50d5645310a8b49664398fe5223.1560546537.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 17 Jun 2019 01:54:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/19 at 09:15pm, Lendacky, Thomas wrote:
> The memory occupied by the kernel is reserved using memblock_reserve()
> in setup_arch(). Currently, the area is from symbols _text to __bss_stop.
> Everything after __bss_stop must be specifically reserved otherwise it
> is discarded. This is not clearly documented.
> 
> Add a new symbol, __end_of_kernel_reserve, that more readily identifies
> what is reserved, along with comments that indicate what is reserved,
> what is discarded and what needs to be done to prevent a section from
> being discarded.
> 
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Lianbo Jiang <lijiang@redhat.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/sections.h | 2 ++
>  arch/x86/kernel/setup.c         | 8 +++++++-
>  arch/x86/kernel/vmlinux.lds.S   | 9 ++++++++-
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
> index 8ea1cfdbeabc..71b32f2570ab 100644
> --- a/arch/x86/include/asm/sections.h
> +++ b/arch/x86/include/asm/sections.h
> @@ -13,4 +13,6 @@ extern char __end_rodata_aligned[];
>  extern char __end_rodata_hpage_align[];
>  #endif
>  
> +extern char __end_of_kernel_reserve[];
> +
>  #endif	/* _ASM_X86_SECTIONS_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 08a5f4a131f5..32eb70625b3b 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -827,8 +827,14 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
>  
>  void __init setup_arch(char **cmdline_p)
>  {
> +	/*
> +	 * Reserve the memory occupied by the kernel between _text and
> +	 * __end_of_kernel_reserve symbols. Any kernel sections after the
> +	 * __end_of_kernel_reserve symbol must be explicity reserved with a
> +	 * separate memblock_reserve() or it will be discarded.
> +	 */
>  	memblock_reserve(__pa_symbol(_text),
> -			 (unsigned long)__bss_stop - (unsigned long)_text);
> +			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
>  
>  	/*
>  	 * Make sure page 0 is always reserved because on systems with
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 0850b5149345..ca2252ca6ad7 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -368,6 +368,14 @@ SECTIONS
>  		__bss_stop = .;
>  	}
>  
> +	/*
> +	 * The memory occupied from _text to here, __end_of_kernel_reserve, is
> +	 * automatically reserved in setup_arch(). Anything after here must be
> +	 * explicitly reserved using memblock_reserve() or it will be discarded
> +	 * and treated as available memory.
> +	 */
> +	__end_of_kernel_reserve = .;
> +
>  	. = ALIGN(PAGE_SIZE);
>  	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
>  		__brk_base = .;
> @@ -382,7 +390,6 @@ SECTIONS
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  
> -	/* Sections to be discarded */
>  	DISCARDS
>  	/DISCARD/ : {
>  		*(.eh_frame)

Looks good to me, thanks. To the series,

Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

