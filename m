Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62153C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D66520854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552507641;
	bh=BA8bzZoS2/gf19hPjFVcEe3fH5ko7ryd4i4aQnYm86Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PSzhycD8S43dLahrKsxlGO22NSQnM8kcXbgRmc0Q6RH8y7n8RzZlNLPTmmbQSs/0W
	 +rCxrE7idgawBh/pVVBCdvT9f5GRn0LFhbjIawJiqdgO1jxMpRGe9B53xzUg61agjl
	 LvZGLbNzySsEMDHKDPss2HnFqdl7aK6IyT5fAGfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCMUHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfCMUHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:07:19 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF262146E;
        Wed, 13 Mar 2019 20:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552507638;
        bh=BA8bzZoS2/gf19hPjFVcEe3fH5ko7ryd4i4aQnYm86Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E0jZjHZFFn2txB/TSwlE12nW0TzYPzh62xRmsd8yfsho1iNmwvSsIgOc3ikgD7dax
         GrwnZqKodUYVsdcs+ML1oSkpjh2ukrnXO0RdCFRSop3bV1GDLn08YyrzndaFhJ21xE
         fh+BGSsQcZ5vLytbz432D4DTfAxeJZTv42ahLE8s=
Received: by mail-qt1-f180.google.com with SMTP id z17so3474843qtn.4;
        Wed, 13 Mar 2019 13:07:17 -0700 (PDT)
X-Gm-Message-State: APjAAAUZsgjgXit/X6N/fv9nCoJy8Z83qweW2EL304myfJ0Bi0/9Rp87
        vZyqE/tfk4+m51SgtGoPIGnM65rrq9bMPq//JA==
X-Google-Smtp-Source: APXvYqw87Ro29I5U0HwuCjzmE8G+DGicpVQXY2flFbFKvRF4cXOCzipWaMFB30K33IHVPOjUnCKaNkxsJnjxdmKnTS8=
X-Received: by 2002:a0c:c585:: with SMTP id a5mr10988734qvj.246.1552507637038;
 Wed, 13 Mar 2019 13:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190121173835.21173-1-nava.manne@xilinx.com> <20190121173835.21173-7-nava.manne@xilinx.com>
 <20190121154928.GA32129@bogus> <BYAPR02MB4710D1404CF2816599623363C2980@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CAL_JsqKy0DB+nt+q307d2HHuuf1OCdCe-Ro-5covdTibBwQw8A@mail.gmail.com>
 <BYAPR02MB4710216D63D98A56ABD99E67C2710@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CAL_JsqLn8LrO_qHkXK0hgwjvsedMCAEL0MTYXBLrke2cgri3+g@mail.gmail.com> <BYAPR02MB471068180BA4592779B0C2CEC2720@BYAPR02MB4710.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB471068180BA4592779B0C2CEC2720@BYAPR02MB4710.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Mar 2019 15:07:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJnG_zMxy-ESTey5tzeEnU3LA8GjZ7aLB3i+05rqkqDsg@mail.gmail.com>
Message-ID: <CAL_JsqJnG_zMxy-ESTey5tzeEnU3LA8GjZ7aLB3i+05rqkqDsg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Alan Tull <atull@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 3:42 AM Nava kishore Manne <navam@xilinx.com> wrote:
>
> Hi Rob,
>
> Thanks for the quick response.
> Please find my response inline.
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Monday, March 4, 2019 10:57 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
> > <JOLLYS@xilinx.com>; chinnikishore369@gmail.com
> > Subject: Re: [PATCH v3 6/6] dt-bindings: fpga: Add bindings for ZynqMP fpga
> > driver

Please fix your mail program to...

> > On Mon, Mar 4, 2019 at 5:35 AM Nava kishore Manne <navam@xilinx.com>
> > wrote:

...use this style reply header.

[...]

> > > Device Tree Example for Full Reconfiguration
> > > ============================================
> > >
> > > Live Device Tree contains:
> > >
> > >         zynqmp_pcap: pcap {
> > >                 compatible = "xlnx,zynqmp-pcap-fpga";
> > >         };
> > >
> > >         fpga_region0: fpga-region0 {
> >
> > This should be a child of pcap.
> >
> AFAIK we can't put the fpga-region as a child of pcap as both are independent and they refered to each other using phandlers
> I have made this changes by looking into the below reference doc.
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/fpga/fpga-region.txt

Indeed. But having them a as child of the firmware node doesn't make
sense either. Putting them at the top level would make more sense. I
don't recall why we didn't make them a child. Maybe regions can span
multiple bridges in the case with bridges.

> > >                 compatible = "fpga-region";
> > >                 fpga-mgr = <&zynqmp_pcap>;
> > >                 #address-cells = <0x1>;
> > >                 #size-cells = <0x1>;
> > >                 ranges;
> > >         };
> > >
> > > DT Overlay contains:
> >
> > Don't show overlays in examples. Just show a final tree (i.e. base with overlay
> > applied).
>
> To get a better picture for the users i have added this example node with overlays
> I feel it's good to have this info because it will not impact the functionality of PCAP node.

Then feel free to document this somewhere else. As we move to schema
documents, your examples will have to compile and validate against the
schema. I don't want to add applying overlays to the mix.

Rob
