Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CE2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE55A2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW6d35dc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfFTQ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:27:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42410 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfFTQ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:27:31 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so2142736ior.9;
        Thu, 20 Jun 2019 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CX8s9WxO1kjnOx1IAEplfhAOdKpdfU5oisESF2S2i2s=;
        b=hW6d35dcH66VjSndHulXY8mLQ+4hFxOw0xq3JUzSx8xgA2yrP3QsqGercEeUzzVABP
         3TUXmjzoz69MygoW2fqLQ+WFVVg4gAPHkyyrbquwuEGnXa9AfcjyamuERw6SlrNY4Oss
         pxAicTcXQa1JY3uZ0ia9yjSXFtgujqrQKxnCgMzdApBPL2bzCo7ZCAL6P+gqucikXmTj
         WNbzVKMcRcV/Q5DvQzCf82P12btX94yjaZtC9WaCmaOwWVbCbCZ/hp9M0s4QQdSOMShV
         /Hgtud6VdargFmwxxr2DhXQCTXYdGcfcUAMVgxwCibGSLFbkcALOXSF+qRCbZjTKgZBu
         Tt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CX8s9WxO1kjnOx1IAEplfhAOdKpdfU5oisESF2S2i2s=;
        b=aDCoS1AuRlLcGranhqw+6cxqNAU0nG9gnWBTdPa96QDK1zIIUHOEK2epnVP3focScN
         2wofL+apm9K1jXtnTKF6tP2chPKK+yd7lgTvUsnCSjUU3kuwP8Mk3Hqi1eJ9Lh3fmiEk
         EXO7l5UJKUGu0PdSPraQljg765a+QL53Q4EPODs6Z3bt1Wdwwra7lCRbkQuTwh1B7eqZ
         yzPsFoUaxjv+hT+ZJ7gH8usu9ExtlRdnWtfLhH2r2xXLdjsIEgFJdh9htNk1rfRXG835
         FJNqTC1HLgc9ro59Xf547LNN3wiH+HbxSaERHPwXyYnhXSJYEoIZ5h5z4Ia8g60SX6sW
         Bc7g==
X-Gm-Message-State: APjAAAU49d7ptPjEXn7C691tuM1N4Gjvq4R9iybiHO5IovXYCoS5uvxk
        7l6QPpZalZ10UMr89nkmwjmrfO3UO2G4KiL4LCA=
X-Google-Smtp-Source: APXvYqxIITI45eune2WDDNkDTdi9twqEa5g2nyH4P6h6nRs/ZfqhK7dpjVB/YYaNuTFCPikSAFjVk7xftozqQGfvaS0=
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr11763289ion.239.1561048049928;
 Thu, 20 Jun 2019 09:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190603083005.4304-1-peng.fan@nxp.com> <20190603083005.4304-2-peng.fan@nxp.com>
 <20190620092241.GC1248@e107155-lin> <20190620171319.13dae226@donnerap.cambridge.arm.com>
