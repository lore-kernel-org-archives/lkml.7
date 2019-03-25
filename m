Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08733C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9964520848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YtITiRfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfCYU2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:28:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44904 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:28:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so8703344edh.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wa2un+uW2Uvp5IJAkAwEZdH4mKEWmObG+0Syp9UyP4M=;
        b=YtITiRfw0R0OMOJ/DdQD1F5gZ/+iXEBdSyRwFQT40i4GXbngorJa87rTuMQcld6b/q
         0iauHd0Q6ChIZ1PMubLVz2MBpB6G//qJIoLJzKg9+wrCZZpIareQ0abUv2rU1QYA5+jF
         QwITXGfYTOdyBV89T6h+JTj17UD7OnfLLkrUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wa2un+uW2Uvp5IJAkAwEZdH4mKEWmObG+0Syp9UyP4M=;
        b=Kue0p5YxjmN70E/kOHTFoPYmdOqDDvHS9/ndSS8ui2gEZXVZq85In3PZIect74ob3/
         OTp3nNHKE3DzRRK4sNttQqXtcx8kWyUL3QmOcGN3sZoBIo1w8ynxgKeBlneqxFiPYjYL
         EvH7AQ+rKHNkU2dBnM7ARCw3z8eiiqNck1hi6eKyfanYeZdizexNzGU87Feein8lhZM8
         AwDiwbEKPSNM01qDarI+oK2QoTTODFF094V/yggeZcCN5TRzA7BuBJpdZFYe/dFlUpb1
         U3rcGb9NsvTXJ9UaCbXcFAET3mkgL9Y9wbQRBmJI3K3FAvH35bKerrChuTNQXYR2YLBZ
         k+gQ==
X-Gm-Message-State: APjAAAXGdOxMe9p+X6ISjZQbsAoYJNVr0VHuAE3rRkj5KdEzmZfVMhSR
        J5dN/6W7Od4rCa5Gpr9UjkAp/A==
X-Google-Smtp-Source: APXvYqz/nBtBZc1Iu1mU8L7ieBQf3L6P0eG0PFVo49uiQX3F5TR6+7BS8rxoMSkjoiGxE8rsWUib+A==
X-Received: by 2002:a50:cd06:: with SMTP id z6mr17796251edi.163.1553545693805;
        Mon, 25 Mar 2019 13:28:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c9sm5402804eds.92.2019.03.25.13.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 13:28:12 -0700 (PDT)
Date:   Mon, 25 Mar 2019 21:28:10 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     sonal.santan@xilinx.com
Cc:     dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        cyrilc@xilinx.com, linux-kernel@vger.kernel.org, lizhih@xilinx.com,
        michals@xilinx.com, airlied@redhat.com
Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
Message-ID: <20190325202810.GG2665@phenom.ffwll.local>
Mail-Followup-To: sonal.santan@xilinx.com, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, cyrilc@xilinx.com,
        linux-kernel@vger.kernel.org, lizhih@xilinx.com, michals@xilinx.com,
        airlied@redhat.com
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319215401.6562-1-sonal.santan@xilinx.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 02:53:55PM -0700, sonal.santan@xilinx.com wrote:
> From: Sonal Santan <sonal.santan@xilinx.com>
> 
> Hello,
> 
> This patch series adds drivers for Xilinx Alveo PCIe accelerator cards.
> These drivers are part of Xilinx Runtime (XRT) open source stack and
> have been deployed by leading FaaS vendors and many enterprise customers.

Cool, first fpga driver submitted to drm! And from a high level I think
this makes a lot of sense.

