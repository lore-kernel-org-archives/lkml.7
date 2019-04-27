Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076FDC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAB42087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pELLvVDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfD0TV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:21:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45882 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:21:56 -0400
Received: by mail-oi1-f193.google.com with SMTP id t189so2483680oih.12;
        Sat, 27 Apr 2019 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dl4sPWHvtIbxgrJc1mG0D08dqZTYwvfuhtEglk0YIMA=;
        b=pELLvVDb25I15N32giJO3bSPLIlU17YzwgNG8xW7mEvBMna4DWw0kKIb7tfcdqo1RZ
         nS5Dq+KKUJN/we0/q6ANQxfab50qpL+BEzkAjoqpxMeI2ThZa3/9xlb7UbTWK8YAkNQE
         o0x7iFnb2bBSjBiLG+J0p5wgoUqqrRn9FppCDdeNik+OHCTCykq+tV7FSTN6Ohy4mDdC
         EOpChY8m0uW8MO+m3kav1AF1RUwL0XxWZQ3Qu6RYxDc7RvAr08A7LwC5A43+iZxtR9jr
         R1KjrDYj5tWSCPkSc2Mbbu7qhHWLG49zNrZG873JxPB+ImKfl5VVB0VHf5Y5dPX18INv
         hL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dl4sPWHvtIbxgrJc1mG0D08dqZTYwvfuhtEglk0YIMA=;
        b=d7Is53uCYyZaWi6fxr/VY4jCY2AuRXo/wBGtToWEbw66569uSDrEAgrerruiZwMuMx
         +kNjdKHi6Tms7C5OwGPD9Q7+IwPFlRF9qsDKvJalel2ZEZV1PnxTUVz2TA0uLrwI7AW8
         kkKiliT7rKWYoxC/UBIUvzML9sX4HkYGI3EKVMSUlTYzyyQNLwiANrDSfgNVvDcbKcYL
         mEWAQBBcoCH50s/gcWD5X9aABLxq8DLi5VhY8GwuNoojwg2t8cRor0aM1elsbAXfHJOV
         D6pRiApbeos9rPnJ1EGtI2arU4jz0gqMT2c3YrLGVWYPDqYlNRVnF0sQQvbivW5nMUwR
         pemQ==
X-Gm-Message-State: APjAAAX4wG7hXpop0dcPcvmT3ayCufWTV3Wy0nAL7u7Y8SjU3UmnHtur
        D8q8/U1t0anKtRya+YfCnSf2hj9T2wkf7kF+dE0=
X-Google-Smtp-Source: APXvYqxGqdLBuMP3LYM+4ZBxOnoJEx2t4P64t25bW6/lCDyU6cVNMOAx/tdVFvfxRdOIgLZhsK6EKG78Kmy47KpoR5k=
X-Received: by 2002:aca:4482:: with SMTP id r124mr11703404oia.39.1556392915645;
 Sat, 27 Apr 2019 12:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190418124758.24022-1-glaroque@baylibre.com> <20190418124758.24022-4-glaroque@baylibre.com>
In-Reply-To: <20190418124758.24022-4-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 21:21:44 +0200
Message-ID: <CAFBinCD_qJw6-_zsnKFhsVHUHd2K2wJ3S9EsXGrPPxZ1SWn=uA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: pinctrl: meson: Add drive-strength-uA property
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Thu, Apr 18, 2019 at 2:48 PM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Add optional drive-strength-uA property
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> index a47dd990a8d3..b3e4be696ddc 100644
> --- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> @@ -51,6 +51,9 @@ Configuration nodes support the generic properties "bias-disable",
>  "bias-pull-up" and "bias-pull-down", described in file
>  pinctrl-bindings.txt
>
> +Optional properties :
> + - drive-strength-uA: Drive strength for the specified pins in uA.
if you have to re-send this series for whatever reason then please
mention that drive-strength-uA is only valid for G12A and newer

otherwise:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
