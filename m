Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671C6C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB012173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wl9L0AJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfETXYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:24:37 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33047 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfETXYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:24:36 -0400
Received: by mail-ua1-f68.google.com with SMTP id 49so5953623uas.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZR/L7Hf828I4020IYpCxcxcft8SiYhAJProPc5vXrzU=;
        b=Wl9L0AJOEI10bssx6lat9jgrA3rPKbO8BogUuRNHLDN7Ve5zvOpZnNKVUMTpQBBSvA
         p/ROLEzSFq3wxGQ6g2TbkeeBcO4ve3Y+PyFFmeHbkUyvbi63Vy39FzWnFqQ/iYDf8s83
         1rVab5Txti5C4wfalrdFVBqPk8IPgB+yp/yHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZR/L7Hf828I4020IYpCxcxcft8SiYhAJProPc5vXrzU=;
        b=Qs74d5ZpQUmA1qYRTBHdMfx7uV0Da/3laQ3gnQ1mDpLjQN/fHpxrClan55qqhNSFuI
         ug0gC/ZL/8JsS/gv6xikEN2nPPFn+ylt4hNaN0uV2YPCfDk3WUpNpGXz4fNRODhGXvb0
         N9OEnG6UTC9qif/FKaHCZGn+hIX7zOrFKlXkGDBOK9vqOnrTSr0LpEYYMQS/K+WEVTSz
         wulsUkeYpTkBpa0iwulupqS1jC5IwFY/2Vuafj0YbkukeSuGwTNHhV0YgO3e98N6a7FF
         XQ0gPLy4KQ2+1vZeNdC9qHArA6BbH4tG4Ufy9g1dOdVkHyzFvjhef9eHJIV4djgJYwlA
         KPMw==
X-Gm-Message-State: APjAAAXRvILVFY05+kqSaAKldb5091cW2vZNYbZDnNWWbOud/gtjBBdk
        q9ubiJU7hdOvJCst0IiFcRRRw8fbK8U=
X-Google-Smtp-Source: APXvYqyS/TGPLW4pAfNatCZ6/BKCoXPD8oL5GUDXmOM3JjIN1fEAUcout222wCDZyYE4x+U23YOxTw==
X-Received: by 2002:ab0:3499:: with SMTP id c25mr8038668uar.56.1558394675670;
        Mon, 20 May 2019 16:24:35 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id u83sm6766587vke.33.2019.05.20.16.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:24:34 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id w124so2047674vsb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:24:34 -0700 (PDT)
X-Received: by 2002:a67:f60b:: with SMTP id k11mr31398691vso.111.1558394674402;
 Mon, 20 May 2019 16:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220051.54847-1-mka@chromium.org>
In-Reply-To: <20190520220051.54847-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 16:24:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WxhL3FLYWvOoys3GOB68WVKinfgjTVK5byyzyTzVsyBw@mail.gmail.com>
Message-ID: <CAD=FV=WxhL3FLYWvOoys3GOB68WVKinfgjTVK5byyzyTzVsyBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: disable GPU 500 MHz OPP for veyron
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 20, 2019 at 3:01 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The NPLL is the only safe way to generate 500 MHz for the GPU. The
> downstream Chrome OS 3.14 kernel ('official' kernel for veyron
> devices) re-purposes NPLL to HDMI and hence disables the OPP for
> the GPU (see https://crrev.com/c/1574579). Disable it here as well
> to keep in sync and avoid problems in case someone decides to
> re-purpose NPLL.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to the series
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
