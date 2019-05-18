Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1180AC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3167206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDXYnqYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfERNm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 09:42:28 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37093 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfERNm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 09:42:28 -0400
Received: by mail-vs1-f68.google.com with SMTP id o5so6432455vsq.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 06:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RGFFzjBhNiyidD59Z5h5Zp/VrAgBZOeTOoJ9odKkxU=;
        b=YDXYnqYIaeJRG4ysVyvDzCaIhFqdYTMYbXS2cChMC/tqYsViXrSpvQfFj1YCueaAn9
         VUnk6J+fvbwekMY20xSYwssbKxGE3X1+lo8Z9tD6OkRIplPCUVGDlfmqbPcqns0fI1Np
         /iDN17LGgWZYBF9cCZNP7YkUa9MLXM6AOMgfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RGFFzjBhNiyidD59Z5h5Zp/VrAgBZOeTOoJ9odKkxU=;
        b=fPRH5vcvhUnwA9fPMGyXBXNA0EO+GhkhcSJIhQxHPJgayXAdjRS+E/Rb1QazO5wdQf
         evD77bfkZopQDxLXX4ZKosZFD3p1OzxMDBkWu8N/ES3vqD1ocm6RXP+/+3XBlLuK2rK3
         fUyB5Pv4t9HPyXp9ruQknnM+hSRnw82fIZARf0LjGAb/tj8/t5SryvpfFnLJSfRA7yVA
         r6VL6qosoUO7JYhvIqHIvUPJciwmhpaV9OmeTJj1pMO2UkMIVj8LsHcpw1XnQxTVLjHn
         R6UPjczDDM5K66LjmFOUnJNTUF9tG21ZXhebMQW0XWSC2fAQq568azoC2RV1xfBzSg5C
         5nuA==
X-Gm-Message-State: APjAAAWXY0d0VeoVCHHNr/CXnLSuM51idv1pOn/RQzgd5a9ilj+crtTa
        nNTv2acj4N/SJ7DOuC8Xm7+g+z0+904=
X-Google-Smtp-Source: APXvYqyvcr8wr50C5QEW9bs/YtVgzk+5Jj/0kIeNklRjlT7p7A546vhdML5BkKYdULTbC7e/S3ERPQ==
X-Received: by 2002:a67:f60b:: with SMTP id k11mr23087491vso.111.1558186946784;
        Sat, 18 May 2019 06:42:26 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id j195sm5136085vkd.3.2019.05.18.06.42.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 06:42:23 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id e9so3783583uar.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 06:42:23 -0700 (PDT)
X-Received: by 2002:ab0:2709:: with SMTP id s9mr14728825uao.21.1558186942832;
 Sat, 18 May 2019 06:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190507234857.81414-1-dianders@chromium.org> <CAD=FV=VcF688tSArf5gu0sV5oKVgFEvPBxXm7j-5GXXMP_CYRw@mail.gmail.com>
 <1862323.vETM5zrFmV@phil>
In-Reply-To: <1862323.vETM5zrFmV@phil>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 18 May 2019 06:42:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XhQtsPkvFuQ4cP5769XmbvkT7csFrcVkHT6ktySSYOdw@mail.gmail.com>
Message-ID: <CAD=FV=XhQtsPkvFuQ4cP5769XmbvkT7csFrcVkHT6ktySSYOdw@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-dp: Avoid power leak by leaving the PHY
 power on
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Caesar <wxt@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 18, 2019 at 12:51 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Samstag, 18. Mai 2019, 01:57:47 CEST schrieb Doug Anderson:
> > Elaine and Caesar,
> >
> > On Tue, May 7, 2019 at 4:50 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > While testing a newer kernel on rk3288-based Chromebooks I found that
> > > the power draw in suspend was higher on newer kernels compared to the
> > > downstream Chrome OS 3.14 kernel.  Specifically the power of an
> > > rk3288-veyron-jerry board that I tested (as measured by the smart
> > > battery) was ~16 mA on Chrome OS 3.14 and ~21 mA on a newer kernel.
> > >
> > > I tracked the regression down to the fact that the "DP PHY" driver
> > > didn't exist in our downstream 3.14.  We relied on the eDP driver to
> > > turn on the clock and relied on the fact that the power for the PHY
> > > was default turned on.
> > >
> > > Specifically the thing that caused the power regression was turning
> > > the eDP PHY _off_.  Presumably there is some sort of power leak in the
> > > system and when we turn the PHY off something is leaching power from
> > > something else and causing excessive power draw.
> > >
> > > Doing a search through device trees shows that this PHY is only ever
> > > used on rk3288.  Presumably this power leak is present on all
> > > rk3288-SoCs running upstream Linux so let's just whack the driver to
> > > make sure we never turn off power.  We'll still leave the parts that
> > > turn _on_ the power and grab the clock, though.
> > >
> > > NOTES:
> > > A) If someone can identify what this power leak is and fix it in some
> > >    other way we can revert this patch.
> > > B) If someone can show that their particular board doesn't have this
> > >    power leak (maybe they have rails hooked up differently?) we can
> > >    perhaps add a device tree property indicating that for some boards
> > >    it's OK to turn this rail off.  I don't want to add this property
> > >    until I know of a board that needs it.
> > >
> > > Fixes: fd968973de95 ("phy: Add driver for rockchip Display Port PHY")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > As far as I know Yakir (the original author) is no longer at Rockchip.
> > > I've added a few other Rockchip people and hopefully one of them can
> > > help direct even if they're not directly responsible.
> > >
> > >  drivers/phy/rockchip/phy-rockchip-dp.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > Can you help direct this to the right person?  ...or should we just
> > land it and assume it's fine?
>
> I tink Kishon as phy-maintainer is the correct person to take on this
> patch, but maybe he's waiting for the merge-window to be over.

Yeah, definitely Kishon should be the one to land.  I was kinda hoping
to get confirmation from the Rockchip guys that this was a good idea
across the board for rk3288 since I can only really test
rk3288-veyron.  They'd have access to the SoC design and could tell
more about what this bit actually does in the SoC.

...in any case, if they don't respond then presumably we'd be good to
land once the merge window is over and Kishon is landing patches
again.

-Doug
