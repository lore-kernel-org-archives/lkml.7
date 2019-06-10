Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC83C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488942082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="NC0Ym/md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfFJUv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:51:27 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45057 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfFJUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:51:27 -0400
Received: by mail-vs1-f67.google.com with SMTP id n21so6450115vsp.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyYkEWRj0YJV5ZLI8Mg19WpHWifRtrV4TMHZVE8qPm8=;
        b=NC0Ym/mdsDncoZDorvKAM6xnQHqO/QrBZMSByQ87DFOKOY5LektD3i2fXTPFMV5gEb
         B+jz+3Dd13t7MZNh2lFBrzF3VPLx1KIsiagqMIMYyENWW6PDVua6vokHuxp4iRB7SGBP
         oFhMiqoPRQF0lp325kHJWPXC+dup4oIV+FxnM24bVaa7URJymXv0UBdm6axvZ/7SXM0V
         KpHpsjeDDyeZoP+I9UaJoBhGziX7ec09BY4mQMov6WeiEnm+l5+JUFxqG2hd7MI5PM0F
         5X61FbBw9ul1y43HMTwi6J7dygh1JPsAue+OITbRaSvfqs4rtsLSqXqhyOol/LAVEb3N
         Mc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyYkEWRj0YJV5ZLI8Mg19WpHWifRtrV4TMHZVE8qPm8=;
        b=Ac53C9Q8KFi3/sdW+bAA0EfuWKaDwdfZabVHjdnBOyNZXNtQk+9yZAtwvYea2eiptA
         XRMEDA3VaG0C0e0mbrOumECP3oPCeNS/doIxLa2iSxa29+Iy7k2I0G+op5fQAmtmY+Qf
         gPD6ZM9ylaExnzQx+K07eb87serI/xsos5kqL+GXqM5rbMMVv2mB/Fh9zbL3xKPtcoq0
         2wzgnFCowwtjv7k5XdjkCHQWqS6szNKiE50b0bX0ikj5P4mYdUpvAV3e3Pk7Ct0wjGMi
         JliKp5Ca1MuQptBvLAUjqxN6TJklhwlI7NHsC8T0HRHzH5jTP0/HVqjm1I6nB8kJw3jF
         CayQ==
X-Gm-Message-State: APjAAAW8WKnKFCM0nc8zXwSIntuUFzQZRoYrOa6od5xnxH1ucVtoLNei
        jtPNWaOYt+v3q2JYFlmbidMPH4biFtdQR3o5yLBgpQ==
X-Google-Smtp-Source: APXvYqxHiF7j7PUoNqVyn9OY/HQVtXAWopKiEj3RQFyhF+xmBBltqTuNBj9BhxevhFCKpkFJxP+TtW+cFT392wT7E5c=
X-Received: by 2002:a67:6b43:: with SMTP id g64mr28426206vsc.183.1560199886317;
 Mon, 10 Jun 2019 13:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190610175234.196844-1-dianders@chromium.org>
In-Reply-To: <20190610175234.196844-1-dianders@chromium.org>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 10 Jun 2019 16:50:50 -0400
Message-ID: <CAMavQKLRm8uYu3O=co5Ui7YjkK0hKHAd=+TA0oExfqnLc+TLFA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: Fix unwedge crash when no
 pinctrl entries
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Erico Nunes <nunes.erico@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 1:52 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> In commit 50f9495efe30 ("drm/bridge/synopsys: dw-hdmi: Add "unwedge"
> for ddc bus") I stupidly used IS_ERR() to check for whether we have an
> "unwedge" pinctrl state even though on most flows through the driver
> the unwedge state will just be NULL.
>
> Fix it so that we consistently use NULL for no unwedge state.
>
> Fixes: 50f9495efe30 ("drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc bus")
> Reported-by: Erico Nunes <nunes.erico@gmail.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks Erico for the report, and Doug for fixing this up quickly, I've applied
the patch to drm-misc-next

Sean

> ---
>
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index f25e091b93c5..5e4e9408d00f 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -251,7 +251,7 @@ static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
>  static bool dw_hdmi_i2c_unwedge(struct dw_hdmi *hdmi)
>  {
>         /* If no unwedge state then give up */
> -       if (IS_ERR(hdmi->unwedge_state))
> +       if (!hdmi->unwedge_state)
>                 return false;
>
>         dev_info(hdmi->dev, "Attempting to unwedge stuck i2c bus\n");
> @@ -2686,11 +2686,13 @@ __dw_hdmi_probe(struct platform_device *pdev,
>                         hdmi->default_state =
>                                 pinctrl_lookup_state(hdmi->pinctrl, "default");
>
> -                       if (IS_ERR(hdmi->default_state) &&
> -                           !IS_ERR(hdmi->unwedge_state)) {
> -                               dev_warn(dev,
> -                                        "Unwedge requires default pinctrl\n");
> -                               hdmi->unwedge_state = ERR_PTR(-ENODEV);
> +                       if (IS_ERR(hdmi->default_state) ||
> +                           IS_ERR(hdmi->unwedge_state)) {
> +                               if (!IS_ERR(hdmi->unwedge_state))
> +                                       dev_warn(dev,
> +                                                "Unwedge requires default pinctrl\n");
> +                               hdmi->default_state = NULL;
> +                               hdmi->unwedge_state = NULL;
>                         }
>                 }
>
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
