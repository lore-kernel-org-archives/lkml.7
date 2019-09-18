Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA58C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2025521920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMp8M65K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfIRF1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:27:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42470 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfIRF1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:27:13 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so13190319iod.9;
        Tue, 17 Sep 2019 22:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aeBpu/wksCT1eq18uEHm7Scq/w+GtocYUT2tO+t26F0=;
        b=vMp8M65KRUlfeZGbM54vJnl7+FvdUgmmaWesiZcW/q5UdEYhMJ7/Ty2eSltd8PLGSm
         DMt9o6GCsyfy3wpiL2IhV8AYWGbVyBNDanNECOSoSnTx/ieDAogDlwXNWc0rblN/BaYV
         ttRlnUfsJkyh//HvGDaFJUe+kU04vclfJWM8DxfpdxlJ6DJe7c7Mf2rMQsGlwpzlGg9f
         QtAzpUp4zU1DzfVu/0TE1p1ELMAe4qFJ2ItweEowoOecSsUhBMZfZCoGzZEGcQiCbUTP
         7o6+6ufAfQhqGuB6oLJClyXQFUmCXq82COD21jB54iRw9pvuRDD302YxWCd9GIek2E7Z
         k/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aeBpu/wksCT1eq18uEHm7Scq/w+GtocYUT2tO+t26F0=;
        b=qSW69W2hhXGAn8ZOgjzc6Z3MiWuBJvx8MN5vCZ7KIXve1jFM1Ozn79B/aJHKeSXnle
         QoiFDlBgReijTIn1EWcY8sLl2rkH3SNGn+Qeiq5u61VzeWvSANehpr19KwtRbnWYpj66
         mGls7jgcX6wyqLw0Q4kaxG10KwFzeZjtOYlxqqt5sWYhPA/Hlf+5uVf3AViQgA+nM9bB
         92jogM0fL1uuaO+FmBgcynT2P4bO7HLBclf0MN4Hu2Ubvv/8wca2+a8uUkAmd6HbXuB1
         iCVnVjZATAy4aRmpOCjgmHm0ks5J41J+71JtK/xKSiJZeXoCmPfROC+qTahzu41QH9Tu
         ZMOg==
X-Gm-Message-State: APjAAAUbzIIzrZ+7H/7UCfb2dcr4yyZSKLadnVcIr2stSzCUJ6whGm7+
        ZIqB/vpfvYA6zoRtUrdXkOzp5EVzQq9ymS7mIZw=
X-Google-Smtp-Source: APXvYqx5XSrUtThjRZDoB5Q++Oj4nDBjUDfWVblqDIj6KUhujZbYc3JJ8XIGjEO/QXyyA5B6D207fuaYBXrQI9oxlIY=
X-Received: by 2002:a5d:8a0f:: with SMTP id w15mr3299161iod.239.1568784431907;
 Tue, 17 Sep 2019 22:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
 <1568626884-5189-2-git-send-email-peng.fan@nxp.com> <20190917183115.3e40180f@donnerap.cambridge.arm.com>
