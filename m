Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F5C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F5E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IKvWFo0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFUNpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:45:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41734 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfFUNpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:45:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id c11so4423287qkk.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5X0rmkRC95nceR2b+WbG0Q+b41qnJ7FNz5RDX36KkRU=;
        b=IKvWFo0f0mTVaCe/ijJtv0mDxHgoNp8HulNuI0gdobye37WUW94nv8DO7J1ctBzM/s
         y1U3xE4o3pFMYs/7BSYNHk45TVTdOg5ah1B/Ezb+sYysR+frntFucIE6z4FaKjp7+kPS
         CWfRQXI0wAV8/s5+T6lJtOeXR69gDXp75nl/bDlVvB0CS61j1/DQcB5+JxxW8c8h8L/W
         Do9nWLXeCDBlSBMAgLef2HJyHbQwTzNWgF989V9+FjYpu72cru6fLYnt32uoCsfDkKYD
         8v1BgRCJXKFONlNlM8ZrySrf2ZWJIGMy+aVFl4b0JnDL684iSD+C68Fqbqka+ZNuPT7s
         EMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5X0rmkRC95nceR2b+WbG0Q+b41qnJ7FNz5RDX36KkRU=;
        b=N9cOyL5TvgJ24DyfhD1GGkkhr5J2COi9KHXOrNRqjnWeIywUIg1iuxw5XYOn7RkaYK
         1a7RyqFh6BjyBtjxzWF2k9joNfax5qdWRGePLe2/VspyBADwvUIftEDhD1H/MOGjn/hV
         23lxzj6SBCjcNmHT9pT0lJbPzDZBE5tNUy6kJpvGzBmd3aNNtm0HUzrjpqmaQthORxlW
         /XLSgo5oqDbllSUr29AVjB7tT8f5dtSeXNyDriovx4RqpeQc07iha/rV3M673z81dO47
         uLhDeiyaxWj974oLPoFmmv0df+f1vNyPJfAtpiU3BCfogQavueBiqf/8JVyTbV4q7bF2
         FEoQ==
X-Gm-Message-State: APjAAAVR0CF9ukAbOsmx54d/vgTfbVxafjFaX1jRoS2lwXj1fX0aYQmL
        6eUXscB5M7UFaIyleTp8xElj6g==
X-Google-Smtp-Source: APXvYqw6Aa1vtmaoAcmmWYgjcUlAuKLWmpTyuJq4yf3HeH8qCqVB5lh6+d5sgipawN8uf35W8F5eHQ==
X-Received: by 2002:a37:6808:: with SMTP id d8mr5468961qkc.478.1561124732220;
        Fri, 21 Jun 2019 06:45:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h4sm1369861qkk.39.2019.06.21.06.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 06:45:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heJr9-00008q-7e; Fri, 21 Jun 2019 10:45:31 -0300
Date:   Fri, 21 Jun 2019 10:45:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] mm: lift the x86_32 PAE version of gup_get_pte to
 common code
Message-ID: <20190621134531.GN19891@ziepe.ca>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611144102.8848-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:40:49PM +0200, Christoph Hellwig wrote:
> The split low/high access is the only non-READ_ONCE version of
> gup_get_pte that did show up in the various arch implemenations.
> Lift it to common code and drop the ifdef based arch override.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/include/asm/pgtable-3level.h | 47 ------------------------
>  arch/x86/kvm/mmu.c                    |  2 +-
>  mm/Kconfig                            |  3 ++
>  mm/gup.c                              | 51 ++++++++++++++++++++++++---
>  5 files changed, 52 insertions(+), 52 deletions(-)

Yep, the sh and mips conversions look right too.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f0c76ba47695..fe51f104a9e0 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -762,6 +762,9 @@ config GUP_BENCHMARK
>  
>  	  See tools/testing/selftests/vm/gup_benchmark.c
>
> +config GUP_GET_PTE_LOW_HIGH
> +	bool
> +

The config name seems a bit out of place though, should it be prefixed
with GENERIC_ or ARCH_?

Jason
