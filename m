Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6EEC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7927D215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQiziV51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfJDWVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:21:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39371 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:21:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id 72so5494965lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9NX5JuTWafrd7iXTgyMS4RoKwJ5yHBPv8xmUFX4nrZA=;
        b=MQiziV51a+gwItEpIvETwGGmI9QP0PC5GgUZXP/g56eByqgN3NZLQopBV1GRv2Bf3O
         U8sZhi4oYdp9BmSQN3toekTctMA9R3y6hXVohUHuYjstpKA3eqv2ulSEbAjwGoBXbtR5
         4XwdUzQsr1XOvxUr51XcmtfeSl1GGHz2QPOWcPL/A+lgIx8EgRx83tJqeUc319yBJiFr
         tiOH+0i9jZMuoIFCNAKKcgrhpB52LNBLj/x9F/yYhwEasRC0f94CKAWg/yS/0qOYsW+B
         UzCRpmdTQ1XF5zhwp6wMByySoDX1m3Jz2OI7Zz+uP8mDLmKkQklsdlVlvHM6UIhDP7Ah
         waKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9NX5JuTWafrd7iXTgyMS4RoKwJ5yHBPv8xmUFX4nrZA=;
        b=fzuxBYQQ0qQYQtzU+f5iTDxo/yY/H6VjgIe9RyXwcuc4ky9r361hi9QRs5zlsxQMen
         x5bhU5liCbEgZwZ73DZTBR5mPg2CVoQPd+S0Zc6gK4mVxbffovAvgiiMqaS7tnUCyXiA
         FcCz4AxC2CYwAqDGY9d/bTEmDCbOn0AmcXMoMsLEmVtiWkgVfjdSoEoD5YdNo0iOgZ7k
         aOEu5Sz4FIS1FS6/i8PuXJQbz8Zr23j3sLSeNTV/yzNg/L3FP9tfqRZTlGrgLBpyPZkc
         nT6YvCm2APC9Bb7pjGDEyL+mXn5QIz7cG3txBH8zGqmcCH4Gb/H/xq3Az6JECI8bSmmA
         489Q==
X-Gm-Message-State: APjAAAU8V/v0EVdpzILM/+98VgePS8k84NkEeX49pyv46ps/BANto5fY
        g8l+E7EQynpztQsEKRaSNwTpF0yMzzOn2WZ7N/KJvSn2gvg=
X-Google-Smtp-Source: APXvYqxO/Wj6yEjUFPz44eOAVE0OIWbXwEw1qgTNOC8kPeD8B+ai3ePplrGXWyqLgU0QgY9MZ/8+S34Igmsja/QXRvg=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr10232582lfa.141.1570227662211;
 Fri, 04 Oct 2019 15:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191002153827.23026-1-j.neuschaefer@gmx.net> <CACRpkdZ0ekYtZ4bZ-A4NZN6HO6XJzwpdZ_HjUL=FoWfG08UBtg@mail.gmail.com>
 <CACRpkdYDuAx6OhFYiXT+79a1NphtfPQfyY=o7jKi0Bas5vr7+g@mail.gmail.com> <20191003151555.64qabct3jmd74ypi@gilmour>
In-Reply-To: <20191003151555.64qabct3jmd74ypi@gilmour>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 00:20:50 +0200
Message-ID: <CACRpkdaOxKPd2CrB4F7QQasov85C83f3NEqS8TvrzKXiC8-+uQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mcde: Fix reference to DOC comment
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 5:15 PM Maxime Ripard <mripard@kernel.org> wrote:

> > > > Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE=
")
> > > > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > >
> > > Both patches applied!
> >
> > ...but I can't push the changes:
> >
> > $ dim push-branch drm-misc-next
> > dim: 9fa1f9734e40 ("Revert "drm/sun4i: dsi: Change the start delay
> > calculation""): committer Signed-off-by missing.
> > dim: ERROR: issues in commits detected, aborting
> >
> > Not even my commit, apart from that it looks like it does have
> > the committer Signed-off-by. I'm confused and don't know what
> > to do... anyone has some hints?
>
> Yeah, it's pretty weird, I just pushed without any trouble.
>
> Did you rebase or something?

Nope... even tried to reset hard to origin :/

I guess just try again...

Yours,
Linus Walleij