In-Reply-To: <20190620171319.13dae226@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 20 Jun 2019 11:27:19 -0500
Message-ID: <CABb+yY0teBHHdtOFz6-ab3v2C2z39=t09XwL+=FKSp=ogQGENQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC mailbox
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, festevam@gmail.com,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, van.freenix@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:13 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Thu, 20 Jun 2019 10:22:41 +0100
> Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> > On Mon, Jun 03, 2019 at 04:30:04PM +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The ARM SMC mailbox binding describes a firmware interface to trigger
> > > actions in software layers running in the EL2 or EL3 exception levels.
> > > The term "ARM" here relates to the SMC instruction as part of the ARM
> > > instruction set, not as a standard endorsed by ARM Ltd.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > > Introduce interrupts as a property.
> > >
> > > V1:
> > > arm,func-ids is still kept as an optional property, because there is no
> > > defined SMC funciton id passed from SCMI. So in my test, I still use
> > > arm,func-ids for ARM SIP service.
> > >
> > >  .../devicetree/bindings/mailbox/arm-smc.txt        | 101 +++++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > new file mode 100644
> > > index 000000000000..401887118c09
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > @@ -0,0 +1,101 @@
> > > +ARM SMC Mailbox Interface
> > > +=========================
> > > +
> > > +This mailbox uses the ARM smc (secure monitor call) instruction to trigger
> > > +a mailbox-connected activity in firmware, executing on the very same core
> > > +as the caller. By nature this operation is synchronous and this mailbox
> > > +provides no way for asynchronous messages to be delivered the other way
> > > +round, from firmware to the OS, but asynchronous notification could also
> > > +be supported. However the value of r0/w0/x0 the firmware returns after
> > > +the smc call is delivered as a received message to the mailbox framework,
> > > +so a synchronous communication can be established, for a asynchronous
> > > +notification, no value will be returned. The exact meaning of both the
> > > +action the mailbox triggers as well as the return value is defined by
> > > +their users and is not subject to this binding.
> > > +
> > > +One use case of this mailbox is the SCMI interface, which uses shared memory
> > > +to transfer commands and parameters, and a mailbox to trigger a function
> > > +call. This allows SoCs without a separate management processor (or when
> > > +such a processor is not available or used) to use this standardized
> > > +interface anyway.
> > > +
> > > +This binding describes no hardware, but establishes a firmware interface.
> > > +Upon receiving an SMC using one of the described SMC function identifiers,
> > > +the firmware is expected to trigger some mailbox connected functionality.
> > > +The communication follows the ARM SMC calling convention[1].
> > > +Firmware expects an SMC function identifier in r0 or w0. The supported
> > > +identifiers are passed from consumers, or listed in the the arm,func-ids
> > > +properties as described below. The firmware can return one value in
> > > +the first SMC result register, it is expected to be an error value,
> > > +which shall be propagated to the mailbox client.
> > > +
> > > +Any core which supports the SMC or HVC instruction can be used, as long as
> > > +a firmware component running in EL3 or EL2 is handling these calls.
> > > +
> > > +Mailbox Device Node:
> > > +====================
> > > +
> > > +This node is expected to be a child of the /firmware node.
> > > +
> > > +Required properties:
> > > +--------------------
> > > +- compatible:              Shall be "arm,smc-mbox"
> > > +- #mbox-cells              Shall be 1 - the index of the channel needed.
> > > +- arm,num-chans            The number of channels supported.
> > > +- method:          A string, either:
> > > +                   "hvc": if the driver shall use an HVC call, or
> > > +                   "smc": if the driver shall use an SMC call.
> > > +
> > > +Optional properties:
> > > +- arm,func-ids             An array of 32-bit values specifying the function
> > > +                   IDs used by each mailbox channel. Those function IDs
> > > +                   follow the ARM SMC calling convention standard [1].
> > > +                   There is one identifier per channel and the number
> > > +                   of supported channels is determined by the length
> > > +                   of this array.
> > > +- interrupts               SPI interrupts may be listed for notification,
> > > +                   each channel should use a dedicated interrupt
> > > +                   line.
> > > +
> >
> > I think SMC mailbox as mostly unidirectional/Tx only channel. And the
> > interrupts here as stated are for notifications, so I prefer to keep
> > them separate channel. I assume SMC call return indicates completion.
> > Or do you plan to use these interrupts as the indication for completion
> > of the command? I see in patch 2/2 the absence of IRQ is anyway dealt
> > the way I mention above.
> >
> > Does it make sense or am I missing something here ?
>
> I think you are right. From a mailbox point of view "completion" means
> that the trigger has reached the other side. A returning smc call is a
> perfect indication of this fact.
>
Yes. mailbox only cares about message delivery.

> Whether the action triggered by this
> mailbox command has completed is a totally separate question and out of
> the scope of the mailbox.
>
Yes, whether the message is accepted/rejected at protocol level is a
matter of upper layer (protocol).

> This should be handled by a higher level
> protocol (SCPI in this case). Which could mean that this employs a
> separate return mailbox channel, which is RX only and implemented by
> interrupts. Which could or could not be part of this driver.
>
Any message received over the same class of channel should be handled
in this driver.

Cheers
