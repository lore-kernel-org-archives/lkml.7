Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DD4C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2C20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cDLw0v+a";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nrqBzDi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfDJIBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:01:03 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:53988 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728953AbfDJIA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:00:57 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A7xiLe017589;
        Wed, 10 Apr 2019 01:00:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=xy4p8/+eiwyRjVaB5t0CkpQu85twAYncahtU/z5SqRc=;
 b=cDLw0v+aeRhXRZ+5crJsDEZoHzXNIYS2hTl2S7SbFtNgXskpqcUJlt19YEUdJppQe20U
 2Fa+Ctq4JegS9zfFRCTaV+N/n8TRl2UnREumfgRAd9KloM5yor29B5p1NR5l1Kc+mUzB
 r8q19EbUkPAbKR+WsSeonVRaN1TigCNF2vg1ndCDZf7KGH/dBJZ+vLA8GPS61ScDWUS0
 cJUL1xPdMUTBytIYyJi3a16ipgFTR8lZZqTsyVwuwqbRk8s1ZiMcwjCvVT/RWRaZY6Ai
 GKX/Z+nwliZ9H3XNBZBLlIGzcq9UdkHUrWocOFDtqWvlzKrAdBBkRvFY5qxRoQpxhI/R Hw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2058.outbound.protection.outlook.com [104.47.49.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2rsa27rm72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Apr 2019 01:00:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy4p8/+eiwyRjVaB5t0CkpQu85twAYncahtU/z5SqRc=;
 b=nrqBzDi3PbUyT4OAUyJJJSegzB/hKvOl9MQdl9nySE8bMM5efU2bwndv8mbLQc1orrf9Rcz1f11rUpDPYWerNUikgLx+GAjni82k+8f6ojB9t0CI1/EZiRn83hNqakwiq/DxLscnoH4ovuMRW7WdGzHeWiO1WJ+ZoHaYS3N7xws=
Received: from DM5PR07CA0048.namprd07.prod.outlook.com (2603:10b6:3:16::34) by
 DM6PR07MB5915.namprd07.prod.outlook.com (2603:10b6:5:181::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 08:00:34 +0000
Received: from DM3NAM05FT018.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by DM5PR07CA0048.outlook.office365.com
 (2603:10b6:3:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.15 via Frontend
 Transport; Wed, 10 Apr 2019 08:00:34 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT018.mail.protection.outlook.com (10.152.98.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1792.7 via Frontend Transport; Wed, 10 Apr 2019 08:00:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x3A80TDM028108
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 10 Apr 2019 01:00:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 10 Apr 2019 10:00:28 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 10 Apr 2019 10:00:28 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x3A80Sdv021620;
        Wed, 10 Apr 2019 09:00:28 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x3A80Osb021392;
        Wed, 10 Apr 2019 09:00:24 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v6 0/6] Introduced new Cadence USBSS DRD Driver.
Date:   Wed, 10 Apr 2019 08:48:18 +0100
Message-ID: <1554882504-9010-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(189003)(36092001)(199004)(4720700003)(51416003)(54906003)(14444005)(48376002)(966005)(6666004)(305945005)(356004)(47776003)(107886003)(50466002)(6916009)(126002)(6306002)(476003)(36756003)(5660300002)(7416002)(2351001)(76130400001)(26005)(336012)(2616005)(426003)(186003)(4326008)(8936002)(486006)(87636003)(246002)(478600001)(105596002)(7636002)(106466001)(8676002)(86362001)(42186006)(26826003)(50226002)(16586007)(316002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5915;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45c390de-27d2-49b6-d735-08d6bd8a9be3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328);SRVR:DM6PR07MB5915;
X-MS-TrafficTypeDiagnostic: DM6PR07MB5915:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM6PR07MB59156A8B8B42E428E8CB3879DD2E0@DM6PR07MB5915.namprd07.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MenMV8Dk9XxIiO2RGWKA2A3Vd+5eGRE8IfgfktEOf9f2ycnKLZEqjmUaOVt6ZASQBibRb1WNsGf6kJqZzhfk4wtnK75TlQI3WyVUxwOVbVEjHmg5nzkWS4jILlLeMv8iVNwlfExhhKsGxMHuOvc0eCipfh2lKTre2IB4ROZ4Eqdb6/R44Xc8wMgUXbG9zJ9CUXw5yZe2wrox0AdIiUzccrkXBbLH8iiuHJCU14XRKMUw8usjFxhwFfFIMYhtf9Ko2CxKTQJ8ejuntBwLyJ6Y9WsQ1o/d0y6ixb3zgMTShP7mL4yjqyg96EnD715c5pRzBXslsV+rRsMIr1F2ieXfpy9CQs3zA8F4Ui/NNAQGn9KLl82Oo+dW0TYszGFO63EfpBp8sNYyxQ+jWNJf3v326yeBKscWqNB0dpKCtwTDL9k=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 08:00:32.7371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c390de-27d2-49b6-d735-08d6bd8a9be3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5915
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce new Cadence USBSS DRD driver to linux kernel.

The Cadence USBSS DRD Driver is a highly configurable IP Core whichi
can be instantiated as Dual-Role Device (DRD), Peripheral Only and
Host Only (XHCI)configurations.

The current driver has been validated with FPGA burned. We have support
for PCIe bus, which is used on FPGA prototyping.

The host side of USBSS-DRD controller is compliance with XHCI
specification, so it works with standard XHCI linux driver.

Change since v5:
- fixed compilation error.

Changes since v4:
- fixed issue: with choosing incorrect dr_mode in cdns3_core_init_role.
- speed up DRD timings by adding an appropriate entry to OTGSIMULATE
  register in cdns3_drd_init function.
- added detecting transition to DEV_IDLE/H_IDLE state instead using
  usleep_range in cdns3_drd_switch_gadget and cdns3_drd_switch_host functions.
- fixed issue with setting incorrect burst and mult field during endpoint
  configuration. 
- fixed issue in WA1 algorithm. The previous one could not work correct with
  slow CPU or in case the access to AXI bus would be blocked for some time.
- fixed issue with compilation driver occurred when driver was configured
  as build in. This fix required to move cdns3_handshake function from
  gadget.c to core.c file.
- added missing pci_disable_device in cdns3-pci-wrap.c file.
- fixed issue with pm_runtime_get_sync in cdns3_role_switch function.
- fixed incorrect condition in cdns3_decode_usb_irq function.
- removed cdns3_data_flush function - is no longer used.
- fixed issue in cdns3_descmissing_packet function - fixed incorrect condition
- added missed callback informing upper layer about reset event.
- added resetting endpoint in cdns3_gadget_ep_disable function.
- fixed issue: added statement removing request from descmiss_req_list in
  cdns3_gadget_ep_disable function.
- fixed issue in cdns3_ep_onchip_buffer_reserve.
- fixed issue with incorrect callculation the number of required on-chip buffer 
  for OUT endpoints cdns3_ep_onchip_buffer_reserve.
- fixed issue in __cdns3_gadget_init function: pm_runtime_get_sync was in
  incorrect place in.
- removed some typos and improved comments as suggested by reviewers.
- made some other minor changes as suggested by revivers.

Changes since v3:
- updated dt-binding as suggested by Rob Herring
- updated patch 002, 003 and 004 according with patch:
  https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/
  ?h=next&id=7790b3556fccc555ae422f1576e97bf34c8ab8b6 posted by Felipe Balbi.
- fixed issues related to isochronous transfers.
- improved algorithm calculating number of on-chip buffers required
  by endpoints.
- fixed incorrect macro EP_CFG_MULT in gadget.h file.
- fixed potential issue with incorrect order of instruction - added wmb().
- made some minor changes suggested by reviewers.

*Changes since v2:
- made some text correction in Kconfig file as suggested by Randy Dunlap.
- simplified Makefile as suggested by Peter Chan.
- removed phy-names from dt-binding as suggested Rob Herring.
- changed cdns3-usb.txt to cdns3-usb3.txt as suggested by Rob Herring.
- added checking error code in some function in drd.c file 
  as suggested by Peter Chan.
- added reg-names to dt-binding documentation as suggested by Chunfeng Yun.
- replaced platform_get_resource with platform_get_resource_byname.
- made other changes suggested by Chunfeng Yun.
- fixed bug in cdns3_get_id. Now function return id instead 1.
- added trace_cdns3_log trace event.
- simplify cdns3_disable_write function.
- create separate patch for work around related with blocking endpoint 
  issue.
- Fixed issue related with stale data address in TRB. 
  Issue: At some situations, the controller may get stale data address
  in TRB at below sequences:
  1. Controller read TRB includes data address.
  2. Software updates TRBs includes data address and Cycle bit.
  3. Controller read TRB which includes Cycle bit.
  4. DMA run with stale data address.
- Fixed issue without transfer. In some cases not all interrupts
  disabled in Hard IRQ was enabled in Soft Irq.
- Modified LFPS minimal U1 Exit time for controller revision 0x00024505.
- Fixed issue - in some case selected endpoint was unexpectedly changed.
- Fixed issue - after clearing halted endpoint transfer was not started.
- Fixed issue - in some case driver send ACK instead STALL in status phase.
- Fixed issues related to dequeue request.
- Fixed incorrect operator in cdns3_ep_run_transfer function.

Changes since v1:
 - Removed not implemented Suspend/Resume functions.
 - Fixed some issues in debugging related functions.
 - Added trace_cdns3_request_handled marker.
 - Added support for Isochronous transfer. 
 - Added some additional descriptions.
 - Fixed compilation error in cdns3_gadget_ep_disable.
 - Added detection of device controller version at runtime.
 - Upgraded dt-binding documentation.
 - Deleted ENOSYS from phy initialization section. It should be also removed
   from generic PHY driver.
 - added ep0_stage flag used during enumeration process.
 - Fixed issue with TEST MODE.
 - Added one common function for finish control transfer.
 - Separated some decoding function from dwc3 driver to common library file,
   and removed equivalents function from debug.h file as suggested  by Felipe.
 - replaced function name cdns3_gadget_unconfig with cdns3_hw_reset_eps_config.
 - Improved algorithm fixing hardware issue related to blocking endpoints.
   This issue is related to on-chip shared FIFO buffers for OUT packets. 
   Problem was reported by Peter Chan.
 - Changed organization of endpoint array in cdns3_device object.  
      - added ep0 to common eps array
      - removed cdns3_free_trb_pool and cdns3_ep_addr_to_bit_pos macros.
      - removed ep0_trb_dma, ep0_trb fields from cdns3_device.
 - Removed ep0_request and ep_nums fields from cdns3_device.
 - Other minor changes according with Felipe suggestion.

---

Pawel Laszczak (6):
  dt-bindings: add binding for USBSS-DRD controller.
  usb:common Separated decoding functions from dwc3 driver.
  usb:common Patch simplify usb_decode_set_clear_feature function.
  usb:common Simplify usb_decode_get_set_descriptor function.
  usb:cdns3 Add Cadence USB3 DRD Driver
  usb:cdns3 Fix for stuck packets in on-chip OUT buffer.

 .../devicetree/bindings/usb/cdns-usb3.txt     |   30 +
 drivers/usb/Kconfig                           |    2 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   44 +
 drivers/usb/cdns3/Makefile                    |   14 +
 drivers/usb/cdns3/cdns3-pci-wrap.c            |  146 +
 drivers/usb/cdns3/core.c                      |  437 +++
 drivers/usb/cdns3/core.h                      |  118 +
 drivers/usb/cdns3/debug.h                     |  168 ++
 drivers/usb/cdns3/debugfs.c                   |  173 ++
 drivers/usb/cdns3/drd.c                       |  371 +++
 drivers/usb/cdns3/drd.h                       |  163 ++
 drivers/usb/cdns3/ep0.c                       |  907 ++++++
 drivers/usb/cdns3/gadget-export.h             |   28 +
 drivers/usb/cdns3/gadget.c                    | 2442 +++++++++++++++++
 drivers/usb/cdns3/gadget.h                    | 1291 +++++++++
 drivers/usb/cdns3/host-export.h               |   28 +
 drivers/usb/cdns3/host.c                      |   72 +
 drivers/usb/cdns3/trace.c                     |   23 +
 drivers/usb/cdns3/trace.h                     |  447 +++
 drivers/usb/common/Makefile                   |    2 +-
 drivers/usb/common/debug.c                    |  270 ++
 drivers/usb/dwc3/debug.h                      |  249 --
 drivers/usb/dwc3/trace.h                      |    2 +-
 include/linux/usb/ch9.h                       |   25 +
 25 files changed, 7203 insertions(+), 251 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/debug.h
 create mode 100644 drivers/usb/cdns3/debugfs.c
 create mode 100644 drivers/usb/cdns3/drd.c
 create mode 100644 drivers/usb/cdns3/drd.h
 create mode 100644 drivers/usb/cdns3/ep0.c
 create mode 100644 drivers/usb/cdns3/gadget-export.h
 create mode 100644 drivers/usb/cdns3/gadget.c
 create mode 100644 drivers/usb/cdns3/gadget.h
 create mode 100644 drivers/usb/cdns3/host-export.h
 create mode 100644 drivers/usb/cdns3/host.c
 create mode 100644 drivers/usb/cdns3/trace.c
 create mode 100644 drivers/usb/cdns3/trace.h
 create mode 100644 drivers/usb/common/debug.c

-- 
2.17.1

