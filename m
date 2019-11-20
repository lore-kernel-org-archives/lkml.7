Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57168C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31189223B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574236337;
	bh=Ub9SM4/PD/5Re2yrL92/LT0TlmMSG6imRrqXXC9T7uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r9irjWweMsWfKy+xEOgSUfUvTaX7X9k+hz6Fx/sKqLccpD4tcNniMvuoiexv6kNXr
	 A2q2UbXhrdMzSFLccEo1dH7lz8bJu5Y9RcvsG491pGXUQULPNFVY3mkmOsqaIs+fl/
	 GT8tkWUYjb1zZIyBCjfOBtMl42ZEdHf/fhMngULc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfKTHwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 02:52:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41376 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKTHwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 02:52:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so25468504wrj.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 23:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SuCP5JTI0E4nMP2UPf/N4wvDe3O4fmtrt4QcYh19UfQ=;
        b=OEXa5Z+Lwm0xTDaCT/T+TeOZiOjFm4L3T9fV44vWc+I8PXT/sFJw5HYYFp59ivfsGF
         5krk5fPj4nkdGTkMrsEDckphZdEWylWFDDtKCkp/2fkHNfNgJ6J6YBFEoAKx7wake7NQ
         LXZBb4cHyEMD3AyzEw250yXGQn+L6/4ViPxWjb3sJ8yvTL8AJHk0b3Bj9NGybFqNpLyC
         gd0Og1jPFQLyeh3Q97VfE2TvMiVNzm6UFl7DIAXq/ZkDYv9GA9CoA+0uZvaXlBFIhayP
         3Lwmrz2D9XMPlYyN9vz20u5CLE+D/mvopI5N8q9JLardnSve+s55hRkkDUfoEv/Icy+X
         ALQg==
X-Gm-Message-State: APjAAAX+UYnLXlXUJelssdXumnXiNHgcfsKwe/aJNxBJOeVMGO63d2xN
        LEmt/FItMBC//k0Q6PWFyWP3JNSn
X-Google-Smtp-Source: APXvYqzsr0Ao8O6jA7Ftffi4GO93OFuiGOoZfd06FdYMGUzZpoZhqWOAQQrfYgcNFd9W0Q4Ox8VHTw==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr1407766wrw.311.1574236331639;
        Tue, 19 Nov 2019 23:52:11 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h15sm32973798wrb.44.2019.11.19.23.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 23:52:10 -0800 (PST)
Date:   Wed, 20 Nov 2019 08:52:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Oscar Salvador <OSalvador@suse.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, sparse: do not waste pre allocated memmap space
Message-ID: <20191120075209.GB23213@dhcp22.suse.cz>
References: <20191119092642.31799-1-mhocko@kernel.org>
 <def84c96-a7d0-1026-a890-a8eca2e6a458@redhat.com>
 <20191119141047.a8e31e95b631e28f84dc0bc9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119141047.a8e31e95b631e28f84dc0bc9@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-11-19 14:10:47, Andrew Morton wrote:
> On Tue, 19 Nov 2019 11:03:58 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
> > > @@ -482,8 +481,13 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
> > >   {
> > >   	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
> > >   	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
> > > +	/*
> > > +	 * Pre-allocated buffer is mainly used by __populate_section_memmap
> > > +	 * and we want it to be properly aligned to the section size - this is
> > > +	 * especially the case for VMEMMAP which maps memmap to PMDs
> > > +	 */
> > >   	sparsemap_buf =
> > > -		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
> > > +		memblock_alloc_try_nid_raw(size, section_map_size(),
> > >   						addr,
> > >   						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > 
> > Wow, that alignment/layout gives me nightmares  ^
> > 
> > None of your business, though :)
> 
> We're allowed to change it ;)
> 
> --- a/mm/sparse.c~mm-sparse-do-not-waste-pre-allocated-memmap-space-fix
> +++ a/mm/sparse.c
> @@ -486,10 +486,8 @@ static void __init sparse_buffer_init(un
>  	 * and we want it to be properly aligned to the section size - this is
>  	 * especially the case for VMEMMAP which maps memmap to PMDs
>  	 */
> -	sparsemap_buf =
> -		memblock_alloc_try_nid_raw(size, section_map_size(),
> -						addr,
> -						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +	sparsemap_buf = memblock_alloc_try_nid_raw(size, section_map_size(),
> +					addr, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>  	sparsemap_buf_end = sparsemap_buf + size;
>  }

I didn't bother mostly because the creative code layout made the
intention of the patch more obvious.  But if it saves from nightmares
then why not.
-- 
Michal Hocko
SUSE Labs
