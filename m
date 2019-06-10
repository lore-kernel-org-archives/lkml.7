Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC8C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29D5208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560203876;
	bh=g4mY100w2qgQoqrm9iHtxlwWj9iN/wYo4Hcn8OgqS8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ez0KQdva0vQGU+DzAErMCOL3m1St04ENXtF1vkXY62xVk1aq9DeO35GLGAItGir10
	 Dvw2UTJdpFhfhmz/bviaExxc51NCQYuxL6uvK6iQ+UnrtSxnl0GPJnnTUjWq3JtmM2
	 FQhtjlmJ6sHGgij/lALLI1Rxw2L1UiDvzzbB5FFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfFJV54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfFJV5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:57:55 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE86212F5;
        Mon, 10 Jun 2019 21:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560203875;
        bh=g4mY100w2qgQoqrm9iHtxlwWj9iN/wYo4Hcn8OgqS8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fO8OzSFz3yf/+buoGxsLocyYpw/2kZwneLtrMzQ05YDjIRyc2CdUqR1PIhjOLP5x/
         jvFdH7X9Uqd/8QErrXxULrDRJNIS7T+v9WXbPRP/d7ScW5DXaSbbrO3WHycdhZxgdR
         lftNaJOTMYM6k3XwuF9LnSP3XL1HG4cbXSzsrReg=
Received: by mail-qt1-f179.google.com with SMTP id i34so12170246qta.6;
        Mon, 10 Jun 2019 14:57:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXzxoPiTvm+6mL7H3Jpr2zZNHpRNC+zKxCyWa/2Mwjny4CkyUIn
        ooVHu/fzg5/tDZf6hAZBhaqzDL21esRdujtJsA==
X-Google-Smtp-Source: APXvYqw1cfkjGTbC0jdIEGlyRcw4f3LBrmMrdCPBXItz9JGMvlPjCnQIatnqWLCFa+L6qVlKCb97ojLPMStDgnodVi8=
X-Received: by 2002:a0c:8a43:: with SMTP id 3mr13015726qvu.138.1560203874386;
 Mon, 10 Jun 2019 14:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190531063849.26142-1-manivannan.sadhasivam@linaro.org> <20190531063849.26142-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190531063849.26142-3-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 15:57:43 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+N7NA7m+dp+zpwFeZLM6B+OwRrqZdzKkJp2TRWi_e3Mw@mail.gmail.com>
Message-ID: <CAL_Jsq+N7NA7m+dp+zpwFeZLM6B+OwRrqZdzKkJp2TRWi_e3Mw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: stm32: Convert STM32 SoC
 bindings to DT schema
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        loic pallardy <loic.pallardy@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 12:39 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> This commit converts STM32 SoC bindings to DT schema using jsonschema.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/arm/stm32/stm32.yaml  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.yaml

Converting implies removal of something. The schema looks fine though.

>
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> new file mode 100644
> index 000000000000..f53dc0f2d7b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/stm32/stm32.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Alexandre Torgue <alexandre.torgue@st.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: st,stm32f429
> +
> +      - items:
> +          - const: st,stm32f469
> +
> +      - items:
> +          - const: st,stm32f746
> +
> +      - items:
> +          - const: st,stm32h743
> +
> +      - items:
> +          - const: st,stm32mp157
> +...
> --
> 2.17.1
>
