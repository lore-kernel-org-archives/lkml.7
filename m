Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28324C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29A0217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Si47Mpri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbfKEPlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:41:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35818 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389032AbfKEPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:41:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id z6so18013366otb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYpV5+o1A/dXvbQaQ7n7dcL2+JD79qjMx+pIX36zQXU=;
        b=Si47Mpriw1EKXcSZsKuCqlPm4/dogrxQwhOJv0m772xFHmIUe052ovmhrkWgGU+Bkl
         jZ5bwHGw4D+uiMu+tsUEztuFOU+SRx0OYmKjn34Oa0IqeWEfvy9uB3oFmhEp4Bk6BxU9
         q1whDXxaitjDU2vXBm44oZTDU/eQILq9K0+wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYpV5+o1A/dXvbQaQ7n7dcL2+JD79qjMx+pIX36zQXU=;
        b=kDS0UkTOQXT/S4hFszQLPgC/sgu2MAdE9Jp1cqKPKEw2JOSo9lKT+fZZ/7uNjuHIEK
         LNHa1vboFPun47V6VTeuFQlijaJm+g+WCmBOkdtINkJQV66dwK7I2CU/uexDqB6ttuhN
         KhLkw9AvOKX0b9xx3uJ4H99+7i0ySD8Sj5V7BdZJPVS73eImLBUH3egpzpBFoEguMfdV
         k2sA9z0Mr3sXMi/jMV6xKJZiusL8+VIFp+pe/tIHAVTuw0ETf6d2X0wQYdYDhnUHxxfv
         NLTqxLqgkWRmG9Y6fQPLzxAEm5gHKSwo4uFjsMcn3iEgd8ts3lZ2Pfne4XkWYWdDF3uX
         67YA==
X-Gm-Message-State: APjAAAXJyjegyyK2qV358DxDyBg+Fjcb0LFLopMj4HE5QJZaFhxmEbtF
        5Sk7/2dHXfG+8DXPu1ODIX8qFuY28OKOAFz4+xNUQQ==
X-Google-Smtp-Source: APXvYqwsv1as2ejBQgt0yF61DLtdufwSuN9OWBbVoSv6U2YVvVTmDaT6G27AR5seiL/WGxW7SuFgVJ7Uw4VuuLDjWUY=
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr1965788otr.281.1572968512490;
 Tue, 05 Nov 2019 07:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20191014184320.GA161094@dtor-ws> <20191105004050.GU57214@dtor-ws> <CACRpkdak-gW9+OV-SZQVNNi5BuyNzkjkKvHmYp2+eYq4vu2nyg@mail.gmail.com>
In-Reply-To: <CACRpkdak-gW9+OV-SZQVNNi5BuyNzkjkKvHmYp2+eYq4vu2nyg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 5 Nov 2019 16:41:41 +0100
Message-ID: <CAKMK7uG7FQ3bDWsTxq0n8Osh7jjws5ia3PFJXvDdo=nxKu7+Ng@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-tfp410: switch to using fwnode_gpiod_get_index()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 4:29 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Nov 5, 2019 at 1:40 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Oct 14, 2019 at 11:43:20AM -0700, Dmitry Torokhov wrote:
>
> > > Instead of fwnode_get_named_gpiod() that I plan to hide away, let's use
> > > the new fwnode_gpiod_get_index() that mimics gpiod_get_index(), but
> > > works with arbitrary firmware node.
> > >
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > >
> > > Andrzej, Neil,
> > >
> > > This depends on the new code that can be bound in
> > > ib-fwnode-gpiod-get-index immutable branch of Linus' Walleij tree:
> > >
> > >         git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git ib-fwnode-gpiod-get-index
> > >
> > > I hope that it would be possible to pull in this immutable branch and
> > > not wait until after 5.5 merge window, or, alternatively, merge through
> > > Linus Walleij's tree.
> >
> > Any chance this could be merged, please?
>
> I'm happy to merge it into the GPIO tree if some DRM maintainer can
> provide an ACK.

Ack.

> Getting ACK from DRM people is problematic and a bit of friction in the
> community, DVetter usually advice to seek mutual reviews etc, but IMO
> it would be better if some people felt more compelled to review stuff
> eventually. (And that has the problem that it doesn't scale.)

This has a review already plus if you merge your implied review.
That's more than good enough imo, so not seeing the issue here?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
