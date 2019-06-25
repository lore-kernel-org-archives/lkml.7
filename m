Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79A2C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ED021655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jy18i/ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfFYIli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:41:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46212 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfFYIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:41:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so15352701ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yY87oqTTD0Lxu/Nod5+FQjpzkb9Bg3pO2iG7HQ35E9E=;
        b=jy18i/ewXTLgSvPyNLRaupblj/y1T6RuSuzYOmPX9Rgd5ez/9RF4JcwCLM01Ki7+VD
         Mw5HQ7AHG8KHsR5lDtc5F0J+vvOHsVnN8x7Z0VxqkiQBcWFPRj0tKwvNTVFWT7+kwa1o
         CEz4MKcqB2akH4600BMlytNemC6KpfZ33ALUx0+guDJ1Mi3r13EBkSR1eYCAzLR4vLW6
         5k1HUIjZywUQ5iTZwCWcARRV4pNq1caXQH1Z1u88Dg/rbv/Zbka2U5D1RwqR3Io1AUGC
         CfJiRiBAVFDvL+akBMKt/EM4x1oAIOFHEABhAVVZBiPpfsZMNL+2AM65JSiPMyuwqe8R
         45ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY87oqTTD0Lxu/Nod5+FQjpzkb9Bg3pO2iG7HQ35E9E=;
        b=f2mEMeEt90iSOfiMps/llyQqlyGCfTxcoudvTTROc31KPqKnbDJxGThWnzoJhpxQse
         IwcZkjhIxBlfFHiyMg2nqXzrzT6/MTCm5wxYbI0M8fqS3u9+CiKoUH4bawZrT1/Zx0rI
         hlxi/fYvrqxQW3kJOcc7ml5E98WKjZ7+c6pNDrQlxUK6tF2ovsKfX4AHmpXAlWh7N1ou
         Yo4xXaXhutAI0H2IGcbSmLfRKX/I56Enf+w3mOLcoouHIkU0c//id46CFwHBGxazL/I0
         HKv4Vk69mP024aPB4RY2dKkrrkULtyrpKOisY7tCj4a4Q2PhqnKvyRqIM0rJ0nFTQxyI
         6olQ==
X-Gm-Message-State: APjAAAX6gRP7JU2wEqeqKx9+w/Fka1wsxHIrSwFNZpqvOxE+JIdvNIIl
        b09t0SLuTiX5Cxh0MiP7qmsa3B4rSThxZj/eggBP4A==
X-Google-Smtp-Source: APXvYqy6jIwHwap88t5Oaa18Ta0HSwKvS14nJn1eTrjidyPzk7gb5fytFaXhj7sVmPkrE39Kdr2drRh47kPrl+2xWxs=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr8401315ljm.180.1561452095250;
 Tue, 25 Jun 2019 01:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190611122535.23583-1-Anson.Huang@nxp.com> <20190611122535.23583-3-Anson.Huang@nxp.com>
In-Reply-To: <20190611122535.23583-3-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 10:41:24 +0200
Message-ID: <CACRpkdZoySkQHc7sbHchR6O0UqxAjp8FS+ubdbXqESGnotDDpA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] arm64: defconfig: Select CONFIG_PINCTRL_IMX8MN by default
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 2:24 PM <Anson.Huang@nxp.com> wrote:

> From: Anson Huang <Anson.Huang@nxp.com>
>
> Enable CONFIG_PINCTRL_IMX8MN by default to support i.MX8MN
> pinctrl driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> Changes since V1:
>         - sort the change in alphabet order.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please merge this through the ARM SoC tree.

Yours,
Linus Walleij
