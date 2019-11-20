Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B5C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7192251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqkMWRLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfKTMnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:43:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39596 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfKTMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:42:58 -0500
Received: by mail-oi1-f195.google.com with SMTP id v138so22366455oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1kvKePgmOlp312ylkyBxDZhjYmUB28WgRyVChV+Gis=;
        b=XqkMWRLFwMVAhtf2OojeIzhF7aXEI9kLcrkYit3ig65ex18iexZ4H5D3ChBV/XJkHt
         laPATqmM7JspowvVML3CVg31wq6pevEgTBDUqPilfuXXq/xvNLfMkCmDLH9W+jzcSr6y
         +oNU/0Lx5ljZkJdHexlGE8n+CuFDnLaXqRqMNYkaybR5QWUFHeMs3FEmBLjwOOicacWk
         oOEKMTXMs+xLaqDIwoCKI64k+Tt19xazkp38+2hM7L2cv1Xry0wKppQUMjuBpUPPy7xE
         P8fmZTYM8PUogH+lWjH9IYzQfZakfbaCj05PG7xqaDOqkdpkduyeCRYeTY8UC6e+jrTI
         VlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1kvKePgmOlp312ylkyBxDZhjYmUB28WgRyVChV+Gis=;
        b=SrbNdToSJ6yCwGVjTu/ZY9e/eZXRjNSjKzWrNfeQ7rdSdd+Z4+pDntI6iVRcRoAxTS
         J105hbsEdxFUAjqHqEYRQB03lbnMkKq/EsRVl+XnlggdAzkbpyJd4mspXUmtMXAVDezr
         nIF9sN/lWERRuT6Bh7dYfHepsuDNMYSBFbVp4sStMbpwYraq5FFrxVQdeTL6dJUgBzyA
         5n3HDH9lQNEaTEizDWmiCG4UwFmnzX4ubosTQ8p4GOopfx7klWI3sVmdQHWaJk+ffELd
         vqxejfkvl5nVw77O3LnIY3YzeBUYVhG0HHKbJ3fv2zPiuLIVk/0lYyDwy4pwFPlijoDS
         OItA==
X-Gm-Message-State: APjAAAU1RYwajgq+pA9VcndryzmJy1o/Esu6VhFeZBOlivG4dcgNWYyi
        iEVT5az2y/z5Bc/f0Es7vhQiCVxp1kGJj2+9Ct1GXg==
X-Google-Smtp-Source: APXvYqwl9FfJLLEru8qUxE1aWkbUtyS4LaH9mss0hWUGwceKMkfdA/3IkHo+ODbTNkEbkv8yz2GS0jTr6MVHrw/+N1c=
X-Received: by 2002:aca:4d47:: with SMTP id a68mr2666979oib.68.1574253777810;
 Wed, 20 Nov 2019 04:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20191120103613.63563-1-jannh@google.com> <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com> <CAG48ez0Frp4-+xHZ=UhbHh0hC_h-1VtJfwHw=kDo6NahyMv1ig@mail.gmail.com>
 <20191120123058.GA17296@gmail.com> <20191120123926.GE2634@zn.tnic>
In-Reply-To: <20191120123926.GE2634@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Nov 2019 13:42:31 +0100
Message-ID: <CAG48ez11KVxQoSDM2GmMAxU=1jNZNYKcLFkvpkeq74p+yxeefw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 1:39 PM Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Nov 20, 2019 at 01:30:58PM +0100, Ingo Molnar wrote:
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

True, that'd work, too. I didn't really want to special-case an
integer here - especially one that has the same value as NULL - but I
guess it's fine.
