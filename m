Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90CBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A53F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 20:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiy/oAhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfFUU16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 16:27:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36997 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:27:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so4155988pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KP4ilcPdmABEPlr+/D/amPHFdvJ3gnFsM6KKvQ9drQg=;
        b=uiy/oAhHyz2MdM+IKVm2PkedbYFqmVsW84xl3irtDA3BMYfQqm0Gg1tykK+agogafs
         DF3g8jB3DUUCqykvBSy+FNSvHj7HCbZ2sHwvKQpDIruQvKkfllY8yuf86F5gvcnEnc55
         LAQPaeRWR5ph64I91qFc4P+Yrh6AggqTEGc0s21mD/X8hN/K7zybtZzFH9raxIo9EeU9
         erpCrLhu04QyXG6sdH3ZffAew7wPT4pZpqJg6k6obSHYVPuekln6VojXZhBAwpy0g0YA
         r+millf2OjU8O0JIKzc2tZkMZZMzBWwgL2RZmVMNvohdiTGSOoYsPZJmw4bVft+ErnqR
         S2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KP4ilcPdmABEPlr+/D/amPHFdvJ3gnFsM6KKvQ9drQg=;
        b=HwnU181XSNOc8yzwoFXIhQQ0E2dnbng0Z3kfUcwoeL/WuOoVtHz5APYHP+yXh4z9J3
         kAVLg4UFOKDg8iXAfUjXc1wIkWG7YNWA3dR/pU8pISFnbbZKlNID49xAWEbsEayjUfe3
         zXW5k19nJBxravgxHgJqEXfUaLMCjbW7qM41NJn7aCQtW8YEWQp5IxZhbyAUuAnX6J5G
         WKzcic2VEmvimQ1QMOooCENcR0xhMLxMqmB7TeDuWgrG8rhSkFiomPKvLBOdvyfvebaS
         dk7pbRNwbjg8vYAjW14VrRhpkvl79Frgzcf6CsImuzO+V6JsIVPbhcyDlkus6QnGP7WJ
         O/Ng==
X-Gm-Message-State: APjAAAWFSjPMLGQ863qtlauni1TSAKGNW/X05eK+jL4Jkpid9uhZs5gf
        OviDY9uP+OqGqtmUCo5utwG45VEG3YRwJMTQWLunyQ==
X-Google-Smtp-Source: APXvYqyZQDPJ5W/OCMKlCMRcCGknfUFV38Qj5OmN7kK+QXexoi9ZXQUd+bx6ps5NTYS8DSuqQ+2ur81NrBCeVxmazhU=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr8787354pje.123.1561148877090;
 Fri, 21 Jun 2019 13:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190620003244.261595-1-ndesaulniers@google.com>
 <20190620074640.GA27228@brain-police> <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_KCFCVxw_zAfzUf8DjD4DmhvaJEoqBsX_SigOse_NwYw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Jun 2019 13:27:45 -0700
Message-ID: <CAKwvOdmQ+WdD8nvLz_VB_5atDi56fv485Xsn+mHJZKnyj6L-JA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

On Thu, Jun 20, 2019 at 1:17 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 20 Jun 2019 at 09:47, Will Deacon <will.deacon@arm.com> wrote:
>
> > On Wed, Jun 19, 2019 at 05:32:42PM -0700, Nick Desaulniers wrote:
> > > Generated via:
> > > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig
> > > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make menuconfig
> > > <enable CONFIG_RANDOMIZE_BASE aka KASLR>
> > > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make savedefconfig
> > > $ mv defconfig arch/arm64/configs/defconfig

FWIW, it looks like CONFIG_RANDOMIZE_BASE is set in x86 defconfigs.

> >
> > Hmm, I'm in two minds about whether we want this on by default. On the plus
> > side, it gets us extra testing coverage, although the /vast/ majority of
> > firmware implementations I run into either don't pass a seed or don't
> > provide a working EFI_RNG. Perhaps that's just a chicken-and-egg problem
> > which can be solved if we shout loud enough when we fail to randomize; we'll
> > also eventually be in a better position when CPUs start implementing the
> > v8.5 RNG instructions (but don't hold your breath unless you have an
> > unusually high lung capacity).
> >
>
> For testing coverage purposes, exercising the relocation machinery etc
> even on no-kaslr boots would be beneficial imo. (The kernel is
> relocated once for non-kaslr boots and twice for kaslr boots on kaslr
> capable kernels)

