Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA0020B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cfdkpelc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfHFMtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:49:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44362 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:49:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id v16so7146539lfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dE5JuDdEA/pQScNByPn3VC+2psga/+uhIp5+6Lpb/IU=;
        b=CfdkpelcPzvwnG1MdqcjcMyI02MUVnNU6luZnIfMDPb2TDvDh/PMhfidkJDiDm5vjw
         TSvW1XIVaisosJn9owSOQNrRfN01cs41uzJMTlM1VsZX0cW6SBzNzVZKo2WGsc7xHA/y
         52dUv8uwgMs+ujW6Xv1T48Zb1XvjfjCWbXCG46cuulJ68eqIsTcpjWkGSqGqJIk/zhKt
         FmDBpMi8Fdr7o1vGrpM/XkRced54b6WwHbfhJBaJgtO7Nxsv4XjRHbsliAGTfPn5nSRH
         4P0r6a4S4hwn0ipXQEhPdnBvxTjgs3aWXnX3Ob+3gbZvc/hC66HkM8kC7oWs5VCWX1de
         wM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dE5JuDdEA/pQScNByPn3VC+2psga/+uhIp5+6Lpb/IU=;
        b=oLpaL9SVe0d5E2YXKa1HBwY/PZq0etBj2u5lYjJLw+3d/h0h1YHZeL/FY6zlvqwhze
         PKtLE+mJ5Bxa+lDcLgC1TT4ZCUYr8MMqlRMSsSCn6oMPQrxOl7kGGmQIIoYWCYlpOiKX
         B2o9DJHL/cjxESqMa82lx4tQeIoWUIlgsbxeNVnH8Alm0d8JITIOQrsAocfpheh93ren
         5r1q5FIJnsLe1ZTarC2DDMAHDAsDVvJd4nKI2wIfs5sg/pNO7rTG7NezQGNpujUkf8HY
         Aam5mOqZTSLTS89B/ePiMjTvSdgsMZjiHDS/EQwIgTtYTokP9GHpo942pv1+7m7m7QJ9
         8PBQ==
X-Gm-Message-State: APjAAAVyfazmCU4gw3vlDsQiEFxw2z22q4TifpjuqmS1rQJf9qElASzI
        WOLc/Y96HoXXzwCO73uG11vjK1JO3Eje+gsgy+lwdA==
X-Google-Smtp-Source: APXvYqw0Wl1Q08gOWskV45KZ1hlu4YydCL1Uqb2v8Dojvc+PSoMPhvxKIqVPTrhNLCBWwALS8FyzMEW+/49Nw/ggfeM=
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr2349039lfq.92.1565095745984;
 Tue, 06 Aug 2019 05:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190806024923.34355-1-hui.song_1@nxp.com>
In-Reply-To: <20190806024923.34355-1-hui.song_1@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Aug 2019 14:48:54 +0200
Message-ID: <CACRpkdZ7hW+hSC41JqjqfLrwWvRY80+_8sXC89OhN7SwVtU7MA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mpc8xxx: Add new platforms GPIO DT node description
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

On Tue, Aug 6, 2019 at 4:59 AM Hui Song <hui.song_1@nxp.com> wrote:

> From: Song Hui <hui.song_1@nxp.com>
>
> Update the NXP GPIO node dt-binding file for QorIQ and
> Layerscape platforms, and add one more example with
> ls1028a GPIO node.
>
> Signed-off-by: Song Hui <hui.song_1@nxp.com>
(...)
> +Example of gpio-controller node for a ls1028a SoC:
> +
> +gpio1: gpio@2300000 {
> +       compatible = "fsl,ls1028a-gpio","fsl,qoriq-gpio";

What you need to do is to add "fsl,ls1028a-gpio" to the list
of compatible values at the top of the file "Required properties".
Please send a v2 with this fixed.

Yours,
Linus Walleij
