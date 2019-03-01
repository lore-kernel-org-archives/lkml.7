Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F32C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47F62087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="q3u1mHxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbfCAKvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:51:05 -0500
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:6242
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728157AbfCAKvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3771yKmTn/fojXvd6sj3s5mDZN3mqlpZhmAsMHZLYEY=;
 b=q3u1mHxQpBraHZ43J6l+kHdzeMXYxT3AbdJZ4XPMZI5wNiqkEUtbHWgGWh1qsf2Vq6V+r1T3Rf/91tZC3z8PLr0XyNoz+ANhAyDooTGZno+p6X6hskVAyJWeaGELVcf/0bpnCeyqmn2rjbceS+R1nJnJZq2NCESYWiGG8amICGs=
Received: from MWHPR02CA0017.namprd02.prod.outlook.com (2603:10b6:300:4b::27)
 by BYAPR02MB4918.namprd02.prod.outlook.com (2603:10b6:a03:47::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.16; Fri, 1 Mar
 2019 10:50:56 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR02CA0017.outlook.office365.com
 (2603:10b6:300:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Fri, 1 Mar 2019 10:50:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 10:50:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43534 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkk-0003DH-HC; Fri, 01 Mar 2019 02:50:54 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkf-0007u9-Cy; Fri, 01 Mar 2019 02:50:49 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x21AofAm023273;
        Fri, 1 Mar 2019 02:50:42 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkX-0007d5-9c; Fri, 01 Mar 2019 02:50:41 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v3 1/4] net: macb: Check MDIO state before read/write and use timeouts
Date:   Fri, 1 Mar 2019 16:20:32 +0530
Message-ID: <1551437435-3462-2-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
References: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(189003)(199004)(478600001)(9786002)(81156014)(8676002)(305945005)(36756003)(51416003)(7696005)(2906002)(50466002)(81166006)(5660300002)(8936002)(48376002)(47776003)(76176011)(107886003)(50226002)(4326008)(36386004)(356004)(6666004)(446003)(186003)(476003)(106466001)(2201001)(486006)(336012)(54906003)(426003)(77096007)(316002)(110136005)(16586007)(106002)(63266004)(44832011)(2616005)(11346002)(126002)(26005)(107986001)(42866002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4918;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da723e71-7eb2-4170-3259-08d69e33c7fb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR02MB4918;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4918:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4918;20:lSYmHlfAiye4r3dvrAvSrMoba9MyuW568klkWeVQInCuFseeJNsEVPN83YBIlJiCwUhX41GOG9lSqRTQJH/OanFj9YtH+b+rr/PopJVvbDWq/5l8eo7Plu/Kavz5NwswEb5rKW5MzMIdYVQ+jtonuld/6+yImkOVfcM3OJbXSpFVP0r0+6r81tFPl5rgSDIczzJxhG9tGL0x3T36503TX5JW+5QxW5G67PyZoj7ae/RGAmfPUcK0kXPg9sIGX/A9BenOMbZmOig05Egefx+mLXmkuF+oVUpl6EDsh8dOQiqG3XlPwZGoNXGRhM/UCstd1sZ1fDuRzG6ox0tYLKIClus3CPwUFAX6YCXTzyXHpLSzq6jVjqN0lxCUAutfHP0pYT3Tcty0k2u+khgXb6cvwVkEu5lOxnOcNHFpOIVzlkfHW2UYE37v2fBOBATCxl/SSeusmUWbU4lKXbLjviBO26f1un1X5bPmriXtpHSbBmc+LDkhDNa9UR8befcvsHkf
X-Microsoft-Antispam-PRVS: <BYAPR02MB4918C8C4038C02A93D865483C9760@BYAPR02MB4918.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4918;23:DSyha7Ds8SEh6Eh8TY82imT/moKYsl1V1fnDi/A7U?=
 =?us-ascii?Q?VmHRropxFiNxqguP2RaX89QPInO0bzZNUx6AIg7ZPs39AQJzpe3L0zUnyGsy?=
 =?us-ascii?Q?6+9qvjPQs4MksEIYVEQnZSuYV98k/xqmHfhUhOCxA9SGzKbU/6QMTZbjoyqW?=
 =?us-ascii?Q?J01EXYSgnNoeqLzrhnVIli2CavOrxUr/qxQwX3ejZ41GaG9enJq+6WdextS6?=
 =?us-ascii?Q?Z9BPhtQET9b1x3UZAxVKI/+rMzLmqsKfEf1YwqklP0NQKfRdN2ogub9tHct/?=
 =?us-ascii?Q?sZOgOfFF0bZhqTsTHx8EOwU1degxvrnbFV18B44bmupy7IgSS+yr5iRy7MyX?=
 =?us-ascii?Q?WWEwKREUSPH+2VFmS2LI0/xKV0BOM0uV8uD1VqA6ti310FE3N1n6nXEIiOrD?=
 =?us-ascii?Q?5MPzbRM5NyxnO5ckqjKu6FfcFSFAnhJLpXaGwYrtT3EB5Xqz5zuf/HJtmrlA?=
 =?us-ascii?Q?cdzY2VVrIYS10Cqp2VVv2sUW6KjRnrRSO+ABQAv2yGs4ul2cI/NBZAvCxNJ6?=
 =?us-ascii?Q?AWWSKAt3x1yvDYKcS4GaDd9PQy+sSIzgWz5rrqqpOB63bBC9KxxIY72u8okt?=
 =?us-ascii?Q?f+p+2S/Gu2guWu1hQi549J/SalyH7J1fauYjdhAdnmhnTOVHzhb2IUCLMObd?=
 =?us-ascii?Q?Ve265x2OaU6OpmF4YJRrB4p3S+0CfOIVQ14c40me2q1QkPckgOE4j7wVj/x4?=
 =?us-ascii?Q?i27vBCyzefthMRRVPYkPfnhDsIiPGycu2naCMx6rih2567/uZyNQYxr2Bbyg?=
 =?us-ascii?Q?e0MdGxmu2ukObn2WxC4Gd7EyDWfU01x9z/HKaVN2TCtzRWVl/8ZDravurVUu?=
 =?us-ascii?Q?ZRhWoljOpMwzKV/+WnnBF/lfzRxk3VNH4KWDZ3BQUFVRUCrscZxCCZSQtKdq?=
 =?us-ascii?Q?4lgB+OGsJNUCkt4MrBPlyrEjqCvzTEwuQKhE8xdcxBYZOPkPH7gDi2o1gd5+?=
 =?us-ascii?Q?t+mLJ9xbxu8h6WB2vanEzkJvDBQndMpDUpUMViS7lSHhUnyQHIjn1DTPu6e8?=
 =?us-ascii?Q?k1HJAZUJzMEtXI2d9csVFKPQy3KbE0RXyvG223Hp1ASORXvYLul4nHZDOaQc?=
 =?us-ascii?Q?fb9RrKniLzem24vsqlVC0mn+x0jWvs6qu1m4Vv0N7kus6MDW35moAyOX1Twe?=
 =?us-ascii?Q?OYkG6857BGAWNeYYnh2UKNreL33ldf3xmlENFoIyI6v/9ttUs1UsAzdy1iMv?=
 =?us-ascii?Q?JmDWvWaSzbPEgI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fI7hZRDKVKK5+FGhJ9YBT4oXu3FKVm2d12eWn9OAgKF+BLrdcNgYhBV0wA6RiLvW5UyXLbZJujoRkWCw+FELrar6xGltJ1YrAsIOSVXkYnz2TuDgLIMtpxHG6qzFane6iLP3yFGdwSUCEcFpTCL16jbcpov+8VKBdnM9lT+tnc0TiAWgbrUibo3ihqNhNhYvi1X3/GbAvHtbxMs//XGbglYI9DXpElVZTp2RGheDD+BKCsaD0Hbea8ouJOgDk/QcfgHd9tyoVbS9ZZ7/2XpgQzrR3piE121CaXOiZYfnPFeoZcfSmZWJlm6sSAcKoPYFm6P+bn8xjR79BqM2L5gfiawMhWhpKtpT7wMJeO+LHt9zJ7cQskxBKMQzW7vuPAYyAQM2dhDrVkKhsc72lin/dkBCzpicA33/azzBcwXIOL8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 10:50:55.2748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da723e71-7eb2-4170-3259-08d69e33c7fb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the while loop in MDIO read/write functions with a timeout.
In addition, add a check for MDIO bus busy before initiating a new
operation as well to make sure there is no ongoing MDIO operation.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v3 changes:
Used MACB_BIT for IDLE field

v2 changes:
Use readx_poll_timeout

Changes form RFC:
Cleaned up timeout implementation and moved it to a helper.

 drivers/net/ethernet/cadence/macb.h      |  2 ++
 drivers/net/ethernet/cadence/macb_main.c | 33 ++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 9bbaad9..f51040f 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -715,6 +715,8 @@
 		__v; \
 	})
 