Reminds me of https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd9dde6abcb9bfe6c6bee48834e157999f113971
(but maybe unrelated?).

>
> > On the flip side, I worry that it could make debugging more difficult, but I
> > don't know whether that's a genuine concern or not. I'm assuming you've
> > debugged your fair share of crashes from KASLR-enabled kernels; how bad is
> > it? (I'm thinking of the case where somebody mails you part of a panic log
> > and a .config).

I don't recall specific cases where KASLR made debugging difficult.  I
went and spoke to our stability team that debugs crash reports from
the field.  My understanding is that we capture full ramdumps.  They
have a lot of custom tooling for debugging, but they did not recall
ever having to disable KASLR to debug further.  We've had KASLR
enabled since I think the 2016 Pixel 1, so I assume their tooling
accounts for the seed/offset.

I think if a full ramdump of the kernel image is loaded into GDB with
the matching kernel image it "just works" but could be mistaken.  For
external developers, "nokaslr" boot time param is pretty standard.

> In fact, given how many Android phones are running this code: Nick,
> can you check if there are any KASLR related kernel fixes that haven't
> been upstreamed?

I spoke with the android common kernel team that's trying to burn down
their out of tree patches.  I triple checked a doc they had where they
had audited every last patch, looking for for KASLR and
CONFIG_RANDOMIZE_BASE.  I also triple checked our internal bug tracker
for burning down the out of tree patches.  Finally I'm scanning each
branch of our android-common trees via `git log --all --grep
<KASLR|CONFIG_RANDOMIZE_BASE>`.  I haven't found anything yet, and the
team doesn't expect any out of tree patches related to that feature.
Sorry for not responding sooner, but I'm still going through our 4.4,
4.9, 4.14, and 4.19 branches.

I know I put some backports into an unreleased device's kernel to
support LLD (backports of some of your patches).  All of those patches
are now upstream in mainline, and LLD has its bugs fixed.  In fact, I
think the backports I did of your patches that broke
CONFIG_RANDOMIZE_BASE were actually to support LLD (not Clang) (sorry
again for that).  I'm currently upgrading AOSP's prebuilt version of
Clang.  Once that exists, I'll clean up that device's kernel.

If you know of any android vendor relying on out of tree hacks to
KASLR, and they're getting them from android common kernels, please
shoot me a quick email.  Every out of tree patch is a burden IMO.

Also, for internal code reviews of backports, I've been much
better/more aggressive about the backports being sent to stable (when
they aren't large features) and then pulling them in from there
(sorry, Sami).

>
> > Finally, I know that (K)ASLR can be a bit controversial amongst security
> > folks, with some seeing it as purely a smoke-and-mirrors game with no
> > tangible benefits other than making us feel better about ourselves. Is it
> > still the case that it can be trivially bypassed, or do you see it actually
> > preventing some attacks in production?
> >
> > Sorry for the barrage of questions, but I think enabling this one by default
> > is quite a significant thing to do and probably deserves a bit of scrutiny
> > beforehand.
> >
>
> I think it is mostly controversial among non-security folks, who think
> that every mitigation by itself should be bullet proof. Security folks
> tend to think more about how each layer reduces the attack surface,
> hopefully resulting in a secure system when all layers are enabled.

+ Kees, Sami, Jeff
It's a relatively low cost part of our defense in depth strategy.
Maybe (Kees, Sami, Jeff) have more thoughts?

>
> So KASLR is known to be broken unless you enable KPTI as well, so that
> is something we could take into account. I.e., mitigations that don't
> reduce the attack surface at all are just pointless complexity, which
> should obviously be avoided.

(Note to Sami + Jeff if they had KPTI on their radar)

>
> Another thing to note is that the runtime cost of KASLR is ~zero, with
> the exception of the module PLTs. However, the latter could do with
> some additional coverage as well, so in summary, I think enabling this
> is a good thing. Otherwise, we could disable full module randomization
> so that the module PLT code doesn't get used in practice.
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Olof mentioned on IRC that I should resend without the other defconfig
changes.  Do others have thoughts on that?

-- 
Thanks,
~Nick Desaulniers
