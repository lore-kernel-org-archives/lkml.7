Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE11C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76853214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570797686;
	bh=0ntoZW7nIQaS0RptBTqn8yRQKbcwYPW6mrTC+nExxQQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VqGm1LBEpepLnORxgq4Rju1G4cTuisvqbsj9JDwytRBvrrSJGP5pIyEHtb1F+nm5+
	 k36kM7TTIBr7JS7MTl6OtMFP6+e7e88soVyQWc21dQCSnbiXtK0+SNGEn0qLTq5VTC
	 +XkshQ9en9bhXOjiLALUCcnbZF+OPzMJSOHVdfbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfJKMlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbfJKMlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:41:23 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D471E21D82;
        Fri, 11 Oct 2019 12:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570797683;
        bh=0ntoZW7nIQaS0RptBTqn8yRQKbcwYPW6mrTC+nExxQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dR100AmRHlPwX27kUrp1Lauf3ohIZVPT1aokTFmN/cMb52PIZCHr7cnR8lnpbjLqj
         dicgfF0TpW4nEd2mwFBiZJjqOSCarxIGU+A6CE1Bvzn5Lxu1fFt6mtmei+4dyZVSSl
         CSrZCRsYHokj3EuztdAzqWaGGTOBWJxfSIjVmNCk=
Received: by mail-qk1-f178.google.com with SMTP id u184so8729069qkd.4;
        Fri, 11 Oct 2019 05:41:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUd2UBXEtHJcOxwdG1FbIT5dJXmJhSM6AqXDoXVp/OTrGmmbf3x
        oH9VcV9ON0woIWvIcZL5SFVNK3kgafadNTw6IQ==
X-Google-Smtp-Source: APXvYqxSOLHC3OhXJjaOJaRAYwJ7GF4/t7229zQiP9PqqmGtuF/Yddz3rOt3p/MLumF2OTaUmi8AujpP8UblZE39o8w=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr15407013qkl.152.1570797681944;
 Fri, 11 Oct 2019 05:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191002151907.15986-1-benjamin.gaignard@st.com>
In-Reply-To: <20191002151907.15986-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Oct 2019 07:41:10 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+p6rYun-zOwK49=QSfuJGMpiXj5UfASdXhjmOX1cudWQ@mail.gmail.com>
Message-ID: <CAL_Jsq+p6rYun-zOwK49=QSfuJGMpiXj5UfASdXhjmOX1cudWQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hwlock: Convert stm32 hwspinlock bindings to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 10:19 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Convert the STM32 hwspinlock binding to DT schema format using json-schema
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 -----------
>  .../bindings/hwlock/st,stm32-hwspinlock.yaml       | 48 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml
>
> diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> deleted file mode 100644
> index adf4f000ea3d..000000000000
> --- a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -STM32 Hardware Spinlock Device Binding
> --------------------------------------
> -
> -Required properties :
> -- compatible : should be "st,stm32-hwspinlock".
> -- reg : the register address of hwspinlock.
> -- #hwlock-cells : hwlock users only use the hwlock id to represent a specific
> -       hwlock, so the number of cells should be <1> here.
> -- clock-names : Must contain "hsem".
> -- clocks : Must contain a phandle entry for the clock in clock-names, see the
> -       common clock bindings.
> -
> -Please look at the generic hwlock binding for usage information for consumers,
> -"Documentation/devicetree/bindings/hwlock/hwlock.txt"
> -
> -Example of hwlock provider:
> -       hwspinlock@4c000000 {
> -               compatible = "st,stm32-hwspinlock";
> -               #hwlock-cells = <1>;
> -               reg = <0x4c000000 0x400>;
> -               clocks = <&rcc HSEM>;
> -               clock-names = "hsem";
> -       };
> diff --git a/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml
> new file mode 100644
> index 000000000000..64e169702515
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwlock/st,stm32-hwspinlock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Hardware Spinlock bindings
> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> +  - Fabien Dessenne <fabien.dessenne@st.com>
> +
> +properties:
> +  "#hwlock-cells": true

const: 1

> +
> +  compatible:
> +    const: st,stm32-hwspinlock
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Module Clock

Don't need a description for a single item.

maxItems: 1

> +
> +  clock-names:
> +    items:
> +      - const: hsem
> +
> +required:
> +  - "#hwlock-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names

Add a:

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    hwspinlock@4c000000 {
> +        compatible = "st,stm32-hwspinlock";
> +        #hwlock-cells = <1>;
> +        reg = <0x4c000000 0x400>;
> +        clocks = <&rcc HSEM>;
> +        clock-names = "hsem";
> +    };
> +
> +...
> --
> 2.15.0
>
