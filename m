Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0859BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D422070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QdFOj7U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCNOC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:02:29 -0400
Received: from mail-eopbgr770058.outbound.protection.outlook.com ([40.107.77.58]:12622
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbfCNOC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VPpJWatAVauEfGM00K/2YJ8HXVAzPLhnhrytnyCSx0=;
 b=QdFOj7U+MfXQ2oo72rXTb435vVEfie/vPjzfq5hsJFDpJ4NjXP2lse5LJ4zxaKo/kewXUei093z/T7Ftsze9vpivkiMP/biemh5bgSgCDNA33Y69GhSVfHuh0J5i6b2l/Jh6c2a5xXPhhOVFzNvaWuAW2BmsUflqEho+LbWKFZ4=
Received: from BL0PR02CA0137.namprd02.prod.outlook.com (2603:10b6:208:35::42)
 by BL0PR02MB4339.namprd02.prod.outlook.com (2603:10b6:208:40::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.20; Thu, 14 Mar
 2019 14:02:23 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BL0PR02CA0137.outlook.office365.com
 (2603:10b6:208:35::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Thu, 14 Mar 2019 14:02:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Thu, 14 Mar 2019 14:02:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53649 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qvy-0002ki-UK; Thu, 14 Mar 2019 07:02:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qvt-0005Yx-Q7; Thu, 14 Mar 2019 07:02:05 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1h4Qvs-0004xG-74; Thu, 14 Mar 2019 07:02:04 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v4 5/6] dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
Date:   Thu, 14 Mar 2019 19:31:21 +0530
Message-ID: <20190314140122.23372-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190314140122.23372-1-nava.manne@xilinx.com>
References: <20190314140122.23372-1-nava.manne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(189003)(199004)(110136005)(6666004)(106002)(476003)(186003)(14444005)(9786002)(356004)(336012)(76176011)(26005)(316002)(2616005)(486006)(2906002)(47776003)(126002)(5660300002)(36386004)(51416003)(16586007)(36756003)(426003)(305945005)(48376002)(50466002)(50226002)(106466001)(446003)(478600001)(8936002)(1076003)(7696005)(81156014)(81166006)(77096007)(2201001)(11346002)(8676002)(63266004)(921003)(1121003)(2101003)(83996005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4339;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57cf8c1-e418-40b4-b1c2-08d6a885a7b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BL0PR02MB4339;
X-MS-TrafficTypeDiagnostic: BL0PR02MB4339:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4339;20:7jFqDjh6ejOZlNDdbLmRZBmK47YcjOGBLf93JcWNLj9qJtFNmy7u1oPrqtNzhVo7R9Ywyr6kXi7R+3wFgKiYkLmS0dSBZoNH8MMZPa7cs8CCSWcCwaAWSoLOeZCxsIbSCNnguYRwoU4HVY/1dVkOtq5GJ1W1ZIjRUSCNxnJorRBFy1r1uYAGyngtcYmFPs6S4lLPfbLGQjonYsGAJhgRnJRKfaxAbseXU6+n4A3b8zNhlxA/0bZ8sVed1tybyb1hekKh8NmDaQqpGmjFYYQ3/Fq/nyQish9esZB3VxsvtApD/LgmZvylj674aegh+DZtTZ41wr3boa+Fn4UmS9t1OzgREM3UUdOJCrAfIdqU5hU547NeF+Oq9xTL4ux5LtImqxeSvIZQ5t/tY6WE2I6JGBdJ8HUMvokbx3sjuhrNfxCP+lkxq8JGqdElMa9a2SV6qU5u8rlzgsO5bugI+CszDd3ZlW3xU1geqJHonqFYPU37nLG54DijfzHbxfmHVBjp
X-Microsoft-Antispam-PRVS: <BL0PR02MB43396908B5C030A30C820FA7C24B0@BL0PR02MB4339.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09760A0505
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4339;23:qof2RdUw0SHkrCkdHN0cWthLKXIe1Yyy4HgQm/f79?=
 =?us-ascii?Q?3slVwyOim/At9co/K52DIxOFwbbX/xWLlEu48yq38nwvJz5JY5zsPX4zkqf9?=
 =?us-ascii?Q?e0yuwf7a0nu5/cFyJE2RxQtfEWT3FJHNI1a/8fuoOWe6S3iqOHFqPtxHMmK1?=
 =?us-ascii?Q?CdVdb3pxSwGNpUWbaNYXahyGa3yhJMqhfc8+RTt1dp/lsHABQMwkoKGNqa56?=
 =?us-ascii?Q?vjErHEA1k77NceZJdGyG9UWqTakD8LTbB95/dbz10ot/12TKrhVjEhEKjrT3?=
 =?us-ascii?Q?GK1RSr1ZSn6KfnHprz5WFYFJMxUKflzCAlVmYgARGgBchlBcQssgBrGkoyEL?=
 =?us-ascii?Q?U0VCNYNFi3YAXcsJ2oz8d87tEK54oy89i/2uck0JJkX8SkWNyLY9ZDrVpWLG?=
 =?us-ascii?Q?cj2IwfMjYe6Fn/odPb34RTci3Tom4UwpU0VgUW8mIdRNJgb2rhKtYV4ZBkG3?=
 =?us-ascii?Q?FTJMzBDGUy8es3yCLSuuVaEFthbc0F4Y/FLqHsaa242u9S8ghWZCnk8DHCdE?=
 =?us-ascii?Q?a48rCglNQcTsj0QjALuofdhH9M4GHJQCL2i0vEcawjMyBSQV8aqVbbGEX95f?=
 =?us-ascii?Q?yGPRZtqTyI3UsfR2IwuKrYQ8U9zwVZ7m8bVCPXTP9XCyoWIp8UmtDADzKOfJ?=
 =?us-ascii?Q?mZH8NgSWCM+TZ2IMPCvJ8VnG6MtXYpUgxySdWS7WPFdKElnWeC2CXtp9i+Ve?=
 =?us-ascii?Q?wPP5/waYRZ4O3L7s1ydTRyvTU6I1HBPSm0KxUk+GOECVJvNXrn/7lI5/Fl8L?=
 =?us-ascii?Q?RDTo3MneG5BTQnzZLQKQZQmWCwWPsFoQi2dQMsPVjzaQYgKv5nbtDhIbKG7v?=
 =?us-ascii?Q?coV+Y16NC28vOg3LoDRDM43aASqscY7S04gR1CwXZBFVK8uDwM8fzZRmhvMz?=
 =?us-ascii?Q?q3dxjhGNZ3TVwAePW4QhFGGaIcPydDcDFaSfNfgzyZG2xP8dA9LO9rB42dPd?=
 =?us-ascii?Q?kHeIyOLiisevjcY5eBOb+yQVZSSBJpzzF/Bft//NTBpa6lK+c0vaVjeg+nP/?=
 =?us-ascii?Q?U5mffkvK4r04nAl9rBreXLAl3uKOf5sFF3PNSlSLaG1PaBqZjc9Vx5JeIwee?=
 =?us-ascii?Q?Ioxs2D2QQHqWMYRqu6/NynoAvnHa5kZDUAUDIK/tBpFNGjnUiQBB6Zc5CZcG?=
 =?us-ascii?Q?/q1L5XUaQEoYMe8PJxZqeZ5hokX2z9dsPkVD+ETXULbON4qLkkqFg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wtVrqP8G0ELs2ACiXDjlqb0/27Zf4FCFQU3sj4v2S3Vm10dRPy6V7DZck9GVZqu2HZrHO8TAfVeMapO4JetASi9QipkMk9wbMBiV54QFeeBzaa9+uC4gzo2MNP3VuuenLhYODsSALfERuvoQOFI1hjxyYIyxeNuvroX2++c1cixadbMncLMxawsLr2wI5Db/9ZTtf7To1qjNwJ+DIGDe7PO0jhWs+/+8Bh9X4nkhOkTbUCxQyZ5clbFfwsKZUEac1Xec2hLJYGV7uYx3Zg++5Mk42J/sJZSLojWhXh8zcgj8VnlWntHjIqNLnd2vvJmlmfTAq/cPciO2B/8yxLOTdnGIRxtNgPR6pxeFUj5AEapFNZWFqAl7xDsf59CoU0lLNP/9V+3Q8uVGa1Chfu9UWeYT4fInee5AGma2orHaRyE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2019 14:02:11.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57cf8c1-e418-40b4-b1c2-08d6a885a7b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
new file mode 100644
index 000000000000..2043c8284f8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
@@ -0,0 +1,47 @@
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+-------
+ Example
+-------
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		nvmem_firmware {
+			compatible = "xlnx,zynqmp-nvmem-fw";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			soc_revision: soc_revision {
+				reg = <0x0 0x4>;
+			};
+		};
+	};
+};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+	pcap {
+		...
+
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+
+		...
+	};
+
-- 
2.18.0

