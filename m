Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54342C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1324A2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="x139zFM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfCAKvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:51:03 -0500
Received: from mail-eopbgr820057.outbound.protection.outlook.com ([40.107.82.57]:56746
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfCAKvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=308Yx3mYdtafFwp4J1XXCfFeC8Is0cilmW3AIrde4wI=;
 b=x139zFM8N4TbNK1ZRa3zb8q7YPxeqV2dsi7IWTnvszd7Kn7XhM9ZyCGMEwCucUUa1vVL3cp+mriDXlMz90yTG2Wj3QAwuef/g/qt+Vh56gMPa0LV04AZ6uDZ7PEyv+0TrOVtNiHxzngDBoGGaKUViBAwktzUvHoJit8LxNtpoX0=
Received: from BN7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:20::33)
 by BN6PR02MB2755.namprd02.prod.outlook.com (2603:10b6:404:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.18; Fri, 1 Mar
 2019 10:50:55 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN7PR02CA0020.outlook.office365.com
 (2603:10b6:408:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.18 via Frontend
 Transport; Fri, 1 Mar 2019 10:50:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 10:50:54 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkk-0006qs-8L; Fri, 01 Mar 2019 02:50:54 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkf-0007u9-41; Fri, 01 Mar 2019 02:50:49 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x21AoiwS023385;
        Fri, 1 Mar 2019 02:50:45 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfka-0007d5-8k; Fri, 01 Mar 2019 02:50:44 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v3 2/4] net: macb: Support clock management for tsu_clk
Date:   Fri, 1 Mar 2019 16:20:33 +0530
Message-ID: <1551437435-3462-3-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
References: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(478600001)(5024004)(76176011)(7696005)(36756003)(26005)(6666004)(51416003)(81156014)(356004)(47776003)(77096007)(14444005)(54906003)(305945005)(81166006)(4326008)(16586007)(107886003)(110136005)(106002)(8676002)(316002)(36386004)(8936002)(2616005)(476003)(336012)(48376002)(50226002)(426003)(11346002)(5660300002)(2201001)(50466002)(186003)(44832011)(106466001)(2906002)(126002)(63266004)(9786002)(446003)(486006)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2755;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf882351-3dbe-44b3-d961-08d69e33c7bf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR02MB2755;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2755:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2755;20:vc8LNZHK7x/gKyo13bpY761qd11npXnWLu1dvDyKAxyRXItSg3+IKKZ+W1JfQbdR7uts1v1UsstzgDbuwTiDt7/nxFVAzUxUPTah0pa1EMIyLDKXBuFQP8wJTWbTW0zXqi/8gNOg3g4PlzrKT/2tiqkBYWNTg0mNVcQnJ2qwHDne4+8nxQ3CttD7Yi4HKJQ5cw9TlyirRhL9GzajCBrnU2qXwKi1ME0d+z5QRlJd1lbs34GJ1LhHK/joK4/XYOCyLs7L71oxguYXbxHjxkA7goAXW4o1TCyfszsh6N4DF73oNJw0Aw1JSE1U/ocbXjoyn58GNHskxe8Er8xf9m2CmRRUJ46iO/+e9her4QJNvD2wpb8E4t+4hVvmGpWeA0Fh3LYaEn0OLO/O0Ddfz6527QXJxDAi2xZeRdy/X8a5A/O1W7qQRsmvYwQ68Zs4xuaO1hxPFhJV9xxct1mRW/rGBY3LEABy7GGMl97+BjzHju1Ox1TGKZKOWk9FKKg2f3Zi
X-Microsoft-Antispam-PRVS: <BN6PR02MB27550932B4476B104E30B874C9760@BN6PR02MB2755.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2755;23:klPXCs3wh0saUfBj+qlBGox3VqK5ROz+Ygj0AIAnP?=
 =?us-ascii?Q?B5UKKpjCQ+v/ewZWkDzt4878m4jg53t/Q4tY3lIA1VrQbDHFYR5sLSsQj/6x?=
 =?us-ascii?Q?FS82QHrg54aA9oFfo6EyhLUonQTl9M+o73ZNGAl8ZfaATwT5nWBsbWWhu/TS?=
 =?us-ascii?Q?4yRgsS/uVQARfkpMI4j2nTq6PxwrerZOR/DlU0AhofS2XDQ+YGkJ6EZ0G2SD?=
 =?us-ascii?Q?puAJ7v0LPk6xYHtlSzST2QgxI+lg9m9mmFKxKNh5YtPXPMF0lxKR1h9pgaZv?=
 =?us-ascii?Q?h4FvNqeQnc7mIpd4IJnZs9Uc/ZYEoUSNGXw4SApivjyd49DuELP5DYH8SFSt?=
 =?us-ascii?Q?FaJttUcgi2U5mPqxKE7p+YlOeJIYZiLkJVxoJSUBS9VIGWKIPukd/xcMdE91?=
 =?us-ascii?Q?7NEpF1cOy4YPMbPC++jUq3ltkOODVB9yFl9Y98UUBa0NXmx1VEs+4xqo5GLo?=
 =?us-ascii?Q?pTCAJcD2eyEJGwB886KHHFDS4h5z1d0gIiB/IGPLaXe3UHyAP+Egy3xKkRcm?=
 =?us-ascii?Q?EGhNqGb7JEBBVJyeLcMNP3tsr4UEmlHsWjEftH7lxIXw7rrlfZ5Byduw8R02?=
 =?us-ascii?Q?ER2rQV67TCkz8sCCsUdCQSHbfsf07YIEPih2FnLMSRWeCMVpuxVysZdOag/E?=
 =?us-ascii?Q?LvsjuYC5Cr6sj2tKwPkrQ3iY21P9qr8RCOatgDUj+6BEpAWToHbEI9N6XB58?=
 =?us-ascii?Q?4UOBBosJR6XYuU/HODkkmFM04DSXaNhPDr77P3m0SCs652AeTtvESZjCUGcz?=
 =?us-ascii?Q?xOWbAligciYdA3Z/IS+6kyplmFLHRYwfl5VST/T+oFxlLmddkN/fiBUUUfHm?=
 =?us-ascii?Q?03x1JUEtT71F2vdv/8b7G8ew9jAH0jrORJ3Iym8mpJ4sKgl8A6oASG6vUpvN?=
 =?us-ascii?Q?5qoIEARe3WE0sJdhuSQNBvUe6dP4vHVBZfmAwmjlVoIe3rUwTvG4kNTLgjKj?=
 =?us-ascii?Q?f6YZmDeY5x5NHJESo/SwLXdWcuWcvgZGNqxMRo0I3fpgDkAdod869FRp6F3O?=
 =?us-ascii?Q?iMZqv9NWcdr1q/0a9SabdG6rWFf8Vit/B68MEU3Oyl4lMOPdN5vMehPgErv7?=
 =?us-ascii?Q?grKLwf9rRYbZwDWEyArM2xE+B9jP54sfKQAhcHeqUhRcZOOb/I4DnD85YRt6?=
 =?us-ascii?Q?KbMYZXcQsZ68caoXE14VmViM2i4Lxmo7yEOun90UeoBullFDle02Q=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VEOhljb5QKB6T48R4D0pt5QtC6/2PaYwmTjQnYSwJdvX+ov3oa5Mkft/YmJzOyc0S0B7rsl5idu+FMAuNfF8OUaRn/h0NMjQyapWtABpbT2Ews9Dyk4oncegB6h6n517tT7yALbgfJXAhsfcEiMZzv9Fl0E/1gp1bFbUBNfAkWkrAv4AbSAns1eCwq6wc6kifjpeHsnnIEeD2nGZk/qUvi+Gkd33dhmPhBD8q4L2n3hCG7LyApneqZXikJM4eOSBI+OZVHc6sColVWcZKzsJST39eg9ebpiw8zAeG9oY+S6LDnM+5Q3BRR1XPJzR1ArH505CygLF7rNKRNhx7lL6Fu3i07WDMdKlNb7QvZt3ffKx8V/I6KodIL7ih03waUGMDM5c5ynfms1fzKnwRjQSyyXqYz8b4fUTiQNxVOV6rwY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 10:50:54.8831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf882351-3dbe-44b3-d961-08d69e33c7bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TSU clock needs to be enabled/disabled as per support in devicetree
and it should also be controlled during suspend/resume (WOL has no
dependency on this clock).

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
v3 and v2:
No changes

 drivers/net/ethernet/cadence/macb.h      |  3 ++-
 drivers/net/ethernet/cadence/macb_main.c | 30 +++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index f51040f..acc66a7 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1085,7 +1085,7 @@ struct macb_config {
 	unsigned int		dma_burst_length;
 	int	(*clk_init)(struct platform_device *pdev, struct clk **pclk,
 			    struct clk **hclk, struct clk **tx_clk,
-			    struct clk **rx_clk);
+			    struct clk **rx_clk, struct clk **tsu_clk);
 	int	(*init)(struct platform_device *pdev);
 	int	jumbo_max_len;
 };
