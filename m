Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D87C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA7020856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568813571;
	bh=dgd3HLoBEteCdcPQrCZKXADiZ8jzryr3w3iCvP2D74Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UK+pA5PeNgOPBK8SZ5niu9QRyiHT1u6BSF+xLO1bdURsCqJlsO1qnAKlRwB5npVaz
	 Ysk5e9IdQPZy4/UJKyn9hS6Ln5f10v5x/FMRknl+JmrihVBnC60gx9rAP15PjW/T4p
	 M/fqeQPCx9cn3nr29kr7ejii3IZ6rJtgEuhWeIws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfIRNcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:32:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34251 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfIRNcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:32:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id 83so4469925oii.1;
        Wed, 18 Sep 2019 06:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7IwPCCYIN3KneYKTvFnqIuRk+F1H7GrB0ZojyqUwUE=;
        b=Dpu5ti0tgBfgj4+WCp3Fty35DAGLOAwV2xILVActKKI1/dQlG9VPQIr3NEmHZc1lt2
         MgWiuACgv9pSNea8lcFQh/xVUo9TIafiiqicbbzgX4X0MCi14j1kR0XiUBnsG10SuIGD
         phMSEVVDgvoZETUBpujPVhiiVDp1owiK9jFC0HTP9G1+rSIxqhjXI9W+Y8lJ2AmnEy3d
         Bd/Coj63HFP6gc5tSc6VpHxvSme0GkCEyRYL0t7W2uQ5cKjig52ZCnj6MRQr5Inqdcx3
         vCq6DD7oNE+4fcFWQd1TCN+KJB/H//8e9DBHc1wK1p5r1REtgillgFyyw7eM0BvBDYgO
         2sJQ==
X-Gm-Message-State: APjAAAVhSqoxmhIx0N6IBu0DX0JEmBgLKWKkJh9qEtO2Qija7B1XqLmn
        qCVG8+6vfB8AARqJCeAyWg==
X-Google-Smtp-Source: APXvYqz1JYVYLbKSA1/p8SgXY2Hoy54lVb9U2TutrUy/5vL0+EMXn3d1aQ/SNaMMW1c9u42gy9Tdog==
X-Received: by 2002:aca:4e85:: with SMTP id c127mr2143919oib.21.1568813569830;
        Wed, 18 Sep 2019 06:32:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm1836567ota.3.2019.09.18.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 06:32:48 -0700 (PDT)
Date:   Wed, 18 Sep 2019 08:32:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        mchehab+samsung@kernel.org, shawn.lin@rock-chips.com,
        gregkh@linuxfoundation.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: al-pos: Amazon's Annapurna Labs
 POS
Message-ID: <20190918133248.GA16653@bogus>
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
 <1568142310-17622-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568142310-17622-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:05:08PM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs POS SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../devicetree/bindings/soc/amazon/amazon,al-pos.txt   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt

Please convert to DT schema.

> 
> diff --git a/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt b/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
> new file mode 100644
> index 00000000..035cc571
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
> @@ -0,0 +1,18 @@
> +Amazon's Annapurna Labs POS
> +
> +POS node is defined to describe the Point Of Serialization (POS) logger
> +unit.
> +
> +Required properties:
> +- compatible:	Shall be "amazon,al-pos".
> +- reg:		POS logger resources.
> +- interrupts:	should contain the interrupt for pos error event.
> +
> +Example:
> +
> +al_pos {

Needs a unit-address.

> +	compatible = "amazon,al-pos";
> +	reg = <0x0 0xf0070084 0x0 0x00000008>;
> +	interrupt-parent = <&amazon_system_fabric>;
> +	interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
> +};
> -- 
> 2.7.4
> 
