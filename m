Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B1CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADBE2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="n73Fs9YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfJ3SXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:23:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38791 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfJ3SXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:23:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id y8so2583285edu.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lxy6IprtXZdN1Ywem6LzRdwBXd8vho1sAHNiae8FLkc=;
        b=n73Fs9YNQtX1WLpOp/DvW7Jo0Rg47SCxO1onvdEWmm0oFIplwMPhi1j369yqnLzedG
         WZWf1Mc/JN7Esy7Vz1u5CuNHu+0okYW1bPkGw1vvcbpSsdCi709aM9D+Fak2qjJi9szW
         jRGyrqqiAVur1HuEJL6zXGspvAVCwHNYNsWsIrnGyHhxy2IXHVjbHVPDhKewKBAxvK2L
         xo6DU9eEYjUk30W9LvA6d3fdjZrJfHkSajP1d7W+S72FyHHAxBRU3joh7LMtUiYpDdGd
         apTtQHWAqRlreFj7iVMuenjFAyQR9xBZZu8ULj8wqEAJj7DOOi9ADLUZftexMeT+JsHo
         nywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lxy6IprtXZdN1Ywem6LzRdwBXd8vho1sAHNiae8FLkc=;
        b=SXnxeGZnn55W+0W9m6wLyngyYODn7WW9Dz8QTSi21wUlVBGA9ndJK7GWCU1f39LYs6
         ksb0iqB+liJ906N5s2FEoNVKKePArHmymbOfi0VArHsanOJ+6mQgWPvgXM5W5+/g72SZ
         1jonEo3ACg83R/Qt5b5p8cTzSwcSDDZiC4mi1sM/zn2PaqllX/2KpT4SDrsOV6d06ThT
         NmtGW1rgkE30vRsNNzgxxZ4/tTwKWFAh978i9re2zCU2LvFE43QhS0g42WIztWfuGebu
         12I6DTDx46ozEO7mF+e+QHGEhddEEXxXG/HAue2QB/S0DmeLEIO6amSTN7n2O+wOFUsr
         YDzw==
X-Gm-Message-State: APjAAAW7ky7MenY0D40VWaUVnOMtgBjtxJELtjeCzJbMzmo+3JH6Tybo
        BesdhtLy/ywAPlzMlj+9imZkxUP0LZUbRLc15okemQ==
X-Google-Smtp-Source: APXvYqy681K0P2BhS9hNV/6IN1RzMU0NYrerzkLLmTAy0ae5W1KTT4HMpsivRJGyqAisB4evXw4J34XHaVMuvtUF2Uo=
X-Received: by 2002:aa7:da10:: with SMTP id r16mr1235278eds.304.1572459800920;
 Wed, 30 Oct 2019 11:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz> <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz> <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
 <20191030153150.GI31513@dhcp22.suse.cz> <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
 <20191030173123.GK31513@dhcp22.suse.cz> <CA+CK2bA_Cb95mu6XRLy3nnjNoRwMHR2OQuRAPGU-uzPXbBth1g@mail.gmail.com>
 <20191030180116.GN31513@dhcp22.suse.cz>
In-Reply-To: <20191030180116.GN31513@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 30 Oct 2019 14:23:10 -0400
Message-ID: <CA+CK2bBuFM9Rdnu4yCQ4NXHCeXMyFFFOn80nfL2q6hVKXGHkOg@mail.gmail.com>
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

On Wed, Oct 30, 2019 at 2:01 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 30-10-19 13:53:52, Pavel Tatashin wrote:
> > On Wed, Oct 30, 2019 at 1:31 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Wed 30-10-19 12:53:41, Pavel Tatashin wrote:
> [...]
> > > > Yes, PMD_SIZE should be the alignment here. It just does not make
> > > > sense to align to size.
> > >
> > > What about this? It still aligns to the size but that should be
> > > correctly done to the section size level.
> > >
> > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > index 72f010d9bff5..ab1e6175ac9a 100644
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -456,8 +456,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
> > >         if (map)
> > >                 return map;
> > >
> > > -       map = memblock_alloc_try_nid(size,
> > > -                                         PAGE_SIZE, addr,
> > > +       map = memblock_alloc_try_nid(size, size, addr,
> > >                                           MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > >         if (!map)
> > >                 panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%pa\n",
> > > @@ -474,8 +473,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> > >  {
> > >         phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
> > >         WARN_ON(sparsemap_buf); /* forgot to call sparse_buffer_fini()? */
> > > +       /*
> > > +        * Pre-allocated buffer is mainly used by __populate_section_memmap
> > > +        * and we want it to be properly aligned to the section size - this is
> > > +        * especially the case for VMEMMAP which maps memmap to PMDs
> > > +        */
> > >         sparsemap_buf =
> > > -               memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> > > +               memblock_alloc_try_nid_raw(size, section_map_size(),
> > >                                                 addr,
> > >                                                 MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > >         sparsemap_buf_end = sparsemap_buf + size;
> >
> > This looks good, I think we should also change alignment in fallback
> > of vmemmap_alloc_block() to be
> > section_map_size().
> >
> > +++ b/mm/sparse-vmemmap.c
> > @@ -65,9 +65,10 @@ void * __meminit vmemmap_alloc_block(unsigned long
> > size, int node)
> >                         warned = true;
> >                 }
> >                 return NULL;
> > -       } else
> > -               return __earlyonly_bootmem_alloc(node, size, size,
> > +       } else {
> > +               return __earlyonly_bootmem_alloc(node, size, section_map_size(),
> >                                 __pa(MAX_DMA_ADDRESS));
> > +       }
> >  }
>
> Are you sure? Doesn't this provide the proper alignement already? Most
> callers do PAGE_SIZE vmemmap_populate_hugepages PMD_SIZE so the
> resulting alignment looks good to me.

Nevermind, you are right. I tracked only one path, and forgot about
the normal PAGE_SIZE path.

Thank you,
Pasha

> --
> Michal Hocko
> SUSE Labs
