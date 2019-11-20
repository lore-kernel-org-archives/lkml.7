Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E81C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7EA2251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256517;
	bh=VGLoPcKOlcVRq/LbrOEtcpJklEyOFZtKgXKjiHCb7t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eOiatFlqyNOJLkKkQi0SuTZ3h1fLc0kTKhwKocIZK/h5gdlMdupW6J9J7o6LNg6Wd
	 MeErOusq9dU87PpSoL4fzGg6ifESxUR2SLAG617TsD4+E9NA602o30L44d40ILIZX0
	 gJs7gcpZlOWyQQWjKqOawMuhMEZAEtYTNFM0r09w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfKTN2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:28:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53888 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfKTN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:28:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so6986122wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 05:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f11bqYRLU8GEHJXNeBAMacLrDj3b4Fc6rBnmQVewYXs=;
        b=TynL67zsnb3dlePBwaPt6y18949VU/64q6GUujLld7eUoJVZXTgTrf7dueb6TNT8yK
         fK64R0MGvbEsCxYedDclltsAl8wwekTy43w1ACsTQJafhZYJ7GVGsL9vrqWXQBJLoCzz
         F8f4CZ1PaMyNL9GdZQOtTC8QqSeFVkaBVajBfUj8PRMtM2GYtvcVtQZRxWRblIr8/UZT
         Cbl+MuMfI+yGDvOKjg75Pgbi7ifcEbY+noLDHoWfQROefstmc08NOyeEQo1lRY8GYAMT
         EkGr1ESrPfu8s3Bdp418kNH1C1IJ6sUm5K2dX/77GrC3pijg+S95JCWnKgL+rAaftAJ7
         Gn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f11bqYRLU8GEHJXNeBAMacLrDj3b4Fc6rBnmQVewYXs=;
        b=ShndYAzgqjtGtKkkncGc/k0+cF+wP5HGwrp7E4thT9/+50SWDFlWUN2tuRZEWl9vBp
         rdkmfcSILtkGh1i5ie281yMXnNY3aXwZKHD6VbuybkfQIs+chbzc3ojDZNi9D5K66Jz8
         uvf5Niw2kGRfuQc8roD9rMVzsthqe69OZ6HU+S6mFg8SlPgnlMfnwjfhlL9+rSPdrGFm
         duYaKYYETBpqQUX1vK420omF5HzPfwp/kqrmj4e4zvKbfh97Ha+Ykme8t8PydEhJlIJQ
         +iYpOXV5Y9KAuQHc4wRLYFNBq4/fXXTlIFE7evNMN9t69V9QHolr7Ad6PE4WuNB1hFW9
         O8ww==
X-Gm-Message-State: APjAAAXB97lKFo/Fw/HXmVzoYPNn1ApvgzI0l5+qjdd/k3ENYcsCmlw/
        WfDdU4UmC2FQ1okGmre7uK8=
X-Google-Smtp-Source: APXvYqxo7AeaIXtlfWun1U8ri3KLtGtuy/9Cw9fnh02S6IZlWcCK+uYtNmteBxXb4S+YqUY/dC0o1A==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr3186364wmc.157.1574256513123;
        Wed, 20 Nov 2019 05:28:33 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d20sm34607640wra.4.2019.11.20.05.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 05:28:32 -0800 (PST)
Date:   Wed, 20 Nov 2019 14:28:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120132830.GB54414@gmail.com>
References: <20191120103613.63563-1-jannh@google.com>
 <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com>
 <CAG48ez0Frp4-+xHZ=UhbHh0hC_h-1VtJfwHw=kDo6NahyMv1ig@mail.gmail.com>
 <20191120123058.GA17296@gmail.com>
 <20191120123926.GE2634@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120123926.GE2634@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Nov 20, 2019 at 01:30:58PM +0100, Ingo Molnar wrote:
> > 
> > * Jann Horn <jannh@google.com> wrote:
> > 
> > > You mean something like this?
> > > 
> > > ========================
> > > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > > index 9b23c4bda243..16a6bdaccb51 100644
> > > --- a/arch/x86/kernel/traps.c
> > > +++ b/arch/x86/kernel/traps.c
> > > @@ -516,32 +516,36 @@ dotraplinkage void do_bounds(struct pt_regs
> > > *regs, long error_code)
> > >   * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> > >   * address, return that address.
> > >   */
> > > -static unsigned long get_kernel_gp_address(struct pt_regs *regs)
> > > +static bool get_kernel_gp_address(struct pt_regs *regs, unsigned long *addr,
> > > +                                          bool *non_canonical)
> > 
> > Yeah, that's pretty much the perfect end result!
> 
> Why do we need the bool thing? Can't we rely on the assumption that an
> address of 0 is the error case and use that to determine whether the
> resolving succeeded or not?

I'd rather we not trust the decoder and the execution environment so much 
that it never produces a 0 linear address in a #GP:

in get_addr_ref_32() we could get zero:

	linear_addr = (unsigned long)(eff_addr & 0xffffffff) + seg_base;

in get_addr_ref_16() we could get zero too:

	linear_addr = (unsigned long)(eff_addr & 0xffff) + seg_base;

Or in particularly exotic crashes we could get zero in get_addr_ref_64() 
as well:

        linear_addr = (unsigned long)eff_addr + seg_base;

although it's unlikely I suspect.

But the 32-bit case should be plausible enough?

It's also the simplest, most straightforward printout of the decoder 
state: we either see an error, or an (address,canonical) pair of values.

Thanks,

	Ingo
