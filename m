Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72744C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FED22166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562638985;
	bh=o5PSncln/gogTg+VDaiJOFZ9SDu4CtH4MR77spV0nYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z9y0FhQhUC9Lo9BGk+zIavENFYUJ4/cEFY7FEitiebBJU+UUB8VoZrF9l9mu0tSXx
	 DPr4fgEErqzsUrpJRe1jkWcveyfIBr11w38NcvqgcKPg3qf3SByJRG1OSmhJlJ9pzk
	 U6hoLw8tmMXVGOh5cNkcC9WrHPYuAFvxY3gVAM0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGICXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:23:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39022 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfGICXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:23:03 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so24329429ioh.6;
        Mon, 08 Jul 2019 19:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R3JPnhBHfFb9OzH6lZUtQSvRm4JihrB2GE869N3xz5E=;
        b=oi96BbFpsiOUnyL+wVC4Y6roxpY3TysWrAwnv04fBPnBS1yXfvUZN6rWjiSIKkCHUl
         OkuxBit4tQlDG3N94Tl8Z1TVFkyP2D1ynec1uwXCCNi0cR2v0sMBs4l0YOSylpyLfS1V
         4gmS76MLvERWL/Cq1lT9fD+hOA7p1iw44NJFftAky+GFyJody4gmj9ORBaHqmdlrYqa9
         wdDy7iU2FkZn/Iz7uUq7iAsGw+e119J9X3rJYLSwBUWKV9F7e57aoJ8dfrAIBzlhUgQB
         mY6VZ00N65zCfMQbZr3FXdfZ5sNolChgBT3IXx6TWGN3GyJCJjIupZogds+75GxdP1GQ
         ktdA==
X-Gm-Message-State: APjAAAVrT1hKRlX9a0nYSYwTTNjTskkNRGpIgyl99tguNt9QHzj1U2GO
        APr/JOY/NKYz/ZVlhx3SCQ==
X-Google-Smtp-Source: APXvYqxsIgOj/ZdGtWYV2BO0Gbl8kvdqQXFDzvnk6/W6LBdKDVVo9KM+Yn4hSrmBpblij3eaznvGHQ==
X-Received: by 2002:a02:3b62:: with SMTP id i34mr25538320jaf.91.1562638982759;
        Mon, 08 Jul 2019 19:23:02 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b3sm15095394iot.23.2019.07.08.19.23.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:23:02 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:23:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     nicolas.ferre@microchip.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, jonnyc@amazon.com, hhhawa@amazon.com,
        ronenk@amazon.com, hanochu@amazon.com, barakw@amazon.com
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: Amazon's
 Annapurna Labs FIC
Message-ID: <20190709022301.GA8734@bogus>
References: <1560155683-29584-1-git-send-email-talel@amazon.com>
 <1560155683-29584-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560155683-29584-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 11:34:42AM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Fabric Interrupt Controller SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../interrupt-controller/amazon,al-fic.txt         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> new file mode 100644
> index 0000000..4e82fd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> @@ -0,0 +1,29 @@
> +Amazon's Annapurna Labs Fabric Interrupt Controller
> +
> +Required properties:
> +
> +- compatible: should be "amazon,al-fic"
> +- reg: physical base address and size of the registers
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: must be 2.
> +  First cell defines the index of the interrupt within the controller.
> +  Second cell is used to specify the trigger type and must be one of the
> +  following:
> +    - bits[3:0] trigger type and level flags
> +	1 = low-to-high edge triggered
> +	4 = active high level-sensitive

No need to define this here. Reference the standard definition.

> +- interrupt-parent: specifies the parent interrupt controller.

Drop this. It is implied and could be in the parent.

> +- interrupts: describes which input line in the interrupt parent, this
> +  fic's output is connected to. This field property depends on the parent's
> +  binding
> +
> +Example:
> +
> +amazon_fic: interrupt-controller@0xfd8a8500 {

Drop the '0x'

> +	compatible = "amazon,al-fic";
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	reg = <0x0 0xfd8a8500 0x0 0x1000>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <GIC_SPI 0x0 IRQ_TYPE_LEVEL_HIGH>;
> +};
> -- 
> 2.7.4
> 
