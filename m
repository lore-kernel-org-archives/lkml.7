Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A054C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD742084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WcY9RfgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfFQKrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:47:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43280 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfFQKrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:47:49 -0400
Received: from zn.tnic (p200300EC2F0613006087DD9CF534030C.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1300:6087:dd9c:f534:30c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8D151EC0ADE;
        Mon, 17 Jun 2019 12:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560768467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aJyz0+t8hQU2wnjkPp+zeWmP/XrIEe0Ovu0EpKgg8Gg=;
        b=WcY9RfgLaW5ID7xYAAMIDK01dGqOV2MRBThoimU17NZd9dYYwHuQE/xaasZhEol8SZ7FAd
        xBBnGZ95CqGGNiLKOj23m1YYycze1RDlg3d/jB28MnehLQibLNEcx7Ntf6o5T/UL0nofeC
        2/9qOr/V8j0FWPj25AF8t0RfHWsZ5nE=
Date:   Mon, 17 Jun 2019 12:47:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH v2 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Message-ID: <20190617104740.GG27127@zn.tnic>
References: <cover.1560546537.git.thomas.lendacky@amd.com>
 <284d3650e2dae50d5645310a8b49664398fe5223.1560546537.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <284d3650e2dae50d5645310a8b49664398fe5223.1560546537.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 09:15:18PM +0000, Lendacky, Thomas wrote:
> The memory occupied by the kernel is reserved using memblock_reserve()
> in setup_arch(). Currently, the area is from symbols _text to __bss_stop.
> Everything after __bss_stop must be specifically reserved otherwise it
> is discarded. This is not clearly documented.

Hmm, so I see this in arch/x86/kernel/vmlinux.lds.S after _end:

        _end = .;

        STABS_DEBUG
        DWARF_DEBUG

        /* Sections to be discarded */
        DISCARDS
        /DISCARD/ : {
                *(.eh_frame)
        }

and over DISCARDS:

/*
 * Default discarded sections.
 *
 * Some archs want to discard exit text/data at runtime rather than
 * link time due to cross-section references such as alt instructions,
 * bug table, eh_frame, etc.  DISCARDS must be the last of output
 * section definitions so that such archs put those in earlier section
 * definitions.
 */
#define DISCARDS

That sounds like it is documented to me, or do you mean something else?

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

s/it/they/

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

Huh?

They're called DISCARD* ...

>       DISCARDS
>       /DISCARD/ : {
>               *(.eh_frame)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
