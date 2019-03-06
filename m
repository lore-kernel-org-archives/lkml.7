Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926DAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BF220661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CAW2gr32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfCFTWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:22:50 -0500
Received: from mail-eopbgr810048.outbound.protection.outlook.com ([40.107.81.48]:63568
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbfCFTWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiEouij/asD6VmISImbo8OlEv2ytj2g5dYTnVNScQvA=;
 b=CAW2gr32RA/o9O89JMB8AMa23YhhINBFUyN/z1i8qqplMr7Pu4tQsm3kc3Tk7Dz4KEsnLr7uOlz0WYMEOk/6L+kGIHNbC8mOyDNwPo8SzOFqvyHMOmt/2kxW/tqxYsHWIodHbEKvS4ePXo1g77HA9uZHfnbOLUUr7pHLQjNNgNs=
Received: from BYAPR02MB5160.namprd02.prod.outlook.com (20.176.254.33) by
 BYAPR02MB5239.namprd02.prod.outlook.com (20.177.124.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 19:22:47 +0000
Received: from BYAPR02MB5160.namprd02.prod.outlook.com
 ([fe80::80b3:fda4:4f28:b969]) by BYAPR02MB5160.namprd02.prod.outlook.com
 ([fe80::80b3:fda4:4f28:b969%4]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 19:22:47 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     dri-devel <dri-devel@lists.freedesktop.org>
CC:     Daniel Vetter <daniel@ffwll.ch>, Hyun Kwon <hyunk@xilinx.com>,
        Cyril Chemparathy <cyrilc@xilinx.com>,
        David Airlie <airlied@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ronan Keryell <rkeryell@xilinx.com>,
        Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>
Subject: RFC: Xilinx FPGA based accelerator kernel drivers
Thread-Topic: RFC: Xilinx FPGA based accelerator kernel drivers
Thread-Index: AdTUJBHxDxtrcmfUTSih/d/OI9MTYQ==
Date:   Wed, 6 Mar 2019 19:22:47 +0000
Message-ID: <BYAPR02MB5160B6788B048F4B063BE56BBB730@BYAPR02MB5160.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sonals@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e604b69-1680-49c0-1b03-08d6a2691df5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5239;
x-ms-traffictypediagnostic: BYAPR02MB5239:
x-ms-exchange-purlcount: 6
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR02MB5239;23:xKjShmcd37c+LaDcbuMIrRAnb6kpm91BdwuNq+PqW?=
 =?us-ascii?Q?RsMF0zi7GkX07YuDO7f93Y4bSXlrM0KnhJthjmOHKsjiZFcOkSgr56MXPvSq?=
 =?us-ascii?Q?7DLKbNZ1BAApZvMpiivDvNjY9C3jU5xPIHId+I/X6vseFvtMIWN0CtFUC3vB?=
 =?us-ascii?Q?wdz7DiOMNPpjBN50CA3XO1tuJsS6VFqhlpLHcZ4AI5kvfBkBCDfIz2chi4r5?=
 =?us-ascii?Q?PvbqlCX0SnszAG6TtDiHDmBqUYN35JPv8CaQoPPIUqZb4pE+vgsYbUxbjIEE?=
 =?us-ascii?Q?d9TxSnphoQ1lOH46kcDHrz5hjvm9DKBjEXiuGhvu6jyT+2Q4XUkKifegVWty?=
 =?us-ascii?Q?UzBbNpDPyAj8cfc2DYK+5o5dPYLGNmwxbR8kRbR5jg9ZdvzZt1XxPYlaieLa?=
 =?us-ascii?Q?HNp0Wm1Kx9g20PnsW1HkY/zuulynKHBkpv/8cmWsACUmEm7Asf4NbkByua8j?=
 =?us-ascii?Q?A1hLFn69V28w8XB2uPNgJ9wdFtLAsr1dOftnu12QiGvMzBmupyjy5j7DaJLI?=
 =?us-ascii?Q?5nJ2SB/I4QfDC8xjSYXl41oE9x//o6+WB4md8oIrWnM1RjTOBDwo6b96fjQd?=
 =?us-ascii?Q?GS2r/slKPAwHXJVCuURjWrnaTWUDkMc+90Jr57PwOYzYuWY1q3s7Xx5+a6+n?=
 =?us-ascii?Q?n90BLMB03Vswe30dgYG492VBrmkwDGg1V26lpZ5FO3WFJUqYmT/WUfI79oKh?=
 =?us-ascii?Q?EBLmcyR+7odx2MWxVns29B1nvWsoCpOb1LieQV331466ErY0nYL/NBMXGZ5d?=
 =?us-ascii?Q?Srf6RhnP5hPeWLOOcgxNfn6MbEnFwX9JsKjtWfru2Cllym4qcs8uubuE73rH?=
 =?us-ascii?Q?b+1+v6ia54RTzhYfrN13XT7X6r+4u/sI2+SvuWrCkBKn54PycwwS22+D/ZGp?=
 =?us-ascii?Q?mjRZUSjpefXZM6faS7FiO0mvGb1Zh10SwxPDalcrhfY1bid1rxB7RPjFpRe9?=
 =?us-ascii?Q?2OgHiWdTivcxvZy6+l3cQUebev6xrn7sSgqCkNwu/007hu8sy2FZ8A9WYBpE?=
 =?us-ascii?Q?wJSP8FXfiJOdYFnC/PWlpau0/bs7qZwFZJibCsFVupQdewv+z5gZhU43i2HN?=
 =?us-ascii?Q?g/jQFPEUTJHDVmvMsmVJ/S2vtU2QUGNScC/E7GN0G0z25g/3+KbsnSnSsVhg?=
 =?us-ascii?Q?RJ/GFSxaHWEO+TX7Y4qqnUDwg1geYrxy9/yOZRYc1LbudFA28YELArKN1T0n?=
 =?us-ascii?Q?oi3xAMb+V+em1zGiYoXVeS9Lmn+M3B7fqb+?=
x-microsoft-antispam-prvs: <BYAPR02MB5239325385907F7BB55DA822BB730@BYAPR02MB5239.namprd02.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(305945005)(5660300002)(316002)(52536013)(53936002)(9686003)(6116002)(2906002)(3846002)(26005)(55016002)(14444005)(256004)(66066001)(102836004)(25786009)(81166006)(97736004)(8676002)(6306002)(71200400001)(71190400001)(68736007)(6506007)(86362001)(4326008)(81156014)(107886003)(8936002)(476003)(7696005)(186003)(74316002)(54906003)(14454004)(347745004)(6436002)(7736002)(99286004)(6916009)(966005)(486006)(478600001)(33656002)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5239;H:BYAPR02MB5160.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wHKrNmUDfSCiXRE+NK9zo4XKxkjLOBVaE2hpe00rH5e4xCYZmHauWX0xVj+aRQ6Tgz+GLynOqA5QIuYJedciAKrEU85KRcc1cjdrBwB1kucFQKqpvNxCdmiG/UrQhH1PirMH/v1CdQoO2Zmzq+UUBBItbE3GeSwZXPX7x+mpNIubgITgwQk8zUarb4W1IscjhJoC0aYQSPCeLilMpzcuni+om7laTLvZYV174tSiwxOmVEkYzlk0Wu0DPLhsStVz9Wy8wx8XfThd0f5DtlsVNwzXP3DSd6UNT2Qe8EGLbmPcx5OgKV9zW8jOiD8g+RRYRhnKdx4F2zr9Z5/GOcOastYlJ0Zn6Z6eHrNNGJbzsJ6LKf0hZs+3RGG+abFYPgv7BbcIpuebBeoWrLxe5H5b0SHzeQYGbw13SM8i88Us1KY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e604b69-1680-49c0-1b03-08d6a2691df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 19:22:47.6171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Xilinx would like to begin upstreaming kernel drivers used with our Alveo F=
PGA accelerator cards. These drivers are part of Xilinx Runtime (XRT) open =
source stack and have been deployed by leading FaaS vendors and many enterp=
rise customers.

The PCIe drivers are available for review on GitHub against drm-next tree--

https://github.com/sonals/XRTDrvUpstream

The ioctls are defined in the following two files:
https://github.com/sonals/XRTDrvUpstream/blob/drm-next/include/uapi/drm/xmg=
mt_drm.h
https://github.com/sonals/XRTDrvUpstream/blob/drm-next/include/uapi/drm/xoc=
l_drm.h

The new drivers are located at:=20
https://github.com/sonals/XRTDrvUpstream/tree/drm-next/drivers/gpu/drm/xocl

PLATFORM ARCHITECTURE

Alveo PCIe platforms have a static shell and a reconfigurable (dynamic) reg=
ion. The shell is automatically loaded from PROM when host is booted and PC=
Ie is enumerated by BIOS. Shell cannot be changed till next cold reboot. Th=
e shell has two physical functions: Management Physical Function and User P=
hysical Function. The reconfigurable region contents are compiled by the us=
er using SDx compiler tool chain like xocc which produces xclbin file.

XRT DRIVERS

XRT Linux kernel driver xclmgmt binds to mgmt pf. The driver is modular and=
 organized into several platform drivers which handle the following functio=
nality:
1.   ICAP programming (FPGA bitstream download with FPGA Mgr integration)
2.   Clock scaling
3.   Loading firmware container also called dsabin (embedded Microblaze fir=
mware for ERT and XMC, optional clearing bitstream)
4.   In-band sensors: temp, voltage, power, etc.
5.   AXI Firewall management
6.   Access to Flash programmer
7.   Device reset and rescan
8.   Hardware mailbox
9.   Interrupt handling for AXI Firewall and mailbox
10. ECC handling

XRT Linux kernel driver xocl binds to user pf. The driver is modular and or=
ganized into several platform drivers which handle the following functional=
ity:
1.   Device memory topology discovery and memory management=20
2.   Buffer object abstraction and management for client process=20
3.   XDMA MM PCIe DMA engine programming=20
4.   Multi-process aware context management=20
5.   Standardized compute unit execution management (optionally with help o=
f ERT) for client processes=20
6.   Interrupt handling for DMA, compute unit completion and mailbox

The drivers export ioctls and sysfs nodes for various services. xocl driver=
 makes heavy use of DRM GEM features for device memory management, referenc=
e counting, mmap support and export/import. xocl also has a very simple sch=
eduler called KDS which schedules compute units and interacts with hardware=
 scheduler running ERT firmware. The scheduler interface is somewhat simila=
r to GPUs with a custom command object format with an asynchronous done not=
ification via POSIX poll.

More details of our architecture, software APIs, ioctl definitions, executi=
on model, etc. is available as Sphinx documentation--
=20
https://xilinx.github.io/XRT/2018.3/html/index.html

The complete runtime software stack (XRT) which includes out of tree kernel=
 drivers, user space libraries, board utilities and firmware for the hardwa=
re scheduler is open source and available at https://github.com/Xilinx/XRT.=
 Both PCIe based Alveo boards and Zynq Ultrascale+ MPSoC based embedded pla=
tforms are supported by XRT. We will work on upstreaming the driver for emb=
edded platforms after PCIe drivers have been merged upstream.=20

I am not subscribed to dri-devel so please cc me in the replies.

-Sonal
