Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CBDC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF47206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Mi9PTtkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKMR0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:26:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35389 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfKMR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:26:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so2949778wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 09:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ne3IB6JUFova0lzzOpPMWzymeDbzsimAaBCz8RRdb34=;
        b=Mi9PTtkIzr+0PMcGE/bBm9Lq/ypoje6GERaznJxRQcp3bbriEbSsx6sIC7o41HhzLM
         JnyVFLZ8MEWgjYltJbjEpR3JwpHmwdgByvX668e3QjuOIIXkukRGze0uLqhswvuW8a6H
         JBaOuWRhOYDLvzriTO1AQpkk/7rQBBJDZ+5i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ne3IB6JUFova0lzzOpPMWzymeDbzsimAaBCz8RRdb34=;
        b=BMPV94VpIA2KRqiQmeBCHN52tui6AdKePcsllPStbpoIZCNmJeQb3IEXRHpF5AxaGz
         YALU5RI4zEfHU3KrFDDbJj7PsKG0fG6+V6Lm4sOM6u/uEVVKJp3w9ViVnO6MjeK4qtbj
         oWxxBu35l2ogfL7588M0o3d/4RpPShpcpllx7z6AjSB/FMGHnd8NJiOGabzuUR5sGdC7
         9H1FtRzqo+8/LHs+s4/4MHJK97t7kbHWIRvm3NV/5x8BRcZfB6ehrayJsZMFVQxfvLjz
         TbeXOvonpLI5Pyo7QMXgF0YL9cW6otTbGGivCX3gPsX/r1FtPYRv7/f58Wuqd3FiOFFt
         bL0w==
X-Gm-Message-State: APjAAAV8bx74BPqoQDAOc811t20g86zIyUBtuB2tKf/hSAguIA7Ug/3Q
        Cp/kch7sbXSm4Ybdp71OBaDsKw==
X-Google-Smtp-Source: APXvYqxCtvJuXqPxIA0Khu8utk9sAVQT2i2beFqWvz4cDuTR2YzISI6cdki5QgFtYGv0aIG12l7Iug==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr3817163wml.100.1573665958483;
        Wed, 13 Nov 2019 09:25:58 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id x9sm3610241wru.32.2019.11.13.09.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 09:25:57 -0800 (PST)
Date:   Wed, 13 Nov 2019 18:25:55 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: ti-tfp410: switch to using
 fwnode_gpiod_get_index()
Message-ID: <20191113172555.GW23790@phenom.ffwll.local>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
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
 <CACRpkdYY_W8_L4---iMORt6vriUa9wKEi0d_kiMRbB_NQatRog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYY_W8_L4---iMORt6vriUa9wKEi0d_kiMRbB_NQatRog@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:52:23PM +0100, Linus Walleij wrote:
> On Tue, Nov 5, 2019 at 4:41 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Tue, Nov 5, 2019 at 4:29 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Tue, Nov 5, 2019 at 1:40 AM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> 
> > > I'm happy to merge it into the GPIO tree if some DRM maintainer can
> > > provide an ACK.
> >
> > Ack.
> 
> Thanks!
> 
> > > Getting ACK from DRM people is problematic and a bit of friction in the
> > > community, DVetter usually advice to seek mutual reviews etc, but IMO
> > > it would be better if some people felt more compelled to review stuff
> > > eventually. (And that has the problem that it doesn't scale.)
> >
> > This has a review already plus if you merge your implied review.
> 
> Yeah I missed Laurent's review tag. I needed some kund of consent
> to take it into the GPIO tree I suppose.
> 
> > That's more than good enough imo, so not seeing the issue here?
> 
> No issue.
> 
> What freaked me out was the option of having to pull in an
> immutable branch from my GPIO tree into drm-misc. That would
> have been scary. Keeping it all in my tree works fine.

For next time around, just ping one of the drm-misc (or drm maintainers)
for an ack to merge it through a different tree. Or ask them what they
want to do. committer model isn't 100% free-wheeling, for cross-tree stuff
you still have maintainers who're supposed to do their jobs :-)

But by default everyone will assume you'll just commit, so you need to
poke them explicitly (like you've done here).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
