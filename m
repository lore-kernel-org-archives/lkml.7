Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C0EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850FC218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5Tj96r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbfDXOfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:35:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45841 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731322AbfDXOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:35:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so17079372ljd.12;
        Wed, 24 Apr 2019 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dg0jS/e6KyZQfSlGUUgaQ9gBLRxQL95NBWNKL/lRFIQ=;
        b=Z5Tj96r/vtMbuAq0GpwwChB4HPVtU9C2E+BY6DZEtTSlxrGzQmHCLgN5XqCsQ5n1sm
         ued5wfSpySFJPN2UckkJLRwUIHQSBdkECYVoNNwmHowgOMctFRGzCHDwLSIcrn0mjAVh
         apQ62RuB6tm+yq8KODPVlEDBb/bQE1nZhI14pwzrCaYK9aKb6W2wbOCiTVQMcuTe+ckt
         Qo74QfhLhOQzuAsuGhDyOwb0envbiEhSCc0Nv6owgIG/NC7ID0KyxsWSfx1baH/jsAmY
         Qn6W86v2Tlm4i4ISuDZE/Xcao2PCtfk2pq0cNWg5SH3qqCAPibD147ntzbPxgJiYdAGM
         ljYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dg0jS/e6KyZQfSlGUUgaQ9gBLRxQL95NBWNKL/lRFIQ=;
        b=tT9TAUcNsqQhQFrOKX1vUHKNdjczR4coVGDDABcMqbnDMnX3nudWPvdSgq1rYhbcZg
         nHrGDKoZO+GcSh8gZcaFpKHrZFNzOns0H3+1cSmWFeLzjcws9VAXNJ9QXcXSBZqetUbc
         q/+n8oOTHTTzOxbAoPJBEEulQeWNDygUyIoXdRmUKzeojcKJURyAaHBpUyPfI8Hw9beR
         dU5ZuydUkJhy2PP3OmUU75YFHHf6XM/2iRWpsF26XS/LTh2+LkjBFGfg2zdJYMqgdV5O
         NwSZV0k7S0Ywc7eQ158BIXBnthNvaFIwkFCOnR/aGDJnAH5j7CKuvS+txpDGhc1G/xNk
         dB0A==
X-Gm-Message-State: APjAAAUhDp5qMkRM4SPmFaHJnlWeqMCbSoozeeh+5mxnfi6XRAl+aZfI
        5bN/iuVWfCSnmwkK7qINiWU=
X-Google-Smtp-Source: APXvYqzs8a5zlHbh9398lzVKt6Z5xMctYUwPuqtayYy0lMkrwGairYdrpDUIUr5fqklnQcFZxTeW3w==
X-Received: by 2002:a2e:89da:: with SMTP id c26mr17341237ljk.186.1556116514540;
        Wed, 24 Apr 2019 07:35:14 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id j13sm591869lfb.34.2019.04.24.07.35.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 07:35:13 -0700 (PDT)
Date:   Wed, 24 Apr 2019 17:35:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] mips: Print the kernel virtual mem layout on
 debugging
Message-ID: <20190424143510.ahzq2hpdje7iddzm@mobilestation>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
 <20190423224748.3765-11-fancer.lancer@gmail.com>
 <20190424134711.GE6278@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424134711.GE6278@rapoport-lnx>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:47:11PM +0300, Mike Rapoport wrote:
