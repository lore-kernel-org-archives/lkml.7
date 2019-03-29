Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B885C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C50A217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVDU8GHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfC2E4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:56:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46260 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfC2E4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:56:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so927541qts.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 21:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4/Y7bmu921aQNXbml8kqieWMm/KL+990+ILNuEM8ZA=;
        b=kVDU8GHAYpplfbhOKn6sjJSoi0KSQUVus0Gtpyc47mOln6UZH/JTedkfx+tw2PEOJW
         E02WnwTGScM5ct1sBWFvFl9okcuuXtFeTAdKwPlHKRJFX/joN71/5zQEzrAQ9OMQNucX
         vyJGXpzkJu9m+gOAyJH0PDcbw4ff3OcItx/F4VrFUiWRQps6XM6QYxiD7jrk3a5XSAdn
         6y7agSAkVF1ddKqSzgpfYoEd7KPap9Sw6dVATLSyI3IgZB4Gn6X+r+g8A7PQO+Sk4J2W
         XHoDAWPEHIBddXboogfDi6XI5u7BhK/ZNFoOVvc/OoiVWdezO2vcq0ba6P7O04wWW/lY
         IQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4/Y7bmu921aQNXbml8kqieWMm/KL+990+ILNuEM8ZA=;
        b=d1q2tC8L4bVNv7tEMXP1XS143o2pvEx7uZqbFwXXuRVtg+lQtGtekD8/GsVhwO+JBH
         pA8JSdp2yacXTMTkrM6ZjZPLPAEyM5obXIB5RJjQwJSa67WpvQULm0D/jy00zcMuy2y8
         BNz8P/bMqn2nQoGj8xaO+hpT6KqZ7TRe0TLO/eZVn6IbkngiwjEneT68tH+bno47MGhb
         VTDRsEK3qm1EmcLAgrCl65STihj7KtPUneO+Y7SY9jWz/26FgBhJ2Z+odDFvQ6b2nhKi
         3iGwjyrxuaAbHhTPHb8TCIVuT6FiKcpnU3wLhOB7iUSZqkXRLyCr1qoKZ1JRE8G1X5ko
         FgSw==
X-Gm-Message-State: APjAAAXCAfGy0jDLekUS7qqZeVN41UNUbOKB4BxncTezd+SHfWzQY3X9
        snGg+Rabvzrau65KiuAL/DBxRl0kAmsYXkhrN/c=
X-Google-Smtp-Source: APXvYqwrWj60++s46rE6k+QI2ZDw7n2n9kuvzgyihlIX9YK/B6e2tNTclGqYJvWxOT/pSGJfOdBlaeUyPdXxb2mEbFU=
X-Received: by 2002:a0c:a8d5:: with SMTP id h21mr5153300qvc.124.1553835389941;
 Thu, 28 Mar 2019 21:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
 <20190325202810.GG2665@phenom.ffwll.local> <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
 <CAKMK7uHh5KNaTO+a4ZA+vPQcPKUBwODsx+pPCWNp3sxe9TFP0Q@mail.gmail.com>
 <BYAPR02MB51603A1AD72F704112B55B90BB580@BYAPR02MB5160.namprd02.prod.outlook.com>
 <20190327141137.GK2665@phenom.ffwll.local> <BYAPR02MB5160162639C2EAC6B19901B7BB590@BYAPR02MB5160.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB5160162639C2EAC6B19901B7BB590@BYAPR02MB5160.namprd02.prod.outlook.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Mar 2019 14:56:17 +1000
