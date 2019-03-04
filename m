Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACDDC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D97D20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CZAlvIhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCDXTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:19:33 -0500
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:44550
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfCDXTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mOooqAEJ/Ix4ao32Ec7oncg6wO/mGJflaTdPGmiKic=;
 b=CZAlvIhR3nkPOR+ryuNONDfIbMqrTVqFThLEK6TC8lUZo2HI7mAGLRNYYs8ah+eY1aFYF5UeVMxEYE8i9s8YRTPHVXnTCMa4rNWEfFPhXKOvFF5q7LxjopPczLVMg63DhS9B9kCBMw6Y3tsEZzKy/NT3NRmQfIRtZgpUsdvSWOE=
Received: from CY4PR02CA0032.namprd02.prod.outlook.com (2603:10b6:903:117::18)
 by BYAPR02MB4216.namprd02.prod.outlook.com (2603:10b6:a02:fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.15; Mon, 4 Mar
 2019 23:19:26 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by CY4PR02CA0032.outlook.office365.com
 (2603:10b6:903:117::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Mon, 4 Mar 2019 23:19:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 4 Mar 2019 23:19:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1h0wrl-0006Sx-KY; Mon, 04 Mar 2019 15:19:25 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1h0wrg-0004yZ-H9; Mon, 04 Mar 2019 15:19:20 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x24NJFob028869;
        Mon, 4 Mar 2019 15:19:15 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1h0wrb-0004xP-8Z; Mon, 04 Mar 2019 15:19:15 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH] drivers: clk: Update clock driver to handle clock attribute
Date:   Mon, 4 Mar 2019 15:19:10 -0800
Message-ID: <1551741550-10315-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(199004)(189003)(47776003)(106466001)(48376002)(50466002)(63266004)(5660300002)(72206003)(50226002)(9786002)(478600001)(2201001)(77096007)(8936002)(26005)(7696005)(51416003)(44832011)(476003)(486006)(126002)(2906002)(2616005)(336012)(6666004)(106002)(426003)(81166006)(110136005)(8676002)(54906003)(36386004)(316002)(81156014)(186003)(4326008)(305945005)(36756003)(356004)(16586007)(107886003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4216;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 449dbdc4-24f6-429c-8fad-08d6a0f7d838
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR02MB4216;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4216:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4216;20:AQjxinVu/3Zn8VdRvre1vujbrGWpO+bOojI856tryhtXuts5ZQ4W+meFJQjs3Zpta+Ke25gAkqaG/YzVPxC0DVcejw/Wovcbjk+SwQ5K1U5n+Y+X6r7WIZDHvM9lCrlMtg/Wj9MOz2/JFzz5NkHaFNXnULbEaPdCKsxMd6WVf9Mv1GHmm9wyitBGVTxjIuWq6oJ0L+G3H1DmXqUxO2wSV9thYKBku8ZOffKDR39bQQGe71HEthoFvA7iQjbreWhsoaaWMJwpxMl6R5Iz0KFb+2OYlmqTOIJVYBabEpLS6DSAfJ7HLpDn6r9Nr2JNsWnYaznanZc8oBNdT2kG028pt0qckN31JU9729Obetvv0FWL9Kd6NdEih3WBK9ZmoEwxapkDWF4VYRfYSt9owGyD5luiAkSGnGLgjhAqZGC0dqpOMczl0ZSsiD2XRDj7sQRLwxzF3KJEJP1TVaRlUA3oakzlCivG382qSw+HkiRqJVgfRUNFCKnZL8tC3RBgLddX
X-Microsoft-Antispam-PRVS: <BYAPR02MB4216D662D2372805E86580C1B8710@BYAPR02MB4216.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09669DB681
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4216;23:JwzfD1WBgsKVb9+g0IKxQySJDDoJvo/vCVFgm3/b2?=
 =?us-ascii?Q?WWaEQlcVwRbKhP4FdeuKsaS/X8pYS90mj3eA5q2GGR0y6MyKf4OAZ9Vtmg4D?=
 =?us-ascii?Q?pOQwWdVGYvqDFW8HZEYwiVwHR+8mBoon8PabHenWib7TfymOz9EqTYu3sr7w?=
 =?us-ascii?Q?AZh147MOH//nPu3CKj63N3WhOjMJ+LCRBSLSiOc3jbVe8hC3Wt/c8Ble+vOs?=
 =?us-ascii?Q?hZ+xy/G8HD/28uU8CsVUr2Qh78IHG5pdRl1Z3mHOO9Gw1U984S504aGxa2U1?=
 =?us-ascii?Q?tT7U7JmpRDEjAM1Jdh8R6TGcxalRcNGS8suY06Lnco1MYJVH8NBMTabqa7+8?=
 =?us-ascii?Q?R3rbLGk2/ADJDroFT9oqf7qjSanE4jq98zG/nF20g3Q2kanGTBdQ/nBH5DUc?=
 =?us-ascii?Q?8vzCbk7fO4s8mYY8hkKpMnZAyVFAiIcUUSiBoSyyJ+93h4ILnfn37U22dieT?=
 =?us-ascii?Q?Many2w1+EqTH/eD69EJC3VRJgmO1xPomOo7GugO8DQ0qBqv043wlHthYMSE1?=
 =?us-ascii?Q?xf7vcWuAjT/qBSVCQgt+xcPWCaAa2BPNoBY1kXYg7G6XGVF8mccmJKj4Cfr/?=
 =?us-ascii?Q?hofZxoO9va9zTyCA9g0xA4lkg59iVnKuynT2STQKhxfxChBeAGmXo8vYJcbo?=
 =?us-ascii?Q?PwKn582iyV8GwXhnzSD1ooJkZQLnfYWrWav4/90HpFGkqcGrqSqe+bXd/XGU?=
 =?us-ascii?Q?L1OFrs3EjaAECxKSoqhtmwFciNYNSES/MUrcd0fRmu+5tDzWp2CEP2EchRRC?=
 =?us-ascii?Q?mHvYbzFS//WEIHjgqp69Lca7D9DbAso9pMaF9elInFtR4LIgBaWAma+xdObI?=
 =?us-ascii?Q?4QHA0TIGvCApxm/PVcb6OLrQwFbYoH1IZ0JeGLcT30mRsUXuNmM/UrZytFN6?=
 =?us-ascii?Q?yuHvNa5h74LqzELrcO20aifkLvUE0QS+XwBXyXF9DkiguKqNckjGrQhyCzWd?=
 =?us-ascii?Q?qtkG0ko+DqUXUIDFWdeGILeuwkwsTXqqgf4WonJvxvzOA89YRpTOltElhEpR?=
 =?us-ascii?Q?oYcpZFSciMyzemVD9IKVDRXgN3qjCVszR8/aKaytiFc7yultpdxCx9BFm3Oe?=
 =?us-ascii?Q?xqOEa804K6QeFh2Tx9z8mgLYV+tXML3BTKgQfgeOWxQvFKnpw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WpKsTCVrNwFGn5SHNpRPN3J1ID7baDc/4UmGhZXE6XTbjFXLis3Z5W8OsHQKdPRCN4UjgxgZRcaqAl06blPVLUthrynIoSHEINna16NBZk9p18saVGSTdiBb7auSsKH9ROmaB2hWCPZCRwrh+oyYYy1auorhLENNyML1i6T6h2b748PCqX0PSDxXHgG/tqM+yrqzk82sLngb1EHOq3YzRcGKiLinxgoHF8sBaCeEwykSP0TV51UbStllFvxglqpZb/u1eSxIybT5mO0o5wO3ECVLGdGqy+RFvEnN0DHuxGmW3gvnEYxq8M4pOugdj34ousO03goR8Zh62A9iUX66EfkG9PIp/9/MKDtbrVc4lZVvGPcwxIEKm6MiOZZHpJcRQsgdrRXirF4qtx2HkbtvoncDnAIBtk1GLz2DQC46V+w=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 23:19:26.2033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 449dbdc4-24f6-429c-8fad-08d6a0f7d838
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Versal EEMI APIs uses clock device ID which is combination of class,
subclass, type and clock index (e.g. 0x8104006 in which 0-13 bits are
for index(6 in given example), 14-19 bits are for clock type (i.e pll,
out or ref, 1 in given example), 20-25 bits are for subclass which is
nothing but clock type only), 26-32 bits are for device class, which
is clock(0x2) for all clocks) while zynqmp firmware uses clock ID
which is index only (e.g 0, 1, to n, where n is max_clock id).

To use zynqmp clock driver for versal platform also, extend use
of QueryAttribute API to fetch device class, subclass and clock type
to create clock device ID. In case of zynqmp this attributes would be
0 only, so there won't be any effect on clock id as it would use
clock index only.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/clk/zynqmp/clkc.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index f65cc0f..c13b014 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -53,6 +53,10 @@
 #define RESERVED_CLK_NAME		""
 
 #define CLK_VALID_MASK			0x1
+#define NODE_CLASS_SHIFT		26U
+#define NODE_SUBCLASS_SHIFT		20U
+#define NODE_TYPE_SHIFT			14U
+#define NODE_INDEX_SHIFT		0U
 
 enum clk_type {
 	CLK_TYPE_OUTPUT,
@@ -80,6 +84,7 @@ struct clock_parent {
  * @num_nodes:		Number of nodes present in topology
  * @parent:		Parent of clock
  * @num_parents:	Number of parents of clock
+ * @clk_id:		Clock id
  */
 struct zynqmp_clock {
 	char clk_name[MAX_NAME_LEN];
@@ -89,6 +94,7 @@ struct zynqmp_clock {
 	u32 num_nodes;
 	struct clock_parent parent[MAX_PARENT];
 	u32 num_parents;
+	u32 clk_id;
 };
 
 static const char clk_type_postfix[][10] = {
@@ -396,7 +402,8 @@ static int zynqmp_clock_get_topology(u32 clk_id,
 
 	*num_nodes = 0;
 	for (j = 0; j <= MAX_NODES; j += 3) {
-		ret = zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
+		ret = zynqmp_pm_clock_get_topology(clock[clk_id].clk_id, j,
+						   pm_resp);
 		if (ret)
 			return ret;
 		ret = __zynqmp_clock_get_topology(topology, pm_resp, num_nodes);
@@ -459,7 +466,8 @@ static int zynqmp_clock_get_parents(u32 clk_id, struct clock_parent *parents,
 	*num_parents = 0;
 	do {
 		/* Get parents from firmware */
-		ret = zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
+		ret = zynqmp_pm_clock_get_parents(clock[clk_id].clk_id, j,
+						  pm_resp);
 		if (ret)
 			return ret;
 
@@ -528,13 +536,14 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
 						   const char **parent_names)
 {
 	int j;
-	u32 num_nodes;
+	u32 num_nodes, clk_dev_id;
 	char *clk_out = NULL;
 	struct clock_topology *nodes;
 	struct clk_hw *hw = NULL;
 
 	nodes = clock[clk_id].node;
 	num_nodes = clock[clk_id].num_nodes;
+	clk_dev_id = clock[clk_id].clk_id;
 
 	for (j = 0; j < num_nodes; j++) {
 		/*
@@ -551,13 +560,14 @@ static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk_name,
 		if (!clk_topology[nodes[j].type])
 			continue;
 
-		hw = (*clk_topology[nodes[j].type])(clk_out, clk_id,
+		hw = (*clk_topology[nodes[j].type])(clk_out, clk_dev_id,
 						    parent_names,
 						    num_parents,
 						    &nodes[j]);
 		if (IS_ERR(hw))
-			pr_warn_once("%s() %s register fail with %ld\n",
-				     __func__, clk_name, PTR_ERR(hw));
+			pr_warn_once("%s() 0x%x: %s register fail with %ld\n",
+				     __func__,  clk_dev_id, clk_name,
+				     PTR_ERR(hw));
 
 		parent_names[0] = clk_out;
 	}
@@ -621,20 +631,26 @@ static int zynqmp_register_clocks(struct device_node *np)
 static void zynqmp_get_clock_info(void)
 {
 	int i, ret;
-	u32 attr, type = 0;
+	u32 attr, type = 0, nodetype, subclass, class;
 
 	for (i = 0; i < clock_max_idx; i++) {
-		zynqmp_pm_clock_get_name(i, clock[i].clk_name);
-		if (!strcmp(clock[i].clk_name, RESERVED_CLK_NAME))
-			continue;
-
 		ret = zynqmp_pm_clock_get_attributes(i, &attr);
 		if (ret)
 			continue;
 
 		clock[i].valid = attr & CLK_VALID_MASK;
-		clock[i].type = attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTERNAL :
-							CLK_TYPE_OUTPUT;
+		clock[i].type = ((attr >> CLK_TYPE_SHIFT) & 0x1) ?
+				CLK_TYPE_EXTERNAL : CLK_TYPE_OUTPUT;
+		nodetype = (attr >> NODE_TYPE_SHIFT) & 0x3F;
+		subclass = (attr >> NODE_SUBCLASS_SHIFT) & 0x3F;
+		class = (attr >> NODE_CLASS_SHIFT) & 0x3F;
+
+		clock[i].clk_id = (class << NODE_CLASS_SHIFT) |
+				  (subclass << NODE_SUBCLASS_SHIFT) |
+				  (nodetype << NODE_TYPE_SHIFT) |
+				  (i << NODE_INDEX_SHIFT);
+
+		zynqmp_pm_clock_get_name(clock[i].clk_id, clock[i].clk_name);
 	}
 
 	/* Get topology of all clock */
-- 
2.7.4

