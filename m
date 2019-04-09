Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD3AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB77D20663
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qo6xgz7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDIImm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:42:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38989 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIImm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:42:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so2284654wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JOnz41YeiiwGNUNF/rubyOkNKVgAf6MWK9CiwaNBXWU=;
        b=Qo6xgz7smkAwnlrKsgmO/SjKyf18u7zpGG3sxVmoSYnlhFpR+XGNpfn3Anb16N9Ton
         082wItw55Xkpw52NacEMESHAPQvyGqTJJqyNBXC7ww7OUSFCEunbDb24CJCSIJTWBkI+
         ItOtX+Ri50Oc8qh8jkJprn9zDp7twC5YcXo7xFlpIuMrZFzNNYH0y/O5dSGS/0Go2YOK
         fD0h2sGX4YJJy8zgfQX474rG9XgQDUUgrAj7KwZQcg0wvLhAp6ZxPXahOf8z/R8P79UT
         wJeXAU+w0epL3nGT4+bmp9p6PLb/GkulodnlRzjMZfwlnWg6lwePz7UUrql179o8b4ru
         /zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JOnz41YeiiwGNUNF/rubyOkNKVgAf6MWK9CiwaNBXWU=;
        b=b/1Bt1M9anhw9/0XE4afKXjVIJDaQFxABZZ/ygf2LlmhgXjjlRvAXpWdLnFllnUzua
         ofb/Sr6hzf3lpr2DWTKy2CEvhB/If99kIIL71GqtC3phvOdw/auTfeujmpUSHNmwrGNC
         C8DNpPxxN9SydqAQP92UeOrdH5TjiiESZvvhIBT9J81apRlb/L6geVdyOf62vI6h4U89
         0t4VfslAIJNGCl0sZTAbR9JgEwnRTqMh90/2AAUI9S6UjIgGJCxPnXuZuuyYCseUKJE9
         kgC/SFF+QnPJn8IKzNXPChj0FAQ4vY1oq534PWCyY7QC1lQGOksYlVip7x7nHyUj0Q2/
         VaFA==
X-Gm-Message-State: APjAAAX0EaYPj/RgE+JofhbyXobfJ53xq3zplwMBIsSWiL/nxHt7mshi
        0n/LbxZdl1EQ5NJbWeNWZ82+bAXwCqU=
X-Google-Smtp-Source: APXvYqyUYLoNvi0tN6IXmGKk3doOyGYa/RBrilvZmg9iBxSmTIFOeBteobyAjVVNeFWPX4ZCgu2M9Q==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr11002750wmc.137.1554799360129;
        Tue, 09 Apr 2019 01:42:40 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id h84sm16963940wmf.15.2019.04.09.01.42.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 01:42:39 -0700 (PDT)
Message-ID: <84e8a61db1be6e83e7dcd9630fde17cfc59eb8a3.camel@baylibre.com>
Subject: Re: [PATCH 00/11] drm/meson: Add G12A Support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Apr 2019 10:42:37 +0200
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
> The Amlogic G12A SoC offers very close Video Display
> functionnalities with it's older GXBB, GXL & GXM predecessors.
> 
> The main differences are :
> - G12A Support now 3 "real" OSD planes with a new Blender module
> - Instead of having a single Scaler for OSD1, G12A has two scaler
>   that can be applied to 2 out of the 3 OSD planes or on the outputs
>   of the blender module.
> - The HDMI PHY now support RX-SENSE, Dynamic HDR and it's registers are
>   now memory mapped instead of using an internal bus.
> - The VPU now support a DSI interface to connect a display, using
>   the Synopsys DSI controller and a custom PHY
> 
> The complex Blender routing, HDMI RX-SENSE, Dynamic HDR and DSI support
> are not handled in this patchset.
> 
> This patchset implements on-par support with the currently support
> GXBB, GXL and GXM SoCs. There is no support delta with this patchset.
> 
> patch 10 & 11 implements the bindings found at [1].
> 
> [1] https://lkml.kernel.org/r/20190313141030.5958-1-narmstrong@baylibre.com
> 
> Neil Armstrong (11):
>   drm/meson: Switch PLL to 5.94GHz base for 297Mhz pixel clock
>   drm/meson: Add registers for G12A SoC
>   drm/meson: Add G12A Support for VPP setup
>   drm/meson: Add G12A Support for VIU setup
>   drm/meson: Add G12A support for OSD1 Plane
>   drm/meson: Add G12A Support for the Overlay video plane
>   drm/meson: Add G12A support for plane handling in CRTC driver
>   drm/meson: Add G12A support for CVBS Encoer
>   drm/meson: Add G12A Video Clock setup
>   drm/meson: Add G12A compatible
>   drm/meson: Add G12A support for the DW-HDMI Glue
> 
>  drivers/gpu/drm/meson/meson_crtc.c      | 269 +++++++++++++++++++-----
>  drivers/gpu/drm/meson/meson_drv.c       |   1 +
>  drivers/gpu/drm/meson/meson_drv.h       |   4 +
>  drivers/gpu/drm/meson/meson_dw_hdmi.c   | 163 +++++++++++---
>  drivers/gpu/drm/meson/meson_dw_hdmi.h   |  32 ++-
>  drivers/gpu/drm/meson/meson_overlay.c   |  10 +-
>  drivers/gpu/drm/meson/meson_plane.c     |  15 +-
>  drivers/gpu/drm/meson/meson_registers.h | 247 ++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_vclk.c      | 123 +++++++++--
>  drivers/gpu/drm/meson/meson_venc.c      |  11 +-
>  drivers/gpu/drm/meson/meson_venc_cvbs.c |  25 ++-
>  drivers/gpu/drm/meson/meson_viu.c       |  72 ++++++-
>  drivers/gpu/drm/meson/meson_vpp.c       |  51 +++--
>  13 files changed, 880 insertions(+), 143 deletions(-)
> 

on the u200 and sei510
Tested-by: Jerome Brunet <jbrunet@baylibre.com>

I can't pretend to have a deep understanding of this subsystem, but as far as
I can tell, there is nothing crazy in there. With the comments around the use
of constants and defines fixed, you can add

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

As a possible future enhancement, it would be nice if you could trim the use
of *_is_compatible() functions. I think it would make the code easier to
follow and review.

