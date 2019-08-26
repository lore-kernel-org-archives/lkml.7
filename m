Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3234DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB3F2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="jGZUGuG3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="0tE72aUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfHZLUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:20:34 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37568 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730705AbfHZLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:20:29 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QBJHgg004573;
        Mon, 26 Aug 2019 04:20:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=U8ByjFBezs+a0AGO7TOzqi0rNGuuNFIRjjYyjEbmx3Y=;
 b=jGZUGuG3INLSOVYyZ2L4i5JhQNrSyBItx6wC5qVSFbXj1CH0QTsBHSynLWOupaNtHToC
 kTk3Jlq/yeeZ+K1JsZSDVM0vhylnSBIYbCrU6dImERLhjgLcLXvgwDDZ4VOoxBHxb9xF
 lkG5NsvQIBfDr2bQ6EF9MbB5NIFUdOeI/M6qGdLJJxbeoiDc9mctqkpuakDPuf58JUm+
 pWN+m9JfhQpw92xY7ciWDyR8LvHiGi2UthIuLZPdJChh4daStzqXNA/3q3ADjDczRSTA
 g/jbjKDXFSM+D4Nrh0QwJEKQYBRgJrsh+tEmpj4dIAq/ybEpTlFnu3KKVOwF+0FJnl5i hg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2054.outbound.protection.outlook.com [104.47.32.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uk21yp6h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 04:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnN+sDaJy7Uvg27Sf8OJuFggFMg92BBCfqzAtAjDO6mDjLr5aVND00rCmlmp/tgItaGBtAUs8coTiZPHYNVh6X6YXYUHkz08lQly5zzowlogYaTePuDruxeo2w0U5I41RZytOS0KOtIJvt51d7aYwvk1jkDOSmcrLxWGYfuQaAMKjDYeg6/EZqv+3ykl+0DFkh2r+laXeUq6FF3zCSc1elA2+4LWDfWXIglKhfby1aV7h66eWvM0Yx9C2FsNLtQzSpTttVd8aBfqXJort56cXLve5t2ayCsw5E9+gAr82ZYz/D2uONhkrArmkj2CphJViYCTKn3BNP/coofpLs3A/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8ByjFBezs+a0AGO7TOzqi0rNGuuNFIRjjYyjEbmx3Y=;
 b=nqAWXkW3EHWMe65Al/ykQNBlQ1t7CM9MpH2/B3LnTnjJYOPTfBuDCdKqZigUAh0+XsQJv5wB//IAkPw4CI8kkMZneFJTcRjMq0A+gZIHn5k/8BhBAv4PkJLn3fplDRI0ybBIKuHV/S7tA0Mtut3JFeoMU0rINVtrY9g9XjsoRaAiWeVf9+N3ZkuLP7LJZD84SGjSHB5dScmT/nsTkzLOjQMjlGhlSKhmqJt+O22Hp5fjyn5mLEtaABqEmwbB/YTb8an7YAlhzaZB73in4bFfBDzTEOz7BzDr5hiWw+NNHg8z39lai72n78aQTNaWVCzSqcITLE+e2hioxoeCXIYV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8ByjFBezs+a0AGO7TOzqi0rNGuuNFIRjjYyjEbmx3Y=;
 b=0tE72aUJaIXhQW5+jUAjfVhe3LbtIXHX39+IGNb16bhsfhLE3LUEaGpMuRSnA0iy4uSshsLO6fPXVliwLMdMA/luHpqfaa2JJE32rW8rWHdgWpZvuTam9+wOSL3/jvsmVs30NqflCN7XqvkzjAVUuwbDlsfKZN8VaV6o+MCXlXo=
Received: from BYAPR07CA0006.namprd07.prod.outlook.com (2603:10b6:a02:bc::19)
 by SN2PR07MB2478.namprd07.prod.outlook.com (2603:10b6:804:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Mon, 26 Aug
 2019 11:20:14 +0000
Received: from DM3NAM05FT036.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by BYAPR07CA0006.outlook.office365.com
 (2603:10b6:a02:bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.17 via Frontend
 Transport; Mon, 26 Aug 2019 11:20:13 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT036.mail.protection.outlook.com (10.152.98.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.7 via Frontend Transport; Mon, 26 Aug 2019 11:20:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK9WQ001206
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 26 Aug 2019 04:20:10 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 26 Aug 2019 13:20:09 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 13:20:09 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK87m029066;
        Mon, 26 Aug 2019 12:20:08 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x7QBK7Z1029003;
        Mon, 26 Aug 2019 12:20:07 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v11 0/6] Introduced new Cadence USBSS DRD Driver.
Date:   Mon, 26 Aug 2019 12:19:25 +0100
Message-ID: <1566818371-27721-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(199004)(189003)(36092001)(2906002)(30864003)(478600001)(2351001)(14444005)(6306002)(36756003)(42186006)(16586007)(316002)(87636003)(4720700003)(48376002)(7416002)(6916009)(186003)(246002)(8676002)(107886003)(50226002)(8936002)(356004)(6666004)(305945005)(4326008)(7636002)(50466002)(26826003)(5660300002)(47776003)(54906003)(2616005)(26005)(426003)(336012)(476003)(126002)(76130400001)(966005)(86362001)(70206006)(70586007)(51416003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2478;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae33e678-96e9-49fb-5ec2-08d72a175d42
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328);SRVR:SN2PR07MB2478;
X-MS-TrafficTypeDiagnostic: SN2PR07MB2478:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN2PR07MB2478C9E0D544E253A2322E52DDA10@SN2PR07MB2478.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 01415BB535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cZRq8yFKKMf+H5b8JWQwg7/EDwQH6II+x7D1MDLLle8iXl0MWboGV+66gzH7DdOga5i03GoOiEAfN/iMe8508eVkpG6+faUUI8fjjxiGJ2mpwfaB1iImxyirdGRyVrZN9fcFwXfRcyVP/vmNaDujHwkSQn/AjWDfAbZREOp84TfXL/IaVB/hoqJ7A7NpZDU5RjyGSFQXhswj32wpIrOjD0NUub3QQ4UXKz3SBQqQfB5N64GgzsRteTKmbFoXpZ7cGxQKtDGSJy+Wo6Px6N+ZeDJFpM780hHQQ4YM+5KMSua38qvBCFsXfRwCMSj1oRAhIsS+OhcgHkqylbzPSEPi5V/UWGS/EtskYzHekdkKwdFUrQknrdzN0JRq7og+8KF4bjW1AzrK485HwJdtb1+PHhsEOZ27f08Pf7CweQRs6q4=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2019 11:20:12.7514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae33e678-96e9-49fb-5ec2-08d72a175d42
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2478
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_06:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908260127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce new Cadence USBSS DRD driver to linux kernel.

The Cadence USBSS DRD Controller is a highly configurable IP Core which
can be instantiated as Dual-Role Device (DRD), Peripheral Only and
Host Only (XHCI)configurations.

The current driver has been validated with FPGA burned. We have support
for PCIe bus, which is used on FPGA prototyping.

The host side of USBSS-DRD controller is compliance with XHCI
specification, so it works with standard XHCI Linux driver.

Changes since v10:
- Moved handling of usb_ists interrupts to thread handler.
- Removed no longer needed shadow_ep_en field from cdns3_device structure.
- Removed choosing the role by debugfs.
- Added support for forcing controller speed.
- Fixed issue with changing kind of access to memory.
- Set quirk_avoids_skb_reserve.
- Fixed issue related with phy initialization in cdns3_probe.
- Fixed address of dma_axi_ctrl register.
- Improved role switch implementation as suggested by Roger.
- Fixed issue with handling STALL.
- Some other minor change sugested by Felipe and Roger.

Changes since v9:
- Removed duplicated cdns3_mode array. The same array is defined in 
  drivers/usb/common/common.c. It required some change in common API.
  the appropirate patch was posted separately.
- Replaced generic cdns3_dbg with serparate trace events.
- Replaced cdns3_handshake with readl_poll_timeout_atomic function
- Added threaded irq handler for handling DRD/OTG irq instead workqueue.
- Removed support for debug_disable. It's no longer neeeded. 
- Moved mode attribute under usb root.
- Changed DRD switching role implementation. This version of the driver uses
  common roles interface.
- removed not implemented cdns3_idle_role_start and cdns3_exit_role_start.
- Added support for DRD/OTG irq for Cadence platform.
- Fixed bug in cdns3_mode_show/cdns3_mode_write with changing mode. There was a problem with switching mode. 
- Added support for PM suspend/resume.
- Simplified cdns3/Makefile file.

Changes since v8:
- Fixed compilation error by moving drivers/usb/gadget/debug.c back to
  drivers/usb/common/debug.c. The previous version caused compilation
  error when dwc3 or cdns3 driver was built-in kernel and libcomposite
  was built as module.
 
Changes since v7:
- Updated dt-binding.
- Simplified debugfs file as suggested by Heikki Krogerus.
- Changed some dev_info to dev_dbg.
- Added support for additional PHY. Now driver can use both USB2 PHY
  and USB3 PHY.
- Fixed issue in algorithm checking the number of allocated on-chip buffers.
- Moved common code form drivers/usb/common/debug.c to
  drivers/usb/gadget/debug.c.
- Removed warning generated by sh4-linux-gcc compiler for trace.h file.
- L1 issue: moved resuming after setting DRDY. It should protect against 
  potential racing.
- LPM packet acknowledge has been disabled during control transfer.
- Aded setting AXI Non-Secure mode in DMA_AXI_CTRL register. 

Changes since v6:
- Fixed issue with L1 support. Controller has issue with hardware 
  resuming from L1 state. It was fixed in software. 
- Fixed issues related with Transfer Ring Size equal 2. 
- Fixed issue with removing cdns3.ko module. Issue appeared on the latest 
  version of kernel.
- Added separate interrupt resources for host, device and otg. It was 
  added mainly for compatibility with TI platforms. 
- Added enabling ISO OUT just before arming endpoint. It's recommended by 
  controller specification.
- Added support for 0x0002450d controller version. This version allows to set 
  DMULT mode per endpoint. It also fixes WA1 issue.
- Added support for separate interrupt line for Device and OTG/DRD.
- Removed drd_update_mode from drd_init, 'desired_dr_mode' is not yet correctly
  set based on enabled drivers and dr_mode in DT.
- Added phy power on/off.
- Added setting dma and coherent mask to 32-bits, because controller can do
  only 32-bit access.
- Added Idle state for Type-C for TI platform as suggested by Roger. 
- Improved the flow according with Figure 24 from Software OTG Control user
  guide as sugested by Roger.

Changes since v5:
- Fixed controller issue with handling SETUP that has occurred on 0x0002450C
  controller version. In some case EP_STS_SETUP is reported but SETUP
  packet has not been copied yet to system memory. This bug caused that
  driver started handling the previous SETUP packet.
- Added handling ZLP for EP0.
- Removed unused cdns3_gadget_ep0_giveback function.
- Fixed issue with disabling endpoint. Added waiting for clearing EP_STS_DBUSY
  bit between disabling endpoint and calling EP_CMD_EPRST command.
  EP_CMD_EPRST command can be called only when DMA is stopped.
- Fixed issue: EP_CFG_TDL_CHK is currently supported only for OUT direction,
  It was enabled for both IN/OUT direction.
- Improved resetting of interrupt in cdns3_device_irq_handler.
- Fixed issue with ISOC IN transfer in cdns3_ep_run_transfer function. In some
  cases driver set incorrect Cycle Bit in TRBs.
- Fixed issue in function cdns3_ep_onchip_buffer_reserve. Driver assigned 
  incorrect value to priv_dev->out_mem_is_allocated field.

Changes since v5:
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
- fixed issue with incorrect calculation the number of required on-chip buffer 
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

 .../devicetree/bindings/usb/cdns-usb3.txt     |   45 +
 drivers/usb/Kconfig                           |    2 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   46 +
 drivers/usb/cdns3/Makefile                    |   16 +
 drivers/usb/cdns3/cdns3-pci-wrap.c            |  203 ++
 drivers/usb/cdns3/core.c                      |  653 ++++
 drivers/usb/cdns3/core.h                      |   98 +
 drivers/usb/cdns3/debug.h                     |  161 +
 drivers/usb/cdns3/drd.c                       |  381 +++
 drivers/usb/cdns3/drd.h                       |  167 +
 drivers/usb/cdns3/ep0.c                       |  888 ++++++
 drivers/usb/cdns3/gadget-export.h             |   28 +
 drivers/usb/cdns3/gadget.c                    | 2751 +++++++++++++++++
 drivers/usb/cdns3/gadget.h                    | 1338 ++++++++
 drivers/usb/cdns3/host-export.h               |   28 +
 drivers/usb/cdns3/host.c                      |   74 +
 drivers/usb/cdns3/trace.c                     |   11 +
 drivers/usb/cdns3/trace.h                     |  493 +++
 drivers/usb/common/Makefile                   |    1 +
 drivers/usb/common/debug.c                    |  268 ++
 drivers/usb/dwc3/debug.h                      |  252 --
 drivers/usb/dwc3/trace.h                      |    2 +-
 include/linux/usb/ch9.h                       |   27 +
 24 files changed, 7682 insertions(+), 253 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/debug.h
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

