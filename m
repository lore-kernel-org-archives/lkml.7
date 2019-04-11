Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE66C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF3D2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TvaDwhxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDKViz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:38:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36821 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDKViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:38:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so6261946oia.3;
        Thu, 11 Apr 2019 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/Eaat6mJaApPXTKW9fxNSQtMRxRCGIGBY0z0WTwZsY=;
        b=TvaDwhxfg26dt8H/AyPFMVm1oubn9ub7EVmMtB+QXJr+GfKype/hsuV1znFc5ueAUg
         XNSe5y9xoMLQ21nUKsuVikIHiMtsr+ZA1aoNrhWiAILFzu0LT6UGrb/jIVQfFa65SpYU
         R1OI79488ZvcxCSU0wYM4tA8tLETlnz6zhLMWghea0PWRlBx/SzlO/8TjNFXqKAaMhDK
         by7GY5b9rNGKSqal9xQk98TnVcSMUWdCTyQ2nMSOw+Y6szke6WlY/ZWWD3TFDvgg+TEf
         zA1aXbnfvOBaMHltAHsjvzs68MNyQLyYTztaRv4G7gesBJ71JXtet+ex5ahay4550GQ4
         2UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/Eaat6mJaApPXTKW9fxNSQtMRxRCGIGBY0z0WTwZsY=;
        b=LJuoyVt+hB6+Km7ljcrV4QH8nnYZ3ym94CBX6Re2hvDIFzbvyOTKmWSNQsxtcPZtxT
         kvpiVNoPtPd3uzZOhoEvPbt/rBoQqdtowlZzqIHma+gdQxuEZKntRBb7FVTcLsit6NMD
         qQ9cVsJ/nCoqj78gCNS7N/WtgJWttymyZnJ5a/HkNVbIs3cR0yJFQGDOEWNs+ROfO2HM
         Uewgmlg6ykP6lb3lAEFcK2nWZM/3e1k71WKQvObuo4E0Kyy6hZKeYaGmJBggysebCkf6
         GQeVTm6yTKihtpTdpPMPJ/mrST0VPMiLh1cgjOl1WuPq5HFP2gkKGAqba6w+kk3bx6+q
         1K9A==
X-Gm-Message-State: APjAAAU0vFJJj8wxVgK1+tzI9HsWnOgBP48RXPp4mQno/tNK11MPKZoC
        xRRxJzgIP4B4O/8sCyryBwZdt3Vq3wUZZjOhccE=
X-Google-Smtp-Source: APXvYqxpFjlc5TAR58LDBDGCS9RlzmCK78XSQeYEC3Z/MRTErq4S19jysbPYG23FDxcOpZ+8xZAKbsLGBGqwTHnXxxU=
X-Received: by 2002:aca:4482:: with SMTP id r124mr8219082oia.39.1555018734440;
 Thu, 11 Apr 2019 14:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190411084537.30299-1-glaroque@baylibre.com> <20190411084537.30299-3-glaroque@baylibre.com>
In-Reply-To: <20190411084537.30299-3-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 11 Apr 2019 23:38:43 +0200
Message-ID: <CAFBinCBVmPa5hi83B1ZTe-guassHxKQFrN5QOyMJc9s95LJ1cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: meson-g12a: Add Temperature Sensor clock
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Thu, Apr 11, 2019 at 10:46 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Add TS clock used by two temperature sensor
thank you for working on this!

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/clk/meson/g12a.c | 31 +++++++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h |  3 ++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 3a3134976534..e6d2af6ee8ea 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -2335,6 +2335,33 @@ static struct clk_regmap g12a_mali = {
>         },
>  };
>
> +static struct clk_regmap g12a_ts_div = {
> +       .data = &(struct clk_regmap_div_data){
> +               .offset = HHI_TS_CLK_CNTL,
> +               .shift = 0,
> +               .width = 7,
buildroot_openlinux_kernel_4.9_fbdev_20180706 uses ".width = 8".
That matches with the public S922X datasheet from hardkernel which
states that HHI_TS_CLK_CNTL[7:0] is "ts_clk clk_div"


Martin
