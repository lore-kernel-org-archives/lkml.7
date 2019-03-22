Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16DCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9752083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553277322;
	bh=+pF7qIwcjTl7K54ijiv4ebjBmWQnq15K3Q5kaNtf6sE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=egl6GNFucShzXqon5ehRDkfIkMTf3NvxXpYQvhZU54wYnOVhq6Ppf591N6T5casXH
	 PvJj2OL3tA2uYNPkHz/yYAdBG/lYiqmD2PHyFqfNrJMcA+FHCn8rtPsJcASUWvLmpA
	 uJeRphatlhM+CtV1g9uI+Yt0Etw3zrSfVIYUEwao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfCVRzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:55:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44895 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfCVRzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:55:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id n18so2746334ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8m8qhWDBjWqa7fntMBLESHaGmro+6lwh8566Qfdifhk=;
        b=Hx40yLghBsxHOA3JVS3XgQ7Yvy5tQne7YNIbVG7/BZdyX8QMi3CIwKyP9otm0r1K2c
         A51sUudjhu865BW9SYnZVy7KN1T69TGoSTxgqyQYD7f5EPgTxDc5W2xwOpMjXGA/Z0vN
         sNWuoAm5P/wEIn/FRRi+ekcaNabG8UHy5iVwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m8qhWDBjWqa7fntMBLESHaGmro+6lwh8566Qfdifhk=;
        b=TwVSKbMOAZhMv40aMnVp9L6xTvyO3X2NAp1Yvt3sYrEBJaOpyJxo2zhIlwpxBaXBHp
         8I3ZI6tDyqMFTm02qje4ThMLzMNQ1sHg+8lP/9SjQer26eAzIkHgQvYKwbPxaV2JMIPq
         SPHglhiQxDCgsFv4iIQpYGYqIzBh4pNY2OQ/clbwq6RS8BqC5bXZLW6m73HgsC2BSKFn
         rYauI1p0pxKfJD7wmBbMyYzYcg2zSgze9jFZ7s3WORR8jgi4wCybomPz/pfzFHQd4vdp
         DzOuGUZP7AZsaeYXAaUrY0qjNXgeDeB8MvYEXkVkUEj/0D1a1E3QYWC2gK6ZgVpByiM0
         VW0g==
X-Gm-Message-State: APjAAAXPFI1GyMm5lQ2XDFcKoshJC9EIKgG2eWP4MasvmJp11Ia0JBE3
        cO04NyXatm25hUzrABtXzZ552aSTe4M=
X-Google-Smtp-Source: APXvYqwq2933UsqUn64c/a4HQiq378OilF6rTaIeyWFk6mg8QFzLEDAUoMMWcNw6cqEeo7M88oedzA==
X-Received: by 2002:a2e:8810:: with SMTP id x16mr5810081ljh.195.1553277318270;
        Fri, 22 Mar 2019 10:55:18 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id q64sm608810ljq.76.2019.03.22.10.55.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:55:18 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id z26so2732655lja.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:55:17 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr630483lja.125.1553276916674;
 Fri, 22 Mar 2019 10:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190322062740.nrwfx2rvmt7lzotj@gondor.apana.org.au> <CAKv+Gu_mgyzqUCeb+wke--8Gn8YbjOb8jyrSgFr3-tcNP8ccEQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_mgyzqUCeb+wke--8Gn8YbjOb8jyrSgFr3-tcNP8ccEQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Mar 2019 10:48:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2LJ5qQ0B2y+_6Ue62SBP4h9MLxLvn89bfcP7Cp2ac6A@mail.gmail.com>
Message-ID: <CAHk-=wg2LJ5qQ0B2y+_6Ue62SBP4h9MLxLvn89bfcP7Cp2ac6A@mail.gmail.com>
Subject: Re: [PATCH 0/17] Add zinc using existing algorithm implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

On Fri, Mar 22, 2019 at 12:56 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> - The way WireGuard uses crypto in the kernel is essentially a
> layering violation

What? No.

That's just wrong.

It's only a layering violation if you accept and buy into the crypto/ model.

And Jason obviously doesn't.

And honestly, I'm 1000% with Jason on this. The crypto/ model is hard
to use, inefficient, and completely pointless when you know what your
cipher or hash algorithm is, and your CPU just does it well directly.

> we even have support already for async accelerators that implement it,

Afaik, none of the async accelerator code has ever been worth anything
on real hardware and on any sane and real loads. The cost of going
outside the CPU is *so* expensive that you'll always lose, unless the
algorithm has been explicitly designed to be insanely hard on a
regular CPU.

(Corollary: "insanely hard on a regular CPU" is also easy to do by
making the CPU be weak and bad. Which is not a case we should optimize
for).

The whole "external accelerator" model is odd. It was wrong. It only
makes sense if the accelerator does *everything* (ie it's the network
card), and then you wouldn't use the wireguard thing on the CPU at
all, you'd have all those things on the accelerator (ie a "network
card that does WG").

One of the (best or worst, depending on your hangups) arguments for
external accelerators has been "but I trust the external hardware with
the key, but not my own code", aka the TPM or Disney argument.  I
don't think that's at all relevant to the discussion either.

The whole model of async accelerators is completely bogus. The only
crypto or hash accelerator that is worth it are the ones integrated on
the CPU cores, which have the direct access to caches.

And if the accelerator is some tightly coupled thing that has direct
access to your caches, and doesn't need interrupt overhead or address
translation etc (at which point it can be worth using) then you might
as well just consider it an odd version of the above. You'd want to
poll for the result anyway, because not polling is too expensive.

Just a single interrupt would completely undo all the advantages you
got from using specialized hardware - both power and performance.

And that kind of model would work just fine with zinc.

So an accelerator ends up being useful in two cases:

 - it's entirely external and part of the network card, so that
there's no extra data transfer overhead

 - it's tightly coupled enough (either CPU instructions or some on-die
cache coherent engine) that you can and will just use it synchronously
anyway.

In the first case, you wouldn't run wireguard on the CPU anyway - you
have a network card that just implements the VPN.

And in the second case, the zinc model is the right one.

So no. I don't believe "layering violation" is the issue here at all.

The only main issue as far as I'm concerned is how to deal with the
fact that we have duplicate code and effort.

                      Linus
