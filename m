Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A24BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90282075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jCB9Fe1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfC0IW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:22:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36499 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfC0IW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:22:57 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so24707358itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WpbU+RKj5aKG8Ik2bJq0Dxy3Vhtrc3f+GtBx9g1UV0=;
        b=jCB9Fe1XuDMxaODuE0ACeSX/LzRTrozRMeLGHNG0SOJW6PeGCsA4S+VDj70j/zwUkq
         FpjK24ulngmiAw5npfYUj+vmHZoOcCywpc1vqpwbzdCnNgLZ5E6HZCyMNWStMY/k/tLc
         guejKvRi9eIY3FbG9IBYcyMWF1xPd2oZ1GWp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WpbU+RKj5aKG8Ik2bJq0Dxy3Vhtrc3f+GtBx9g1UV0=;
        b=gsydCR4nIK89N4Ew6SfE02r5WXcijSE1Z2CH9/RotsFEJ4gYxbEUVmmcgd28xhTAZD
         JzNAjjF5BTXpQG6VOgsFsXa+eCXd+lPJvncFAIEzWygBBBE9edkActPrWe1Uj8KTqPCY
         jCZsIRbYHBBuD0MFEPdPQEBAAuYNfPK5bMduiHyZYdkTHC6C1xH5XQSTPV552jMh//Ss
         imtTCdidRWJ2z4X8l1/DqreMlheYH9Ksm/vxgSMJvFIFVd/y+vlpa1TG80xmYK10Ldjx
         oxQS3id3SLXgQgY9mH+ORfrzi3Ib0+VQgNnGzcUMA+yyby6uNLNE9dA2u3/SnbChhScc
         64Ew==
X-Gm-Message-State: APjAAAWpcXck2Ceofpinr9EkgyB1vQcwHGF4dfMgTDkJX4RvwN4baF9f
        OjscJbg0gV4jcY4d4mPtwD3Y+dqd3RsQmAwDxAL831bw
X-Google-Smtp-Source: APXvYqxlHXXzbvzTmxhAJ+cUOW/kpP42ZT+aW6hMxJwxPj3ln2VFF3S4UKkIvoj4k84eQRSSd5QULfGEVryMzOPYQvk=
X-Received: by 2002:a24:9197:: with SMTP id i145mr2498713ite.117.1553674975844;
 Wed, 27 Mar 2019 01:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
 <20190325202810.GG2665@phenom.ffwll.local> <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 27 Mar 2019 09:22:44 +0100
Message-ID: <CAKMK7uHh5KNaTO+a4ZA+vPQcPKUBwODsx+pPCWNp3sxe9TFP0Q@mail.gmail.com>
Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
To:     Sonal Santan <sonals@xilinx.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
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

