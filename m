Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D47C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9233120823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="fdjTUMeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfC1PSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:18:03 -0400
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:42823 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbfC1PSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1553786282; x=1585322282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=93BBE7yC3AOFgup2wYHFvLtKruTPVNFYqaMgDyQy1yA=;
  b=fdjTUMeCmdHtaqI+A0OgjS1ggDdwiof0KVXrYR2cpewsPtOvSWQQi6RE
   NRatMGm0a5GIrhTRHsvS+jQ1YSVBdow9V8GkhFrrZE7YKshWcsNQ7o/1R
   uT8ugbUb2RfTlv9qs/kBJoSHxqPgMqHsDcNjrIL7viwy0tFbVwghOlQyD
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ELAADi5JxchyeV50NkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBVAIBAQEBCwGBYYEXgQMnCox/jFGYUIFnDQEBHw+BSYJ1AoU?=
 =?us-ascii?q?1IjcGDQEBAwEBCQEDAgEBAhABAQEKCwkIKSMMgjoiHE1rAQEBAQEBIwINYwE?=
 =?us-ascii?q?BAQECARIVEz8MBAIBCBEEAQEfEE8IAgQBDQUIGoMAAYFtCA+deT0Cb4EBiQc?=
 =?us-ascii?q?BAQGBazOEMAGFeQWBLwGLMYIWgRGDEj6BF4ExgTYTARIBhgADiiwYggmYXgc?=
 =?us-ascii?q?Ch2yLUyKCA4lPiDqIMYJ7hgmJf4MyAgQCBAUCFYFjgQhxcFCCbB+Bdw4JiF+?=
 =?us-ascii?q?FP0ABMQGNJw8XA4EFgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2ELAADi5JxchyeV50NkGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AIBAQEBCwGBYYEXgQMnCox/jFGYUIFnDQEBHw+BSYJ1AoU1IjcGDQEBAwEBC?=
 =?us-ascii?q?QEDAgEBAhABAQEKCwkIKSMMgjoiHE1rAQEBAQEBIwINYwEBAQECARIVEz8MB?=
 =?us-ascii?q?AIBCBEEAQEfEE8IAgQBDQUIGoMAAYFtCA+deT0Cb4EBiQcBAQGBazOEMAGFe?=
 =?us-ascii?q?QWBLwGLMYIWgRGDEj6BF4ExgTYTARIBhgADiiwYggmYXgcCh2yLUyKCA4lPi?=
 =?us-ascii?q?DqIMYJ7hgmJf4MyAgQCBAUCFYFjgQhxcFCCbB+Bdw4JiF+FP0ABMQGNJw8XA?=
 =?us-ascii?q?4EFgR8BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2019 10:18:01 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SF7lDP062261;
        Thu, 28 Mar 2019 11:18:00 -0400
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2rgxfbs2sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Mar 2019 11:18:00 -0400
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Mar 2019 21:17:43 +0600
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.60,280,1549951200"; 
   d="scan'208";a="287787610"
To:     <mika.westerberg@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC:     <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <andreas.noever@gmail.com>, <lukas@wunner.de>,
        <davem@davemloft.net>, <andriy.shevchenko@linux.intel.com>,
        <ckellner@redhat.com>, <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 00/36] thunderbolt: Software connection manager
 improvements
Thread-Topic: [PATCH v3 00/36] thunderbolt: Software connection manager
 improvements
Thread-Index: AQHU5WLl07JI2cAT10qiEqN6uf0TUaYhJGhw
Date:   Thu, 28 Mar 2019 15:17:57 +0000
Message-ID: <1aaab9baea4f46b481b5601dfb060104@ausx13mpc120.AMER.DELL.COM>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Thursday, March 28, 2019 7:36 AM
> To: linux-kernel@vger.kernel.org
> Cc: Michael Jamet; Yehezkel Bernat; Andreas Noever; Lukas Wunner; David S=
 .
