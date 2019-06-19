Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7811C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9582166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jcAWf4ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfFSVXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:23:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37936 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSVXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:23:07 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so72750ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Cs6Vhxf3ibwNHsRfPgJ7kBQS0+myDn1Z6sIvkVbn6w=;
        b=jcAWf4ZIO2217+MIicbCG9Un7x60cTFIYR6ZJybuw5Vhx6H9fM+moRWCp4qjjD4imm
         TIb7ZW0IpLxIanQODZnwG/l6RqWUt278U5M73z1SQC65ALD6aqu+B4Z+HCaK18hJGn3t
         KF+A4nrUXysjLjRrFgq191iZRNwC0WFGbd5Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Cs6Vhxf3ibwNHsRfPgJ7kBQS0+myDn1Z6sIvkVbn6w=;
        b=IIQp6kyDTjQEUgi96EeEoC1DPFKi600OUm6rQA+i0eXJCZ0ogZVyBFKDSC36wX4sCu
         apZ3HVLZXF5XiM+W3e6rSTZ9b9DwM4dTgZHQ6qiYy/dTwToIwjZh0R5nkD5MkwxqN9J+
         DwTHcdrQyhUKEiLc5Tgf9CeB04qJINZXDTRKMWMv8+5BD+IwK9p2gXVvFC2+Re4H6bvd
         QoSnpmmzsYnMGMGQRYxLmatYbszEbKEqUzRO0q2IG31GFWU30np2S9RsscGcwDaGpnxU
         UuZsIiMXyVxmVM1dnJ+erBIlvBVOxbJRpEjZvkJCx/Ymn58D8VjpvptkRg08hh0FsV+P
         VAJg==
X-Gm-Message-State: APjAAAUCw3p2adiDfygdNiPdeo2+a5mF17OZPMQr4hLnW4+hdKPPmtr2
        CHF4hs7jgtOO7b2xRsGcbB6JwHJYAsE=
X-Google-Smtp-Source: APXvYqxePMHcI7ZLRzp7Z9CRcnyQedq5eTyQOA1GgaxQqJ7P7VrJiiTNak82UY6BZSZRmtEnHhUA9A==
X-Received: by 2002:a6b:bf87:: with SMTP id p129mr7706211iof.253.1560979386598;
        Wed, 19 Jun 2019 14:23:06 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id f20sm19172040ioh.17.2019.06.19.14.23.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:23:05 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id k8so105707iot.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:23:05 -0700 (PDT)
X-Received: by 2002:a02:878a:: with SMTP id t10mr12921318jai.112.1560979385096;
 Wed, 19 Jun 2019 14:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190612085147.26971-1-narmstrong@baylibre.com>
In-Reply-To: <20190612085147.26971-1-narmstrong@baylibre.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Jun 2019 14:22:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UgmMGZHf_Y+GBgQ+fLYGF3yinj3LtLFRhNwABQB6r-qQ@mail.gmail.com>
Message-ID: <CAD=FV=UgmMGZHf_Y+GBgQ+fLYGF3yinj3LtLFRhNwABQB6r-qQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Use automatic CTS generation mode
 when using non-AHB audio
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 12, 2019 at 1:51 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When using an I2S source using a different clock source (usually the I2S
> audio HW uses dedicated PLLs, different from the HDMI PHY PLL), fixed
> CTS values will cause some frequent audio drop-out and glitches as
> reported on Amlogic, Allwinner and Rockchip SoCs setups.
>
> Setting the CTS in automatic mode will let the HDMI controller generate
> automatically the CTS value to match the input audio clock.
>
> The DesignWare DW-HDMI User Guide explains:
>   For Automatic CTS generation
>   Write "0" on the bit field "CTS_manual", Register 0x3205: AUD_CTS3
>
> The DesignWare DW-HDMI Databook explains :
>   If "CTS_manual" bit equals 0b this registers contains "audCTS[19:0]"
>   generated by the Cycle time counter according to specified timing.
>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 44 +++++++++++++++--------
>  1 file changed, 29 insertions(+), 15 deletions(-)

Tested-by: Douglas Anderson <dianders@chromium.org>
