Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E35D20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k91bRGN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfCEXUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:20:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32893 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:20:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so6891477pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=atDff7xgAoWy20m12k+3BQF0RXwf30PCgVym+g735tM=;
        b=k91bRGN9dN9w/ZM+rhdTOYmPES+sQnVuRuAS8Ry4CFLIL37SdaeEmsA/ee3adhzGG/
         b6PQmgxOpygrJcFJZmIf/ZEilFUFziWjp+a/Mo9yK7H8jDKDAYw3QGHAvQwTaqwRbwDo
         htm0QNaC2BF+p2m9GYdOhiY+DoacBd4B0D1Uqar0mYScc/OojONAARxLWIez652npXER
         qJCJFDJhwfUFtJ4j7cRxfVWa3urJ/my+7BDZtqvrLy8wpXDFYanlKNiwX1whwFzM1hZ7
         XNOy0OqKpDjnVElH7twgcG6FAWGOfRM5cqnb9pxy9y9cV2F0XGjCLy+tsxYZHW9ALdxq
         x13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atDff7xgAoWy20m12k+3BQF0RXwf30PCgVym+g735tM=;
        b=VWXvbWUSERxBhRYbE7OYK2ONMlIpcoCCqrvvBxeMev2Wddw5VrW/ET+pSXksS45Q/L
         eKz1I/D3XxLU3Su7IlVeqf/EYMOTutpCcAKfq+esQ48kTzqzu2uAdT6Sixc4uudoVuID
         H93sknpJgnDZM7uo97D61jG4haOaHFMjU7R18uOemWf7RLzSdK91CIPgMO5sQrqCebKA
         qZ86ogswn3FXq2GTt4I2YaZMLC8e5gE4aEXH9xl8cSNPt7gSbilgKTgnPoosoD7aZLTh
         1TgHNdzyLo6tXVE7LFEEfago58V88Ummezmi+65QLjEnZOMM2jYR3v9ZOIKOHNKqEE7I
         +yXw==
X-Gm-Message-State: APjAAAVwXCuJH4xfAfMraQkiDOHczo0go+weQHWgvHoi18oW0VUMk+q4
        a69g6qcBd+t004zFs1p4q71zKmCK5x62iMpxvmXCJA==
X-Google-Smtp-Source: APXvYqybQA9BGLe5plA87rd0H0RtSs1n3ebB1trqHn6vOpR+Up7oqi6WNN3m71Un0MSlseFbPyOgt+mX+vnDq182pws=
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr3768906pld.238.1551828029456;
 Tue, 05 Mar 2019 15:20:29 -0800 (PST)
MIME-Version: 1.0
References: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
 <7b70b64738db468ab3b830c503524058163b5c3f.1551824161.git.stefan@agner.ch>
 <CAKwvOd=1sEfg94kg6gbjCrrn3Wcp7BuwWKtGdD9pr_+P03eTMQ@mail.gmail.com> <f822090431e21d31b0b4fcd98c983d60@agner.ch>
In-Reply-To: <f822090431e21d31b0b4fcd98c983d60@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Mar 2019 15:20:18 -0800
Message-ID: <CAKwvOd==1Zb+Kj5yQ4UErKST_5v8mBm=wgkt5weHfXp=L=33Jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: drop -mauto-it
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        julien.thierry@arm.com, Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 2:40 PM Stefan Agner <stefan@agner.ch> wrote:
>
> On 05.03.2019 23:21, Nick Desaulniers wrote:
> > On Tue, Mar 5, 2019 at 2:17 PM Stefan Agner <stefan@agner.ch> wrote:
> >>
> >> The assembler option -mauto-it is no longer a valid option. It has
> >> been removed from the documentation in July 2009, which is well
> >> before the release date of the currently supported binutils version
> >> 2.20.
> >
> > Do you by chance have a link to the relevant commit?
> >
>
> Documentation got removed in
> https://github.com/bminor/binutils-gdb/commit/529707530657a333a304c651c808ea630c955223

The minimum version of binutils as per
Documentation/process/changes.rst is 2.20. Looks like 2.20 was
released around 2009-09-04:
https://github.com/bminor/binutils-gdb/commit/81c23f829ee829524ac3bf0b9422f8950306d1d6#diff-2bb5799f8d22903a285e71e925800c08

>
> I think -mauto-it never really made it upstream. Documentation has been
> introduced here, but it seems that the option already has been renamed:
> https://github.com/bminor/binutils-gdb/commit/e07e6e58be1c5273ed79a25c80ba831e71ac86b1
>
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >>  arch/arm/Makefile | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> >> index 9561325c5201..ebf67bebe73d 100644
> >> --- a/arch/arm/Makefile
> >> +++ b/arch/arm/Makefile
> >> @@ -113,8 +113,7 @@ CFLAGS_ABI  +=-funwind-tables
> >>  endif
> >>
> >>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
> >> -AFLAGS_AUTOIT  :=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
> >> -CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT)
> >> +CFLAGS_ISA     :=-mthumb -Wa$(comma)-mimplicit-it=always
> >
> > Is $(comma) still needed? I thought it was only needed when a flag
> > that would contain commas would be in another set of parens (thus
> > making an ambiguity), like cc-ldoption or such?  Can you replace
> > `$(comma)` here with `,`?  I suspect it should work.
>
> Could catch, yes comma should work here.

Cool, if you wouldn't mind sending a v2 with that change, feel free to
add my reviewed by tag.
-- 
Thanks,
~Nick Desaulniers
