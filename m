Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3B8C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C9F2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBkhp4o3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfFTIRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:17:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36837 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFTIRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:17:40 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so112462ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4YztDUoEeZNSItpvBqXAMHzKgEhPW4KSrwgqWZNxZ0=;
        b=OBkhp4o3op8N2jgrTX4I/tH93sjhXYIrF0FFetZzSv5AC5XT2nhL0Kjz7jdLDHnSGI
         ArUBUXG3lrb4oqMsxfLQA0Aza0zz9fjxvKqUw7IW8o4VFBzy/sSIGS5DPEVQKynMo4Hq
         cc72AEowt4e+lj0UWxoRKW5uhJoH1TTTQOQlOB6s030MpuGnWMzevxg9fObiQFOMcUzv
         94xb/435Se3+UVm+a1r9qtsgPjAbQ2jsRiaKilMEVCsLHzp7GvyVifWDs/tg7HVxTkHp
         ngruAOTG+MemFJ5d7eYJAsLl9ylhIpBA+ip8zoTQTIVIdf+3ZqIKhak8k94Nh6iiqbku
         qG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4YztDUoEeZNSItpvBqXAMHzKgEhPW4KSrwgqWZNxZ0=;
        b=hvUvdjHJEBw+XdV1rWjJrsbhf/pxAMFYcXra/IiBPnSkoRHvdx+/nJXY0du4iu7VSG
         14dmX0ykmgiylBb5gnIHhhVnehuNy/kcW/xOTjc0e4LQ5x+zefMGohgT7zo1SB6HOyWj
         dGTrPhTv1HFO9SgX57ZPaUGDGcXezxtkPo/ttIgu3nO8gErHHkfOBQL77W8/81xBdEgq
         ovzdJy7TFWCnQdzXrcLXf1H6gm9NgTQrnjaBGKVMoz2LInJdSB7712owL9mll0OYje1W
         JePNzil7d71166zshUD4tuNANKqS1rEq+oeOhfW71CdsMX0ZiYZ5++CsOwo7BU6QJXU3
         EzHQ==
X-Gm-Message-State: APjAAAXdls8Fqy6WRat0CrAz6t5l0JZQ8C/ivnUIR1C7wDsn8Rt//xa0
        MgyjmUs5dtzaqUbUMOTcWx7NnAg2+x/yPDMVoN5e6g==
X-Google-Smtp-Source: APXvYqxe4q2rYA/eK3CssvAan7/QclqCFivs0lgX+SqqohST3vQOcRkfXN2YktNNYJxfT76HM1HWD0WoW2I90qYqTFc=
X-Received: by 2002:a02:3308:: with SMTP id c8mr33710225jae.103.1561018658694;
 Thu, 20 Jun 2019 01:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190620003244.261595-1-ndesaulniers@google.com> <20190620074640.GA27228@brain-police>
In-Reply-To: <20190620074640.GA27228@brain-police>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 20 Jun 2019 10:17:25 +0200
Message-ID: <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
To:     Will Deacon <will.deacon@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 at 09:47, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Nick,
>
> On Wed, Jun 19, 2019 at 05:32:42PM -0700, Nick Desaulniers wrote:
> > Generated via:
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make menuconfig
> > <enable CONFIG_RANDOMIZE_BASE aka KASLR>
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make savedefconfig
> > $ mv defconfig arch/arm64/configs/defconfig
>
> Hmm, I'm in two minds about whether we want this on by default. On the plus
> side, it gets us extra testing coverage, although the /vast/ majority of
> firmware implementations I run into either don't pass a seed or don't
> provide a working EFI_RNG. Perhaps that's just a chicken-and-egg problem
> which can be solved if we shout loud enough when we fail to randomize; we'll
> also eventually be in a better position when CPUs start implementing the
> v8.5 RNG instructions (but don't hold your breath unless you have an
> unusually high lung capacity).
>

For testing coverage purposes, exercising the relocation machinery etc
even on no-kaslr boots would be beneficial imo. (The kernel is
relocated once for non-kaslr boots and twice for kaslr boots on kaslr
capable kernels)

> On the flip side, I worry that it could make debugging more difficult, but I
> don't know whether that's a genuine concern or not. I'm assuming you've
> debugged your fair share of crashes from KASLR-enabled kernels; how bad is
> it? (I'm thinking of the case where somebody mails you part of a panic log
> and a .config).
>

When you are debugging using GDB, it can get a bit tedious, since you
have to pass the offset when you load the symbols. However, in that
case, you can just pass 'nokaslr' unless you are debugging something
that is affected by the randomization.

For reading backtraces etc, nothing really changes, since we get
symbol+nnn/mmm entries (and the full panic log prints the KASLR offset
as well, in case it matters)

> Irrespective of the above, I know Catalin was running into issues with his
> automated tests where the kernel would die silently during early boot with
> some seeds.  That's a bit rubbish if it's still the case -- Catalin?
>

Yes, it would be good if we could fix that. In fact, I would argue
that having this change in would have increased the likelihood that
someone else would have spotted it and fixed it :-)

In fact, given how many Android phones are running this code: Nick,
can you check if there are any KASLR related kernel fixes that haven't
been upstreamed?

> Finally, I know that (K)ASLR can be a bit controversial amongst security
> folks, with some seeing it as purely a smoke-and-mirrors game with no
> tangible benefits other than making us feel better about ourselves. Is it
> still the case that it can be trivially bypassed, or do you see it actually
> preventing some attacks in production?
>
> Sorry for the barrage of questions, but I think enabling this one by default
> is quite a significant thing to do and probably deserves a bit of scrutiny
> beforehand.
>

I think it is mostly controversial among non-security folks, who think
that every mitigation by itself should be bullet proof. Security folks
tend to think more about how each layer reduces the attack surface,
hopefully resulting in a secure system when all layers are enabled.

So KASLR is known to be broken unless you enable KPTI as well, so that
is something we could take into account. I.e., mitigations that don't
reduce the attack surface at all are just pointless complexity, which
should obviously be avoided.

Another thing to note is that the runtime cost of KASLR is ~zero, with
the exception of the module PLTs. However, the latter could do with
some additional coverage as well, so in summary, I think enabling this
is a good thing. Otherwise, we could disable full module randomization
so that the module PLT code doesn't get used in practice.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