On Wed, Mar 27, 2019 at 12:30 AM Sonal Santan <sonals@xilinx.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel Vetter
> > Sent: Monday, March 25, 2019 1:28 PM
> > To: Sonal Santan <sonals@xilinx.com>
> > Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org; Cyril
> > Chemparathy <cyrilc@xilinx.com>; linux-kernel@vger.kernel.org; Lizhi Hou
> > <lizhih@xilinx.com>; Michal Simek <michals@xilinx.com>; airlied@redhat.com
> > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
> >
> > On Tue, Mar 19, 2019 at 02:53:55PM -0700, sonal.santan@xilinx.com wrote:
> > > From: Sonal Santan <sonal.santan@xilinx.com>
> > >
> > > Hello,
> > >
> > > This patch series adds drivers for Xilinx Alveo PCIe accelerator cards.
> > > These drivers are part of Xilinx Runtime (XRT) open source stack and
> > > have been deployed by leading FaaS vendors and many enterprise
> > customers.
> >
> > Cool, first fpga driver submitted to drm! And from a high level I think this
> > makes a lot of sense.
> >
> > > PLATFORM ARCHITECTURE
> > >
> > > Alveo PCIe platforms have a static shell and a reconfigurable
> > > (dynamic) region. The shell is automatically loaded from PROM when
> > > host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
> > > till next cold reboot. The shell exposes two physical functions:
> > > management physical function and user physical function.
> > >
> > > Users compile their high level design in C/C++/OpenCL or RTL into FPGA
> > > image using SDx compiler. The FPGA image packaged as xclbin file can
> > > be loaded onto reconfigurable region. The image may contain one or
> > > more compute unit. Users can dynamically swap the full image running
> > > on the reconfigurable region in order to switch between different
> > workloads.
> > >
> > > XRT DRIVERS
> > >
> > > XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is modular
> > > and organized into several platform drivers which primarily handle the
> > > following functionality:
> > > 1.  ICAP programming (FPGA bitstream download with FPGA Mgr
> > > integration) 2.  Clock scaling 3.  Loading firmware container also
> > > called dsabin (embedded Microblaze
> > >     firmware for ERT and XMC, optional clearing bitstream) 4.  In-band
> > > sensors: temp, voltage, power, etc.
> > > 5.  AXI Firewall management
> > > 6.  Device reset and rescan
> > > 7.  Hardware mailbox for communication between two physical functions
> > >
> > > XRT Linux kernel driver xocl binds to user pf. Like its peer, this
> > > driver is also modular and organized into several platform drivers
> > > which handle the following functionality:
> > > 1.  Device memory topology discovery and memory management 2.  Buffer
> > > object abstraction and management for client process 3.  XDMA MM PCIe
> > > DMA engine programming 4.  Multi-process aware context management 5.
> > > Compute unit execution management (optionally with help of ERT) for
> > >     client processes
> > > 6.  Hardware mailbox for communication between two physical functions
> > >
> > > The drivers export ioctls and sysfs nodes for various services. xocl
> > > driver makes heavy use of DRM GEM features for device memory
> > > management, reference counting, mmap support and export/import. xocl
> > > also includes a simple scheduler called KDS which schedules compute
> > > units and interacts with hardware scheduler running ERT firmware. The
> > > scheduler understands custom opcodes packaged into command objects
> > and
> > > provides an asynchronous command done notification via POSIX poll.
> > >
> > > More details on architecture, software APIs, ioctl definitions,
> > > execution model, etc. is available as Sphinx documentation--
> > >
> > > https://xilinx.github.io/XRT/2018.3/html/index.html
> > >
> > > The complete runtime software stack (XRT) which includes out of tree
> > > kernel drivers, user space libraries, board utilities and firmware for
> > > the hardware scheduler is open source and available at
> > > https://github.com/Xilinx/XRT
> >
> > Before digging into the implementation side more I looked into the userspace
> > here. I admit I got lost a bit, since there's lots of indirections and abstractions
> > going on, but it seems like this is just a fancy ioctl wrapper/driver backend
> > abstractions. Not really something applications would use.
> Sonal Santan <sonals@xilinx.com>
>
> 4:20 PM (1 minute ago)
>
> to me
>
>
> > -----Original Message-----
> > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel Vetter
> > Sent: Monday, March 25, 2019 1:28 PM
> > To: Sonal Santan <sonals@xilinx.com>
> > Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org; Cyril
> > Chemparathy <cyrilc@xilinx.com>; linux-kernel@vger.kernel.org; Lizhi Hou
> > <lizhih@xilinx.com>; Michal Simek <michals@xilinx.com>; airlied@redhat.com
> > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
> >
> > On Tue, Mar 19, 2019 at 02:53:55PM -0700, sonal.santan@xilinx.com wrote:
> > > From: Sonal Santan <sonal.santan@xilinx.com>
> > >
> > > Hello,
> > >
> > > This patch series adds drivers for Xilinx Alveo PCIe accelerator cards.
> > > These drivers are part of Xilinx Runtime (XRT) open source stack and
> > > have been deployed by leading FaaS vendors and many enterprise
> > customers.
> >
> > Cool, first fpga driver submitted to drm! And from a high level I think this
> > makes a lot of sense.
> >
> > > PLATFORM ARCHITECTURE
> > >
> > > Alveo PCIe platforms have a static shell and a reconfigurable
> > > (dynamic) region. The shell is automatically loaded from PROM when
> > > host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
> > > till next cold reboot. The shell exposes two physical functions:
> > > management physical function and user physical function.
> > >
> > > Users compile their high level design in C/C++/OpenCL or RTL into FPGA
> > > image using SDx compiler. The FPGA image packaged as xclbin file can
> > > be loaded onto reconfigurable region. The image may contain one or
> > > more compute unit. Users can dynamically swap the full image running
> > > on the reconfigurable region in order to switch between different
> > workloads.
> > >
> > > XRT DRIVERS
> > >
> > > XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is modular
> > > and organized into several platform drivers which primarily handle the
> > > following functionality:
> > > 1.  ICAP programming (FPGA bitstream download with FPGA Mgr
> > > integration) 2.  Clock scaling 3.  Loading firmware container also
> > > called dsabin (embedded Microblaze
> > >     firmware for ERT and XMC, optional clearing bitstream) 4.  In-band
> > > sensors: temp, voltage, power, etc.
> > > 5.  AXI Firewall management
> > > 6.  Device reset and rescan
> > > 7.  Hardware mailbox for communication between two physical functions
> > >
> > > XRT Linux kernel driver xocl binds to user pf. Like its peer, this
> > > driver is also modular and organized into several platform drivers
> > > which handle the following functionality:
> > > 1.  Device memory topology discovery and memory management 2.  Buffer
> > > object abstraction and management for client process 3.  XDMA MM PCIe
> > > DMA engine programming 4.  Multi-process aware context management 5.
> > > Compute unit execution management (optionally with help of ERT) for
> > >     client processes
> > > 6.  Hardware mailbox for communication between two physical functions
> > >
> > > The drivers export ioctls and sysfs nodes for various services. xocl
> > > driver makes heavy use of DRM GEM features for device memory
> > > management, reference counting, mmap support and export/import. xocl
> > > also includes a simple scheduler called KDS which schedules compute
> > > units and interacts with hardware scheduler running ERT firmware. The
> > > scheduler understands custom opcodes packaged into command objects
> > and
> > > provides an asynchronous command done notification via POSIX poll.
> > >
> > > More details on architecture, software APIs, ioctl definitions,
> > > execution model, etc. is available as Sphinx documentation--
> > >
> > > https://xilinx.github.io/XRT/2018.3/html/index.html
> > >
> > > The complete runtime software stack (XRT) which includes out of tree
> > > kernel drivers, user space libraries, board utilities and firmware for
> > > the hardware scheduler is open source and available at
> > > https://github.com/Xilinx/XRT
> >
> > Before digging into the implementation side more I looked into the userspace
> > here. I admit I got lost a bit, since there's lots of indirections and abstractions
> > going on, but it seems like this is just a fancy ioctl wrapper/driver backend
> > abstractions. Not really something applications would use.
> >
>
> Appreciate your feedback.
>
> The userspace libraries define a common abstraction but have different implementations
> for Zynq Ultrascale+ embedded platform, PCIe based Alveo (and Faas) and emulation
> flows. The latter lets you run your application without physical hardware.
>
> >
> > From the pretty picture on github it looks like there's some opencl/ml/other
> > fancy stuff sitting on top that applications would use. Is that also available?
>
> The full OpenCL runtime is available in the same repository. Xilinx ML Suite is
> also based on XRT and its source can be found at https://github.com/Xilinx/ml-suite.

