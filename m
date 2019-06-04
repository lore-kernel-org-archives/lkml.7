Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC942C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911292231F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sM1mzsQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfFDMeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:34:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45349 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfFDMeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:34:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so10264282pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHnFmrFfRfh/AvNJyyWOv1fZiunoT+xaBh/4jOpKvTQ=;
        b=sM1mzsQHPWWZHTawBLKWAgVjQThohDWkimAMcbonijyC54y8P2c26E0W2rM2IJY/m8
         LZvg01A94bMj1WlufObeLPkCPFVWlG1fpPGYAusKcJ0h4TSfntoPqPc6/wpa61VjjeSq
         2wxM/o5o0K1ra4b5zRGlQW204mrf6zT/4yMmHX7lBOfDc4OCCgqvd6tNS4U2wlNLMmtL
         bz7UkkIob9zlNFiuzQFjICyejDPOtW4/NuezAc/NufYaEQ9+bPzfXvEC2VUHLxA3jSpg
         zi75erEDlO6/F+f3w/vSf+LFVBb/kHnrW1/Xu0/niwLqlxDvkQELtydqfx7PnZ4+YwSc
         CMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHnFmrFfRfh/AvNJyyWOv1fZiunoT+xaBh/4jOpKvTQ=;
        b=cZmaz9HpCSHDVHpK1pTWTEG8t9fLbVPJT8Edd3939tv3CMRAl/N76IEv2KBB1fiKCm
         B93YJCLsC8yxBE4gzlWxXvuWpVDe46iwJW0tHFJ3MY+cKtoJjicXg4aIgJdxC4qwbKVs
         C5ljv11ikdEA35cKW0AruJR+uvyfZ4v4vOfxqKicX/GFPbnX6sS4tQWLLPRBxkB82SnK
         ZG3eQSiiNWOEY5w7ZuYCGU4f5kA1hH9eEUfZEPm+NEyOVZYs/ZEtNpN2vYmJ/18OnO4S
         fSeAzl4v/zQf4v1a+2FfiuoC6LTCFq9shjJJNE9qI7mlNg9QZVSS9Fv87J/mNCpxl9zr
         vYng==
X-Gm-Message-State: APjAAAWsS0IVThkocxQhzg4ZnaTCJHbf9gYuk29/FP5vsikp4IPanxO8
        oJZQV7NdF9LaFH90BwgD/L5i0zbplVwibICVL438lQ==
X-Google-Smtp-Source: APXvYqwn1SWCI6udsJKomLgM6z7+qFO6mHtKOVLBDx9bpSrAmG/bLquj7gkAYUayFTQJ+Kz6TBw6JcOE/LCE3GzhNkY=
X-Received: by 2002:a62:1c91:: with SMTP id c139mr29991024pfc.25.1559651689157;
 Tue, 04 Jun 2019 05:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
 <20190604122841.GB15385@ziepe.ca>
In-Reply-To: <20190604122841.GB15385@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 4 Jun 2019 14:34:37 +0200
Message-ID: <CAAeHK+x0qYsO+P=8pQ6N0nRa4y+N3HWTh4sFaUMM63X3q_QbBg@mail.gmail.com>
Subject: Re: [PATCH v2] uaccess: add noop untagged_addr definition
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 2:28 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jun 04, 2019 at 02:04:47PM +0200, Andrey Konovalov wrote:
> > Architectures that support memory tagging have a need to perform untagging
> > (stripping the tag) in various parts of the kernel. This patch adds an
> > untagged_addr() macro, which is defined as noop for architectures that do
> > not support memory tagging. The oncoming patch series will define it at
> > least for sparc64 and arm64.
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >  include/linux/mm.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0e8834ac32b7..dd0b5f4e1e45 100644
> > +++ b/include/linux/mm.h
> > @@ -99,6 +99,17 @@ extern int mmap_rnd_compat_bits __read_mostly;
> >  #include <asm/pgtable.h>
> >  #include <asm/processor.h>
> >
> > +/*
> > + * Architectures that support memory tagging (assigning tags to memory regions,
> > + * embedding these tags into addresses that point to these memory regions, and
> > + * checking that the memory and the pointer tags match on memory accesses)
> > + * redefine this macro to strip tags from pointers.
> > + * It's defined as noop for arcitectures that don't support memory tagging.
> > + */
> > +#ifndef untagged_addr
> > +#define untagged_addr(addr) (addr)
>
> Can you please make this a static inline instead of this macro? Then
> we can actually know what the input/output types are supposed to be.
>
> Is it
>
> static inline unsigned long untagged_addr(void __user *ptr) {return ptr;}
>
> ?
>
> Which would sort of make sense to me.

Hm, I'm not sure. arm64 specifically defines this as a macro that
works on different kinds of pointer compatible types to avoid casting
everywhere it's used:

https://elixir.bootlin.com/linux/v5.1.7/source/arch/arm64/include/asm/memory.h#L214

>
> Jason
