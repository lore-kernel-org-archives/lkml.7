Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A5C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7D62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2IDfnV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfCYKnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:43:52 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39001 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbfCYKnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:43:51 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so13097483ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnPk/Ty/G+9FvvXHd3eoMIE+kR40KwZYC4f9prslLHQ=;
        b=R2IDfnV8hnPhvXT9m1QuoY6/slemH21bjIS2ruhBnOFhA7gyFwsKntKswu8BvCLl2o
         Xv011Zr22Dp0Zt/l7D0l3z3OTnsIq3xtRzYuXvVavwdmtW12RYt3/cVnYxsMNt36h0D3
         o1+hvQ7nHveUarxZ2t631VnZrfxOPaVK1m3rlZUaK5xwGnd0K8H0Nbb97itQwXgpbB2V
         c7GnKDm/peMxyYyOVpAQZNv+Qg2QORZ6dAIG+LOo3BicQvPFb8DddUaNM3fDJF/NfiY0
         2rXfIB+wqIBYawJI6lL4hvlHkMgfAud7zc60aTt4hSgVIZEk8ekR2hKR3+yNLg7URtGy
         tPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnPk/Ty/G+9FvvXHd3eoMIE+kR40KwZYC4f9prslLHQ=;
        b=IkiTCjbX3no0Mv4O3O7gw1wXMuq+GxVtScDstz25yjtsnzWahcaIxPWmQ0ti2fBv7y
         tqXf7kOX6MSn5nnAr2mzh8V6Z1uFTcerlPY9UPhC+Vc4kJcLCDA+nMws0njz2R1OVjvp
         BVhZaI0W3ZiyEwSbFmQCMaVDG8hcB61/9mN0P4xntgfoo4J2z2ZQSSbGjo5yFVpQoCcn
         AhErKQCl0Tqo7U3QmtDhdp+TQKMki52Bu14KzeVbQFK/V3xbxSVrZAkVxHLzdtm50vVj
         SZi+rJr8dQ3HK+8sfDz6X0UIOSDVlLpglYeGI8TegNeBbYvPR61+mjh69eWVF+FHek9r
         sWNQ==
X-Gm-Message-State: APjAAAVcu9TtiOgRWOcdMiyvLMmdcVPQXlhdxts9eXz54i3nb3/5Iypr
        9PRC9frWMkRVMBjxOJTCxhJIvLnRHkTgVH8S01Y0Bw==
X-Google-Smtp-Source: APXvYqy37+qXAmtmlxqoX3m4X5ZN/q3Jbw6rq1teNkaHpk5T0JadwZlLy9ftiR9aluLr/G9ulnwnoPiwRSqJCcgax0U=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr13627245jal.2.1553510630546;
 Mon, 25 Mar 2019 03:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190322062740.nrwfx2rvmt7lzotj@gondor.apana.org.au>
 <CAKv+Gu_mgyzqUCeb+wke--8Gn8YbjOb8jyrSgFr3-tcNP8ccEQ@mail.gmail.com> <CAHk-=wg2LJ5qQ0B2y+_6Ue62SBP4h9MLxLvn89bfcP7Cp2ac6A@mail.gmail.com>
In-Reply-To: <CAHk-=wg2LJ5qQ0B2y+_6Ue62SBP4h9MLxLvn89bfcP7Cp2ac6A@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 25 Mar 2019 11:43:38 +0100
Message-ID: <CAKv+Gu_NoKi3hhxw+S59Yu_c0R6fZh8+KW1XnyFWg74MxEixGA@mail.gmail.com>
Subject: Re: [PATCH 0/17] Add zinc using existing algorithm implementations
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Martin Willi <martin@strongswan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 at 18:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Mar 22, 2019 at 12:56 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > - The way WireGuard uses crypto in the kernel is essentially a
> > layering violation
>
> What? No.
>
> That's just wrong.
>
> It's only a layering violation if you accept and buy into the crypto/ model.
>
> And Jason obviously doesn't.
>
> And honestly, I'm 1000% with Jason on this. The crypto/ model is hard
> to use, inefficient, and completely pointless when you know what your
> cipher or hash algorithm is, and your CPU just does it well directly.
>

Well, it is true that the the dynamic dispatch is annoying and we need
to fix that. And I have not given up hope that someone like Jason,
with his level of understanding of crypto, and an enticing use case
such as WireGuard, will choose to work with the linux-crypto community
to improve it rather than build something from scratch on the side.

But that is orthogonal to the sync vs async debate.

> > we even have support already for async accelerators that implement it,
>
> Afaik, none of the async accelerator code has ever been worth anything
> on real hardware and on any sane and real loads. The cost of going
> outside the CPU is *so* expensive that you'll always lose, unless the
> algorithm has been explicitly designed to be insanely hard on a
> regular CPU.
>
> (Corollary: "insanely hard on a regular CPU" is also easy to do by
> making the CPU be weak and bad. Which is not a case we should optimize
> for).
>
> The whole "external accelerator" model is odd. It was wrong. It only
> makes sense if the accelerator does *everything* (ie it's the network
> card), and then you wouldn't use the wireguard thing on the CPU at
> all, you'd have all those things on the accelerator (ie a "network
> card that does WG").
>
> One of the (best or worst, depending on your hangups) arguments for
> external accelerators has been "but I trust the external hardware with
> the key, but not my own code", aka the TPM or Disney argument.  I
> don't think that's at all relevant to the discussion either.
>
> The whole model of async accelerators is completely bogus. The only
> crypto or hash accelerator that is worth it are the ones integrated on
> the CPU cores, which have the direct access to caches.
>
> And if the accelerator is some tightly coupled thing that has direct
> access to your caches, and doesn't need interrupt overhead or address
> translation etc (at which point it can be worth using) then you might
> as well just consider it an odd version of the above. You'd want to
> poll for the result anyway, because not polling is too expensive.
>
> Just a single interrupt would completely undo all the advantages you
> got from using specialized hardware - both power and performance.
>
> And that kind of model would work just fine with zinc.
>
> So an accelerator ends up being useful in two cases:
>
>  - it's entirely external and part of the network card, so that
> there's no extra data transfer overhead
>
>  - it's tightly coupled enough (either CPU instructions or some on-die
> cache coherent engine) that you can and will just use it synchronously
> anyway.
>
> In the first case, you wouldn't run wireguard on the CPU anyway - you
> have a network card that just implements the VPN.
>
> And in the second case, the zinc model is the right one.
>
> So no. I don't believe "layering violation" is the issue here at all.
>

If the consensus is that no accelerator is likely to ever exist that
outperforms CPU crypto by any measure (latency, throughput, power
efficiency), then I don't have any objections to bolting this straight
onto a synchronous interface. My concern is that we will end up with
Zinc patches 12 months from now that implement async interfaces to
support some particular piece of hardware, while other hardware is
only supported by the crypto/ API, even though the algorithm they
implement is the same.

> The only main issue as far as I'm concerned is how to deal with the
> fact that we have duplicate code and effort.
>
>                       Linus
