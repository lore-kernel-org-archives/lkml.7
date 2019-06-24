Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB2C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B355205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsgcCRD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfFXKGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:06:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39152 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbfFXKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:06:33 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so740646iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzjhqKUQE+QT87VlGM7mrbkwUfIug49zvMwL3mtkgLI=;
        b=nsgcCRD4CD7gAOEhmxdS9KtrV1XDmK+5s3tRYAp4HsTfnT8B4aoKgDLyD6HpN5bSKn
         Emsl7eP2xijq0eANUtP0KvD/WoHMrGgOyW9IebxKrBzgTnq8rg7HWaY1HiETeI+wVCy3
         G0x1q+sKHGvktCR3zFb/ltoxVGFvwJ8UiRlSdeXa1JY87nKd8jkdRUZsagcB8fNP2IsO
         5Tzq0jCElctINZ9ixKqDwpWfKrUXZl1inBuoVPQObeQ9VIgGrIzSZj33cST1DvsZkQkt
         kWOD/4dgdYs0UhB5mDmCjKCO8oP7XkPLXtP2+kJoFvLZGT21/9PxD/UiuYBhnX8OFA3A
         Zwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzjhqKUQE+QT87VlGM7mrbkwUfIug49zvMwL3mtkgLI=;
        b=Pec8mVQjPc/BimqPb0u+C2ebpep6vpy5F9QWDD7mqwJe8NjhWQ3e1KJWpxEmRfCsV5
         SThRT8CFPd3u4pQx06LuNiz3nPJBWtgz96Hru9YO15NpoJH4DNb306ZV4lslJ35oD7qS
         rhTbasCHMm6qM7+RW/N0oXAXQ9qr7YWwaqdYe1ylVMu1r0fHR8JohbyJ0O39wxEswkvj
         JJNlcc8bvJLjoxvD1egOk8P9dh6VJfiNjE85xVVpQamwHLdP2sUoaZ74woZ7vN7CLKVX
         4dpdpq08OuPlVsBRLK/vflqHkUM+oRxhZ4hrJayrlXFXxXnpxNkNrn49hGdKiFIILyID
         pWeg==
X-Gm-Message-State: APjAAAX6BLkRFd8OR/oncajbdqQ56ty8XFudFRivxesiAZK9C3Q3X9YA
        Z2ne2y8HONn0kAa+PgM4pher/i35al/n6sQpyqlBAw==
X-Google-Smtp-Source: APXvYqzI8LYtNA99krDyYdJrbnPVFN00/VQBOGb8UbWp0fin3ELK5c7b8Nol1ZK3tMvJkd9iYwbO2GQPbH3p5eA9CAM=
X-Received: by 2002:a02:6597:: with SMTP id u145mr28812545jab.26.1561370790929;
 Mon, 24 Jun 2019 03:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190620003244.261595-1-ndesaulniers@google.com>
 <20190620074640.GA27228@brain-police> <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
 <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com> <20190624095749.wasjfrgcda7ygdr5@willie-the-truck>
In-Reply-To: <20190624095749.wasjfrgcda7ygdr5@willie-the-truck>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Jun 2019 12:06:18 +0200
Message-ID: <CAKv+Gu8G2GQGxmcAAy1XQ5gkN-2fJSWAKCQQm9T4skYdh5cT3Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 at 11:57, Will Deacon <will@kernel.org> wrote:
>
> Hi Nick, Kees, Ard,
>
> Thanks for the responses.
>
> On Fri, Jun 21, 2019 at 01:27:45PM -0700, Nick Desaulniers wrote:
> > On Thu, Jun 20, 2019 at 1:17 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > On Thu, 20 Jun 2019 at 09:47, Will Deacon <will.deacon@arm.com> wrote:
> > > > On the flip side, I worry that it could make debugging more difficult, but I
> > > > don't know whether that's a genuine concern or not. I'm assuming you've
> > > > debugged your fair share of crashes from KASLR-enabled kernels; how bad is
> > > > it? (I'm thinking of the case where somebody mails you part of a panic log
> > > > and a .config).
> >
> > I don't recall specific cases where KASLR made debugging difficult.  I
> > went and spoke to our stability team that debugs crash reports from
> > the field.  My understanding is that we capture full ramdumps.  They
> > have a lot of custom tooling for debugging, but they did not recall
> > ever having to disable KASLR to debug further.  We've had KASLR
> > enabled since I think the 2016 Pixel 1, so I assume their tooling
> > accounts for the seed/offset.
> >
> > I think if a full ramdump of the kernel image is loaded into GDB with
> > the matching kernel image it "just works" but could be mistaken.  For
> > external developers, "nokaslr" boot time param is pretty standard.
> >
> > > In fact, given how many Android phones are running this code: Nick,
> > > can you check if there are any KASLR related kernel fixes that haven't
> > > been upstreamed?
> >
> > I spoke with the android common kernel team that's trying to burn down
> > their out of tree patches.  I triple checked a doc they had where they
> > had audited every last patch, looking for for KASLR and
> > CONFIG_RANDOMIZE_BASE.  I also triple checked our internal bug tracker
> > for burning down the out of tree patches.  Finally I'm scanning each
> > branch of our android-common trees via `git log --all --grep
> > <KASLR|CONFIG_RANDOMIZE_BASE>`.  I haven't found anything yet, and the
> > team doesn't expect any out of tree patches related to that feature.
> > Sorry for not responding sooner, but I'm still going through our 4.4,
> > 4.9, 4.14, and 4.19 branches.
>
> Thanks for having a look. It could be that we've fixed the issue Catalin was
> running into in the past -- he was going to see if the problem persists with
> mainline, since it was frequent enough that it was causing us to ignore the
> results from our testing infrastructure when RANDOMIZE_BASE=y.
>

I had no idea this was the case. I can look into it if we are still
seeing failures.

> > > So KASLR is known to be broken unless you enable KPTI as well, so that
> > > is something we could take into account. I.e., mitigations that don't
> > > reduce the attack surface at all are just pointless complexity, which
> > > should obviously be avoided.
> >
> > (Note to Sami + Jeff if they had KPTI on their radar)
>
> I mean, we could have RANDOMIZE_BASE select UNMAP_KERNEL_AT_EL0 if you like?
> The latter is already default y and hidden behind EXPERT.
>

IIRC, when KASLR is enabled (and we have a seed), we override the
runtime decision to out out of KPTI, and so even uarchs that don't
require the Meltdown mitigations it provides will still be using it.

So I'd be fine with just adding a note to the UNMAP_KERNEL_AT_EL0
Kconfig help text that even non-affected uarchs have a use for it if
KASLR is enabled, but given that it is already behind EXPERT, I don't
think more hand holding is necessary.

> > > Another thing to note is that the runtime cost of KASLR is ~zero, with
> > > the exception of the module PLTs. However, the latter could do with
> > > some additional coverage as well, so in summary, I think enabling this
> > > is a good thing. Otherwise, we could disable full module randomization
> > > so that the module PLT code doesn't get used in practice.
> > >
> > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Olof mentioned on IRC that I should resend without the other defconfig
> > changes.  Do others have thoughts on that?
>
> That's not a bad idea. If you do that, feel free to add my Ack to the one
> adding RANDOMIZE_BASE=y:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Will