> On Wed, Apr 24, 2019 at 01:47:46AM +0300, Serge Semin wrote:
> > It is useful at least for debugging to have the kernel virtual
> > memory layout printed at boot time so to have the full information
> > about the booted kernel. Make the printing optional and available
> > only when DEBUG_KERNEL config is enabled so not to leak a sensitive
> > kernel information.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  arch/mips/mm/init.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> > 
> > diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> > index bbb196ad5f26..c338bbd03b2a 100644
> > --- a/arch/mips/mm/init.c
> > +++ b/arch/mips/mm/init.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/gfp.h>
> >  #include <linux/kcore.h>
> >  #include <linux/initrd.h>
> > +#include <linux/sizes.h>
> >  
> >  #include <asm/bootinfo.h>
> >  #include <asm/cachectl.h>
> > @@ -56,6 +57,53 @@ unsigned long empty_zero_page, zero_page_mask;
> >  EXPORT_SYMBOL_GPL(empty_zero_page);
> >  EXPORT_SYMBOL(zero_page_mask);
> >  
> > +/*
> > + * Print out the kernel virtual memory layout
> > + */
> > +#define MLK(b, t) (void *)b, (void *)t, ((t) - (b)) >> 10
> > +#define MLM(b, t) (void *)b, (void *)t, ((t) - (b)) >> 20
> > +#define MLK_ROUNDUP(b, t) (void *)b, (void *)t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> > +static void __init mem_print_kmap_info(void)
> > +{
> > +#ifdef CONFIG_DEBUG_KERNEL
> 
> Maybe CONFIG_DEBUG_VM?
> 

Last time I posted this patch Matt suggested to use CONFIG_DEBUG_KERNEL [1].
On the other hand arm platform prints this table unconditionally, but uses %lx
format for low-memory ranges and %p for kernel segments. I even more inclined
in the arm solution. But if selecting between DEBUG_KERNEL and DEBUG_VM I'd
stick with DEBUG_KERNEL, since VM-debug config help text states it is
intended for special performance checks: "Enable this to turn on extended
checks in the virtual-memory system that may impact performance," and
not for memory layout.

-Sergey

[1] https://lkml.org/lkml/2018/2/13/494

> > +	pr_notice("Kernel virtual memory layout:\n"
> > +		  "    lowmem  : 0x%px - 0x%px  (%4ld MB)\n"
> > +		  "      .text : 0x%px - 0x%px  (%4td kB)\n"
> > +		  "      .data : 0x%px - 0x%px  (%4td kB)\n"
> > +		  "      .init : 0x%px - 0x%px  (%4td kB)\n"
> > +		  "      .bss  : 0x%px - 0x%px  (%4td kB)\n"
> > +		  "    vmalloc : 0x%px - 0x%px  (%4ld MB)\n"
> > +#ifdef CONFIG_HIGHMEM
> > +		  "    pkmap   : 0x%px - 0x%px  (%4ld MB)\n"
> > +#endif
> > +		  "    fixmap  : 0x%px - 0x%px  (%4ld kB)\n",
> > +		  MLM(PAGE_OFFSET, (unsigned long)high_memory),
> > +		  MLK_ROUNDUP(_text, _etext),
> > +		  MLK_ROUNDUP(_sdata, _edata),
> > +		  MLK_ROUNDUP(__init_begin, __init_end),
> > +		  MLK_ROUNDUP(__bss_start, __bss_stop),
> > +		  MLM(VMALLOC_START, VMALLOC_END),
> > +#ifdef CONFIG_HIGHMEM
> > +		  MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
> > +#endif
> > +		  MLK(FIXADDR_START, FIXADDR_TOP));
> > +
> > +	/* Check some fundamental inconsistencies. May add something else? */
> > +#ifdef CONFIG_HIGHMEM
> > +	BUILD_BUG_ON(VMALLOC_END < PAGE_OFFSET);
> > +	BUG_ON(VMALLOC_END < (unsigned long)high_memory);
> > +	BUILD_BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) < PAGE_OFFSET);
> > +	BUG_ON((PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE) <
> > +		(unsigned long)high_memory);
> > +#endif
> > +	BUILD_BUG_ON(FIXADDR_TOP < PAGE_OFFSET);
> > +	BUG_ON(FIXADDR_TOP < (unsigned long)high_memory);
> > +#endif /* CONFIG_DEBUG_KERNEL */
> > +}
> > +#undef MLK
> > +#undef MLM
> > +#undef MLK_ROUNDUP
> > +
> >  /*
> >   * Not static inline because used by IP27 special magic initialization code
> >   */
> > @@ -479,6 +527,7 @@ void __init mem_init(void)
> >  	setup_zero_pages();	/* Setup zeroed pages.  */
> >  	mem_init_free_highmem();
> >  	mem_init_print_info(NULL);
> > +	mem_print_kmap_info();
> >  
> >  #ifdef CONFIG_64BIT
> >  	if ((unsigned long) &_text > (unsigned long) CKSEG0)
> > -- 
> > 2.21.0
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
