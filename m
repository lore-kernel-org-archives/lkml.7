Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD37C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2D2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nyopb1Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgAFWZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:25:52 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33032 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:25:51 -0500
Received: by mail-vk1-f195.google.com with SMTP id i78so12909365vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eV/1akoxP7P3ABmGBw2S16HDMJ8eaLjqFUo1f5/sSLU=;
        b=Nyopb1GgYHuYm4R4qPjbmQiRz9pqSDRwa0NMCNwzi97cVj5VOB0eC1RQIKPkLo7RAY
         3Yfg8Sb5Xzxc2VGfuD3QSRolbSggv0XZfau1AluQ0W6H97XjPI2HXUl3iqL/kDoH8Uf3
         zHQkdzZ2Dg3uxiLBFDyXjtSHyOlzhm3/QNAgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eV/1akoxP7P3ABmGBw2S16HDMJ8eaLjqFUo1f5/sSLU=;
        b=XPJworXJnVlzqCGSO96zo6jgBojnRPp91YgKOpNdic3fLF4iCH6a3Slla/9+Y51FJx
         r7fbLwj+OvWgkazK7FLRC9eYWjgsLqkBinJM62Jjm+1nPB3uCZTFeDGYNqcciDllvUTL
         fXnbl4uDCOKjAhG+Qld0lfavLd6UVAZiGVFQcFLgKlq4bi0sRQBPxDWFuXRQlgaP3VWT
         UP+580IwfJCmwmtAqNKq5uzoNNf8M+kvvb+IvOT9GvTfNOeiBzQQbULqoJzldnQaInEf
         zmc3763xPR+gX1EZ/fuxVVxB7xQBfMgZidMbKYhc1MLXIvPMOxYo8b+6Fdvnmy/BqLR0
         Ibmw==
X-Gm-Message-State: APjAAAWLNhqn2Iz/xN4FpVq216jxAlkMF1IM+84OnpBPMX4TEwzE0ejE
        CM3vsfKy8olsKZQ9SPp4wPjXZ3NQYUs=
X-Google-Smtp-Source: APXvYqyv8A+f20/WLireLiLyJG8ZIGlmkiG4VYBoh6SQRysE4BtpREf++1pdky9K29JNFq28buw8vA==
X-Received: by 2002:a1f:e784:: with SMTP id e126mr61611505vkh.102.1578349550438;
        Mon, 06 Jan 2020 14:25:50 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id n204sm18656240vkn.7.2020.01.06.14.25.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 14:25:49 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id x123so32642843vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:25:49 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr55143272vsd.106.1578349548941;
 Mon, 06 Jan 2020 14:25:48 -0800 (PST)
MIME-Version: 1.0
References: <HE1PR06MB40118544456FC5461F49DDE8AC2E0@HE1PR06MB4011.eurprd06.prod.outlook.com>
In-Reply-To: <HE1PR06MB40118544456FC5461F49DDE8AC2E0@HE1PR06MB4011.eurprd06.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jan 2020 14:25:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XbmwC1H446Og9juqYBR66ozjNVw9SDa2WWz=sKQg_imw@mail.gmail.com>
Message-ID: <CAD=FV=XbmwC1H446Og9juqYBR66ozjNVw9SDa2WWz=sKQg_imw@mail.gmail.com>
Subject: Re: [PATCH for 5.5] phy/rockchip: inno-hdmi: round clock rate down to
 closest 1000 Hz
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 23, 2019 at 12:49 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Commit 287422a95fe2 ("drm/rockchip: Round up _before_ giving to the clock framework")
> changed what rate clk_round_rate() is called with, an additional 999 Hz
> added to the requsted mode clock. This has caused a regression on RK3328
> and presumably also on RK3228 because the inno-hdmi-phy clock requires an
> exact match of the requested rate in the pre pll config table.
>
> When an exact match is not found the parent clock rate (24MHz) is returned
> to the clk_round_rate() caller. This cause wrong pixel clock to be used and
> result in no-signal when configuring a mode on RK3328.
>
> Fix this by rounding the rate down to closest 1000 Hz in round_rate func,
> this allows an exact match to be found in pre pll config table.
>
> Fixes: 287422a95fe2 ("drm/rockchip: Round up _before_ giving to the clock framework")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)

Sorry for the regression and thanks for the fix.  It seems sane to me
since you're just matching against your own table and all the rates
there are all in kHz.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
