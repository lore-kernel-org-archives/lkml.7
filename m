Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECA4C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AD9222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Cz5aqzBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392081AbfIZFQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:16:52 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:31136
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388115AbfIZFQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlvwydisLIke1SpTOfGOjDMjX+HalkqUKhQ4SppQT7dakAHVvITV0xgZcluTSbN5GxnMnXhhqpQe0+Mk97VQoTkWygRiKwLgYOJCUZbqNZqWCrBTBnFeuxb88Ld6XD5LwtIPWdQ1LrUCwtd9L0DBtbG5VPfZPSGFXGvEjzQFKUBV+fyz5GBMpCrD80yB4mh4NX6PZHIhXCfundkU0AM+EJia3OYdvRTmQwrfJSdzmGh8lnhTKf1tztSGsx4QDCwRNhWVWtKEoLPEZozytpCRBdCjY0kSU5DzRKE6JiIJcOKy91EH6iwPZreEQO3nNXDLm6qec/Gb21SNrSfOb/I3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aSYEt1mAC4PIt4SUNOLCtPwY+MQPx8Nq+WMCoM88+A=;
 b=V6WRVIL01tPEzuoqjAU7dLunzitqbJ8+0P/V3fwUI3YEutthlbDeWV00c5Gflrm7yRkNlAoyUe2odBSVusQJmVmtciwSiW1sPzqjhQ+gFNKagXfNroWz25MhEb6oSypXTY/qHjEJ4b3MnG612BeCSEbXq56A9e3XfyVrZhLUar47Mj9j70v/tTnhDr/CnxkLu0DKMDPe+fQzVCRQrpzvcYLTpjlJl09tdhp4RoaiUcxNprFp3oGcgKIez/95DcKyop6jzj4SksoaKbQpxn4J5xHsH9ifKfWcD866iHiyoTQFZder8/0h9xST9tQ/eXzzpPH3rb4adeIkQMpBq/7QMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aSYEt1mAC4PIt4SUNOLCtPwY+MQPx8Nq+WMCoM88+A=;
 b=Cz5aqzBKGmDNKeAVPaHZqgxmF6ggWPXYqB+r6szm29PkPzPG8TSCUUHxLtQ1MkwMWqpBQzyRRZuCm/TnlCxdNwFjazYi4cR+IsJGpFiww/v24jG5RdbiaCJo658iS/R9/hNIL7/ggL2/JufnVFVfAzfQj3dIT/Yq0LdpKtLVnfU=
