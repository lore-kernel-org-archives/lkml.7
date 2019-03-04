Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02987C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA67020643
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551720451;
	bh=fsneTV3PF/RYK82S2xwbOskBJfOu6mSJyEPSXawmbrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=07L+dQ57Hs+rYzPWo1F4jSvto1i5DAYix0iR4KZKpJOxclh0Iy3Vw8f9e99sptD1D
	 ynzxXoDqAA6umRNab06CJLuBzQIIxrxj+WTa2EkvQ1uni4lnvfMz9tra41oqV3XWz8
	 IFBzFy7B2veBKaij9/8cq3dBR4iilxDTw0Zj3vyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCDR1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDR13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:27:29 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB7520823;
        Mon,  4 Mar 2019 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551720448;
        bh=fsneTV3PF/RYK82S2xwbOskBJfOu6mSJyEPSXawmbrc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lwQqzyp52T9Das3FRApiiZCbHtaqXl8Z3EneJhpZNqGzg61iQ4aMtEEqij0xP4ykc
         NkX5dCsUqMfkHn+ihf8kEe9pnZ2icP61jJPY5IachWooVvRmUdrRd5Ii1+0PGz9mpW
         ze64aM9BxVb9VMRkFlxxg5KKpM7rEs95OhELZDQk=
Received: by mail-qk1-f174.google.com with SMTP id z13so3221836qki.2;
        Mon, 04 Mar 2019 09:27:28 -0800 (PST)
X-Gm-Message-State: APjAAAW5npi+GAs3+8DFW4isKMHjRl0dxDd11NszHyBNa5KhRe9RJQEO
        IqcyHnVoR92ESnOb2pJLQu1g+wZP16pebbCA6Q==
X-Google-Smtp-Source: APXvYqwWGI3FxAO3jVnfFI1B6/Tv0eCRfTc0Ae8HQcoNLE9Q76ge7XUjQlhp7tRO66Q6rTq6G84pgVFXXDPy+RlXQXk=
X-Received: by 2002:a37:a381:: with SMTP id m123mr14508963qke.147.1551720447754;
 Mon, 04 Mar 2019 09:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20190121173835.21173-1-nava.manne@xilinx.com> <20190121173835.21173-7-nava.manne@xilinx.com>
 <20190121154928.GA32129@bogus> <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com> <BYAPR02MB4710216D63D98A56ABD99E67C2710@BYAPR02MB4710.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4710216D63D98A56ABD99E67C2710@BYAPR02MB4710.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 4 Mar 2019 11:27:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLn8LrO_qHkXK0hgwjvsedMCAEL0MTYXBLrke2cgri3+g@mail.gmail.com>
