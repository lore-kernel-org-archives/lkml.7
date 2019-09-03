Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEC121897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BBjwNz6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfICS5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:57:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40538 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:57:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id b80so6769962oii.7;
        Tue, 03 Sep 2019 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgbHG9a6GXDkb4b1cfc7DWlhQhBIRzQTZmisxCwqGGs=;
        b=BBjwNz6/3fHY8rDgOLaY/yvXdKRFVZYsTKXVNmSCdFQ/dNCCQaIxnHsBYJNXuvGDEO
         f9mhEh0pQsmWCi0WPzFVoH9nnjfu8vXvgOVunnuSyq+JSUS3OZxc3vlh3RbLPsn2uj+g
         83AIFfkIq6703Z9yiKBzkU/OMHLJP2prYdP7/hlMO4e6Tu/3Gd3D61uqMkjjpnOVYAUR
         3GCIBZhbJvtnnIbHiGasPrLYVLFIdACc1YzVDcv3Mt0i43nif1+dwPa4yqT5M/WMMTE1
         y1wckMubmHTCC4MKZZg3F79DWmkhh106OP5dJ7uPM2r3INuheTXdCbR9czXpkNQICRnQ
         vvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgbHG9a6GXDkb4b1cfc7DWlhQhBIRzQTZmisxCwqGGs=;
        b=QRL015IFdcSe5OCyMNTRCjPGWlj6+PsuqldB5B6xFkLjF5kJw2Nfm/WavJMX667wi1
         bDq0JCapIDF6mg9fL6B57+sk2Kr+juj8fuVw0ubH9HN7j4znE3kOefs2WTGKop01iLJI
         ol1TqEpo5RduwHnU4ND0MEko6YnYfWUg8nY8r7aYcXmdBiofCeC0MBACZtGFEYpqbQWv
         NVFyVeU38s+HNnXmvgxgH2YSZnM9VMs4c67nyyrp/o5EsCiVqY+izHgeJ/akdNqI6Nyg
         x/lKjGG1rsnmas2pBhbXqPWSn4GnPgd5LOOq79KtTj9C8sjdy0N+6zosDy9nBem8DoyR
         o94g==
X-Gm-Message-State: APjAAAUGcIJXhLtmnuZN0bcf+Hi9/vvzTOIm6kPkHINIoU7VgYhMZQJC
        3VWauPJHdD3STuXHzaweHuhn9aCpHHZtUsTELG4=
X-Google-Smtp-Source: APXvYqwo6lyzOAn9MpdsDInLIzODZQbZKHJLy/aDmR2MVsl116zAO58OI7Yc8xhhDiQfZHa1Jk+N4bjw3Wv9fE7kATU=
X-Received: by 2002:a05:6808:48a:: with SMTP id z10mr574467oid.129.1567537054417;
 Tue, 03 Sep 2019 11:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190902054935.4899-1-linux.amoon@gmail.com> <20190902054935.4899-3-linux.amoon@gmail.com>
In-Reply-To: <20190902054935.4899-3-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Sep 2019 20:57:23 +0200
Message-ID: <CAFBinCCyWn+3unD8Ch-UBRve6jt5FtE9r0dSpKV3izgh1a6URA@mail.gmail.com>
Subject: Re: [PATCHv4-next 2/3] arm64: dts: meson: odroid-c2: Add missing
 linking regulator to usb bus
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 7:50 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add missing linking regulator node to usb bus for power usb devices.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Re-base on linux-next
> Added Ack from Martin.
>
> Changes from previous patch
> [1] https://lore.kernel.org/patchwork/patch/1031243/
> split the changes and add the comments to power source
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 0cb5831d9daf..d4c8b896dd26 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -36,8 +36,15 @@
>                 regulator-min-microvolt = <5000000>;
>                 regulator-max-microvolt = <5000000>;
>
> +               /*
> +                * signal name from schematics: PWREN
> +                */
>                 gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
>                 enable-active-high;
> +               /*
> +                * signal name from sehematics: USB_POWER
nit-pick: should be "schematics"
I hope that Kevin can fix that up when applying
