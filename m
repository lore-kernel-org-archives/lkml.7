Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E50C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9BC2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0mx/4C53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfCAKvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:51:10 -0500
Received: from mail-eopbgr680081.outbound.protection.outlook.com ([40.107.68.81]:10494
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728157AbfCAKvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nck7Ww3ukqeZPnp8RH62yn7NpXyw/3mqBqByrkmjwt0=;
 b=0mx/4C53OVgttQh0uIqZxtfF6F+98DjNsI27/WaZy2xGOnh6brbC9TuXmukVrCA48V/TEc3SIULJLWG7CNGH4zr/3Pvzu3rERs7xIVU9UVhng4KTmdlDgDl+3szkvP2D6KuC0gSe5hXtPrWnGRQmOxwx/uL58e32Ju26WzWePvM=
Received: from BL0PR02CA0066.namprd02.prod.outlook.com (2603:10b6:207:3d::43)
 by BN6PR02MB2754.namprd02.prod.outlook.com (2603:10b6:404:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.21; Fri, 1 Mar
 2019 10:51:05 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BL0PR02CA0066.outlook.office365.com
 (2603:10b6:207:3d::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.16 via Frontend
 Transport; Fri, 1 Mar 2019 10:51:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 10:51:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44348 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfku-0003DY-KI; Fri, 01 Mar 2019 02:51:04 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkp-00083j-GQ; Fri, 01 Mar 2019 02:50:59 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x21Aood2023727;
        Fri, 1 Mar 2019 02:50:50 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gzfkg-0007d5-2U; Fri, 01 Mar 2019 02:50:50 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v3 4/4] net: macb: Add support for suspend/resume with full power down
Date:   Fri, 1 Mar 2019 16:20:35 +0530
Message-ID: <1551437435-3462-5-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
References: <1551437435-3462-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(189003)(199004)(9786002)(47776003)(4326008)(2906002)(356004)(6666004)(76176011)(14444005)(336012)(77096007)(26005)(36386004)(316002)(16586007)(63266004)(106002)(5024004)(110136005)(186003)(54906003)(106466001)(15650500001)(426003)(36756003)(51416003)(50226002)(476003)(7696005)(11346002)(2616005)(486006)(446003)(8936002)(305945005)(478600001)(126002)(81166006)(8676002)(81156014)(2201001)(50466002)(107886003)(5660300002)(48376002)(44832011)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2754;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f9eb24-3b81-43cb-3206-08d69e33cded
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR02MB2754;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2754:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2754;20:iROCbp9HrY6TdKr8tA2ZYNrE+U8P9wEz/PqDWiIA30kGiRt4Y2z6alwert8oDGwxc8M80/s4L49FfQS997blW0iHoPzPD2inS7SiTGkPTCHtetHsYsdL573U8FJTRsOopMBztnqEnSucdL8PXUITUTLfZjxSFfz4NtUf6tam4auDrp2y/Jh+Dt/YJLRW8LLnk/r1IzFziEG562iXSEWl9qTSxeNw0XW5dHO+VOptK8Dzmpm6G0SWpyU62cDuwQ8a4dux25kVPx+o2V2tCTWEU2jmYnKc5c7S8cjpALe97G/wtgHbe9k7PazXypGVcs/kd0N0b5YvZvXFYLJc/tmPEq+8MhwdT1rROiGFeCUhsqjz6Iojmm1/MhdlkeNkFZSIkhbws8APTlwJpaGAy4HaD5IXD+Pl8KC8thmYsIiD6gISKoJ9h5jTgtcieZuXb+LhIoJGdOQ394GJbIQc2KcMzUdXUeKO4xd/NNt1+byl+vx92KJY7DWjmsMdqKdebl8A
X-Microsoft-Antispam-PRVS: <BN6PR02MB2754056D5AB1C8766B659C06C9760@BN6PR02MB2754.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2754;23:PQh6gXwn9MuNmMkP1BGKovpzCKKZ4L4LNqvULm0yT?=
 =?us-ascii?Q?QyyM4gH0M32RU0N4809uoMXzk0qBqoc5GK0UOrzKMhHOx2Q6OIyvBM4Z4/8V?=
 =?us-ascii?Q?R+7SOTkNiXBIDDe40yEuLIhXuLzC5iiq/rJCE4qxZX6zTNfRp55eAXf7/Fwb?=
 =?us-ascii?Q?kanpWT37p73uzLdHu3hQTnVWfiuoK8+NpD2aJsyl17RRmBbc1BDirYUqCpVf?=
 =?us-ascii?Q?TPSumoi+g9t3NXKFuKMxvjyK4BmPw59M7NI+1/UFwFRQE1yBOxOrMxmxq4Sa?=
 =?us-ascii?Q?nL8NI+xzGcHWIh56/n2GrWwY1lW45gITgiPCfZGu3xsWA34r0o9KiaoD4sz0?=
 =?us-ascii?Q?4wSs8dlJDExouDn2LS9sRe0V30cvaFm0tjc+RUr0dy2Q30uUjJ1RsJ2GZ2Vd?=
 =?us-ascii?Q?WID54xIj/pLM3EfrLHhSi2ykBTiBp2eNJlDhIxph7HthNqSzuTj2+PXBgzTK?=
 =?us-ascii?Q?eDWtFvaJ/SKs8ygHAd5PG6QPQEEaBkIdZokzfLmFkKK1khmYV0azSb6aBfqW?=
 =?us-ascii?Q?ozfe2xbJTsjpjfYpUxrmxdeOK46dotW5smWWZYFzh+Vjk6W+Db3VbdVG3ds9?=
 =?us-ascii?Q?LsxeomGkFFf6WQ4ehgde+0islhTIaOtqk/Wzo9krQyPM0Ipr0Mf92sxXiwam?=
 =?us-ascii?Q?U8SvgQ2AGSXrV7wRYlrB7yUep8lzkAv6/B+wyf12IvDGq8D3KNSu+LhriguX?=
 =?us-ascii?Q?3rwHSwkOTwZaYgRONH03a81BohhgT5IdjZYYBO2ApsszRSj16AuFAr6OIJPY?=
 =?us-ascii?Q?gfTqjdo30FruAKuiWvehBoTGUwIwZHGHn6wb06tCvdWyILnCsltVC6CAzVEU?=
 =?us-ascii?Q?iMNVWY7F6iHBlQIYZnaWp1mYMTo7DzuAEHPpNHj+v/4mexQZ8ANjJwSa2UjR?=
 =?us-ascii?Q?wezS30MZth4Ob1x0U7voAyNSSE7hyr0M0iW3jvU261pzU+a39W7Yd/J/BoId?=
 =?us-ascii?Q?3lAT0s0iX1z/dJptOK4ptedI0/AITz8BxBa8Ffsl0jwK/CjE+Jl90p9G91kE?=
 =?us-ascii?Q?git+0EP5vfvBCMn5tZ8GeZRyvQF8lHoGq7JEG3aWtECw+v7lUKaJ4bnBPp8X?=
 =?us-ascii?Q?T6dA7bY54jYddQMfoFOtVjh5HtDreYhX5QMLNpLDXzFaplPHSDiRhi2WcWmH?=
 =?us-ascii?Q?W5lVPubv34+7zW8Dq41uUqfNChZrq9+Ym1+oSBlfze0F8QYZsVKQHIHuQkJh?=
 =?us-ascii?Q?eAr62z2vXL5pMlg2Rt2393RYZxGZNYdOILJD8E8x/Vy7dBqVndDJ4CFrg=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wwDYn5av6kNSKKL66cUf+eniXuGdGXVFivifCV5pl/Z2CgFE2fi9K/O51bVKlZEBwyZkMLWMVzY3pTQRVZcwJLx+Q4ri/VYDA5HbH4lufiDvfc3hVkhKiN8qskCxJFVlGlgi3ks7w68v/VKMlPCqMIEccoC8Puzy+3TyK3cqty38Yp3jV9rsen482M7jFodZMwbzpztdg9JrJsqDseHb7Y9UPkoVsXoZQ69TDJd4WY5TcbRxTJatwLhzcITS0IiYvjfteq/18p7rqHQcZ+C40qfpar0SMV9raatvJu1tAlYlT0vy8RuWbNFIXpAr63K7Bd1jbWV0gdAetGDEs+u8h813i7W/GVLhWWXpk89qLXMwSJ4szsR2TgNMX1TMJkQoRIDA8cciJYQEwqgVmsWco1q8ZawMf9Ov2eb+txyAsHo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 10:51:05.2506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f9eb24-3b81-43cb-3206-08d69e33cded
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When macb device is suspended and system is powered down, the clocks
are removed and hence macb should be closed gracefully and restored
upon resume. This patch does the same by switching off the net device,
suspending phy and performing necessary cleanup of interrupts and BDs.
Upon resume, all these are reinitialized again.

Reset of macb device is done only when GEM is not a wake device.
Even when gem is a wake device, tx queues can be stopped and ptp device
can be closed (tsu clock will be disabled in pm_runtime_suspend) as
wake event detection has no dependency on this.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
v3:
Fix >80 char lines

v2 changes:
Fixed parameter passed to phy calls.

 drivers/net/ethernet/cadence/macb_main.c | 40 ++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5173c02..ad099fd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4283,16 +4283,34 @@ static int __maybe_unused macb_suspend(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = bp->queues;
+	unsigned long flags;
+	unsigned int q;
+
+	if (!netif_running(netdev))
+		return 0;
 
-	netif_carrier_off(netdev);
-	netif_device_detach(netdev);
 
 	if (bp->wol & MACB_WOL_ENABLED) {
 		macb_writel(bp, IER, MACB_BIT(WOL));
 		macb_writel(bp, WOL, MACB_BIT(MAG));
 		enable_irq_wake(bp->queues[0].irq);
+		netif_device_detach(netdev);
+	} else {
+		netif_device_detach(netdev);
+		for (q = 0, queue = bp->queues; q < bp->num_queues;
+		     ++q, ++queue)
+			napi_disable(&queue->napi);
+		phy_stop(netdev->phydev);
+		phy_suspend(netdev->phydev);
+		spin_lock_irqsave(&bp->lock, flags);
+		macb_reset_hw(bp);
+		spin_unlock_irqrestore(&bp->lock, flags);
 	}
 
+	netif_carrier_off(netdev);
+	if (bp->ptp_info)
+		bp->ptp_info->ptp_remove(netdev);
 	pm_runtime_force_suspend(dev);
 
 	return 0;
@@ -4302,6 +4320,11 @@ static int __maybe_unused macb_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = bp->queues;
+	unsigned int q;
+
+	if (!netif_running(netdev))
+		return 0;
 
 	pm_runtime_force_resume(dev);
 
@@ -4309,9 +4332,22 @@ static int __maybe_unused macb_resume(struct device *dev)
 		macb_writel(bp, IDR, MACB_BIT(WOL));
 		macb_writel(bp, WOL, 0);
 		disable_irq_wake(bp->queues[0].irq);
+	} else {
+		macb_writel(bp, NCR, MACB_BIT(MPE));
+		for (q = 0, queue = bp->queues; q < bp->num_queues;
+		     ++q, ++queue)
+			napi_enable(&queue->napi);
+		phy_resume(netdev->phydev);
+		phy_init_hw(netdev->phydev);
+		phy_start(netdev->phydev);
 	}
 
+	bp->macbgem_ops.mog_init_rings(bp);
+	macb_init_hw(bp);
+	macb_set_rx_mode(netdev);
 	netif_device_attach(netdev);
+	if (bp->ptp_info)
+		bp->ptp_info->ptp_init(netdev);
 
 	return 0;
 }
-- 
2.7.4

