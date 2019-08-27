Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92DF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566926402;
	bh=7QCXo11pySO/wlVmRZtLOHkgNATakju1Bb7r5a2wq14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kaiEmWl6a59mr1ZW7NKbk/qvaSyrmVCO2FiQFY3gIBDR+rFZBEYSDl5qXX3rehZ7P
	 Rb0QMBBYbObAVuIPR6NzklVbZoYmAXpbVBuNf+UAsftcLOehQgU8yeQ/fEMxM7WcuF
	 /NM9+NP/sPJaUpmAVYtmyn7hSqGw3HI1V6a4ui+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfH0RUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:20:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37329 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:20:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id f17so19453548otq.4;
        Tue, 27 Aug 2019 10:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jbgN4f1dE+DdTRtHITnsL1zb/tk6IDr9KI+sNDzzCw0=;
        b=AqHFtYqOvTSxAEoERCzrNTLKtR9f1kP4dEQMKm6Gs2uQVUwL8ZzLHYrcBm175+Z7VN
         ZtIcfbotF5GWFhZ6y30/m3Cwpf85eLgacxM50mAeRfIvUeKwZ3SVYgEvE6qHOmUCcHWZ
         s2nCUQAkHtkvo/K+RE6igglPsKW/kl9bypzeSMc8fAaV950Whrw8w+M3xHlnLJuBnd4M
         gSssGaVbf8ZEGyu3vPycoWgN3uSTkPYEVZFZ5xomAneptr6Pm+5cskiy74XGBaVHYlsK
         MTLUBO5Op7RSmfkRGNjtSvf+ut9vAKywCP9pdkjNqRedjLEnW+XLUDYO+yKbmJKoyiJk
         LFbg==
X-Gm-Message-State: APjAAAVP53nwBw2FcLG+gM4wLLcYq5v+00O4hjJN0QdSDcpZHJqZC4em
        13alQ5xIRoseEePHLYkPWg==
X-Google-Smtp-Source: APXvYqxV4NrnE2hDRfgzjsQvqIgGi0wFYE3LbnuAqf0XCI2QpBD/PpEV+RaKegu0aBl9in8p09Rwrg==
X-Received: by 2002:a9d:7dc6:: with SMTP id k6mr4430649otn.99.1566926400232;
        Tue, 27 Aug 2019 10:20:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a66sm5040827oii.15.2019.08.27.10.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:19:59 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:19:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     ulf.hansson@linaro.org, afaerber@suse.de, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
Message-ID: <20190827171959.GA30843@bogus>
References: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
 <20190821025629.15470-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821025629.15470-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 08:26:24AM +0530, Manivannan Sadhasivam wrote:
> Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
> controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/mmc/owl-mmc.yaml      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> new file mode 100644
> index 000000000000..f7eff4c43017
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) for new bindings please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/owl-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl SoCs SD/MMC/SDIO controller
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true

You can drop these.

> +
> +  compatible:
> +    const: actions,owl-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: mmc
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - dmas
> +  - dma-names
> +
> +examples:
> +  - |
> +    mmc0: mmc@e0330000 {
> +        compatible = "actions,owl-mmc";
> +        reg = <0x0 0xe0330000 0x0 0x4000>;
> +        interrupts = <0 42 4>;
> +        clocks = <&cmu 56>;
> +        resets = <&cmu 23>;
> +        dmas = <&dma 2>;
> +        dma-names = "mmc";
> +        bus-width = <4>;
> +    };
> +
> +...
> -- 
> 2.17.1
> 
