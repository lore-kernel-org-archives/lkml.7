Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25FCC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE69206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S11HT2eU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLRTnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:43:32 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36458 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:43:32 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so2722707iln.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ufzqu5SYStGRmDjFW6F6AuBJEpv9SjyFBEIc9hkxT84=;
        b=S11HT2eUHvh6PNlKlTpHPZHdyyA7ZFbOnQfOmMSkW3r4g+s3386CSdYkBDEjraYC+C
         01//sKB8p7le9qAzIs9k8Q+mey74hWohMpW14NcSlZngQodcuohASzfNofHRG7fxcVsN
         HKcYiNg5dlesgXTkt+vbVXbNfUzHUz1xM3QTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ufzqu5SYStGRmDjFW6F6AuBJEpv9SjyFBEIc9hkxT84=;
        b=FckQPkTt7JqBsjK3ZI4inGN3dM1bg8ohdjmDbD+072mVjrLLoP4qUoFUqe4XIgq+oJ
         XcyxG5xS5/ba8S0VqX3H+UBMPnE2AQKv9n6bzTlwkTpaFzvQf+Fid/znxS981MAGBimI
         P1pjUO3MLmJHTsG+SC8+KUsLOKcrucaEO0nx26F3vFIkXH/ZyPj0jIjK2EPdwkOvAT/x
         eXAjA4MrHr2gplPJXuMR19s4UlhpODlMAoVGp4djXqpenIe5qEwvS3l8wKJPRLdujs6g
         GbUtW6X1YaIbMP/g6EZaE1/IhJzR5vnAXDTO63IjGFP2+B4wgMnoz9Lt0ti0T6rBs0GV
         c0Hg==
X-Gm-Message-State: APjAAAV1gJA4vZISgw9wBJcHa5Ud9x5RxRJe/FtOTGS7VVE1LDNZMGFm
        1lIq77rSqWqOsTH5KZSunKiaRrHztMs=
X-Google-Smtp-Source: APXvYqxSBjoNasx1/lYXHl6jhNxRHkZZD8UsIySSnkMJYTdVWY3HNQE/lV1crzoJFwWtXbm9hEgk2Q==
X-Received: by 2002:a05:6e02:beb:: with SMTP id d11mr3449141ilu.220.1576698210947;
        Wed, 18 Dec 2019 11:43:30 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id g79sm964238ilf.10.2019.12.18.11.43.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:43:30 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id v69so2700478ili.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:43:30 -0800 (PST)
X-Received: by 2002:a92:cc90:: with SMTP id x16mr3541709ilo.269.1576698209663;
 Wed, 18 Dec 2019 11:43:29 -0800 (PST)
MIME-Version: 1.0
References: <1575520881-31458-1-git-send-email-sanm@codeaurora.org> <1575520881-31458-3-git-send-email-sanm@codeaurora.org>
In-Reply-To: <1575520881-31458-3-git-send-email-sanm@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 18 Dec 2019 11:43:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UiPXYMsw=t7Sw7YaEFRxSfgzUXYZA3J1enV8zd+Pa9OA@mail.gmail.com>
Message-ID: <CAD=FV=UiPXYMsw=t7Sw7YaEFRxSfgzUXYZA3J1enV8zd+Pa9OA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: qcom-qusb2: Convert QUSB2 phy
 bindings to yaml
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 4, 2019 at 8:43 PM Sandeep Maheswaram <sanm@codeaurora.org> wrote:
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml

Hrm.  Probably should have given this same comment on the USB3 yaml
bindings too, but I think the file name should be:

qcom,qusb2-phy.yaml

Specifically I think that's what Rob H has been requesting elsewhere.



> new file mode 100644
> index 0000000..3ef94bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom-qusb2-phy.yaml#"

If you change the name to add the comma (as per above), don't forget
to update your ID.


> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm QUSB2 phy controller
> +
> +maintainers:
> +  - Manu Gautam <mgautam@codeaurora.org>
> +
> +description: |

nit: don't need the "|" unless carriage returns are important.


