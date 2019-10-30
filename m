Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA8B2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="l3ydEFAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfJ3RyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:54:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45134 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfJ3RyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:54:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id y7so2468819edo.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A22yCdXQ4wKxgH4FAev2UDTCLWsAjVrVdIRX9CE3m0o=;
        b=l3ydEFAxhV6GSwc0Uekxe9DWSEGrLEvvsyW2uiGILGo5a5+4/dX/LFaAiiWs3ETJf0
         /alX2ZRFbpNS6xLFBOYB7v9Y9IDIgCWqxQ9zC0fm45MEx2BzDPamEeMFqL1WqWtxK+wD
         NCIm4g+UGf6XE/hQjwN7cmEnrKV/rPqZtQmwuOhw8z3wVvXooRPprO/loxEftX4bEiz0
         v0/iPuZUJ6FUH2Q87CPeRu+woeVSJajyaQrKFchJnzzcez+DiRT2hhGLJI0tMX1+Z3dk
         rolkWrWPYRMnvmwQwfVK3f5IH51jqJmii5XDNJNw8ja5qephOK3CIpwbb3RZcrNWO7nX
         c0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A22yCdXQ4wKxgH4FAev2UDTCLWsAjVrVdIRX9CE3m0o=;
        b=IuvplAQFZ/BOWPE2f/7veQ9HiovugNOSjXzvanFiPGF9gNisDZQld4f6WXpnDVZaME
         3OWkyuGZOjsglXqM9Tj6vH6pj3yl9o8ekMqbXWKtD7iVPgc7/h1GNOh9/SG4cbGKhUZV
         D7D5Dt9Jny6NGFxI157CrVBwMoHboYjFOUBYJL8peEnwLopmAClnY6COICAfVf0JY319
         WQBu9QQxuFWwqBWiLUQLsHSDKfQ8sz8rRKkSWnVmpwNLG6eWgo+u1/O+bJ21IJujj2gs
         BijxxmvuEjVm/aeG3M5Rr5IHZOhMttKimDg5Tpp1D4MgambdLjiaHuF1u04WcD55haBP
         SdYg==
X-Gm-Message-State: APjAAAWqYl3BDkBH88bwy5DtrlD8Zvye0wvQ4jYEbxQupoA1KInwWdYG
        a4J6FqR+V9feca6RbN3IzlJ7tLVHmOFCFF3sOZL3BQ==
X-Google-Smtp-Source: APXvYqwXBr9TvyBOuA23CYTQrGdthPHx6833Rsz1sxp6rOkkNopRuVVjppCyiRTYsh+Pzp3vC6PPHsMO7EdmlYXVe1M=
X-Received: by 2002:a50:9254:: with SMTP id j20mr1136893eda.0.1572458043602;
 Wed, 30 Oct 2019 10:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz> <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz> <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
 <20191030153150.GI31513@dhcp22.suse.cz> <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
 <20191030173123.GK31513@dhcp22.suse.cz>
