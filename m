Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319FEC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0536220645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561738225;
	bh=JT2+LjdeGYwAzgiQO03rJyeR6d1ItE4i/2D95RggsE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZNxDN1SqyWGmK5ecVeS5flNBbZjsGmZroObLpyhHUxmvQ8nHstiN4NHfynDDNr+a5
	 C4dhX2seR5MLiQ32l2eQQZNGZMcJXCKjF8DslzTNoV7dIXDx12M2g0ahLJeA1/hhyT
	 S8nU395Ep+4BR85U8YxW6TCpvSpbPFXwQJ7spvw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfF1QKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfF1QKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:10:23 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB68721726;
        Fri, 28 Jun 2019 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561738222;
        bh=JT2+LjdeGYwAzgiQO03rJyeR6d1ItE4i/2D95RggsE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2jPfie8PRDa4umctnjlAEeWpw3BkCmoC0WH18fW0TkvsFQ7RsdkA1hCqoVP0ei99p
         DiYQXIXkyt2+Mt+6ZLrCD09gMxB2R29SmABRJMeRvyvKaERRxanck59+m1nOVipH+B
         x6rjzkLBBU1UFtKGMM5ebhZp3sbY2dzzZoPP7kl4=
Received: by mail-qk1-f175.google.com with SMTP id r6so5294974qkc.0;
        Fri, 28 Jun 2019 09:10:21 -0700 (PDT)
X-Gm-Message-State: APjAAAWSQGxFpD7L/A6bbyl7f2ksTFD+s+1f2bFRUcQPDIM7yBv1D5Ux
        B7+pznqjOEM/PyOei6JzJq5H/oxEalwefzYTFQ==
X-Google-Smtp-Source: APXvYqyWvAhqS9/ekWTKjDusvBvbzTg0jA8Pn2h4OITXjwQUgHtqy5AWS+DPlCXsn23dZ+IMB0pxlEQeYQRMQrLcvXU=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr9535724qkl.254.1561738221012;
 Fri, 28 Jun 2019 09:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190626130007.GE23428@ravnborg.org> <CAD=FV=U4UU8q+CS76uuuGUP=EVnE6+BTUf8U=j7uwfczNgkrZw@mail.gmail.com>
 <CAD=FV=Vi2C7s2oWBDD0n+HK=_SuBYhRM9saMK-y6Qa0+k-g17w@mail.gmail.com>
In-Reply-To: <CAD=FV=Vi2C7s2oWBDD0n+HK=_SuBYhRM9saMK-y6Qa0+k-g17w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Jun 2019 10:10:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJGtUTpJL+SDEKi09aDT4yDzY4x9KwYmz08NaZcn=nHfA@mail.gmail.com>
Message-ID: <CAL_JsqJGtUTpJL+SDEKi09aDT4yDzY4x9KwYmz08NaZcn=nHfA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] drm/panel: simple: Add mode support to devicetree
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
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

On Fri, Jun 28, 2019 at 9:55 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jun 26, 2019 at 7:41 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Jun 26, 2019 at 6:00 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Douglas.
> > >
> > > On Mon, Apr 01, 2019 at 10:17:17AM -0700, Douglas Anderson wrote:
> > > > I'm reviving Sean Paul's old patchset to get mode support in device
> > > > tree.  The cover letter for his v3 is at:
> > > > https://lists.freedesktop.org/archives/dri-devel/2018-February/165162.html
> > > >
> > > > No code is different between v4 and v5, just commit messages and text
> > > > in the bindings.
> > > >
> > > > I've pulled together the patches that didn't land in v3, addressed
> > > > outstanding feedback, and reposted.  Atop them I've added patches for
> > > > rk3288-veyron-chromebook (used for jaq, jerry, mighty, speedy) and
> > > > rk3288-veryon-minnie.
> > > >
> > > > Please let me know how they look.
> > > >
> > > > In general I have added people to the whole series who I think would
> > > > like the whole series and then let get_maintainer pick extra people it
> > > > thinks are relevant to each individual patch.  If I see you respond to
> > > > any of the patches in the series, though, I'll add you to the whole
> > > > series Cc list next time.
> > > >
> > > > Changes in v5:
> > > > - Removed bit about OS may ignore (Rob/Ezequiel)
> > > > - Added Heiko's Tested-by
> > > > - It's not just jerry, it's most rk3288 Chromebooks (Heiko)
> > >
> > > What are the plans to move forward with this?
> > > Or did you drop the whole idea again?
> >
> > At the moment I'm blocked on Thierry responding, either taking the
> > patch or telling me what I need to do to fix it.  I saw Sean Paul ping
> > Thierry on IRC on June 3rd and as far as I could tell there was no
> > response.
> >
> > https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2019-06-03&show_html=true
> >
> > ...and as you can see Heiko pinged this thread on June 14th.
> >
> > Thierry: can you help give us some direction?  Are you uninterested in
> > reviewing them and would prefer that I find someone to land them in
> > drm-misc directly?
>
> Sam: Oh!  I hadn't noticed that you've been added as a panel
> maintainer in commit ef0db94f94a0 ("MAINTAINERS: Add Sam as reviewer
> for drm/panel").  Does that mean you are able to provide some advice
> for how to land this series?  As far as I know everything is in order
> for it to land, but if you are aware of something I need to do to spin
> it then please let me know!

BTW, at least for the binding, this will get implicitly supported in
the schema conversion[1] as simple-panel as a binding is gone and
panel-common already had timing node defined. A schema for the timing
node is still needed though (hint :) ).

Rob

[1] https://patchwork.ozlabs.org/patch/1121538/