> Miller; Andy Shevchenko; Christian Kellner; Limonciello, Mario; Mika West=
erberg;
> netdev@vger.kernel.org
> Subject: [PATCH v3 00/36] thunderbolt: Software connection manager
> improvements
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Hi,
>=20
> This is third iteration of the patch series intending to bring same kind =
of
> functionality for older Apple systems than we have in PCs. Software
> connection manager is used on Apple hardware with Light Ridge, Cactus Rid=
ge
> or Falcon Ridge controllers to create PCIe tunnels when a Thunderbolt
> device is connected. Currently only one PCIe tunnel is supported. On newe=
r
> Alpine Ridge based Apple systems the driver starts the firmware which the=
n
> takes care creating tunnels.
>=20
> This series improves the software connection manager so that it will
> support:
>=20
>   - Full PCIe daisy chains (up to 6 devices)
>   - Display Port tunneling
>   - P2P networking
>=20
> We also add support for Titan Ridge based Apple systems where we can use
> the same flows than with Alpine Ridge to start the firmware.

It seems to me that there would be an expectation that PC system firmware a=
nd TBT controller
firmware is configured to behave like Apple systems to use this SW connecti=
on manager
instead of the ICM in AR/TR FW.

Is there an intent to eventually offer a way to "side-step" the TBT ICM and=
 try to use this instead
without firmware support?

>=20
> This applies on top of thunderbolt.git/next.
>=20
> Christian, Mario do you see any issues with patch [05/36] regarding bolt
> and fwupd? The kernel is supposed to restart the syscall automatically so
> userspace should not be affected but wanted to check with you.

I don't see a problem for fwupd in this area.

>=20
> Previous version of the patch series can be viewed here:
>=20
>   v2: https://lkml.org/lkml/2019/2/6/347
>   v1: https://lkml.org/lkml/2019/1/29/924
>=20
> Making v3 took longer than I anticipated mostly due to some issues I run
> during testing the new changes. There are quite many changes so I dropped
> the reviewed-by tags I got for v2. Below is the list of major changes fro=
m
> the previous version:
>=20
>   * Always set port->remote even in case of dual link connection.
>=20
>   * Leave (DP, PCIe) tunnels up when the driver is unloaded. When loaded
>     back, it discovers the existing tunnels and updated data structures
>     accordingly. I noticed that the code in v2 did not support cases
>     properly when you unplug something before the driver gets loaded back=
.
>     This version tears down partial paths during discovery.
>=20
>   * Do not automatically create PCIe tunnels. Instead we implement "user"
>     security level in the software connection manager as well taking
>     advantage of the existing sysfs interfaces. This allows user to disab=
le
>     PCIe tunneling completely or implement different white listing
>     policies. Major distros include bolt system daemon that takes care of
>     this.

This is a bit unfortunate.  Is this because of IOMMU limitations in working
with devices down the chain?

