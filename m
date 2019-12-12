Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555AEC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BA4214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yd5bVEFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfLLJ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:57:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36226 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfLLJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:57:35 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so1779655wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=gx1Mdi7/CFmOT7RiIEVg3kQRBdQoHiJa4CnAd9qCJmg=;
        b=yd5bVEFtgIODavE5Wy5kl2EwUKPgntf/ynutV1/iuGWUD7bN9CmysWNJgtp9Bs3vVf
         bLKRuIOtbxscxmKQ5AoUrdctD3vjekNCRBG20Z+21i36dxmQjJB/kqpJqM4j1IXiVrHV
         zdgK0zjx2IJXCdHzkWC4Srs79kGXf7TVq6kSzAU1yPNnVlB/hdCu/RuOOAYwqI0jFs9J
         uyHCMuKtD3XZ6Ymbz+aL/YawKQkgEXAmQybExIjwVLXb0+TmAuwCLWKsOCNi/1ON8PGZ
         cQP6rBl5ZNcF8PU0F29ZGw+9Ze1ZBnASA1cVQ4X37+jSlUKGtkv9rT0Lv/9/tf9PjGuv
         j0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=gx1Mdi7/CFmOT7RiIEVg3kQRBdQoHiJa4CnAd9qCJmg=;
        b=SaH5YqUYRMUx24jojbU5OZQXhvgmeeO2wZdJA5nnMoY2RzYFd1TgIbTIAaaiyOP8Qt
         8iYl82WnYaswOwAbNpZZv73Hrnoab3f/fySxckEE++fUFRpCVGZW64PJLhueDt6o/jnr
         Lpd6roUtjNNUXEFHxJM6EtvLMOZnNP6K5LEBr6JY2i4BtjxXouGIOvXGLtXUonmYCdTE
         SnQgn5D/u2ij2tsM/rmPN0Frf3GluVEQ95hpnWhBXconLWH6x+JdrVUBEbkcLVdToJZ+
         gbxPyf/mrTSo3puAMbN27yA4Az9Dt0Aev2+mcJZPV5vblwPysEsaCJr0t5F/UoUCMh1P
         ydig==
X-Gm-Message-State: APjAAAX8qLksJw3cVFdjsandOfbZjaZ4D0ZDkpp63yXOEecrYRwKtDE0
        4l9k9fhwKLPXDMb47DfwEiHy5Q==
X-Google-Smtp-Source: APXvYqwk4QDlI0ODXXgdLTi/EXbqG6DwiTR8OW5NiylFbyhT0VLdogLil3eQ5czc90Dbh6YAj+YurA==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr5740102wmb.137.1576144653403;
        Thu, 12 Dec 2019 01:57:33 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k19sm5248320wmi.42.2019.12.12.01.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 01:57:32 -0800 (PST)
References: <20191206074052.15557-1-jian.hu@amlogic.com> <20191206074052.15557-2-jian.hu@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "Rob Herring" <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: clock: meson: add A1 PLL clock controller bindings
In-reply-to: <20191206074052.15557-2-jian.hu@amlogic.com>
Date:   Thu, 12 Dec 2019 10:57:31 +0100
Message-ID: <1jblsdlvck.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 06 Dec 2019 at 08:40, Jian Hu <jian.hu@amlogic.com> wrote:

> Add the documentation to support Amlogic A1 PLL clock driver,
> and add A1 PLL clock controller bindings.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 59 +++++++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 +++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> new file mode 100644
> index 000000000000..7feeef5abf1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */

Rob commented on the above in v1 and it remains unaddressed

> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +
> +properties:
> +  compatible:
> +    - enum:
> +        - amlogic,a1-pll-clkc
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +clocks:
> +  minItems: 2
> +  maxItems: 2
> +  items:
> +   - description: Input xtal_fixpll
> +   - description: Input xtal_hifipll
> +
> +clock-names:
> +  minItems: 2
> +  maxItems: 2
> +  items:
> +     - const: xtal_fixpll
> +     - const: xtal_hifipll
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clkc_pll: pll-clock-controller@7c80 {
> +                compatible = "amlogic,a1-pll-clkc";
> +                reg = <0 0x7c80 0 0x18c>;
> +                #clock-cells = <1>;
> +                clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
> +                         <&clkc_periphs CLKID_XTAL_HIFIPLL>;
> +                clock-names = "xtal_fixpll", "xtal_hifipll";
> +    };
> diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h
> new file mode 100644
> index 000000000000..58eae237e503
> --- /dev/null
> +++ b/include/dt-bindings/clock/a1-pll-clkc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __A1_PLL_CLKC_H
> +#define __A1_PLL_CLKC_H
> +
> +#define CLKID_FIXED_PLL				1
> +#define CLKID_FCLK_DIV2				6
> +#define CLKID_FCLK_DIV3				7
> +#define CLKID_FCLK_DIV5				8
> +#define CLKID_FCLK_DIV7				9
> +#define CLKID_HIFI_PLL				10
> +
> +#endif /* __A1_PLL_CLKC_H */