> +  QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8996-qusb2-phy
> +      - qcom,msm8998-qusb2-phy
> +      - qcom,sdm845-qusb2-phy
> +
> +  reg:
> +    description:
> +        offset and length of the PHY register set.

No description, just maxItems: 1 I think.  This seemed to be what Rob
H suggested in USB3 bindings with regards to resets where the
description was just generic [1].


> +  "#phy-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 3
> +    description:
> +        a list of phandles and clock-specifier pairs,
> +        one for each entry in clock-names.
> +
> +  clock-names:
> +    items:
> +      - const: cfg_ahb #phy config clock
> +      - const: ref #19.2 MHz ref clk
> +      - const: iface #phy interface clock (Optional)

Please take the same type of feedback you got for the USB3 bindings
with regards to clocks / clock-names.


> +  vdda-pll-supply:
> +     description:
> +       Phandle to 1.8V regulator supply to PHY refclk pll block.
> +
> +  vdda-phy-dpdm-supply:
> +     description:
> +       Phandle to 3.1V regulator supply to Dp/Dm port signals.
> +
> +  resets:
> +    description:
> +       Phandle to reset to phy block.

No description, just maxItems: 1 I think [1].


> +  nvmem-cells:
> +    description:
> +        Phandle to nvmem cell that contains 'HS Tx trim'
> +        tuning parameter value for qusb2 phy.

Add maxItems: 1 ?


> +  qcom,tcsr-syscon:
> +    description:
> +        Phandle to TCSR syscon register region.
> +    $ref: /schemas/types.yaml#/definitions/cell
> +
> +  qcom,imp-res-offset-value:
> +    description:
> +        It is a 6 bit value that specifies offset to be
> +        added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
> +        tuning parameter that may vary for different boards of same SOC.
> +        This property is applicable to only QUSB2 v2 PHY (sdm845).
> +    $ref: /schemas/types.yaml#/definitions/uint32

minimum: 0
maximum: 63

...and, I think:
default: 0


> +  qcom,hstx-trim-value:
> +    description:
> +        It is a 4 bit value that specifies tuning for HSTX
> +        output current.
> +        Possible range is - 15mA to 24mA (stepsize of 600 uA).
> +        See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +        This property is applicable to only QUSB2 v2 PHY (sdm845).
> +        Default value is 22.2mA for sdm845.
> +    $ref: /schemas/types.yaml#/definitions/uint32

minimum: 0
maximum: 15
default: 3


> +  qcom,preemphasis-level:
> +    description:
> +        It is a 2 bit value that specifies pre-emphasis level.
> +        Possible range is 0 to 15% (stepsize of 5%).
> +        See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +        This property is applicable to only QUSB2 v2 PHY (sdm845).
> +        Default value is 10% for sdm845.
> +    $ref: /schemas/types.yaml#/definitions/uint32

minimum: 0
maximum: 3
default: 2


> +  qcom,preemphasis-width:
> +    description:
> +        It is a 1 bit value that specifies how long the HSTX
> +        pre-emphasis (specified using qcom,preemphasis-level) must be in
> +        effect. Duration could be half-bit of full-bit.
> +        See dt-bindings/phy/phy-qcom-qusb2.h for applicable values.
> +        This property is applicable to only QUSB2 v2 PHY (sdm845).
> +        Default value is full-bit width for sdm845.
> +    $ref: /schemas/types.yaml#/definitions/uint32

minimum: 0
maximum: 1
default: 0


> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - vdda-pll-supply
> +  - vdda-phy-dpdm-supply
> +  - resets
> +
> +
> +examples:
> +  - |

#include <dt-bindings/clock/qcom,gcc-msm8996.h>


> +    hsusb_phy: phy@7411000 {
> +        compatible = "qcom,msm8996-qusb2-phy";
> +        reg = <0x7411000 0x180>;
> +        #phy-cells = <0>;
> +
> +        clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +                <&gcc GCC_RX1_USB2_CLKREF_CLK>,

The comma at the end is a syntax error.

make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml

[1] https://lore.kernel.org/r/20191213212313.GA21092@bogus


-Doug
