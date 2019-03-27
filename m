Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249FD20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553728986;
	bh=PrmqpMfzrltuLaGCdjfRl8DBwx7XjCtT2crtDMEMEYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yFP4uXCuasI+pYDZGTGZCtRuE/Vo8X0tvE2hgYYBAD/pS5a8Wc5JLSSTmXz8hYcwP
	 Bi41cxlrkEO9ixeZIUlGOc+03cBMN82MH/unxH81d/JyPBqVlIj+4OWpI1sworjFX9
	 aNCOTkaGpoBGrobFZrsxVEnWnoXOXWW+6faOkaJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfC0XXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:23:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36119 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC0XXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:23:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id o74so16605080ota.3;
        Wed, 27 Mar 2019 16:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X9izbOMUwCRZa6WzDZaRDFv5zdrlITT7TLbKNQaKL5w=;
        b=Px6d8zhP0LerNAB8wREjGV3R3XdyLUzA5EHzTSnVLVGej2nfeQtnSY8eLG1tXkwqQP
         C6zpx0j13NeWLawuD88/Hq1336Fq/k+7XZxONZiP1Bd0wV1awxK02zDW/jX6GElpyW6b
         Imqwp/wv6f8I3L+JdTBDAcmMbLqvvOslqCXdzUojGo+4mNPRextXvUgMVOkdiXzDHsdB
         bFzvZJSUaLqBjYQm+jSNQEPuCwCPc3KepTugOhLIYwTJ6+x2Y1LQC4ecL4SIC9XUDnYe
         bNQecKTt4KblTLG3DwwnBlXYpFTzrSC7PGnVBYHldNl7Fx8xUJNnqdJHL33uodRRtsg3
         jucA==
X-Gm-Message-State: APjAAAUycYkVRpcsIPSHSXjSBC8He0/9grtUIVZLnKHLb3ITfTqjI/B0
        QQ8rXRMHGI2BYU/TdusFUw==
X-Google-Smtp-Source: APXvYqxRxLfFmtCS9Atsb4CfYTnhkh1cjGl8kaUIj7Qb6oIaRyYlGzDqBXBdbCAHYIO3ovOPfUZztg==
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr27615188otp.234.1553728983265;
        Wed, 27 Mar 2019 16:23:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x89sm8824006ota.30.2019.03.27.16.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:23:01 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:23:01 -0500
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
Subject: Re: [PATCH 2/8] dt-bindings: remoteproc: add bindings for stm32
 remote processor driver
Message-ID: <20190327232301.GA2172@bogus>
References: <1551795849-13672-1-git-send-email-fabien.dessenne@st.com>
 <1551795849-13672-3-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551795849-13672-3-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 03:24:03PM +0100, Fabien Dessenne wrote:
> Add the device tree bindings document for the stm32 remoteproc devices.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  .../devicetree/bindings/remoteproc/stm32-rproc.txt | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> new file mode 100644
> index 0000000..cc90c88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> @@ -0,0 +1,67 @@
> +STMicroelectronics STM32 Remoteproc
> +-----------------------------------
> +This document defines the binding for the remoteproc component that loads and
> +boots firmwares on the ST32MP family chipset.
> +
> +Required properties:
> +- compatible:	Must be "st,stm32mp1-rproc"

'rproc' is what this is called in the h/w manual?

> +- reg:		Address ranges of the remote processor dedicated memories.
> +		The parent node should provide an appropriate ranges property
> +		for properly translating these into bus addresses.
> +- resets:	Reference to a reset controller asserting the remote processor.
> +- reset-names:	Must be "mcu_rst"

-names is kind of pointless when there is only 1 entry.

> +- st,syscfg-holdboot: Reference to the system configuration which holds the
> +		remote processor reset hold boot
> +	1st cell: phandle of syscon block
> +	2nd cell: register offset containing the hold boot setting
> +	3rd cell: register bitmask for the hold boot field
> +- st,syscfg-tz: Reference to the system configuration which holds the RCC trust
> +		zone mode
> +	1st cell: phandle to syscon block
> +	2nd cell: register offset containing the RCC trust zone mode setting
> +	3rd cell: register bitmask for the RCC trust zone mode bit
> +
> +Optional properties:
> +- interrupt-parent: phandle to the interrupt controller node.

This is implied.

> +- interrupts:	Should contain the watchdog interrupt
> +- interrupt-names: Must be "wdg"

-names is kind of pointless when there is only 1 entry.

> +- mboxes:	List of phandle and mailbox channel specifiers:

How would one talk to the processor if this is optional?

> +		- a channel (a) used to communicate through virtqueues with the
> +		  remote proc.
> +		  Bi-directional channel:
> +		      - from local to remote = send message
> +		      - from remote to local = send message ack
> +		- a channel (b) working the opposite direction of channel (a)
> +		- a channel (c) used by the local proc to notify the remote proc
> +		  that it is about to be shut down.
> +		  Mono-directional channel:

Unidirectional

> +		      - from local to remote, where ACK from the remote means
> +		        that it is ready for shutdown
> +- mbox-names:	This property is required if the mboxes property is used.
> +		- must be "vq0" for channel (a)
> +		- must be "vq1" for channel (b)
> +		- must be "shutdown" for channel (c)
> +- memory-region: list of phandles to the reserved memory regions associated with
> +		the remoteproc device
> +		(see ../reserved-memory/reserved-memory.txt)

How many?

> +- st,syscfg-pdds: Reference to the system configuration which holds the remote
> +		processor deep sleep setting
> +	1st cell: phandle to syscon block
> +	2nd cell: register offset containing the deep sleep setting
> +	3rd cell: register bitmask for the deep sleep bit
> +- auto_boot:	If defined, when remoteproc is probed, it looks for a default
> +		firmware and if it finds some, it loads the firmware and starts
> +		the remote processor.

How do you know what is and isn't default firmware? Seems like this 
could be accomplished using the standard 'firmware-name' to specify what 
firmware to load and boot.

> +- recovery:	If defined, remoteproc enables the crash recovery process.

Doesn't seem like a static DT property. This is a feature to enable or 
something you set on boot to recover?

> +
> +Example:
> +	m4_rproc: m4@0 {
> +		compatible = "st,stm32mp1-rproc";
> +		reg = <0x00000000 0x10000>,
> +		      <0x10000000 0x40000>,
> +		      <0x30000000 0x40000>;
> +		resets = <&rcc MCU_R>;
> +		reset-names = "mcu_rst";
> +		st,syscfg-holdboot = <&rcc 0x10C 0x1>;
> +		st,syscfg-tz = <&rcc 0x000 0x1>;
> +	};
> -- 
> 2.7.4
> 
