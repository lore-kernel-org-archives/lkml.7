Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF7C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46944217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WCwD54c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfKFJwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:52:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43051 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKFJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:52:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so24933149wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 01:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uCkx2NozxMaeNkrsz7EMpm21ukg71K77/waY5+1TSls=;
        b=WCwD54c3npOPHXAP4xGIZoi+KxNI0Wra0FUQc+WOKuP65BTREKcW1l2Px8Cy5d7Hvf
         RsnnX7VENbarQfmGgwgmypWiHj4Noz1Ts34CB2uRBr36vyCBKg3YP1rnO8oJ2+hKTnnA
         2mcXMzgkd/9aX8Mm+HBqytVbf8+3bOW6tICyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uCkx2NozxMaeNkrsz7EMpm21ukg71K77/waY5+1TSls=;
        b=p/L/HeG8XJ87HvVHce12UR3pQxBw/GTKPhEUDUVVa3bNAcHjYNYHN8XqVEfPR/KypS
         33IJyqefK7jGrVcI65S9ZHj2NThgLVbbc1YuJkyBv2Kopa5FFGdx+Y3rfDS9qn0WWokr
         GpOXF02bhf/5SwkkULYCj2/guusYv11zclBGCdW0vwh971vaHzeGQy5LTxsGMFjZGSWV
         XvD8QsWOybynr9xo+Ada7YoYLVJxvkOEA8dO2lWJDguC+4Kkd25eZq4PCVlKiq4bJaGd
         rGPzI3bkqFsKoGxUIiQWmL3r/7dKSZ3/FZRtQgWfklYGQR1oyBCKDWI5Mnrb75pzkATC
         MLZQ==
X-Gm-Message-State: APjAAAUQJHEfpaBOLruu/wBXceBmu96aBDL5iV50RxJ7YfMD7Em9oKLd
        9EVjaISwpDclMmfnHSHVO6dS/Q==
X-Google-Smtp-Source: APXvYqy8SOiPH2SZzS90gKSp/dp4epdL+H8v3Vlhplrbbnp18EozMW5rOerNGE8QMR95g/PO5WVynA==
X-Received: by 2002:adf:8011:: with SMTP id 17mr1804211wrk.367.1573033937277;
        Wed, 06 Nov 2019 01:52:17 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id u4sm13466822wrq.22.2019.11.06.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 01:52:16 -0800 (PST)
Date:   Wed, 6 Nov 2019 10:51:32 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: ti-tfp410: switch to using
 fwnode_gpiod_get_index()
Message-ID: <20191106095132.GA23790@phenom.ffwll.local>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191014184320.GA161094@dtor-ws>
 <20191105004050.GU57214@dtor-ws>
 <CACRpkdak-gW9+OV-SZQVNNi5BuyNzkjkKvHmYp2+eYq4vu2nyg@mail.gmail.com>
 <CAKMK7uG7FQ3bDWsTxq0n8Osh7jjws5ia3PFJXvDdo=nxKu7+Ng@mail.gmail.com>
 <20191105195323.GC4869@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105195323.GC4869@pendragon.ideasonboard.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 09:53:23PM +0200, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Tue, Nov 05, 2019 at 04:41:41PM +0100, Daniel Vetter wrote:
> > On Tue, Nov 5, 2019 at 4:29 PM Linus Walleij wrote:
> > > On Tue, Nov 5, 2019 at 1:40 AM Dmitry Torokhov wrote:
> > > > On Mon, Oct 14, 2019 at 11:43:20AM -0700, Dmitry Torokhov wrote:
> > >
> > > > > Instead of fwnode_get_named_gpiod() that I plan to hide away, let's use
> > > > > the new fwnode_gpiod_get_index() that mimics gpiod_get_index(), but
> > > > > works with arbitrary firmware node.
> > > > >
> > > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > ---
> > > > >
> > > > > Andrzej, Neil,
> > > > >
> > > > > This depends on the new code that can be bound in
> > > > > ib-fwnode-gpiod-get-index immutable branch of Linus' Walleij tree:
> > > > >
> > > > >         git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git ib-fwnode-gpiod-get-index
> > > > >
> > > > > I hope that it would be possible to pull in this immutable branch and
> > > > > not wait until after 5.5 merge window, or, alternatively, merge through
> > > > > Linus Walleij's tree.
> > > >
> > > > Any chance this could be merged, please?
> > >
> > > I'm happy to merge it into the GPIO tree if some DRM maintainer can
> > > provide an ACK.
> > 
> > Ack.
> > 
> > > Getting ACK from DRM people is problematic and a bit of friction in the
> > > community, DVetter usually advice to seek mutual reviews etc, but IMO
> > > it would be better if some people felt more compelled to review stuff
> > > eventually. (And that has the problem that it doesn't scale.)
> > 
> > This has a review already plus if you merge your implied review.
> > That's more than good enough imo, so not seeing the issue here?
> 
> Isn't the issue that the patch should have been picked by someone for
> drm-misc ?

It requires prep work that isn't in drm-misc I thought? Anyway, Linus has
commit rights to drm-misc, could also push it there.

Plus you have, except you don't want it.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
