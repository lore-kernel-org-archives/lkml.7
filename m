Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAF3208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="t55CWEr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfEGSJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:09:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34704 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:09:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id l17so6323593otq.1;
        Tue, 07 May 2019 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BwTINmche9opIL7zBMQCWsHXeqw7MIVdob3Aj0xWt0=;
        b=t55CWEr4h6A7mXHO1OW3wPHGDHGzFqHvqr5sHDoAUiOUiSX+ahQ5fAC8TI8UfMPI7I
         pzT2ccK7qShUInrcOamnCaoAYy/T0/W16dOR/+y8M6v9WTYe9TSstQzhmGVLclfTqCtS
         y5gkDnHVg9zi/a8t+MdCiDPrCnLg9xYz64p9GxplUFOeib6yZytHYAz5TCO4xkMb4ww3
         xOmvXR0vILSsj2ybPGtll/F0vR8XjLUqZi7uHlitQSy58sigey0kW8bmrRh/uW0VenQv
         KlzpuUD5QuLSfBXnKwe7Cz3dRVMKfdIvHCdYh+spHjB6+czHiISxZIt/CMQP3d+iy+b8
         Gagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BwTINmche9opIL7zBMQCWsHXeqw7MIVdob3Aj0xWt0=;
        b=gGigWsklJxLMOcV+GMyjTnjHPWW4957RpnfaWtsegdfmFmIDJQUZE5YYxmxRm7bH7c
         sXsfF9KP21LNKaNc23A/CWN2blRxH4EcWdnB2kRnv7TI0+E4Mw3qGQbkCMn7q4QykX4T
         rdcsdB/ucsvJ51uZyDT12gbtGsCzo3udnsElNEE5B4lghdEmIEJx9x4v8OTMo1flCC1U
         tJzKPCf6ENnKT7FkIX/Ot6NzVhpkT4+3+gSvtY7cBnzv4T3qea0AKssh8/xVMjFv/UTF
         f9hXMPHfICDYYBIiizOTjjZQ+ZJotV8pY55DPDJN9vkLo21IpL+t/d6T0cfjDc0vYss8
         xA2Q==
X-Gm-Message-State: APjAAAVgvDJ3k+zaNqij6Rt4WIbm4O4LZ89zt2J0jwRSc46Ohn3q2nTM
        0EYhs1t4eTaZN/JRYC3Il6TTPY20CTZY3iyXDhg=
X-Google-Smtp-Source: APXvYqzELThOf7KH9K8tpNNay5dDVj9jJZ6jAC1S8J91wpjoKFub/ufgDELBpw8Sh342/HXwunD2TiuIwbnflCFwBDU=
X-Received: by 2002:a9d:4e97:: with SMTP id v23mr22116360otk.148.1557252595581;
 Tue, 07 May 2019 11:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190507115726.23714-1-glaroque@baylibre.com> <20190507115726.23714-7-glaroque@baylibre.com>
In-Reply-To: <20190507115726.23714-7-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 7 May 2019 20:09:44 +0200
Message-ID: <CAFBinCB6beHBKLcmXa-gwiyUrAD1z4tD92RDs9Rnjp=hArKbHw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] pinctrl: meson: g12a: add DS bank value
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

On Tue, May 7, 2019 at 1:57 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> add drive-strength bank register and bit value for G12A SoC
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +       /* name  first  last  irq  pullen  pull  dir  out  in  ds */
> +       BANK_DS("Z",    GPIOZ_0,    GPIOZ_15, 12, 27,
> +               4,  0,  4,  0,  12,  0,  13, 0,  14, 0, 5, 0),
> +       BANK_DS("H",    GPIOH_0,    GPIOH_8, 28, 36,
> +               3,  0,  3,  0,  9,  0,  10,  0,  11,  0, 4, 0),
a note for myself (because I keep forgetting this)
"5, 0" stands for:
- the register PAD_DS_REG5A as seen in the public S922X datasheet from
Hardkernel on page 224
- starting at bit 0
