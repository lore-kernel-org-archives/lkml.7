Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C27C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2B62240E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAYqXYJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfKSUCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:02:06 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36274 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKSUCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:02:05 -0500
Received: by mail-vs1-f68.google.com with SMTP id q21so15158926vsg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 12:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+kgeC423PEmiXE54P456kmvClusHVqDZZQMf6Wfq8g=;
        b=LAYqXYJmg3/nUPp2KkicyNn045+DSy+qXZ69cpU3O7SoqBK7jbFkPKBinM1rx16+R4
         91xiJTO1WqhfYnv5n6OUtt1t2cg9YZP+j/dt2z8V+cOsGkYFGKFW4Cs2k66ETJ8Sw6vK
         h2mYSM+2qxLS4HeVa5Hl6UooSCyvJm2WLZ9NhMrotAQSOsLE8Arx339mnaJ+EdbOX5PT
         mOGLU9xKkjpQamXuUFolfgvZ9Oc1Ok80gB1T0nWbbJjHNdCxPMgf/KGWgblI4kc4AOlJ
         UpLffBeGi/UAB2yJHAQnvh2Gp8Mb8vto1564i8T1PczukVwHCjZ7xiCJ3xS0NkPY3K2r
         9WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+kgeC423PEmiXE54P456kmvClusHVqDZZQMf6Wfq8g=;
        b=cydZUmmgp8GOGxv6SL3Ba3kEqcTyLS5Q1rx02xN+jp3f7KlOttzp8pcCnjZTlhn2VQ
         VgY09kAofRBdHj3lRYnRVVnVQCYi1yAi2TZLP2+31WH2P+kVBGDUJH3FIyYSAq/Br2Ra
         vixJ/uc6NmeyIFR4pAPHjrVYiIxotTkk+V3mu4oqyBHpr7JCeOPcxcWEYCdqkRX4gBeP
         7b5RrDWXzJxDfqjUl/Wa1F9RnKJx0/+NKJtrPHA3DSuJqT8Iiph0HLFOzySwrPBbj1I+
         3QMr/kEI+SWoElsx2OtCJolXfc0itnG+kAnuVawx3DQdjUXz3aKnmac2M4nf6EMZX0/B
         Q6DA==
X-Gm-Message-State: APjAAAXN4E+g8mH0vmfwNgB3tIF0ycRkAa63tPuVLgnfOGgg1+EXOLLz
        lxp7alowhw1V0N4leJzST3HEe3oOamKNdc8fsFt0IA==
X-Google-Smtp-Source: APXvYqzcRdtEp6THc7+OIwZlRAkM2IozUimYlwR67GM90nMnCXw4ij3J6M+8GvqPD08ArQNVwEdRuTBT0xp6TrRbhp0=
X-Received: by 2002:a67:e951:: with SMTP id p17mr18570219vso.112.1574193724307;
 Tue, 19 Nov 2019 12:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191114225113.155143-1-samitolvanen@google.com> <CAKv+Gu98uOZz7ZrG66gQerBq+hmwHmL4ebz5oDL16hxg=Y_YvA@mail.gmail.com>
In-Reply-To: <CAKv+Gu98uOZz7ZrG66gQerBq+hmwHmL4ebz5oDL16hxg=Y_YvA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 19 Nov 2019 12:01:52 -0800
Message-ID: <CABCJKufNpaYEFC0dNVFMd+4puPn9EW4r=UNW-gzn1y0yxYzY-w@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: arm64/sha: fix function types
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 3:32 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 14 Nov 2019 at 22:51, Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Instead of casting pointers to callback functions, add C wrappers
> > to avoid type mismatch failures with Control-Flow Integrity (CFI)
> > checking.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/arm64/crypto/sha1-ce-glue.c   | 17 +++++++++------
> >  arch/arm64/crypto/sha2-ce-glue.c   | 34 ++++++++++++++++++------------
> >  arch/arm64/crypto/sha256-glue.c    | 32 +++++++++++++++++-----------
> >  arch/arm64/crypto/sha512-ce-glue.c | 26 ++++++++++++-----------
> >  arch/arm64/crypto/sha512-glue.c    | 15 ++++++++-----
> >  5 files changed, 76 insertions(+), 48 deletions(-)
> >
> > diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> > index bdc1b6d7aff7..76a951ce2a7b 100644
> > --- a/arch/arm64/crypto/sha1-ce-glue.c
> > +++ b/arch/arm64/crypto/sha1-ce-glue.c
> > @@ -28,6 +28,13 @@ struct sha1_ce_state {
> >  asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
> >                                   int blocks);
> >
> > +static inline void __sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> > +                                      int blocks)
>
> Nit: making a function inline when all we ever do is take its address
> is rather pointless, so please drop that (below as well)

Ack, I'll send v3 that removes the extra inlines shortly.

> With that fixed (and assuming that the crypto selftests still pass -
> please confirm that you've tried that)

I don't have a test device that supports sha512-ce, but self-tests for
everything else pass with these changes.

Sami
