Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD98206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MSX9aktC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfC1AOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:14:05 -0400
Received: from mail-eopbgr800073.outbound.protection.outlook.com ([40.107.80.73]:19280
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbfC1AOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9WKaqWN3b9pE4lkv8c439Rs1TJtBguaCvY9gOi8f/o=;
 b=MSX9aktC3R/DQjP6kVt2N4DSsb5jBonVR6rSB4bz6fLtvC8xus4ckwTQP8hFss4BwCTgGc5vG5ijT2a+MsvBKD74zZZoGrc30PLuecvGr9WEy8TvFdOVYyI73qSqosN9vWxdeVbqi7q/EkYaIxT5hCG7PSNtIZFX1hHFROTTwvE=
Received: from BYAPR02MB5160.namprd02.prod.outlook.com (20.176.254.33) by
 BYAPR02MB3974.namprd02.prod.outlook.com (20.176.248.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 00:13:55 +0000
Received: from BYAPR02MB5160.namprd02.prod.outlook.com
 ([fe80::21a0:9cd3:90cb:7d7b]) by BYAPR02MB5160.namprd02.prod.outlook.com
 ([fe80::21a0:9cd3:90cb:7d7b%5]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019
 00:13:55 +0000
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
Thread-Index: AQHU3p5QKbxkgyec50+i8ouG/VB2wqYc1UkAgAHB29CAAJggAIAAPv4AgAAifICAAJorkA==
Date:   Thu, 28 Mar 2019 00:13:55 +0000
Message-ID: <BYAPR02MB5160162639C2EAC6B19901B7BB590@BYAPR02MB5160.namprd02.prod.outlook.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
 <20190325202810.GG2665@phenom.ffwll.local>
 <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
 <CAKMK7uHh5KNaTO+a4ZA+vPQcPKUBwODsx+pPCWNp3sxe9TFP0Q@mail.gmail.com>
 <BYAPR02MB51603A1AD72F704112B55B90BB580@BYAPR02MB5160.namprd02.prod.outlook.com>
 <20190327141137.GK2665@phenom.ffwll.local>
In-Reply-To: <20190327141137.GK2665@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sonals@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e892efb-85ff-4d0e-26f8-08d6b312442c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB3974;
x-ms-traffictypediagnostic: BYAPR02MB3974:
x-ms-exchange-purlcount: 10
x-microsoft-antispam-prvs: <BYAPR02MB3974D877A996E3171F95AA42BB590@BYAPR02MB3974.namprd02.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(366004)(346002)(376002)(189003)(199004)(13464003)(11346002)(3846002)(76176011)(97736004)(446003)(105586002)(316002)(6916009)(6116002)(8936002)(5660300002)(52536014)(2906002)(7696005)(71190400001)(6506007)(14444005)(256004)(54906003)(71200400001)(33656002)(93886005)(9686003)(8676002)(55016002)(81156014)(81166006)(74316002)(478600001)(6306002)(476003)(99286004)(305945005)(68736007)(229853002)(347745004)(6246003)(587094005)(86362001)(186003)(26005)(53546011)(25786009)(4326008)(486006)(7736002)(30864003)(14454004)(53946003)(53936002)(966005)(66066001)(6436002)(53386004)(106356001)(102836004)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB3974;H:BYAPR02MB5160.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I4jJyLnHnah1Tr7Q9LqCz+l9YrLXQKmXMf64bzwHA2SElHfMM7eP9vvrC61Pm5ru+qNZ6n/EMy6G4fO4tPz0hFx1WgmVPTyTLfygrFKiSvVGki2knQ0E0eKz0OAGFaY3st+MhDWYjaYuDH2zZESnVjkDFiPWXVbVXR0SGL7XyHAYJxURs+cfxmcLqiWiokQZqPvwpaFQpol2UX+Zo8qoQ6RI4BN8Xo3KeU77/l1PfHsXd8wDT7f7UkruZu6f4Ufl9gO9iTNikqvH3WnPHYcjm0rc2yi2wda0wyXDo11StVZJ1QmmD7eQCK5tdO+mh7WUWFTRecni5a2LuoJrtcXAp8ki05GWsg2KbEJxDu27IDqv4HdnanfR6jLM6RA2K+RpDnvIKP9mJVt4YY9jZ4oedddefQiL4PvOGzdIPMosSjk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e892efb-85ff-4d0e-26f8-08d6b312442c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 00:13:55.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3974
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of Daniel V=
etter
> Sent: Wednesday, March 27, 2019 7:12 AM
> To: Sonal Santan <sonals@xilinx.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>; dri-devel@lists.freedesktop.org;
> gregkh@linuxfoundation.org; Cyril Chemparathy <cyrilc@xilinx.com>; linux-
> kernel@vger.kernel.org; Lizhi Hou <lizhih@xilinx.com>; Michal Simek
> <michals@xilinx.com>; airlied@redhat.com
> Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
>=20
> On Wed, Mar 27, 2019 at 12:50:14PM +0000, Sonal Santan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Daniel Vetter [mailto:daniel@ffwll.ch]
> > > Sent: Wednesday, March 27, 2019 1:23 AM
> > > To: Sonal Santan <sonals@xilinx.com>
> > > Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org;
> > > Cyril Chemparathy <cyrilc@xilinx.com>; linux-kernel@vger.kernel.org;
> > > Lizhi Hou <lizhih@xilinx.com>; Michal Simek <michals@xilinx.com>;
> > > airlied@redhat.com
> > > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator
> > > driver
> > >
> > > On Wed, Mar 27, 2019 at 12:30 AM Sonal Santan <sonals@xilinx.com>
> wrote:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of
> > > > > Daniel Vetter
> > > > > Sent: Monday, March 25, 2019 1:28 PM
> > > > > To: Sonal Santan <sonals@xilinx.com>
> > > > > Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org;
> > > > > Cyril Chemparathy <cyrilc@xilinx.com>;
> > > > > linux-kernel@vger.kernel.org; Lizhi Hou <lizhih@xilinx.com>;
> > > > > Michal Simek <michals@xilinx.com>; airlied@redhat.com
> > > > > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe
> > > > > accelerator driver
> > > > >
> > > > > On Tue, Mar 19, 2019 at 02:53:55PM -0700,
> > > > > sonal.santan@xilinx.com
> > > wrote:
> > > > > > From: Sonal Santan <sonal.santan@xilinx.com>
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > This patch series adds drivers for Xilinx Alveo PCIe accelerato=
r cards.
> > > > > > These drivers are part of Xilinx Runtime (XRT) open source
> > > > > > stack and have been deployed by leading FaaS vendors and many
> > > > > > enterprise
> > > > > customers.
> > > > >
> > > > > Cool, first fpga driver submitted to drm! And from a high level
> > > > > I think this makes a lot of sense.
> > > > >
> > > > > > PLATFORM ARCHITECTURE
> > > > > >
> > > > > > Alveo PCIe platforms have a static shell and a reconfigurable
> > > > > > (dynamic) region. The shell is automatically loaded from PROM
> > > > > > when host is booted and PCIe is enumerated by BIOS. Shell
> > > > > > cannot be changed till next cold reboot. The shell exposes two
> physical functions:
> > > > > > management physical function and user physical function.
> > > > > >
> > > > > > Users compile their high level design in C/C++/OpenCL or RTL
> > > > > > into FPGA image using SDx compiler. The FPGA image packaged as
> > > > > > xclbin file can be loaded onto reconfigurable region. The
> > > > > > image may contain one or more compute unit. Users can
> > > > > > dynamically swap the full image running on the reconfigurable
> > > > > > region in order to switch between different
> > > > > workloads.
> > > > > >
> > > > > > XRT DRIVERS
> > > > > >
> > > > > > XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is
> > > > > > modular and organized into several platform drivers which
> > > > > > primarily handle the following functionality:
> > > > > > 1.  ICAP programming (FPGA bitstream download with FPGA Mgr
> > > > > > integration) 2.  Clock scaling 3.  Loading firmware container
> > > > > > also called dsabin (embedded Microblaze
> > > > > >     firmware for ERT and XMC, optional clearing bitstream) 4.
> > > > > > In-band
> > > > > > sensors: temp, voltage, power, etc.
> > > > > > 5.  AXI Firewall management
> > > > > > 6.  Device reset and rescan
> > > > > > 7.  Hardware mailbox for communication between two physical
> > > > > > functions
> > > > > >
> > > > > > XRT Linux kernel driver xocl binds to user pf. Like its peer,
> > > > > > this driver is also modular and organized into several
> > > > > > platform drivers which handle the following functionality:
> > > > > > 1.  Device memory topology discovery and memory management 2.
> > > > > > Buffer object abstraction and management for client process 3.
> > > > > > XDMA MM PCIe DMA engine programming 4.  Multi-process aware
> > > context management 5.
> > > > > > Compute unit execution management (optionally with help of ERT)
> for
> > > > > >     client processes
> > > > > > 6.  Hardware mailbox for communication between two physical
> > > > > > functions
> > > > > >
> > > > > > The drivers export ioctls and sysfs nodes for various services.
> > > > > > xocl driver makes heavy use of DRM GEM features for device
> > > > > > memory management, reference counting, mmap support and
> export/import.
> > > > > > xocl also includes a simple scheduler called KDS which
> > > > > > schedules compute units and interacts with hardware scheduler
> > > > > > running ERT firmware. The scheduler understands custom opcodes
> > > > > > packaged into command objects
> > > > > and
> > > > > > provides an asynchronous command done notification via POSIX po=
ll.
> > > > > >
> > > > > > More details on architecture, software APIs, ioctl
> > > > > > definitions, execution model, etc. is available as Sphinx
> > > > > > documentation--
> > > > > >
> > > > > > https://xilinx.github.io/XRT/2018.3/html/index.html
> > > > > >
> > > > > > The complete runtime software stack (XRT) which includes out
> > > > > > of tree kernel drivers, user space libraries, board utilities
> > > > > > and firmware for the hardware scheduler is open source and
> > > > > > available at https://github.com/Xilinx/XRT
> > > > >
> > > > > Before digging into the implementation side more I looked into
> > > > > the userspace here. I admit I got lost a bit, since there's lots
> > > > > of indirections and abstractions going on, but it seems like
> > > > > this is just a fancy ioctl wrapper/driver backend abstractions.
> > > > > Not really
> > > something applications would use.
> > > > Sonal Santan <sonals@xilinx.com>
> > > >
> > > > 4:20 PM (1 minute ago)
> > > >
> > > > to me
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch] On Behalf Of
> > > > > Daniel Vetter
> > > > > Sent: Monday, March 25, 2019 1:28 PM
> > > > > To: Sonal Santan <sonals@xilinx.com>
> > > > > Cc: dri-devel@lists.freedesktop.org; gregkh@linuxfoundation.org;
> > > > > Cyril Chemparathy <cyrilc@xilinx.com>;
> > > > > linux-kernel@vger.kernel.org; Lizhi Hou <lizhih@xilinx.com>;
> > > > > Michal Simek <michals@xilinx.com>; airlied@redhat.com
> > > > > Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe
> > > > > accelerator driver
> > > > >
> > > > > On Tue, Mar 19, 2019 at 02:53:55PM -0700,
> > > > > sonal.santan@xilinx.com
> > > wrote:
> > > > > > From: Sonal Santan <sonal.santan@xilinx.com>
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > This patch series adds drivers for Xilinx Alveo PCIe accelerato=
r cards.
> > > > > > These drivers are part of Xilinx Runtime (XRT) open source
> > > > > > stack and have been deployed by leading FaaS vendors and many
> > > > > > enterprise
> > > > > customers.
> > > > >
> > > > > Cool, first fpga driver submitted to drm! And from a high level
> > > > > I think this makes a lot of sense.
> > > > >
> > > > > > PLATFORM ARCHITECTURE
> > > > > >
> > > > > > Alveo PCIe platforms have a static shell and a reconfigurable
> > > > > > (dynamic) region. The shell is automatically loaded from PROM
> > > > > > when host is booted and PCIe is enumerated by BIOS. Shell
> > > > > > cannot be changed till next cold reboot. The shell exposes two
> physical functions:
> > > > > > management physical function and user physical function.
> > > > > >
> > > > > > Users compile their high level design in C/C++/OpenCL or RTL
> > > > > > into FPGA image using SDx compiler. The FPGA image packaged as
> > > > > > xclbin file can be loaded onto reconfigurable region. The
> > > > > > image may contain one or more compute unit. Users can
> > > > > > dynamically swap the full image running on the reconfigurable
> > > > > > region in order to switch between different
> > > > > workloads.
> > > > > >
> > > > > > XRT DRIVERS
> > > > > >
> > > > > > XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is
> > > > > > modular and organized into several platform drivers which
> > > > > > primarily handle the following functionality:
> > > > > > 1.  ICAP programming (FPGA bitstream download with FPGA Mgr
> > > > > > integration) 2.  Clock scaling 3.  Loading firmware container
> > > > > > also called dsabin (embedded Microblaze
> > > > > >     firmware for ERT and XMC, optional clearing bitstream) 4.
> > > > > > In-band
> > > > > > sensors: temp, voltage, power, etc.
> > > > > > 5.  AXI Firewall management
> > > > > > 6.  Device reset and rescan
> > > > > > 7.  Hardware mailbox for communication between two physical
> > > > > > functions
> > > > > >
> > > > > > XRT Linux kernel driver xocl binds to user pf. Like its peer,
> > > > > > this driver is also modular and organized into several
> > > > > > platform drivers which handle the following functionality:
> > > > > > 1.  Device memory topology discovery and memory management 2.
> > > > > > Buffer object abstraction and management for client process 3.
> > > > > > XDMA MM PCIe DMA engine programming 4.  Multi-process aware
> > > context management 5.
> > > > > > Compute unit execution management (optionally with help of ERT)
> for
> > > > > >     client processes
> > > > > > 6.  Hardware mailbox for communication between two physical
> > > > > > functions
> > > > > >
> > > > > > The drivers export ioctls and sysfs nodes for various services.
> > > > > > xocl driver makes heavy use of DRM GEM features for device
> > > > > > memory management, reference counting, mmap support and
> export/import.
> > > > > > xocl also includes a simple scheduler called KDS which
> > > > > > schedules compute units and interacts with hardware scheduler
> > > > > > running ERT firmware. The scheduler understands custom opcodes
> > > > > > packaged into command objects
> > > > > and
> > > > > > provides an asynchronous command done notification via POSIX po=
ll.
> > > > > >
> > > > > > More details on architecture, software APIs, ioctl
> > > > > > definitions, execution model, etc. is available as Sphinx
> > > > > > documentation--
> > > > > >
> > > > > > https://xilinx.github.io/XRT/2018.3/html/index.html
> > > > > >
> > > > > > The complete runtime software stack (XRT) which includes out
> > > > > > of tree kernel drivers, user space libraries, board utilities
> > > > > > and firmware for the hardware scheduler is open source and
> > > > > > available at https://github.com/Xilinx/XRT
> > > > >
> > > > > Before digging into the implementation side more I looked into
> > > > > the userspace here. I admit I got lost a bit, since there's lots
> > > > > of indirections and abstractions going on, but it seems like
> > > > > this is just a fancy ioctl wrapper/driver backend abstractions.
> > > > > Not really
> > > something applications would use.
> > > > >
> > > >
> > > > Appreciate your feedback.
> > > >
> > > > The userspace libraries define a common abstraction but have
> > > > different implementations for Zynq Ultrascale+ embedded platform,
> > > > PCIe based Alveo (and Faas) and emulation flows. The latter lets
> > > > you run your
> > > application without physical hardware.
> > > >
> > > > >
> > > > > From the pretty picture on github it looks like there's some
> > > > > opencl/ml/other fancy stuff sitting on top that applications
> > > > > would use. Is
> > > that also available?
> > > >
> > > > The full OpenCL runtime is available in the same repository.
> > > > Xilinx ML Suite is also based on XRT and its source can be found
> > > > at
> > > https://github.com/Xilinx/ml-suite.
> > >
> > > Hm, I did a few git grep for the usual opencl entry points, but
> > > didn't find anything. Do I need to run some build scripts first
> > > (which downloads additional sourcecode)? Or is there some symbol
> > > mangling going on and that's why I don't find anything? Pointers very
> much appreciated.
> >
> > The bulk of the OCL runtime code can be found inside
> > https://github.com/Xilinx/XRT/tree/master/src/runtime_src/xocl.
> > The OCL runtime also includes
> https://github.com/Xilinx/XRT/tree/master/src/runtime_src/xrt.
> > The OCL runtime library called libxilinxopencl.so in turn then uses XRT=
 APIs
> to talk to the drivers.
> > For PCIe these XRT APIs are implemented in the library libxrt_core.so
> > the source for which is
> https://github.com/Xilinx/XRT/tree/master/src/runtime_src/driver/xclng/xr=
t.
> >
> > You can build a fully functioning runtime stack by following very
> > simple build instructions--
> > https://xilinx.github.io/XRT/master/html/build.html
> >
> > We do have a few dependencies on standard Linux packages including a
> > few OpenCL packages bundled by Linux distros: ocl-icd, ocl-icd-devel
> > and opencl-headers
>=20
> Thanks a lot for pointers. No idea why I didn't find this stuff, I guess =
I was
> blind.
>=20
> The thing I'm really interested in is the compiler, since at least the ex=
perience
> from gpus says that very much is part of the overall uapi, and definitely
> needed to be able to make any chances to the implementation.
> Looking at clCreateProgramWithSource there's only a lookup up cached
> compiles (it looks for xclbin), and src/runtime_src/xclbin doesn't look l=
ike that
> provides a compiler either. It seems like apps need to precompile everyth=
ing
> first. Am I again missing something, or is this how it's supposed to work=
?
>=20
XRT works with precompiled binaries which are compiled by Xilinx SDx compil=
er=20
called xocc. The binary (xclbin) is loaded by clCreateProgramWithBinary().=
=20

> Note: There's no expectation for the fully optimizing compiler, and we're
> totally ok if there's an optimizing proprietary compiler and a basic open=
 one
> (amd, and bunch of other companies all have such dual stacks running on t=
op
> of drm kernel drivers). But a basic compiler that can convert basic kerne=
ls into
> machine code is expected.
>=20
Although the compiler is not open source the compilation flow lets users ex=
amine
output from various stages. For example if you write your kernel in OpenCL/=
C/C++=20
you can view the RTL (Verilog/VHDL) output produced by first stage of compi=
lation.=20
Note that the compiler is really generating a custom circuit given a high l=
evel=20
input which in the last phase gets synthesized into bitstream. Expert hardw=
are=20
designers can handcraft a circuit in RTL and feed it to the compiler. Our F=
PGA tools=20
let you view the generated hardware design, the register map, etc. You can =
get more=20
information about a compiled design by running XRT tool like xclbinutil on =
the=20
generated file.

In essence compiling for FPGAs is quite different than compiling for GPU/CP=
U/DSP.
Interestingly FPGA compilers can run anywhere from 30 mins to a few hours t=
o=20
compile a testcase.

Thanks,
-Sonal

> Thanks, Daniel
>=20
> >
> > Thanks,
> > -Sonal
> >
> > >
> > > > Typically end users use OpenCL APIs which are part of XRT stack.
> > > > One can write an application to directly call XRT APIs defined at
> > > > https://xilinx.github.io/XRT/2018.3/html/xclhal2.main.html
> > >
> > > I have no clue about DNN/ML unfortunately, I think I'll try to look
> > > into the ocl side a bit more first.
> > >
> > > Thanks, Daniel
> > >
> > > >
> > > > Thanks,
> > > > -Sonal
> > > > >
> > > > > Thanks, Daniel
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > -Sonal
> > > > > >
> > > > > > Sonal Santan (6):
> > > > > >   Add skeleton code: ioctl definitions and build hooks
> > > > > >   Global data structures shared between xocl and xmgmt drivers
> > > > > >   Add platform drivers for various IPs and frameworks
> > > > > >   Add core of XDMA driver
> > > > > >   Add management driver
> > > > > >   Add user physical function driver
> > > > > >
> > > > > >  drivers/gpu/drm/Kconfig                    |    2 +
> > > > > >  drivers/gpu/drm/Makefile                   |    1 +
> > > > > >  drivers/gpu/drm/xocl/Kconfig               |   22 +
> > > > > >  drivers/gpu/drm/xocl/Makefile              |    3 +
> > > > > >  drivers/gpu/drm/xocl/devices.h             |  954 +++++
> > > > > >  drivers/gpu/drm/xocl/ert.h                 |  385 ++
> > > > > >  drivers/gpu/drm/xocl/lib/Makefile.in       |   16 +
> > > > > >  drivers/gpu/drm/xocl/lib/cdev_sgdma.h      |   63 +
> > > > > >  drivers/gpu/drm/xocl/lib/libxdma.c         | 4368
> ++++++++++++++++++++
> > > > > >  drivers/gpu/drm/xocl/lib/libxdma.h         |  596 +++
> > > > > >  drivers/gpu/drm/xocl/lib/libxdma_api.h     |  127 +
> > > > > >  drivers/gpu/drm/xocl/mgmtpf/Makefile       |   29 +
> > > > > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c    |  960 +++++
> > > > > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h    |  147 +
> > > > > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c      |   30 +
> > > > > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c   |  148 +
> > > > > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h     |  244 ++
> > > > > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c   |  318 ++
> > > > > >  drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c   |  399 ++
> > > > > >  drivers/gpu/drm/xocl/subdev/dna.c          |  356 ++
> > > > > >  drivers/gpu/drm/xocl/subdev/feature_rom.c  |  412 ++
> > > > > >  drivers/gpu/drm/xocl/subdev/firewall.c     |  389 ++
> > > > > >  drivers/gpu/drm/xocl/subdev/fmgr.c         |  198 +
> > > > > >  drivers/gpu/drm/xocl/subdev/icap.c         | 2859 ++++++++++++=
+
> > > > > >  drivers/gpu/drm/xocl/subdev/mailbox.c      | 1868 +++++++++
> > > > > >  drivers/gpu/drm/xocl/subdev/mb_scheduler.c | 3059
> ++++++++++++++
> > > > > >  drivers/gpu/drm/xocl/subdev/microblaze.c   |  722 ++++
> > > > > >  drivers/gpu/drm/xocl/subdev/mig.c          |  256 ++
> > > > > >  drivers/gpu/drm/xocl/subdev/sysmon.c       |  385 ++
> > > > > >  drivers/gpu/drm/xocl/subdev/xdma.c         |  510 +++
> > > > > >  drivers/gpu/drm/xocl/subdev/xmc.c          | 1480 +++++++
> > > > > >  drivers/gpu/drm/xocl/subdev/xvc.c          |  461 +++
> > > > > >  drivers/gpu/drm/xocl/userpf/Makefile       |   27 +
> > > > > >  drivers/gpu/drm/xocl/userpf/common.h       |  157 +
> > > > > >  drivers/gpu/drm/xocl/userpf/xocl_bo.c      | 1255 ++++++
> > > > > >  drivers/gpu/drm/xocl/userpf/xocl_bo.h      |  119 +
> > > > > >  drivers/gpu/drm/xocl/userpf/xocl_drm.c     |  640 +++
> > > > > >  drivers/gpu/drm/xocl/userpf/xocl_drv.c     |  743 ++++
> > > > > >  drivers/gpu/drm/xocl/userpf/xocl_ioctl.c   |  396 ++
> > > > > >  drivers/gpu/drm/xocl/userpf/xocl_sysfs.c   |  344 ++
> > > > > >  drivers/gpu/drm/xocl/version.h             |   22 +
> > > > > >  drivers/gpu/drm/xocl/xclbin.h              |  314 ++
> > > > > >  drivers/gpu/drm/xocl/xclfeatures.h         |  107 +
> > > > > >  drivers/gpu/drm/xocl/xocl_ctx.c            |  196 +
> > > > > >  drivers/gpu/drm/xocl/xocl_drm.h            |   91 +
> > > > > >  drivers/gpu/drm/xocl/xocl_drv.h            |  783 ++++
> > > > > >  drivers/gpu/drm/xocl/xocl_subdev.c         |  540 +++
> > > > > >  drivers/gpu/drm/xocl/xocl_thread.c         |   64 +
> > > > > >  include/uapi/drm/xmgmt_drm.h               |  204 +
> > > > > >  include/uapi/drm/xocl_drm.h                |  483 +++
> > > > > >  50 files changed, 28252 insertions(+)  create mode 100644
> > > > > > drivers/gpu/drm/xocl/Kconfig  create mode 100644
> > > > > > drivers/gpu/drm/xocl/Makefile  create mode 100644
> > > > > > drivers/gpu/drm/xocl/devices.h  create mode 100644
> > > > > > drivers/gpu/drm/xocl/ert.h  create mode 100644
> > > > > > drivers/gpu/drm/xocl/lib/Makefile.in
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/lib/cdev_sgdma.h
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.h
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/lib/libxdma_api.h
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/Makefile
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/dna.c  create
> > > > > > mode
> > > > > > 100644 drivers/gpu/drm/xocl/subdev/feature_rom.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/firewall.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/fmgr.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/icap.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/mailbox.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/mb_scheduler.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/microblaze.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/mig.c  create
> > > > > > mode
> > > > > > 100644 drivers/gpu/drm/xocl/subdev/sysmon.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/xdma.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/subdev/xmc.c  create
> > > > > > mode
> > > > > > 100644 drivers/gpu/drm/xocl/subdev/xvc.c  create mode 100644
> > > > > > drivers/gpu/drm/xocl/userpf/Makefile
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/userpf/common.h
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.h
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drm.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drv.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_ioctl.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_sysfs.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/version.h  create
> > > > > > mode
> > > > > > 100644 drivers/gpu/drm/xocl/xclbin.h  create mode 100644
> > > > > > drivers/gpu/drm/xocl/xclfeatures.h
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/xocl_ctx.c  create
> > > > > > mode
> > > > > > 100644 drivers/gpu/drm/xocl/xocl_drm.h  create mode 100644
> > > > > > drivers/gpu/drm/xocl/xocl_drv.h  create mode 100644
> > > > > > drivers/gpu/drm/xocl/xocl_subdev.c
> > > > > >  create mode 100644 drivers/gpu/drm/xocl/xocl_thread.c
> > > > > >  create mode 100644 include/uapi/drm/xmgmt_drm.h  create mode
> > > > > > 100644 include/uapi/drm/xocl_drm.h
> > > > > >
> > > > > > --
> > > > > > 2.17.0
> > > > > > _______________________________________________
> > > > > > dri-devel mailing list
> > > > > > dri-devel@lists.freedesktop.org
> > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation http://blog.ffwll.ch
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>=20
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
