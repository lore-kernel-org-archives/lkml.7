Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDE5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B101217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZ8u9uAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfH0UDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:03:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39281 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0UDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:03:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so83383wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=impKCbyAxRs9NFOM+DFGNElYKCV9PdyDQbIxJjFevFA=;
        b=IZ8u9uAFL6eeaolWlF3r1zEFQK00yXEBdd2GZo74Q8JnQOyj8Qqn+gA+mWHII+DL54
         DcMjlaZ7nMoJaGTc2+D57TVEaEVpGGrtxnVmy3Kk6wH1p8tJvet9iZ2CFGYZCCOX4bN7
         MpYeAvGyphsEom5+u/KfDh/WVySnq75jNo0QYLhFZupyfSAl4OsN06t2DHhz1XdsuCzk
         do/W5UtNiiG8d4RWw3OkZogNM0hFfbr03H8ijXSVsGSoDyBy4QxCDi5kvZZq5gfqlGsr
         8bVp089gsGXHf11zwHf/2AHuLcNJl2gxEPv/gtiCHiUDoAeXFc2LrH6q/2/oiMDRxhkR
         fbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=impKCbyAxRs9NFOM+DFGNElYKCV9PdyDQbIxJjFevFA=;
        b=NDZqARQSeo9rsutK0e5onbeEb/PVkJOVdsGFHglQzfEtX6IntvDo2ZKQAV8OTGnN5G
         IpHlVtofE/+hBev84OcPWpd94qYjEQjc3xcOMiEYQ1tgPpAjnoSbIdj4fb8qXI8y6nEU
         Nx77duwMRTAx9lz/50IymcvrUYvT5zut99ucTGjGu6zIkNv/f72/1mk20JUHlWef5cET
         40UlSUokpSLImq8gCLXE0n1dotqVfiXzi5pr+OXdx6ObXUNpLAAoIPYqk4JpoGxkNkid
         BzfX7xCf7zy7WZvaPVdNz+06PwXw9aD3MjKG9lWyyv5gNwb+63V0n6I3qmtpC2IAicb2
         EK3A==
X-Gm-Message-State: APjAAAVIOH4yGNr9ocaN+e3Hb6LI5guIyPFM1C4/x9DAXdRrfVKhB8pe
        PqN/4EUFELtZP8QDTLGsX+y5wAlcr5QmanTC4Dl/lw==
X-Google-Smtp-Source: APXvYqxMf0gPlGKALYf0yBr5/No4pDEoW1Setdjt5CEUhoFxnZ5cKpvdpBGJpJuLwsoD4zMtMpNRmmlLntSwgxu9mXs=
X-Received: by 2002:adf:ba0c:: with SMTP id o12mr3100629wrg.284.1566936202247;
 Tue, 27 Aug 2019 13:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190627151740.2277-1-matt.redfearn@thinci.com> <CALAqxLUsf4HJBcAcd+qzycFC3d8XbKk9HyQ7FfCrH8Ewc3mzvw@mail.gmail.com>
In-Reply-To: <CALAqxLUsf4HJBcAcd+qzycFC3d8XbKk9HyQ7FfCrH8Ewc3mzvw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 27 Aug 2019 13:03:09 -0700
Message-ID: <CALAqxLVtzQSgVL0B0M2RNB_U-TvNs7+C=k6VUk0VJywdgJbNFQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: adv7511: Attach to DSI host at probe time
To:     Matt Redfearn <matt.redfearn@thinci.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Sean Paul <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 3:27 PM John Stultz <john.stultz@linaro.org> wrote:
> On Thu, Jun 27, 2019 at 8:18 AM Matt Redfearn <matt.redfearn@thinci.com> wrote:
> >
> > In contrast to all of the DSI panel drivers in drivers/gpu/drm/panel
> > which attach to the DSI host via mipi_dsi_attach() at probe time, the
> > ADV7533 bridge device does not. Instead it defers this to the point that
> > the upstream device connects to its bridge via drm_bridge_attach().
> > The generic Synopsys MIPI DSI host driver does not register it's own
> > drm_bridge until the MIPI DSI has attached. But it does not call
> > drm_bridge_attach() on the downstream device until the upstream device
> > has attached. This leads to a chicken and the egg failure and the DRM
> > pipeline does not complete.
> > Since all other mipi_dsi_device drivers call mipi_dsi_attach() in
> > probe(), make the adv7533 mipi_dsi_device do the same. This ensures that
> > the Synopsys MIPI DSI host registers it's bridge such that it is
> > available for the upstream device to connect to.
> >
> > Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
> >
> > ---
>
> As a heads up, I just did some testing on drm-misc-next and this patch
> seems to be breaking the HiKey board.  On bootup, I'm seeing:
> [    4.209615] adv7511 2-0039: 2-0039 supply avdd not found, using
> dummy regulator
> [    4.217075] adv7511 2-0039: 2-0039 supply dvdd not found, using
> dummy regulator
> [    4.224453] adv7511 2-0039: 2-0039 supply pvdd not found, using
> dummy regulator
> [    4.231804] adv7511 2-0039: 2-0039 supply a2vdd not found, using
> dummy regulator
> [    4.239242] adv7511 2-0039: 2-0039 supply v3p3 not found, using
> dummy regulator
> [    4.246615] adv7511 2-0039: 2-0039 supply v1p2 not found, using
> dummy regulator
> [    4.272970] adv7511 2-0039: failed to find dsi host
>
> over and over.  The dummy regulator messages are normal, but usually
> [    4.444315] kirin-drm f4100000.ade: bound f4107800.dsi (ops dsi_ops)
>
> Starts up right afterward.

Hey Matt, Andrzej,
  I just wanted to follow up on this as this patch is breaking a
couple of boards. Any sense of what might be missing, or is this
something we should revert?

I'm happy to test any patch ideas you have.

thanks
-john
