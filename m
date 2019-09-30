Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE36FC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A934721A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569846143;
	bh=cOLOKOmvaYLarF4Qg8rhvW+yROkM8klreFEOrduvdLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Q2L+DLlcu/4G4ccpMMgEPZJklMyZDliXIZ7bT8Ubetq4KdWf1kfqYzz/oE+QoqwC
	 rX/+WkXTrznpLuKaHSJjX52dH6MYaAoreeY34bHzX9DKKCx39KMPAl+QQ1KNuzUFX9
	 LKQ03o36bHV1c447GPDUyTp9fLn/QQ41DSvTU6kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfI3MWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfI3MWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:22:22 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6847B216F4;
        Mon, 30 Sep 2019 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569846141;
        bh=cOLOKOmvaYLarF4Qg8rhvW+yROkM8klreFEOrduvdLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QES9zpJwh+9KFJX0BeLY3ZWSYSnbZ3YWTvQwlob9ETkCKCo2RonUOPvLwJ8MlS+bx
         GgUJXK80bRROeCz/eHnG0kop+J8Lv0zFRQ/9plLGDCMNjerGT9WnJtM0nBYX+24gWH
         Pl51lx60GmdqV7jOfemEjSs2j9NlIF3S6/dKqwYc=
Received: by mail-qt1-f179.google.com with SMTP id c21so16662224qtj.12;
        Mon, 30 Sep 2019 05:22:21 -0700 (PDT)
X-Gm-Message-State: APjAAAVTM5hYqt4ztwjQui1Pyv67xF9IOmYaZbcmfQ3vqGMctXiffRjc
        RuBqIHPFOohNrXLlR2yd5WwJL4ya10nbg+lgnw==
X-Google-Smtp-Source: APXvYqzrKI+HW/IJwobAuPoIwDguHXnRcIGXqgXgPSdclcufDbGq0nnxgxQ/qGqHwmh4ZxI6ERNeBADiPKAKMSdQKvY=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr24312480qtn.110.1569846140534;
 Mon, 30 Sep 2019 05:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190923101513.32719-1-kurt@linutronix.de> <20190923101513.32719-3-kurt@linutronix.de>
 <20190927161118.GA19333@bogus> <f63da257-95b4-bcb8-9ba4-9786645caf26@prevas.dk>
In-Reply-To: <f63da257-95b4-bcb8-9ba4-9786645caf26@prevas.dk>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Sep 2019 07:22:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKZQXGtrDUiAJj+xMnYowzDdxTdvDOXTbr_n3KWMrL7_w@mail.gmail.com>
Message-ID: <CAL_JsqKZQXGtrDUiAJj+xMnYowzDdxTdvDOXTbr_n3KWMrL7_w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt/bindings: Add bindings for Layerscape external irqs
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 4:16 PM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 27/09/2019 18.11, Rob Herring wrote:
> > On Mon, Sep 23, 2019 at 12:15:13PM +0200, Kurt Kanzenbach wrote:
> >> From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> >>
> >> This adds Device Tree binding documentation for the external interrupt
> >> lines with configurable polarity present on some Layerscape SOCs.
> >>
> >> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> >> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> >> ---
> >>
> >> +* Freescale Layerscape external IRQs
> >> +
> >> +Some Layerscape SOCs (LS1021A, LS1043A, LS1046A, LS2088A) support
> >> +inverting the polarity of certain external interrupt lines.
> >> +
> >> +The device node must be a child of the node representing the
> >> +Supplemental Configuration Unit (SCFG) or the Interrupt Sampling
> >> +Control (ISC) Unit.
> >> +
> >> +Required properties:
> >> +- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
> >> +- interrupt-controller: Identifies the node as an interrupt controller
> >> +- #interrupt-cells: Must be 2. The first element is the index of the
> >> +  external interrupt line. The second element is the trigger type.
> >> +- interrupt-parent: phandle of GIC.
> >> +- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in the SCFG.
> >> +- fsl,extirq-map: Specifies the mapping to interrupt numbers in the parent
> >> +  interrupt controller. Interrupts are mapped one-to-one to parent
> >> +  interrupts.
> >
> > This should be an 'interrupt-map' instead.
>
> Rob, thanks for your review comments. I know you said the same thing at
> v5, and it might seem like they are ignored. However, I asked a couple
> of followup questions
> (https://lore.kernel.org/lkml/0bb4533d-c749-d8ff-e1f2-4b08eb724713@prevas.dk/).
> I'd really appreciate it if you could (a) point to some documentation on
> how to write that interrupt-map and (b) explain how this is different
> from the Qualcomm PDC case I tried to copy and which had your Reviewed-By.

https://www.devicetree.org/specifications/
https://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping

For QC PDC, it could be a large number of interrupts to remap which
interrupt-map doesn't scale to very well. Also, I think it sits in
parallel to the GIC rather than downstream. The interrupt binding
doesn't really have a way to express that.


> >> +Optional properties:
> >> +- fsl,bit-reverse: This boolean property should be set on the LS1021A
> >> +  if the SCFGREVCR register has been set to all-ones (which is usually
> >> +  the case), meaning that all reads and writes of SCFG registers are
> >> +  implicitly bit-reversed. Other compatible platforms do not have such
> >> +  a register.
> >
> > Couldn't you just read that register and tell?
>
> In theory, yes, but as far as I understand (and as I wrote) it's
> specific to the ls1021a. Of course one can decide whether it's
> necessary/possible to read it based on the compatible string, but one
> would also need an extra reg property to have its address - but that
> register is not really part of the extirq "device" we're trying to
> describe. So would it need to be represented as its own subnode of scfg?

Why? You should know where the register is because you know what chip
you are on (from the compatible).

>
> If it is set at all, it's done within the first few instructions after
> reset (before control is even handed to the bootloader), so I see it as
> a kind of quirk of the hardware. The data sheet says "SCFG bit reverse
> (SCFG_SCFGREVCR) must be written 0xFFFF_FFFF as a part of initialization
> sequence before writing to any other SCFG register." which, taken
> literally, means we don't need the property at all and can just assume
> it for the ls1021a (i.e., do it based on compatible string alone) - but
> I think it should be read as "if you're going to write this register, it
> must be done first thing".
>
> > Does this apply to only the extirq register or all of scfg?
>
> All of scfg. It really seems like some accident/bad joke coming out of a
> discussion between a hardware and software engineer on the enumeration
> of bits, with the hardware guy ending up saying "alright, have it
> whichever way you want it", causing even more pain :(

If all of the scfg bits change, then if you have this property, it
should be in the scfg node. But I prefer you use the compatible
instead if that works.

Rob
