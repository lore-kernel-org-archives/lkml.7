Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2D3248C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y9IUVHZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfFDNBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:01:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33818 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFDNBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:01:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so8329640qtu.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JItJDb1hCe3PXbM5CDMidmb7xSzfnBwGQJaUWCGmqxo=;
        b=Y9IUVHZGqeU0HCJUHFiWu6pa9R1aTN7kulR/wN6MqxmpXYzOa0TiCqua5LiZ4hEwEz
         ev2Sj3xyes2144LjjuyOexSqeqSKWlt3WMK6cSGZPGD8HxNjX+Gtgr2VjY2syXYm24yv
         pNhVi+7lsS8CkaA6Ue3uMV/Vv79a8q0c7Bx2ZKe0zrhNUNw+dh1aaTgg9nVjtt2pPP8J
         SZ03QiW2V5U/FSunjX+Di4eqhrmayy4bvd9nBAYIILU6Dw1ILE8JJqykvWw/nYFx66N/
         59mJF6D5Asld4XY9Y52qmbOm2vh94w3cf4KMuiWIudfxgAyJaXKJUsg9rxdyQ86kjKce
         JSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JItJDb1hCe3PXbM5CDMidmb7xSzfnBwGQJaUWCGmqxo=;
        b=G7eVO8box6xTrB4z3D5LBr6A6HJMEWools9XRxZRODXWqaltdTu8ytKPJ7hMDKVqc3
         2AGhsF8nhjzRB81s1cfraH9mbiuL6TKkgCsjk41vznIiNeUskaXOdZwZUhoRrTmvXtsF
         aPuiRlqs2sduirWuJSBER4VRb6ugmXduHKQMYoWeoGqYEUWSRVMTs6WsOpONc3k0T4Aw
         +jTGA5G8tmQPTJ7Hip8PQYND2z7JecSKCSSgCWxMLrlDf1/QUHRwl5PHP4IxY6XorNx3
         LJ2I9ZkeZ+jNtOXbWPpSFKzT/ZyjmBj4CwOnixnXLnqUO7rY/XhBEFBdzaxHVeHjW9fH
         PCxg==
X-Gm-Message-State: APjAAAWDSsz7a7E9bi+BI/HUPkQdd4XGu/X5vBqcTHOneAByOtEbFl7R
        UGGa/Gnf7+6uLq7z6Qp+Np4i5Q==
X-Google-Smtp-Source: APXvYqzAG+mI1DPv2W+11pupnoGWNGycht5g/63Z32TRX8qAmaRQdBGY8y7MK6ZcgElkWgzp2dHDfw==
X-Received: by 2002:ac8:7c7:: with SMTP id m7mr25441539qth.28.1559653280236;
        Tue, 04 Jun 2019 06:01:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a7sm7509135qke.88.2019.06.04.06.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 06:01:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hY942-0004Su-LN; Tue, 04 Jun 2019 10:01:18 -0300
Date:   Tue, 4 Jun 2019 10:01:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v2] uaccess: add noop untagged_addr definition
Message-ID: <20190604130118.GC15385@ziepe.ca>
References: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
 <20190604122841.GB15385@ziepe.ca>
 <20190604123759.GA6610@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604123759.GA6610@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:38:00PM +0100, Catalin Marinas wrote:
> On Tue, Jun 04, 2019 at 09:28:41AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 04, 2019 at 02:04:47PM +0200, Andrey Konovalov wrote:
> > > Architectures that support memory tagging have a need to perform untagging
> > > (stripping the tag) in various parts of the kernel. This patch adds an
> > > untagged_addr() macro, which is defined as noop for architectures that do
> > > not support memory tagging. The oncoming patch series will define it at
> > > least for sparc64 and arm64.
> > > 
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > >  include/linux/mm.h | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 0e8834ac32b7..dd0b5f4e1e45 100644
> > > +++ b/include/linux/mm.h
> > > @@ -99,6 +99,17 @@ extern int mmap_rnd_compat_bits __read_mostly;
> > >  #include <asm/pgtable.h>
> > >  #include <asm/processor.h>
> > >  
> > > +/*
> > > + * Architectures that support memory tagging (assigning tags to memory regions,
> > > + * embedding these tags into addresses that point to these memory regions, and
> > > + * checking that the memory and the pointer tags match on memory accesses)
> > > + * redefine this macro to strip tags from pointers.
> > > + * It's defined as noop for arcitectures that don't support memory tagging.
> > > + */
> > > +#ifndef untagged_addr
> > > +#define untagged_addr(addr) (addr)
> > 
> > Can you please make this a static inline instead of this macro? Then
> > we can actually know what the input/output types are supposed to be.
> > 
> > Is it
> > 
> > static inline unsigned long untagged_addr(void __user *ptr) {return ptr;}
> > 
> > ?
> > 
> > Which would sort of make sense to me.
> 
> This macro is used mostly on unsigned long since for __user ptr we can
> deference them in the kernel even if tagged. 

What does that mean? Do all kernel apis that accept 'void __user *'
already untag due to other patches?

> So if we are to use types here, I'd rather have:
> 
> static inline unsigned long untagged_addr(unsigned long addr);
> 
> In addition I'd like to avoid the explicit casting to (unsigned long)
> and use some userptr_to_ulong() or something. 

Personally I think it is a very bad habit we have in the kernel to
store a 'void __user *' as a u64 or an unsigned long all over the
place.

AFAIK a u64 passed in from userpace is supposed to be converted to the
'void __user *' via u64_to_user_ptr() before it can be used. (IIRC
Some arches require this..)

So, if I have a ioctl that takes a user pointer as a u64, and I want
to pass it to find_vma, then I do need to write:

    find_vma(untagged_addr(u64_to_user_ptr(ioctl_u64)))

Right?

So, IMHO, not accepting a 'void __user *' is just encouraging drivers
to skip the needed u64_to_user_ptr() step.

At the very worst we should have at least a 2nd function, but, IMHO,
it would be better to do a bit more work on adding missing
u64_to_user_ptr() calls to get the 'void __user *', and maybe a bit
more work on swapping unsigned long for 'void __user *' in various
places.

Jason
