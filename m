Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D1E20659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575363322;
	bh=m31aHcD0txfHJWKNc3ry756pAIVc76wigOfC41CiuM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sGG0fWj5T/kewUPtSzXEn6d8en7o0lhN9ys1vd4/7XEyF5OKDF2U1eJMttMCTphH5
	 cH/YWarcHOm924tub/APbWxEyiZa7hVtrEEXLjbjSLDb25ERB0k89UBGsGY3Rh42NK
	 eFgnh0pCC+mc4wNyEcRWsGwT52KSSr63B7FBDhus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCIzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCIzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:55:21 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2707720659
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 08:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575363319;
        bh=m31aHcD0txfHJWKNc3ry756pAIVc76wigOfC41CiuM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WS+GCjTdSmvP1K/ViX64PcBDw+zuAXYbYZN6tWV8P//zN2g6ESkoJDHzuoOjTCZ3l
         iguq6sHUxBJsCQpdduX4/r6+qOa266CB+PM+cyKJZWrGpK5ryDLCKRrlLKRZTPgBXC
         ax6uVafGMzRiKrIuvJb6KXjZOffOtCisuMWx9+4k=
Received: by mail-lj1-f182.google.com with SMTP id d20so2780523ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:55:19 -0800 (PST)
X-Gm-Message-State: APjAAAUXlu8aGmxDmP1DbFLnNcOj0hPrZuKzyToWl3XIDCZZpuK0Xa8K
        Do00MUrrVRukX8wPNjJKhdgKtrqMutPokRJNwvk=
X-Google-Smtp-Source: APXvYqznGhY18iGzPMVXELvCtR8ehYByGaG/fsz3XPcxRM4rSVGa7ldqi9qmLor4YDyMLU4DcZEWUwxp1+oDS/K7bgU=
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr1954358ljl.74.1575363317362;
 Tue, 03 Dec 2019 00:55:17 -0800 (PST)
MIME-Version: 1.0
References: <1574906800-19901-1-git-send-email-krzk@kernel.org>
 <87a78gnyaz.fsf@intel.com> <ab3309596fac1c5a0cb4e0abed0cf1ee7ac13a3d.camel@perches.com>
 <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com>
In-Reply-To: <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Dec 2019 16:55:05 +0800
X-Gmail-Original-Message-ID: <CAJKOXPdJ=-yPR8-=4DiREXj6aA+Qufn_uFhViyWU+mSvqPu9cA@mail.gmail.com>
Message-ID: <CAJKOXPdJ=-yPR8-=4DiREXj6aA+Qufn_uFhViyWU+mSvqPu9cA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Look for Kconfig indentation errors
To:     Joe Perches <joe@perches.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 at 16:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 28 Nov 2019 at 17:35, Joe Perches <joe@perches.com> wrote:
> >
> > On Thu, 2019-11-28 at 11:29 +0200, Jani Nikula wrote:
> > > On Thu, 28 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > Kconfig should be indented with one tab for first level and tab+2 spaces
> > > > for second level.  There are many mixups of this so add a checkpatch
> > > > rule.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > I agree unifying the indentation is nice, and without something like
> > > this it'll start bitrotting before Krzysztof's done fixing them all... I
> > > think there's been quite a few fixes merged lately.
> > >
> > > I approve of the idea, but I'm clueless about the implementation.
> >
> > I think that a grammar, or a least an array of words
> > that are supposed to start on a tab should be used here.
>
> This won't work for wrong indentation of help text. This is quite
> popular Kconfig indentation violation so worth checking. I can then
> check for:
> 1. any white-space violations before array of Kconfig words - that
> 2. spaces mixed with tab before any text,
> 3. just spaces before any text,
> 4. tab + wrong number of spaces before any text.
>
> It would look like:
> +               if ($realfile =~ /Kconfig/ &&
> +                   (($rawline =~
> /^\+\s+(?:config|menuconfig|choice|endchoice|if|endif|menu|endmenu|source|bool|tristate|prompt|help|---help---|depends|select)\b/
> &&
> +                     $rawline !~ /^\+\t[a-z-]/) ||
> +                    $rawline =~ /^\+\t* +\t+ *[a-zA-Z0-9-]/ ||
> +                    $rawline =~ /^\+\t( |   )[a-zA-Z0-9-]/)) {

This unfortunately fails if help text starts with one of syntax
keywords (e.g. "if"). Isn't this getting over-complicated? The Kconfig
is rather simple:
1. no indentation,
2. one tab,
3. one tab + 2 spaces
4. one tab + 2 spaces + some more spaces (e.g. help text)

Best regards,
Krzysztof
