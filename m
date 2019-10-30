Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFF6CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC802067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IesVa9hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfJ3Qxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:53:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44456 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfJ3Qxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:53:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id b18so2306385edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3oE/ISsN3ohvMo3fk8k+NX9SYpKGHbEZ6iLVbVyFVc=;
        b=IesVa9hsEguoPZy/yb2OyqBsFEkMFaGJSJq2dKpJLyz71ld3bo+FYdCtGXLsxe2bC6
         SgwVKsezUheR8h7+ENUMvD3MbHEyy+buDEXnEW1M+sEsiL16yK4Xqt3JXn9MbKBUtkcS
         gNZ6wAZA6qhFRR5qkO5zYqvxJeXCycnT6Z9lMEfo1ZIiIAesJ9uU7z6m8fz2e0/WcNgY
         TLkhSbMV3s/OVu1e7TomgS5jaPKerHIJxwxpxFmc4U6kK+H4Np6BC+aEe59GdxXTc3/z
         uGkr7wCN1vSd8D/f32EAKt7Bf8HM1CpPMXPA45OSIBHKcNAbERYmzVlzoFWFHWADqpmb
         x6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3oE/ISsN3ohvMo3fk8k+NX9SYpKGHbEZ6iLVbVyFVc=;
        b=Hd0EajuQSSv0YI1MZVXgm++2E2XEdoq4RPAnqR1YyyNVKmt5LoYEgiOKaubSOL+Xdl
         sYkpRIe/1hzj/Fk9rzf6lPEoHqzigESWIXkw0SBuvW87Kt7yljGjiHzaJuYzWUU+lmHe
         QGGQQqAU7tlVUSX3SEPAVCaPq1N8I5nxdQtEheqiRv9G8YcIbNdUlQk2q+UZf53Mgn0l
         0Kwj8G0SxYyjqk9OKu+etR+RB3ugH8DPNKQpWfTtBFkqyduSLipv60vUBqg8gcFxJjdB
         wfXqP76+Y2RsQJDql1l5XnwWKlNog/VDU7kPdPooD+AAdi/7l25jDLXYe+oL8t7Uv3XQ
         lTSQ==
X-Gm-Message-State: APjAAAUaufGVd8wbeDwdyBBYFWpC/xz0FUYbM1QaADtoBXHawDD4lInv
        VTscoIpp3cT8Sy+yytP5gnUNkhM/BI6RH3Iiuui+EviMFlg=
X-Google-Smtp-Source: APXvYqxNsw9zcuj+j7gJs36T9DxM3B6SwIzt9nkI+9LU16RSzOKN/Hdgn4Ial9Pfw9qQdWzlYR6q9GlUgEucyPE0964=
X-Received: by 2002:aa7:d305:: with SMTP id p5mr774920edq.80.1572454432421;
 Wed, 30 Oct 2019 09:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz> <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz> <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
 <20191030153150.GI31513@dhcp22.suse.cz>
In-Reply-To: <20191030153150.GI31513@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 30 Oct 2019 12:53:41 -0400
Message-ID: <CA+CK2bA3gM4pMSj-wDWgAPNoPtcjwd59_6VivKA2Uf2GriASsw@mail.gmail.com>
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

On Wed, Oct 30, 2019 at 11:31 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 30-10-19 11:20:44, Pavel Tatashin wrote:
> > On Wed, Oct 30, 2019 at 10:13 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > [Add Pavel - the email thread starts http://lkml.kernel.org/r/20191030131122.8256-1-vincent.whitchurch@axis.com
> > >  but it used your old email address]
> > >
> > > On Wed 30-10-19 15:02:16, Vincent Whitchurch wrote:
> > > > On Wed, Oct 30, 2019 at 02:29:58PM +0100, Michal Hocko wrote:
> > > > > On Wed 30-10-19 14:11:22, Vincent Whitchurch wrote:
> > > > > > (I noticed this because on my ARM64 platform, with 1 GiB of memory the
> > > > > >  first [and only] section is allocated from the zeroing path while with
> > > > > >  2 GiB of memory the first 1 GiB section is allocated from the
> > > > > >  non-zeroing path.)
> > > > >
> > > > > Do I get it right that sparse_buffer_init couldn't allocate memmap for
> > > > > the full node for some reason and so sparse_init_nid would have to
> > > > > allocate one for each memory section?
> > > >
> > > > Not quite.  The sparsemap_buf is successfully allocated with the correct
> > > > size in sparse_buffer_init(), but sparse_buffer_alloc() fails to
> > > > allocate the same size from it.
> > > >
> > > > The reason it fails is that sparse_buffer_alloc() for some reason wants
> > > > to return a pointer which is aligned to the allocation size.  But the
> > > > sparsemap_buf was only allocated with PAGE_SIZE alignment so there's not
> > > > enough space to align it.
> > > >
> > > > I don't understand the reason for this alignment requirement since the
> > > > fallback path also allocates with PAGE_SIZE alignment.  I'm guessing the
> > > > alignment is for the VMEMAP code which also uses sparse_buffer_alloc()?
> > >
> > > I am not 100% sure TBH. Aligning makes some sense when mapping the
> > > memmaps to page tables but that would suggest that sparse_buffer_init
> > > is using a wrong alignment then. It is quite wasteful to allocate
> > > alarge misaligned block like that.
> > >
> > > Your patch still makes sense but this is something to look into.
> > >
> > > Pavel?
> >
> > I remember thinking about this large alignment, as it looked out of
> > place to me also.
> > It was there to keep memmap in single chunks on larger x86 machines.
> > Perhaps it can be revisited now.
>
> Don't we need 2MB aligned memmaps for their PMD mappings?

Yes, PMD_SIZE should be the alignment here. It just does not make
sense to align to size.

Pasha
