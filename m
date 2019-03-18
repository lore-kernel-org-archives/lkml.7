Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E1920828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GB+HQzVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCRURv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:17:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38921 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfCRURu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:17:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id b4so14154677oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kviz/ZAppsOp97wiwa/3qIYHbJwscWwNP5RnfHRpeDo=;
        b=GB+HQzVsQOcWCvFIEFBse7gdQqKCla07o2s0SjRyREYw1B6tK6JGIzP0iHN/x+hC01
         /8GBoaImw+xXSwQrAU1yogcGoNxVvX9iryi5QiC9PfpV8BglnX3zpJEJry+poPSCxIan
         xRHIqBgwCdVQndsO9PbkY890c0cj6LzaUphqcD+0HrirUuHlK2UJyUCdC+CDE0Zz5fXl
         jhKXi2xkmOnSyPusQgf9AkvyuLfDS+Ue8ocDnar0cx7h5wjjLdzSrnrTC32W0j91qIvR
         3fav52QCeZLTrlFQRoAkq2NKjZtwVZjelF7+XQg1ZoQuh35TXUa5fR7kExwf+t9ACf2/
         OTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kviz/ZAppsOp97wiwa/3qIYHbJwscWwNP5RnfHRpeDo=;
        b=BRzFUc4nKsr1bmU98wBt2dC5OXbf+bfiErbrwcggXVWnRpTpP0pWzO2g33EYX3tBv+
         b9GC52gQxRxFWUGR1jXlRv2Pr/LLU8KSi1viBAN6I51GueXTKWeqRyXGnW268Bjj7IiP
         LcnJfhcuz98RP1GUss7HJB/7DovOhQHtVk6ReR0Q4+SXPRm+f08MWi3eCPJhXv8Lgs+V
         6JicavYGcUNV81UcRork5HbqzkrnHroHMeN7+L48KMez+5n9vMA5WktWACYm5w64Mgrf
         ObL2cKITT/MipXsaVp2wFy2k7LMKhyXwArHb+UNqvNq4Mzli8fP5khUpEF6R4WfQnJ5M
         or3g==
X-Gm-Message-State: APjAAAWNIbAtKsAbDIShAmTK/bduSvfygLqTs3jaUwsT4aya+eGUi8UV
        gTH/xYpkyixjVmqgWFjQDGuA7ObKFK/SBTbvCBDnQdBJ
X-Google-Smtp-Source: APXvYqwSISyeOH9Uc2VL1oxQaZFMCjd/XksthHTsvNaRR2/rhIYFljgtzS21QekWn9ai9rIdNFhhM5uY12aU9ARtbtI=
X-Received: by 2002:aca:6209:: with SMTP id w9mr460277oib.47.1552940269900;
 Mon, 18 Mar 2019 13:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100458.5619-1-narmstrong@baylibre.com> <20190318100458.5619-9-narmstrong@baylibre.com>
In-Reply-To: <20190318100458.5619-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 21:17:39 +0100
Message-ID: <CAFBinCCWMpyaJ1WjxGkxAr-ROc6MjWVyzt+LUrcAhjTY99dVKw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] arm64: dts: meson-g12a-sei510: Add ADC Key and
 BT support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add support for the :
> - ADC Touch key
> - Bluetooth Module on UART A
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I have no details about this board but the changes look sane, so
(apart from one nit-pick below):
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  .../boot/dts/amlogic/meson-g12a-sei510.dts    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> index 43d57e20294a..ebdad5a192f1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> @@ -7,6 +7,7 @@
>
>  #include "meson-g12a.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>
>  / {
> @@ -17,6 +18,19 @@
>                 serial0 = &uart_AO;
>         };
>
> +       adc_keys {
in meson-gxm-khadas-vim2.dts we use "adc-keys". Other Allwinner and
Rockchip board also use "adc-keys" instead of "adc_keys".
I prefer if we go with "adc-keys" (we can clean up the two occurrences
of "adc_keys" in arch/arm64/boot/dts/amlogic later)


Regards
Martin
