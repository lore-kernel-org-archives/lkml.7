Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E58C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CD420684
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxmgdcxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfGFKSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:18:23 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40993 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGFKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:18:23 -0400
Received: by mail-vs1-f68.google.com with SMTP id 2so5265193vso.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAVwcJuM+YKewDeekBtdpzxDH4pN8Z1qY7lRoAxlQ2k=;
        b=LxmgdcxPecTrogSpOJXeHAvpLygjo6I3MXbMM2SYl+QXjS6fO+EQHhi8KNRAZ1Z1aa
         7c0i45kq3WMa2ftCYUtfQ1IWl836CgNJ1myvCLLiNdPdEEBpafk5GG4cD/UCrtAGhTqT
         oaI01JbitM9uW1q7vmGKd2LVxuVnT5f0gv4yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAVwcJuM+YKewDeekBtdpzxDH4pN8Z1qY7lRoAxlQ2k=;
        b=kswZqLH5ttU1EU4hYA06wKRiMTBBrQ+PgAbUWkncRJRB/ZBMVcuN1SaFL2rLkLez2F
         J23CxUOgrjUjEmNJDh+Hg54r/iBCofLy3nW1noOgozdbtxezn1T6OexZP830Pg9WHkdZ
         gsmH8CnOxg4iA4aZN7NlyWcxeOAFRsE/CrUxgIM+cm/157Nyt/l7IwCiH1q3aegEcdGz
         mbRmYLyjCBWM7yljZM058a9ejlJtSjDOOWc8mtWc6asI9cFYve27N2K26ISEgsv+J6BP
         pMsZCUO48RLsSaLImCc1QTNRvlqP1mTL2KS+eRKBEogCoyBfJUPym/Crj6FmEFwfFblv
         hKNw==
X-Gm-Message-State: APjAAAXSsVlchAwQDWNnVrwZP3px73+NRvwAlx+XSmBlu942xyBEpyWT
        kHN3viQXLR9fYDOahEsmvpASm3F1smQhjcv+7r6QKwsnnhBOOQ==
X-Google-Smtp-Source: APXvYqwHXziO50Z/T/wc7OBaLrepyZ4DeDeLVwv5g2F6618IyLzz5j+3wEg9LMO4ASJyJbXamm3xKkz3W1VhuzqonMQ=
X-Received: by 2002:a67:f7cd:: with SMTP id a13mr2560400vsp.163.1562408301993;
 Sat, 06 Jul 2019 03:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-3-cychiang@chromium.org> <VI1PR06MB41425D1F24AC653F08AFA463ACF50@VI1PR06MB4142.eurprd06.prod.outlook.com>
 <CAFv8NwJXbJo=z_NDj+JQHD9LOmnbfM8v_N1uHn4sdBzF-FZQfA@mail.gmail.com> <20190705171618.GA35842@sirena.org.uk>
In-Reply-To: <20190705171618.GA35842@sirena.org.uk>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Sat, 6 Jul 2019 18:17:54 +0800
Message-ID: <CAFv8NwKhBKaDAzfdRVGzOs0M3quZeZANWQ2EDo210jy9M-c0cQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/4] drm: bridge: dw-hdmi: Report connector
 status using callback
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tzungbi@chromium.org" <tzungbi@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dgreid@chromium.org" <dgreid@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 1:16 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 05, 2019 at 03:31:24PM +0800, Cheng-yi Chiang wrote:
>
> > It was a long discussion.
> > I think the conclusion was that if we are only talking about
> > hdmi-codec, then we just need to extend the ops exposed in hdmi-codec
> > and don't need to use
> > hdmi-notifier or drm_audio_component.
>
> What I'd picked up from the bits of that discussion that I
> followed was that there was some desire to come up with a unified
> approach to ELD notification rather than having to go through
> this discussion repeatedly?  That would certianly seem more
> sensible.  Admittedly it was a long thread with lots of enormous
> mails so I didn't follow the whole thing.

Hi Mark, thanks for following the long thread.
The end of the discussion was at
https://lkml.org/lkml/2019/6/20/1397

Quoted from Daniel's suggestion:
"
I need to think about this more, but if all we need to look at is
hdmi_codec, then I think this becomes a lot easier. And we can ignore
drm_audio_component.h completely.
"

My thought is that the codec driver under ASoC are only these two:
hdac_hdmi.c and hdmi-codec.c  ( forgive me if I missed others. I just
grep "hdmi" under sound/soc/codecs/ )
hdac_hdmi.c is like a wrapper for HDA and drm_audio_components.
hdmi-codec.c is the only other codec driver that cares HDMI under ASoC.
So adding the jack/eld support at hdmi-codec driver can cover the
existing use cases for HDMI codec driver in ASoC.
That said, adding a new unified approach for Jack/ELD notification
that will only be used by hdmi-codec seems not a high priority.
Hope this explanation helps your decision.
Thanks!
