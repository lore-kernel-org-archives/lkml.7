Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4962C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A4B20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iMt4NyQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDMAMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:12:49 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46907 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfDMAMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:12:48 -0400
Received: by mail-ua1-f68.google.com with SMTP id v7so3803556uak.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 17:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKy/1tk4tvKeRmpGz+7+rq/OSvJFqAcwZaB/B047Mvo=;
        b=iMt4NyQRPqlyQFIF80o8voPJJWKHIfT4iHw+wM+odI2ubVz+8Uqefw99j8p/qY0MsM
         FLAJuMrYr4PdrdrGhN9LcWqr6n9aG60WfpgTpV2Ic8FDowmPZxltQtD64FPu1cp1sjoF
         hDhVvoYOx5KxnRNaXQYfuxW0fyXDwZIsNMdW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKy/1tk4tvKeRmpGz+7+rq/OSvJFqAcwZaB/B047Mvo=;
        b=ii4XzWQtXEjOSAWCbbyc/u7R/vh7NWmkHrFSMUERcZoOyH21h4ZMlqGfuajKagKr6C
         8vT8SbGJzsYz8mheT11dw/dlEbxgAb36onC49yL5vQHFw5qNf/wqHreafGzpL2pRXFAo
         wRsjGLglq6idbPmyo/NonwwjdLHS8e/3kWsrLstWLSOVxt6p2CkWXuOAk17lNz+LExYY
         Bm2LXQa9VRvfifHLhhTv6qghPvR/O5r9u/V6NWGfHdkWnsQryC7pvv1wlqKxU1wsJCLu
         5FltfTU6epME/VSuArpk8BBEBENl9YU0MNpMOfGabxgLPkEOoAPvUuluDOZh5f35s7lF
         eb1w==
X-Gm-Message-State: APjAAAVGPQkKi16IotF+36ANY0LHzPFuy9iYLksxiaU/KL5xfSXJwPi5
        6rPBnzXWJRvxwYbVK6sOlhywToAyEGI=
X-Google-Smtp-Source: APXvYqywm8cPMMLuwWeN1DFWgWW5/wKyxi2YTW4b7bDkictNS48kmXGEr7U1zMN4PqW3U/0Zxj7LjA==
X-Received: by 2002:ab0:1d82:: with SMTP id l2mr33215613uak.120.1555114366743;
        Fri, 12 Apr 2019 17:12:46 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id v22sm11643023vkv.35.2019.04.12.17.12.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 17:12:46 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id l17so3829441uar.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 17:12:46 -0700 (PDT)
X-Received: by 2002:ab0:7212:: with SMTP id u18mr31245998uao.32.1555114045585;
 Fri, 12 Apr 2019 17:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-7-dianders@chromium.org> <CAPCnQJmWfnBwxj8gScNzmZTGV6eU5B1vk76sQ56A2FvpSiYRaw@mail.gmail.com>
 <CAD=FV=VK3ow3PgA9nXiE8+0UdgsGiFbAiZd-QAmCsLHK0Yi2Cg@mail.gmail.com> <CAPCnQJkDDGrFLpFHr=xD02Gz_TzMwHK7B4-E4cw7A=QhWFFF4w@mail.gmail.com>
In-Reply-To: <CAPCnQJkDDGrFLpFHr=xD02Gz_TzMwHK7B4-E4cw7A=QhWFFF4w@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 12 Apr 2019 17:07:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WivkKM3CXE+28QCMO=RnJb19vhse0Ot0q-81a1L30iEA@mail.gmail.com>
Message-ID: <CAD=FV=WivkKM3CXE+28QCMO=RnJb19vhse0Ot0q-81a1L30iEA@mail.gmail.com>
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

