Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8445AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF76215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cMQ/vDuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFUJBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:01:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40172 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfFUJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:01:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so9024012eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xgdrm/+uDzgv3SzhRxL0tfed3iEPzeIqwWeZ4LUbXGY=;
        b=cMQ/vDuRGUEoyum98yMdueDd2jydiu/6afc0tmWAZBeP10inFyVjuZChKUqT4PiHp4
         ZaSOaO0GrmX6Pzrpoc89zr4LDXG1Rs6RAUq+EHe/URL5DxcN/rxWzl7evg9hSMa3R+ai
         uAt/AmC9AhH4m47gSgcwZtfZUKFOEVgKQDP5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Xgdrm/+uDzgv3SzhRxL0tfed3iEPzeIqwWeZ4LUbXGY=;
        b=Fcxn0ApXXBL5YjSfOX6Gb4KdSSRHlV5kKCE7W7JlNzNgZmt5JNonT+WDD8htRjLQtd
         qDE6XyWTFkkcehHyvDCsZysqk6QCg/oiBSO1eQKO2cEdewSUpc0SZCvBnP0R7WSTvk+t
         3LfpKySZA6fySFoijNyfUn3OdnukoIO3ozSi3whBLxQAV6Rgt16ThKbrJRizYULEaKVl
         jhl5f/B4/ksW6NuW1YKoa6T+uw/QJTanOIsvTpUL/x/5lG77zmiSu9iq3z9Xd5yck9Rb
         msYooQqIcy76lTRFkg+CRR1M7vNkZz4st+IXGA9Bdd+WkjB0RSi2qPMHbj7zOsGoNBBU
         e94Q==
X-Gm-Message-State: APjAAAU7OIeIub/U/T4tPZPIamU92U18ElkDOZ+JXeluuL6QFHoBda+p
        khupKjlNbpr9sX4AJm8AzLlrZg==
X-Google-Smtp-Source: APXvYqznrdn8j6NIihoYPfy33vPTVa+X0ZBuzxvWDrMGfyNYMVq6ZP0YVj6cK3KfmQdSrvV8TaEBdA==
X-Received: by 2002:a17:906:ce21:: with SMTP id sd1mr98973416ejb.189.1561107693780;
        Fri, 21 Jun 2019 02:01:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w35sm658424edd.32.2019.06.21.02.01.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:01:32 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:01:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>
Subject: Re: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
Message-ID: <20190621090125.GX12905@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <085dc3be-20e5-b2fe-4c02-bf4a4d1473da@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085dc3be-20e5-b2fe-4c02-bf4a4d1473da@baylibre.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 04:40:12PM +0200, Neil Armstrong wrote:
> Hi Andrzej,
> 
> Gentle ping, could you review the dw-hdmi changes here ?

btw not sure you absolutely need review from Andrzej, we're currently a
bit undersupplied with bridge reviewers I think ... Better to ramp up
more.
-Daniel

> 
> Thanks,
> Neil
> 
> On 26/05/2019 23:18, Jonas Karlman wrote:
> > Add support for HDR metadata using the hdr_output_metadata connector property,
> > configure Dynamic Range and Mastering InfoFrame accordingly.
> > 
> > A drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
> > can use to signal when Dynamic Range and Mastering infoframes is supported.
> > This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
> > and only GXL support DRM InfoFrame.
> > 
> > The first patch add functionality to configure DRM InfoFrame based on the
> > hdr_output_metadata connector property.
> > 
> > The remaining patches sets the drm_infoframe flag on some SoCs supporting
> > Dynamic Range and Mastering InfoFrame.
> > 
> > Note that this was based on top of drm-misc-next and Neil Armstrong's
> > "drm/meson: Add support for HDMI2.0 YUV420 4k60" series at [1]
> > 
> > [1] https://patchwork.freedesktop.org/series/58725/#rev2
> > 
> > Jonas Karlman (4):
> >   drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame support
> >   drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
> >   drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
> >   drm/sun4i: Enable DRM InfoFrame support on H6
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 109 ++++++++++++++++++++
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   |  37 +++++++
> >  drivers/gpu/drm/meson/meson_dw_hdmi.c       |   5 +
> >  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   2 +
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |   2 +
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h       |   1 +
> >  include/drm/bridge/dw_hdmi.h                |   1 +
> >  7 files changed, 157 insertions(+)
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
