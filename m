Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CEDC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CEA218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AI94tmMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfGEIa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:30:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37997 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfGEIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:30:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so7510634edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QbM44vAJoF7F4CJFe8D/rdMDdvpEwrpfX/ASCNMAqXA=;
        b=AI94tmMhDWpYtJmSG9OE2YtmGF4jgP603p1zLogEX94WNdxqWXxqEwxrlkap0wV7Yl
         ZZRrsbZx4mmXa6AJ4tYAh2jqBqJjFu9u5l/agQqdcx6lc9fHqFA0EU/eN4baePIRYs0K
         ZXYrsPW7Y5tzH4uUsUdwjuKhodl8pkaIRj+10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QbM44vAJoF7F4CJFe8D/rdMDdvpEwrpfX/ASCNMAqXA=;
        b=G+BqlVciEqe+pcAKlT1P9/V6eVqWsZFr140mJvWr/XW64hNbQJG93T/8aWxB9vHI+C
         R9+ijL+FthBxGzLmYWoqUFZe4a5xqnLC8TAw2pFyoaRlasN9pt/PiuCmCZW+sWmpCBaQ
         CYtMFYoWAhCdxqR6AAztIcQuO+Lg+lixtY524CPxBV4m5TIl+DUwqYdZ22YPncxlYGX2
         4jYVBZDNHHPIbQds2SoHvQp3oSjZNvjVZ+zQRsPb3bcjoHtOKIN1LTA0Qv4eXZvLBTAR
         fARW4166wwgZTlW0bD0jxkR0U/x9ykxg5IEFWVIQ9eHPoScdNnIYfBmow2qfK/kiOIBK
         kl9A==
X-Gm-Message-State: APjAAAWZ4KaCiQorcFQgEgbp9HZ0QO6+cKXhcjFKfRWNAJ7xgujob44j
        kV8OlWAkbgaSg0r8ofc1INdthA==
X-Google-Smtp-Source: APXvYqwxQTfCTwjg1Nv3JLxxlgEvpmawVRx0vKkBJIxGnG7RJ1+MqMHZ1WkVfQw3vC+4ikaheGDsmw==
X-Received: by 2002:a17:906:ce21:: with SMTP id sd1mr2339496ejb.189.1562315425410;
        Fri, 05 Jul 2019 01:30:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j16sm481089ejq.66.2019.07.05.01.30.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 01:30:24 -0700 (PDT)
Date:   Fri, 5 Jul 2019 10:30:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/4] Add HDMI jack support on RK3288
Message-ID: <20190705083022.GM15868@phenom.ffwll.local>
Mail-Followup-To: Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Heiko Stuebner <heiko@sntech.de>,
        dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20190705042623.129541-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705042623.129541-1-cychiang@chromium.org>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 12:26:19PM +0800, Cheng-Yi Chiang wrote:
> This patch series supports HDMI jack reporting on RK3288, which uses
> DRM dw-hdmi driver and hdmi-codec codec driver.
> 
> The previous discussion about reporting jack status using hdmi-notifier
> and drm_audio_component is at
> 
> https://lore.kernel.org/patchwork/patch/1083027/
> 
> The new approach is to use a callback mechanism that is
> specific to hdmi-codec.

I think this looks reasonable. There's the entire question of getting rid
of the platform_device in hdmi_codec an roll our own devices (so that it
all looks a bit cleaner, like e.g. the cec stuff does). But that can also
be done in a follow-up (if you can convince reviewers of that).
-Daniel

> Cheng-Yi Chiang (4):
>   ASoC: hdmi-codec: Add an op to set callback function for plug event
>   drm: bridge: dw-hdmi: Report connector status using callback
>   ASoC: rockchip_max98090: Add dai_link for HDMI
>   ASoC: rockchip_max98090: Add HDMI jack support
> 
>  .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |   3 +
>  .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  10 ++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  32 ++++-
>  include/sound/hdmi-codec.h                    |  16 +++
>  sound/soc/codecs/hdmi-codec.c                 |  52 ++++++++
>  sound/soc/rockchip/rockchip_max98090.c        | 112 ++++++++++++++----
>  6 files changed, 201 insertions(+), 24 deletions(-)
> 
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