+#define MACB_READ_NSR(bp)	macb_readl(bp, NSR)
+
 /* struct macb_dma_desc - Hardware DMA descriptor
  * @addr: DMA address of data buffer
  * @ctrl: Control and status bits
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f2915f2..a19ed2b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -36,6 +36,7 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
+#include <linux/iopoll.h>
 #include "macb.h"
 
 #define MACB_RX_BUFFER_SIZE	128
@@ -79,6 +80,8 @@
  */
 #define MACB_HALT_TIMEOUT	1230
 
+#define MACB_MDIO_TIMEOUT	1000000 /* in usecs */
+
 /* DMA buffer descriptor might be different size
  * depends on hardware configuration:
  *
@@ -318,10 +321,23 @@ static void macb_get_hwaddr(struct macb *bp)
 	eth_hw_addr_random(bp->dev);
 }
 
+static int macb_mdio_wait_for_idle(struct macb *bp)
+{
+	u32 val;
+
+	return readx_poll_timeout(MACB_READ_NSR, bp, val, val & MACB_BIT(IDLE),
+				  1, MACB_MDIO_TIMEOUT);
+}
+
 static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct macb *bp = bus->priv;
 	int value;
+	int err;
+
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_READ)
@@ -329,9 +345,9 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 			      | MACB_BF(REGA, regnum)
 			      | MACB_BF(CODE, MACB_MAN_CODE)));
 
-	/* wait for end of transfer */
-	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
-		cpu_relax();
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
@@ -342,6 +358,11 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			   u16 value)
 {
 	struct macb *bp = bus->priv;
+	int err;
+
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_WRITE)
@@ -350,9 +371,9 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			      | MACB_BF(CODE, MACB_MAN_CODE)
 			      | MACB_BF(DATA, value)));
 
-	/* wait for end of transfer */
-	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
-		cpu_relax();
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
-- 
2.7.4

