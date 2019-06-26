Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CBCC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA7E216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f8TY1v47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfFZTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:30:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34202 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZTa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:30:28 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so4455638iot.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMDBPgUsvp65+GDLE8L0NRSWZecIdZ0UtHWFD2Htqnw=;
        b=f8TY1v47mlNmVd21P8YuLUhvPcChePJhG5luDNvNOtOVM0rQxgkmqCwMDmf30Pudhf
         Z2bz0ZwXvpg8OX8mhH5NXCZszTpkwlUwUseq96CumbKwcURP9hZVRxWVqkhb/A+4g1V7
         DEcJcWvGjKFFkLhlwMo6C03JF99srWG00HP6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMDBPgUsvp65+GDLE8L0NRSWZecIdZ0UtHWFD2Htqnw=;
        b=OsAUheY7SaYpK5/0GCn+kz1ORxy9X40MallgCgek2M++qCzXYNuyvR20Cu4YOqgvnc
         DsuW6PDGQnE4Vme+5tPvaSVZpTdJhaa3x/BR3LCTBwdCsiNbP9OttL91CxXYLSKXKw+s
         nrTZZrX7z2fH5IP5R2fU24eaBF1eYjekfmj63NMwjY/po4qtLQUYnIs1E7fQ7d6s5mGr
         vtuKrYe7FHfgkjSIe9m+sazJKtUtkRCrCb6gdXtetYCZ5w014IwzIv77ppT3WUkmmyM0
         kEurizJCurGdPTofP8Yw5iVcn45Uvfc/LbG5sWkkynC3aX1JE9MJO0owTQ3hzuxjXMWE
         Fl7g==
X-Gm-Message-State: APjAAAXPZ89JW6Gx1ZqemOYcLVDyG5ZSd2r+0TOPg3MDrrR1gWASdUir
        4jvqxKemMCeLUv8hif4J3CaPESIqRPQ=
X-Google-Smtp-Source: APXvYqwEIf3Vx+eOPtp+lY//B1U0QFNT/E09Fvha13rS77spEuiw6231i7DSWVG0xldiYEhNwPGrTw==
X-Received: by 2002:a6b:3b89:: with SMTP id i131mr6484407ioa.33.1561577427995;
        Wed, 26 Jun 2019 12:30:27 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id q1sm18552890ios.86.2019.06.26.12.30.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 12:30:27 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id e5so4533895iok.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 12:30:27 -0700 (PDT)
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr6956221iok.52.1561577085074;
 Wed, 26 Jun 2019 12:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190619211151epcas3p4dbb163c034afa4063869c761b93e24b1@epcas3p4.samsung.com>
 <20190619210718.134951-1-dianders@chromium.org> <bec87373-48cc-0c55-9662-a74a7d2a47a0@samsung.com>
 <CAD=FV=WJBkYfRznh6aAyvgKgHb8-AG0hMORdKA0BXCL89wG_7w@mail.gmail.com> <a94d9554-fc93-a2d0-9a30-9604db8c123e@samsung.com>
In-Reply-To: <a94d9554-fc93-a2d0-9a30-9604db8c123e@samsung.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Jun 2019 12:24:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNR1z_WL7rrfv-O5cXFjDowq3qZe-3tg9o9YHjQgyCAA@mail.gmail.com>
Message-ID: <CAD=FV=VNR1z_WL7rrfv-O5cXFjDowq3qZe-3tg9o9YHjQgyCAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge/synopsys: dw-hdmi: Handle audio for
 more clock rates
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Dylan Reid <dgreid@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 26, 2019 at 2:56 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> >   AKA: anyone using auto-CTS won't notice any change
> > at all.  I guess the question is: with Auto-CTS should you pick the
> > "ideal" 6272 or a value that allows CTS to be the closest to integral
> > as possible.  By reading between the lines of the spec, I decided that
> > it was slightly more important to allow for an integral CTS.  If
> > achieving an integral CTS wasn't a goal then the spec wouldn't even
> > have listed special cases for any of the clock rates.  We would just
> > be using the ideal N and Auto-CTS and be done with it.  The whole
> > point of the tables they list is to make CTS integral.
>
>
> Specification recommends many contradictory things without explicit
> prioritization, at least I have not found it.
>
> So we should relay on our intuition.
>
> I guess that with auto-cts N we should follow recommendation - I guess
> most sinks have been better tested with recommended values.
>
> So what with non-auto-cts case:
>
> 1. How many devices do not have auto-cts? how many alternative TMDS
> clocks we have? Maybe it is theoretical problem.
>
> 2. Alternating CTS in software is possible, but quite
> complicated/annoying, but at least it will follow recommendation :)

It is OK w/ me if we want to drop my patch.  With the auto-CTS patch
it shouldn't matter anymore.  ...but I still wanted to post it to the
list for posterity in case it is ever useful for someone else.

-Doug
