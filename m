Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25E6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06A62084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="TDOw0JqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEOSmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:42:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41414 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEOSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:42:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id y22so879356qtn.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1reD9us9N5mO/PuTxFUyMzUfJf88hZBU0BFrHnbD0Bo=;
        b=TDOw0JqG4MjKV/6oPistcSMXTCPQKhxSgzGJ/dexYJdSGe/daqrONJ1A9P2mr4N9vE
         LNAL0hfNzpBNmX2d16ydeNQrlLloRhFKn763PhLvoNiPF0YpYM3ij0yYm+5NNLBjVUOn
         ygtIVMAFfXUxICL4Geq/Pm0Dg+Cg4ZmOop6JOMf0GkEe+byYEQYqN3SWvLSXOqCrQshi
         P4lgu+IZ/vH/7qZg3HYwntrYlEyu2dHKA1yELq4rFLP36JN7QwfkaKh7fUt4Rf2RC1ju
         5jJvgI9D30JfE4j3f8KNHKrbV3P/j6dM7gdz5yw++DQd5s7tncpv42Se5FAZf3DByu81
         rfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1reD9us9N5mO/PuTxFUyMzUfJf88hZBU0BFrHnbD0Bo=;
        b=fYg4DCSc9lT4eBY1OOTtOrJK8ezwzOpYjxcSf4HlLRrBRMnZA5sE3u6Gu4WB1h4Bhi
         qC8io8zgjOLj+D50shq4e9e83aRvpf692qjTaq5bklNxj/jSCHNyjIcaWPXKxdrdZ0RA
         A3KrrQGDRbeXfYc9dM8wieoj4u0nztzzMxOAzuBY0j4vY2BfFjhQ9Nthke0hbgZLbhHV
         oFUBmKB7TF/9Zgk4WQXpSZDe2S8xpaGUaMbSpvh744Arw/Hi7f8TAl8hu1NfO100JFD+
         Jqrs7CKEy49YI2Wv3EOtxtTedhO32yOAu7ExUI2EYvPmoG+w+fD9ScN9sfPKr8dPYmbB
         fROQ==
X-Gm-Message-State: APjAAAUcrE2gWVCohDnixK6vuzrET5j0SA8FTidvUK9Zy/asUPtJIXHL
        LlSZlRPUuYpw9NIDW/h3IWmG/g==
X-Google-Smtp-Source: APXvYqxrY8c666Igwg1R0i0REY1OJW1Ih3Ad8v+ZlbR2LUupNFnSbQkoVPBYFdyzfysek+egkkA9dA==
X-Received: by 2002:aed:2a85:: with SMTP id t5mr8551891qtd.264.1557945769970;
        Wed, 15 May 2019 11:42:49 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id t63sm1274466qka.33.2019.05.15.11.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:42:49 -0700 (PDT)
Date:   Wed, 15 May 2019 14:42:49 -0400
From:   Sean Paul <sean@poorly.run>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sean Paul <sean@poorly.run>, Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 2/5] drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc
 bus
Message-ID: <20190515184249.GA17077@art_vandelay>
References: <20190502225336.206885-1-dianders@chromium.org>
 <20190502225336.206885-2-dianders@chromium.org>
 <20190515182038.GV17077@art_vandelay>
 <CAD=FV=WP-rFDAR28oZg+9DcrXbaYPjFCAD-dV1VR3-3_XDs-3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WP-rFDAR28oZg+9DcrXbaYPjFCAD-dV1VR3-3_XDs-3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:36:33AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 15, 2019 at 11:20 AM Sean Paul <sean@poorly.run> wrote:
> 
> > > +                     if (IS_ERR(hdmi->default_state) &&
> > > +                         !IS_ERR(hdmi->unwedge_state)) {
> > > +                             dev_warn(dev,
> > > +                                      "Unwedge requires default pinctrl\n");
> >
> > Can you downgrade this message to info or dbg? Given how rare this issue is, we
> > probably don't want to spam everyone who is happily using dw-hdmi.
> 
> I don't think it will spam anyone, will it?  It will only spam if you
> _do_ specify an unwedge state and you _don't_ specify a default state.
> This seems like something you'd want a pretty serious warning about
> because it meant that you wanted to use unwedge but you didn't specify
> it properly.
> 

That'll teach me for skimming, you're right on, thanks for the correction!

> 
> > Reviewed-by: Sean Paul <sean@poorly.run>
> 
> Thanks!
> 
> -Doug

-- 
Sean Paul, Software Engineer, Google / Chromium OS
