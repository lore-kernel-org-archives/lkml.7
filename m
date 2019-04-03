Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981B9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522CB20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554301026;
	bh=l5FH1cPP3qFK/a5VUmTgTXOEjhaYEIV9UQv60BgE3tM=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=KaoBRE8pPCPJG5uEyKev8C9I/Ti/CXV2N3XQlwyvLapASXza35myIZWReGSw+rAkO
	 qUeflKecqs3cpo3teyLvHHzIFRUDOGsTi/RZzLSDxBeC8UAP9suSii5V4CFm8RmI+5
	 VvZvlcPihzA6ba58i1SrLFpTR0ZUcwmp9+yZydoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDCORE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:17:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40868 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:17:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so15515895otp.7;
        Wed, 03 Apr 2019 07:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yxc16RHJRP6qsurt4UbJQXngJJgmfpyeVdjjy+AAMgY=;
        b=q1FGXT49+k08VyikAQH6hm0/sYOAneepVdx7IomRoUEwykq9oaPG/8Z3h8hanwbK9Z
         swMEspcQsqYcCTif8dde8/6jWN9U7KYn1sJThlxm8COac/I19mNKLi2+NjCASH5uJZPg
         7oQShzSd2dsWXKEBA8HBHK+Yr4fzK2U1PzaKkOnicKtIRsOYi/fVaz4cnUDX4Hg/9DdC
         pVUP77Vwu9PTLQhayD7V98UiNowphgMV5Qz/jLGpVpxYUzlAPNRIRAvqXtjhJ5UWs+D4
         VSzVnITlycoTh1qjNStpiLLGxVhjwAfP2jNo8Tyq0KxWh6MsDkGU4LDSmhF4H5YyWXRO
         sBFg==
X-Gm-Message-State: APjAAAXswHymNbDtfWQhUqBK/hMm4PiHEbs3m8gJd7d1DK50Z3lGOw9T
        MXxIxy+Ae4mjGieYebDbppA=
X-Google-Smtp-Source: APXvYqzdBRNyvAqqOHvkX9lN3v70/CUmM0VLdceFEhpz1WXof9G4veUu+jcP0WZtZmVwlaNpDzHWYg==
X-Received: by 2002:a9d:19af:: with SMTP id k44mr46989573otk.300.1554301023109;
        Wed, 03 Apr 2019 07:17:03 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id j1sm6660521otn.59.2019.04.03.07.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 07:17:02 -0700 (PDT)
Date:   Wed, 3 Apr 2019 07:17:01 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Ronan KERYELL <ronan@keryell.fr>, Dave Airlie <airlied@gmail.com>,
        Sonal Santan <sonals@xilinx.com>,
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
Message-ID: <20190403141701.GA5752@archbook>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
 <20190325202810.GG2665@phenom.ffwll.local>
 <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
 <CAKMK7uHh5KNaTO+a4ZA+vPQcPKUBwODsx+pPCWNp3sxe9TFP0Q@mail.gmail.com>
 <BYAPR02MB51603A1AD72F704112B55B90BB580@BYAPR02MB5160.namprd02.prod.outlook.com>
 <20190327141137.GK2665@phenom.ffwll.local>
 <BYAPR02MB5160162639C2EAC6B19901B7BB590@BYAPR02MB5160.namprd02.prod.outlook.com>
 <CAPM=9tyLNOXCaKGQkCCmo4tt=Dny0j984-=q8utjwv-aX-Y6BQ@mail.gmail.com>
 <871s2pw4ld.fsf@fisel.enstb.org>
 <20190403131449.GB2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403131449.GB2665@phenom.ffwll.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Apr 03, 2019 at 03:14:49PM +0200, Daniel Vetter wrote:
