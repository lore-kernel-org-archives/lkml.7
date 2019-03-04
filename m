Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79959C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2452420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XDtxwWf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfCDXSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:18:31 -0500
Received: from mail-eopbgr820058.outbound.protection.outlook.com ([40.107.82.58]:15824
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfCDXSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYUmpP2dSrI6REqB+re+dY3IEQagoA4eLgCGZQYtN+4=;
 b=XDtxwWf6WRo7YFXDEqbmE4j2frYcY8DmMmg3wCRFJiqO5DL5kx7tuWl9b5Bt20TJS56/Sh8Abqct721WVRj62D8y7iUaZFRpN5NH4vEyrMWR2YcdZBlhvIKvXsZPorXx1qZU2Kczgz5+7vHtEQdJF+DLO3fvcCfFbqLtv8mEqlQ=
Received: from SN4PR0201CA0022.namprd02.prod.outlook.com
 (2603:10b6:803:2b::32) by SN6PR02MB4222.namprd02.prod.outlook.com
 (2603:10b6:805:2f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.18; Mon, 4 Mar
 2019 23:18:26 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN4PR0201CA0022.outlook.office365.com
 (2603:10b6:803:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Mon, 4 Mar 2019 23:18:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 4 Mar 2019 23:18:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1h0wqn-0006Sh-9g; Mon, 04 Mar 2019 15:18:25 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1h0wqi-0004sb-6I; Mon, 04 Mar 2019 15:18:20 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x24NIDwO003555;
        Mon, 4 Mar 2019 15:18:13 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1h0wqb-0004s5-6d; Mon, 04 Mar 2019 15:18:13 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <michal.simek@xilinx.com>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH] drivers: Defer probe if firmware is not ready
Date:   Mon, 4 Mar 2019 15:18:08 -0800
Message-ID: <1551741488-10226-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(189003)(199004)(51416003)(356004)(6666004)(44832011)(4326008)(106002)(107886003)(6636002)(47776003)(7416002)(36386004)(7696005)(316002)(54906003)(16586007)(110136005)(5660300002)(14444005)(5024004)(106466001)(50466002)(48376002)(2201001)(36756003)(50226002)(426003)(305945005)(77096007)(26005)(186003)(2906002)(9786002)(476003)(2616005)(126002)(63266004)(81166006)(486006)(81156014)(72206003)(8676002)(478600001)(336012)(8936002)(107986001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4222;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d488852-de44-480c-6305-08d6a0f7b44d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB4222;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4222:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4222;20:Ay97OgSbGkvRoN1AUi9YuXlZlrVIsy20AC+61WOPmjdeBMNxQL2z9M1c+UY4OX+9X8vriAnyygA9Ygjczr3E+Q0A1ap6lzEtb++V036RmuLXV38a7rf+RDaXOyLxQyCuzL9mbgsMe5OaqF4GjGFlaySkW4pSioe4ITERklt2TDti+1NMEBxwBnD/L+Pqhx4lpa++TShLOKQolf5I1++GJaYkfPbguFwr5HSVR5TFo/85kTKvW28vCuaTtNCmMjY6U7EJYdUyYg62wWNgDmWmO4qtVa2UY+HORKrGdLjBXYzrEM3/9Y8b/BeRj67OlOdRDWM0VmLmmnuF6jMoXpOXo/82g+MbT9zOMzTrVCjO5VwAnTiB8nNjAZmrRhnNGMkGOt5otg5ZCol09rVUUMDqiZiUC/i6D2H51QZ92v7X1zmwaqhZJzHD/Pt2uv/PgWn4UFfLx663oj1e9zEQbQWP/zFvV1rLKoO6wNHkl90OrVXsT76rq/5T77NLTbCj9gbO
X-Microsoft-Antispam-PRVS: <SN6PR02MB42221438F12D1D34CA4B11F1B8710@SN6PR02MB4222.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09669DB681
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4222;23:riutk1L6nGF5+nBRkBDdgnUP0nZSchSc57OvYvyqJ?=
 =?us-ascii?Q?MBOpev8OYrNleNWjW7kj9Z5OgNQpIopwWZsgqlMfy9BkRR6XJR9uvrBw1Wgx?=
 =?us-ascii?Q?Hr7Csyuki2dzHABveEmCu2uj7SyN1yVC4jY/ad663pUM+JGQeID0g0oiIwZi?=
 =?us-ascii?Q?54ZX9teW1eQUvc76Ac2csXLTiGMO0Fj9Gn038mqWcEitpDRJhuJYVun7xRfe?=
 =?us-ascii?Q?vl4xKI+y2irfgWd9sciNr1LIaPrKVt7NdkcQMydBTEfVQWvOm8poHO7TAFWK?=
 =?us-ascii?Q?DGS8zKXv6ZjrOxqZMkm6Kd3HPKJ77u1ccqV4YqbQnzyRjJySYbkcf5TdwdzS?=
 =?us-ascii?Q?G0UfqugVdPYId02PDsBQzh7jdH9ReKPwSF3IFO+BBrh6V/z1MipjWUPfpoV8?=
 =?us-ascii?Q?Z/bx+VrpiZeqcGY4hHmXS37AibDUALV3ca+yMKCf76hPmBQzN+I54lf53CXY?=
 =?us-ascii?Q?P+lxP1uO8HupWKoYKo1/ZYrBIr8AWBgQvXPIhRrIlIZ6Sld8/WpzDwL6SADb?=
 =?us-ascii?Q?6E3KWd+JZXa1D8qy05SvMWR1LwzY9bKV6K+CMeSawmybtTfYjcbTaAe9erCk?=
 =?us-ascii?Q?JUdE812rRkHQc87I01QJaj6xKOzz7ku5h5ZVXBKKXHvGknVUI4XwExjThMFM?=
 =?us-ascii?Q?GeKngRK0WwXgZekUQE0IkRb0FV5TCjaTb5YtjzF1rUyXAbfS0WP1nBdrHhP7?=
 =?us-ascii?Q?3VvzDvNtg5tWySByeiaTKKD/eRs5dQwaCJ2z6d4VnN2JPU6EPJhAflbLldWW?=
 =?us-ascii?Q?UAXU1tiOE0VfU3klxHXTvo7wi9E3N7XRfomYnqm7d1AdqLURdmIG9UfNK2f/?=
 =?us-ascii?Q?VXV9ufSWHFvE99WBHMt5R0xnORfkj+DZ9ZRzbziPYcmSL2YLbolMD5hmjCRF?=
 =?us-ascii?Q?Sw/5F7ptKTpFjsUBHe/bW+2jvX4h50ISf/70HEqSnEfTHmCFxZos8S6h6cOB?=
 =?us-ascii?Q?n1CznYrauX+K0JJ1BWaB3CIBRl8z+bgHxGYC8ovrpm2TeNan3A+uUK27RdV1?=
 =?us-ascii?Q?qnv/kNYL1SWS1nwQREYQssSedMDyjcypcllIGCucTrtr4NX+PO0bUHpO8dQF?=
 =?us-ascii?Q?X6olezDXCI/ZQGAap9Xm45FBaP8XOwwlkB6Amq1HndhehFYF3YzZ64DKM3Dq?=
 =?us-ascii?Q?ulF1Lij0y49ofScuiO+YAKArFQHp1dP2yjTIcdFy5jvAYArlIDc22AuvX9XA?=
 =?us-ascii?Q?PyoSSBvp9BLqCI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vj/gdnIgluEht2S0/fkdUjMJp3FrVK2DnKvtc87lrx/fgdn/911TKeiWv1SmNPEshce379wXZ9n+KWCe1EFHboVUUqfDcMYxLYFybAwUCPHbU7mlzpvCvSINgJPUfMSOFBY49aJ3EEYVZRaMxH6o3qUkhl+ruTX/Qp8nFEZHyNKmmWNFibVR2QpgkVMpcs6zJ+0tpgnM443TZAQS9XU3cvcI4iZGIvgs6UqWdOqcS28mCCHCSez6WMJHlSdcVBXwtvSC2GlipYKllozw7yPW5WmYiNe60jQc/BkKpSz3h6wQqIElhaegpuoOyCVppkEjd/BkdEEU648ZmRSEzds0rU57wuY0NQ4mT1QOoO5kEY2MA8If8Yp9H6pg0o/q5KVsEHBkJGuDgtpThuX18dzjSoprB3n35S0HPogU4Tqeldc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 23:18:25.8748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d488852-de44-480c-6305-08d6a0f7b44d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Driver needs ZynqMP firmware interface to call EEMI
APIs. In case firmware is not ready, dependent drivers
should wait until the firmware is ready.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 Documentation/xilinx/eemi.txt          |  4 ++--
 drivers/clk/zynqmp/clkc.c              |  4 ++--
 drivers/firmware/xilinx/zynqmp-debug.c |  3 ---
 drivers/firmware/xilinx/zynqmp.c       | 11 ++++++++++-
 drivers/nvmem/zynqmp_nvmem.c           | 10 +++++++---
 drivers/reset/reset-zynqmp.c           |  8 ++++----
 drivers/soc/xilinx/zynqmp_pm_domains.c | 18 ++++++++++--------
 drivers/soc/xilinx/zynqmp_power.c      | 10 ++++++----
 drivers/spi/spi-zynqmp-gqspi.c         |  5 +++++
 include/linux/firmware/xlnx-zynqmp.h   |  2 +-
 10 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/Documentation/xilinx/eemi.txt b/Documentation/xilinx/eemi.txt
index 0ab686c..5f39b4f 100644
--- a/Documentation/xilinx/eemi.txt
+++ b/Documentation/xilinx/eemi.txt
@@ -41,8 +41,8 @@ Example of EEMI ops usage:
 	int ret;
 
 	eemi_ops = zynqmp_pm_get_eemi_ops();
-	if (!eemi_ops)
-		return -ENXIO;
+	if (IS_ERR(eemi_ops))
+		return PTR_ERR(eemi_ops);
 
 	ret = eemi_ops->query_data(qdata, ret_payload);
 
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index c13b014..1e34e3e 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -711,8 +711,8 @@ static int zynqmp_clock_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	eemi_ops = zynqmp_pm_get_eemi_ops();
-	if (!eemi_ops)
-		return -ENXIO;
+	if (IS_ERR(eemi_ops))
+		return PTR_ERR(eemi_ops);
 
 	ret = zynqmp_clk_setup(dev->of_node);
 
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 2771df6..a3aa76c 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -90,9 +90,6 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 	int ret;
 	struct zynqmp_pm_query_data qdata = {0};
 
-	if (!eemi_ops)
-		return -ENXIO;
-
 	switch (pm_id) {
 	case PM_GET_API_VERSION:
 		ret = eemi_ops->get_api_version(&pm_api_version);
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 98f9361..87a1d63 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -24,6 +24,8 @@
 #include <linux/firmware/xlnx-zynqmp.h>
 #include "zynqmp-debug.h"
 
+static const struct zynqmp_eemi_ops *eemi_ops_tbl;
+
 static const struct mfd_cell firmware_devs[] = {
 	{
 		.name = "zynqmp_power_controller",
@@ -649,7 +651,11 @@ static const struct zynqmp_eemi_ops eemi_ops = {
  */
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
-	return &eemi_ops;
+	if (eemi_ops_tbl)
+		return eemi_ops_tbl;
+	else
+		return ERR_PTR(-EPROBE_DEFER);
+
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
 
@@ -694,6 +700,9 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	pr_info("%s Trustzone version v%d.%d\n", __func__,
 		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
 
+	/* Assign eemi_ops_table */
+	eemi_ops_tbl = &eemi_ops;
+
 	zynqmp_pm_api_debugfs_init();
 
 	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 490c8fc..5893543 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -16,6 +16,8 @@ struct zynqmp_nvmem_data {
 	struct nvmem_device *nvmem;
 };
 
+static const struct zynqmp_eemi_ops *eemi_ops;
+
 static int zynqmp_nvmem_read(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
@@ -23,9 +25,7 @@ static int zynqmp_nvmem_read(void *context, unsigned int offset,
 	int idcode, version;
 	struct zynqmp_nvmem_data *priv = context;
 
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
-
-	if (!eemi_ops || !eemi_ops->get_chipid)
+	if (!eemi_ops->get_chipid)
 		return -ENXIO;
 
 	ret = eemi_ops->get_chipid(&idcode, &version);
@@ -61,6 +61,10 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (IS_ERR(eemi_ops))
+		return PTR_ERR(eemi_ops);
+
 	priv->dev = dev;
 	econfig.dev = dev;
 	econfig.reg_read = zynqmp_nvmem_read;
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 2ef1f13..99e75d9 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -79,11 +79,11 @@ static int zynqmp_reset_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
-
 	priv->eemi_ops = zynqmp_pm_get_eemi_ops();
-	if (!priv->eemi_ops)
-		return -ENXIO;
+	if (IS_ERR(priv->eemi_ops))
+		return PTR_ERR(priv->eemi_ops);
+
+	platform_set_drvdata(pdev, priv);
 
 	priv->rcdev.ops = &zynqmp_reset_ops;
 	priv->rcdev.owner = THIS_MODULE;
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
index 354d256..600f57c 100644
--- a/drivers/soc/xilinx/zynqmp_pm_domains.c
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -23,6 +23,8 @@
 /* Flag stating if PM nodes mapped to the PM domain has been requested */
 #define ZYNQMP_PM_DOMAIN_REQUESTED	BIT(0)
 
+static const struct zynqmp_eemi_ops *eemi_ops;
+
 /**
  * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
  * @gpd:		Generic power domain
@@ -71,9 +73,8 @@ static int zynqmp_gpd_power_on(struct generic_pm_domain *domain)
 {
 	int ret;
 	struct zynqmp_pm_domain *pd;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	if (!eemi_ops || !eemi_ops->set_requirement)
+	if (!eemi_ops->set_requirement)
 		return -ENXIO;
 
 	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
@@ -107,9 +108,8 @@ static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
 	struct zynqmp_pm_domain *pd;
 	u32 capabilities = 0;
 	bool may_wakeup;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	if (!eemi_ops || !eemi_ops->set_requirement)
+	if (!eemi_ops->set_requirement)
 		return -ENXIO;
 
 	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
@@ -160,9 +160,8 @@ static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
 {
 	int ret;
 	struct zynqmp_pm_domain *pd;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	if (!eemi_ops || !eemi_ops->request_node)
+	if (!eemi_ops->request_node)
 		return -ENXIO;
 
 	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
@@ -197,9 +196,8 @@ static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
 {
 	int ret;
 	struct zynqmp_pm_domain *pd;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	if (!eemi_ops || !eemi_ops->release_node)
+	if (!eemi_ops->release_node)
 		return;
 
 	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
@@ -266,6 +264,10 @@ static int zynqmp_gpd_probe(struct platform_device *pdev)
 	struct zynqmp_pm_domain *pd;
 	struct device *dev = &pdev->dev;
 
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (IS_ERR(eemi_ops))
+		return PTR_ERR(eemi_ops);
+
 	pd = devm_kcalloc(dev, ZYNQMP_NUM_DOMAINS, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
 		return -ENOMEM;
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 771cb59..1b9d144 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -31,6 +31,7 @@ static const char *const suspend_modes[] = {
 };
 
 static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
+static const struct zynqmp_eemi_ops *eemi_ops;
 
 enum pm_api_cb_id {
 	PM_INIT_SUSPEND_CB = 30,
@@ -92,9 +93,8 @@ static ssize_t suspend_mode_store(struct device *dev,
 				  const char *buf, size_t count)
 {
 	int md, ret = -EINVAL;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	if (!eemi_ops || !eemi_ops->set_suspend_mode)
+	if (!eemi_ops->set_suspend_mode)
 		return ret;
 
 	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
@@ -120,9 +120,11 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	int ret, irq;
 	u32 pm_api_version;
 
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (IS_ERR(eemi_ops))
+		return PTR_ERR(eemi_ops);
 
-	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
+	if (!eemi_ops->get_api_version || !eemi_ops->init_finalize)
 		return -ENXIO;
 
 	eemi_ops->init_finalize();
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 9f83e1b..d07b6f9 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -138,6 +138,7 @@
 
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
+static const struct zynqmp_eemi_ops *eemi_ops;
 
 /**
  * struct zynqmp_qspi - Defines qspi driver instance
@@ -1021,6 +1022,10 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (IS_ERR(eemi_ops))
+		return PTR_ERR(eemi_ops);
+
 	master = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!master)
 		return -ENOMEM;
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 642dab1..3533ee5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -293,7 +293,7 @@ const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 #endif
 
-- 
2.7.4

