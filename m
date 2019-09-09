Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18161C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B0F21A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbfIIPmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:42:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388577AbfIIPmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:42:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC136169E;
        Mon,  9 Sep 2019 08:42:12 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75B5B3F59C;
        Mon,  9 Sep 2019 08:42:11 -0700 (PDT)
Date:   Mon, 9 Sep 2019 16:42:08 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the
 ARM SMC/HVC mailbox
Message-ID: <20190909164208.6605054e@donnerap.cambridge.arm.com>
In-Reply-To: <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
        <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 03:02:58 +0000
Peng Fan <peng.fan@nxp.com> wrote:

Hi,

sorry for the late reply, eventually managed to have a closer look on this.

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

This maximum sounds rather arbitrary. Why do we need one? In the driver this just allocates more memory, so why not just impose no artificial limit at all?

Actually, do we need this property at all? Can't we just rely on the size of arm,func-ids to determine this (using of_property_count_elems_of_size() in the driver)? Having both sounds redundant and brings up the question what to do if they don't match.

> +
> +  method:
> +    - enum:
> +        - smc
> +        - hvc
> +
> +  transports:
> +    - enum:
> +        - mem
> +        - reg

Shouldn't there be a description on what both mean, exactly?
For instance I would expect a list of registers to be shown for the "reg" case, and be it by referring to the ARM SMCCC.

Also looking at the driver this brings up more questions:
- Which memory does mem refer to? If this is really the means of transport, it should be referenced in this *controller* node and populated by the driver. Looking at the example below and the driver code, it actually isn't used that way, instead the memory is used and controlled by the mailbox *client*.
- What is the actual difference between the two transports? For "mem" we just populate the registers with 0, for "reg" we use the data. Couldn't this be left to the client?

There are more points which makes me think this property is actually redundant, see my comments on patch 2/2.

> +
> +  arm,func-ids:
> +    description: |
> +      An array of 32-bit values specifying the function IDs used by each
> +      mailbox channel. Those function IDs follow the ARM SMC calling
> +      convention standard [1].
> +
> +      There is one identifier per channel and the number of supported
> +      channels is determined by the length of this array.

I think this makes it obvious that arm,num-chans is not needed.

Also this somewhat contradicts the driver implementation, which allows the array to be shorter, marking this as UINT_MAX and later on using the first data item as a function identifier. This is somewhat surprising and not documented (unless I missed something).

So I would suggest:
- We drop the transports property, and always put the client provided data in the registers, according to the SMCCC. Document this here.
  A client not needing those could always puts zeros (or garbage) in there, the respective firmware would just ignore the registers.
- We drop "arm,num-chans", as this is just redundant with the length of the func-ids array.
- We don't impose an arbitrary limit on the number of channels. From the firmware point of view this is just different function IDs, from Linux' point of view just the size of the memory used. Both don't need to be limited artificially IMHO.
- We mark arm,func-ids as required, as this needs to be fixed, allocated number.

For the question of "always one channel per controller" vs. "allow multiple channels per controller": I don't really have a strong opinion, but lean towards allowing multiple channels. This would allow to group functions belonging together, separating them from totally distinct controller uses (think virtual GPIO vs. SCMI).
And it would still allow the special case of multiple single-channel controllers to be naturally specified.

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

According to the above description arm,func-ids would also be required?

Cheers,
Andre.

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