Received: from BL0PR02CA0133.namprd02.prod.outlook.com (2603:10b6:208:35::38)
 by DM6PR02MB5258.namprd02.prod.outlook.com (2603:10b6:5:48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Thu, 26 Sep
 2019 05:16:49 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BL0PR02CA0133.outlook.office365.com
 (2603:10b6:208:35::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26 via Frontend
 Transport; Thu, 26 Sep 2019 05:16:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 05:16:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM91-00062q-LX; Wed, 25 Sep 2019 22:16:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM8w-0007lO-IB; Wed, 25 Sep 2019 22:16:42 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8Q5GaPA005925;
        Wed, 25 Sep 2019 22:16:36 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1iDM8p-0007hs-R5; Wed, 25 Sep 2019 22:16:36 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCHv2 3/3] Documentation: short descriptions for Flexnoc Performance Monitor driver
Date:   Thu, 26 Sep 2019 10:46:26 +0530
Message-Id: <81f9de9559d248be498cac1ee0e3ab15c7a2696c.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(2351001)(47776003)(2361001)(5024004)(14444005)(70586007)(9786002)(70206006)(50226002)(316002)(81156014)(8936002)(8746002)(36386004)(81166006)(118296001)(478600001)(106002)(8676002)(6916009)(2906002)(50466002)(36756003)(76176011)(2616005)(11346002)(186003)(486006)(446003)(48376002)(126002)(476003)(6666004)(356004)(107886003)(336012)(4326008)(5660300002)(305945005)(7696005)(51416003)(426003)(26005)(44832011)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5258;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 223f1358-6b21-439d-1c61-08d74240bb4f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR02MB5258;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5258:
X-Microsoft-Antispam-PRVS: <DM6PR02MB52585B24790246939EBCCB58AA860@DM6PR02MB5258.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: OmRlhoLUT/eKf8VyErZyFWVF7JM1PIfQHdMmFpMuhLGD8OooKQrnA0p6jJq1dlxb6ZMrf/gOrZBsQS2WBGZbjgaOtMD8C7wh5DaUV/G22GQ464biGJdN5u9uXrYKgkJGg38peuZ+Db4pUP4hwlj9cN5EGoWXiIEv/VABdyK1uQQqcvlWpivoWFnHH3EpeKi7m1Pepzx1rMaL83vWrzlDtr2rgarmm4Yn8xTtrZWXfwCTG/TBimRO86tJLRq6QZqBjViFCCSPTB5LVNn/qfYJ7NA59Ui+4Pco1DxNG8khjT3l7BOiwcGnV9S/Wc9TjNRrOMY7kX//hZ3eqASbinQl+iJG98ytYr4G1UaehoII3GbkRqm5549mvmS6uwWGTa4eRR6kdpwTloEZRCHYnvnFB4tjlfy0Vc5phWaKovwoBiE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 05:16:48.1967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223f1358-6b21-439d-1c61-08d74240bb4f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add short documentation for FlexNoc Performance Monitor driver.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
patch added

 Documentation/misc-devices/xilinx_flex.txt | 66 ++++++++++++++++++++++++++=
++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/misc-devices/xilinx_flex.txt

diff --git a/Documentation/misc-devices/xilinx_flex.txt b/Documentation/mis=
c-devices/xilinx_flex.txt
new file mode 100644
index 0000000..c075934
--- /dev/null
+++ b/Documentation/misc-devices/xilinx_flex.txt
@@ -0,0 +1,66 @@
+Kernel driver xilinx_flex
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+Supported chips:
+Versal SOC
+
+Author:
+       Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+
+Description
+-----------
+
+Versal uses the Arteris FlexNoC interconnect instead of the ARM NIC. FlexN=
oC
+provides the capability to integrate performance counters in the interconn=
ect.
+It has configurable probe points to monitor the packet and forwards it to
+observer for logging. It supports read and write transaction counts for
+request and response.
+
+Features:
+---> Run-time programmable selection of packet probe points.
+---> Recording of traffic and link statistics.
+---> Separate read and write response and request count.
+
+SYSFS:
+
+counteridfpd
+       RW - shows the counter number selected for the FPD Flexnoc.
+
+counterfpd_rdreq
+       RO - shows the read request count for the FPD counters.
+
+counterfpdsrc
+       WO - sets the source of the FPD counter.
+
+counterfpd_wrrsp
+       RO - shows the write response count for the FPD counters.
+
+counterfpd_rdrsp
+       RO - shows the read response count for the FPD counters.
+
+counterfpd_wrreq
+       RO - shows the write request count for the FPD counters.
+
+counterfpdport
+       WO - sets the port number selected for the FPD Flexnoc.
+
+counteridlpd
+       RW - shows the counter number selected for the LPD Flexnoc.
+
+counterlpdport
+       WO - sets the port number selected for the LPD Flexnoc.
+
+counterlpd_rdreq
+       RO - shows the read request count for the LPD counters.
+
+counterlpd_wrreq
+       RO - shows the write request count for the LPD counters.
+
+counterlpd_wrrsp
+       RO - shows the write response count for the LPD counters.
+
+counterlpdsrc
+       WO - sets the source of the LPD counter.
+
+counterlpd_rdrsp
+       RO - shows the read response count for the LPD counters.
--
2.1.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