In-Reply-To: <20191030173123.GK31513@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 30 Oct 2019 13:53:52 -0400
Message-ID: <CA+CK2bA_Cb95mu6XRLy3nnjNoRwMHR2OQuRAPGU-uzPXbBth1g@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 1:31 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 30-10-19 12:53:41, Pavel Tatashin wrote:
> > On Wed, Oct 30, 2019 at 11:31 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Wed 30-10-19 11:20:44, Pavel Tatashin wrote:
> > > > On Wed, Oct 30, 2019 at 10:13 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > [Add Pavel - the email thread starts http://lkml.kernel.org/r/20191030131122.8256-1-vincent.whitchurch@axis.com
> > > > >  but it used your old email address]
> > > > >
> > > > > On Wed 30-10-19 15:02:16, Vincent Whitchurch wrote:
> > > > > > On Wed, Oct 30, 2019 at 02:29:58PM +0100, Michal Hocko wrote:
> > > > > > > On Wed 30-10-19 14:11:22, Vincent Whitchurch wrote:
> > > > > > > > (I noticed this because on my ARM64 platform, with 1 GiB of memory the
> > > > > > > >  first [and only] section is allocated from the zeroing path while with
> > > > > > > >  2 GiB of memory the first 1 GiB section is allocated from the
> > > > > > > >  non-zeroing path.)
> > > > > > >
> > > > > > > Do I get it right that sparse_buffer_init couldn't allocate memmap for
> > > > > > > the full node for some reason and so sparse_init_nid would have to
> > > > > > > allocate one for each memory section?
> > > > > >
> > > > > > Not quite.  The sparsemap_buf is successfully allocated with the correct
> > > > > > size in sparse_buffer_init(), but sparse_buffer_alloc() fails to
> > > > > > allocate the same size from it.
> > > > > >
> > > > > > The reason it fails is that sparse_buffer_alloc() for some reason wants
> > > > > > to return a pointer which is aligned to the allocation size.  But the
> > > > > > sparsemap_buf was only allocated with PAGE_SIZE alignment so there's not
> > > > > > enough space to align it.
> > > > > >
> > > > > > I don't understand the reason for this alignment requirement since the
> > > > > > fallback path also allocates with PAGE_SIZE alignment.  I'm guessing the
> > > > > > alignment is for the VMEMAP code which also uses sparse_buffer_alloc()?
> > > > >
> > > > > I am not 100% sure TBH. Aligning makes some sense when mapping the
> > > > > memmaps to page tables but that would suggest that sparse_buffer_init
> > > > > is using a wrong alignment then. It is quite wasteful to allocate
> > > > > alarge misaligned block like that.
> > > > >
> > > > > Your patch still makes sense but this is something to look into.
> > > > >
> > > > > Pavel?
> > > >
> > > > I remember thinking about this large alignment, as it looked out of
> > > > place to me also.
> > > > It was there to keep memmap in single chunks on larger x86 machines.
> > > > Perhaps it can be revisited now.
> > >
> > > Don't we need 2MB aligned memmaps for their PMD mappings?
> >
> > Yes, PMD_SIZE should be the alignment here. It just does not make
> > sense to align to size.
>
> What about this? It still aligns to the size but that should be
> correctly done to the section size level.
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 72f010d9bff5..ab1e6175ac9a 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -456,8 +456,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
>         if (map)
>                 return map;
>
> -       map = memblock_alloc_try_nid(size,
> -                                         PAGE_SIZE, addr,
> +       map = memblock_alloc_try_nid(size, size, addr,
>                                           MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>         if (!map)
>                 panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
> @@ -474,8 +473,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>  {
>         phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
>         WARN_ON(sparsemap_buf); /* forgot to call sparse_buffer_fini()? */
> +       /*
> +        * Pre-allocated buffer is mainly used by __populate_section_memmap
> +        * and we want it to be properly aligned to the section size - this is
> +        * especially the case for VMEMMAP which maps memmap to PMDs
> +        */
>         sparsemap_buf =
> -               memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> +               memblock_alloc_try_nid_raw(size, section_map_size(),
>                                                 addr,
>                                                 MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>         sparsemap_buf_end = sparsemap_buf + size;

This looks good, I think we should also change alignment in fallback
of vmemmap_alloc_block() to be
section_map_size().

+++ b/mm/sparse-vmemmap.c
@@ -65,9 +65,10 @@ void * __meminit vmemmap_alloc_block(unsigned long
size, int node)
                        warned = true;
                }
                return NULL;
-       } else
-               return __earlyonly_bootmem_alloc(node, size, size,
+       } else {
+               return __earlyonly_bootmem_alloc(node, size, section_map_size(),
                                __pa(MAX_DMA_ADDRESS));
+       }
 }

Pasha


>
> --
> Michal Hocko
> SUSE Labs
