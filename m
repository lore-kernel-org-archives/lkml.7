Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16F22067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556579601;
	bh=JMZYoGWizgiNxhMNhGj4R6i/Ml1AvFt3aYd285yQE7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uLrJSo5vxAXqLkFn+/dGj5EXvLkSuJ6R2W1O3lhDIV1J/a2YUN/ruhvQ4kXmtEOXK
	 RJu11j+EIBKTgEUW2JtSl1+TRXom/qG5YXcYrCZu61CVb1bA9YYnbIRUhHjrtHSLGn
	 SK0yyX1Q5++xNONMfykkjrqOOi7ag2S749QaoZ1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfD2XNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:13:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41484 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbfD2XNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:13:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id g8so9255139otl.8;
        Mon, 29 Apr 2019 16:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1O8sBEArMyrhqwTcVLODqVK500uIwj8t/3xZEzr2rlE=;
        b=oqaq6xuegt4KOwgAtlREALpM64s28IhrijvHmG1YDXL3L2Vxt0Vk7TIvt1bQfBR35J
         b3mA0zEaaEfDr8qC5+9+cJEpObmnbjby8rblONIif2LHQyh3AtT7XjSXWzgdywI5+oQ7
         ZHVfh+VVuyfYq9OeNpv8uxjdZR709aLnHYxxgN6gsVlP5FZXTrMx5tE7YN31nmJePJhF
         sXYChZWEPXaxdodmLBCZMcrRWlUfoV+Ln+GLEJGO/JaTfhQpesb4/EyEjSC08LjkqZ8b
         F/Y3k+yfUSQ6lLSLRqjnEsyQ3aeWonwWod6wIDCY0RF2lBOAJhOloeuoWNP6KvK6PRUq
         4lgg==
X-Gm-Message-State: APjAAAUcmaOoej4BAptjQyMM5dwq9BypqGgk9vvkMwMQzt9aXQJqZ6oL
        5snLjj4G/dhuhfjqI09JvQ==
X-Google-Smtp-Source: APXvYqxfp5Q4JJdPQJwax02hjhdCKb3p3RdL1zNagDD5a7+FoN+9hkK7/OqHSYTKoeE7c2kOZMmk9A==
X-Received: by 2002:a05:6830:20c4:: with SMTP id z4mr1561007otq.27.1556579597678;
        Mon, 29 Apr 2019 16:13:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f18sm13702399otl.51.2019.04.29.16.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 16:13:16 -0700 (PDT)
Date:   Mon, 29 Apr 2019 18:13:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: stm32: add bindings for ML-AHB
 interconnect
Message-ID: <20190429231316.GA13995@bogus>
References: <1555426699-5340-1-git-send-email-fabien.dessenne@st.com>
 <1555426699-5340-2-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555426699-5340-2-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:58:12PM +0200, Fabien Dessenne wrote:
> Document the ML-AHB interconnect for stm32 SoCs.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  .../devicetree/bindings/arm/stm32/mlahb.txt        | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> new file mode 100644
> index 0000000..a36458a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> @@ -0,0 +1,37 @@
> +ML-AHB interconnect bindings
> +
> +These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
> +a Cortex-M subsystem with dedicated memories.
> +The MCU SRAM and RETRAM memory parts can be accessed through different addresses
> +(see "RAM aliases" in [1]) using different buses (see [2]) : balancing the
> +Cortex-M firmware accesses among those ports allows to tune the system
> +performance.
> +
> +[1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
> +[2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
> +
> +Required properties:
> +- compatible: should be "simple-bus"
> +- dma-ranges: describes memory addresses translation between the local CPU and
> +	   the remote Cortex-M processor. Each memory region, is declared with
> +	   3 parameters:
> +		 - param 1: device base address (Cortex-M processor address)
> +		 - param 2: physical base address (local CPU address)
> +		 - param 3: size of the memory region.
> +
> +The Cortex-M remote processor accessed via the mlahb interconnect is described
> +by a child node.
> +
> +Example:
> +mlahb {
> +	compatible = "simple-bus";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	dma-ranges = <0x00000000 0x38000000 0x10000>,
> +		     <0x10000000 0x10000000 0x60000>,
> +		     <0x30000000 0x30000000 0x60000>;
> +
> +	m4_rproc: m4@0 {

'0' is a cpu address given there's no 'ranges' now for translating cpu 
addresses. I think you want it to be 0x38000000 instead. 

> +		...
> +	};
> +};
> -- 
> 2.7.4
> 
