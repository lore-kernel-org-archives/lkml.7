Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5DAC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D48020828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzTrUukz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfF1Pzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:55:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43441 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfF1Pzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:55:47 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so13500593ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvsku1LsJlCMNeTol53NqA/7OgT8tqKKHqYv+Wh37GE=;
        b=CzTrUukzMMeVRGwtHonyk2yl+qyq6WCscFXVn/MC+4gnXi3vA+3kMHy6iRQGqVZrU5
         w20Qcluka+u28ayDtwVRqBQcrYz+4pCRRXefNm0+pAj+0E4hSBY3IzGe9/jYZeN6+zm7
         0cy9PihW6uY+H+FazttpKeB7XOxwJRVWhPe0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvsku1LsJlCMNeTol53NqA/7OgT8tqKKHqYv+Wh37GE=;
        b=kEkBJQ0Y9tr3ruc0vFsRJwdPxhlVDbB7beXvD+aBf4U3wj3shjFVyheauIzKd8DE4/
         zVsl0bFQsHhjLaAykSwHWjqciJjS07QYBuKoLD1om5u76BvAFgAQSixOTU1mGcefVc8G
         QJmG5GOR/js+c1fynR/qmjpWd8HXtCWZJx70HXonnSFB8AisdXd317kBlb40zNTaIA5U
         47MFGIdeBzXYOJK7LRNJoiQU99vkN7N8Cb6aLHlO+/ZuUGB6Np+byiDTCWu+lGBiLq1z
         CRgII6ghtfmWcaz0T4oVXj++fplqxjPUOC/xt3Jjp6ae0FOex1EMagGRK3zTFzRicPgL
         km8A==
X-Gm-Message-State: APjAAAVYuYPFAPMLVbRWwKqygBRk4kiV0naE6q4tsVbZr4HoD/1A7T5t
        iArCBWiv/Oevw7ha0eCSox3i6BJA20U=
X-Google-Smtp-Source: APXvYqwPuF6Oogd0ToyFsItdKCpRY16CkGTuD9Y+s62gdTldZ9vYGvzwHZoRuoTNsqisei0TM5SFIw==
X-Received: by 2002:a6b:8bd1:: with SMTP id n200mr5437404iod.134.1561737346281;
        Fri, 28 Jun 2019 08:55:46 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id a15sm2046333ioc.27.2019.06.28.08.55.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 08:55:45 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id i10so13457163iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 08:55:44 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr1014520iol.269.1561737344434;
 Fri, 28 Jun 2019 08:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190626130007.GE23428@ravnborg.org> <CAD=FV=U4UU8q+CS76uuuGUP=EVnE6+BTUf8U=j7uwfczNgkrZw@mail.gmail.com>
In-Reply-To: <CAD=FV=U4UU8q+CS76uuuGUP=EVnE6+BTUf8U=j7uwfczNgkrZw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 28 Jun 2019 08:55:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vi2C7s2oWBDD0n+HK=_SuBYhRM9saMK-y6Qa0+k-g17w@mail.gmail.com>
Message-ID: <CAD=FV=Vi2C7s2oWBDD0n+HK=_SuBYhRM9saMK-y6Qa0+k-g17w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] drm/panel: simple: Add mode support to devicetree
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi,

On Wed, Jun 26, 2019 at 7:41 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jun 26, 2019 at 6:00 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Douglas.
> >
> > On Mon, Apr 01, 2019 at 10:17:17AM -0700, Douglas Anderson wrote:
> > > I'm reviving Sean Paul's old patchset to get mode support in device
> > > tree.  The cover letter for his v3 is at:
> > > https://lists.freedesktop.org/archives/dri-devel/2018-February/165162.html
> > >
> > > No code is different between v4 and v5, just commit messages and text
> > > in the bindings.
> > >
> > > I've pulled together the patches that didn't land in v3, addressed
> > > outstanding feedback, and reposted.  Atop them I've added patches for
> > > rk3288-veyron-chromebook (used for jaq, jerry, mighty, speedy) and
> > > rk3288-veryon-minnie.
> > >
> > > Please let me know how they look.
> > >
> > > In general I have added people to the whole series who I think would
> > > like the whole series and then let get_maintainer pick extra people it
> > > thinks are relevant to each individual patch.  If I see you respond to
> > > any of the patches in the series, though, I'll add you to the whole
> > > series Cc list next time.
> > >
> > > Changes in v5:
> > > - Removed bit about OS may ignore (Rob/Ezequiel)
> > > - Added Heiko's Tested-by
> > > - It's not just jerry, it's most rk3288 Chromebooks (Heiko)
> >
> > What are the plans to move forward with this?
> > Or did you drop the whole idea again?
>
> At the moment I'm blocked on Thierry responding, either taking the
> patch or telling me what I need to do to fix it.  I saw Sean Paul ping
> Thierry on IRC on June 3rd and as far as I could tell there was no
> response.
>
> https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2019-06-03&show_html=true
>
> ...and as you can see Heiko pinged this thread on June 14th.
>
> Thierry: can you help give us some direction?  Are you uninterested in
> reviewing them and would prefer that I find someone to land them in
> drm-misc directly?

Sam: Oh!  I hadn't noticed that you've been added as a panel
maintainer in commit ef0db94f94a0 ("MAINTAINERS: Add Sam as reviewer
for drm/panel").  Does that mean you are able to provide some advice
for how to land this series?  As far as I know everything is in order
for it to land, but if you are aware of something I need to do to spin
it then please let me know!

Thanks!

-Doug
