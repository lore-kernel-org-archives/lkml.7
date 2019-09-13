Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5BDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E951208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568365235;
	bh=9JuhOjqC48yFU3xkVLjzZFxv/cTU1Q2mIYn/jQmUgPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jtET855uqtRR9gVvYah5GsanxFy9b2w0nSyFiGyEI/dkvwmBdCDif8oZ6yzbCGSJE
	 TqCJIWdfDU6uQmU1jaPkhN2kyN8hR5s3SRv4PAEG/3XJm5X1Ve4ENaOeocj0SlpqK7
	 HG/QuPGW6KqqGpZstznRLu9Er7FOKEoHZFrp0Tcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfIMJAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:00:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34969 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfIMJAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:00:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so21567032lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iy3rPYv8IxEgFPOj88Xqu6ZodZ60o8YHq7Vyj7h0pd0=;
        b=Z4iEjFWn0T5IGOF+peJ2fu2ey8x7ARRNGdRQXARaPqTWNrJDlg/9rfWzOGlU+SXS4H
         w4eSp+LVS3o3UrhgOEiT+AFjRMFYjK/IKFfctD2yyMHN8ovnG9lXF4UoEBNuR8uPDAnn
         kylBjujazd0cknxDWHzi7sQIBLo0I372i+MwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iy3rPYv8IxEgFPOj88Xqu6ZodZ60o8YHq7Vyj7h0pd0=;
        b=KU6VZZ2PLofydwB2oD5xyhi3tMmVqfh10OIM1j5qw9Hf34vhd+gMGLoHb0n4ch0tnH
         MvHy6a2dP9y5r4K9JtFg4cU6W7iXN7cAuit4CIVTpNUG9zgi4itWX8PwztMEWJ7w8C+M
         sVXToZESbTCdzBJUIivhaSKX3pKNrPKMgvQX6duRg6NdweAQ/dGTnQfMsacIb8quHu5m
         Ke9ni5EETdZDeLgZRaYWouDDCocfvEa8Dz2y9Uxfx+C26a2h8ArYTAsTh3jbBpTlkIQJ
         8AqX04n0/e/ZBu+yFVrJaJXSTfhoUaB4y5OEos09OUzVvbAnX8tvT+K4LsUNdNkwaAJt
         MdHg==
X-Gm-Message-State: APjAAAX0omK9puazkvAnIIwNfKNETj+o+mJOq00hS4JWZy8Av7PeMznZ
        jaSP1Ug99ikLD+OKWaDEn0RRAC6wph9ldQ==
X-Google-Smtp-Source: APXvYqw3rWgXzXDOjqQlAOx5kFeyE98mjCrhKttPwIhA5UZFQT6PrVxkRRq4Q+dzwrIW71TdLkq04A==
X-Received: by 2002:a19:2d54:: with SMTP id t20mr1032481lft.84.1568365230742;
        Fri, 13 Sep 2019 02:00:30 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u1sm6686124lfi.83.2019.09.13.02.00.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 02:00:29 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h2so19829362ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 02:00:29 -0700 (PDT)
X-Received: by 2002:a05:651c:1108:: with SMTP id d8mr21690001ljo.180.1568365229338;
 Fri, 13 Sep 2019 02:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190913072237.GA12381@zn.tnic>
In-Reply-To: <20190913072237.GA12381@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Sep 2019 10:00:13 +0100
X-Gmail-Original-Message-ID: <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
Message-ID: <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
Subject: Re: [RFC] Improve memset
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 8:22 AM Borislav Petkov <bp@alien8.de> wrote:
>
> since the merge window is closing in and y'all are on a conference, I
> thought I should take another stab at it. It being something which Ingo,
> Linus and Peter have suggested in the past at least once.
>
> Instead of calling memset:
>
> ffffffff8100cd8d:       e8 0e 15 7a 00          callq  ffffffff817ae2a0 <__memset>
>
> and having a JMP inside it depending on the feature supported, let's simply
> have the REP; STOSB directly in the code:

That's probably fine for when the memset *is* a call, but:

> The result is this:
>
> static __always_inline void *memset(void *dest, int c, size_t n)
> {
>         void *ret, *dummy;
>
>         asm volatile(ALTERNATIVE_2_REVERSE("rep; stosb",

Forcing this code means that if you do

     struct { long hi, low; } a;
     memset(&a, 0, sizeof(a));

you force that "rep stosb". Which is HORRID.

The compiler should turn it into just one single 8-byte store. But
because you took over all of memset(), now that doesn't happen.

In fact, the compiler should be able to keep a structure like that in
registers if the use of it is fairly simple. Which again wouldn't
happen due to forcing that inline asm.

And "rep movsb" is ok for variable-sized memsets (well, honestly,
generally only when size is sufficient, but it's been getting
progressively better). But "rep movsb"  is absolutely disastrous for
small constant-sized memset() calls. It serializes the pipeline, it
takes tens of cycles etc - for something that can take one single
cycle and be easily hidden in the instruction stream among other
changes.

And we do have a number of small structs etc in the kernel.

So we do need to have gcc do the __builtin_memset() for the simple cases..

                 Linus
