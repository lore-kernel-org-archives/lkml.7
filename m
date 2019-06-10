Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA9EC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65BF206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aypLgRrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfFJUgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:36:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43341 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfFJUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:36:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so5625952pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QIiaElKbYG7X2iRY6VXsdeM4+31zgx4vPIFfu4hUJug=;
        b=aypLgRrX0btLwkQ78UmSd30OW9UF0AUZJnAd3r2/5HqpTZB7t9pPjkr79taehwRSBe
         Uf3LjKJsRGeyWW7niEs4BHLmd/27Tp++YcV8xUIXVrHXkWkhfr39ad2bGk73/2ccXpRd
         Krrfs143htc/xGI+Ppm9VimNWGnjKhQyxh//k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIiaElKbYG7X2iRY6VXsdeM4+31zgx4vPIFfu4hUJug=;
        b=DEttQB6HF6YDbjNEvIaoHeWoGJHDLvdqlL1+HB1KM0Re63/odxXGv9SQkFCrUsSBCG
         0XVVLC6J15LsPN18ml2ROMVd3EDHI6DHpknAJrsp3rOH0UeRE/znAa6FnczM+TKGvxXx
         yg+OVcXwD+GoYVx8ID03wSMnVkjbnQrEym3HDni4rOw5WjsV6ID6HSKcPsx+QlEfUnTv
         95CeH4WwndsiwwdyMlhuhXhtDvbFE1mYB7x4pSJj2e+Jy1NOFRe8JAMb8x/rJ+U+ftKr
         TH8ludDfexhOGRd7gdun24UG5/Jw9olox8fcrQkJXCbSRart0sKEy0Kpp7ctGFzsiVlS
         jeKg==
X-Gm-Message-State: APjAAAU/dsDodaqlTtm6UxWJj9ENkyEKUcOmMs1JrvS2h5p3uGgflmWN
        VTbwrQzEjQWoSRjFts4OAAsI1Q==
X-Google-Smtp-Source: APXvYqz36v1zCKX0GRWb534Z9an9udGHI/NESxPlvuGqVOMCrwC97gsWY6mXQoFhLwcNndoWLde2ZA==
X-Received: by 2002:a62:1b85:: with SMTP id b127mr76850297pfb.165.1560198965895;
        Mon, 10 Jun 2019 13:36:05 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id k22sm11148457pfk.178.2019.06.10.13.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 13:36:04 -0700 (PDT)
Date:   Mon, 10 Jun 2019 13:36:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [PATCH v16 02/16] arm64: untag user pointers in access_ok and
 __uaccess_mask_ptr
Message-ID: <201906101335.DF80D631@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
 <20190610175326.GC25803@arrakis.emea.arm.com>
 <201906101106.3CA50745E3@keescook>
 <20190610185329.xhjawzfy4uddrkrj@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610185329.xhjawzfy4uddrkrj@mbp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 07:53:30PM +0100, Catalin Marinas wrote:
> On Mon, Jun 10, 2019 at 11:07:03AM -0700, Kees Cook wrote:
> > On Mon, Jun 10, 2019 at 06:53:27PM +0100, Catalin Marinas wrote:
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index 3767fb21a5b8..fd191c5b92aa 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -552,3 +552,18 @@ void arch_setup_new_exec(void)
> > >  
> > >  	ptrauth_thread_init_user(current);
> > >  }
> > > +
> > > +/*
> > > + * Enable the relaxed ABI allowing tagged user addresses into the kernel.
> > > + */
> > > +int untagged_uaddr_set_mode(unsigned long arg)
> > > +{
> > > +	if (is_compat_task())
> > > +		return -ENOTSUPP;
> > > +	if (arg)
> > > +		return -EINVAL;
> > > +
> > > +	set_thread_flag(TIF_UNTAGGED_UADDR);
> > > +
> > > +	return 0;
> > > +}
> > 
> > I think this should be paired with a flag clearing in copy_thread(),
> > yes? (i.e. each binary needs to opt in)
> 
> It indeed needs clearing though not in copy_thread() as that's used on
> clone/fork but rather in flush_thread(), called on the execve() path.

Ah! Yes, thanks.

> And a note to myself: I think PR_UNTAGGED_ADDR (not UADDR) looks better
> in a uapi header, the user doesn't differentiate between uaddr and
> kaddr.

Good point. I would agree. :)

-- 
Kees Cook
