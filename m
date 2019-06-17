Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF24C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E02020861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ecdcx5xI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfFQLCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:02:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47556 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfFQLCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:02:49 -0400
Received: from zn.tnic (p200300EC2F0613006087DD9CF534030C.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1300:6087:dd9c:f534:30c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 600511EC0249;
        Mon, 17 Jun 2019 13:02:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560769368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OijPc0WWIfdOsltA5SOHD4hbuYIyRTxsd1+8sNjTtHk=;
        b=ecdcx5xI9o4i+Zruw2Jkv8SaWdeKSbRo0kW3W5sAxfi2Mm0yXsU7Svn7y2GNa7OYHm7xj0
        wEov1MZL0HcvVRSFSFGVMzgUgdpBppioXX0ycCOO1wSqtrqV1nVYiVEx7z5dWPG86o2F08
        BLpu0+pEE+e7y0tx1sX3UhXLHjWxhKc=
Date:   Mon, 17 Jun 2019 13:02:41 +0200
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
Subject: Re: [PATCH v2 2/2] x86/mm: Create an SME workarea in the kernel for
 early encryption
Message-ID: <20190617110241.GH27127@zn.tnic>
References: <cover.1560546537.git.thomas.lendacky@amd.com>
 <cdb1fab3558ae11a50c922d8f373c2125c862e10.1560546537.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdb1fab3558ae11a50c922d8f373c2125c862e10.1560546537.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 09:15:19PM +0000, Lendacky, Thomas wrote:
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index ca2252ca6ad7..a7aa65b44c71 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -387,6 +387,30 @@ SECTIONS
>  	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
>  	_end = .;
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * SME workarea section: Lives outside of the kernel proper (_text -
> +	 * _end) for performing in-place encryption of the kernel during boot.
> +	 *
> +	 * Resides after _end because even though the .brk section is after
> +	 * __end_of_kernel_reserve, the .brk section is later reserved as a
> +	 * part of the kernel. It is used in very early boot code and not
> +	 * needed after that, so it is located after __end_of_kernel_reserve
> +	 * so that it will be discarded and become part of the available
> +	 * memory.
> +	 *
> +	 * Resides on a 2MB boundary to simplify the pagetable setup used for
> +	 * the encryption.
> +	 */
> +	. = ALIGN(HPAGE_SIZE);
> +	.sme : AT(ADDR(.sme) - LOAD_OFFSET) {

Should we call that section something more generic as

	.early_scratch

or so?

Someone else might need something like that too, in the future...

Also, the DISCARDS sections do get freed at runtime so why not make it
part of the DISCARD section...?

> +		__sme_begin = .;
> +		*(.sme)
> +		. = ALIGN(HPAGE_SIZE);
> +		__sme_end = .;
> +	}
> +#endif
> +
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 4aa9b1480866..c55c2ec8fb12 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -73,6 +73,19 @@ struct sme_populate_pgd_data {
>  	unsigned long vaddr_end;
>  };
>  
> +/*
> + * This work area lives in the .sme section, which lives outside of
> + * the kernel proper. It is sized to hold the intermediate copy buffer
> + * and more than enough pagetable pages.
> + *
> + * By using this section, the kernel can be encrypted in place and we

replace that "we" with an impartial passive formulation.

Other than that, I like the commenting, very helpful!

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
