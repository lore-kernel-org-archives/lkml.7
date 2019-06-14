Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1338C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03412082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ooZzfFJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfFNK4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:56:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34257 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFNK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:56:42 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so4864158iot.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06iI6z4cthU4ce66OeHWQkRCnmuFyEIHHZ9Es1yn3sc=;
        b=ooZzfFJD2u9j2LussEGHFOPOfLBkJ+BU0GJHPBhgAJ/vkF6JbiQbi3Z9LCSduATYrm
         pmqk7dvkdE04MoEJvLFEsmWLKI31BrB0lbpcgBa7PmY2Pqee615LcMhMjtdzFAWkeAol
         te7vdgYxjdEddafQhiDTatljo0z/1a5LRul94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06iI6z4cthU4ce66OeHWQkRCnmuFyEIHHZ9Es1yn3sc=;
        b=KFZBOf1xB6qy7k0lRpNqI8S6Fkx7L3IoUOhast9ERJ8A6/zbzxosTdJMjogZ2Q1cQv
         sm31jW4zS7rW8SnCftYJXa94X8cfkSo1Nx+QSqiStfNkum4eRfNGDNzecEj2pu5WJ9+j
         g8rjSGue0LIfrM1YZd3qN+tDsmGDvPQDUYii7MxcXzCFF55wn2YdAZ+pLtAJ0ShSLQHF
         r7j8CR/vEI/ghcGk4+0mU8lPCFbfPcHhILTYvu1DIXnF3o2lD3L43UW40JEnNeoxeRtX
         JJzjcCR4eqihO+4qSYSy7ShjNHTXtjwhIk4OGM1WHjKeDNUscvP2Ra1MUpCblFLIOSrG
         Bc3A==
X-Gm-Message-State: APjAAAV5zhiTPdaMkVBmP3n/F4HbNYdVY5ajOJRCv10pvRwJc6M3dYwU
        UrfumPpjLqULQkJhVQ27NeQ69IAVqpbFKcY/36O1tw==
X-Google-Smtp-Source: APXvYqwkcIwVPtfblhejh6xHVBtwFYzc9v3JjBjZavec/51f+nlxxqOghRWbuFOJBMDNowUmrcO58Fw+cwukMr5fTSU=
X-Received: by 2002:a05:6602:2253:: with SMTP id o19mr14463706ioo.297.1560509801785;
 Fri, 14 Jun 2019 03:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
 <20190613185241.22800-3-jagan@amarulasolutions.com> <CAGb2v65xuXc4C1jOyM1GbEFVDam5P-6NN0ZhtzwzA7qU5F3nJQ@mail.gmail.com>
 <CAGb2v67DY534hXrx2H4jnZXA7jJS7sq2UwYCqw1iAgyLKdNzgA@mail.gmail.com>
In-Reply-To: <CAGb2v67DY534hXrx2H4jnZXA7jJS7sq2UwYCqw1iAgyLKdNzgA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 14 Jun 2019 16:26:30 +0530
Message-ID: <CAMty3ZBc-AqbNGZCxRhOPw46iMvEZxoq1oATA46=K29gRYi4Sg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/9] drm/sun4i: tcon: Add TCON LCD support
 for R40
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 9:05 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Jun 14, 2019 at 11:19 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Fri, Jun 14, 2019 at 2:53 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > TCON LCD0, LCD1 in allwinner R40, are used for managing
> > > LCD interfaces like RGB, LVDS and DSI.
> > >
> > > Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
> > > tcon top.
> > >
> > > Add support for it, in tcon driver.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> I take that back.
>
> The TCON output muxing (which selects whether TCON LCD or TCON TV
> outputs to the GPIO pins)
> is not supported yet. Please at least add TODO notes, or ideally,

Are you referring about port selection? it is support in
sun8i_tcon_top_de_config.