> On Fri, Mar 29, 2019 at 06:09:18PM -0700, Ronan KERYELL wrote:
> > I am adding linux-fpga@vger.kernel.org, since this is why I missed this
> > thread in the first place...
> > 
> > >>>>> On Fri, 29 Mar 2019 14:56:17 +1000, Dave Airlie <airlied@gmail.com> said:
> > 
> > Hi Dave!
> > 
> >     Dave> On Thu, 28 Mar 2019 at 10:14, Sonal Santan <sonals@xilinx.com> wrote:
> > 
> >     >>> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]
> > 
> > [...]
> > 
> >     >>> Note: There's no expectation for the fully optimizing compiler,
> >     >>> and we're totally ok if there's an optimizing proprietary
> >     >>> compiler and a basic open one (amd, and bunch of other
> >     >>> companies all have such dual stacks running on top of drm
> >     >>> kernel drivers). But a basic compiler that can convert basic
> >     >>> kernels into machine code is expected.
> > 
> >     >> Although the compiler is not open source the compilation flow
> >     >> lets users examine output from various stages. For example if you
> >     >> write your kernel in OpenCL/C/C++ you can view the RTL
> >     >> (Verilog/VHDL) output produced by first stage of compilation.
> >     >> Note that the compiler is really generating a custom circuit
> >     >> given a high level input which in the last phase gets synthesized
> >     >> into bitstream. Expert hardware designers can handcraft a circuit
> >     >> in RTL and feed it to the compiler. Our FPGA tools let you view
> >     >> the generated hardware design, the register map, etc. You can get
> >     >> more information about a compiled design by running XRT tool like
> >     >> xclbinutil on the generated file.
> > 
> >     >> In essence compiling for FPGAs is quite different than compiling
> >     >> for GPU/CPU/DSP.  Interestingly FPGA compilers can run anywhere
> >     >> from 30 mins to a few hours to compile a testcase.
> > 
> >     Dave> So is there any open source userspace generator for what this
> >     Dave> interface provides? Is the bitstream format that gets fed into
> >     Dave> the FPGA proprietary and is it signed?
> > 
> > Short answer:
> > 
> > - a bitstream is an opaque content similar to various firmware handled
> >   by Linux, EFI capsules, x86 microcode, WiFi modems, etc.
> > 
> > - there is no open-source generator for what the interface consume;
> > 
> > - I do not know if it is signed;
> > 
> > - it is probably similar to what Intel FPGA (not GPU) drivers provide
> >   already inside the Linux kernel and I guess there is no pure
> >   open-source way to generate their bit-stream either.
> 
> Yeah, drivers/gpu folks wouldn't ever have merged drivers/fpga, and I
> think there's pretty strong consensus over here that merging fpga stuff
> without having clear specs (in the form of an executable open source
> compiler/synthesizer/whatever) was a mistake.

I don't totally understand this statement. You don't go out and ask
people to open source their EDA tools that are used to create the ASICs
on any piece of HW (NIC, GPU, USB controller,...) out there.

FPGAs are no different.

I think you need to distinguish between the general FPGA as a means to
implement a HW solution and *FPGA based devices* that implement flows such
as OpenCL etc. For the latter I'm more inclined to buy the equivalence
to GPUs argument.

> We just had a similar huge discussions around the recently merged
> habanalabs driver in drivers/misc, for neural network accel. There was a
> proposed drivers/accel for these. gpu folks objected, Greg and Olof were
> happy with merging.
> 
> And the exact same arguments has come up tons of times for gpus too, with
> lots proposals to merge a kernel driver with just the kernel driver being
> open source, or just the state tracker/runtime, but most definitely not
> anything looking like the compiler. Because $reasons.
> 
> Conclusion was that drivers/gpu people will continue to reject these,
> everyone else will continue to take whatever, but just don't complain to
> us if it all comes crashing down :-)
> 
> > Long answer:
> > 
> > - processors, GPU and other digital circuits are designed from a lot of
> >   elementary transistors, wires, capacitors, resistors... using some
> >   very complex (and expensive) tools from some EDA companies but at the
> >   end, after months of work, they come often with a "simple" public
> >   interface, the... instruction set! So it is rather "easy" at the end
> >   to generate some instructions with a compiler such as LLVM from a
> >   description of this ISA or some reverse engineering. Note that even if
> >   the ISA is public, it is very difficult to make another efficient
> >   processor from scratch just from this ISA, so there is often no
> >   concern about making this ISA public to develop the ecosystem ;
> > 
> > - FPGA are field-programmable gate arrays, made also from a lot of
> >   elementary transistors, wires, capacitors, resistors... but organized
> >   in billions of very low-level elementary gates, memory elements, DSP
> >   blocks, I/O blocks, clock generators, specific
> >   accelerators... directly exposed to the user and that can be
> >   programmed according to a configuration memory (the bitstream) that
> >   details how to connect each part, routing element, configuring each
> >   elemental piece of hardware.  So instead of just writing instructions
> >   like on a CPU or a GPU, you need to configure each bit of the
> >   architecture in such a way it does something interesting for
> >   you. Concretely, you write some programs in RTL languages (Verilog,
> >   VHDL) or higher-level (C/C++, OpenCL, SYCL...)  and you use some very
> >   complex (and expensive) tools from some EDA companies to generate the
> >   bitstream implementing an equivalent circuit with the same
> >   semantics. Since the architecture is so low level, there is a direct
> >   mapping between the configuration memory (bitstream) and the hardware
> >   architecture itself, so if it is public then it is easy to duplicate
> >   the FPGA itself and to start a new FPGA company. That is unfortunately
> >   something the existing FPGA companies do not want... ;-)
> 
> i.e. you have a use case where you absolutely need an offline compiler.
> Like with gpus (in some use cases), the only difference is that for gpus
> the latency requirement that's too high is measured in milliseconds, cause
> that would cause dropped frames, and worst case compiling takes seconds
> for some big shaders. With FPGAs it's just 1000x higher limits, same problem.

