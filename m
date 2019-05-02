Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFEBC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E9E206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556828149;
	bh=zRxoyURQKaIiT7crP80AuPIZsgXFZ/JEMXTtFf2j0Rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2VVgDQPvNgi73mpRf/fsPzyCPfM/gH/4SltUU4a0mIAMkOkogKUqH9FWEzmvagQjx
	 A5aryRkHy8sIJsMTvCw4JyR6m+OUrTco2Ph77NuneGZVIZs71hUGLp6Kn778Hhf2vw
	 rMNLeLZVu+jPygTtXb+gvHvtRkWnMZD2sACE2FeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEBUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBUPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:15:48 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8252D2087F;
        Thu,  2 May 2019 20:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556828146;
        bh=zRxoyURQKaIiT7crP80AuPIZsgXFZ/JEMXTtFf2j0Rg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HgR9EGv2AamK+gZAJYsuOyK66VNso2+jrjJ0znjMqgHbUMH8Ya9aP+6ogolNBc1Ox
         OSHm2fsO77nAjn8ZJyeU3ZleOn0vAoYQ/g60xHR8m7rwSlnZ0+VfshIkm9c7x/Aa5o
         n/3FhxDFr+mjjqONXDAaHgy9qIMaVdFDko8SgnLY=
Received: by mail-qk1-f181.google.com with SMTP id a132so2311217qkb.13;
        Thu, 02 May 2019 13:15:46 -0700 (PDT)
X-Gm-Message-State: APjAAAWCGCK9fV1sBzHyZ+ZFYU1pumGFDVbr9Q9tnu26vobO0kM1SbT/
        r+OHeLRlpydtsGvxwN4PZiCjyWuFHcH2rVZ1tw==
X-Google-Smtp-Source: APXvYqw5GzLdFMOydWWcI7Vtz2kWP9mL44UCoBhvg9xM001jIZ9hNWRsOoc9oDvi/bnDFT/mrU5onhhUYKrYHAhsiI8=
X-Received: by 2002:a37:ad14:: with SMTP id f20mr4646875qkm.147.1556828145727;
 Thu, 02 May 2019 13:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-2-git-send-email-dragan.cvetic@xilinx.com>
 <20190501194738.GA1441@bogus> <BL0PR02MB56815DFC139D65D46D5DFF50CB340@BL0PR02MB5681.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB56815DFC139D65D46D5DFF50CB340@BL0PR02MB5681.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 May 2019 15:15:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLhmtqUdUd8OPdx-390imegzouAJ43JOhYr16w87afS-Q@mail.gmail.com>
Message-ID: <CAL_JsqLhmtqUdUd8OPdx-390imegzouAJ43JOhYr16w87afS-Q@mail.gmail.com>
Subject: Re: [PATCH V3 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 6:04 AM Dragan Cvetic <draganc@xilinx.com> wrote:
>
> Hi Rob,
>
> Please find my inline comments below
>
> Thank you
> Dragan
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh@kernel.org]
> > Sent: Wednesday 1 May 2019 20:48
> > To: Dragan Cvetic <draganc@xilinx.com>
> > Cc: arnd@arndb.de; gregkh@linuxfoundation.org; Michal Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org;
> > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > Subject: Re: [PATCH V3 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
> >
> > On Sat, Apr 27, 2019 at 11:04:55PM +0100, Dragan Cvetic wrote:
> > > Add the Soft Decision Forward Error Correction (SDFEC) Engine
> > > bindings which is available for the Zynq UltraScale+ RFSoC
> > > FPGA's.
> > >
> > > Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > > Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> > > ---
> > >  .../devicetree/bindings/misc/xlnx,sd-fec.txt       | 58 ++++++++++++++++++++++
> > >  1 file changed, 58 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> > > new file mode 100644
> > > index 0000000..425b6a6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> > > @@ -0,0 +1,58 @@
> > > +* Xilinx SDFEC(16nm) IP *
> > > +
> > > +The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
> > > +which provides high-throughput LDPC and Turbo Code implementations.
> > > +The LDPC decode & encode functionality is capable of covering a range of
> > > +customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
> > > +principally covers codes used by LTE. The FEC Engine offers significant
> > > +power and area savings versus implementations done in the FPGA fabric.
> > > +
> > > +
> > > +Required properties:
> > > +- compatible: Must be "xlnx,sd-fec-1.1"
> > > +- clock-names : List of input clock names from the following:
> > > +    - "core_clk", Main processing clock for processing core (required)
> > > +    - "s_axi_aclk", AXI4-Lite memory-mapped slave interface clock (required)
> > > +    - "s_axis_din_aclk", DIN AXI4-Stream Slave interface clock (optional)
> > > +    - "s_axis_din_words-aclk", DIN_WORDS AXI4-Stream Slave interface clock (optional)
> > > +    - "s_axis_ctrl_aclk",  Control input AXI4-Stream Slave interface clock (optional)
> > > +    - "m_axis_dout_aclk", DOUT AXI4-Stream Master interface clock (optional)
> > > +    - "m_axis_dout_words_aclk", DOUT_WORDS AXI4-Stream Master interface clock (optional)
> > > +    - "m_axis_status_aclk", Status output AXI4-Stream Master interface clock (optional)
> > > +- clocks : Clock phandles (see clock_bindings.txt for details).
> > > +- reg: Should contain Xilinx SDFEC 16nm Hardened IP block registers
> > > +  location and length.
> > > +- xlnx,sdfec-code : Should contain "ldpc" or "turbo" to describe the codes
> > > +  being used.
> > > +- xlnx,sdfec-din-words : A value 0 indicates that the DIN_WORDS interface is
> > > +  driven with a fixed value and is not present on the device, a value of 1
> > > +  configures the DIN_WORDS to be block based, while a value of 2 configures the
> > > +  DIN_WORDS input to be supplied for each AXI transaction.
> > > +- xlnx,sdfec-din-width : Configures the DIN AXI stream where a value of 1
> > > +  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
> > > +  of "4x128b".
> >
> > Perhaps append with '-bits' and make the values 0, 128, 256, 512.
> >
>
>
> The suggested will require the extra code for converting from 128,256,512  to 1,2,4, as HW is configured with 1, 2 and 4.

A simple divide by 128.

We generally prefer DT to use real units rather than register values.

Rob
