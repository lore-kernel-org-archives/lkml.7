Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4ACC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E66521655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556584855;
	bh=Vq2SIzYLltqiP/nMG6XHfpPIjGy3WuM7JxtYCJroVOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xWdsY2ibz3uGFXW1ng69Cm7ghmzMGKEah3MSmnc8I0PgPynwlC8cNKlHkVE+ukYY2
	 GQraJDmvkDU2cO2dVY4SyriiCnbPNb51aXrjTt6CMM2JUk3YSeBDe1ATvt+wDkWkM7
	 8qcpsPF2WG1C+/BWPaIOflKYJYmVmwoBwRi/homU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfD3Aky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:40:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35248 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3Akx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:40:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id w197so9908243oia.2;
        Mon, 29 Apr 2019 17:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9Iv2ifY4GsmV3xCWRy9UVgazV3TsrIbtMu5jqaQZhI=;
        b=Djas2NxqkJIwANqjFaAfwQhagy4ZZR3zNO31BzPCDmDHNb2+GsXIq4aHPuU21tXxTf
         caQZbiS91rpyn8yiaJQXhYOP4hrAPkvCjeCIehRekX1+dQm4mrfgk7Fjr7b7w48+dkCf
         XsO2C6e59oN/nqNCZ2KY3JHsovtJ4oxjM2TqhXheJo78/eAInwJWrM9B4IZIOFc0fkx0
         vxa+QHdW38sx2k7F2PmMAhhwnV3K+br7uyObdsiRpH83jRCPdAbfnXmDU99PDVKcRqvj
         tV9U9rs6+HbngdD1MAMdtLhEbc/7lqSeuzhQp5Wr/5nLhzBMo7yNDmqImJ8JSWmx6UHb
         oe/g==
X-Gm-Message-State: APjAAAU8CTZqVVnsi3i+gHY06Yd6Yd8nOxXm2VtMAsEP32Q1Z39qZpQR
        hf1FYFOR9sM83NTvUTkhzg==
X-Google-Smtp-Source: APXvYqwW5hh4WHQNcZx2ZksEDdkJIORlNN4TTBlJnzXoGja1o5FdA+MCwncVj6Y4QcnHR11jUvZouA==
X-Received: by 2002:aca:5fc4:: with SMTP id t187mr1302241oib.18.1556584852646;
        Mon, 29 Apr 2019 17:40:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k65sm14951243oia.16.2019.04.29.17.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 17:40:51 -0700 (PDT)
Date:   Mon, 29 Apr 2019 19:40:51 -0500
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
Subject: Re: [PATCH v2 2/8] dt-bindings: remoteproc: add bindings for stm32
 remote processor driver
Message-ID: <20190430004051.GA7391@bogus>
References: <1555426699-5340-1-git-send-email-fabien.dessenne@st.com>
 <1555426699-5340-3-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555426699-5340-3-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:58:13PM +0200, Fabien Dessenne wrote:
> Add the device tree bindings document for the stm32 remoteproc devices.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  .../devicetree/bindings/remoteproc/stm32-rproc.txt | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> new file mode 100644
> index 0000000..430132c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> @@ -0,0 +1,64 @@
> +STMicroelectronics STM32 Remoteproc
> +-----------------------------------
> +This document defines the binding for the remoteproc component that loads and
> +boots firmwares on the ST32MP family chipset.
> +
> +Required properties:
> +- compatible:	Must be "st,stm32mp1-m4"
> +- reg:		Address ranges of the remote processor dedicated memories.
> +		The parent node should provide an appropriate ranges property
> +		for properly translating these into bus addresses.

dma-ranges, but that's independent of 'reg'.

It needs to list how many reg regions and what they are.

> +- resets:	Reference to a reset controller asserting the remote processor.
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
> +- interrupts:	Should contain the watchdog interrupt
> +- mboxes:	This property is required only if the rpmsg/virtio functionality
> +		is used. List of phandle and mailbox channel specifiers:
> +		- a channel (a) used to communicate through virtqueues with the
> +		  remote proc.
> +		  Bi-directional channel:
> +		      - from local to remote = send message
> +		      - from remote to local = send message ack
> +		- a channel (b) working the opposite direction of channel (a)
> +		- a channel (c) used by the local proc to notify the remote proc
> +		  that it is about to be shut down.
> +		  Unidirectional channel:
> +		      - from local to remote, where ACK from the remote means
> +		        that it is ready for shutdown
> +- mbox-names:	This property is required if the mboxes property is used.
> +		- must be "vq0" for channel (a)
> +		- must be "vq1" for channel (b)
> +		- must be "shutdown" for channel (c)
> +- memory-region: List of phandles to the reserved memory regions associated with
> +		the remoteproc device. This is variable and describes the
> +		memories shared with the remote processor (eg: remoteproc
> +		firmware and carveouts, rpmsg vrings, ...).
> +		(see ../reserved-memory/reserved-memory.txt)
> +- st,syscfg-pdds: Reference to the system configuration which holds the remote
> +		processor deep sleep setting
> +	1st cell: phandle to syscon block
> +	2nd cell: register offset containing the deep sleep setting
> +	3rd cell: register bitmask for the deep sleep bit
> +- auto_boot:	If defined, when remoteproc is probed, it loads the default
> +		firmware and starts the remote processor.

st,auto-boot

> +
> +Example:
> +	m4_rproc: m4@0 {
> +		compatible = "st,stm32mp1-m4";
> +		reg = <0x00000000 0x10000>,
> +		      <0x10000000 0x40000>,
> +		      <0x30000000 0x40000>;
> +		resets = <&rcc MCU_R>;
> +		st,syscfg-holdboot = <&rcc 0x10C 0x1>;
> +		st,syscfg-tz = <&rcc 0x000 0x1>;
> +	};
> -- 
> 2.7.4
> 
