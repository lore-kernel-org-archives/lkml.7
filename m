Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001D7C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 11:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70E1207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 11:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="16mz3cRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCILRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 06:17:24 -0500
Received: from mail-eopbgr820070.outbound.protection.outlook.com ([40.107.82.70]:22064
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbfCILRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 06:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2WNQWMaSqxjs03133fNOegFIGfBGZRBePZaNhPSbng=;
 b=16mz3cRUBT80mJgcxqkJBPqL/mnzmUUI6eu0zn2l7Vxk1dNqtM+Y+g3u9UCM4iONGn4e/tbMYvge0pvGiCLt2y6XoNXt+F3x85joPLogp/lOrBBUpHRvKDAuDmnt0FVXtwmmmljXtjNyNOUhCCkmIXfFo7mP3b1EtUEGfw2tYek=
Received: from BYAPR02CA0055.namprd02.prod.outlook.com (2603:10b6:a03:54::32)
 by BN6PR02MB2371.namprd02.prod.outlook.com (2603:10b6:404:30::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.18; Sat, 9 Mar
 2019 11:17:17 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BYAPR02CA0055.outlook.office365.com
 (2603:10b6:a03:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.16 via Frontend
 Transport; Sat, 9 Mar 2019 11:17:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1686.19
 via Frontend Transport; Sat, 9 Mar 2019 11:17:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55281 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h2Zye-00006q-0u; Sat, 09 Mar 2019 03:17:16 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h2ZyY-000295-St; Sat, 09 Mar 2019 03:17:10 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x29BH4lS028366;
        Sat, 9 Mar 2019 03:17:04 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h2ZyR-0001zJ-LJ; Sat, 09 Mar 2019 03:17:04 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <robh+dt@kernel.org>, <=mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <harini.katakam@xilinx.com>,
        <sudeep.holla@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>
Subject: [PATCH] arm64: zynqmp: dt: Add TI PHY quirk
Date:   Sat, 9 Mar 2019 16:46:58 +0530
Message-ID: <1552130218-21505-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(199004)(189003)(186003)(478600001)(36386004)(47776003)(5660300002)(50466002)(8936002)(50226002)(2906002)(48376002)(77096007)(16586007)(51416003)(6666004)(356004)(14444005)(63266004)(106466001)(7696005)(4326008)(26005)(2201001)(426003)(2616005)(486006)(476003)(305945005)(110136005)(126002)(316002)(9786002)(81166006)(81156014)(54906003)(44832011)(336012)(8676002)(36756003)(106002)(42866002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2371;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cab4ae8-aa8c-48fc-9a20-08d6a480c9d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR02MB2371;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2371:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2371;20:jtUbH0+G67QlEHQCfXL0XHsV6//NGo2mYGJvqCqo82B+YANEyljtUkRJb5tdwFX6ComEUjiEpya9tqTTemHufxSqzOdSSVxt2ruFfJCXBkFL6Mqe/plEgs1Fe6cV4CKaBtkUEadb/y5WAJ8dYX7llIrxsfJk/NwUubpr+e/GvB2r13K4O7/w7meShgQUpaxC31H6ItiDIEntQE+weNBKgbeGGl6PkOqXD0nCdNdsDD/apDxO1RWl4yOeIzQugjawCkULKK3IlRzTghfOClfCNzDCicIO9XfhvLzcToXc6Y7Emc/v5Wqz8d0G7WukXfLZplbi8kRkSVWGGpVjx+NLWb4cF+6Xv+I2hLYD0DN70trbGSoCZLRgYBxLhPDYVFhCp+Pm+S9vVQh87yc6FajYEB3SRew/Yrgr7B0Lx2HzY3ElsjyfkpmwFaZZkWuohhDiNdofGjvjZaINUQsjGEoKs1+gfceCRZuXnjnMUeFbi5SW24sqIqRLg2hZ9O4Hcosb
X-Microsoft-Antispam-PRVS: <BN6PR02MB2371D4C350939FD8F7547EECC94E0@BN6PR02MB2371.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0971922F40
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2371;23:J9MXeABIATk39Qrx+yQ2M1UW80UyHRr+pRT4fQa2/?=
 =?us-ascii?Q?o5yJPDZ6/tyIRsSl3Aw7Tvet2Vswst8ieV7OBaBgtfLkaFYrol2y1rfQTpyJ?=
 =?us-ascii?Q?pYTw3luaiXHwsOTiYpx3EiEC4roCOv2IkU+UMl6n7t5r+e4FA9N3oIYYFBT6?=
 =?us-ascii?Q?gu4URotwMzbNtL3l6Lzk5E3C1u6mrgX50Z0IUWtdU/yHe779V95Iloawcv3O?=
 =?us-ascii?Q?op3fC5rtja06JIEurzgQSF8v5iiB1G0KXYpQsVmAYRstNjPMRK+4gfQtJbOE?=
 =?us-ascii?Q?+08HMIxHF+5PpcSnGSXZ46X6H6xnP8y5UPgJsdsF0kYRnkrzsyF9H2+FS3bU?=
 =?us-ascii?Q?REUFxXx5/hm+bKgMSyyUNHH87XiNoD6VmFa9AlrN2nhLUxCcLy/AWdFETMux?=
 =?us-ascii?Q?EJLXB7FSvcRKUHNheQkS1VMs042UmCSJNDM7h0taUGinn14CFakfKl+ixiix?=
 =?us-ascii?Q?jqIHi9fLhdsS8Vn9iKBfXK0+nx8oFR9T1mXf2+tXqrI2cmvOf1aB0hYbmSDe?=
 =?us-ascii?Q?wFCHS+RKXlwrOEWdKDQiqpdteslUWiOwRmkNr0LdRr4mjfrzcKVkxmObNyxK?=
 =?us-ascii?Q?6kFGucjTUZsn3miDkt/0Q94C1YGfhGB3E92y5PZESUZKxQ3oUkjrDi83Iug0?=
 =?us-ascii?Q?1jEDWK38kO6ELn0wb2w627QaqMgliX7MxOfDN7eUkuGMay3sOdrckXCAakmp?=
 =?us-ascii?Q?dNSQmvYt9sDmXvv4VTS7tpSBoN2EMs7LgEClQn3hbkuZScaugCMl3oOT5z+Q?=
 =?us-ascii?Q?O1lM1PC9Zax91CA2X5bCLsxLrgV9WBRkg9axcQxitf4H4V4oEIvzQdGlzSKY?=
 =?us-ascii?Q?KRPQmdALEBKp1iwbHzrAUF17X5ynuIEF5Yn39MJ7YXgqNj1f64ARn9t3aFZZ?=
 =?us-ascii?Q?TeBC92HzI8TymcEHDWpZ1+gXSYIcMHNp2Fb8KUMzhw05AtqWdQGVuXDy6olH?=
 =?us-ascii?Q?gMDA75k+Fkc3lyTJFEo/OXtNFikUVgFmVHQBzSZndWqseQWKP3Kqf+QNmGha?=
 =?us-ascii?Q?8IwkyDf+ERf9lEyH3/t7i5dKaxXtnX3E1HIEYegZVYR/Ijd3yfoO2dEjC5cK?=
 =?us-ascii?Q?TZkDviBDyDhJCNtXuDMAWojTJKoTVRnqx1jxijZgxNQSda1ng=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xJbr6Sp1yR74GJ+dFE5tSkZHuK8ebjm0bBzCLPtSwxB24QzC7Z1B/0j9ZgVneojZN1cNb1zB9pHKbiYqLJyOR1eVSsxgk8D7Dm8cpx20JT2yXNsEmw7D8/6XSRme+4n4IQ11kYEYnEQJ5XZxPi5e5B4kMY6rU/utm/RF2ZVViYkEBoGCthOk4Sxck6Q088T16R4lCq3HPoIcw7wcfGYR7oZe1nKDGqNgckz83LDuoWQdoeI6H2j/9jVt5oovAMl45D8fGpkAx05r8T0Eu7fuQeD38NZxKRSgaHZeK77cOrGYS1Rayn6afi5+oKGHdiLcodTiWL6xUeCnopmVpj6LEq0dC7wZlkJHBloMWnIx+SKZ0hAWI3aiAosuiByUX+nVgrR1OOTad3OHZgQ/mRT0Qzv/rAgQSn3S1cOyrwlMzfo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2019 11:17:16.4954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cab4ae8-aa8c-48fc-9a20-08d6a480c9d6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TI PHY strap ctrl quirk for all the HW where applicable.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 11cc671..2421ec7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -89,6 +89,7 @@
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
 		ti,fifo-depth = <0x1>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index cef8167..2a3b665 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -110,6 +110,7 @@
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
 		ti,fifo-depth = <0x1>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
index af4d868..1780ed2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
@@ -21,6 +21,7 @@
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
 		ti,fifo-depth = <0x1>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 	/* Cleanup from RevA */
 	/delete-node/ phy@21;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index d4ad19a..8f45614 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -55,6 +55,7 @@
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
 		ti,fifo-depth = <0x1>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 94cf509..93ce7eb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -111,6 +111,7 @@
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
 		ti,fifo-depth = <0x1>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 460adc3..8bb0001 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -106,6 +106,7 @@
 		ti,rx-internal-delay = <0x8>;
 		ti,tx-internal-delay = <0xa>;
 		ti,fifo-depth = <0x1>;
+		ti,dp83867-rxctrl-strap-quirk;
 	};
 };
 
-- 
2.7.4