Hm, I did a few git grep for the usual opencl entry points, but didn't
find anything. Do I need to run some build scripts first (which
downloads additional sourcecode)? Or is there some symbol mangling
going on and that's why I don't find anything? Pointers very much
appreciated.

> Typically end users use OpenCL APIs which are part of XRT stack. One can write an
> application to directly call XRT APIs defined at
> https://xilinx.github.io/XRT/2018.3/html/xclhal2.main.html

I have no clue about DNN/ML unfortunately, I think I'll try to look
into the ocl side a bit more first.

Thanks, Daniel

>
> Thanks,
> -Sonal
> >
> > Thanks, Daniel
> >
> > >
> > > Thanks,
> > > -Sonal
> > >
> > > Sonal Santan (6):
> > >   Add skeleton code: ioctl definitions and build hooks
> > >   Global data structures shared between xocl and xmgmt drivers
> > >   Add platform drivers for various IPs and frameworks
> > >   Add core of XDMA driver
> > >   Add management driver
> > >   Add user physical function driver
> > >
> > >  drivers/gpu/drm/Kconfig                    |    2 +
> > >  drivers/gpu/drm/Makefile                   |    1 +
> > >  drivers/gpu/drm/xocl/Kconfig               |   22 +
> > >  drivers/gpu/drm/xocl/Makefile              |    3 +
> > >  drivers/gpu/drm/xocl/devices.h             |  954 +++++
> > >  drivers/gpu/drm/xocl/ert.h                 |  385 ++
> > >  drivers/gpu/drm/xocl/lib/Makefile.in       |   16 +
> > >  drivers/gpu/drm/xocl/lib/cdev_sgdma.h      |   63 +
> > >  drivers/gpu/drm/xocl/lib/libxdma.c         | 4368 ++++++++++++++++++++
> > >  drivers/gpu/drm/xocl/lib/libxdma.h         |  596 +++
> > >  drivers/gpu/drm/xocl/lib/libxdma_api.h     |  127 +
> > >  drivers/gpu/drm/xocl/mgmtpf/Makefile       |   29 +
> > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c    |  960 +++++
> > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h    |  147 +
> > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c      |   30 +
> > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c   |  148 +
> > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h     |  244 ++
> > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c   |  318 ++
> > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c   |  399 ++
> > >  drivers/gpu/drm/xocl/subdev/dna.c          |  356 ++
> > >  drivers/gpu/drm/xocl/subdev/feature_rom.c  |  412 ++
> > >  drivers/gpu/drm/xocl/subdev/firewall.c     |  389 ++
> > >  drivers/gpu/drm/xocl/subdev/fmgr.c         |  198 +
> > >  drivers/gpu/drm/xocl/subdev/icap.c         | 2859 +++++++++++++
> > >  drivers/gpu/drm/xocl/subdev/mailbox.c      | 1868 +++++++++
> > >  drivers/gpu/drm/xocl/subdev/mb_scheduler.c | 3059 ++++++++++++++
> > >  drivers/gpu/drm/xocl/subdev/microblaze.c   |  722 ++++
> > >  drivers/gpu/drm/xocl/subdev/mig.c          |  256 ++
> > >  drivers/gpu/drm/xocl/subdev/sysmon.c       |  385 ++
> > >  drivers/gpu/drm/xocl/subdev/xdma.c         |  510 +++
> > >  drivers/gpu/drm/xocl/subdev/xmc.c          | 1480 +++++++
> > >  drivers/gpu/drm/xocl/subdev/xvc.c          |  461 +++
> > >  drivers/gpu/drm/xocl/userpf/Makefile       |   27 +
> > >  drivers/gpu/drm/xocl/userpf/common.h       |  157 +
> > >  drivers/gpu/drm/xocl/userpf/xocl_bo.c      | 1255 ++++++
> > >  drivers/gpu/drm/xocl/userpf/xocl_bo.h      |  119 +
> > >  drivers/gpu/drm/xocl/userpf/xocl_drm.c     |  640 +++
> > >  drivers/gpu/drm/xocl/userpf/xocl_drv.c     |  743 ++++
> > >  drivers/gpu/drm/xocl/userpf/xocl_ioctl.c   |  396 ++
> > >  drivers/gpu/drm/xocl/userpf/xocl_sysfs.c   |  344 ++
> > >  drivers/gpu/drm/xocl/version.h             |   22 +
> > >  drivers/gpu/drm/xocl/xclbin.h              |  314 ++
> > >  drivers/gpu/drm/xocl/xclfeatures.h         |  107 +
> > >  drivers/gpu/drm/xocl/xocl_ctx.c            |  196 +
> > >  drivers/gpu/drm/xocl/xocl_drm.h            |   91 +
> > >  drivers/gpu/drm/xocl/xocl_drv.h            |  783 ++++
> > >  drivers/gpu/drm/xocl/xocl_subdev.c         |  540 +++
> > >  drivers/gpu/drm/xocl/xocl_thread.c         |   64 +
> > >  include/uapi/drm/xmgmt_drm.h               |  204 +
> > >  include/uapi/drm/xocl_drm.h                |  483 +++
> > >  50 files changed, 28252 insertions(+)  create mode 100644
> > > drivers/gpu/drm/xocl/Kconfig  create mode 100644
> > > drivers/gpu/drm/xocl/Makefile  create mode 100644
> > > drivers/gpu/drm/xocl/devices.h  create mode 100644
> > > drivers/gpu/drm/xocl/ert.h  create mode 100644
> > > drivers/gpu/drm/xocl/lib/Makefile.in
> > >  create mode 100644 drivers/gpu/drm/xocl/lib/cdev_sgdma.h
> > >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.c
> > >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.h
> > >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma_api.h
> > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/Makefile
> > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c
> > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h
> > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c
> > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c
> > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h
> > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c
> > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/dna.c  create mode
> > > 100644 drivers/gpu/drm/xocl/subdev/feature_rom.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/firewall.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/fmgr.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/icap.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/mailbox.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/mb_scheduler.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/microblaze.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/mig.c  create mode
> > > 100644 drivers/gpu/drm/xocl/subdev/sysmon.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/xdma.c
> > >  create mode 100644 drivers/gpu/drm/xocl/subdev/xmc.c  create mode
> > > 100644 drivers/gpu/drm/xocl/subdev/xvc.c  create mode 100644
> > > drivers/gpu/drm/xocl/userpf/Makefile
> > >  create mode 100644 drivers/gpu/drm/xocl/userpf/common.h
> > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.c
> > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.h
> > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drm.c
> > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drv.c
> > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_ioctl.c
> > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_sysfs.c
> > >  create mode 100644 drivers/gpu/drm/xocl/version.h  create mode 100644
> > > drivers/gpu/drm/xocl/xclbin.h  create mode 100644
> > > drivers/gpu/drm/xocl/xclfeatures.h
> > >  create mode 100644 drivers/gpu/drm/xocl/xocl_ctx.c  create mode
> > > 100644 drivers/gpu/drm/xocl/xocl_drm.h  create mode 100644
> > > drivers/gpu/drm/xocl/xocl_drv.h  create mode 100644
> > > drivers/gpu/drm/xocl/xocl_subdev.c
> > >  create mode 100644 drivers/gpu/drm/xocl/xocl_thread.c
> > >  create mode 100644 include/uapi/drm/xmgmt_drm.h  create mode 100644
> > > include/uapi/drm/xocl_drm.h
> > >
> > > --
> > > 2.17.0
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
