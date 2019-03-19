Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E22AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9162146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sP3qwQKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCSVyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:54:18 -0400
Received: from mail-eopbgr810058.outbound.protection.outlook.com ([40.107.81.58]:39872
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbfCSVyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjwFzwEL+jmbEZqiydc/b9TPpZUlPKee5YMichGPS78=;
 b=sP3qwQKOccykCDnFSGM0dKXJu3btLqCF5FVCy87BpEha3BZku0vhoBAfjLszF//A7cxSnEHM1rDb2xcFoUprty7qW+KLIaddUlQhr7rSPETwv4sOy9Zlz6GYhp1TOkmJBSk5sonr73KdM9DkcYsWLjOv4jrVDSdKSNoETkXFGfI=
Received: from BN6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:404:5f::34)
 by MWHPR02MB2208.namprd02.prod.outlook.com (2603:10b6:300:5a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 21:54:14 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR02CA0048.outlook.office365.com
 (2603:10b6:404:5f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 21:54:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 21:54:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgW-0001QZ-BK; Tue, 19 Mar 2019 14:54:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgR-0001Oa-7J; Tue, 19 Mar 2019 14:54:07 -0700
Received: from [172.19.73.196] (helo=xsjsonals5570.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <sonals@xilinx.com>)
        id 1h6MgL-0001KF-Ok; Tue, 19 Mar 2019 14:54:01 -0700
Received: by xsjsonals5570.xilinx.com (Postfix, from userid 1000)
        id 7A66376001F; Tue, 19 Mar 2019 14:54:01 -0700 (PDT)
From:   <sonal.santan@xilinx.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <airlied@redhat.com>, <cyrilc@xilinx.com>, <michals@xilinx.com>,
        <lizhih@xilinx.com>, <hyunk@xilinx.com>
Subject: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
Date:   Tue, 19 Mar 2019 14:53:55 -0700
Message-ID: <20190319215401.6562-1-sonal.santan@xilinx.com>
X-Mailer: git-send-email 2.17.0
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(199004)(189003)(50466002)(336012)(6266002)(2616005)(52956003)(426003)(6916009)(1076003)(486006)(36756003)(6306002)(6666004)(86152003)(47776003)(476003)(126002)(48376002)(63266004)(5660300002)(356004)(36386004)(14444005)(316002)(42186006)(51416003)(478600001)(106002)(81156014)(2906002)(966005)(8676002)(4326008)(90966002)(50226002)(106466001)(2351001)(305945005)(8936002)(2876002)(54906003)(26005)(186003)(16586007)(107886003)(103686004)(81166006)(347745004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2208;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f89a3cb-a6c8-4499-56f6-08d6acb56cad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:MWHPR02MB2208;
X-MS-TrafficTypeDiagnostic: MWHPR02MB2208:
X-MS-Exchange-PUrlCount: 2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2208ED3D855967BDA65BC1BCBB400@MWHPR02MB2208.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: oDF9+rmYXzHpYp9dK79Qi9QvdV5HFIgaS1rIuByMvGZz1L1WPaWv1T3JnRFe6BPaKLZ2Q/+TLALbPSLhED/mVhKmlxUuSjfhJ6VOLfeD5mVdvudVlilUYJkz/vQeo5e2jDnF1xXkmgmeH8e6TbuayaAT9+Blsa0Z4AwFzBUbcx2gNw3RPc2qMvk8dd2XL6NwAe2aKGgjuCG/aCFVzr4XKsoQOIX5IGZ6hRwIY/1HOtSdFdEJpCtqfagtWpDLOYc6moh3MEbccDeyptAWzeX+cBKnGi+Q+SCW10OUsxOnbmc2mUSYk4TQANafAgolGUlwvwMlqRv/ntmqtPnSqEid7nfRgnkNDrlmuz0lWTb2FyZGtXQZQkE06TH8uDgSD8g+VpZsemF2dSWVdimxBVm70n3SCgtx76IfMTdpIcoW+D8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 21:54:12.9048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f89a3cb-a6c8-4499-56f6-08d6acb56cad
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Hello,

This patch series adds drivers for Xilinx Alveo PCIe accelerator cards.
These drivers are part of Xilinx Runtime (XRT) open source stack and
have been deployed by leading FaaS vendors and many enterprise customers.

PLATFORM ARCHITECTURE

Alveo PCIe platforms have a static shell and a reconfigurable (dynamic)
region. The shell is automatically loaded from PROM when host is booted
and PCIe is enumerated by BIOS. Shell cannot be changed till next cold
reboot. The shell exposes two physical functions: management physical
function and user physical function.

Users compile their high level design in C/C++/OpenCL or RTL into FPGA
image using SDx compiler. The FPGA image packaged as xclbin file can be
loaded onto reconfigurable region. The image may contain one or more
compute unit. Users can dynamically swap the full image running on the
reconfigurable region in order to switch between different workloads.

XRT DRIVERS

XRT Linux kernel driver xmgmt binds to mgmt pf. The driver is modular and
organized into several platform drivers which primarily handle the
following functionality:
1.  ICAP programming (FPGA bitstream download with FPGA Mgr integration)
2.  Clock scaling
3.  Loading firmware container also called dsabin (embedded Microblaze
    firmware for ERT and XMC, optional clearing bitstream)
4.  In-band sensors: temp, voltage, power, etc.
5.  AXI Firewall management
6.  Device reset and rescan
7.  Hardware mailbox for communication between two physical functions

XRT Linux kernel driver xocl binds to user pf. Like its peer, this driver
is also modular and organized into several platform drivers which handle
the following functionality:
1.  Device memory topology discovery and memory management
2.  Buffer object abstraction and management for client process
3.  XDMA MM PCIe DMA engine programming
4.  Multi-process aware context management
5.  Compute unit execution management (optionally with help of ERT) for
    client processes
6.  Hardware mailbox for communication between two physical functions

The drivers export ioctls and sysfs nodes for various services. xocl
driver makes heavy use of DRM GEM features for device memory management,
reference counting, mmap support and export/import. xocl also includes a
simple scheduler called KDS which schedules compute units and interacts
with hardware scheduler running ERT firmware. The scheduler understands
custom opcodes packaged into command objects and provides an asynchronous
command done notification via POSIX poll.

More details on architecture, software APIs, ioctl definitions, execution
model, etc. is available as Sphinx documentation--

https://xilinx.github.io/XRT/2018.3/html/index.html

The complete runtime software stack (XRT) which includes out of tree
kernel drivers, user space libraries, board utilities and firmware for
the hardware scheduler is open source and available at
https://github.com/Xilinx/XRT

Thanks,
-Sonal

Sonal Santan (6):
  Add skeleton code: ioctl definitions and build hooks
  Global data structures shared between xocl and xmgmt drivers
  Add platform drivers for various IPs and frameworks
  Add core of XDMA driver
  Add management driver
  Add user physical function driver

 drivers/gpu/drm/Kconfig                    |    2 +
 drivers/gpu/drm/Makefile                   |    1 +
 drivers/gpu/drm/xocl/Kconfig               |   22 +
 drivers/gpu/drm/xocl/Makefile              |    3 +
 drivers/gpu/drm/xocl/devices.h             |  954 +++++
 drivers/gpu/drm/xocl/ert.h                 |  385 ++
 drivers/gpu/drm/xocl/lib/Makefile.in       |   16 +
 drivers/gpu/drm/xocl/lib/cdev_sgdma.h      |   63 +
 drivers/gpu/drm/xocl/lib/libxdma.c         | 4368 ++++++++++++++++++++
 drivers/gpu/drm/xocl/lib/libxdma.h         |  596 +++
 drivers/gpu/drm/xocl/lib/libxdma_api.h     |  127 +
 drivers/gpu/drm/xocl/mgmtpf/Makefile       |   29 +
 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c    |  960 +++++
 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h    |  147 +
 drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c      |   30 +
 drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c   |  148 +
 drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h     |  244 ++
 drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c   |  318 ++
 drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c   |  399 ++
 drivers/gpu/drm/xocl/subdev/dna.c          |  356 ++
 drivers/gpu/drm/xocl/subdev/feature_rom.c  |  412 ++
 drivers/gpu/drm/xocl/subdev/firewall.c     |  389 ++
 drivers/gpu/drm/xocl/subdev/fmgr.c         |  198 +
 drivers/gpu/drm/xocl/subdev/icap.c         | 2859 +++++++++++++
 drivers/gpu/drm/xocl/subdev/mailbox.c      | 1868 +++++++++
 drivers/gpu/drm/xocl/subdev/mb_scheduler.c | 3059 ++++++++++++++
 drivers/gpu/drm/xocl/subdev/microblaze.c   |  722 ++++
 drivers/gpu/drm/xocl/subdev/mig.c          |  256 ++
 drivers/gpu/drm/xocl/subdev/sysmon.c       |  385 ++
 drivers/gpu/drm/xocl/subdev/xdma.c         |  510 +++
 drivers/gpu/drm/xocl/subdev/xmc.c          | 1480 +++++++
 drivers/gpu/drm/xocl/subdev/xvc.c          |  461 +++
 drivers/gpu/drm/xocl/userpf/Makefile       |   27 +
 drivers/gpu/drm/xocl/userpf/common.h       |  157 +
 drivers/gpu/drm/xocl/userpf/xocl_bo.c      | 1255 ++++++
 drivers/gpu/drm/xocl/userpf/xocl_bo.h      |  119 +
 drivers/gpu/drm/xocl/userpf/xocl_drm.c     |  640 +++
 drivers/gpu/drm/xocl/userpf/xocl_drv.c     |  743 ++++
 drivers/gpu/drm/xocl/userpf/xocl_ioctl.c   |  396 ++
 drivers/gpu/drm/xocl/userpf/xocl_sysfs.c   |  344 ++
 drivers/gpu/drm/xocl/version.h             |   22 +
 drivers/gpu/drm/xocl/xclbin.h              |  314 ++
 drivers/gpu/drm/xocl/xclfeatures.h         |  107 +
 drivers/gpu/drm/xocl/xocl_ctx.c            |  196 +
 drivers/gpu/drm/xocl/xocl_drm.h            |   91 +
 drivers/gpu/drm/xocl/xocl_drv.h            |  783 ++++
 drivers/gpu/drm/xocl/xocl_subdev.c         |  540 +++
 drivers/gpu/drm/xocl/xocl_thread.c         |   64 +
 include/uapi/drm/xmgmt_drm.h               |  204 +
 include/uapi/drm/xocl_drm.h                |  483 +++
 50 files changed, 28252 insertions(+)
 create mode 100644 drivers/gpu/drm/xocl/Kconfig
 create mode 100644 drivers/gpu/drm/xocl/Makefile
 create mode 100644 drivers/gpu/drm/xocl/devices.h
 create mode 100644 drivers/gpu/drm/xocl/ert.h
 create mode 100644 drivers/gpu/drm/xocl/lib/Makefile.in
 create mode 100644 drivers/gpu/drm/xocl/lib/cdev_sgdma.h
 create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.c
 create mode 100644 drivers/gpu/drm/xocl/lib/libxdma.h
 create mode 100644 drivers/gpu/drm/xocl/lib/libxdma_api.h
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/Makefile
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.c
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-core.h
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-cw.c
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-ioctl.c
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-reg.h
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-sysfs.c
 create mode 100644 drivers/gpu/drm/xocl/mgmtpf/mgmt-utils.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/dna.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/feature_rom.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/firewall.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/fmgr.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/icap.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/mailbox.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/mb_scheduler.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/microblaze.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/mig.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/sysmon.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/xdma.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/xmc.c
 create mode 100644 drivers/gpu/drm/xocl/subdev/xvc.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/Makefile
 create mode 100644 drivers/gpu/drm/xocl/userpf/common.h
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.h
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drm.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drv.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_ioctl.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_sysfs.c
 create mode 100644 drivers/gpu/drm/xocl/version.h
 create mode 100644 drivers/gpu/drm/xocl/xclbin.h
 create mode 100644 drivers/gpu/drm/xocl/xclfeatures.h
 create mode 100644 drivers/gpu/drm/xocl/xocl_ctx.c
 create mode 100644 drivers/gpu/drm/xocl/xocl_drm.h
 create mode 100644 drivers/gpu/drm/xocl/xocl_drv.h
 create mode 100644 drivers/gpu/drm/xocl/xocl_subdev.c
 create mode 100644 drivers/gpu/drm/xocl/xocl_thread.c
 create mode 100644 include/uapi/drm/xmgmt_drm.h
 create mode 100644 include/uapi/drm/xocl_drm.h

--
2.17.0
