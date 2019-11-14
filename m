Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99ACC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5D62071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VB3pVK1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKNSNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:13:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfKNSNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:13:25 -0500
Received: from zn.tnic (p200300EC2F15E200329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:e200:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 387771EC0C7B;
        Thu, 14 Nov 2019 19:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573755204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RMMUQPDTcsu6g1c7FpfgsbBV1fCLLyImkY6jGIKEhnw=;
        b=VB3pVK1O+9R7OqabyRDeOqzK3UitbpyGeh5FvlhLICud1GlDiMHKEgA27bVtrEO0rBUxRq
        vR3FqYY7eoeLoqPwIZdGZLgViRZSVPY3GFSLnQFQbLefHynHYT9dUhQancxldovy+ey2jJ
        ikiXvx5P6vwE4GBR2idmT5zUrYIaGlI=
Date:   Thu, 14 Nov 2019 19:13:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V3 17/20] x86/iopl: Restrict iopl() permission scope
Message-ID: <20191114181324.GD7222@zn.tnic>
References: <20191113204240.767922595@linutronix.de>
 <20191113210105.369055550@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191113210105.369055550@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:42:57PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The access to the full I/O port range can be also provided by the TSS I/O
> bitmap, but that would require to copy 8k of data on scheduling in the
> task. As shown with the sched out optimization TSS.io_bitmap_base can be
> used to switch the incoming task to a preallocated I/O bitmap which has all
> bits zero, i.e. allows access to all I/O ports.
> 
> Implementing this allows to provide an iopl() emulation mode which restricts
> the IOPL level 3 permissions to I/O port access but removes the STI/CLI
> permission which is coming with the hardware IOPL mechansim.
> 
> Provide a config option to switch IOPL to emulation mode, make it the
> default and while at it also provide an option to disable IOPL completely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> ---
> V3:	Folded the missing NULL pointer check, reduced preempt disable
> 	scope (Ingo)
> 
> V2:	Fixed the 32bit build fail by increasing the cpu entry area size
> 	Move the TSS update out of the iopl() emulation code.
> ---
>  arch/x86/Kconfig                        |   32 +++++++++++
>  arch/x86/include/asm/pgtable_32_types.h |    2 
>  arch/x86/include/asm/processor.h        |   28 +++++++---
>  arch/x86/kernel/cpu/common.c            |    5 +
>  arch/x86/kernel/ioport.c                |   87 ++++++++++++++++++++++----------
>  arch/x86/kernel/process.c               |   28 ++++++----
>  6 files changed, 137 insertions(+), 45 deletions(-)
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1254,6 +1254,38 @@ config X86_VSYSCALL_EMULATION
>  	 Disabling this option saves about 7K of kernel size and
>  	 possibly 4K of additional runtime pagetable memory.
>  
> +choice
> +	prompt "IOPL"
> +	default X86_IOPL_EMULATION
> +
> +config X86_IOPL_EMULATION
> +	bool "IOPL Emulation"
> +	---help---
> +	  Legacy IOPL support is an overbroad mechanism which allows user
> +	  space aside of accessing all 65536 I/O ports also to disable
> +	  interrupts. To gain this access the caller needs CAP_SYS_RAWIO
> +	  capabilities and permission from eventually active security

I think you mean here: s/eventually/potentially/ or so. "eventually" is
one of the false friends. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
