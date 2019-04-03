Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE2EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DB7206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDCPrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:47:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:47:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47D1FBDD0;
        Wed,  3 Apr 2019 15:47:40 +0000 (UTC)
Received: from redhat.com (ovpn-125-190.rdu2.redhat.com [10.10.125.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 197785C229;
        Wed,  3 Apr 2019 15:47:37 +0000 (UTC)
Date:   Wed, 3 Apr 2019 11:47:36 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ronan KERYELL <ronan@keryell.fr>
Cc:     Dave Airlie <airlied@gmail.com>, Sonal Santan <sonals@xilinx.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Cyril Chemparathy <cyrilc@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        linux-fpga@vger.kernel.org, Ralph Wittig <wittig@xilinx.com>,
        Ronan Keryell <rkeryell@xilinx.com>
Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
Message-ID: <20190403154734.GA12818@redhat.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
 <20190325202810.GG2665@phenom.ffwll.local>
 <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
 <CAKMK7uHh5KNaTO+a4ZA+vPQcPKUBwODsx+pPCWNp3sxe9TFP0Q@mail.gmail.com>
 <BYAPR02MB51603A1AD72F704112B55B90BB580@BYAPR02MB5160.namprd02.prod.outlook.com>
 <20190327141137.GK2665@phenom.ffwll.local>
 <BYAPR02MB5160162639C2EAC6B19901B7BB590@BYAPR02MB5160.namprd02.prod.outlook.com>
 <CAPM=9tyLNOXCaKGQkCCmo4tt=Dny0j984-=q8utjwv-aX-Y6BQ@mail.gmail.com>
 <871s2pw4ld.fsf@fisel.enstb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s2pw4ld.fsf@fisel.enstb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 03 Apr 2019 15:47:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 06:09:18PM -0700, Ronan KERYELL wrote:
> I am adding linux-fpga@vger.kernel.org, since this is why I missed this
> thread in the first place...
> >>>>> On Fri, 29 Mar 2019 14:56:17 +1000, Dave Airlie <airlied@gmail.com> said:
>     Dave> On Thu, 28 Mar 2019 at 10:14, Sonal Santan <sonals@xilinx.com> wrote:
>     >>> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]

[...]

> Long answer:
> 
> - processors, GPU and other digital circuits are designed from a lot of
>   elementary transistors, wires, capacitors, resistors... using some
>   very complex (and expensive) tools from some EDA companies but at the
>   end, after months of work, they come often with a "simple" public
>   interface, the... instruction set! So it is rather "easy" at the end
>   to generate some instructions with a compiler such as LLVM from a
>   description of this ISA or some reverse engineering. Note that even if
>   the ISA is public, it is very difficult to make another efficient
>   processor from scratch just from this ISA, so there is often no
>   concern about making this ISA public to develop the ecosystem ;
> 
> - FPGA are field-programmable gate arrays, made also from a lot of
>   elementary transistors, wires, capacitors, resistors... but organized
>   in billions of very low-level elementary gates, memory elements, DSP
>   blocks, I/O blocks, clock generators, specific
>   accelerators... directly exposed to the user and that can be
>   programmed according to a configuration memory (the bitstream) that
>   details how to connect each part, routing element, configuring each
>   elemental piece of hardware.  So instead of just writing instructions
>   like on a CPU or a GPU, you need to configure each bit of the
>   architecture in such a way it does something interesting for
>   you. Concretely, you write some programs in RTL languages (Verilog,
>   VHDL) or higher-level (C/C++, OpenCL, SYCL...)  and you use some very
>   complex (and expensive) tools from some EDA companies to generate the
>   bitstream implementing an equivalent circuit with the same
>   semantics. Since the architecture is so low level, there is a direct
>   mapping between the configuration memory (bitstream) and the hardware
>   architecture itself, so if it is public then it is easy to duplicate
>   the FPGA itself and to start a new FPGA company. That is unfortunately
>   something the existing FPGA companies do not want... ;-)

This is completely bogus argument, all FPGA documentation i have seen so far
_extensively_ describe _each_ basic blocks within the FGPA, this does include
the excelent documentation Xilinx provide on the inner working and layout of
Xilinx FPGA. Same apply to Altera, Atmel, Latice, ...

The extensive public documentation is enough for anyone with the money and
with half decent engineers to produce an FPGA.

The real know how of FPGA vendor is how to produce big chips on small process
capable to sustain high clock with the best power consumption possible. This
is the part where the years of experiences of each company pay off. The cost
for anyone to come to the market is in the hundred of millions just in setup
cost and to catch with established vendor on the hardware side. This without
any garanty of revenue at the end.

The bitstream is only giving away which bits correspond to which wire where
the LUT boolean table is store  ... Bitstream that have been reverse engineer
never revealed anything of value that was not already publicly documented.


So no the bitstream has _no_ value, please prove me wrong with Latice bitstream
for instance. If anything the fact that Latice has a reverse engineer bitstream
has made that FPGA popular with the maker community as it allows people to do
experiment for which the closed source tools are an impediment. So i would argue
that open bitstream is actualy beneficial.


The only valid reason i have ever seen for hidding the bitstream is to protect
the IP of the customer ie those customer that can pour quite a lot of money on
designing something with an FPGA and then wants to keep the VHDL/Verilog
protected and "safe" from reverse engineering.

But this is security by obscurity and FPGA company would be better off providing
strong bitstream encryption (and most already do but i have seen some paper on
how to break them).


I rather not see any bogus argument to try to justify something that is not
justifiable.


Daniel already stressed that we need to know what the bitstream can do and it
is even more important with FPGA where on some FPGA AFAICT the bitstream can
have total control over the PCIE BUS and thus can be use to attack either main
memory or other PCIE devices.

For instance with ATS/PASID you can have the device send pre-translated request
to the IOMMU and access any memory despite the IOMMU.

So without total confidence of what the bitstream can and can not do, and thus
without knowledge of the bitstream format and how it maps to LUT, switch, cross-
bar, clock, fix block (PCIE, DSP, DAC, ADC, ...) there is no way for someone
independant to check anything.


Cheers,
Jérôme Glisse
