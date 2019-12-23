Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5364EC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7C0206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577129891;
	bh=Dih/wOurVTvIq8c1XErUHJTObmDBQEui58gJp3SRloM=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=OvgTKG0bpQ8xca2bbu9mbQm8rlzODOItVEIKc/h1iJ2yrAz67NeYGQQJB80YJNAxN
	 P+9DImZR1uggsotMW3wayQ1dm9p72aHH81XpRJ2QZPu6LYyjUvGCaLiJz9dVseACTk
	 A3B0y3yU5y5/nlcx/RQQ3Yj1RHCqPCEOuC8eFHQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLWTiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWTiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:38:09 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 518DD206CB;
        Mon, 23 Dec 2019 19:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577129889;
        bh=Dih/wOurVTvIq8c1XErUHJTObmDBQEui58gJp3SRloM=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=VpJQ1DX6mclIWUzMvp5eMrYTvEbIE4X0oZMhvCOHX9ufMvaVWxAb5Tu/tYJdTe6bE
         Emwxky6snUkBGEGADIALj6teuEObdD4hxaIL9gNl3h/nVb4iZGdNfXJVH0FKJ5NIf6
         U1Xw5kOGAnyjc71UVfpwPuDZ0hwGudbq5yFUG5j8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <706ef9c0e08e10798a4cecacff52a4c72e8fe693.1576811332.git.rahul.tanwar@linux.intel.com>
References: <cover.1576811332.git.rahul.tanwar@linux.intel.com> <706ef9c0e08e10798a4cecacff52a4c72e8fe693.1576811332.git.rahul.tanwar@linux.intel.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        yixin.zhu@linux.intel.com, qi-ming.wu@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: clk: intel: Add bindings document & header file for CGU
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 11:38:08 -0800
Message-Id: <20191223193809.518DD206CB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2019-12-19 19:31:08)
> diff --git a/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml b=
/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
> new file mode 100644
> index 000000000000..2c9edabe0490
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,cgu-lgm.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/intel,cgu-lgm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain SoC's Clock Controller(CGU) Binding
> +
> +maintainers:
> +  - Rahul Tanwar <rahul.tanwar@linux.intel.com>
> +
> +description: |
> +  Lightning Mountain(LGM) SoC's Clock Generation Unit(CGU) driver provid=
es
> +  all means to access the CGU hardware module in order to generate a ser=
ies
> +  of clocks for the whole system and individual peripherals.
> +
> +  This binding uses the common clock bindings
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt

I don't know if this second paragraph is very useful.

> +
> +properties:
> +  compatible:
> +    const: intel,cgu-lgm
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +examples:
> +  - |
> +    cgu: cgu@e0200000 {

Node name should be 'clock-controller'

> +        compatible =3D "intel,cgu-lgm";
> +        reg =3D <0xe0200000 0x33c>;
> +        #clock-cells =3D <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/intel,lgm-clk.h b/include/dt-bindi=
ngs/clock/intel,lgm-clk.h
> new file mode 100644
> index 000000000000..09e5dc59ff5b
> --- /dev/null
> +++ b/include/dt-bindings/clock/intel,lgm-clk.h
> @@ -0,0 +1,150 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Can this be more than just GPL? Maybe GPL or BSD?

[...]
> +
> +#define CLK_NR_CLKS            180

Can this be removed from the binding file? It's too generic of a name
regardless and it doesn't describe something that is actually part of
the binding.

