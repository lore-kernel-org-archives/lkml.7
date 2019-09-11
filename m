Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DE2C49ED9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F76B2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdyi2X6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfIKCoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 22:44:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37552 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfIKCoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:44:24 -0400
Received: by mail-io1-f67.google.com with SMTP id r4so42388698iop.4;
        Tue, 10 Sep 2019 19:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tpmd4s87/SLkLb8E8kOjEIQTqrfm/vOEY+B+rLuuG44=;
        b=qdyi2X6bwwHCXJ+qW+lzy8gdokKC1xm6E0cMPkCpNi8h1KMab5j+wAfnd4IN/nhoZP
         LUbbF+6h1z9jx592a34+SkpSF2sx9ph9BH5LABjIxiOAIxQ8in0jefIsQHgF6kK1OfCz
         ZLsiq9xcESnWBvP2tgHNoBd6SCsdD1ib2zpnvAitj30HjVJmFlRW+iUU+VitSZG/foJX
         BfbFOTWOyNZXDSHRd/AfpkJFKuZvoMbGRkyezvUPHiDDDi1qpLQ8JNXPTV5fnecDtDdL
         99+j2UYHuEW9gh7jg5cu8tGXE4yiFOQz1/KVnHYnzcMObVFCAGV4L0+BWLPIAJMSoCmF
         HnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tpmd4s87/SLkLb8E8kOjEIQTqrfm/vOEY+B+rLuuG44=;
        b=BRnGKYFAGlSMstX5dPFQ7GI92Zd9vwLM7kfEDTrJvTO7TLA7kP7kvjhsDQGWeMJJ9q
         FOpJwc7uZ+xcC0jTLIyYmep6FfA1GX6pYculSQZe3IhjgzNvoM/jxuuqT7vuimldlJzn
         WDnqoSJl4EK8p1Yac6uqPGFvBlLEl8AMDb0xUhZncRNpjbOj3WPCjhsa8GYH4hv/FWLp
         kk4HY5ASAMqEqZ8bRXf3QMc4jLC/yxih5Ymt8NWKQe9S1rklU7mx1E2dgfa9wsrH9Vd4
         wdCZ/YUfvyPmAY7xECC85pPZ8/gqRI9RbctYO2xzxxQJtxLdIupObnLrHf9jcdWMjINZ
         2GhQ==
X-Gm-Message-State: APjAAAVmAu9Fotyngwd/gvxXguROD63MTum8x8ykuf7BKdUrUnUI7U24
        sPi1dof1nuNuJjQ5UlXj/Z+CjsA68F50zeLq6Wk=
X-Google-Smtp-Source: APXvYqxC5/ICozkrWJmI5Nd/Y6JYBFqpeOItewQ2dP2xWjPVpaX1wqYKW2lq8ogSzZ3Y/VGmHATwkRhifz8pcSVmMnw=
X-Received: by 2002:a6b:e609:: with SMTP id g9mr13296099ioh.7.1568169862392;
 Tue, 10 Sep 2019 19:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com> <20190909164208.6605054e@donnerap.cambridge.arm.com>
In-Reply-To: <20190909164208.6605054e@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 10 Sep 2019 21:44:11 -0500
Message-ID: <CABb+yY2rppSOgqMy+R294d94xwi5UPR55Eo-WB8KA6m11nG3iQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
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

On Mon, Sep 9, 2019 at 10:42 AM Andre Przywara <andre.przywara@arm.com> wro=
te:
>
> On Wed, 28 Aug 2019 03:02:58 +0000
> Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi,
>
> sorry for the late reply, eventually managed to have a closer look on thi=
s.
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
> >  .../devicetree/bindings/mailbox/arm-smc.yaml       | 125 +++++++++++++=
++++++++
> >  1 file changed, 125 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.y=
aml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/D=
ocumentation/devicetree/bindings/mailbox/arm-smc.yaml
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
> > +  This mailbox uses the ARM smc (secure monitor call) and hvc (hypervi=
sor
> > +  call) instruction to trigger a mailbox-connected activity in firmwar=
e,
> > +  executing on the very same core as the caller. By nature this operat=
ion
> > +  is synchronous and this mailbox provides no way for asynchronous mes=
sages
> > +  to be delivered the other way round, from firmware to the OS, but
> > +  asynchronous notification could also be supported. However the value=
 of
