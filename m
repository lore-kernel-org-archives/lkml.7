Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155DCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7812087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gmofZ0R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfCAKvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:51:16 -0500
Received: from mail-eopbgr790051.outbound.protection.outlook.com ([40.107.79.51]:44960
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732645AbfCAKvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDF02ar6tlPm4XoIAqy/nLw5z8qa1IdctgnVuRo3kEg=;
 b=gmofZ0R2X2Lm6VjFjjArN/ZlhMbAgyOZ/+tPkcGsB3Fw8jPPAriW2ut7z8KZHe12x1F1JzU2e4a18GG8gVTsZJW3necLfFt67er+MRvEMpFIlJw1lt0G5nDfx+W1+aiNoK04Elf8uV7Qa7FbGuM9eR/RnOIlL6yY2oenNfxVKBs=
Received: from BN6PR02CA0043.namprd02.prod.outlook.com (2603:10b6:404:5f::29)
 by SN6PR02MB4415.namprd02.prod.outlook.com (2603:10b6:805:a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.17; Fri, 1 Mar
 2019 10:51:06 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR02CA0043.outlook.office365.com
 (2603:10b6:404:5f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Fri, 1 Mar 2019 10:51:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 10:51:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfku-0006qy-Lr; Fri, 01 Mar 2019 02:51:04 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkp-00083j-Hw; Fri, 01 Mar 2019 02:50:59 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x21Aol1A023558;
        Fri, 1 Mar 2019 02:50:47 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkd-0007d5-5Q; Fri, 01 Mar 2019 02:50:47 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v3 3/4] net: macb: Add pm runtime support
Date:   Fri, 1 Mar 2019 16:20:34 +0530
Message-ID: <1551437435-3462-4-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
References: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(189003)(199004)(11346002)(16586007)(50466002)(446003)(8676002)(316002)(81166006)(426003)(50226002)(4326008)(305945005)(476003)(107886003)(110136005)(9786002)(47776003)(106002)(54906003)(81156014)(48376002)(2616005)(2906002)(63266004)(44832011)(126002)(186003)(5660300002)(8936002)(356004)(6666004)(2201001)(5024004)(36756003)(486006)(36386004)(51416003)(7696005)(77096007)(336012)(14444005)(106466001)(478600001)(26005)(76176011)(42866002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4415;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bee0cc8e-bfd5-4805-02ae-08d69e33cdf9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB4415;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4415:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4415;20:/ZAE1AweMKYhkQ542WUqwLCCVuvfZ7DY8GIjImLwX4tt4L/AQE70EAe5kiSrWBnYwvgLiPhodMxuYII74IqAmbgdd6OhZN+phr9DiJ/wf43L9gvgeYknE/BKyUo7kBVM+yMB4d8O0zg3q6BiSN8SYB+vIeZ7Tar4d7pi+/JJOzYwnuZNmwUWE6u2OqIZfHkj1bbSrXD2hjxEmT4HNJI1IEPvF+Vz6ijjZqXmpHdiJUMYe0WrOJw9paZ/h3MiiV9Spi2JwYzfT4c8nqgrXqsJTaj699GieiKekTm5epvYjVYCB7OX425s09YXt3ulQiDRTxKmQ15LMTiFvl0fOhshPxOWvN0Ts3VTzP0ga18LsMFWrcC/UC7MBt4xR/Q2vYxY75AMdo+z0Kd7f+teUFIqk4mehRwsWwEAlWhX9J4oFX9xZgAXkmzO3vxvlAp+bwiikO6bYAKZPMOlIQ08lWQHf8NxPz9vI3MfwEmBMOYwK57lpypPmNbAe11zkqByiIVL
X-Microsoft-Antispam-PRVS: <SN6PR02MB441585B300F2255976529142C9760@SN6PR02MB4415.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4415;23:6b6/XwGrC6AFQP5rbk+L1S+ezcollfoP45dMyPmcu?=
 =?us-ascii?Q?0g2hze2NlQhBxgqCGKU1m4WOBvi+u3XGlXK3MEolg/dlCuUw1CbTfxfSJIU6?=
 =?us-ascii?Q?ZUw1IhdYzLKR5rb2XtK99Vz9cYegsqzNkdoCHRV9Qlomxcics6Rd+9X645AI?=
 =?us-ascii?Q?EVlRAQvIFRNuMvKG/ZM8xOmXHY4Yd0VJefXHSSLjvjfxieSUSKuWrw4ZnpZO?=
 =?us-ascii?Q?KU6uvgEF9epd/aQbdWRY+lXd7PpfvWd7gRTlt3NQzGUiXSd6G9foOUjrN8Df?=
 =?us-ascii?Q?CCHrj4xR+1OJjQwrRAgX65kwTAZi2EP8kcnE8AQ7ttKDOHvt2gww2E02NM6x?=
 =?us-ascii?Q?XGzgLjl8czlN6yAhhWtss+aFQd22NCG5qggXjPrXqwd/UM78lcIUc25L3Ne8?=
 =?us-ascii?Q?xy+59vQGOIn3a8oLiR7LFogq37c/GEUfJPrR0AqqaHTn+8WqHMY32nEoxwTW?=
 =?us-ascii?Q?Ox3LR/KwthBL5IYbP+pfegY/dmNKQ0rPWRfngh3Kmefae0lGIU1sqsCjWEWo?=
 =?us-ascii?Q?lDgA4UbKI7qRsS4TWBXecc5S+QAnIVbEz5/b6xq2XGkSW5dp5MLP3etBPybg?=
 =?us-ascii?Q?fKtcKjwjZtfT3IJQg8zEuYppLQBXMulm1a1Os88UK8s7Cupoo48yFKIcCKJQ?=
 =?us-ascii?Q?4EGoe26vmLYRUlsVEmofDugRadXQjFT1So2c+T0MflD/V0CCqR8tKnEj+gic?=
 =?us-ascii?Q?K71gjyfmrveF9CTwIgMn2DTL1mziIkLdJ/fq437iljRmuLtIXfx7kEhB96+S?=
 =?us-ascii?Q?F0m/xIT9FOkuzJ7UUbcOAa3Nzc+Rs4ToAwdrEQ861ewXCgJVIOuEqTUYPlF0?=
 =?us-ascii?Q?p6q2ZOE9V0wY16n5EZRH68LFYZs1Il2ouboK/3hDIpql3KkiSb8LoerFRboA?=
 =?us-ascii?Q?OkKpkOKbXn0aO0IXfezdhbtdAIETnNJOWXiBG0/29+9a3Hr6iK62E8mAyqIS?=
 =?us-ascii?Q?BCSftLztKNoc9fP+LLXSvW/tD2bvl95RNUR327A2axNITEJYR1lnWRfer/B+?=
 =?us-ascii?Q?y3JduUZXefFwF59tZGxr5iqZBFuRcmcVPhI0P1Z+D8nCBXbUQVpKyjiac/AY?=
 =?us-ascii?Q?0lvGlo0EYT0PiyyP0nGltpWPJuAZBi0tbMr8H/Yd5xEY4QTDG6pfMB3+AIkm?=
 =?us-ascii?Q?kMxkqt4I2vP6xmodHOIi+iWcT/f4ldbSOnMK1ZJf/KVNeGM4hXb85F8GjqEY?=
 =?us-ascii?Q?H417ymbL9O3j3A=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: trBjWvxTdCk1xu6aa+3k9wBWs4vNqTH1Jw4GY5tRi7y/NT3TbbMy3Z6rehdNYFk0uuicsgPH7CzhZbSpw2dFRt7Xxe1Udy4cZ7I/T3ZJVOF0fZq2+6zqck8GeJA4SCrac23BFxhZLdmm57pmpCSrUnNgK1ror3GAp+q7t6jXzfPRsj8DqUYv9EZVCmWza2aBSZ7p4x07skMXzebbnFDlXRhHD7mbEG6fPHcINAWElLbDEXnm5klHVVq7gmF7ZKoNZTVN6069u2nVbWV04ulsgmN/yd0kwJZQoe8+zCQgwKdbA1AOlWoaDHQ4D40bZrd+MWw1wGn3+K8H2IMxZgV/Gz/G0BPoUybE/hQ3v542A+/CoXeacTUdY889xyxlKV44phbkCptDK5+/6DYBb8jlgVcUk0qaK3uPfyukJtR3SXo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 10:51:05.2850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee0cc8e-bfd5-4805-02ae-08d69e33cdf9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime pm functions and move clock handling there.
Add runtime PM calls to mdio functions to allow for active mdio bus.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
v3 changes:
Fix exit path using goto

v2 changes:
Allow for mdio bus to be active

Changes from RFC:
Updated pm get sync/put sync calls.
Removed unecessary clk up in mdio helpers.

 drivers/net/ethernet/cadence/macb_main.c | 148 +++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index be10ee4..5173c02 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -37,6 +37,7 @@
 #include <linux/udp.h>
 #include <linux/tcp.h>
 #include <linux/iopoll.h>
+#include <linux/pm_runtime.h>
 #include "macb.h"
 
 #define MACB_RX_BUFFER_SIZE	128
@@ -80,6 +81,8 @@
  */
 #define MACB_HALT_TIMEOUT	1230
 
+#define MACB_PM_TIMEOUT  100 /* ms */
+
 #define MACB_MDIO_TIMEOUT	1000000 /* in usecs */
 
 /* DMA buffer descriptor might be different size
@@ -332,12 +335,15 @@ static int macb_mdio_wait_for_idle(struct macb *bp)
 static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct macb *bp = bus->priv;
-	int value;
-	int err;
+	int status;
 
-	err = macb_mdio_wait_for_idle(bp);
-	if (err < 0)
-		return err;
+	status = pm_runtime_get_sync(&bp->pdev->dev);
+	if (status < 0)
+		goto mdio_pm_exit;
+
+	status = macb_mdio_wait_for_idle(bp);
+	if (status < 0)
+		goto mdio_read_exit;
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_READ)
@@ -345,24 +351,32 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 			      | MACB_BF(REGA, regnum)
 			      | MACB_BF(CODE, MACB_MAN_CODE)));
 
-	err = macb_mdio_wait_for_idle(bp);
-	if (err < 0)
-		return err;
+	status = macb_mdio_wait_for_idle(bp);
+	if (status < 0)
+		goto mdio_read_exit;
 
-	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
+	status = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
-	return value;
+mdio_read_exit:
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+mdio_pm_exit:
+	return status;
 }
 
 static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			   u16 value)
 {
 	struct macb *bp = bus->priv;
-	int err;
+	int status;
 
-	err = macb_mdio_wait_for_idle(bp);
-	if (err < 0)
-		return err;
+	status = pm_runtime_get_sync(&bp->pdev->dev);
+	if (status < 0)
+		goto mdio_pm_exit;
+
+	status = macb_mdio_wait_for_idle(bp);
+	if (status < 0)
+		goto mdio_write_exit;
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_WRITE)
@@ -371,11 +385,15 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			      | MACB_BF(CODE, MACB_MAN_CODE)
 			      | MACB_BF(DATA, value)));
 
-	err = macb_mdio_wait_for_idle(bp);
-	if (err < 0)
-		return err;
+	status = macb_mdio_wait_for_idle(bp);
+	if (status < 0)
+		goto mdio_write_exit;
 
-	return 0;
+mdio_write_exit:
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+mdio_pm_exit:
+	return status;
 }
 
 /**
@@ -2418,12 +2436,18 @@ static int macb_open(struct net_device *dev)
 
 	netdev_dbg(bp->dev, "open\n");
 
+	err = pm_runtime_get_sync(&bp->pdev->dev);
+	if (err < 0)
+		goto pm_exit;
+
 	/* carrier starts down */
 	netif_carrier_off(dev);
 
 	/* if the phy is not yet register, retry later*/
-	if (!dev->phydev)
-		return -EAGAIN;
+	if (!dev->phydev) {
+		err = -EAGAIN;
+		goto pm_exit;
+	}
 
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
@@ -2432,7 +2456,7 @@ static int macb_open(struct net_device *dev)
 	if (err) {
 		netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
-		return err;
+		goto pm_exit;
 	}
 
 	bp->macbgem_ops.mog_init_rings(bp);
@@ -2449,6 +2473,11 @@ static int macb_open(struct net_device *dev)
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_init(dev);
 
+pm_exit:
+	if (err) {
+		pm_runtime_put_sync(&bp->pdev->dev);
+		return err;
+	}
 	return 0;
 }
 
@@ -2477,6 +2506,8 @@ static int macb_close(struct net_device *dev)
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(dev);
 
+	pm_runtime_put(&bp->pdev->dev);
+
 	return 0;
 }
 
@@ -4043,6 +4074,11 @@ static int macb_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, MACB_PM_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	native_io = hw_is_native_io(mem);
 
 	macb_probe_queues(mem, native_io, &queue_mask, &num_queues);
@@ -4178,6 +4214,9 @@ static int macb_probe(struct platform_device *pdev)
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
 		    dev->base_addr, dev->irq, dev->dev_addr);
 