On Mon, Apr 8, 2019 at 9:26 AM Urja Rannikko <urjaman@gmail.com> wrote:
>
> Hi,
>
> On Mon, Apr 8, 2019 at 3:21 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Sat, Apr 6, 2019 at 6:16 PM Urja Rannikko <urjaman@gmail.com> wrote:
> > >
> > > Hi,
> <snip>
> > >
> > > The difference would be in this format just setting hfront-porch = 87
> > > and vback-porch = 14.
> > > Anyways the point is: I support moving this mode info into the dts,
> > > and I'd like to know how if at all should i go about getting a
> > > 60Hz(ish) mode upstreamed?
> >
> > I'm a bit torn here.  I like the idea of actually getting 60 Hz and
> > you also increase the vblank time by a little bit (which means that if
> > anyone ever gets DDRFreq upstream it will work better).  ...but I'm
> > also slightly nervous changing something like this without a really
> > good motivation.  As you said in your commit message the pixels clocks
> > claimed by the spec don't actually all work and thus, to some extent,
> > we can only rely on trial-and-error here.  While your new mode works
> > well on your device (and you wisely gave it a bit of margin), it is
> > _possible_ that there could be devices out there where it doesn't work
> > (especially across various temperature extremes).  All devices were
> > tested in the factory with the old timings and presumably have been
> > running fine for years like that...
> Re: the trial and error: it might be the case that the panels actually
> work at 1506 vtotal if you also adjust the sync length and/or back
> porch "accordingly", whatever that accordingly would be for this panel
> since the datasheet doesnt tell. I missed this point when i was doing
> my testing and just adjusted the variables with the most
> "adjustability" (bigger starting value) to them.

Fair enough.  I guess I just have my gut instincts that say that this
will break some device somewhere, but it's certainly possible that's
wrong.


> > I will certainly admit that it's unlikely devices would be affected,
> > but at the same time I'd want to know how much of a difference going
> > from 58.3 Hz to 60 Hz made for you.  Could you actually notice any
> > visible difference, or was it just nice to be at 60 Hz?
> Honestly I was just doing this because i really liked the idea of
> actually making it 60Hz and my eyes arent that good at noticing
> high-fps things - i think the one case where it might be visible to a
> keen eye is 720p60 playback where you'd need to skip "about 2" (1.7..)
> frames a second if running at 58.3 Hz. But currently the C201 isnt
> doing a lot of that given i dont think i/we have a good software setup
> for it. That could be changing in the future with panfrost and the VPU
> hardware decoder support, etc.

Yeah, I'd definitely wonder how easy this is to notice.  Since I
haven't ever heard of anyone who thought that the current 58.3 Hz was
causing problems that they could actually notice it makes me hesitant
to change it.


> Anyways I'm thinking it would be prudent to first get this framework
> of device-tree modes in and then maybe adjust the mode later.

If you're OK with it, let's aim to land things with the current 58.3
and then we can do think about the 60 Hz mode.

...I'm probably sounding super paranoid here since (presumably) anyone
who is running upstream Linux on their Chromebook is more than capable
of bisecting problems like this if it causes problems, but I guess I'm
worried that this could eventually make its way into a Chrome OS tree
(either through a kernel uprev or simple cherry-picks) and affect
people.


> Testing the 60Hz mode is simple enough:
> xrandr --newmode 1366x768p60 74.25 1366 1453 1483 1543 768 776 790 802
> -HSync -VSync
> xrandr --addmode eDP-1 1366x768p60
> xrandr --output eDP-1 --mode 1366x768p60
>
> (The mode name can be anything...)
> So meanwhile I would appreciate it if we could get some test reports
> of the mode with other veyron chromebooks that have this panel :)

I still haven't done this and I'm not in front of my Chromebook now.
I'll try to give it a try soon.  The kinds of problems I'd expect (if
there are any) would be flickers that happen _very_ rarely though, but
I can at least do some basic testing.

One other note to justify my paranoia: on a past Chromebook we
certainly had crazy flickering problems.  On one device one day you'd
get two flickers and then see nothing for the next two weeks.  ...some
devices would see at least a flicker a day and some would see no
flickers ever.  Obviously it's unlikely that would happen here, but
such past experience just makes me paranoid.  ;-)


-Doug
