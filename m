Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27562C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDF62186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566911642;
	bh=n8ibduXjZXj7Q34xh0Rv5sPDq7/16sV0kGKVNRLgDSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S2vJqzwEUsO9edVK87jE5X/398DstalYsOUd/aJA7JSHE11sdoxdKxFHA8aSkz0S3
	 u3X7REY13MWMcKIqfdYslLNtGZpjFlkzwRQWf03vyQULbC8DCXze54TXUuCWKm/WPT
	 xOAnAQebJNeUKoyHX6So1KEpJ6BcHXKXvLHsNAO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfH0NOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0NOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:14:00 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56FC8214DA;
        Tue, 27 Aug 2019 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566911639;
        bh=n8ibduXjZXj7Q34xh0Rv5sPDq7/16sV0kGKVNRLgDSs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lSNV9HxRdPa/5Ef56wsJ6JYR5Xjq4MdznNNx74DNIz4MOmTAVYNQsoy+Xu1Lk6dBW
         sRVBzin4qJyRoLxOuwFBdMs0YnPpXYwVMWlj8/onYqVPNA/0l4oiiK+0vfrDuiYGNu
         ApTb/71j0CI5hh9Pqi6kf6tBHis1MHAWXGOJnjS4=
Received: by mail-qt1-f169.google.com with SMTP id v38so21222232qtb.0;
        Tue, 27 Aug 2019 06:13:59 -0700 (PDT)
X-Gm-Message-State: APjAAAXNNekc+55DYTYP+RnHJklthMwY4Xi5p5hEw43CAFHMES+cdPFe
        /h19I9sO5CVXGANRjBGFp0bmjJI0eEjVVx/NXQ==
X-Google-Smtp-Source: APXvYqxM4rKSeMsRFJ0k2CX54SJt1oCxc9GdiuyJ73RX+TOjoI7sPcD0/x/mVMxp/Tq4eyB0bRsd2oxqjdCHpUHNzIA=
X-Received: by 2002:a0c:eb92:: with SMTP id x18mr20029210qvo.39.1566911638442;
 Tue, 27 Aug 2019 06:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <1566942646-18015-1-git-send-email-peng.fan@nxp.com> <1566942646-18015-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1566942646-18015-2-git-send-email-peng.fan@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Aug 2019 08:13:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK7xPTYFzSXt52m+Z0LRcFy2TUfa45XzY1YGH0-JRA-WQ@mail.gmail.com>
Message-ID: <CAL_JsqK7xPTYFzSXt52m+Z0LRcFy2TUfa45XzY1YGH0-JRA-WQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 4:51 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/arm-smc.yaml       | 126 +++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> new file mode 100644
> index 000000000000..ae677e0c0910
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> @@ -0,0 +1,126 @@
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
> +     minimum: 1
> +     maximum: 4096 # Should be enough?
> +
> +  method:
> +    items:

You can drop 'items' as this is a single entry.

> +      - enum:
> +          - smc
> +          - hvc
> +
> +  transports:
> +    items:

same here

> +      - enum:
> +          - mem
> +          - reg
> +
> +  arm,func-ids:

Needs a $ref to a type (uint32-array).

> +    description: |
> +      An array of 32-bit values specifying the function IDs used by each
> +      mailbox channel. Those function IDs follow the ARM SMC calling
> +      convention standard [1].
> +
> +      There is one identifier per channel and the number of supported
> +      channels is determined by the length of this array.
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
> +        cpu_scp_lpri: scp-shmem@0 {

Looks like some indentation problem...

> +          compatible = "arm,scmi-shmem";
> +          reg = <0x0 0x200>;
> +        };
> +
> +        cpu_scp_hpri: scp-shmem@200 {
> +          compatible = "arm,scmi-shmem";
> +          reg = <0x200 0x200>;
> +        };
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
> +        mboxes = <&mailbox 0 &mailbox 1>;

&smc_mbox and <> each entry.

> +        mbox-names = "tx", "rx";
> +        shmem = <&cpu_scp_lpri &cpu_scp_hpri>;

<> each entry

> +      };
> +    };
> +
> +...
> --
> 2.16.4
>