> > +  r0/w0/x0 the firmware returns after the smc call is delivered as a r=
eceived
> > +  message to the mailbox framework, so a synchronous communication can=
 be
> > +  established, for a asynchronous notification, no value will be retur=
ned.
> > +  The exact meaning of both the action the mailbox triggers as well as=
 the
> > +  return value is defined by their users and is not subject to this bi=
nding.
> > +
> > +  One use case of this mailbox is the SCMI interface, which uses share=
d memory
> > +  to transfer commands and parameters, and a mailbox to trigger a func=
tion
> > +  call. This allows SoCs without a separate management processor (or w=
hen
> > +  such a processor is not available or used) to use this standardized
> > +  interface anyway.
> > +
> > +  This binding describes no hardware, but establishes a firmware inter=
face.
> > +  Upon receiving an SMC using one of the described SMC function identi=
fiers,
> > +  the firmware is expected to trigger some mailbox connected functiona=
lity.
> > +  The communication follows the ARM SMC calling convention.
> > +  Firmware expects an SMC function identifier in r0 or w0. The support=
ed
> > +  identifiers are passed from consumers, or listed in the the arm,func=
-ids
> > +  properties as described below. The firmware can return one value in
> > +  the first SMC result register, it is expected to be an error value,
> > +  which shall be propagated to the mailbox client.
> > +
> > +  Any core which supports the SMC or HVC instruction can be used, as l=
ong as
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
>
> This maximum sounds rather arbitrary. Why do we need one? In the driver t=
his just allocates more memory, so why not just impose no artificial limit =
at all?
>
This will be gone, once the driver is converted to 1channel per controller.

> Actually, do we need this property at all? Can't we just rely on the size=
 of arm,func-ids to determine this (using of_property_count_elems_of_size()=
 in the driver)? Having both sounds redundant and brings up the question wh=
at to do if they don't match.
>

> > +
> > +  method:
> > +    - enum:
> > +        - smc
> > +        - hvc
> > +
> > +  transports:
> > +    - enum:
> > +        - mem
> > +        - reg
>
> Shouldn't there be a description on what both mean, exactly?
> For instance I would expect a list of registers to be shown for the "reg"=
 case, and be it by referring to the ARM SMCCC.
>
> Also looking at the driver this brings up more questions:
> - Which memory does mem refer to? If this is really the means of transpor=
t, it should be referenced in this *controller* node and populated by the d=
river. Looking at the example below and the driver code, it actually isn't =
used that way, instead the memory is used and controlled by the mailbox *cl=
ient*.
> - What is the actual difference between the two transports? For "mem" we =
just populate the registers with 0, for "reg" we use the data. Couldn't thi=
s be left to the client?
>
> There are more points which makes me think this property is actually redu=
ndant, see my comments on patch 2/2.
>
> > +
> > +  arm,func-ids:
> > +    description: |
> > +      An array of 32-bit values specifying the function IDs used by ea=
ch
> > +      mailbox channel. Those function IDs follow the ARM SMC calling
> > +      convention standard [1].
> > +
> > +      There is one identifier per channel and the number of supported
> > +      channels is determined by the length of this array.
>
> I think this makes it obvious that arm,num-chans is not needed.
>
> Also this somewhat contradicts the driver implementation, which allows th=
e array to be shorter, marking this as UINT_MAX and later on using the firs=
t data item as a function identifier. This is somewhat surprising and not d=
ocumented (unless I missed something).
>
> So I would suggest:
> - We drop the transports property, and always put the client provided dat=
a in the registers, according to the SMCCC. Document this here.
>   A client not needing those could always puts zeros (or garbage) in ther=
e, the respective firmware would just ignore the registers.
> - We drop "arm,num-chans", as this is just redundant with the length of t=
he func-ids array.
> - We don't impose an arbitrary limit on the number of channels. From the =
firmware point of view this is just different function IDs, from Linux' poi=
nt of view just the size of the memory used. Both don't need to be limited =
artificially IMHO.
>
Sounds like we are in sync.

> - We mark arm,func-ids as required, as this needs to be fixed, allocated =
number.
>
I still think func-id can be done without. A client can always pass
the value as it knows what it expects. But I can live with it being
optional.

cheers!
