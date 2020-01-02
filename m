Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A0C32764
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1FC21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="XwQN52HF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgABCGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:06:02 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42529 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgABCGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 21:06:02 -0500
Received: by mail-io1-f66.google.com with SMTP id n11so30320554iom.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 18:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHVPj5/UF7FmXw5E/6Coz8EOtDK8UfYd1n1yDId2PbU=;
        b=XwQN52HFHiN4fB5kwYTv9zn1C76bI0Iz71wHNgvVewPn60QLGI/53rhJcn0f8qP7wG
         sYdC1zIp6TQZ1YvNlqMDGXJ9S/iB8GP3sVWi03ibUV1M0gGPnF9lkzJYdq5Sihm1aCxD
         JQsB5mHL8hEMMmYlnX96DExdAaIOIfSU1FKTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHVPj5/UF7FmXw5E/6Coz8EOtDK8UfYd1n1yDId2PbU=;
        b=n3fanbWdA4Xs3oTxBeFtJp6wcBpe31HsUgmW3gBUkkdN9ovC3Ku/X7zUdIEzznAy4p
         62lAJYZteswIRu6XR+/c3I+hzRrqIkX4IPqpGl/4c8g7jfb5WBA9j54yO43gFFPMlKSP
         1uRGg9R3WNH+r35zym0V8iFNLWyF0GsSf46b+QaKKDv+EeGVE9nBWpMuLbQb0DlbNKE1
         GhnyWR67qVwoJk9Vx7IVIBKzCALFNJVMUlw8KyoMn97Dzvp9joBLpm30GNiAmtSdcrqQ
         A/1j7VTrKfcAAEHksRenN2IKiSN1O4sssL5UbUIiXfGqGnIuXwxh1NUi/9t44n3lijGH
         giTg==
X-Gm-Message-State: APjAAAWni/FlJ9SDC+/42JJmHFbCTw9LgoN4Wd/vOX6LPQxeXpf1Jogh
        IgTL3PjNgMOiDc+joaQ+DtvnUWsYmrKuTdZvDwhTrg==
X-Google-Smtp-Source: APXvYqwGWLjQw3gcajosmfzURd5ps+qyn12aquFWSg8sHauYhmdDjIpsc9fULZuWJKPuLIwEScJP+9CPNw9R1+t3PaY=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr64525970jad.136.1577930761321;
 Wed, 01 Jan 2020 18:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20191217102930.26102-1-mtwget@gmail.com>
In-Reply-To: <20191217102930.26102-1-mtwget@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 2 Jan 2020 10:05:49 +0800
Message-ID: <CAJCx=gnyF69PxHVh38nP1AYwi=Tt4J9bYYR-w00uGODUfCrKyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for
 Dynament Premier series single gas sensor
To:     YuDong Zhang <mtwget@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:29 PM YuDong Zhang <mtwget@gmail.com> wrote:
>
> Dynament Premier series single gas sensor.
>
> Signed-off-by: YuDong Zhang <mtwget@gmail.com>
> ---
>  .../iio/chemical/dynament,premier.yaml        | 39 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  1 +
>  3 files changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> new file mode 100644
> index 000000000000..e2bbae4dd086
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/dynament,premier.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynament Premier series single gas sensor
> +
> +maintainers:
> +  - YuDong Zhang <mtwget@gmail.com>
> +
> +description: |
> +  single gas sensor capable of measuring gas concentration of dust
> +  particles, multi-gas sensor are not supported.
> +
> +  Specifications about the sensor can be found at:
> +    https://www.dynament.com/_webedit/uploaded-files/All%20Files/SIL%20Data/tds0045_1.44.pdf, read chapter 1.5.2 Read live data simple

Typo of sample?

- Matt

> +
> +properties:
> +  compatible:
> +    enum:
> +      - dynament,premier
> +
> +  vcc-supply:
> +    description: regulator that provides power to the sensor
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    serial {
> +      single-gas-sensor {
> +        compatible = "dynament,premier";
> +        vcc-supply = <&reg_vcc5v0>;
> +      };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 6046f4555852..5afca0586c41 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -261,6 +261,8 @@ patternProperties:
>      description: Dragino Technology Co., Limited
>    "^dserve,.*":
>      description: dServe Technology B.V.
> +  "^dynament,.*":
> +    description: Dynament, Ltd.
>    "^ea,.*":
>      description: Embedded Artists AB
>    "^ebs-systart,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae228ac7adc9..4842a0afe32b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5796,6 +5796,7 @@ DYNAMENT PREMIER SERIES SINGLE GAS SENSOR DRIVER
>  M:     YuDong Zhang <mtwget@gmail.com>
>  S:     Maintained
>  F:     drivers/iio/chemical/premier.c
> +F:     Documentation/devicetree/bindings/iio/chemical/dynament,premier.yaml
>
>  DYNAMIC DEBUG
>  M:     Jason Baron <jbaron@akamai.com>
> --
> 2.24.1
>
