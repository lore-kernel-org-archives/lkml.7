Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2707AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CFF21872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566907201;
	bh=cojGaPwwiuNAb/W4vwUgL1AZRj1AsasbQrMb/I1e6iI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a6Pnkg/Vzb1lKXbQm4PjNYNxH/NbSS7K6PFpp0tdQlr042OJyLptW1vta7/3X8L2x
	 dFcaLczbHXBjs7rzY+OLjIzFTGQy/NW1X3ehohs2eHoP0iq6tTjIJyKkbWxTswSmGI
	 qcbZLkHqCHaBcmNW/uV/IHGE5HiTVIp1hlqU7CKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfH0MAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfH0L77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:59:59 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE442186A;
        Tue, 27 Aug 2019 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566907198;
        bh=cojGaPwwiuNAb/W4vwUgL1AZRj1AsasbQrMb/I1e6iI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T0pJ99OEmlQBr7pPoQJoDHmOtqwMOKuEXwbmbigauW6MlUwHMiCooYtqwR8OgpAnS
         Z8xNy1gdTVGPI3MkG+btJusN57WfVBUu3E5qOHKl96b73LRExbxcxFew7In4KKhx+o
         T/avNFZxabrlaVvNYxVFrq6mQ0633EAHtFlX4mVU=
Received: by mail-qt1-f179.google.com with SMTP id u34so20990058qte.2;
        Tue, 27 Aug 2019 04:59:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUbfn0lxQhvFUqyCTXuLoaQ7rVrFIsdX3sXKXmSgFS+TpPf3v7v
        CIK7diUqD2Khs8Xh7vsbiVSPxW+dtE9iXi+NFg==
X-Google-Smtp-Source: APXvYqxzLkdUJzCt/zWOg6IuhiGFBaSLvGFnC+KgLNTyvxF+vcnBvHOa0oGv5spSX6RPZ8f6ZyHhXNAQ/NwAtPhzuWs=
X-Received: by 2002:aed:22b3:: with SMTP id p48mr20191755qtc.136.1566907197288;
 Tue, 27 Aug 2019 04:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190822092643.593488-1-lkundrak@v3.sk> <20190822092643.593488-3-lkundrak@v3.sk>
In-Reply-To: <20190822092643.593488-3-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Aug 2019 06:59:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4_h+M=6L-nzK2N+A9TAy-N8SoiFv1SSTk_kCcKt0eXw@mail.gmail.com>
Message-ID: <CAL_JsqJ4_h+M=6L-nzK2N+A9TAy-N8SoiFv1SSTk_kCcKt0eXw@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] dt-bindings: arm: Convert Marvell MMP board/soc
 bindings to json-schema
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 4:27 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Convert Marvell MMP SoC bindings to DT schema format using json-schema.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> ---
> Changes since v1:
> - Added this patch
>
>  .../devicetree/bindings/arm/mrvl/mrvl.txt     | 14 ---------
>  .../devicetree/bindings/arm/mrvl/mrvl.yaml    | 31 +++++++++++++++++++
>  2 files changed, 31 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> deleted file mode 100644
> index 951687528efb0..0000000000000
> --- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -Marvell Platforms Device Tree Bindings
> -----------------------------------------------------
> -
> -PXA168 Aspenite Board
> -Required root node properties:
> -       - compatible = "mrvl,pxa168-aspenite", "mrvl,pxa168";
> -
> -PXA910 DKB Board
> -Required root node properties:
> -       - compatible = "mrvl,pxa910-dkb";
> -
> -MMP2 Brownstone Board
> -Required root node properties:
> -       - compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> new file mode 100644
> index 0000000000000..dc9de506ac6e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mrvl/mrvl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Lubomir Rintel <lkundrak@v3.sk>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: PXA168 Aspenite Board
> +        items:
> +          - enum:
> +              - mrvl,pxa168-aspenite
> +          - const: mrvl,pxa168
> +      - description: PXA910 DKB Board
> +        items:
> +          - enum:
> +              - mrvl,pxa910-dkb

Doesn't match what's in dts file:

arch/arm/boot/dts/pxa910-dkb.dts:       compatible =
"mrvl,pxa910-dkb", "mrvl,pxa910";

> +      - description: MMP2 Brownstone Board

If this entry is only for this board...

> +        items:
> +          - enum:
> +              - mrvl,mmp2-brownstone

...then this can be a 'const' instead. Same for the others.

> +          - const: mrvl,mmp2
> +...
> --
> 2.21.0
>
