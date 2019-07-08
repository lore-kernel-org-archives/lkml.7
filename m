Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECD6C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EDF21707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562624392;
	bh=pNfMyb2lg0mXBAQjG7W80lNb5gbJDEIpRyCDOBUJXOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZA5sXlSoIrTKahvlAUwiUVsEv+f5ntqkSjlTY+pAEYtzCWcHIVySQZ12FwSHcKuSj
	 lo1mgPjfTGMjRjlfXauSPpBt9QBJ9IsorKh7WH9UgI8HD6HKvg0dL13WluXv4reI9C
	 jqS/LOQObj8YdAQ6s5fQg2mMdoKi+Dm7Szsry5nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405410AbfGHWTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:19:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32852 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfGHWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:19:51 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so23916896iog.0;
        Mon, 08 Jul 2019 15:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mN46vG+/AOz/nYTuDQPNV5277nOfHBKNL+k2+anwNSQ=;
        b=XhgH5E/sdyIXaCLrVDGUVddyypzTy+2HSt7JY8nIJzd27x1pCNjwmMVA30qvKPaFPU
         onWGhmly6Q5TBggGLQXvI7XuylS6yyevToz1yAA7Qz2c+9Qac4S13/rjbar+yLpIGHoM
         ly6WN3SSGjQfrjX6MaygUZDzwOKM+fS9JcpxZKaw9Nt+iXRr9xZ+osB4oEtt57EC3rVI
         fDmFG0fr+xBk8FuczCGZUdKMB7iq23KUild0xHnuXthnOMXyi+tWGJrthzQMueBfny89
         qe1NM9NaMEmZdiPH5oPvwRF6P5kA7uuhAjx4sS2QU79uLez3qWEzxcUb8af9Y+dI36FQ
         Nc4Q==
X-Gm-Message-State: APjAAAXfvhQUcRKpsgy1uDNP42gbwKrF5KJsff4rL+34a2IdLK/NEln2
        WmlsGBmlX1eIk3aiyVR9ZdCPMGs=
X-Google-Smtp-Source: APXvYqyFCtd9RZAWexm1ovEMHGgSm3Adn/B2Dt7+BZSqwk7NopQ7+ycbM6hzReeqC1agYla95EW74Q==
X-Received: by 2002:a02:1607:: with SMTP id a7mr23310703jaa.123.1562624389648;
        Mon, 08 Jul 2019 15:19:49 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q22sm14923152ioj.56.2019.07.08.15.19.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 15:19:48 -0700 (PDT)
Date:   Mon, 8 Jul 2019 16:19:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     mark.rutland@arm.com, jassisinghbrar@gmail.com,
        sudeep.holla@arm.com, f.fainelli@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, shawnguo@kernel.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andre.przywara@arm.com,
        van.freenix@gmail.com
Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
Message-ID: <20190708221947.GA13552@bogus>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-2-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603083005.4304-2-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:30:04PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The ARM SMC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
> Introduce interrupts as a property.
> 
> V1:
> arm,func-ids is still kept as an optional property, because there is no
> defined SMC funciton id passed from SCMI. So in my test, I still use
> arm,func-ids for ARM SIP service.
> 
>  .../devicetree/bindings/mailbox/arm-smc.txt        | 101 +++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> new file mode 100644
> index 000000000000..401887118c09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> @@ -0,0 +1,101 @@
> +ARM SMC Mailbox Interface
> +=========================
> +
> +This mailbox uses the ARM smc (secure monitor call) instruction to trigger
> +a mailbox-connected activity in firmware, executing on the very same core
> +as the caller. By nature this operation is synchronous and this mailbox
> +provides no way for asynchronous messages to be delivered the other way
> +round, from firmware to the OS, but asynchronous notification could also
> +be supported. However the value of r0/w0/x0 the firmware returns after
> +the smc call is delivered as a received message to the mailbox framework,
> +so a synchronous communication can be established, for a asynchronous
> +notification, no value will be returned. The exact meaning of both the
> +action the mailbox triggers as well as the return value is defined by
> +their users and is not subject to this binding.
> +
> +One use case of this mailbox is the SCMI interface, which uses shared memory
> +to transfer commands and parameters, and a mailbox to trigger a function
> +call. This allows SoCs without a separate management processor (or when
> +such a processor is not available or used) to use this standardized
> +interface anyway.
> +
> +This binding describes no hardware, but establishes a firmware interface.
> +Upon receiving an SMC using one of the described SMC function identifiers,
> +the firmware is expected to trigger some mailbox connected functionality.
> +The communication follows the ARM SMC calling convention[1].
> +Firmware expects an SMC function identifier in r0 or w0. The supported
> +identifiers are passed from consumers, or listed in the the arm,func-ids
> +properties as described below. The firmware can return one value in
> +the first SMC result register, it is expected to be an error value,
> +which shall be propagated to the mailbox client.
> +
> +Any core which supports the SMC or HVC instruction can be used, as long as
> +a firmware component running in EL3 or EL2 is handling these calls.
> +
> +Mailbox Device Node:
> +====================
> +
> +This node is expected to be a child of the /firmware node.
> +
> +Required properties:
> +--------------------
> +- compatible:		Shall be "arm,smc-mbox"
> +- #mbox-cells		Shall be 1 - the index of the channel needed.
> +- arm,num-chans		The number of channels supported.
> +- method:		A string, either:
> +			"hvc": if the driver shall use an HVC call, or
> +			"smc": if the driver shall use an SMC call.
> +
> +Optional properties:
> +- arm,func-ids		An array of 32-bit values specifying the function
> +			IDs used by each mailbox channel. Those function IDs
> +			follow the ARM SMC calling convention standard [1].
> +			There is one identifier per channel and the number
> +			of supported channels is determined by the length
> +			of this array.
> +- interrupts		SPI interrupts may be listed for notification,
> +			each channel should use a dedicated interrupt
> +			line.
> +
> +Example:
> +--------
> +
> +	sram@910000 {
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x93f000 0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0x93f000 0x1000>;
> +
> +		cpu_scp_lpri: scp-shmem@0 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0x200>;
> +		};
> +
> +		cpu_scp_hpri: scp-shmem@200 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x200 0x200>;
> +		};
> +	};
> +
> +	smc_mbox: mailbox {

This should be a child of 'firmware' node at least and really a child of 
the firmware component that implements the feature.

> +		#mbox-cells = <1>;
> +		compatible = "arm,smc-mbox";
> +		method = "smc";
> +		arm,num-chans = <0x2>;
> +		/* Optional */
> +		arm,func-ids = <0xc20000fe>, <0xc20000ff>;
> +	};
> +
> +	firmware {
> +		scmi {
> +			compatible = "arm,scmi";
> +			mboxes = <&mailbox 0 &mailbox 1>;
> +			mbox-names = "tx", "rx";
> +			shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
> +		};
> +	};
> +
> +
> +[1]
> +http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0028a/index.html
> -- 
> 2.16.4
> 
