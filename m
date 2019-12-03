Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE234C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD55420684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414565;
	bh=K6IMMvz7VrhBT/r4elDKy+T8OufjAAZQT6Bk0nA+v8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Iw2RNapEDT3kcGExystIdlsAIekoFmYfLpX6KQhEAms7EannRXMm0MOvQMGVOXDPD
	 wyQUq+M3OG4jDnnZAzLyTBaLqGvGt85sSOAjOhqVdkUAiVZ3s6HUunKX2FbHJ0KMiU
	 omRP/+jny4NYGybOnIZ9j1WA2bXtSH+axPhWfmZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfLCXJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbfLCXJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:09:22 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA0E520866;
        Tue,  3 Dec 2019 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575414560;
        bh=K6IMMvz7VrhBT/r4elDKy+T8OufjAAZQT6Bk0nA+v8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXbO+PKWt82VvDfa008aPfRPCljM7YrhQqDUK+tbjsJ8YOMRJOaiZNLw2wHoDr7rG
         p17jQRp/hnlEheJZZFeuvn9Fwzggq9tiUsZahKgCfJHAMjPQAXCmAlZQOsG7fBmTZP
         Kvs+fZaygNwtEdjM1kmXmtDdkg+7WWnbFtCPL7xA=
Received: by mail-qv1-f52.google.com with SMTP id q19so2309962qvy.9;
        Tue, 03 Dec 2019 15:09:20 -0800 (PST)
X-Gm-Message-State: APjAAAVe4/Feirmj8jUyJT9OuN32MAUdrnS9SSt4iStSA/fL8J/iwn6E
        3Vx+UHA06N6MEanaEqqLL4r4U9Lkx5ialwCaoA==
X-Google-Smtp-Source: APXvYqxWbn3HAd6F5z+7jJVFqPmGA3wry5wZeoXSEFBoX0HCQMPI5HWXhzetnpmuOaPsqKjXxoFDMW5qwot8ObEg0+w=
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr144958qvo.20.1575414559852;
 Tue, 03 Dec 2019 15:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20191203134910.26470-1-p.paillet@st.com>
In-Reply-To: <20191203134910.26470-1-p.paillet@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Dec 2019 17:09:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOWgB1mC3TwkpzfsAViB2tF9At1z1rtFQZqWEEJ5VnPQ@mail.gmail.com>
Message-ID: <CAL_JsqJOWgB1mC3TwkpzfsAViB2tF9At1z1rtFQZqWEEJ5VnPQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: Convert stm32-pwr regulator to json-schema
To:     Pascal Paillet <p.paillet@st.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 7:49 AM Pascal Paillet <p.paillet@st.com> wrote:
>
> Convert the stm32-pwr regulator binding to DT schema format using
> json-schema.
>
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
>  .../regulator/st,stm32mp1-pwr-reg.txt         | 43 ------------
>  .../regulator/st,stm32mp1-pwr-reg.yaml        | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
> deleted file mode 100644
> index e372dd3f0c8a..000000000000
> --- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -STM32MP1 PWR Regulators
> ------------------------
> -
> -Available Regulators in STM32MP1 PWR block are:
> -  - reg11 for regulator 1V1
> -  - reg18 for regulator 1V8
> -  - usb33 for the swtich USB3V3
> -
> -Required properties:
> -- compatible: Must be "st,stm32mp1,pwr-reg"
> -- list of child nodes that specify the regulator reg11, reg18 or usb33
> -  initialization data for defined regulators. The definition for each of
> -  these nodes is defined using the standard binding for regulators found at
> -  Documentation/devicetree/bindings/regulator/regulator.txt.
> -- vdd-supply: phandle to the parent supply/regulator node for vdd input
> -- vdd_3v3_usbfs-supply: phandle to the parent supply/regulator node for usb33
> -
> -Example:
> -
> -pwr_regulators: pwr@50001000 {
> -       compatible = "st,stm32mp1,pwr-reg";
> -       reg = <0x50001000 0x10>;
> -       vdd-supply = <&vdd>;
> -       vdd_3v3_usbfs-supply = <&vdd_usb>;
> -
> -       reg11: reg11 {
> -               regulator-name = "reg11";
> -               regulator-min-microvolt = <1100000>;
> -               regulator-max-microvolt = <1100000>;
> -       };
> -
> -       reg18: reg18 {
> -               regulator-name = "reg18";
> -               regulator-min-microvolt = <1800000>;
> -               regulator-max-microvolt = <1800000>;
> -       };
> -
> -       usb33: usb33 {
> -               regulator-name = "usb33";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
> new file mode 100644
> index 000000000000..f661728ebdeb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/st,stm32mp1-pwr-reg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32MP1 PWR voltage regulators
> +
> +maintainers:
> +  - Pascal Paillet <p.paillet@st.com>
> +
> +allOf:
> +  - $ref: "regulator.yaml#"

This doesn't belong here as it applied to regulator nodes like you have below.

> +
> +properties:
> +  compatible:
> +    const: st,stm32mp1,pwr-reg
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Input supply phandle(s) for vdd input
> +
> +  vdd_3v3_usbfs-supply:
> +    description: Input supply phandle(s) for vdd_3v3_usbfs input
> +
> +patternProperties:
> +  "^(reg11|reg18|usb33)":

Needs a '$' on the end.

> +    type: object
> +
> +    allOf:
> +      - $ref: "regulator.yaml#"
> +
> +required:
> +   - compatible
> +   - reg

Should be 2 not 3 space indent.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwr@50001000 {
> +      compatible = "st,stm32mp1,pwr-reg";
> +      reg = <0x50001000 0x10>;
> +      vdd-supply = <&vdd>;
> +      vdd_3v3_usbfs-supply = <&vdd_usb>;
> +
> +      reg11 {
> +        regulator-name = "reg11";
> +        regulator-min-microvolt = <1100000>;
> +        regulator-max-microvolt = <1100000>;
> +      };
> +
> +      reg18 {
> +        regulator-name = "reg18";
> +        regulator-min-microvolt = <1800000>;
> +        regulator-max-microvolt = <1800000>;
> +      };
> +
> +      usb33 {
> +        regulator-name = "usb33";
> +        regulator-min-microvolt = <3300000>;
> +        regulator-max-microvolt = <3300000>;
> +      };
> +    };
> +...
> --
> 2.17.1
>
