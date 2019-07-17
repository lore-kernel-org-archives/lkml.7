Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D93C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5F21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfGQR2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:28:06 -0400
Received: from foss.arm.com ([217.140.110.172]:49426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfGQR2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:28:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB8E628;
        Wed, 17 Jul 2019 10:28:04 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B65B3F71F;
        Wed, 17 Jul 2019 10:28:03 -0700 (PDT)
Date:   Wed, 17 Jul 2019 18:28:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Message-ID: <20190717172801.GG18370@e107155-lin>
References: <1563184103-8493-1-git-send-email-peng.fan@nxp.com>
 <1563184103-8493-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563184103-8493-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks much better now.

On Mon, Jul 15, 2019 at 10:10:10AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>  Convert to yaml
>  Drop interrupt
>  Introudce transports to indicate mem/reg
>  The func id is still kept as optional, because like SCMI it only
>  cares about message.
> 
> V2:
>  Introduce interrupts as a property.
> 
>  .../devicetree/bindings/mailbox/arm-smc.yaml       | 124 +++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> new file mode 100644
> index 000000000000..da9b1a03bc4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> @@ -0,0 +1,124 @@
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
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  method:
> +    items:
> +      - enum:
> +          - smc
> +          - hvc
> +
> +  transports:
> +    items:
> +      - enum:
> +          - mem
> +          - reg
> +
> +  arm,func-ids:
> +    description: |
> +      An array of 32-bit values specifying the function IDs used by each
> +      mailbox channel. Those function IDs follow the ARM SMC calling
> +      convention standard [1].
> +
> +      There is one identifier per channel and the number of supported
> +      channels is determined by the length of this array.
> +    minItems: 0
> +    maxItems: 4096   # Should be enough?

I am new to yaml, is there a way to say the number of entries here must
match arm,num-chans ? And not sure if min/maxItems matter then ?

> +
> +required:
> +  - compatible
> +  - "#mbox-cells"
> +  - arm,num-chans
> +  - transports
> +  - method
> +

Why is arm,func-ids optional ? Is there any standard arm,func-ids we can
resort to. Sorry I know you expect ARM Ltd to answer that, but I just want
to raise the point that we don't have one today and hence it can't be
optional. Or I am missing something ?

--
Regards,
Sudeep
