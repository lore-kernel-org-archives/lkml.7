Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E3C80D21
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C75224718
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269650;
	bh=/EvEh1E9wFwFKbgrjOrVViLZY6/9YL7B+khY7dBrn/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ynqkR/ieqwZ2iG+LYprqS3EOBJx56LVWIcPTN7Fzsur2+kN0rqrRFBz2tPLpj+Mbc
	 g5w7EfEU7DG0dvcEU6ieSMIXVa9V9i4gpSZqJpwZn6Psr8FQ5v5nezF0vViLXCKlsM
	 WZ7tB7OzKVtN5+INzuuMUSxW9xlFqH61Nr2xgJ9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfLMTCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:02:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33254 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMTCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:02:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id v140so1673847oie.0;
        Fri, 13 Dec 2019 11:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2XdeKtI0YQlIdxephxhveyyskN7+C9/UjeBuKo3UXnA=;
        b=ihrbPpTpwm9ABq5vgD5GK0bTAJXNLa3wdV2xdJrQgduGnQhnBNoiLx3Nu3QNtVKLET
         zJM3pJ/lktGafG6SdbUt0GgN1XnQPdIxmleRDJ6KXsxh63HrdvzyHokupKFTZzvvDXzD
         j3QDnNewtHchha7Gh2n2BYNUxzmXAtPFQ2VC7K0qE9LOnQkwN4uruaN/gRXTAhnUKM2L
         6W9VgAYJdHyXvDZJTpqCPE9yVK/ZtaOgxc2IrzSGOJTatrOBJoAO+VadohhIp/rjiVYe
         SZw7M8seGvCd2/EwnVsdiG8ZqnAeHkM8Nv2oOX5DacTbW9s6yiJgbd3tPFYZTrgqpL/Y
         krIw==
X-Gm-Message-State: APjAAAVk7x5YR8+pYP15JzxpWVlPHj3XAwmVTWUA9xtO65/+nX21jjfV
        9YX6GPgdhOmSQm7cFDIWHit9YoU=
X-Google-Smtp-Source: APXvYqw8UMim545Km3t4cYb2yWB3l/jkydMfF9IZ1540YOrSblxxasMA+XzaDkAFtvgcqL4kI0gBlg==
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr7214700oih.143.1576263722041;
        Fri, 13 Dec 2019 11:02:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b3sm3542692oie.25.2019.12.13.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:02:01 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:02:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: Document JZ47xx VPU auxiliary
 processor
Message-ID: <20191213190200.GA11267@bogus>
References: <20191210164014.50739-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210164014.50739-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 05:40:10PM +0100, Paul Cercueil wrote:
> Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
> Ingenic is a second Xburst MIPS CPU very similar to the main core.
> This document describes the devicetree bindings for this auxiliary
> processor.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Update TCSM0 address in example
>     v3: Change node name to 'video-decoder'
>     v4: Convert to YAML. I didn't add Rob's Ack on v3 because of that (sorry Rob)
> 
>  .../bindings/remoteproc/ingenic,vpu.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
> new file mode 100644
> index 000000000000..9f876d16a5a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/remoteproc/ingenic,vpu.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Ingenic Video Processing Unit bindings
> +
> +description:
> +  Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
> +  Ingenic is a second Xburst MIPS CPU very similar to the main core.
> +  This document describes the devicetree bindings for this auxiliary
> +  processor.
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  compatible:
> +    const: ingenic,jz4770-vpu-rproc
> +
> +  reg:
> +    items:
> +      - description: aux registers
> +      - description: tcsm0 registers
> +      - description: tcsm1 registers
> +      - description: sram registers
> +
> +  reg-names:
> +    items:
> +      - const: aux
> +      - const: tcsm0
> +      - const: tcsm1
> +      - const: sram
> +
> +  clocks:
> +    items:
> +      - description: aux clock
> +      - description: vpu clock
> +
> +  clock-names:
> +    items:
> +      - const: aux
> +      - const: vpu
> +
> +  interrupts:
> +    description: VPU hardware interrupt
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    vpu: video-decoder@132a0000 {
> +      compatible = "ingenic,jz4770-vpu-rproc";
> +
> +      reg = <0x132a0000 0x20 /* AUX */
> +           0x132b0000 0x4000 /* TCSM0 */
> +           0x132c0000 0xc000 /* TCSM1 */
> +           0x132f0000 0x7000 /* SRAM */
> +      >;
> +      reg-names = "aux", "tcsm0", "tcsm1", "sram";
> +
> +      clocks = <&cgu JZ4770_CLK_AUX>, <&cgu JZ4770_CLK_VPU>;

Examples are built now by 'make dt_binding_check' and this fails. You 
need to add the include for these defines.

Also, the schema should complain after that on 'reg'. You need to <> 
each entry (addr and size).

> +      clock-names = "aux", "vpu";
> +
> +      interrupt-parent = <&cpuintc>;
> +      interrupts = <3>;
> +    };
> -- 
> 2.24.0
> 
