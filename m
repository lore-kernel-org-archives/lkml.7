Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8457EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C38218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OT1m23Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfCOWB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:01:29 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34866 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCOWB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:01:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so5566032oib.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2k0JAt1vgLko7uklXZDWQMH70edhDufSMEPDx+hW/o=;
        b=OT1m23PxQz8fRBWNfe7XHZRvgfwxDD79V4MjxyhvEiLWQs9SEH53uwKqc0yRfsLg2s
         Cf/yfuz6sSQJV4dVbblzfdbcNqflU36bC9FrgMk0KTxqJ8jPga6WVlpELJyMXPZxefWn
         QPVjfdG/V7j0rPdPb/pa68xNckyRoE4E3hBAxc8In1mwG6Mx9j7LhsOGFfoCQOI1yE7U
         hfw/kUOJy4EemhGXj8cMUN9EseK5zqkEUSemQXGBMSD2LQmyQndr6YbRKVyKs2J/NXBA
         tRxdUFELVB62t4Cax2rZvP29yoy1n50ydWlWnNq46k4k6ZxIgRR6MqW4WMte8tUFompv
         4p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2k0JAt1vgLko7uklXZDWQMH70edhDufSMEPDx+hW/o=;
        b=FSBBevf+IDqigNp/f9jbUb1OgozMXGPUzRnKDtAcRENNDqhgESoYy7T+JXwVWVhOxE
         Y+Yul40l064lGEQbSS2Z4F4N4+/rM23ICIXD1zdmdNyIZEkuZsftZb6A20j6A6JNY6qw
         HWUOvPbpYczZKKhmxApoTnd5PAUQh14rKufzYiko5LYfS/DQQTctjI9GP8lK/5+NYanL
         uQOjNN8wO7HgOT8PFPre3a+yqGtYxi1qA6p079GE/YCpej6eKEkT7x3H5OrS8zvqxG+u
         MzI3zyDVI0vriuCfIOaLpY5hA4qU7rXSnQ8HtfdjyXatrJcsx9LRjPv8UvfMKuymdcV6
         mmLg==
X-Gm-Message-State: APjAAAVYBhZrI8dEVEMPt9l31nqDRjYzaZVZghKpuyS8JZNzmETKK8CH
        Iifm//GDbglqnP1bIBn5Wdgzd8gKoyy3zQbMGzN33YxL
X-Google-Smtp-Source: APXvYqwAEzsOPuiVWkHO6Ot26vdR2n3mHJBCLvC6ctae3FitD75mkQPgBcR3bjvnewx5HEtl5I3p56CZMflw35MakaI=
X-Received: by 2002:a54:4e02:: with SMTP id a2mr3109547oiy.140.1552687287594;
 Fri, 15 Mar 2019 15:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-5-narmstrong@baylibre.com>
In-Reply-To: <20190311095613.11371-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 23:01:16 +0100
Message-ID: <CAFBinCCiV21kB38SXqVYMmQ5YkK2MxXKhiTJrVP3jOCLDtuBBg@mail.gmail.com>
Subject: Re: [PATCH 04/11] arm64: dts: meson-g12a-u200: add regulators
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 11, 2019 at 10:57 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Jerome Brunet <jbrunet@baylibre.com>
>
> Add system regulators for the S905D2 U200 reference design.
I find the hint in the meson-g12a-sei510 regulators patch very good:
  Still missing
  * VDD_EE (0.8V - PWM controlled)
  * VDD_CPU(PWM controlled)
  * VDDQ1_5

VDD_EE and VDD_CPU are *probably* going to be very similar across all
boards (Meson8b uses two slightly different PWM regulators on all
boards supported by mainline, but the basic concept is always the
same)
I'm not sure if VDDQ1_5 is specific to the SEI510 board though.

> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12a-u200.dts      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> index f2afd0bf3e28..17696f356ff2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> @@ -14,13 +14,92 @@
>         aliases {
>                 serial0 = &uart_AO;
>         };
> +
>         chosen {
>                 stdout-path = "serial0:115200n8";
>         };
> +
>         memory@0 {
>                 device_type = "memory";
>                 reg = <0x0 0x0 0x0 0x40000000>;
>         };
there are two unrelated whitespace changes above.
please clean them up if you have to re-send this for whatever reason


Regards
Martin