> PLATFORM ARCHITECTURE
> 
> Alveo PCIe platforms have a static shell and a reconfigurable (dynamic)
> region. The shell is automatically loaded from PROM when host is booted
> and PCIe is enumerated by BIOS. Shell cannot be changed till next cold
> reboot. The shell exposes two physical functions: management physical
> function and user physical function.
> 
> Users compile their high level design in C/C++/OpenCL or RTL into FPGA
> image using SDx compiler. The FPGA image packaged as xclbin file can be
> loaded onto reconfigurable region. The image may contain one or more
> compute unit. Users can dynamically swap the full image running on the
> reconfigurable region in order to switch between different workloads.
> 
> XRT DRIVERS
> 
> XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is modular and
> organized into several platform drivers which primarily handle the
> following functionality:
> 1.  ICAP programming (FPGA bitstream download with FPGA Mgr integration)
> 2.  Clock scaling
> 3.  Loading firmware container also called dsabin (embedded Microblaze
>     firmware for ERT and XMC, optional clearing bitstream)
> 4.  In-band sensors: temp, voltage, power, etc.
> 5.  AXI Firewall management
> 6.  Device reset and rescan
> 7.  Hardware mailbox for communication between two physical functions
> 
> XRT Linux kernel driver xocl binds to user pf. Like its peer, this driver
> is also modular and organized into several platform drivers which handle
> the following functionality:
> 1.  Device memory topology discovery and memory management
> 2.  Buffer object abstraction and management for client process
> 3.  XDMA MM PCIe DMA engine programming
> 4.  Multi-process aware context management
> 5.  Compute unit execution management (optionally with help of ERT) for
>     client processes
> 6.  Hardware mailbox for communication between two physical functions
> 
> The drivers export ioctls and sysfs nodes for various services. xocl
> driver makes heavy use of DRM GEM features for device memory management,
> reference counting, mmap support and export/import. xocl also includes a
> simple scheduler called KDS which schedules compute units and interacts
> with hardware scheduler running ERT firmware. The scheduler understands
> custom opcodes packaged into command objects and provides an asynchronous
> command done notification via POSIX poll.
> 
> More details on architecture, software APIs, ioctl definitions, execution
> model, etc. is available as Sphinx documentation--
> 
> https://xilinx.github.io/XRT/2018.3/html/index.html
> 
> The complete runtime software stack (XRT) which includes out of tree
> kernel drivers, user space libraries, board utilities and firmware for
> the hardware scheduler is open source and available at
> https://github.com/Xilinx/XRT

Before digging into the implementation side more I looked into the
userspace here. I admit I got lost a bit, since there's lots of
indirections and abstractions going on, but it seems like this is just a
fancy ioctl wrapper/driver backend abstractions. Not really something
applications would use.

From the pretty picture on github it looks like there's some
opencl/ml/other fancy stuff sitting on top that applications would use. Is
that also available?

Thanks, Daniel