Message-ID: <CAL_JsqLn8LrO_qHkXK0hgwjvsedMCAEL0MTYXBLrke2cgri3+g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 5:35 AM Nava kishore Manne <navam@xilinx.com> wrote:
>
> Hi Rob,
>
>  Thanks for providing the review comments..
> Please find my response inline.
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Saturday, February 23, 2019 2:01 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
> > <JOLLYS@xilinx.com>; chinnikishore369@gmail.com
> > Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
> > driver
> >
> > On Wed, Jan 23, 2019 at 2:46 PM Nava kishore Manne <navam@xilinx.com>
> > wrote:
> > >
> > > Hi Rob,
> > >
> > >
> > >
> > > Thanks for providing the comments...
> >
> > Please fix your mailer to send plain text emails to mail lists.
> >
> Thanks for pointing it..
>
> >
> > > > -----Original Message-----
> > >
> > > > From: Rob Herring [mailto:robh@kernel.org]
> > >
> > > > Sent: Monday, January 21, 2019 9:19 PM
> > >
> > > > To: Nava kishore Manne <navam@xilinx.com>
> > >
> > > > Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan
> > > > Vaja
> > >
> > > > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > >
> > > > kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
> > >
> > > > <JOLLYS@xilinx.com>; chinnikishore369@gmail.com
> > >
> > > > Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for
> > > > ZynqMP fpga
> > >
> > > > driver
> > >
> > > >
> > >
> > > > On Mon, Jan 21, 2019 at 11:08:35PM +0530, Nava kishore Manne wrote:
> > >
> > > > > Add documentation to describe Xilinx ZynqMP fpga driver bindings.
> > >
> > > > >
> > >
> > > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > >
> > > > > ---
> > >
> > > > > Changes for v3:
> > >
> > > > >                         -Removed PCAP as a child node to the FW
> > > > > and Created
> > >
> > > > >                         an independent node since PCAP driver is a
> > > > > consumer
> > >
> > > > >                         not a provider.
> > >
> > > > >
> > >
> > > > >  .../bindings/fpga/xlnx,zynqmp-pcap-fpga.txt         | 13 +++++++++++++
> > >
> > > > >  1 file changed, 13 insertions(+)
> > >
> > > > >  create mode 100644
> > >
> > > > > Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > >
> > > > >
> > >
> > > > > diff --git
> > >
> > > > > a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > >
> > > > > b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > >
> > > > > new file mode 100644
> > >
> > > > > index 000000000000..1f6f58872311
> > >
> > > > > --- /dev/null
> > >
> > > > > +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga
> > > > > +++ .txt
> > >
> > > > > @@ -0,0 +1,13 @@
> > >
> > > > > +Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC
> > >
> > > > > +controlled using ZynqMP SoC firmware interface For Bitstream
> > >
> > > > > +configuration on ZynqMp Soc uses processor configuration
> > >
> > > > > +port(PCAP) to configure the programmable logic(PL) through PS by
> > >
> > > > > +using FW interface.
> > >
> > > > > +
> > >
> > > > > +Required properties:
> > >
> > > > > +- compatible: should contain "xlnx,zynqmp-pcap-fpga"
> > >
> > > > > +
> > >
> > > > > +Example:
> > >
> > > > > +      zynqmp_pcap: pcap {
> > >
> > > > > +                     compatible = "xlnx,zynqmp-pcap-fpga";
> > >
> > > > > +      };
> > >
> > > >
> > >
> > > > There's no need for a DT node. Just make the firware driver create a
> > > > platform
> > >
> > > > device for pcap.
> > >
> > > >
> > >
> > >
> > >
> > > This driver being used by the FPGA manager framework(fpga-region) to apply
> > overlay's so this node is needed AFAIK.
> >
> > The binding says nothing about child nodes and what they are. Please define
> > that.
> >
> Do you mean I need to add the example usage of the pcap node like as below in the binding doc?

You can have an example, but no, I meant you need say something like
"The pcap node may have 1 or more child nodes which have an
'fpga-region' compatible.
>
> Device Tree Example for Full Reconfiguration
> ============================================
>
> Live Device Tree contains:
>
>         zynqmp_pcap: pcap {
>                 compatible = "xlnx,zynqmp-pcap-fpga";
>         };
>
>         fpga_region0: fpga-region0 {

This should be a child of pcap.

>                 compatible = "fpga-region";
>                 fpga-mgr = <&zynqmp_pcap>;
>                 #address-cells = <0x1>;
>                 #size-cells = <0x1>;
>                 ranges;
>         };
>
> DT Overlay contains:

Don't show overlays in examples. Just show a final tree (i.e. base
with overlay applied).

> /dts-v1/ /plugin/;
> / {
> fragment@0 {
>         target = <&fpga_region0>;
>         #address-cells = <1>;
>         #size-cells = <1>;
>         __overlay__ {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>
>                 firmware-name = "zynqmp-gpio.bin";
>
>                 gpio1: gpio@40000000 {
>                         compatible = "xlnx,xps-gpio-1.00.a";
>                         reg = <0x40000000 0x10000>;
>                         gpio-controller;
>                         #gpio-cells = <0x2>;
>                         xlnx,gpio-width= <0x6>;
>                 };
>         };
> };
>
> Please correct me if my understanding is wrong.
>
> Regards,
> Navakishore.