As I said above, you'd do the same thing when you design any other piece
of hardware out there, except for with FPGAs you'd be able to change
stuff, whereas with an ASIC your netlist gets fixed at tape-out date.
> 
> > To summarize:
> > 
> > - on a CPU & GPU, the vendor used the expensive EDA tools once already
> >   for you and provide the simpler ISA interface;
> > 
> > - on an FPGA, you have access to a pile of low-level hardware and it is
> >   up to you to use the lengthy process of building your own computing
> >   architecture using the heavy expensive very subtle EDA tools that will
> >   run for hours or days to generate some good-enough placement for your
> >   pleasure.
> > 
> > There is some public documentation on-line:
> > https://www.xilinx.com/products/silicon-devices/fpga/virtex-ultrascale-plus.html#documentation
> > 
> > To have an idea of the elementary architecture:
> > https://www.xilinx.com/support/documentation/user_guides/ug574-ultrascale-clb.pdf
> > https://www.xilinx.com/support/documentation/user_guides/ug579-ultrascale-dsp.pdf
> > https://www.xilinx.com/support/documentation/user_guides/ug573-ultrascale-memory-resources.pdf
> > 
> > Even on the configuration and the file format, but without any detailed semantics:
> > https://www.xilinx.com/support/documentation/user_guides/ug570-ultrascale-configuration.pdf
> > 
> > 
> > The Xilinx compiler xocc taking for example some LLVM IR and generating
> > some bitstream is not open-source and will probably never be for the
> > reasons above... :-(
> > 
> > Xilinx is open-sourcing all what can reasonably be open-sourced:
> > 
> > - the user-level and system run-time, including the OpenCL runtime:
> >   https://github.com/Xilinx/XRT to handle the bitstreams generated by
> >   some close-source tools
> > 
> > - the kernel device drivers which are already in
> >   https://github.com/Xilinx/XRT but we want to upstream into the Linux
> >   kernel to make life easier (this is the matter of this e-mail thread);
> > 
> > - to generate some real code in the most (modern and) open-source way,
> >   there is an open-source framework to compile some SYCL C++ including
> >   some Xilinx FPGA-specific extensions down to SPIR LLVM IR using
> >   Clang/LLVM and to feed the close-source xocc tool with it
> >   https://github.com/triSYCL/triSYCL
> > 
> >   You can see starting from
> >   https://github.com/triSYCL/triSYCL/blob/master/tests/Makefile#L322 how
> >   to start from C++ code, generate some SPIR LLVM IR and to feed xocc
> >   and build a fat binary that will use the XRT runtime.
> > 
> >   Some documentation in
> >   https://github.com/triSYCL/triSYCL/blob/master/doc/architecture.rst
> > 
> >   There are other more official ways to generate bitstream (they are
> >   called products instead of research projects like triSYCL :-) ).
> > 
> >   We are also working on an other open-source SYCL compiler with Intel
> >   to have a better common implementation
> >   https://github.com/intel/llvm/wiki and to upstream this into Clang/LLVM.
> 
> Yeah, there's been plenty of gpu stacks with "everything open sourced that
> can be open sourced", except the compiler, for gpus. We didn't take those
> drivers either.
> 
> And I looked at the entire stack already to see what's there and what's
> missing.
> 
> > So for Xilinx FPGA, you can see the LLVM IR as the equivalent of PTX for
> > nVidia. But xocc is close-source for some more fundamental reasons: it
> > would expose all the details of the FPGA. I guess this is exactly the
> > same for Xilinx FPGA.
> 
> Yeah, neither did we merge a driver with just some IR as the "compiler",
> and most definitely not PTX (since that's just nv lock-in, spirv is the
> cross vendor solution that at least seems to have a fighting chance). We
> want the low level stuff (and if the high level compiler is the dumbest,
> least optimizing thing ever that can't run any real world workload yet,
> that's fine, it can be fixed). The low level stuff is what matters from an
> uapi perspective.
> 
> > Note that probably most of the tool chains used to generate the
> > low-level firmware for the various CPU (microcode), GPU, etc. are
> > also close-source.
> 
> Yup. None have been successfully used to merge stuff into drivers/gpu.
> 
> Note that we're perfectly fine with closed source stacks running on top of
> drivers/gpu, with lots of additional secret sauce/value add/customer lock
> in/whatever compared to the basic open source stack. There's plenty of
> vendors doing that. But for the uapi review, and making sure we can at
> least keep the basic stack working, it needs to be the full open stack.
> End to end.
> 
> I guess I need to actually type that article on my blog about why exactly
> we're so much insisting on this, seems to become a bit an FAQ.
> 
> Cheers, Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

Cheers,
Moritz
