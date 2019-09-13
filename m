Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECBAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71411206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGUOWQFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfIMVQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:16:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMVQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:16:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so33369036wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJhIFxH6vrpAUB+C/AyT6D1yMvNlweQDODYmOOY6pEw=;
        b=hGUOWQFqBs9ujiqzLhSWn8FmbFzPkwrF4FpGKvEPNfK7BmWSs8oBqsIAWyoXi377WP
         NzbgDjxD3S0uXahrPXCisc86BOZkqlYJBaH2Fov9m0+r52PqsbNJLSjQhC2kWNBT8E4k
         wl43nUXVJzQ2ciDK7FioGXLyhzkqfXQGx6ZbZ1L7pym5rJQPBalIdH1ZMgOjbQkqYsw1
         5vNhHN+z7Wy6Jrbi9FhGiXA/ZiC9IKMMMBrc3VmFY+uVsa75N9Lbrbtz2CRgMGF/Wiq4
         AtgSMOzcHWMURO4orCaTtWUh64nJCAUd73mhEl7lorA+gwTvIsHhohNIPPQSzTYULxcM
         lNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJhIFxH6vrpAUB+C/AyT6D1yMvNlweQDODYmOOY6pEw=;
        b=X+xKsXROpHOfBb660pEylmuXmWfTxlvQEZe1oXCEgR40NVlxQQpKXva9czFzY2C3Yk
         HNoYVsiv9W/vTy64PSosPOUDgw/IkMreVmwvZSWQM0Q4iw4te+AaxbKM/xbJ1Qf4/oyW
         EfiBG4/zwWVH+ju/MHGRisAcan1fhDKRwXG8WRlD++n/DfR4VXQlzSommO4xEg46Qwm2
         lWOU4SeyYsQt8Joad3U3DaC+ED+24FtO8AKLD95WeV/G1csbKfELpmlAD9ozFjglS97f
         LSIv5sBd6komgaimO9EkrkU7HWkfKUwGErAeQ30n4l3qxrTcI4L3+yG6Az9I8oVIB/pY
         Qvbg==
X-Gm-Message-State: APjAAAVarUHI5wHF101sbqyJSprT+OxHwuM+WVLCpRXjCRiSiqiRAxKJ
        92zq9cIgSv07Z2rrhOdYCvV6EEx7hBCykTvn4MI0AQ==
X-Google-Smtp-Source: APXvYqyNx1WaqtIEvH84GEzWZOMCWQkQcW/qRPqnwOXsPpUp/b/p9VxWb+XXAd9JoBd5xkiwcS0cTMahfrcQ+xgu0M8=
X-Received: by 2002:a5d:6951:: with SMTP id r17mr11403852wrw.208.1568409363968;
 Fri, 13 Sep 2019 14:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060550.62095-1-john.stultz@linaro.org>
 <CGME20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da@epcas3p1.samsung.com>
 <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
 <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com> <CAF6AEGtkvRpXSoddjmxer2U6LxnV_SAe+jwE2Ct8B8dDpFy2mA@mail.gmail.com>
 <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com> <CALAqxLU5Ov+__b5gxnuMxQP1RLjndXkB4jAiGgmb-OMdaKePug@mail.gmail.com>
 <9d31af23-8a65-d8e8-b73d-b2eb815fcd6f@samsung.com> <CALAqxLVP=x9+p9scGyfgFUMN2di+ngOz9-fWW=A1YCM4aN7JRA@mail.gmail.com>
 <16c9066b-091f-6d0e-23f1-2c1f83a7da1b@samsung.com> <00e4f553-a02c-6d98-a0e8-28c0183a3c8c@thinci.com>
 <084ab580-8ba8-b018-bc7a-bd705027f200@samsung.com>
In-Reply-To: <084ab580-8ba8-b018-bc7a-bd705027f200@samsung.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 13 Sep 2019 14:15:51 -0700
Message-ID: <CALAqxLWv1nepCF_jDE7xZetXxhYnCJnvqEL8oAC+YWwMOR7geQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Matt Redfearn <matt.redfearn@thinci.com>,
        Rob Clark <robdclark@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 1:47 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 12.09.2019 16:18, Matt Redfearn wrote:
> > On 12/09/2019 14:21, Andrzej Hajda wrote:
> >> On 12.09.2019 04:38, John Stultz wrote:
> >>> Should I resubmit the kirin fix for the adv7511 regression here?
> >>> Or do we revert the adv7511 patch? I believe db410c still needs a fix.
> >>>
> >>> I'd just like to keep the HiKey board from breaking, so let me know so
> >>> I can get the fix submitted if needed.
> >>
> >> Since there is no response from Matt, we can perform revert, since there
> >> are no other ideas. I will apply it tomorrow, if there are no objections.
> > Hi,
> >
> > Sorry - yeah I think reverting is probably best at this point to avoid
> > breaking in-tree platforms.
> > It's a shame though that there is a built-in incompatibility within the
> > tree between drivers.
>
>
> Quite common in development - some issues becomes visible after some time.
>
> > The way that the generic Synopsys DSI host driver
> > probes is currently incompatible with the ADV7533 (hence the patch),
> > other DSI host drivers are now compatible with the ADV7533 but break
> > when we change it to probe in a similar way to panel drivers.
>
>
> 1. The behavior should be consistent between all hosts/device drivers.
>

Yea, I worry about this as well, as I know there is also the lt9611
bridge chip driver pending for the db845c which works against the
current msm dsi code. So changing the msm driver for the adv7533 may
break other drivers (in the case of lt9611, out of tree - so wouldn't
be a regression, but there may be others) written against the current
expectations.


> 2. DSI controlled devices can expose drm objects (drm_bridge/drm_panel)
> only when they can probe, ie DSI bus they sit on must be created 1st.
>
> 1 and 2 enforces policy that all host drivers should 1st create control
> bus (DSI in this case) then look for higher level objects
> (drm_bridge/drm_panel).
>
> As a consequence all bridges and panels should 1st gather the resources
> they depends on, and then they can expose higher level objects.
>
>
> >
> >> And for the future: I guess it is not possible to make adv work with old
> >> and new approach, but simple workaround for adv could be added later:
> >>
> >> if (source is msm or kirin)
> >>
> >>      do_the_old_way
> >>
> >> else
> >>
> >>      do_correctly.
> > Maybe this would work, but how do we know that the list "msm or kirin"
> > is exhaustive to cope with all platforms?
>
>
> By checking dts/config files.
>

A temporary clearly-marked-deprecated config option might also a
reasonable approach while we transition drivers over?

> > It seems to me the built in
> > incompatibility between DSI hosts needs to be resolved really rather
> > than trying to work around it in the ADV7533 driver (and any other DSI
> > bus device that falls into this trap).
>
>
> If you know how, please describe. Atm the only real solution I see is
> explicit workaround to allow new adv7511, then fixing controllers,
> together with workaround-removal.
>
> OK, it could be possible to change msm, kirin and adv in one patch,
> however I am not sure if this is the best solution.

Matt: I'm happy to help you test and validate things. Let me know how
I can help!

thanks
-john