+	pm_runtime_mark_last_busy(&bp->pdev->dev);
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+
 	return 0;
 
 err_out_unregister_mdio:
@@ -4197,6 +4236,9 @@ static int macb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
 	clk_disable_unprepare(tsu_clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	return err;
 }
@@ -4220,11 +4262,16 @@ static int macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
-		clk_disable_unprepare(bp->tx_clk);
-		clk_disable_unprepare(bp->hclk);
-		clk_disable_unprepare(bp->pclk);
-		clk_disable_unprepare(bp->rx_clk);
-		clk_disable_unprepare(bp->tsu_clk);
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
+		if (!pm_runtime_suspended(&pdev->dev)) {
+			clk_disable_unprepare(bp->tx_clk);
+			clk_disable_unprepare(bp->hclk);
+			clk_disable_unprepare(bp->pclk);
+			clk_disable_unprepare(bp->rx_clk);
+			clk_disable_unprepare(bp->tsu_clk);
+			pm_runtime_set_suspended(&pdev->dev);
+		}
 		of_node_put(bp->phy_node);
 		free_netdev(dev);
 	}
@@ -4244,13 +4291,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
-	} else {
-		clk_disable_unprepare(bp->tx_clk);
-		clk_disable_unprepare(bp->hclk);
-		clk_disable_unprepare(bp->pclk);
-		clk_disable_unprepare(bp->rx_clk);
 	}