Message-ID: <CAPM=9tyLNOXCaKGQkCCmo4tt=Dny0j984-=q8utjwv-aX-Y6BQ@mail.gmail.com>
Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
To:     Sonal Santan <sonals@xilinx.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Cyril Chemparathy <cyrilc@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "airlied@redhat.com" <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 at 10:14, Sonal Santan <sonals@xilinx.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel Vetter
> > Sent: Wednesday, March 27, 2019 7:12 AM
> > To: Sonal Santan <sonals@xilinx.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>; dri-devel@lists.freedesktop.org;
> > gregkh@linuxfoundation.org; Cyril Chemparathy <cyrilc@xilinx.com>; linux-
> > kernel@vger.kernel.org; Lizhi Hou <lizhih@xilinx.com>; Michal Simek
> > <michals@xilinx.com>; airlied@redhat.com
> > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
> >
> > On Wed, Mar 27, 2019 at 12:50:14PM +0000, Sonal Santan wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Daniel Vetter [mailto:daniel@ffwll.ch]
> > > > Sent: Wednesday, March 27, 2019 1:23 AM
> > > > To: Sonal Santan <sonals@xilinx.com>
> > > > Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org;
> > > > Cyril Chemparathy <cyrilc@xilinx.com>; linux-kernel@vger.kernel.org;
> > > > Lizhi Hou <lizhih@xilinx.com>; Michal Simek <michals@xilinx.com>;
> > > > airlied@redhat.com
> > > > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator
> > > > driver
> > > >
> > > > On Wed, Mar 27, 2019 at 12:30 AM Sonal Santan <sonals@xilinx.com>
> > wrote:
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of
> > > > > > Daniel Vetter
> > > > > > Sent: Monday, March 25, 2019 1:28 PM
> > > > > > To: Sonal Santan <sonals@xilinx.com>
> > > > > > Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org;
> > > > > > Cyril Chemparathy <cyrilc@xilinx.com>;
> > > > > > linux-kernel@vger.kernel.org; Lizhi Hou <lizhih@xilinx.com>;
> > > > > > Michal Simek <michals@xilinx.com>; airlied@redhat.com
> > > > > > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe
> > > > > > accelerator driver
> > > > > >
> > > > > > On Tue, Mar 19, 2019 at 02:53:55PM -0700,
> > > > > > sonal.santan@xilinx.com
> > > > wrote:
> > > > > > > From: Sonal Santan <sonal.santan@xilinx.com>
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > This patch series adds drivers for Xilinx Alveo PCIe accelerator cards.
> > > > > > > These drivers are part of Xilinx Runtime (XRT) open source
> > > > > > > stack and have been deployed by leading FaaS vendors and many
> > > > > > > enterprise
> > > > > > customers.
> > > > > >
> > > > > > Cool, first fpga driver submitted to drm! And from a high level
> > > > > > I think this makes a lot of sense.
> > > > > >
> > > > > > > PLATFORM ARCHITECTURE
> > > > > > >
> > > > > > > Alveo PCIe platforms have a static shell and a reconfigurable
> > > > > > > (dynamic) region. The shell is automatically loaded from PROM
> > > > > > > when host is booted and PCIe is enumerated by BIOS. Shell
> > > > > > > cannot be changed till next cold reboot. The shell exposes two
> > physical functions:
> > > > > > > management physical function and user physical function.
> > > > > > >
> > > > > > > Users compile their high level design in C/C++/OpenCL or RTL
> > > > > > > into FPGA image using SDx compiler. The FPGA image packaged as
> > > > > > > xclbin file can be loaded onto reconfigurable region. The
> > > > > > > image may contain one or more compute unit. Users can
> > > > > > > dynamically swap the full image running on the reconfigurable
> > > > > > > region in order to switch between different
> > > > > > workloads.
> > > > > > >
> > > > > > > XRT DRIVERS
> > > > > > >
> > > > > > > XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is
> > > > > > > modular and organized into several platform drivers which
> > > > > > > primarily handle the following functionality:
> > > > > > > 1.  ICAP programming (FPGA bitstream download with FPGA Mgr
> > > > > > > integration) 2.  Clock scaling 3.  Loading firmware container
> > > > > > > also called dsabin (embedded Microblaze
> > > > > > >     firmware for ERT and XMC, optional clearing bitstream) 4.
> > > > > > > In-band
> > > > > > > sensors: temp, voltage, power, etc.
> > > > > > > 5.  AXI Firewall management
> > > > > > > 6.  Device reset and rescan
> > > > > > > 7.  Hardware mailbox for communication between two physical
> > > > > > > functions
> > > > > > >
> > > > > > > XRT Linux kernel driver xocl binds to user pf. Like its peer,
> > > > > > > this driver is also modular and organized into several
> > > > > > > platform drivers which handle the following functionality:
> > > > > > > 1.  Device memory topology discovery and memory management 2.
> > > > > > > Buffer object abstraction and management for client process 3.
> > > > > > > XDMA MM PCIe DMA engine programming 4.  Multi-process aware
> > > > context management 5.
> > > > > > > Compute unit execution management (optionally with help of ERT)
> > for
> > > > > > >     client processes
> > > > > > > 6.  Hardware mailbox for communication between two physical
> > > > > > > functions
> > > > > > >
> > > > > > > The drivers export ioctls and sysfs nodes for various services.
> > > > > > > xocl driver makes heavy use of DRM GEM features for device
> > > > > > > memory management, reference counting, mmap support and
> > export/import.
> > > > > > > xocl also includes a simple scheduler called KDS which
> > > > > > > schedules compute units and interacts with hardware scheduler
> > > > > > > running ERT firmware. The scheduler understands custom opcodes
> > > > > > > packaged into command objects
> > > > > > and
> > > > > > > provides an asynchronous command done notification via POSIX poll.
> > > > > > >
> > > > > > > More details on architecture, software APIs, ioctl
> > > > > > > definitions, execution model, etc. is available as Sphinx
> > > > > > > documentation--
> > > > > > >
> > > > > > > https://xilinx.github.io/XRT/2018.3/html/index.html
> > > > > > >
> > > > > > > The complete runtime software stack (XRT) which includes out
> > > > > > > of tree kernel drivers, user space libraries, board utilities
> > > > > > > and firmware for the hardware scheduler is open source and
> > > > > > > available at https://github.com/Xilinx/XRT
> > > > > >
> > > > > > Before digging into the implementation side more I looked into
> > > > > > the userspace here. I admit I got lost a bit, since there's lots
> > > > > > of indirections and abstractions going on, but it seems like
> > > > > > this is just a fancy ioctl wrapper/driver backend abstractions.
> > > > > > Not really
> > > > something applications would use.
> > > > > Sonal Santan <sonals@xilinx.com>
> > > > >
> > > > > 4:20 PM (1 minute ago)
> > > > >
> > > > > to me
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of
> > > > > > Daniel Vetter
> > > > > > Sent: Monday, March 25, 2019 1:28 PM
> > > > > > To: Sonal Santan <sonals@xilinx.com>
> > > > > > Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org;
> > > > > > Cyril Chemparathy <cyrilc@xilinx.com>;
> > > > > > linux-kernel@vger.kernel.org; Lizhi Hou <lizhih@xilinx.com>;
> > > > > > Michal Simek <michals@xilinx.com>; airlied@redhat.com
> > > > > > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe
> > > > > > accelerator driver
> > > > > >
> > > > > > On Tue, Mar 19, 2019 at 02:53:55PM -0700,
> > > > > > sonal.santan@xilinx.com
> > > > wrote:
> > > > > > > From: Sonal Santan <sonal.santan@xilinx.com>
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > This patch series adds drivers for Xilinx Alveo PCIe accelerator cards.
> > > > > > > These drivers are part of Xilinx Runtime (XRT) open source
> > > > > > > stack and have been deployed by leading FaaS vendors and many
> > > > > > > enterprise
> > > > > > customers.
> > > > > >
> > > > > > Cool, first fpga driver submitted to drm! And from a high level
> > > > > > I think this makes a lot of sense.
> > > > > >
> > > > > > > PLATFORM ARCHITECTURE
> > > > > > >
> > > > > > > Alveo PCIe platforms have a static shell and a reconfigurable
> > > > > > > (dynamic) region. The shell is automatically loaded from PROM
> > > > > > > when host is booted and PCIe is enumerated by BIOS. Shell
> > > > > > > cannot be changed till next cold reboot. The shell exposes two
> > physical functions:
> > > > > > > management physical function and user physical function.
> > > > > > >
> > > > > > > Users compile their high level design in C/C++/OpenCL or RTL
> > > > > > > into FPGA image using SDx compiler. The FPGA image packaged as
> > > > > > > xclbin file can be loaded onto reconfigurable region. The
> > > > > > > image may contain one or more compute unit. Users can
> > > > > > > dynamically swap the full image running on the reconfigurable
> > > > > > > region in order to switch between different
> > > > > > workloads.
> > > > > > >
> > > > > > > XRT DRIVERS
> > > > > > >
> > > > > > > XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is
> > > > > > > modular and organized into several platform drivers which
> > > > > > > primarily handle the following functionality:
> > > > > > > 1.  ICAP programming (FPGA bitstream download with FPGA Mgr
> > > > > > > integration) 2.  Clock scaling 3.  Loading firmware container
> > > > > > > also called dsabin (embedded Microblaze
> > > > > > >     firmware for ERT and XMC, optional clearing bitstream) 4.
> > > > > > > In-band
> > > > > > > sensors: temp, voltage, power, etc.
> > > > > > > 5.  AXI Firewall management
> > > > > > > 6.  Device reset and rescan
> > > > > > > 7.  Hardware mailbox for communication between two physical
> > > > > > > functions
> > > > > > >
> > > > > > > XRT Linux kernel driver xocl binds to user pf. Like its peer,
> > > > > > > this driver is also modular and organized into several
> > > > > > > platform drivers which handle the following functionality:
> > > > > > > 1.  Device memory topology discovery and memory management 2.
> > > > > > > Buffer object abstraction and management for client process 3.
> > > > > > > XDMA MM PCIe DMA engine programming 4.  Multi-process aware
> > > > context management 5.
> > > > > > > Compute unit execution management (optionally with help of ERT)
> > for
> > > > > > >     client processes
> > > > > > > 6.  Hardware mailbox for communication between two physical
> > > > > > > functions
> > > > > > >
> > > > > > > The drivers export ioctls and sysfs nodes for various services.
> > > > > > > xocl driver makes heavy use of DRM GEM features for device
> > > > > > > memory management, reference counting, mmap support and
> > export/import.
> > > > > > > xocl also includes a simple scheduler called KDS which
> > > > > > > schedules compute units and interacts with hardware scheduler
> > > > > > > running ERT firmware. The scheduler understands custom opcodes
> > > > > > > packaged into command objects
> > > > > > and
> > > > > > > provides an asynchronous command done notification via POSIX poll.
> > > > > > >
> > > > > > > More details on architecture, software APIs, ioctl
> > > > > > > definitions, execution model, etc. is available as Sphinx
> > > > > > > documentation--
> > > > > > >
> > > > > > > https://xilinx.github.io/XRT/2018.3/html/index.html
> > > > > > >
> > > > > > > The complete runtime software stack (XRT) which includes out
> > > > > > > of tree kernel drivers, user space libraries, board utilities
> > > > > > > and firmware for the hardware scheduler is open source and
> > > > > > > available at https://github.com/Xilinx/XRT
> > > > > >
> > > > > > Before digging into the implementation side more I looked into
> > > > > > the userspace here. I admit I got lost a bit, since there's lots
> > > > > > of indirections and abstractions going on, but it seems like
> > > > > > this is just a fancy ioctl wrapper/driver backend abstractions.
> > > > > > Not really
> > > > something applications would use.
> > > > > >
> > > > >
> > > > > Appreciate your feedback.
> > > > >
> > > > > The userspace libraries define a common abstraction but have
> > > > > different implementations for Zynq Ultrascale+ embedded platform,
> > > > > PCIe based Alveo (and Faas) and emulation flows. The latter lets
> > > > > you run your
> > > > application without physical hardware.
> > > > >
> > > > > >
> > > > > > From the pretty picture on github it looks like there's some
> > > > > > opencl/ml/other fancy stuff sitting on top that applications
> > > > > > would use. Is
> > > > that also available?
> > > > >
> > > > > The full OpenCL runtime is available in the same repository.
> > > > > Xilinx ML Suite is also based on XRT and its source can be found
> > > > > at
> > > > https://github.com/Xilinx/ml-suite.
> > > >
> > > > Hm, I did a few git grep for the usual opencl entry points, but
> > > > didn't find anything. Do I need to run some build scripts first
> > > > (which downloads additional sourcecode)? Or is there some symbol
> > > > mangling going on and that's why I don't find anything? Pointers very
> > much appreciated.
> > >
> > > The bulk of the OCL runtime code can be found inside
> > > https://github.com/Xilinx/XRT/tree/master/src/runtime_src/xocl.
> > > The OCL runtime also includes
> > https://github.com/Xilinx/XRT/tree/master/src/runtime_src/xrt.
> > > The OCL runtime library called libxilinxopencl.so in turn then uses XRT APIs
> > to talk to the drivers.
> > > For PCIe these XRT APIs are implemented in the library libxrt_core.so
> > > the source for which is
> > https://github.com/Xilinx/XRT/tree/master/src/runtime_src/driver/xclng/xrt.
> > >
> > > You can build a fully functioning runtime stack by following very
> > > simple build instructions--
> > > https://xilinx.github.io/XRT/master/html/build.html
> > >
> > > We do have a few dependencies on standard Linux packages including a
> > > few OpenCL packages bundled by Linux distros: ocl-icd, ocl-icd-devel
> > > and opencl-headers
> >
> > Thanks a lot for pointers. No idea why I didn't find this stuff, I guess I was
> > blind.
> >
> > The thing I'm really interested in is the compiler, since at least the experience
> > from gpus says that very much is part of the overall uapi, and definitely
> > needed to be able to make any chances to the implementation.
> > Looking at clCreateProgramWithSource there's only a lookup up cached
> > compiles (it looks for xclbin), and src/runtime_src/xclbin doesn't look like that
> > provides a compiler either. It seems like apps need to precompile everything
> > first. Am I again missing something, or is this how it's supposed to work?
> >
> XRT works with precompiled binaries which are compiled by Xilinx SDx compiler
> called xocc. The binary (xclbin) is loaded by clCreateProgramWithBinary().
>
> > Note: There's no expectation for the fully optimizing compiler, and we're
> > totally ok if there's an optimizing proprietary compiler and a basic open one
> > (amd, and bunch of other companies all have such dual stacks running on top
> > of drm kernel drivers). But a basic compiler that can convert basic kernels into
> > machine code is expected.
> >
> Although the compiler is not open source the compilation flow lets users examine
> output from various stages. For example if you write your kernel in OpenCL/C/C++
> you can view the RTL (Verilog/VHDL) output produced by first stage of compilation.
> Note that the compiler is really generating a custom circuit given a high level
> input which in the last phase gets synthesized into bitstream. Expert hardware
> designers can handcraft a circuit in RTL and feed it to the compiler. Our FPGA tools
> let you view the generated hardware design, the register map, etc. You can get more
> information about a compiled design by running XRT tool like xclbinutil on the
> generated file.
>
> In essence compiling for FPGAs is quite different than compiling for GPU/CPU/DSP.
> Interestingly FPGA compilers can run anywhere from 30 mins to a few hours to
> compile a testcase.

So is there any open source userspace generator for what this
interface provides? Is the bitstream format that gets fed into the
FPGA proprietary and is it signed?

Dave.
