Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E7DC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8266520883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eXziGvqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfDHPV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:21:29 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35392 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfDHPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:21:28 -0400
Received: by mail-vk1-f193.google.com with SMTP id g24so3114980vki.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pviZJ0hcesCJdTGWNGDY0u1Wsy1YkNoM1eqx/2uXuKw=;
        b=eXziGvqYwtf1q3BOk2Yl64rCuFh0DSBoZZXD0kGqZgxyMeR4T2JgBfaw+kuQPJ4k/S
         gNi7EouclnjlHzvwF1T9JYQs34fwqs+lkhpjta5qt0MZo29XsLZL+trJcR0rgW3/4mdN
         d2QvXAuDOIsz1szXDg+yrcaSCP83xOox/801Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pviZJ0hcesCJdTGWNGDY0u1Wsy1YkNoM1eqx/2uXuKw=;
        b=EhMGLWV1CrHv7UBr7KeOICSiYihxItIH6FfoCa3TFcP0FyOTh6yx0O2Mp66yq0hObe
         6E9IiNA0hXJai6Hi2Tci+2O8GtGtHLxBp5LuLylIJLstiISLerKS3zRq3n24MAMSRMPk
         +d+NWIGTNQhTGk6eAOEW8pO/hQNOazddXOAT8jBNFv5oD5kmDsoAD5t6iOO4CXGyDUpv
         OShMwNdNf4BJMwfs3mocaO3gfZiM4SZ33XskKs2jTDWAfdCGOlMfwOFXA7lQzXQHTvOY
         LN58vi/pLMTzWYhGaJBlSPJkshIeSDfnh2mwFuu03XZ4dQXD/k0ZDTwRelX6YMtEGI6R
         3NlQ==
X-Gm-Message-State: APjAAAXcImJbicSbZ/aWLnD16luPeSG0vZmDGSS8aQx9SvAjgqzPVpSY
        WomBv8hxP2qJjfiws4u13E5Mp6ZwcSQ=
X-Google-Smtp-Source: APXvYqyo4TUT88oaozJSpQ8RrFj3IjBRL2U1SUKC0cqKKn0ddYGTs9JhiohwRVeiIDtieHOo+e8hLQ==
X-Received: by 2002:a1f:2b8e:: with SMTP id r136mr16528396vkr.48.1554736887655;
        Mon, 08 Apr 2019 08:21:27 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id w184sm12186441vkd.0.2019.04.08.08.21.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:21:25 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id h127so3099946vkd.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:21:25 -0700 (PDT)
X-Received: by 2002:a1f:a9c2:: with SMTP id s185mr16659893vke.5.1554736885051;
 Mon, 08 Apr 2019 08:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-7-dianders@chromium.org> <CAPCnQJmWfnBwxj8gScNzmZTGV6eU5B1vk76sQ56A2FvpSiYRaw@mail.gmail.com>
In-Reply-To: <CAPCnQJmWfnBwxj8gScNzmZTGV6eU5B1vk76sQ56A2FvpSiYRaw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 Apr 2019 08:21:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VK3ow3PgA9nXiE8+0UdgsGiFbAiZd-QAmCsLHK0Yi2Cg@mail.gmail.com>
Message-ID: <CAD=FV=VK3ow3PgA9nXiE8+0UdgsGiFbAiZd-QAmCsLHK0Yi2Cg@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] ARM: dts: rockchip: Specify rk3288-veyron-chromebook's
 display timings
To:     Urja Rannikko <urjaman@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 6, 2019 at 6:16 PM Urja Rannikko <urjaman@gmail.com> wrote:
>
> Hi,
>
> On Mon, Apr 1, 2019 at 5:18 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > Let's document the display timings that most veyron chromebooks (like
> > jaq, jerry, mighty, speedy) have been using out in the field.  This
> > uses the standard blankings but a slightly slower clock rate, thus
> > getting a refresh rate 58.3 Hz.
> >
> > NOTE: this won't really do anything except cause DRM to properly
> > report the refresh rate since vop_crtc_mode_fixup() was rounding the
> > pixel clock to 74.25 MHz anyway.  Apparently the adjusted rate isn't
> > exposed to userspace so it's important that the rate we're trying to
> > achieve is mostly right.
>
> I just thought it would be worth mentioning that I have picked &
> tested a close to 60Hz mode on two veyron speedys of mine, but thought
> it too much effort to try and upstream, especially as it was done as a
> change to the actual panel info:
> https://github.com/urjaman/linux/commit/23d46278911e18df138b7adde1bebc23f606baae
>
> The difference would be in this format just setting hfront-porch = 87
> and vback-porch = 14.
> Anyways the point is: I support moving this mode info into the dts,
> and I'd like to know how if at all should i go about getting a
> 60Hz(ish) mode upstreamed?

I'm a bit torn here.  I like the idea of actually getting 60 Hz and
you also increase the vblank time by a little bit (which means that if
anyone ever gets DDRFreq upstream it will work better).  ...but I'm
also slightly nervous changing something like this without a really
good motivation.  As you said in your commit message the pixels clocks
claimed by the spec don't actually all work and thus, to some extent,
we can only rely on trial-and-error here.  While your new mode works
well on your device (and you wisely gave it a bit of margin), it is
_possible_ that there could be devices out there where it doesn't work
(especially across various temperature extremes).  All devices were
tested in the factory with the old timings and presumably have been
running fine for years like that...

I will certainly admit that it's unlikely devices would be affected,
but at the same time I'd want to know how much of a difference going
from 58.3 Hz to 60 Hz made for you.  Could you actually notice any
visible difference, or was it just nice to be at 60 Hz?


-Doug
