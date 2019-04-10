Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8A7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B759820850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dAFkt5gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDJXxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:53:43 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35092 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJXxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:53:42 -0400
Received: by mail-ua1-f68.google.com with SMTP id a46so1416260uae.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0qanv7PkolgBRvQhOiiO7uLFouvsHLGSXfQVakL2Ms=;
        b=dAFkt5glW3EJq2VCarRBNy6coE53xZFx79EzlWgGURRZZR0HY3yfwmMCEsRRFPjn5l
         VKJ0h1EziMe23vQ1UgryqzHe/CZTjF6ugJ2eobx7Qs9G0BBz6B9ers9Vw2emh6Qfcvz5
         ZFsSSnXzbhQNTAqMcFnBi1Td+gllP8VwqvAvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0qanv7PkolgBRvQhOiiO7uLFouvsHLGSXfQVakL2Ms=;
        b=F3gEh5OLtL/23k9mssT4SqeF6PArbvk2ZDDxsELsO5XMMtV3L4v5lgb96zU8nrNOI8
         r0V3QZ/jbxOzxg/7b60KPl3wac4l98FAOKH4dz22AVDpEiU3RImeZ21OyzcuswHIrn2J
         QdpbCmMeLFUSyWYoJgQ3Y65RwPWOJh6n35HQsqPrLlmEb4JMIFYI9rvCI8+UfsS3/8xc
         TcN+3D/e9vivDktboIsYgvhBJdmw5+8FcGLgq6lnX2V6tGxZxO2DbwcyRqWlpedBnQ5e
         9MRwO7czUS7lV99Yrd+rsddLAJPvR2r7PHZFuYfALeh5pM9q+x2BbUr0FJQdpYpjZTNQ
         ZIpg==
X-Gm-Message-State: APjAAAUx36NlyF8MlwNlW4FeO75an37eA7xEs9iOihuv0mwFvfbQO027
        xGXUk09sRKMHicjWFR2mV8fODKppocA=
X-Google-Smtp-Source: APXvYqwXEdcMywGiV/cBdinxkThbNPhucgBX8Zs7KOFxL/IPId2d49+ZTWekrcKN7QvQvjeKiW7rMA==
X-Received: by 2002:a9f:3233:: with SMTP id x48mr2659583uad.89.1554940421767;
        Wed, 10 Apr 2019 16:53:41 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id d133sm7956205vke.19.2019.04.10.16.53.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:53:41 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id f15so2423974vsk.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:53:40 -0700 (PDT)
X-Received: by 2002:a67:ed84:: with SMTP id d4mr3698410vsp.207.1554940420519;
 Wed, 10 Apr 2019 16:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190410183010.21307-1-mka@chromium.org>
In-Reply-To: <20190410183010.21307-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Apr 2019 16:53:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xa446sRq0P=jNRHu-eqhPVpB1A-0LDoqokLi3+SYXxgg@mail.gmail.com>
Message-ID: <CAD=FV=Xa446sRq0P=jNRHu-eqhPVpB1A-0LDoqokLi3+SYXxgg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: Remove unnecessary setting of UART0
 SCLK rate on veyron
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 10, 2019 at 11:30 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Some veyron devices have a Bluetooth controller connected on UART0.
> The UART needs to operate at a high speed, however setting the clock
> rate at initialization has no practical effect. During initialization
> user space adjusts the UART baudrate multiple times, which ends up
> changing the SCLK rate. After a successful initiatalization the clk
> is running at the desired speed (48MHz).
>
> Remove the unnecessary clock rate configuration from the DT.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 4 ----
>  1 file changed, 4 deletions(-)

Nice.  Looks like this hasn't been needed for a while.  Back in 3.14
when I first added this it was important because "8250_dw.c" didn't
have a clk_set_rate() in it, but seems like it's been there forever
now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
