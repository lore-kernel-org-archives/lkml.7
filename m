Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A37C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E01F2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572020557;
	bh=YnQL01UumaW7b7M2qX2sASeCb6Qo9nVI3pUMRuElEnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eAOkdhj245folUHoODWD9eY8R+HVUVdtoAC21qPfFKejoWgsIOti6vr4qZ5eDjTJd
	 +DQyF0xbiH6d1GGUzC5MauXlcDdPA6F0mWM+DFu9Y2pZP24gKbh5Ky7AvC7ZRH1Z79
	 Op1TNNqXu8gLy0e+NVORI/cUhm3Cf1egLZ9FT2J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632859AbfJYQWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:22:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44962 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632806AbfJYQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:22:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id n48so2420034ota.11;
        Fri, 25 Oct 2019 09:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DcXI0ptEmLNRJ3ATloq3LFD9nbZMbeqbCJ87LxNGHWo=;
        b=PaBxT/zjhHIZGXJYauWxCPNHPmYAodN02jgvrTjDGa55nYgPbwHr9+HFzdJGdUKXw0
         IN5gNzuJQe4Oohf1yO3z/akOKhwJejU4TCKKD0rmqLSPZeS8XHPZqYtkYzx8cPxku7Nw
         Sp+FHFRTXC9KjUCw7+4NUBZYuixsVxj4s05ep5ugKmJ41hs7Zkc5KiW+gpUM+xjIlA9I
         8zquV4Rb+Bu+Gal1UebVd89ghva9XdLDkcIm06SbuTB33/693gy9K2CDhOHTIQfbrLGM
         MCGBUH+ipTNj9TxDINq8k3GTMfxWJ1z/x66NWn17/9azUrSnxZu8wiBFg9h8ATI70ube
         NdeQ==
X-Gm-Message-State: APjAAAVeLFL5CRqTfJZ9ITjodcgQTO4eQRi2piItkk6vh/fkD5hzPVfa
        SuHkWvlkC51lbaz9NP2a3w==
X-Google-Smtp-Source: APXvYqzzIuc1vcdp++0F80RLl8KAdKlip2Nqm2Fe6QaByRNOoVA8SwaqBnoVkTda+L/6FQKAQI1xRg==
X-Received: by 2002:a9d:3476:: with SMTP id v109mr3516135otb.211.1572020554577;
        Fri, 25 Oct 2019 09:22:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i5sm836976otk.10.2019.10.25.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:22:33 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:22:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/6] ASoC: rockchip-max98090: Support usage with and
 without HDMI
Message-ID: <20191025162232.GA23022@bogus>
References: <20191025133007.11190-1-cychiang@chromium.org>
 <20191025133007.11190-3-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025133007.11190-3-cychiang@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 09:30:03PM +0800, Cheng-Yi Chiang wrote:
> There will be multiple boards sharing this machine driver.
> Use compatible string to specify the use case.
> 
> "rockchip,rockchip-audio-max98090" for max98090-only.
> "rockchip,rockchip-audio-hdmi" for HDMI-only
> "rockchip,rockchip-audio-max98090-hdmi" for max98090 plus
> 
> Move these properties to optional because they are not needed for
> HDMI-only use case.
> "rockchip,audio-codec": The phandle of the MAX98090 audio codec
> "rockchip,headset-codec": The phandle of Ext chip for jack detection
> 
> The machine driver change will add support for HDMI codec in
> rockchip-max98090.
> Add one optional property "rockchip,hdmi-codec" to let user specify HDMI
> device node in DTS so machine driver can find hdmi-codec device node for
> codec DAI.

Why not just use the presence of rockchip,hdmi-codec to enable HDMI or 
not. Maybe you still add rockchip,rockchip-audio-hdmi for HDMI only.

Really, the same should have been done for which codec is used too, but 
I guess someone wanted 2 machine drivers.

> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  .../bindings/sound/rockchip-max98090.txt      | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
