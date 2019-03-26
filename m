Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0915CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A54920811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1QRdjsgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbfCZXay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:30:54 -0400
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:44266
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731583AbfCZXax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7d8uqEdeRfl032M2KMP3XRBQ3AbFRD4Gz8GXW84V2E=;
 b=1QRdjsgbrsN/sxl76XzC1tJKeVyejEBy/qrJr1jzLkchxwtX2o/gHDdHvLWdmgq26cmotw+mUZ6kSK1Lzf9huM71hBa2H5t+VbGcq337NzZnCV3gjdxURR6avlidjdMrFohARyzaFTwfkU8A9oJuM3tbjgTI+4L5OJB6jN9ClEo=
Received: from BYAPR02MB5160.namprd02.prod.outlook.com (20.176.254.33) by
 BYAPR02MB4549.namprd02.prod.outlook.com (52.135.239.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 23:30:43 +0000
Received: from BYAPR02MB5160.namprd02.prod.outlook.com
 ([fe80::21a0:9cd3:90cb:7d7b]) by BYAPR02MB5160.namprd02.prod.outlook.com
 ([fe80::21a0:9cd3:90cb:7d7b%5]) with mapi id 15.20.1730.017; Tue, 26 Mar 2019
 23:30:43 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Cyril Chemparathy <cyrilc@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "airlied@redhat.com" <airlied@redhat.com>
Subject: RE: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
Thread-Topic: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
Thread-Index: AQHU3p5QKbxkgyec50+i8ouG/VB2wqYc1UkAgAHB29A=
Date:   Tue, 26 Mar 2019 23:30:43 +0000
Message-ID: <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
 <20190325202810.GG2665@phenom.ffwll.local>
In-Reply-To: <20190325202810.GG2665@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sonals@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7093ed16-f87f-4e4c-b2a9-08d6b24310e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4549;
x-ms-traffictypediagnostic: BYAPR02MB4549:
x-ms-exchange-purlcount: 6
x-microsoft-antispam-prvs: <BYAPR02MB4549160609FD01F3FBA9BB1EBB5F0@BYAPR02MB4549.namprd02.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(366004)(346002)(376002)(189003)(199004)(13464003)(53936002)(53946003)(476003)(14454004)(9686003)(446003)(6116002)(11346002)(256004)(3846002)(105586002)(6246003)(71200400001)(66066001)(486006)(71190400001)(86362001)(14444005)(106356001)(2906002)(6436002)(99286004)(7736002)(229853002)(316002)(6916009)(33656002)(4326008)(6306002)(26005)(6506007)(25786009)(76176011)(7696005)(55016002)(97736004)(347745004)(478600001)(30864003)(186003)(8676002)(81156014)(68736007)(5660300002)(52536014)(81166006)(305945005)(966005)(74316002)(8936002)(54906003)(53546011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4549;H:BYAPR02MB5160.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tEsBcjyZm+KW8lPxMFOzaML5ynZibN+JkoiZFJIpT3arevDYEm3HP+YTAeihB/8NbVaBeMm1MrwAFglZH1Ss+bqTj/i3DK+fG6rqgpvtgInEm/x4QLXl8Qdax2a7xb4eW0k8RkvG2oQt0CiclBmaVn/Vd6HSEaMbaGwdZMsFOiTtuCzHLVlRpPsn3x7ggdfv1jEumljT3TKAbYkkStNXyc73BjtVQLlLfi5fG2sfKGJjwzZcb5ZorWRKDi3hR6B8xLzIyWs0Qnk0bMBsyBej1b2g4/hWKB4iY4EosDUHDan5N4QHMzq1+CaDrZ1h0lz5vjAOqSpKth/Qav7QwWDQXaGuyJ+tfjRiXweVno5Wp7Wbaw4P5DVoGQAwEigMKEV0m+A4wQKQRA7hX2rrWPwjHrChESSDuCIRtcpH+dbzbns=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7093ed16-f87f-4e4c-b2a9-08d6b24310e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 23:30:43.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel V=
etter
> Sent: Monday, March 25, 2019 1:28 PM
> To: Sonal Santan <sonals@xilinx.com>
> Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org; Cyril
> Chemparathy <cyrilc@xilinx.com>; linux-kernel@vger.kernel.org; Lizhi Hou
> <lizhih@xilinx.com>; Michal Simek <michals@xilinx.com>; airlied@redhat.co=
m
> Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
>=20
> On Tue, Mar 19, 2019 at 02:53:55PM -0700, sonal.santan@xilinx.com wrote:
> > From: Sonal Santan <sonal.santan@xilinx.com>
> >
> > Hello,
> >
> > This patch series adds drivers for Xilinx Alveo PCIe accelerator cards.
> > These drivers are part of Xilinx Runtime (XRT) open source stack and
> > have been deployed by leading FaaS vendors and many enterprise
> customers.
>=20
> Cool, first fpga driver submitted to drm! And from a high level I think t=
his
> makes a lot of sense.
>=20
> > PLATFORM ARCHITECTURE
> >
> > Alveo PCIe platforms have a static shell and a reconfigurable
> > (dynamic) region. The shell is automatically loaded from PROM when
> > host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
> > till next cold reboot. The shell exposes two physical functions:
> > management physical function and user physical function.
> >
> > Users compile their high level design in C/C++/OpenCL or RTL into FPGA
> > image using SDx compiler. The FPGA image packaged as xclbin file can
> > be loaded onto reconfigurable region. The image may contain one or
> > more compute unit. Users can dynamically swap the full image running
> > on the reconfigurable region in order to switch between different
> workloads.
> >
> > XRT DRIVERS
> >
> > XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is modular
> > and organized into several platform drivers which primarily handle the
> > following functionality:
> > 1.  ICAP programming (FPGA bitstream download with FPGA Mgr
> > integration) 2.  Clock scaling 3.  Loading firmware container also
> > called dsabin (embedded Microblaze
> >     firmware for ERT and XMC, optional clearing bitstream) 4.  In-band
> > sensors: temp, voltage, power, etc.
> > 5.  AXI Firewall management
> > 6.  Device reset and rescan
> > 7.  Hardware mailbox for communication between two physical functions
> >
> > XRT Linux kernel driver xocl binds to user pf. Like its peer, this
> > driver is also modular and organized into several platform drivers
> > which handle the following functionality:
> > 1.  Device memory topology discovery and memory management 2.  Buffer
> > object abstraction and management for client process 3.  XDMA MM PCIe
> > DMA engine programming 4.  Multi-process aware context management 5.
> > Compute unit execution management (optionally with help of ERT) for
> >     client processes
> > 6.  Hardware mailbox for communication between two physical functions
> >
> > The drivers export ioctls and sysfs nodes for various services. xocl
> > driver makes heavy use of DRM GEM features for device memory
> > management, reference counting, mmap support and export/import. xocl
> > also includes a simple scheduler called KDS which schedules compute
> > units and interacts with hardware scheduler running ERT firmware. The
> > scheduler understands custom opcodes packaged into command objects
> and
> > provides an asynchronous command done notification via POSIX poll.
> >
> > More details on architecture, software APIs, ioctl definitions,
> > execution model, etc. is available as Sphinx documentation--
> >
> > https://xilinx.github.io/XRT/2018.3/html/index.html
> >
> > The complete runtime software stack (XRT) which includes out of tree
> > kernel drivers, user space libraries, board utilities and firmware for
> > the hardware scheduler is open source and available at
> > https://github.com/Xilinx/XRT
>=20
> Before digging into the implementation side more I looked into the usersp=
ace
> here. I admit I got lost a bit, since there's lots of indirections and ab=
stractions
> going on, but it seems like this is just a fancy ioctl wrapper/driver bac=
kend
> abstractions. Not really something applications would use.
Sonal Santan <sonals@xilinx.com>
=09
4:20 PM (1 minute ago)
=09
to me


> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel V=
etter
> Sent: Monday, March 25, 2019 1:28 PM
> To: Sonal Santan <sonals@xilinx.com>
> Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org; Cyril
> Chemparathy <cyrilc@xilinx.com>; linux-kernel@vger.kernel.org; Lizhi Hou
> <lizhih@xilinx.com>; Michal Simek <michals@xilinx.com>; airlied@redhat.co=
m
> Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
>
> On Tue, Mar 19, 2019 at 02:53:55PM -0700, sonal.santan@xilinx.com wrote:
> > From: Sonal Santan <sonal.santan@xilinx.com>
> >
> > Hello,
> >
> > This patch series adds drivers for Xilinx Alveo PCIe accelerator cards.
> > These drivers are part of Xilinx Runtime (XRT) open source stack and
> > have been deployed by leading FaaS vendors and many enterprise
> customers.
>
> Cool, first fpga driver submitted to drm! And from a high level I think t=
his
> makes a lot of sense.
>
> > PLATFORM ARCHITECTURE
> >
> > Alveo PCIe platforms have a static shell and a reconfigurable
> > (dynamic) region. The shell is automatically loaded from PROM when
> > host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
> > till next cold reboot. The shell exposes two physical functions:
> > management physical function and user physical function.
> >
> > Users compile their high level design in C/C++/OpenCL or RTL into FPGA
> > image using SDx compiler. The FPGA image packaged as xclbin file can
> > be loaded onto reconfigurable region. The image may contain one or
> > more compute unit. Users can dynamically swap the full image running
> > on the reconfigurable region in order to switch between different
> workloads.
> >
> > XRT DRIVERS
> >
> > XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is modular
> > and organized into several platform drivers which primarily handle the
> > following functionality:
> > 1.  ICAP programming (FPGA bitstream download with FPGA Mgr
> > integration) 2.  Clock scaling 3.  Loading firmware container also
> > called dsabin (embedded Microblaze
> >     firmware for ERT and XMC, optional clearing bitstream) 4.  In-band
> > sensors: temp, voltage, power, etc.
> > 5.  AXI Firewall management
> > 6.  Device reset and rescan
> > 7.  Hardware mailbox for communication between two physical functions
> >
> > XRT Linux kernel driver xocl binds to user pf. Like its peer, this
> > driver is also modular and organized into several platform drivers
> > which handle the following functionality:
> > 1.  Device memory topology discovery and memory management 2.  Buffer
> > object abstraction and management for client process 3.  XDMA MM PCIe
> > DMA engine programming 4.  Multi-process aware context management 5.
> > Compute unit execution management (optionally with help of ERT) for
> >     client processes
> > 6.  Hardware mailbox for communication between two physical functions
> >
> > The drivers export ioctls and sysfs nodes for various services. xocl
> > driver makes heavy use of DRM GEM features for device memory
> > management, reference counting, mmap support and export/import. xocl
> > also includes a simple scheduler called KDS which schedules compute
> > units and interacts with hardware scheduler running ERT firmware. The
> > scheduler understands custom opcodes packaged into command objects
> and
> > provides an asynchronous command done notification via POSIX poll.
> >
> > More details on architecture, software APIs, ioctl definitions,
> > execution model, etc. is available as Sphinx documentation--
> >
> > https://xilinx.github.io/XRT/2018.3/html/index.html
> >
> > The complete runtime software stack (XRT) which includes out of tree
> > kernel drivers, user space libraries, board utilities and firmware for
> > the hardware scheduler is open source and available at
> > https://github.com/Xilinx/XRT
>
> Before digging into the implementation side more I looked into the usersp=
ace
> here. I admit I got lost a bit, since there's lots of indirections and ab=
stractions
> going on, but it seems like this is just a fancy ioctl wrapper/driver bac=
kend
> abstractions. Not really something applications would use.
>

Appreciate your feedback.=20

The userspace libraries define a common abstraction but have different impl=
ementations
for Zynq Ultrascale+ embedded platform, PCIe based Alveo (and Faas) and emu=
lation
flows. The latter lets you run your application without physical hardware.

>=20
> From the pretty picture on github it looks like there's some opencl/ml/ot=
her
> fancy stuff sitting on top that applications would use. Is that also avai=
lable?

The full OpenCL runtime is available in the same repository. Xilinx ML Suit=
e is
also based on XRT and its source can be found at https://github.com/Xilinx/=
ml-suite.

Typically end users use OpenCL APIs which are part of XRT stack. One can wr=
ite an
application to directly call XRT APIs defined at=20
https://xilinx.github.io/XRT/2018.3/html/xclhal2.main.html

Thanks,
-Sonal
>=20
> Thanks, Daniel
>=20
> >
> > Thanks,
> > -Sonal
> >
> > Sonal Santan (6):
> >   Add skeleton code: ioctl definitions and build hooks
> >   Global data structures shared between xocl and xmgmt drivers
> >   Add platform drivers for various IPs and frameworks
> >   Add core of XDMA driver
> >   Add management driver
> >   Add user physical function driver
> >
> >  drivers/gpu/drm/Kconfig                    |    2 +
> >  drivers/gpu/drm/Makefile                   |    1 +
> >  drivers/gpu/drm/xocl/Kconfig               |   22 +
> >  drivers/gpu/drm/xocl/Makefile              |    3 +
> >  drivers/gpu/drm/xocl/devices.h             |  954 +++++
> >  drivers/gpu/drm/xocl/ert.h                 |  385 ++
> >  drivers/gpu/drm/xocl/lib/Makefile.in       |   16 +
> >  drivers/gpu/drm/xocl/lib/cdev_sgdma.h      |   63 +
> >  drivers/gpu/drm/xocl/lib/libxdma.c         | 4368 ++++++++++++++++++++
> >  drivers/gpu/drm/xocl/lib/libxdma.h         |  596 +++
> >  drivers/gpu/drm/xocl/lib/libxdma_api.h     |  127 +
> >  drivers/gpu/drm/xocl/mgmtpf/Makefile       |   29 +
> >  drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c    |  960 +++++
> >  drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h    |  147 +
> >  drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c      |   30 +
> >  drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c   |  148 +
> >  drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h     |  244 ++
> >  drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c   |  318 ++
> >  drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c   |  399 ++
> >  drivers/gpu/drm/xocl/subdev/dna.c          |  356 ++
> >  drivers/gpu/drm/xocl/subdev/feature_rom.c  |  412 ++
> >  drivers/gpu/drm/xocl/subdev/firewall.c     |  389 ++
> >  drivers/gpu/drm/xocl/subdev/fmgr.c         |  198 +
> >  drivers/gpu/drm/xocl/subdev/icap.c         | 2859 +++++++++++++
> >  drivers/gpu/drm/xocl/subdev/mailbox.c      | 1868 +++++++++
> >  drivers/gpu/drm/xocl/subdev/mb_scheduler.c | 3059 ++++++++++++++
> >  drivers/gpu/drm/xocl/subdev/microblaze.c   |  722 ++++
> >  drivers/gpu/drm/xocl/subdev/mig.c          |  256 ++
> >  drivers/gpu/drm/xocl/subdev/sysmon.c       |  385 ++
> >  drivers/gpu/drm/xocl/subdev/xdma.c         |  510 +++
> >  drivers/gpu/drm/xocl/subdev/xmc.c          | 1480 +++++++
> >  drivers/gpu/drm/xocl/subdev/xvc.c          |  461 +++
> >  drivers/gpu/drm/xocl/userpf/Makefile       |   27 +
> >  drivers/gpu/drm/xocl/userpf/common.h       |  157 +
> >  drivers/gpu/drm/xocl/userpf/xocl_bo.c      | 1255 ++++++
> >  drivers/gpu/drm/xocl/userpf/xocl_bo.h      |  119 +
> >  drivers/gpu/drm/xocl/userpf/xocl_drm.c     |  640 +++
> >  drivers/gpu/drm/xocl/userpf/xocl_drv.c     |  743 ++++
> >  drivers/gpu/drm/xocl/userpf/xocl_ioctl.c   |  396 ++
> >  drivers/gpu/drm/xocl/userpf/xocl_sysfs.c   |  344 ++
> >  drivers/gpu/drm/xocl/version.h             |   22 +
> >  drivers/gpu/drm/xocl/xclbin.h              |  314 ++
> >  drivers/gpu/drm/xocl/xclfeatures.h         |  107 +
> >  drivers/gpu/drm/xocl/xocl_ctx.c            |  196 +
> >  drivers/gpu/drm/xocl/xocl_drm.h            |   91 +
> >  drivers/gpu/drm/xocl/xocl_drv.h            |  783 ++++
> >  drivers/gpu/drm/xocl/xocl_subdev.c         |  540 +++
> >  drivers/gpu/drm/xocl/xocl_thread.c         |   64 +
> >  include/uapi/drm/xmgmt_drm.h               |  204 +
> >  include/uapi/drm/xocl_drm.h                |  483 +++
> >  50 files changed, 28252 insertions(+)  create mode 100644
> > drivers/gpu/drm/xocl/Kconfig  create mode 100644
> > drivers/gpu/drm/xocl/Makefile  create mode 100644
> > drivers/gpu/drm/xocl/devices.h  create mode 100644
> > drivers/gpu/drm/xocl/ert.h  create mode 100644
> > drivers/gpu/drm/xocl/lib/Makefile.in
> >  create mode 100644 drivers/gpu/drm/xocl/lib/cdev_sgdma.h
> >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.c
> >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.h
> >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma_api.h
> >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/Makefile
> >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c
> >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h
> >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c
> >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c
> >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h
> >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c
> >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/dna.c  create mode
> > 100644 drivers/gpu/drm/xocl/subdev/feature_rom.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/firewall.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/fmgr.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/icap.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/mailbox.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/mb_scheduler.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/microblaze.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/mig.c  create mode
> > 100644 drivers/gpu/drm/xocl/subdev/sysmon.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/xdma.c
> >  create mode 100644 drivers/gpu/drm/xocl/subdev/xmc.c  create mode
> > 100644 drivers/gpu/drm/xocl/subdev/xvc.c  create mode 100644
> > drivers/gpu/drm/xocl/userpf/Makefile
> >  create mode 100644 drivers/gpu/drm/xocl/userpf/common.h
> >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.c
> >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.h
> >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drm.c
> >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drv.c
> >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_ioctl.c
> >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_sysfs.c
> >  create mode 100644 drivers/gpu/drm/xocl/version.h  create mode 100644
> > drivers/gpu/drm/xocl/xclbin.h  create mode 100644
> > drivers/gpu/drm/xocl/xclfeatures.h
> >  create mode 100644 drivers/gpu/drm/xocl/xocl_ctx.c  create mode
> > 100644 drivers/gpu/drm/xocl/xocl_drm.h  create mode 100644
> > drivers/gpu/drm/xocl/xocl_drv.h  create mode 100644
> > drivers/gpu/drm/xocl/xocl_subdev.c
> >  create mode 100644 drivers/gpu/drm/xocl/xocl_thread.c
> >  create mode 100644 include/uapi/drm/xmgmt_drm.h  create mode 100644
> > include/uapi/drm/xocl_drm.h
> >
> > --
> > 2.17.0
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
