Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34C8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55C0218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHgC61S8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfIRH3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:29:25 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46586 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:29:24 -0400
Received: by mail-vs1-f67.google.com with SMTP id z14so3793303vsz.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDoUVLf2sM2Wd7eza5DvRhJf8f3rN/ciRvE3nXJqNFQ=;
        b=bHgC61S83XFKjjHLXOkOq4DxsfgHo2iXOrB0kGNER7zB3qrVVxUkcW0pixzEoZ/hFO
         9zlhd8/Ni87ZlTvrJ0eiUB+ehwc8ERiN1SdYfkRdu5K74DlnoLi+h/s3kgUV+MO5yxI4
         IpXJ9/umG++g7tOVTqBUHyZhF1w1+BHeH19F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDoUVLf2sM2Wd7eza5DvRhJf8f3rN/ciRvE3nXJqNFQ=;
        b=UnKEMOfW38AoPD68l64kGYDy8k/ujVCCV32VEXF+iT+Uq9gAAIPRRZ54DdgMrgEDyH
         kaWIBHuq64kmI6ckyu5NH46Ca7dJvvY2pLcNxqqIEkvW19v502LDD5wLfHmP8g+OawNb
         VUHOY9C4BeO1Kkb/jEy6K2UBvLI+n9B6e2zSvgDzehsUhDaE0GrzilIXPU0yLnP13rV1
         7u8S2AdexVFDetwiOz6hckIw9qAfiDbg3ZekCXOnh7SheHqTR7OfdJEa71UwPLxMJOCy
         2S/t+xmwVMGw4vfSZt3REgH+CDDdDoVdNxzeXrl383t+DCxaEzY4hx0EAZDpnJLpClK1
         en1w==
X-Gm-Message-State: APjAAAWQHgmy2z/oftT3wWmzgql/0mqw35bjkXKoCwd2VxbJmIB+Al65
        SKB4/JX5rDmcljzwuMSHIgcrBHVGEcP/66NVyCFZ+Q==
X-Google-Smtp-Source: APXvYqz3X6HVZiW3ZAIrMpmqoTkGT9csY3mslQR+djJ/IC/kNyPMlb3OEGubgnn0YA3Nv38dQWDVGsLPAgmKFKrvNcM=
X-Received: by 2002:a67:db8d:: with SMTP id f13mr1362214vsk.163.1568791763011;
 Wed, 18 Sep 2019 00:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190717083327.47646-1-cychiang@chromium.org> <CA+Px+wX4gbntkd6y8NN8xwXpZLD4MH9rTeHcW9+Ndtw=3_mWBw@mail.gmail.com>
 <CAFv8NwLiY+ro0L4c5vjSOGN8jA-Qr4zm2OWvVHkiuoa7_4e2Fg@mail.gmail.com>
 <CAFv8NwJjG4mwfnYO=M3O9nZN48D6aY72nQuqEFpZL68dh5727w@mail.gmail.com>
 <7019a223-cc97-e1c6-907b-e6b3d626164f@baylibre.com> <20190909135346.GG2036@sirena.org.uk>
 <3fc94731-f66a-223d-995e-97ac67f9e882@baylibre.com>
In-Reply-To: <3fc94731-f66a-223d-995e-97ac67f9e882@baylibre.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 18 Sep 2019 15:28:56 +0800
Message-ID: <CAFv8NwL3+4Qsv0B7PtVhB=HX6uFUMMaw5V=E3NTRE-v_jDVAxg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add HDMI jack support on RK3288
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 5:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 09/09/2019 15:53, Mark Brown wrote:
> > On Mon, Sep 09, 2019 at 09:37:14AM +0200, Neil Armstrong wrote:
> >
> >> I'd like some review from ASoC people and other drm bridge reviewers,
> >> Jernej, Jonas & Andrzej.
> >
> >> Jonas could have some comments on the overall patchset.
> >
> > The ASoC bits look basically fine, I've gone ahead and applied
> > patch 1 as is since we're just before the merge window and that
> > way we reduce potential cross tree issues.  I know there's a lot
> > of discussion on the DRM side about how they want to handle
> > things with jacks, I'm not 100% sure what the latest thinking is
> > there.
> >
>
> Thanks Mark.
>
>
> Cheng-Yi can you resent this serie without the already applied
> first patch with Jernej, Jonas, and Jerome Brunet <jbrunet@baylibre.com> CCed ?

Hi Neil,
Got it. Sorry for the late reply.
I will resend this series without the first patch, based on latest
drm-misc-next, and cc the folks.
Thanks!

>
> Thanks,
> Neil
>
