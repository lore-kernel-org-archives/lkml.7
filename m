Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120EBC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBFB21848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfIQRb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:31:29 -0400
Received: from foss.arm.com ([217.140.110.172]:59466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfIQRb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:31:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F1F41000;
        Tue, 17 Sep 2019 10:31:28 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADA973F575;
        Tue, 17 Sep 2019 10:31:26 -0700 (PDT)
Date:   Tue, 17 Sep 2019 18:31:15 +0100
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
Subject: Re: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the
 ARM SMC/HVC mailbox
Message-ID: <20190917183115.3e40180f@donnerap.cambridge.arm.com>
In-Reply-To: <1568626884-5189-2-git-send-email-peng.fan@nxp.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
        <1568626884-5189-2-git-send-email-peng.fan@nxp.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019 09:44:37 +0000
Peng Fan <peng.fan@nxp.com> wrote:

Hi,

> From: Peng Fan <peng.fan@nxp.com>
> 
> The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/arm-smc.yaml       | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> new file mode 100644
> index 000000000000..bf01bec035fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> @@ -0,0 +1,96 @@
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

I think "or" instead of "and" is less confusing.

> +  call) instruction to trigger a mailbox-connected activity in firmware,
> +  executing on the very same core as the caller. The value of r0/w0/x0
> +  the firmware returns after the smc call is delivered as a received
> +  message to the mailbox framework, so synchronous communication can be
> +  established. The exact meaning of the action the mailbox triggers as
> +  well as the return value is defined by their users and is not subject
> +  to this binding.
> +
> +  One use case of this mailbox is the SCMI interface, which uses shared

     One example use case of this mailbox ...
(to make it more obvious that it's not restricted to this)

> +  memory to transfer commands and parameters, and a mailbox to trigger a
> +  function call. This allows SoCs without a separate management processor
> +  (or when such a processor is not available or used) to use this
> +  standardized interface anyway.
> +
> +  This binding describes no hardware, but establishes a firmware interface.
> +  Upon receiving an SMC using one of the described SMC function identifiers,

                             ... the described SMC function identifier,

> +  the firmware is expected to trigger some mailbox connected functionality.
> +  The communication follows the ARM SMC calling convention.
> +  Firmware expects an SMC function identifier in r0 or w0. The supported
> +  identifiers are passed from consumers,

     identifier

"passed from consumers": How? Where?
But I want to repeat: We should not allow this. This is a binding for a mailbox controller driver, not a generic firmware backdoor.
We should be as strict as possible to avoid any security issues.
The firmware certainly knows the function ID it implements. The firmware controls the DT. So it is straight-forward to put the ID into the DT. The firmware could even do this at boot time, dynamically, before passing on the DT to the non-secure world (bootloader or kernel).

What would be the use case of this functionality?

> or listed in the the arm,func-ids

                       arm,func-id

> +  properties as described below. The firmware can return one value in

     property

> +  the first SMC result register, it is expected to be an error value,
> +  which shall be propagated to the mailbox client.
> +
> +  Any core which supports the SMC or HVC instruction can be used, as long
> +  as a firmware component running in EL3 or EL2 is handling these calls.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description:
> +          For implementations using ARM SMC instruction.
> +        const: arm,smc-mbox
> +
> +      - description:
> +          For implementations using ARM HVC instruction.
> +        const: arm,hvc-mbox

I am not particularly happy with this, but well ...

> +
> +  "#mbox-cells":
> +    const: 1

Why is this "1"? What is this number used for? It used to be the channel ID, but since you are describing a single channel controller only, this should be 0 now.

> +
> +  arm,func-id:
> +    description: |
> +      An 32-bit value specifying the function ID used by the mailbox.

         A single 32-bit value ...

> +      The function ID follow the ARM SMC calling convention standard [1].

                         follows

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - "#mbox-cells"
> +
> +examples:
> +  - |
> +    sram@93f000 {
> +      compatible = "mmio-sram";
> +      reg = <0x0 0x93f000 0x0 0x1000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0x0 0x93f000 0x1000>;
> +
> +      cpu_scp_lpri: scp-shmem@0 {
> +        compatible = "arm,scmi-shmem";
> +        reg = <0x0 0x200>;
> +      };
> +    };
> +
> +    smc_tx_mbox: tx_mbox {
> +      #mbox-cells = <1>;

As mentioned above, should be 0.

> +      compatible = "arm,smc-mbox";
> +      /* optional */

First: having "optional" in a specific example is not helpful, just confusing.
Second: It is actually *not* optional in this case, as there is no other way of propagating the function ID. The SCMI driver as the mailbox client has certainly no clue about this.
I think I said this previously: Relying on the mailbox client to pass the function ID sounds broken, as this is a property of the mailbox controller driver. The mailbox client does not care about this mailbox communication detail, it just wants to trigger the mailbox.

> +      arm,func-id = <0xc20000fe>;
> +    };
> +
> +    firmware {
> +      scmi {
> +        compatible = "arm,scmi";
> +        mboxes = <&smc_tx_mbox 0>;

... and here just <&smc_tx_mbox>; would suffice.

> +        mbox-names = "tx";
> +        shmem = <&cpu_scp_lpri>;
> +      };
> +    };
> +
> +...

Cheers,
Andre.