@@ -1165,6 +1165,7 @@ struct macb {
 	struct clk		*hclk;
 	struct clk		*tx_clk;
 	struct clk		*rx_clk;
+	struct clk		*tsu_clk;
 	struct net_device	*dev;
 	union {
 		struct macb_stats	macb;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a19ed2b..be10ee4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3325,7 +3325,7 @@ static void macb_probe_queues(void __iomem *mem,
 
 static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 			 struct clk **hclk, struct clk **tx_clk,
-			 struct clk **rx_clk)
+			 struct clk **rx_clk, struct clk **tsu_clk)
 {
 	struct macb_platform_data *pdata;
 	int err;
@@ -3359,6 +3359,10 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 	if (IS_ERR(*rx_clk))
 		*rx_clk = NULL;
 
+	*tsu_clk = devm_clk_get(&pdev->dev, "tsu_clk");
+	if (IS_ERR(*tsu_clk))
+		*tsu_clk = NULL;
+
 	err = clk_prepare_enable(*pclk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable pclk (%u)\n", err);
@@ -3383,8 +3387,17 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 		goto err_disable_txclk;
 	}
 
+	err = clk_prepare_enable(*tsu_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable tsu_clk (%u)\n", err);
+		goto err_disable_rxclk;
+	}
+
 	return 0;
 
+err_disable_rxclk:
+	clk_disable_unprepare(*rx_clk);
+
 err_disable_txclk:
 	clk_disable_unprepare(*tx_clk);
 
@@ -3835,13 +3848,14 @@ static const struct net_device_ops at91ether_netdev_ops = {
 
 static int at91ether_clk_init(struct platform_device *pdev, struct clk **pclk,
 			      struct clk **hclk, struct clk **tx_clk,
-			      struct clk **rx_clk)
+			      struct clk **rx_clk, struct clk **tsu_clk)
 {
 	int err;
 
 	*hclk = NULL;
 	*tx_clk = NULL;
 	*rx_clk = NULL;
+	*tsu_clk = NULL;
 
 	*pclk = devm_clk_get(&pdev->dev, "ether_clk");
 	if (IS_ERR(*pclk))
@@ -3992,11 +4006,12 @@ static int macb_probe(struct platform_device *pdev)
 {
 	const struct macb_config *macb_config = &default_gem_config;
 	int (*clk_init)(struct platform_device *, struct clk **,
-			struct clk **, struct clk **,  struct clk **)
-					      = macb_config->clk_init;
+			struct clk **, struct clk **,  struct clk **,
+			struct clk **) = macb_config->clk_init;
 	int (*init)(struct platform_device *) = macb_config->init;
 	struct device_node *np = pdev->dev.of_node;
 	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
+	struct clk *tsu_clk = NULL;
 	unsigned int queue_mask, num_queues;
 	struct macb_platform_data *pdata;
 	bool native_io;
@@ -4024,7 +4039,7 @@ static int macb_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk);
+	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
 	if (err)
 		return err;
 
@@ -4061,6 +4076,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->hclk = hclk;
 	bp->tx_clk = tx_clk;
 	bp->rx_clk = rx_clk;
+	bp->tsu_clk = tsu_clk;
 	if (macb_config)
 		bp->jumbo_max_len = macb_config->jumbo_max_len;
 
@@ -4180,6 +4196,7 @@ static int macb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(hclk);
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
+	clk_disable_unprepare(tsu_clk);
 
 	return err;
 }
@@ -4207,6 +4224,7 @@ static int macb_remove(struct platform_device *pdev)
 		clk_disable_unprepare(bp->hclk);
 		clk_disable_unprepare(bp->pclk);
 		clk_disable_unprepare(bp->rx_clk);
+		clk_disable_unprepare(bp->tsu_clk);
 		of_node_put(bp->phy_node);
 		free_netdev(dev);
 	}
@@ -4232,6 +4250,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		clk_disable_unprepare(bp->pclk);
 		clk_disable_unprepare(bp->rx_clk);
 	}
+	clk_disable_unprepare(bp->tsu_clk);
 
 	return 0;
 }
@@ -4251,6 +4270,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 		clk_prepare_enable(bp->tx_clk);
 		clk_prepare_enable(bp->rx_clk);
 	}
+	clk_prepare_enable(bp->tsu_clk);
 
 	netif_device_attach(netdev);
 
-- 
2.7.4

