Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E6C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD5F23402
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567434019;
	bh=AxTJX4Sy34LCyqEsH+WI/Hwf5ujI35RSWIvy9oMh8Wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rA2r+5iJwE0p7sh5iaNxlDyaqkpaQ/lSROYXtLbtiM/TUuRlFxC5lNYUDijwCpVQs
	 AxzKQqMaU1xYZh5OvOLewtnOLWOtsU/61l4rIu2ipyJPUPb5So2SmTzr/N827eNHw+
	 5pRLFfqyB2VMPfgS9wYdiUGkqp5s+8+r1X3s2sMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfIBOUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731097AbfIBOUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:20:18 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA9ED21883;
        Mon,  2 Sep 2019 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567434012;
        bh=AxTJX4Sy34LCyqEsH+WI/Hwf5ujI35RSWIvy9oMh8Wc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L2Blockz7/DoqZgkB8u4vX6tVvN7EVnrZ0r2H/VY0IsukXWuTe0ncWyvirv5atV4w
         UEUAdLuod8c9cPTqWimDKIokQKFtTOUdbmF5F0omUdbfF/SL1fKWn/pVq1n0kutMBX
         8xBC2rf1gZpeXsOLZNES3F/sI2JafMqN6YGFyNAU=
Received: by mail-qk1-f177.google.com with SMTP id g17so12612741qkk.8;
        Mon, 02 Sep 2019 07:20:12 -0700 (PDT)
X-Gm-Message-State: APjAAAW27+Ez2AwPogxjAb06G9fzWpnH+C+svmVUkUdCYlOW0Gh3wyRl
        1iTF9DgNF2CzH3z6HlF3X069sV4Ful2xDGqmZg==
X-Google-Smtp-Source: APXvYqxPGBMJIHE3Wdp0ctZv+Wz/CJn+h36vN88vdviYdDNQU98hoWVWliq0ENL5YpSo9mfe/J4UK3cWrQaTNxP86zY=
X-Received: by 2002:a05:620a:1356:: with SMTP id c22mr9452576qkl.119.1567434011842;
 Mon, 02 Sep 2019 07:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com> <5d6d1b86.1c69fb81.f86b5.3988@mx.google.com>
In-Reply-To: <5d6d1b86.1c69fb81.f86b5.3988@mx.google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Sep 2019 15:20:00 +0100
X-Gmail-Original-Message-ID: <CAL_JsqLauLbgVg=Aguebqk3q6e+BOxiMNJ+xqTgkmpAjOh8BpA@mail.gmail.com>
Message-ID: <CAL_JsqLauLbgVg=Aguebqk3q6e+BOxiMNJ+xqTgkmpAjOh8BpA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
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

On Mon, Sep 2, 2019 at 2:39 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Aug 28, 2019 at 03:02:58AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
> > actions in software layers running in the EL2 or EL3 exception levels.
> > The term "ARM" here relates to the SMC instruction as part of the ARM
> > instruction set, not as a standard endorsed by ARM Ltd.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/mailbox/arm-smc.yaml       | 125 +++++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> > new file mode 100644
> > index 000000000000..f8eb28d5e307
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/arm-smc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM SMC Mailbox Interface
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +description: |
> > +  This mailbox uses the ARM smc (secure monitor call) and hvc (hypervisor
> > +  call) instruction to trigger a mailbox-connected activity in firmware,
> > +  executing on the very same core as the caller. By nature this operation
> > +  is synchronous and this mailbox provides no way for asynchronous messages
> > +  to be delivered the other way round, from firmware to the OS, but
> > +  asynchronous notification could also be supported. However the value of
> > +  r0/w0/x0 the firmware returns after the smc call is delivered as a received
> > +  message to the mailbox framework, so a synchronous communication can be
> > +  established, for a asynchronous notification, no value will be returned.
> > +  The exact meaning of both the action the mailbox triggers as well as the
> > +  return value is defined by their users and is not subject to this binding.
> > +
> > +  One use case of this mailbox is the SCMI interface, which uses shared memory
> > +  to transfer commands and parameters, and a mailbox to trigger a function
> > +  call. This allows SoCs without a separate management processor (or when
> > +  such a processor is not available or used) to use this standardized
> > +  interface anyway.
> > +
> > +  This binding describes no hardware, but establishes a firmware interface.
> > +  Upon receiving an SMC using one of the described SMC function identifiers,
> > +  the firmware is expected to trigger some mailbox connected functionality.
> > +  The communication follows the ARM SMC calling convention.
> > +  Firmware expects an SMC function identifier in r0 or w0. The supported
> > +  identifiers are passed from consumers, or listed in the the arm,func-ids
> > +  properties as described below. The firmware can return one value in
> > +  the first SMC result register, it is expected to be an error value,
> > +  which shall be propagated to the mailbox client.
> > +
> > +  Any core which supports the SMC or HVC instruction can be used, as long as
> > +  a firmware component running in EL3 or EL2 is handling these calls.
> > +
> > +properties:
> > +  compatible:
> > +    const: arm,smc-mbox
> > +
> > +  "#mbox-cells":
> > +    const: 1
> > +
> > +  arm,num-chans:
> > +    description: The number of channels supported.
> > +    items:
> > +      minimum: 1
> > +      maximum: 4096 # Should be enough?
> > +
> > +  method:
> > +    - enum:
>
> Did you build this with 'make dt_binding_check' as this should be a
> warning. This should not be a list entry (i.e. drop the '-').
>
> > +        - smc
> > +        - hvc
> > +
> > +  transports:
>
> arm,transports
>
> > +    - enum:
> > +        - mem
> > +        - reg
> > +
> > +  arm,func-ids:
> > +    description: |
> > +      An array of 32-bit values specifying the function IDs used by each
> > +      mailbox channel. Those function IDs follow the ARM SMC calling
> > +      convention standard [1].
> > +
> > +      There is one identifier per channel and the number of supported
> > +      channels is determined by the length of this array.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array

Also, this doesn't work. You need:

allOf:
  - $ref: /schemas/types.yaml#/definitions/uint32-array

> > +    minItems: 0
> > +    maxItems: 4096   # Should be enough?
