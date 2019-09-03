Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04790C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A6223431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567520667;
	bh=8p5CNP6BskSbrJouAkp8CPkNDKbbnxS4GqAgIpkH6xI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ddPoef1fL0t7Cnh4Ux3Q3eZe3qG7SY8tSIGZ62QEn2ieVk/dUDf42C+L/OzArLKTX
	 J2mbwuVjQksu4+7yAU9TH/hg6o5nwS1OQyrAlEcU1K93CgRcLtRce6oRsLzMpyp2NE
	 9OAZgPna4ZrnRdwEK0IAhaygSvwSA+dNWAvmGX0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfICOY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICOY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:24:26 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E73E23711;
        Tue,  3 Sep 2019 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567520665;
        bh=8p5CNP6BskSbrJouAkp8CPkNDKbbnxS4GqAgIpkH6xI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B2R+gSM9rCpwwImgfy85EdsLDtBELWH16KyE5jnVu6rMk/fnE90aUQem6v2XWvhGf
         k187E2P7dJzAQq21/bxqLFjTfcDwxI4s0zB0DI1KjPrC3bTJke79uRme6/hIbw95Qo
         Jr37leZG9ug9RjQwyWe1JTR6as0m6fgK8FKGiZcg=
Received: by mail-qt1-f171.google.com with SMTP id t12so20107545qtp.9;
        Tue, 03 Sep 2019 07:24:25 -0700 (PDT)
X-Gm-Message-State: APjAAAXpaUAGUjWpVW0gIbhTWp3YPdGRKivCs7xig8QkINW9tmclfvT0
        w6RGbqk3WxiPMck4Y4AGLXnAqvLsSAjkftqI+Q==
X-Google-Smtp-Source: APXvYqyf66U1enOSZroZ3NfqFTeBGuG/63QoHRuWUDZSe6k7+SHykxn/1jfwi/0yDstZK2RJ2ui8y0/4Bnql3UfknIs=
X-Received: by 2002:a05:6214:1042:: with SMTP id l2mr4516540qvr.39.1567520664326;
 Tue, 03 Sep 2019 07:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <1567321765-3738-1-git-send-email-pragnesh.patel@sifive.com>
 <5d6d1b81.1c69fb81.7eabb.cabd@mx.google.com> <CAN8ut8KMjo4KVcgLp6AhZOpuLwWMJ8HeiecH70RgYnLQQ05M9w@mail.gmail.com>
In-Reply-To: <CAN8ut8KMjo4KVcgLp6AhZOpuLwWMJ8HeiecH70RgYnLQQ05M9w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Sep 2019 15:24:12 +0100
X-Gmail-Original-Message-ID: <CAL_Jsq+Y3=xXuaqO=UoAShw5OxJA4wDBZVUE3=OT_DL9kw9t-Q@mail.gmail.com>
Message-ID: <CAL_Jsq+Y3=xXuaqO=UoAShw5OxJA4wDBZVUE3=OT_DL9kw9t-Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: Convert riscv,sifive-serial to json-schema
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 7:52 AM Pragnesh Patel <pragnesh.patel@sifive.com> wrote:
>
> On Mon, Sep 2, 2019 at 7:09 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Sep 01, 2019 at 12:39:21PM +0530, Pragnesh Patel wrote:
> > > Convert the riscv,sifive-serial binding to DT schema using json-schema.
> > >
> > > Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> > > ---
> > >  .../devicetree/bindings/serial/sifive-serial.txt   | 33 ------------
> > >  .../devicetree/bindings/serial/sifive-serial.yaml  | 62 ++++++++++++++++++++++
> > >  2 files changed, 62 insertions(+), 33 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
> > >  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > deleted file mode 100644
> > > index c86b1e5..0000000
> > > --- a/Documentation/devicetree/bindings/serial/sifive-serial.txt
> > > +++ /dev/null
> > > @@ -1,33 +0,0 @@
> > > -SiFive asynchronous serial interface (UART)
> > > -
> > > -Required properties:
> > > -
> > > -- compatible: should be something similar to
> > > -           "sifive,<chip>-uart" for the UART as integrated
> > > -           on a particular chip, and "sifive,uart<version>" for the
> > > -           general UART IP block programming model.  Supported
> > > -           compatible strings as of the date of this writing are:
> > > -           "sifive,fu540-c000-uart" for the SiFive UART v0 as
> > > -           integrated onto the SiFive FU540 chip, or "sifive,uart0"
> > > -           for the SiFive UART v0 IP block with no chip integration
> > > -           tweaks (if any)
> > > -- reg: address and length of the register space
> > > -- interrupts: Should contain the UART interrupt identifier
> > > -- clocks: Should contain a clock identifier for the UART's parent clock
> > > -
> > > -
> > > -UART HDL that corresponds to the IP block version numbers can be found
> > > -here:
> > > -
> > > -https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> > > -
> > > -
> > > -Example:
> > > -
> > > -uart0: serial@10010000 {
> > > -     compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> > > -     interrupt-parent = <&plic0>;
> > > -     interrupts = <80>;
> > > -     reg = <0x0 0x10010000 0x0 0x1000>;
> > > -     clocks = <&prci PRCI_CLK_TLCLK>;
> > > -};
> > > diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> > > new file mode 100644
> > > index 0000000..56fa935
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
> > > @@ -0,0 +1,62 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/serial/sifive-serial.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SiFive asynchronous serial interface (UART)
> > > +
> > > +maintainers:
> > > +  - Pragnesh Patel <pragnesh.patel@sifive.com>
> > > +  - Paul Walmsley  <paul.walmsley@sifive.com>
> > > +  - Palmer Dabbelt <palmer@sifive.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/serial.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sifive,fu540-c000-uart
> > > +      - sifive,uart0
> >
> > This is wrong and should have warned if you tested this on 5.3.
> >
> > items:
> >   - const: sifive,fu540-c000-uart
> >   - const: sifive,uart0
> >
>
> Thanks for the correction, i will update this in v2 patch.
>
> I haven't got any warnings due to my patch.
> For your reference, following is the list of warnings when i did "make
> dtbs_check" (kernel version - 5.3.0-rc7)

Thanks for the confirmation. I've now fixed it to correctly catch
that. Update your dtschema to the latest.

Rob
