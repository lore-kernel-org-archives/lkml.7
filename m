Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B22CC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5146F21D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uo8KLjMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbfKEP3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:29:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39369 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389962AbfKEP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:29:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id y3so22352492ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28try4muClFQlh9iqHPnuMbdLAxeCEgg636Rpb1wZM8=;
        b=uo8KLjMarHlD53eWZPrliRhD2xVf0hN4iqn+31jBXWm2aAP/tEyuSyteVhFDm9YH4L
         tFHvrtdmpuTvdt6I9MUh2YqvgIMac1r3Kv870L38T8Tc7l1v0IqTFkLpX8eEl7ktLQcz
         GboVdtCINpiR2TmJO0P35K4JZWIg1QL3/bl7byWg4vljyN+4S+NFhQG36YQpZv8ue3Nj
         QW5grIFQF1eg6TswdZFU0HNtV+ZUpJffTh0Mugnt5dfzmFSLmj+2YhdzaL56+v2TUnoD
         TT78Zucz1PC0L7oI5GYCKQn++/XY9bu+eE4rUukb3yd17VkJakaNTNUIOh7QAqb1P1ge
         4JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28try4muClFQlh9iqHPnuMbdLAxeCEgg636Rpb1wZM8=;
        b=K3XsLvlEJUkrBpwo9bBluSFS3HZvGj6+TNuNhnJJlcZGx5+/fcE/ddYF/XICKE37k2
         saZqLNym/UEQuclJpKqofnno3n0JFSbHBg0C0led6NISqsu6NtgkjLA9z0wmc4iSHCEF
         1jd7EGeyoOqY4FjEZGOPZkgWm56uBhcVO2eI7l2amXn8PWczGij/jyiJzkeLlMI0K6Jm
         sl6+LlDNcHQfl0A+ez0tJSrUFyzxBNo0D/7D2rLjRKZgPPd0DIr23El8u7iS46IP3n/f
         x5VZZeCQ6YZBO0So0se6frdCD4QERpFYlE/8w2oEoTdbH1mlzlrVdV5cQTQ/xCnUF+lW
         xoBQ==
X-Gm-Message-State: APjAAAWxGCiFsZfx1yzhSNdedhA0/wRrXC9WmyVNb/AEB04dyAvvkRSl
        4bKXPCmw1zVcmpf51mjDEmgO1iqkP4hn6NhSMG3uzA==
X-Google-Smtp-Source: APXvYqxEL3fqUDLcfo6mqdD0ClDkn2bxHuGMnRoW5eEjhGzajtl3kL3nBMiBE8xX5dO1ORsfFdRO106BZJVC38Tulao=
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr23933312ljm.77.1572967790855;
 Tue, 05 Nov 2019 07:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20191014184320.GA161094@dtor-ws> <20191105004050.GU57214@dtor-ws>
In-Reply-To: <20191105004050.GU57214@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 16:29:39 +0100
Message-ID: <CACRpkdak-gW9+OV-SZQVNNi5BuyNzkjkKvHmYp2+eYq4vu2nyg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-tfp410: switch to using fwnode_gpiod_get_index()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 1:40 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Oct 14, 2019 at 11:43:20AM -0700, Dmitry Torokhov wrote:

> > Instead of fwnode_get_named_gpiod() that I plan to hide away, let's use
> > the new fwnode_gpiod_get_index() that mimics gpiod_get_index(), but
> > works with arbitrary firmware node.
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > Andrzej, Neil,
> >
> > This depends on the new code that can be bound in
> > ib-fwnode-gpiod-get-index immutable branch of Linus' Walleij tree:
> >
> >         git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git ib-fwnode-gpiod-get-index
> >
> > I hope that it would be possible to pull in this immutable branch and
> > not wait until after 5.5 merge window, or, alternatively, merge through
> > Linus Walleij's tree.
>
> Any chance this could be merged, please?

I'm happy to merge it into the GPIO tree if some DRM maintainer can
provide an ACK.

Getting ACK from DRM people is problematic and a bit of friction in the
community, DVetter usually advice to seek mutual reviews etc, but IMO
it would be better if some people felt more compelled to review stuff
eventually. (And that has the problem that it doesn't scale.)

Yours,
Linus Walleij
