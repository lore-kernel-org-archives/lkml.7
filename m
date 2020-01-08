Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4404DC33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2372070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RTIHSC/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgAHCjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:39:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43273 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:39:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so1362787qke.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 18:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imZn+Ec+Is2o2WWsfLwBIjwDvv9tZ0cym99jWLIGp0g=;
        b=RTIHSC/+7ysjfzJoIYGjrcrngxwtrtX8VdXagMorsS5Ct9CaD6REuwypvXPlyJHBJO
         pGMfW2ZMmB5uGsRSrnAlxL45XCtymJBLzJyeLNT8QhUBhUC6VbQRQ3B5addAuDXwQ6YH
         2rOvYUzgJGMK716x4tTn6y3vmkfR3TgM3tYkZyGwXRvFuM0CbR9TVr8RYK+NFWhWjokW
         x24dyeb1A+WOc9thbtX6VE3tkn+u2pQoZHKic4tcBHljKNkb6K4VJwDp1udY4oUyaoWE
         tDp5ZHyi5nCEFzqWBSC3KKQ75FJ7aPREZzEfZ9ItFHOFBBBVf+V01ZRNN8fHf1+2A+u/
         0czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imZn+Ec+Is2o2WWsfLwBIjwDvv9tZ0cym99jWLIGp0g=;
        b=s3G5dkSyeQhJUiV888GRJyCwZrIEKzyB/bfEQIKMFkd+STzVKxIohxYxhu7Y73Hip6
         vmCpgbs77drhT93fwnewH0J6Efu6yP0gagxmCCtht+HpZyP/ov6Th2e//yBqDPJjWH95
         ZPq5cjFoMEQX0jQYy7HyFMkiZuoDMKj5b57ugzmIO0JvulAhaD2yaFetf6WIjLWZUae5
         wQ7Vrf/51aFHgy/wcqGxCLy+6AYLdI+paXPh4ojpAfXmCNfQrwa+CZQdG9mDWw8R9TDW
         +zOugaLGPzq2cQkw9fxGyLDkD/Bz+I5F9NiG4aTYqrrnZo4hmGYApv4d/Stpu9BxwMyJ
         22bg==
X-Gm-Message-State: APjAAAVHhjzg80x150UjcuAjTr4mJJ29KQFZP1FgjyQksHudiatWPV+1
        OQps6RE74NAtJMdqCQPvjYsVssFl3fmZhY34qb+tZw==
X-Google-Smtp-Source: APXvYqx5TRVgUJMNHuC2iaHQrk2At/FlzCevHvo++QNAvQL3DZYAMXmCZ3KV6nWwtYHpKK6u/lh94EXtMK7n7GrVOjs=
X-Received: by 2002:a05:620a:992:: with SMTP id x18mr2284951qkx.327.1578451187096;
 Tue, 07 Jan 2020 18:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20200107091618.7214-1-greentime.hu@sifive.com> <alpine.DEB.2.21.9999.2001070253000.75790@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.2001070253000.75790@viisi.sifive.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Wed, 8 Jan 2020 10:39:34 +0800
Message-ID: <CAHCEehLz9MfTyOPf42xPbT7FM8oO--C-hT4eVcNkXMG1vnBjmg@mail.gmail.com>
Subject: Re: [PATCH] riscv: to make sure the cores in .Lsecondary_park
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Gt <green.hu@gmail.com>, greentime@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 6:54 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Hi Greentime,
>
> On Tue, 7 Jan 2020, Greentime Hu wrote:
>
> > The code in secondary_park is currently placed in the .init section.  The
> > kernel reclaims and clears this code when it finishes booting.  That
> > causes the cores parked in it to go to somewhere unpredictable, so we
> > move this function out of init to make sure the cores stay looping there.
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/kernel/head.S | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index f8f996916c5b..d8da076fc69e 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -217,11 +217,6 @@ relocate:
> >       tail smp_callin
> >  #endif
> >
> > -.align 2
> > -.Lsecondary_park:
> > -     /* We lack SMP support or have too many harts, so park this hart */
> > -     wfi
> > -     j .Lsecondary_park
> >  END(_start)
> >
> >  #ifdef CONFIG_RISCV_M_MODE
> > @@ -303,6 +298,14 @@ ENTRY(reset_regs)
> >  END(reset_regs)
> >  #endif /* CONFIG_RISCV_M_MODE */
> >
> > +__FINIT
> > +.section ".text", "ax",@progbits
>
> Can the __FINIT be dropped?

Yes, Paul.
It can be dropped. I'll send v2.