>=20
>   * When testing on two-port Falcon Ridge based system I realized
>     that we always just pick the first available PCIe downstream adapter
>     regardless of which Thunderbolt port you plug the device which is not
>     consistent. To solve this we add mapping between host PCIe downstream
>     adapter and the Thunderbolt port for Cactus Ridge and Falcon Ridge
>     based systems.
>=20
>   * Take domain lock in switch sysfs callbacks. This is needed because th=
e
>     software connection manager needs to walk over the topology during
>     tunnel creation so switch_lock is not enough anymore.
>=20
> Changes from v1:
>=20
>   * Added ACK from David
>=20
>   * Add constant (TMU_ACCESS_EN) for BIT(20) when TMU access is enabled. =
We
>     keep it in cap.c close to the LR/ER workaround. Also we enable/disabl=
e
>     only during capability walk. If it turns we need to have it enabled
>     elsewhere we can move it to switch.c and enable just once during
>     switch enumeration.
>=20
>   * Use 0 to mean no cap_adap instead of negative value. This follows
>     cap_phy.
>=20
>   * Use correct PCI IDs (_BRIDGE) in the last patch where we start firmwa=
re
>     on Titan Ridge. It wrongly used NHI PCI IDs in v1.
>=20
> Mika Westerberg (36):
>   net: thunderbolt: Unregister ThunderboltIP protocol handler when suspen=
ding
>   thunderbolt: Remove unused work field in struct tb_switch
>   thunderbolt: Drop duplicated get_switch_by_route()
>   thunderbolt: Block reads and writes if switch is unplugged
>   thunderbolt: Take domain lock in switch sysfs attribute callbacks
>   thunderbolt: Do not allocate switch if depth is greater than 6
>   thunderbolt: Enable TMU access when accessing port space on legacy devi=
ces
>   thunderbolt: Add dummy read after port capability list walk on Light Ri=
dge
>   thunderbolt: Move LC specific functionality into a separate file
>   thunderbolt: Configure lanes when switch is initialized
>   thunderbolt: Set sleep bit when suspending switch
>   thunderbolt: Properly disable path
>   thunderbolt: Cache adapter specific capability offset into struct port
>   thunderbolt: Rename tunnel_pci to tunnel
>   thunderbolt: Generalize tunnel creation functionality
>   thunderbolt: Add functions for allocating and releasing HopIDs
>   thunderbolt: Assign remote for both ports in case of dual link
>   thunderbolt: Add helper function to iterate from one port to another
>   thunderbolt: Extend tunnel creation to more than 2 adjacent switches
>   thunderbolt: Deactivate all paths before restarting them
>   thunderbolt: Discover preboot PCIe paths the boot firmware established
>   thunderbolt: Add support for full PCIe daisy chains
>   thunderbolt: Scan only valid NULL adapter ports in hotplug
>   thunderbolt: Generalize port finding routines to support all port types
>   thunderbolt: Rework NFC credits handling
>   thunderbolt: Add support for Display Port tunnels
>   thunderbolt: Do not tear down tunnels when driver is unloaded
>   thunderbolt: Run tb_xdp_handle_request() in system workqueue
>   thunderbolt: Add XDomain UUID exchange support
>   thunderbolt: Add support for DMA tunnels
>   thunderbolt: Make tb_switch_alloc() return ERR_PTR()
>   thunderbolt: Add support for XDomain connections
>   thunderbolt: Make __TB_[SW|PORT]_PRINT take const parameters
>   thunderbolt: Make rest of the logging to happen at debug level
>   thunderbolt: Reword output of tb_dump_hop()
>   thunderbolt: Start firmware on Titan Ridge Apple systems
>=20
>  drivers/net/thunderbolt.c        |   3 +
>  drivers/thunderbolt/Makefile     |   4 +-
>  drivers/thunderbolt/cap.c        |  85 +++-
>  drivers/thunderbolt/ctl.c        |   2 +-
>  drivers/thunderbolt/icm.c        |  60 ++-
>  drivers/thunderbolt/lc.c         | 179 ++++++++
>  drivers/thunderbolt/nhi.c        |   3 +-
>  drivers/thunderbolt/path.c       | 421 ++++++++++++++++---
>  drivers/thunderbolt/switch.c     | 551 +++++++++++++++++++-----
>  drivers/thunderbolt/tb.c         | 608 ++++++++++++++++++++-------
>  drivers/thunderbolt/tb.h         | 173 +++++++-
>  drivers/thunderbolt/tb_msgs.h    |  11 +
>  drivers/thunderbolt/tb_regs.h    |  50 ++-
>  drivers/thunderbolt/tunnel.c     | 691 +++++++++++++++++++++++++++++++
>  drivers/thunderbolt/tunnel.h     |  78 ++++
>  drivers/thunderbolt/tunnel_pci.c | 226 ----------
>  drivers/thunderbolt/tunnel_pci.h |  31 --
>  drivers/thunderbolt/xdomain.c    | 147 ++++++-
>  include/linux/thunderbolt.h      |   8 +
>  19 files changed, 2680 insertions(+), 651 deletions(-)
>  create mode 100644 drivers/thunderbolt/lc.c
>  create mode 100644 drivers/thunderbolt/tunnel.c
>  create mode 100644 drivers/thunderbolt/tunnel.h
>  delete mode 100644 drivers/thunderbolt/tunnel_pci.c
>  delete mode 100644 drivers/thunderbolt/tunnel_pci.h
>=20
> --
> 2.20.1

