Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC2C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1C3214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auZPw0pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfDHQ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:26:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34196 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfDHQ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:26:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id j89so11871321ljb.1;
        Mon, 08 Apr 2019 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y71r9AUja0CoGWFgRrYLcEiJm9kTC3t8g/dOsaY1BqQ=;
        b=auZPw0prVgUXtR0TBdNozs5wKbJkRR73+UpM3K++tXv69cdCCkXqXcM5YC8+m5XpmE
         Wrn8qLDxJTX4xuatZBeG/A4USV5p/dn+rEWggDDuPupfbXqW57jvW4gEQhR6F+adUQNC
         ZWpdx8HwJKY8XzGw0W1tvxZhJUhYbtZQmWkb9DjftYZCl+RG2vXKzASVDQWHs2XtoLtl
         MH5LCF9KsXc0fTCpsGSsefIuls0JAe7umdtFZWMy1v2YxJthpEJqDuUC6cUPbDXosCeB
         gjPoPmvkMkjDaQYGmGyNznn41kpAqKMF4JnG22jZ9y2M82uUkIk0D6T8EcJ4jOj2a0ie
         8yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y71r9AUja0CoGWFgRrYLcEiJm9kTC3t8g/dOsaY1BqQ=;
        b=EZoxIzp2javu2mjzsVNMMdXu3j7X15vQtag7eNrEq4EcSZ7KBWXlTZ9PufCHsF3iyE
         j+TmT1t5ts/Fxw9/PtHRekBSCfBPp0sOinVTdvwEwzLUUrCdkDeZ2JErGJaYQQ35K2rm
         JFpFpc/ho2XnPDbFCbDNj50fantN3mc0HHI04RnBUydyL3skEoPvilXbXdeSP4TG5k28
         8WKnxqirEplX5AjANNhdQNq7aTRpoSC4C2nD7qHE0qc369TUs9AakWsmUL56d1NKZunI
         lF4fhDzviIIRkbmXcvYvywkmLd6InLCUOehM2tiSBGQuc2ix+OC1jBdnDwm3eHaMJ8Ov
         Hs2Q==
X-Gm-Message-State: APjAAAWZSfniBuDrpru4uITPkBrz3otydQsdxm44/4HQeSGtTuBgsrhD
        xXPmXGO2hug+sL6VvT84kgUJ86To3geFQFb0ltScSDaJlw==
X-Google-Smtp-Source: APXvYqzaEkao6wkp8WTylJoJwPAdL0wtRO66fI12td6n9X7fdVz1rjDJdxipjQCty0kYrP+riiNZisvRlBwoPpTSxHY=
X-Received: by 2002:a2e:5c7:: with SMTP id 190mr16285330ljf.108.1554740771741;
 Mon, 08 Apr 2019 09:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-7-dianders@chromium.org> <CAPCnQJmWfnBwxj8gScNzmZTGV6eU5B1vk76sQ56A2FvpSiYRaw@mail.gmail.com>
 <CAD=FV=VK3ow3PgA9nXiE8+0UdgsGiFbAiZd-QAmCsLHK0Yi2Cg@mail.gmail.com>
In-Reply-To: <CAD=FV=VK3ow3PgA9nXiE8+0UdgsGiFbAiZd-QAmCsLHK0Yi2Cg@mail.gmail.com>
From:   Urja Rannikko <urjaman@gmail.com>
Date:   Mon, 8 Apr 2019 16:26:04 +0000
Message-ID: <CAPCnQJkDDGrFLpFHr=xD02Gz_TzMwHK7B4-E4cw7A=QhWFFF4w@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] ARM: dts: rockchip: Specify rk3288-veyron-chromebook's
 display timings
To:     Doug Anderson <dianders@chromium.org>
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

On Mon, Apr 8, 2019 at 3:21 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Apr 6, 2019 at 6:16 PM Urja Rannikko <urjaman@gmail.com> wrote:
> >
> > Hi,
<snip>
> >
> > The difference would be in this format just setting hfront-porch = 87
> > and vback-porch = 14.
> > Anyways the point is: I support moving this mode info into the dts,
> > and I'd like to know how if at all should i go about getting a
> > 60Hz(ish) mode upstreamed?
>
> I'm a bit torn here.  I like the idea of actually getting 60 Hz and
> you also increase the vblank time by a little bit (which means that if
> anyone ever gets DDRFreq upstream it will work better).  ...but I'm
> also slightly nervous changing something like this without a really
> good motivation.  As you said in your commit message the pixels clocks
> claimed by the spec don't actually all work and thus, to some extent,
> we can only rely on trial-and-error here.  While your new mode works
> well on your device (and you wisely gave it a bit of margin), it is
> _possible_ that there could be devices out there where it doesn't work
> (especially across various temperature extremes).  All devices were
> tested in the factory with the old timings and presumably have been
> running fine for years like that...
Re: the trial and error: it might be the case that the panels actually
work at 1506 vtotal if you also adjust the sync length and/or back
porch "accordingly", whatever that accordingly would be for this panel
since the datasheet doesnt tell. I missed this point when i was doing
my testing and just adjusted the variables with the most
"adjustability" (bigger starting value) to them.

> I will certainly admit that it's unlikely devices would be affected,
> but at the same time I'd want to know how much of a difference going
> from 58.3 Hz to 60 Hz made for you.  Could you actually notice any
> visible difference, or was it just nice to be at 60 Hz?
Honestly I was just doing this because i really liked the idea of
actually making it 60Hz and my eyes arent that good at noticing
high-fps things - i think the one case where it might be visible to a
keen eye is 720p60 playback where you'd need to skip "about 2" (1.7..)
frames a second if running at 58.3 Hz. But currently the C201 isnt
doing a lot of that given i dont think i/we have a good software setup
for it. That could be changing in the future with panfrost and the VPU
hardware decoder support, etc.

Anyways I'm thinking it would be prudent to first get this framework
of device-tree modes in and then maybe adjust the mode later.

Testing the 60Hz mode is simple enough:
xrandr --newmode 1366x768p60 74.25 1366 1453 1483 1543 768 776 790 802
-HSync -VSync
xrandr --addmode eDP-1 1366x768p60
xrandr --output eDP-1 --mode 1366x768p60

(The mode name can be anything...)
So meanwhile I would appreciate it if we could get some test reports
of the mode with other veyron chromebooks that have this panel :)

-- 
Urja Rannikko
