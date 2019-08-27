Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794D5C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2B12341C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566910181;
	bh=1bu0rXvphKzgZ4qatOKJ9eG5F+ybzMBvmitnLK+n9bE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VZ+erR4MtmIib/ORnFYilb/WdbZquQwoKDeQk1dzTuMCATv4rVx85sO+oGYhiwhz0
	 P0U7wCUm/6wqqV9rnjDcQtJe5jihJp4Np/qwImSBBg4bs4T8adp+HQfeSIEY0S9BrM
	 Sx5h+xakOTyCiakfQFJUFtQUAQ2ppWlPR4fkYlvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfH0Mtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfH0Mtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:49:40 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5E5221883;
        Tue, 27 Aug 2019 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566910178;
        bh=1bu0rXvphKzgZ4qatOKJ9eG5F+ybzMBvmitnLK+n9bE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nMiI24QuRojgqYZFjzzwIerufsNUvx8lI7JtSsQrBGkzztzu8P404G7TV1IHMoZk+
         vQfnvRb4wxvnJKIMg5DbuI6ucEU4dv9rcqPZwnZcsZKtG+Wx9a+eJwpkwpPMAp2CvZ
         4hshX5L3VpG0PvKWTpQELJ4FEJwosdFD4eRw5ptk=
Received: by mail-qk1-f172.google.com with SMTP id g17so16799841qkk.8;
        Tue, 27 Aug 2019 05:49:38 -0700 (PDT)
X-Gm-Message-State: APjAAAWM3xZAjeFpYi7rVDsZxiGl9AObWpGl5DjguYIacGmE+AgXNAsg
        RJZ+WERR3RIQ/tAIOukFh3dmnHUJiYJcn3VbyQ==
X-Google-Smtp-Source: APXvYqyc8cAqLr+5lWC4OcOsH4WwQCDZJCiD70mt/JKEw8mkjMvEJFueWACXOw3on7KMnzXDUY9z834YBM0JJ8P4vV0=
X-Received: by 2002:a37:682:: with SMTP id 124mr1666838qkg.393.1566910177817;
 Tue, 27 Aug 2019 05:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190827085302.5197-1-jiaxun.yang@flygoat.com> <20190827085302.5197-8-jiaxun.yang@flygoat.com>
In-Reply-To: <20190827085302.5197-8-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Aug 2019 07:49:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzkKDVm_DBpp4_w5YZQkg0yo9TJtvxzN5beTf45gtohw@mail.gmail.com>
Message-ID: <CAL_JsqJzkKDVm_DBpp4_w5YZQkg0yo9TJtvxzN5beTf45gtohw@mail.gmail.com>
Subject: Re: [PATCH 07/13] dt-bindings: interrupt-controller: Add Loongson-3 HTINTC
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.co>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 3:59 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Document Loongson-3 HyperTransport Interrupt controller.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../loongson,ls3-htintc.yaml                  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml
> new file mode 100644
> index 000000000000..c1bc0faca656
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-htintc.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt-controller/loongson,ls3-htintc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Loongson-3 HyperTransport Interrupt Controller
> +
> +maintainers:
> +  - Jiaxun Yang <jiaxun.yang@flygoat.com>
> +
> +description: |
> +  This interrupt controller is found in the Loongson-3 family of chips to transfer
> +  interrupts from PCH connected on HyperTransport bus.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - loongson,ls3-htintc

Can be simplified to:

compatible
  const: loongson,ls3-htintc

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 4

Need to list out what each of the 4 are.

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +examples:
> +  - |
> +               htintc: interrupt-controller@0xEFDFB000080 {

interrupt-controller@efdfb000080

> +                       compatible = "loongson,ls3-htintc";
> +                       reg = <0xEFD 0xFB000080 0x100>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +
> +                       interrupt-parent = <&iointc>;
> +                       interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
> +                                               <25 IRQ_TYPE_LEVEL_HIGH>,
> +                                               <26 IRQ_TYPE_LEVEL_HIGH>,
> +                                               <27 IRQ_TYPE_LEVEL_HIGH>;

Run 'make dt_binding_check'. This will not build without the necessary include.

> +    };
> --
> 2.22.0
>
