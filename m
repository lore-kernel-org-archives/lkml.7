Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB5C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB03217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fCTbBab5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfEUSCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:02:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37116 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfEUSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:02:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id r10so17204801otd.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjWxpHH3RznZUOqoTJZzK9OefaWQHmm+6EF8eel7zaI=;
        b=fCTbBab53Rb/T5/XOyrfV9aXwuFPA8aJCgNesV9ZYjTy2R2SeRzgE5zVvjRV2d7NrV
         W96B1ax1cJnk8+D4B5xVKYBn0d22Dpn71HE6Nply3n+bCBt6ul5Go8zGCiHEd0hfsYck
         xDO56q31L4b7WIoKUpkeStjZZGpjL357ji16/Zs9EhetntVCemnO5yK0GMoNuFk3dtCk
         0eZQB8UQm0qOa+CRQiVv9NNP52v0+/a56lCF8i70AHXvRc/d4hv3nFP1U0KCt2dkhU4U
         qOvOluWUwk0SCkNtPknnJDrMchCSzDPAc1EWOLJYky29sKUoZduhzz2xNDWF+NmEbuVN
         YwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjWxpHH3RznZUOqoTJZzK9OefaWQHmm+6EF8eel7zaI=;
        b=A/3DjKXsU8M0wS3GX2OIi/KDUywNIfS1XFgVoA7GyCFKTordIFHT7jelbQVmO39ckM
         X2c2vZWCtLwTYmOKYzgVYpz1ezF0VI8ErOcPqWw1wG2F6dpPXvJebDj9uk0Dxyjfb9e0
         yJchlZ8EFm7ONvtDcyyFLaNg5a9CNsJ14cLkwJoGEPx/Ccn6+N3Pm3K/qD77yx72LMgx
         Lyyu94moZSN5lSdWR8RkDCIuC7JaYBY9P6f1kndreXKY/BKVPUBSHr1Elq/vTsFuZHmB
         KW3Tqtxk6DzIwbnES/VgdnjVQ39sJFadRCsvMZ4icAn0vBvvCrjHZMWgYtt7Vk3L5oV7
         eqNA==
X-Gm-Message-State: APjAAAWM9H3u3tfvT+QSIdNrE3U1P+BNiyGVKG7lmDrpeh5SqPGViVRr
        wsgF+VDQSk5R8+yimDQLSAX8wyWX6AMhh7C2MOsNmD9e2pY=
X-Google-Smtp-Source: APXvYqxIY/HpMv45ibunXIFlX3sF5mN0iADq/vx0dJX2bVB1EzbElUuxq9OuQBIvCivd25vNdd1d39c6pIL8y0lMaGg=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr49623983otb.42.1558461722700;
 Tue, 21 May 2019 11:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190521151952.2779-1-narmstrong@baylibre.com> <20190521151952.2779-4-narmstrong@baylibre.com>
In-Reply-To: <20190521151952.2779-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 21 May 2019 20:01:51 +0200
Message-ID: <CAFBinCDzvroNfzhZHhDdvc+VR1eQNg5JMJ7F9=++hdWKcEXSOw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: meson: Add minimal support for Odroid-N2
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, May 21, 2019 at 5:20 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +       hub_5v: regulator-hub_5v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "HUB_5V";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&vcc_5v>;
> +
> +               gpio = <&gpio GPIOH_5 GPIO_ACTIVE_HIGH>;
I missed this in the review of v1:
according to the schematics GPIOH_5 is routed to GL3523 (soldered down
USB hub) CHIP_EN signal.
The datasheet [0] mentions that this will "Disable whole chip and keep
hub in lowest power state (standby mode)"

do you know if this is a similar case as GPIOH_4 (USB hub reset line,
we configure this using a gpio-hog)?

[...]
> +&ext_mdio {
> +       external_phy: ethernet-phy@0 {
> +               /* Realtek RTL8211F (0x001cc916) */
> +               reg = <0>;
> +               max-speed = <1000>;
> +               eee-broken-1000t;
are we in the same situation that we have on the X96 Max where network
dies without eee-broken-1000t?

[...]
> +&usb2_phy0 {
> +       phy-supply = <&usb_pwr_en>;
is usb_pwr_en really the phy-supply or is it the vbus-supply of the
USB top control block (&usb node)?

if these three questions are answered then you can add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin


[0] https://datasheet.lcsc.com/szlcsc/GL3523-OV3S1_C157363.pdf