-	clk_disable_unprepare(bp->tsu_clk);
+
+	pm_runtime_force_suspend(dev);
 
 	return 0;
 }
@@ -4260,11 +4303,43 @@ static int __maybe_unused macb_resume(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 
+	pm_runtime_force_resume(dev);
+
 	if (bp->wol & MACB_WOL_ENABLED) {
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
-	} else {
+	}
+
+	netif_device_attach(netdev);
+
+	return 0;
+}
+
+static int __maybe_unused macb_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+
+	if (!(device_may_wakeup(&bp->dev->dev))) {
+		clk_disable_unprepare(bp->tx_clk);
+		clk_disable_unprepare(bp->hclk);
+		clk_disable_unprepare(bp->pclk);
+		clk_disable_unprepare(bp->rx_clk);
+	}
+	clk_disable_unprepare(bp->tsu_clk);
+
+	return 0;
+}
+
+static int __maybe_unused macb_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *netdev = platform_get_drvdata(pdev);
+	struct macb *bp = netdev_priv(netdev);
+
+	if (!(device_may_wakeup(&bp->dev->dev))) {
 		clk_prepare_enable(bp->pclk);
 		clk_prepare_enable(bp->hclk);
 		clk_prepare_enable(bp->tx_clk);
@@ -4272,12 +4347,13 @@ static int __maybe_unused macb_resume(struct device *dev)
 	}
 	clk_prepare_enable(bp->tsu_clk);
 
-	netif_device_attach(netdev);
-
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(macb_pm_ops, macb_suspend, macb_resume);
+static const struct dev_pm_ops macb_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(macb_suspend, macb_resume)
+	SET_RUNTIME_PM_OPS(macb_runtime_suspend, macb_runtime_resume, NULL)
+};
 
 static struct platform_driver macb_driver = {
 	.probe		= macb_probe,
-- 
2.7.4

