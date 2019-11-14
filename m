Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6534AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3630420718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573751928;
	bh=ocz46gTCP/NUGPTiVuVJqGTutFbDRHy1wr+ZIMUnIJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HceOg4tTVs+Bq4WCXpC0sOwpq1OtjV2J7ECuD4gqBXcIGV6P+6o8/jHZJAsUf/bAg
	 AIQeZ3toabhhUoGp/ED1y93sbWuZv5/wo/2zOFIFFl6LJa97OwPwgyEfaff27DUUW/
	 zofZfy/a0PFqEKlaCMYDakqMl4Y5x0hSdizG7TPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKNRSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKNRSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:18:46 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 412EE20718;
        Thu, 14 Nov 2019 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573751925;
        bh=ocz46gTCP/NUGPTiVuVJqGTutFbDRHy1wr+ZIMUnIJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FEltqMdfOa5s52eVq2HDJrCWY63pFr+eHadBHw1DVPLEAbhcAhRYFLbOR4NBVLJOA
         U6JM/AfIJ9xq46+VbVjsuRKMHAsC4jkyCbI2duqLtUcj+iTIWEqphmPj10YvKLY7qM
         j6fMRfMgAtoWRJIXpIcU0JimN8FIb592KhgMDKjw=
Received: by mail-qk1-f182.google.com with SMTP id d13so5661723qko.3;
        Thu, 14 Nov 2019 09:18:45 -0800 (PST)
X-Gm-Message-State: APjAAAWdC8qFFuwkIRTJ/3bH8kilPSOOjgvDbg1sn38dc9p+GV92lZQ0
        crobV7F/XE5QZIs+OfFbtSZIxh0G36NfF5BJGQ==
X-Google-Smtp-Source: APXvYqydolbw7U1IFwsmCdguELeny4+5hB8lSGa1lqgOoHuaINM81p54+J/thh41N+0dOQJlAExq8K8modx+6jO6l6Y=
X-Received: by 2002:a37:30b:: with SMTP id 11mr8607360qkd.254.1573751924338;
 Thu, 14 Nov 2019 09:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20191114164104.22782-1-alexandre.torgue@st.com>
In-Reply-To: <20191114164104.22782-1-alexandre.torgue@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Nov 2019 11:18:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJZwJ0MyRp37Y-F0ujPdVEKARd8qcUCN1xmawpkiffLg@mail.gmail.com>
Message-ID: <CAL_JsqKJZwJ0MyRp37Y-F0ujPdVEKARd8qcUCN1xmawpkiffLg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert stm32-exti to json-schema
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:41 AM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Convert the STM32 external interrupt controller (EXTI) binding to DT
> schema format using json-schema.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> ---
>
> Hi Rob,
>
> I planned to use "additionalProperties: false" for this schema but as I add a
> property under condition, I got an error (property added under contion seems
> to be detected as an "additional" property and then error is raised).
>
> Is there a way to fix that ?

See below.

>
> regards
> Alex
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> deleted file mode 100644
> index cd01b2292ec6..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -STM32 External Interrupt Controller
> -
> -Required properties:
> -
> -- compatible: Should be:
> -    "st,stm32-exti"
> -    "st,stm32h7-exti"
> -    "st,stm32mp1-exti"
> -- reg: Specifies base physical address and size of the registers
> -- interrupt-controller: Indentifies the node as an interrupt controller
> -- #interrupt-cells: Specifies the number of cells to encode an interrupt
> -  specifier, shall be 2
> -- interrupts: interrupts references to primary interrupt controller
> -  (only needed for exti controller with multiple exti under
> -  same parent interrupt: st,stm32-exti and st,stm32h7-exti)
> -
> -Optional properties:
> -
> -- hwlocks: reference to a phandle of a hardware spinlock provider node.
> -
> -Example:
> -
> -exti: interrupt-controller@40013c00 {
> -       compatible = "st,stm32-exti";
> -       interrupt-controller;
> -       #interrupt-cells = <2>;
> -       reg = <0x40013C00 0x400>;
> -       interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
> -};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
> new file mode 100644
> index 000000000000..39be37e1e532
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0

If ST has copyright on the old binding, can you add BSD here.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/st,stm32-exti.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32 External Interrupt Controller Device Tree Bindings
> +
> +maintainers:
> +  - Alexandre Torgue <alexandre.torgue@st.com>
> +  - Ludovic Barre <ludovic.barre@st.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - st,stm32-exti
> +          - st,stm32h7-exti
> +      - items:
> +        - enum:
> +          - st,stm32mp1-exti
> +        - const: syscon
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  hwlocks:
> +    maxItems: 1
> +    description:
> +      Reference to a phandle of a hardware spinlock provider node.
> +
> +required:
> +  - "#interrupt-cells"
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32-exti
> +              - st,stm32h7-exti
> +    then:
> +      properties:
> +        interrupts:
> +          allOf:
> +            - $ref: /schemas/types.yaml#/definitions/uint32-array

Standard property, doesn't need a type. You just need 'maxItems' or an
'items' list if the index is not meaningful. This appears to be the
former case.

> +          description:
> +            Interrupts references to primary interrupt controller
> +      required:
> +        - interrupts

You can move the definition to the main section as you only need
'required' here. That should fix your additionalProperties issue.

In hindsight, the mp1 case probably should have used interrupt-map.

> +
> +examples:
> +  - |
> +    //Example 1
> +    exti1: interrupt-controller@5000d000 {
> +        compatible = "st,stm32mp1-exti", "syscon";
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        reg = <0x5000d000 0x400>;
> +    };
> +
> +    //Example 2
> +    exti2: interrupt-controller@40013c00 {
> +        compatible = "st,stm32-exti";
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        reg = <0x40013C00 0x400>;
> +        interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
> +    };
> +
> +...
> --
> 2.17.1
>
