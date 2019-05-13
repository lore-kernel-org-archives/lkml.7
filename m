Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7570520873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557767967;
	bh=0q4MOW6tHtWJsQHveTpWZRRuwhbh3nK2gBHeqEF/sV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H47445guyp5HPaA8MD6UH6gC5s0SVXKqjiZODKgmASE27dPcJEYt2MLF+wyZhqMDC
	 YqbVv4BfIX4F6Gnx2a2HbqQZReLgYUEcX4cGnm0XKGEYL8yh5SD2Z8RNEsJ6X8IMV5
	 FNoxm7oEhvKRdy/THGL9jNCKHi18wtoYr8d1sUzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfEMRT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:19:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45804 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbfEMRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:19:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id t24so3797219otl.12;
        Mon, 13 May 2019 10:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gxg55zJpNlVm2nYvWvCM959D+KA++JweeXldKs1l7XI=;
        b=YOpx5Gfuiz7/I1GC2K2JHc/cK0drj3PAq7S03vi4BQ0Dm0RVTfhrY2YfRv92ttsQ7P
         7VOZ2rOmqwSdDhptWaj1QvBXKmjLgUQKm6mzYoqqqJTLvuUTF2Sx8YBrWYVUC4C5wBqx
         zD9B6FhoLkY4G+ggX+lWPh9Xzzd/bTHBQWC/xhd7kG5oq02TOI0TAmBgABmuTdthmGxX
         EHR7dx1pP1COqYKGJsdrxvEXV2NtbAuhYUJS4Ca6GPQ2YPi9oBed6EWKI7gXGDEsgs+9
         ZWG1MYDsG3VjNC0VOeh3RfuBPF7NncgvKPXBwx/qVJImV/m33xxF5UxIhrpjD5YPL1U3
         OG7Q==
X-Gm-Message-State: APjAAAUtHT6m/W1L/cKTa93Ro1I+GrwZy8Om2sZ7OlPZRpHbwgH2DqLF
        JpjoJrdaeK3FoR9IoTjt3Q==
X-Google-Smtp-Source: APXvYqx7PhGUwDZEi+8Vj6jS0VwAlzO0fyOLufMf85clsIBI268PujGqMZ25iGzjREBsER4YemD1fg==
X-Received: by 2002:a05:6830:11ce:: with SMTP id v14mr15390493otq.184.1557767964113;
        Mon, 13 May 2019 10:19:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g84sm5482087oia.31.2019.05.13.10.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:19:23 -0700 (PDT)
Date:   Mon, 13 May 2019 12:19:22 -0500
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
Subject: Re: [PATCH v3 2/8] dt-bindings: remoteproc: add bindings for stm32
 remote processor driver
Message-ID: <20190513171922.GA25458@bogus>
References: <1556784606-3016-1-git-send-email-fabien.dessenne@st.com>
 <1556784606-3016-3-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556784606-3016-3-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 10:10:00AM +0200, Fabien Dessenne wrote:
> Add the device tree bindings document for the stm32 remoteproc devices.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  .../devicetree/bindings/remoteproc/stm32-rproc.txt | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> new file mode 100644
> index 0000000..a495757
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
> @@ -0,0 +1,63 @@
> +STMicroelectronics STM32 Remoteproc
> +-----------------------------------
> +This document defines the binding for the remoteproc component that loads and
> +boots firmwares on the ST32MP family chipset.
> +
> +Required properties:
> +- compatible:	Must be "st,stm32mp1-m4"
> +- reg:		Address ranges of the RETRAM and MCU SRAM memories used by the
> +		remote processor.
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
> +- st,auto_boot:	If defined, when remoteproc is probed, it loads the default
> +		firmware and starts the remote processor.

s/_/-/

> +
> +Example:
> +	m4_rproc: m4@38000000 {
> +		compatible = "st,stm32mp1-m4";
> +		reg = <0x00000000 0x10000>,

Doesn't match the unit-address.

> +		      <0x10000000 0x40000>,
> +		      <0x30000000 0x40000>;
> +		resets = <&rcc MCU_R>;
> +		st,syscfg-holdboot = <&rcc 0x10C 0x1>;
> +		st,syscfg-tz = <&rcc 0x000 0x1>;
> +	};
> -- 
> 2.7.4
> 