> 
> Thanks,
> -Sonal
> 
> Sonal Santan (6):
>   Add skeleton code: ioctl definitions and build hooks
>   Global data structures shared between xocl and xmgmt drivers
>   Add platform drivers for various IPs and frameworks
>   Add core of XDMA driver
>   Add management driver
>   Add user physical function driver
> 
>  drivers/gpu/drm/Kconfig                    |    2 +
>  drivers/gpu/drm/Makefile                   |    1 +
>  drivers/gpu/drm/xocl/Kconfig               |   22 +
>  drivers/gpu/drm/xocl/Makefile              |    3 +
>  drivers/gpu/drm/xocl/devices.h             |  954 +++++
>  drivers/gpu/drm/xocl/ert.h                 |  385 ++
>  drivers/gpu/drm/xocl/lib/Makefile.in       |   16 +
>  drivers/gpu/drm/xocl/lib/cdev_sgdma.h      |   63 +
>  drivers/gpu/drm/xocl/lib/libxdma.c         | 4368 ++++++++++++++++++++
>  drivers/gpu/drm/xocl/lib/libxdma.h         |  596 +++
>  drivers/gpu/drm/xocl/lib/libxdma_api.h     |  127 +
>  drivers/gpu/drm/xocl/mgmtpf/Makefile       |   29 +
>  drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c    |  960 +++++
>  drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h    |  147 +
>  drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c      |   30 +
>  drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c   |  148 +
>  drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h     |  244 ++
>  drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c   |  318 ++
>  drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c   |  399 ++
>  drivers/gpu/drm/xocl/subdev/dna.c          |  356 ++
>  drivers/gpu/drm/xocl/subdev/feature_rom.c  |  412 ++
>  drivers/gpu/drm/xocl/subdev/firewall.c     |  389 ++
>  drivers/gpu/drm/xocl/subdev/fmgr.c         |  198 +
>  drivers/gpu/drm/xocl/subdev/icap.c         | 2859 +++++++++++++
>  drivers/gpu/drm/xocl/subdev/mailbox.c      | 1868 +++++++++
>  drivers/gpu/drm/xocl/subdev/mb_scheduler.c | 3059 ++++++++++++++
>  drivers/gpu/drm/xocl/subdev/microblaze.c   |  722 ++++
>  drivers/gpu/drm/xocl/subdev/mig.c          |  256 ++
>  drivers/gpu/drm/xocl/subdev/sysmon.c       |  385 ++
>  drivers/gpu/drm/xocl/subdev/xdma.c         |  510 +++
>  drivers/gpu/drm/xocl/subdev/xmc.c          | 1480 +++++++
>  drivers/gpu/drm/xocl/subdev/xvc.c          |  461 +++
>  drivers/gpu/drm/xocl/userpf/Makefile       |   27 +
>  drivers/gpu/drm/xocl/userpf/common.h       |  157 +
>  drivers/gpu/drm/xocl/userpf/xocl_bo.c      | 1255 ++++++
>  drivers/gpu/drm/xocl/userpf/xocl_bo.h      |  119 +
>  drivers/gpu/drm/xocl/userpf/xocl_drm.c     |  640 +++
>  drivers/gpu/drm/xocl/userpf/xocl_drv.c     |  743 ++++
>  drivers/gpu/drm/xocl/userpf/xocl_ioctl.c   |  396 ++
>  drivers/gpu/drm/xocl/userpf/xocl_sysfs.c   |  344 ++
>  drivers/gpu/drm/xocl/version.h             |   22 +
>  drivers/gpu/drm/xocl/xclbin.h              |  314 ++
>  drivers/gpu/drm/xocl/xclfeatures.h         |  107 +
>  drivers/gpu/drm/xocl/xocl_ctx.c            |  196 +
>  drivers/gpu/drm/xocl/xocl_drm.h            |   91 +
>  drivers/gpu/drm/xocl/xocl_drv.h            |  783 ++++
>  drivers/gpu/drm/xocl/xocl_subdev.c         |  540 +++
>  drivers/gpu/drm/xocl/xocl_thread.c         |   64 +
>  include/uapi/drm/xmgmt_drm.h               |  204 +
>  include/uapi/drm/xocl_drm.h                |  483 +++
>  50 files changed, 28252 insertions(+)
>  create mode 100644 drivers/gpu/drm/xocl/Kconfig
>  create mode 100644 drivers/gpu/drm/xocl/Makefile
>  create mode 100644 drivers/gpu/drm/xocl/devices.h
>  create mode 100644 drivers/gpu/drm/xocl/ert.h
>  create mode 100644 drivers/gpu/drm/xocl/lib/Makefile.in
>  create mode 100644 drivers/gpu/drm/xocl/lib/cdev_sgdma.h
>  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.c
>  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.h
>  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma_api.h
>  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/Makefile
>  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c
>  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h
>  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c
>  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c
>  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h
>  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c
>  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/dna.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/feature_rom.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/firewall.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/fmgr.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/icap.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/mailbox.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/mb_scheduler.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/microblaze.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/mig.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/sysmon.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/xdma.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/xmc.c
>  create mode 100644 drivers/gpu/drm/xocl/subdev/xvc.c
>  create mode 100644 drivers/gpu/drm/xocl/userpf/Makefile
>  create mode 100644 drivers/gpu/drm/xocl/userpf/common.h
>  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.c
>  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.h
>  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drm.c
>  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drv.c
>  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_ioctl.c
>  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_sysfs.c
>  create mode 100644 drivers/gpu/drm/xocl/version.h
>  create mode 100644 drivers/gpu/drm/xocl/xclbin.h
>  create mode 100644 drivers/gpu/drm/xocl/xclfeatures.h
>  create mode 100644 drivers/gpu/drm/xocl/xocl_ctx.c
>  create mode 100644 drivers/gpu/drm/xocl/xocl_drm.h
>  create mode 100644 drivers/gpu/drm/xocl/xocl_drv.h
>  create mode 100644 drivers/gpu/drm/xocl/xocl_subdev.c
>  create mode 100644 drivers/gpu/drm/xocl/xocl_thread.c
>  create mode 100644 include/uapi/drm/xmgmt_drm.h
>  create mode 100644 include/uapi/drm/xocl_drm.h
> 
> --
> 2.17.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
