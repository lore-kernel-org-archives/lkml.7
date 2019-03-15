Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30147C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA27C21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Wv1vlatb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCOVH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:07:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42009 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfCOVH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:07:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id m4so8467495oim.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWxNjAccAcXWTbaO89TLI40dCP3xjQ327HPneRU/0Jk=;
        b=Wv1vlatbExctWioJq+H7Lewc7enajIjU+MaYu3cQAkXZTKLu8SdyAX3zhbJPWA/slX
         t4yp5wopDXvY5ONZm/ip2MQjBAscqoR68jvPtJ7K7FO/8yQRfxfJW27FhatGi1Pdg/DT
         9DFOPjiSbfJAQLmuF/nol+JorWoPC9CbL/eqHSY3RFFk9UCG3Af7uyWWpXNhPA8PGAag
         YFX00qbeQ8BtdLgQHiI6IXI4pq/xrkbxTc3WeCqQ0yojNir7w/OV0k3qjZ/qb6efLPto
         wdqgKFPSnliaCnORmUVLKbmBsSfEklqxUoQG0cp5vTcEMpE8zNW14kTj4W57KXwJp7Fu
         dpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWxNjAccAcXWTbaO89TLI40dCP3xjQ327HPneRU/0Jk=;
        b=P6piptWC4CXnFqPcrVkO8f8P2FiJSfJ8npJ0Rhv7hSp+I1RipUz3dSRECMjRKeZUN4
         Uf3ZrTh+l3tMQJU3BUwiWRskkJpai6+Gnd0W4OF2bSBItZCjHz6XgX1Iv6SM+0S8MSIV
         utDtYnZgXuCojYORUvK4n3VNLHN1fEJH+sWV999Ag+XlIGxgpyw1Bl0qbTuFhEDReO6B
         Ky+vNIbiePG67VedZzqHO2cn3LQbxO3O9wTfm5j2xEWwrVEpFek+TLfxGguzRgU24ZwQ
         UYSTKOWlUhI0/cFifNW7GysWScJy13yLpCIlFS3DkiqVV/QPZC1fnUtH3Vzk4bW794HH
         H62Q==
X-Gm-Message-State: APjAAAWmTX7lEuGZIq+5m2+vIhWtfIaoMbpZPioeEHxnU9ktZvTZKaB3
        F7//nBTrie4LqGx1lEVxAYrr7/7Z9lY/g9sPefo=
X-Google-Smtp-Source: APXvYqz6eHpbwaTol9R0UvijVk9S8O4jMZmHOSIU8vHKIdr6d5Eq9/tDWmigxSiNH6gGnTC8ebw+lH4Vsg42YFprEFE=
X-Received: by 2002:a54:4e02:: with SMTP id a2mr2981199oiy.140.1552684045898;
 Fri, 15 Mar 2019 14:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-2-narmstrong@baylibre.com>
In-Reply-To: <20190307151342.7381-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:07:14 +0100
Message-ID: <CAFBinCCF81Af=5F19NT337Tfx+oQzx7-zFu2063z7wSfU3qfjQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm64: dts: meson: g12a: Add AO Clock + Reset
 Controller support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Mar 7, 2019 at 4:14 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add nodes and properties for the AO Clocks and Resets.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 191d31db9853..0eb5220da82c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -122,6 +122,23 @@
>                         #size-cells = <2>;
>                         ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
>
> +                       rti: sys-ctrl@0 {
> +                               compatible = "amlogic,meson-gx-ao-sysctrl",
> +                                            "simple-mfd", "syscon";
> +                               reg = <0x0 0x0 0x0 0x1000>;
> +                               #address-cells = <2>;
> +                               #size-cells = <2>;
> +                               ranges = <0x0 0x0 0x0 0x0 0x0 0x1000>;
is this supposed to be 0x1000 (GX uses 0x100 here)?
my understanding is that G12A has the AO CEC at aobus + 0x100, so
using a size of 0x1000 would make it overlap


Regards
Martin