In-Reply-To: <20190917183115.3e40180f@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 18 Sep 2019 00:27:00 -0500
Message-ID: <CABb+yY2CP1i9fZMoPua=-mLCUpYrcO28xF5UXDeRD2XTYe7mEg@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 12:31 PM Andre Przywara <andre.przywara@arm.com> wr=
ote:
>
> On Mon, 16 Sep 2019 09:44:37 +0000
> Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi,
>
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The ARM SMC/HVC mailbox binding describes a firmware interface to trigg=
er
> > actions in software layers running in the EL2 or EL3 exception levels.
> > The term "ARM" here relates to the SMC instruction as part of the ARM
> > instruction set, not as a standard endorsed by ARM Ltd.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/mailbox/arm-smc.yaml       | 96 ++++++++++++++=
++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.y=
aml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/D=
ocumentation/devicetree/bindings/mailbox/arm-smc.yaml
> > new file mode 100644
> > index 000000000000..bf01bec035fc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> > @@ -0,0 +1,96 @@
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
> > +  This mailbox uses the ARM smc (secure monitor call) and hvc (hypervi=
sor
>
> I think "or" instead of "and" is less confusing.
>
> > +  call) instruction to trigger a mailbox-connected activity in firmwar=
e,
> > +  executing on the very same core as the caller. The value of r0/w0/x0
> > +  the firmware returns after the smc call is delivered as a received
> > +  message to the mailbox framework, so synchronous communication can b=
e
> > +  established. The exact meaning of the action the mailbox triggers as
> > +  well as the return value is defined by their users and is not subjec=
t
> > +  to this binding.
> > +
> > +  One use case of this mailbox is the SCMI interface, which uses share=
d
>
>      One example use case of this mailbox ...
> (to make it more obvious that it's not restricted to this)
>
> > +  memory to transfer commands and parameters, and a mailbox to trigger=
 a
> > +  function call. This allows SoCs without a separate management proces=
sor
> > +  (or when such a processor is not available or used) to use this
> > +  standardized interface anyway.
> > +
> > +  This binding describes no hardware, but establishes a firmware inter=
face.
> > +  Upon receiving an SMC using one of the described SMC function identi=
fiers,
>
>                              ... the described SMC function identifier,
>
> > +  the firmware is expected to trigger some mailbox connected functiona=
lity.
> > +  The communication follows the ARM SMC calling convention.
> > +  Firmware expects an SMC function identifier in r0 or w0. The support=
ed
> > +  identifiers are passed from consumers,
>
>      identifier
>
> "passed from consumers": How? Where?
> But I want to repeat: We should not allow this.
> This is a binding for a mailbox controller driver, not a generic firmware=
 backdoor.
>
Exactly. The mailbox controller here is the  SMC/HVC instruction,
which needs 9 arguments to work. The fact that the fist argument is
always going to be same on a platform is just the way we use this
instruction.

> We should be as strict as possible to avoid any security issues.
>
Any example of such a security issue?

> The firmware certainly knows the function ID it implements. The firmware =
controls the DT. So it is straight-forward to put the ID into the DT. The f=
irmware could even do this at boot time, dynamically, before passing on the=
 DT to the non-secure world (bootloader or kernel).
>
> What would be the use case of this functionality?
>
At least for flexibility and consistency.

> > or listed in the the arm,func-ids
>
>                        arm,func-id
>
> > +  properties as described below. The firmware can return one value in
>
>      property
>
> > +  the first SMC result register, it is expected to be an error value,
> > +  which shall be propagated to the mailbox client.
> > +
> > +  Any core which supports the SMC or HVC instruction can be used, as l=
ong
> > +  as a firmware component running in EL3 or EL2 is handling these call=
s.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description:
> > +          For implementations using ARM SMC instruction.
> > +        const: arm,smc-mbox
> > +
> > +      - description:
> > +          For implementations using ARM HVC instruction.
> > +        const: arm,hvc-mbox
>
> I am not particularly happy with this, but well ...
>
> > +
> > +  "#mbox-cells":
> > +    const: 1
>
> Why is this "1"? What is this number used for? It used to be the channel =
ID, but since you are describing a single channel controller only, this sho=
uld be 0 now.
>
Yes. I overlooked it and actually queued the patch for pull request.
But I think the bindings should not carry a 'fix' patch later. Also I
realise this revision of binding hasn't been reviewed by Rob. Maybe I
should drop the patch for now.

> > +
> > +  arm,func-id:
> > +    description: |
> > +      An 32-bit value specifying the function ID used by the mailbox.
>
>          A single 32-bit value ...
>
> > +      The function ID follow the ARM SMC calling convention standard [=
1].
>
>                          follows
>
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +required:
> > +  - compatible
> > +  - "#mbox-cells"
> > +
> > +examples:
> > +  - |
> > +    sram@93f000 {
> > +      compatible =3D "mmio-sram";
> > +      reg =3D <0x0 0x93f000 0x0 0x1000>;
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +      ranges =3D <0x0 0x93f000 0x1000>;
> > +
> > +      cpu_scp_lpri: scp-shmem@0 {
> > +        compatible =3D "arm,scmi-shmem";
> > +        reg =3D <0x0 0x200>;
> > +      };
> > +    };
> > +
> > +    smc_tx_mbox: tx_mbox {
> > +      #mbox-cells =3D <1>;
>
> As mentioned above, should be 0.
>
> > +      compatible =3D "arm,smc-mbox";
> > +      /* optional */
>
> First: having "optional" in a specific example is not helpful, just confu=
sing.
> Second: It is actually *not* optional in this case, as there is no other =
way of propagating the function ID. The SCMI driver as the mailbox client h=
as certainly no clue about this.
> I think I said this previously: Relying on the mailbox client to pass the=
 function ID sounds broken, as this is a property of the mailbox controller=
 driver. The mailbox client does not care about this mailbox communication =
detail, it just wants to trigger the mailbox.
>
Again, the mailbox controller here is the SMC/HVC _instruction_, which
doesn't care what value the first argument carry.

Cheers!
