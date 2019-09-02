Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49059C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150D6216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431567;
	bh=ysPBp0yn2CyQgKuCSJSXZDFVRumNjk4aOeJSFWAEY6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uV/f1IN4TaYjWSsPQ9zEuzja+e31GM//Q0/UX1iA+XwPYCGYQ0Xhxq4h05aSTIXbl
	 k55pqEip5b9g3xAWChMqwmfI14AWAWStYAxNp5y12BAXYhym6mgPRW79GChMYpi3N7
	 /iaC6YG3bGVqatlkp0G3un/eyE6VbXfTQMZFE73k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfIBNj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:39:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37479 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbfIBNjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id d16so14655554wme.2;
        Mon, 02 Sep 2019 06:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=wPZgkYUgc3YwR+wsRfif0DfrV8qbGMQgmAEKsHAecWE=;
        b=eKuQdGtexegE3PpOSoNtZBswPvbY08dfUGF/JdNDuTDheJnGpB2WCdV7eH0ACzjyPw
         al24wTSCth1r4T923r8pGZfGEB8LdfINk112GO+kHocwx9OLAGUxZVJMQ7/ohv4ntTxE
         2Q36vXj6N5QDikirRBtnSAsSj8LnMtRmqm1XVjafeD38UIgKCsGykHVwzIaKe6I/qgyZ
         kKOJYt5HewE/XCbMLvX9b+WIxazyfPTX/pH5ho+NiF+LbNmnbNa6MwWo6JaYgoJZS4fe
         72ud+yaa9cMb1gK1Y91QoI4hKWxWecX+l+Iv0wTehUQruNCtd9a07FPwCU18mf7qwc8Z
         M5IQ==
X-Gm-Message-State: APjAAAWnihenHi34Fh9ugIUdapT6segGo3wfTCNzPG7m2waTlsmZesG3
        mNWLEd9J3j//Y/nFIR77Ng==
X-Google-Smtp-Source: APXvYqybCVrAVCbPJoi8ueJ0dQ9Ncnp8wfj00aMU86WHtM1txDOX6nDXBPHLAZhUgCdNYthuSw+/sg==
X-Received: by 2002:a7b:c244:: with SMTP id b4mr35203191wmj.125.1567431559382;
        Mon, 02 Sep 2019 06:39:19 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id m17sm15277494wrs.9.2019.09.02.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:18 -0700 (PDT)
Message-ID: <5d6d1b86.1c69fb81.f86b5.3988@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:18 +0100
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:02:58AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/arm-smc.yaml       | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> new file mode 100644
> index 000000000000..f8eb28d5e307
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/arm-smc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM SMC Mailbox Interface
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  This mailbox uses the ARM smc (secure monitor call) and hvc (hypervisor
> +  call) instruction to trigger a mailbox-connected activity in firmware,
> +  executing on the very same core as the caller. By nature this operation
> +  is synchronous and this mailbox provides no way for asynchronous messages
> +  to be delivered the other way round, from firmware to the OS, but
> +  asynchronous notification could also be supported. However the value of
> +  r0/w0/x0 the firmware returns after the smc call is delivered as a received
> +  message to the mailbox framework, so a synchronous communication can be
> +  established, for a asynchronous notification, no value will be returned.
> +  The exact meaning of both the action the mailbox triggers as well as the
> +  return value is defined by their users and is not subject to this binding.
> +
> +  One use case of this mailbox is the SCMI interface, which uses shared memory
> +  to transfer commands and parameters, and a mailbox to trigger a function
> +  call. This allows SoCs without a separate management processor (or when
> +  such a processor is not available or used) to use this standardized
> +  interface anyway.
> +
> +  This binding describes no hardware, but establishes a firmware interface.
> +  Upon receiving an SMC using one of the described SMC function identifiers,
> +  the firmware is expected to trigger some mailbox connected functionality.
> +  The communication follows the ARM SMC calling convention.
> +  Firmware expects an SMC function identifier in r0 or w0. The supported
> +  identifiers are passed from consumers, or listed in the the arm,func-ids
> +  properties as described below. The firmware can return one value in
> +  the first SMC result register, it is expected to be an error value,
> +  which shall be propagated to the mailbox client.
> +
> +  Any core which supports the SMC or HVC instruction can be used, as long as
> +  a firmware component running in EL3 or EL2 is handling these calls.
> +
> +properties:
> +  compatible:
> +    const: arm,smc-mbox
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +  arm,num-chans:
> +    description: The number of channels supported.
> +    items:
> +      minimum: 1
> +      maximum: 4096 # Should be enough?
> +
> +  method:
> +    - enum:

Did you build this with 'make dt_binding_check' as this should be a 
warning. This should not be a list entry (i.e. drop the '-').

> +        - smc
> +        - hvc
> +
> +  transports:

arm,transports

> +    - enum:
> +        - mem
> +        - reg
> +
> +  arm,func-ids:
> +    description: |
> +      An array of 32-bit values specifying the function IDs used by each
> +      mailbox channel. Those function IDs follow the ARM SMC calling
> +      convention standard [1].
> +
> +      There is one identifier per channel and the number of supported
> +      channels is determined by the length of this array.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 0
> +    maxItems: 4096   # Should be enough?
> +
> +required:
> +  - compatible
> +  - "#mbox-cells"
> +  - arm,num-chans
> +  - transports
> +  - method
> +
> +examples:
> +  - |
> +    sram@910000 {
> +      compatible = "mmio-sram";
> +      reg = <0x0 0x93f000 0x0 0x1000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0 0x0 0x93f000 0x1000>;
> +
> +      cpu_scp_lpri: scp-shmem@0 {
> +        compatible = "arm,scmi-shmem";
> +        reg = <0x0 0x200>;
> +      };
> +
> +      cpu_scp_hpri: scp-shmem@200 {
> +        compatible = "arm,scmi-shmem";
> +        reg = <0x200 0x200>;
> +      };
> +    };
> +
> +    firmware {
> +      smc_mbox: mailbox {
> +        #mbox-cells = <1>;
> +        compatible = "arm,smc-mbox";
> +        method = "smc";
> +        arm,num-chans = <0x2>;
> +        transports = "mem";
> +        /* Optional */
> +        arm,func-ids = <0xc20000fe>, <0xc20000ff>;
> +      };
> +
> +      scmi {
> +        compatible = "arm,scmi";
> +        mboxes = <&smc_mbox 0>, <&smc_mbox 1>;
> +        mbox-names = "tx", "rx";
> +        shmem = <&cpu_scp_lpri>, <&cpu_scp_hpri>;
> +      };
> +    };
> +
> +...
> -- 
> 2.16.4
> 

