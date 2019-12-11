Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95BFC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6457520836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="eNE0D4Uu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="H3H3bhc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfLKNKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:13 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:14842 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729529AbfLKNJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:56 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD47Hb020442;
        Wed, 11 Dec 2019 05:09:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=l48AtdCfFxxM+p55i2S9fGifCjm4/On2x8xPd5DI3qE=;
 b=eNE0D4Uu8UCXG3ykXjGQIVZbfUy3zXr0gHyAIcR1B6GcpHE8l0dSDWnK8NY1wVDp8uSE
 2dk7mYvXB6pv8aiXxXoXCVMNHx0Cmc310L0QdQvSRq87W7R5fy4lC9Sr3qF25ppK5VCd
 39UTgVOJSjOjf+Pwa0hF3e68+S467FohWoTAToUSjyZciJ+3fqvnqYg94AKXhtBPLeJN
 vSyYllleEd7s9zVlLQz74RxG4IXnjfc27OAb+PEu5IzdxXy7QSSq3b6zeAdA2ZRLMrjp
 A4OvOtkBwA5DJVDPtVfr7pvKdZcf3MVQe4NMnINtk58801j9iA5EWP0TTCUsGt3muUIf tw== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp68q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBhDaSpRxCuLFHwpBVDoD+KY2hXgdRmk/NmMyuNTj2owjv0qi+pVmrpqE9U5JmCqwrJkPdPdyPFI1W7BUtW8yEmYxLAb36nGdspHVRxP/3C0/SW9qNU1KZFZ4C1uBkW8xwAVVQZ2CuFSiImOUfgRy9K7VloXzqVJq+AzFrcIE4iOJb+Ha7eEMFt08/uQ8Ymzgz7kM8F31c1SCbcISFArWEb0wyJc2lzDrCO62jTjUj/idOZjcca4+5Lr+5BEor9A1S9vqmdFxCsWHrynXmy+bPGuzh99Dw328X9mIK+T3wF4GMaiFK79NZxU36wzlibGYjANzYqFJev0oGNe4uJdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l48AtdCfFxxM+p55i2S9fGifCjm4/On2x8xPd5DI3qE=;
 b=nwx6WEuzk9HdcMTGjY8G53vUTPHPLKNXD0IRwI9goiH71kgRVo9+89C9NtOOJRpbVnSzPFgbiYQPXQY8x5lTJ2WYE2a0VH9mwqQx2t/UIuzbEmE/v46rQqXtoIYrNpToXGAemL8vZEIbW26WhVTKlcfBmkVIIdmo3n3IxRvPNOpFiI4/im8S9srB9/G5tp5qd9jejQxWC9HDRsDlU6XNPS1rRWVZb3ymyPwSm2VKeQRHC5bq/XwwmxPF+ZB3L7qWmRSRS113odUKS3o7kcIJnQvyB+IQS20nc+z6LtdZyO5tyW6RGapE1MHzUdeQQdyLNHpWFRKbjQBkdb6YCvqMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l48AtdCfFxxM+p55i2S9fGifCjm4/On2x8xPd5DI3qE=;
 b=H3H3bhc2GAA8gR+6f7SeX0Qc1cAWuPieD2i/kr76+Y/I7bSxBWOOFIhVkKgQt3zbXjPOmFvS8BDlTIft3jHPF8t5RigUDp/fpwYvhprcSUgBXenghFII+YtPOAWrh3EBKHcb0vqB4cspU11o3mRFFyqYmdZVunMhPl1YLK2yS7I=
Received: from DM5PR07CA0085.namprd07.prod.outlook.com (2603:10b6:4:ae::14) by
 DM6PR07MB6170.namprd07.prod.outlook.com (2603:10b6:5:154::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 13:09:39 +0000
Received: from MW2NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::205) by DM5PR07CA0085.outlook.office365.com
 (2603:10b6:4:ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 MW2NAM12FT065.mail.protection.outlook.com (10.13.180.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5l006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:36 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:24 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:24 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9OsQ011705;
        Wed, 11 Dec 2019 14:09:24 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9OTk011704;
        Wed, 11 Dec 2019 14:09:24 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 12/15] phy: cadence-torrent: Use regmap to read and write Torrent PHY registers
Date:   Wed, 11 Dec 2019 14:09:17 +0100
Message-ID: <1576069760-11473-13-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(36092001)(189003)(199004)(26826003)(5660300002)(426003)(2616005)(36756003)(81166006)(81156014)(26005)(478600001)(8936002)(336012)(186003)(316002)(110136005)(70586007)(54906003)(86362001)(4326008)(356004)(107886003)(8676002)(6666004)(70206006)(42186006)(30864003)(2906002)(76130400001)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6170;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8acc2b3-17be-4352-be3f-08d77e3b60c5
X-MS-TrafficTypeDiagnostic: DM6PR07MB6170:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6170EDC003FF844A144F1C59D25A0@DM6PR07MB6170.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noizyg6q1n40XB1m3SDvRLDxeMl/DWfoau+0UVecdD8c4is+1W3HT+bcDY9Pf2l79HNzaHugBHmTNmX+1aQW5mVtGF+HrhpFYpiFy6AOfSLO9aKx6d5U4WKzh3NaFpvgOkbFsL/QK0r9Hmf0eOAOuXlOKEHaSOF4VkpIX6afLWiOuOKdk79beaynalpyFvhrPYWhV5brHykS7oE+4duZGqF7KonhWaivNaphs5aQ2NChVJTBgVgZKPyZvReW/sQUZffwkC+q4O3xToUXtKvJvORelnMzig2hnk8Rq+uDzO08/LaqXiEVY6BMckbLJCv1zYy0fzNRDT0tGwPpn9/EcSE4PCfcwXjxSrJVnI5KZD8lHmsPojxpinePPGKIuDW5wd6DKhbqB27EWbOr3Yg6EJPJhGW7oitP01/TTgaPHA0GpSPG9mzgPNnIPpsn6AWdYmCTUgMDTzP06B68iHleEyoJvCGY8rgVk1SbU1bxvpJjJT6Epjk4BB248l73Ng8G
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:38.6495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8acc2b3-17be-4352-be3f-08d77e3b60c5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6170
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap for accessing Torrent PHY registers. Modify register offsets
as defined in Torrent PHY user guide. Abstract address calculation
using regmap APIs.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 1020 ++++++++++++++++++-----------
 1 file changed, 650 insertions(+), 370 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 006e786..75b8a81 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/regmap.h>
 
 #define REF_CLK_19_2MHz		19200000
 #define REF_CLK_25MHz		25000000
@@ -28,7 +29,22 @@
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
 #define POLL_TIMEOUT_US		5000
-#define LANE_MASK		0x7
+
+#define TORRENT_COMMON_CDB_OFFSET	0x0
+
+#define TORRENT_TX_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				((0x4000 << (block_offset)) +		\
+				(((ln) << 9) << (reg_offset)))
+
+#define TORRENT_RX_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				((0x8000 << (block_offset)) +		\
+				(((ln) << 9) << (reg_offset)))
+
+#define TORRENT_PHY_PCS_COMMON_OFFSET(block_offset)	\
+				(0xC000 << (block_offset))
+
+#define TORRENT_PHY_PMA_COMMON_OFFSET(block_offset)	\
+				(0xE000 << (block_offset))
 
 /*
  * register offsets from DPTX PHY register block base (i.e MHDP
@@ -57,100 +73,114 @@
  * register offsets from SD0801 PHY register block base (i.e MHDP
  * register base + 0x500000)
  */
-#define CMN_SSM_BANDGAP_TMR		0x00084
-#define CMN_SSM_BIAS_TMR		0x00088
-#define CMN_PLLSM0_PLLPRE_TMR		0x000a8
-#define CMN_PLLSM0_PLLLOCK_TMR		0x000b0
-#define CMN_PLLSM1_PLLPRE_TMR		0x000c8
-#define CMN_PLLSM1_PLLLOCK_TMR		0x000d0
-#define CMN_BGCAL_INIT_TMR		0x00190
-#define CMN_BGCAL_ITER_TMR		0x00194
-#define CMN_IBCAL_INIT_TMR		0x001d0
-#define CMN_PLL0_VCOCAL_TCTRL		0x00208
-#define CMN_PLL0_VCOCAL_INIT_TMR	0x00210
-#define CMN_PLL0_VCOCAL_ITER_TMR	0x00214
-#define CMN_PLL0_VCOCAL_REFTIM_START	0x00218
-#define CMN_PLL0_VCOCAL_PLLCNT_START	0x00220
-#define CMN_PLL0_INTDIV_M0		0x00240
-#define CMN_PLL0_FRACDIVL_M0		0x00244
-#define CMN_PLL0_FRACDIVH_M0		0x00248
-#define CMN_PLL0_HIGH_THR_M0		0x0024c
-#define CMN_PLL0_DSM_DIAG_M0		0x00250
-#define CMN_PLL0_SS_CTRL1_M0		0x00260
-#define CMN_PLL0_SS_CTRL2_M0            0x00264
-#define CMN_PLL0_SS_CTRL3_M0            0x00268
-#define CMN_PLL0_SS_CTRL4_M0            0x0026C
-#define CMN_PLL0_LOCK_REFCNT_START      0x00270
-#define CMN_PLL0_LOCK_PLLCNT_START	0x00278
-#define CMN_PLL0_LOCK_PLLCNT_THR        0x0027C
-#define CMN_PLL1_VCOCAL_TCTRL		0x00308
-#define CMN_PLL1_VCOCAL_INIT_TMR	0x00310
-#define CMN_PLL1_VCOCAL_ITER_TMR	0x00314
-#define CMN_PLL1_VCOCAL_REFTIM_START	0x00318
-#define CMN_PLL1_VCOCAL_PLLCNT_START	0x00320
-#define CMN_PLL1_INTDIV_M0		0x00340
-#define CMN_PLL1_FRACDIVL_M0		0x00344
-#define CMN_PLL1_FRACDIVH_M0		0x00348
-#define CMN_PLL1_HIGH_THR_M0		0x0034c
-#define CMN_PLL1_DSM_DIAG_M0		0x00350
-#define CMN_PLL1_SS_CTRL1_M0		0x00360
-#define CMN_PLL1_SS_CTRL2_M0            0x00364
-#define CMN_PLL1_SS_CTRL3_M0            0x00368
-#define CMN_PLL1_SS_CTRL4_M0            0x0036C
-#define CMN_PLL1_LOCK_REFCNT_START      0x00370
-#define CMN_PLL1_LOCK_PLLCNT_START	0x00378
-#define CMN_PLL1_LOCK_PLLCNT_THR        0x0037C
-#define CMN_TXPUCAL_INIT_TMR		0x00410
-#define CMN_TXPUCAL_ITER_TMR		0x00414
-#define CMN_TXPDCAL_INIT_TMR		0x00430
-#define CMN_TXPDCAL_ITER_TMR		0x00434
-#define CMN_RXCAL_INIT_TMR		0x00450
-#define CMN_RXCAL_ITER_TMR		0x00454
-#define CMN_SD_CAL_INIT_TMR		0x00490
-#define CMN_SD_CAL_ITER_TMR		0x00494
-#define CMN_SD_CAL_REFTIM_START		0x00498
-#define CMN_SD_CAL_PLLCNT_START		0x004a0
-#define CMN_PDIAG_PLL0_CTRL_M0		0x00680
-#define CMN_PDIAG_PLL0_CLK_SEL_M0	0x00684
-#define CMN_PDIAG_PLL0_CP_PADJ_M0	0x00690
-#define CMN_PDIAG_PLL0_CP_IADJ_M0	0x00694
-#define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x00698
-#define CMN_PDIAG_PLL0_CP_PADJ_M1	0x006d0
-#define CMN_PDIAG_PLL0_CP_IADJ_M1	0x006d4
-#define CMN_PDIAG_PLL1_CTRL_M0		0x00700
-#define CMN_PDIAG_PLL1_CLK_SEL_M0	0x00704
-#define CMN_PDIAG_PLL1_CP_PADJ_M0	0x00710
-#define CMN_PDIAG_PLL1_CP_IADJ_M0	0x00714
-#define CMN_PDIAG_PLL1_FILT_PADJ_M0	0x00718
-
-#define TX_TXCC_CTRL			0x10100
-#define TX_TXCC_CPOST_MULT_00		0x10130
-#define TX_TXCC_MGNFS_MULT_000		0x10140
-#define DRV_DIAG_TX_DRV			0x10318
-#define XCVR_DIAG_PLLDRC_CTRL		0x10394
-#define XCVR_DIAG_HSCLK_SEL		0x10398
-#define XCVR_DIAG_HSCLK_DIV		0x1039c
-#define XCVR_DIAG_BIDI_CTRL		0x103a8
-#define TX_PSC_A0			0x10400
-#define TX_PSC_A1			0x10404
-#define TX_PSC_A2			0x10408
-#define TX_PSC_A3			0x1040c
-#define TX_RCVDET_ST_TMR		0x1048c
-#define TX_DIAG_ACYA			0x1079c
+#define CMN_SSM_BANDGAP_TMR		0x0021U
+#define CMN_SSM_BIAS_TMR		0x0022U
+#define CMN_PLLSM0_PLLPRE_TMR		0x002AU
+#define CMN_PLLSM0_PLLLOCK_TMR		0x002CU
+#define CMN_PLLSM1_PLLPRE_TMR		0x0032U
+#define CMN_PLLSM1_PLLLOCK_TMR		0x0034U
+#define CMN_BGCAL_INIT_TMR		0x0064U
+#define CMN_BGCAL_ITER_TMR		0x0065U
+#define CMN_IBCAL_INIT_TMR		0x0074U
+#define CMN_PLL0_VCOCAL_TCTRL		0x0082U
+#define CMN_PLL0_VCOCAL_INIT_TMR	0x0084U
+#define CMN_PLL0_VCOCAL_ITER_TMR	0x0085U
+#define CMN_PLL0_VCOCAL_REFTIM_START	0x0086U
+#define CMN_PLL0_VCOCAL_PLLCNT_START	0x0088U
+#define CMN_PLL0_INTDIV_M0		0x0090U
+#define CMN_PLL0_FRACDIVL_M0		0x0091U
+#define CMN_PLL0_FRACDIVH_M0		0x0092U
+#define CMN_PLL0_HIGH_THR_M0		0x0093U
+#define CMN_PLL0_DSM_DIAG_M0		0x0094U
+#define CMN_PLL0_SS_CTRL1_M0		0x0098U
+#define CMN_PLL0_SS_CTRL2_M0            0x0099U
+#define CMN_PLL0_SS_CTRL3_M0            0x009AU
+#define CMN_PLL0_SS_CTRL4_M0            0x009BU
+#define CMN_PLL0_LOCK_REFCNT_START      0x009CU
+#define CMN_PLL0_LOCK_PLLCNT_START	0x009EU
+#define CMN_PLL0_LOCK_PLLCNT_THR        0x009FU
+#define CMN_PLL1_VCOCAL_TCTRL		0x00C2U
+#define CMN_PLL1_VCOCAL_INIT_TMR	0x00C4U
+#define CMN_PLL1_VCOCAL_ITER_TMR	0x00C5U
+#define CMN_PLL1_VCOCAL_REFTIM_START	0x00C6U
+#define CMN_PLL1_VCOCAL_PLLCNT_START	0x00C8U
+#define CMN_PLL1_INTDIV_M0		0x00D0U
+#define CMN_PLL1_FRACDIVL_M0		0x00D1U
+#define CMN_PLL1_FRACDIVH_M0		0x00D2U
+#define CMN_PLL1_HIGH_THR_M0		0x00D3U
+#define CMN_PLL1_DSM_DIAG_M0		0x00D4U
+#define CMN_PLL1_SS_CTRL1_M0		0x00D8U
+#define CMN_PLL1_SS_CTRL2_M0            0x00D9U
+#define CMN_PLL1_SS_CTRL3_M0            0x00DAU
+#define CMN_PLL1_SS_CTRL4_M0            0x00DBU
+#define CMN_PLL1_LOCK_REFCNT_START      0x00DCU
+#define CMN_PLL1_LOCK_PLLCNT_START	0x00DEU
+#define CMN_PLL1_LOCK_PLLCNT_THR        0x00DFU
+#define CMN_TXPUCAL_INIT_TMR		0x0104U
+#define CMN_TXPUCAL_ITER_TMR		0x0105U
+#define CMN_TXPDCAL_INIT_TMR		0x010CU
+#define CMN_TXPDCAL_ITER_TMR		0x010DU
+#define CMN_RXCAL_INIT_TMR		0x0114U
+#define CMN_RXCAL_ITER_TMR		0x0115U
+#define CMN_SD_CAL_INIT_TMR		0x0124U
+#define CMN_SD_CAL_ITER_TMR		0x0125U
+#define CMN_SD_CAL_REFTIM_START		0x0126U
+#define CMN_SD_CAL_PLLCNT_START		0x0128U
+#define CMN_PDIAG_PLL0_CTRL_M0		0x01A0U
+#define CMN_PDIAG_PLL0_CLK_SEL_M0	0x01A1U
+#define CMN_PDIAG_PLL0_CP_PADJ_M0	0x01A4U
+#define CMN_PDIAG_PLL0_CP_IADJ_M0	0x01A5U
+#define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x01A6U
+#define CMN_PDIAG_PLL0_CP_PADJ_M1	0x01B4U
+#define CMN_PDIAG_PLL0_CP_IADJ_M1	0x01B5U
+#define CMN_PDIAG_PLL1_CTRL_M0		0x01C0U
+#define CMN_PDIAG_PLL1_CLK_SEL_M0	0x01C1U
+#define CMN_PDIAG_PLL1_CP_PADJ_M0	0x01C4U
+#define CMN_PDIAG_PLL1_CP_IADJ_M0	0x01C5U
+#define CMN_PDIAG_PLL1_FILT_PADJ_M0	0x01C6U
+
+/* PMA TX Lane registers */
+#define TX_TXCC_CTRL			0x0040U
+#define TX_TXCC_CPOST_MULT_00		0x004CU
+#define TX_TXCC_MGNFS_MULT_000		0x0050U
+#define DRV_DIAG_TX_DRV			0x00C6U
+#define XCVR_DIAG_PLLDRC_CTRL		0x00E5U
+#define XCVR_DIAG_HSCLK_SEL		0x00E6U
+#define XCVR_DIAG_HSCLK_DIV		0x00E7U
+#define XCVR_DIAG_BIDI_CTRL		0x00EAU
+#define TX_PSC_A0			0x0100U
+#define TX_PSC_A2			0x0102U
+#define TX_PSC_A3			0x0103U
+#define TX_RCVDET_ST_TMR		0x0123U
+#define TX_DIAG_ACYA			0x01E7U
 #define TX_DIAG_ACYA_HBDC_MASK		0x0001U
-#define RX_PSC_A0			0x20000
-#define RX_PSC_A1			0x20004
-#define RX_PSC_A2			0x20008
-#define RX_PSC_A3			0x2000c
-#define RX_PSC_CAL			0x20018
-#define RX_REE_GCSM1_CTRL		0x20420
-#define RX_REE_GCSM2_CTRL		0x20440
-#define RX_REE_PERGCSM_CTRL		0x20460
 
-#define PHY_PLL_CFG			0x30038
+/* PMA RX Lane registers */
+#define RX_PSC_A0			0x0000U
+#define RX_PSC_A2			0x0002U
+#define RX_PSC_A3			0x0003U
+#define RX_PSC_CAL			0x0006U
+#define RX_REE_GCSM1_CTRL		0x0108U
+#define RX_REE_GCSM2_CTRL		0x0110U
+#define RX_REE_PERGCSM_CTRL		0x0118U
+
+/* PHY PCS common registers */
+#define PHY_PLL_CFG			0x000EU
+
+/* PHY PMA common registers */
+#define PHY_PMA_CMN_CTRL2		0x0001U
+#define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
-#define PHY_PMA_CMN_CTRL2		0x38004
-#define PHY_PMA_PLL_RAW_CTRL		0x3800c
+static const struct reg_field phy_pll_cfg =
+				REG_FIELD(PHY_PLL_CFG, 0, 1);
+
+static const struct reg_field phy_pma_cmn_ctrl_2 =
+				REG_FIELD(PHY_PMA_CMN_CTRL2, 0, 7);
+
+static const struct reg_field phy_pma_pll_raw_ctrl =
+				REG_FIELD(PHY_PMA_PLL_RAW_CTRL, 0, 1);
+
+static const struct of_device_id cdns_torrent_phy_of_match[];
 
 struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
@@ -161,6 +191,15 @@ struct cdns_torrent_phy {
 	struct device *dev;
 	struct clk *clk;
 	unsigned long ref_clk_rate;
+	struct regmap *regmap;
+	struct regmap *regmap_common_cdb;
+	struct regmap *regmap_phy_pcs_common_cdb;
+	struct regmap *regmap_phy_pma_common_cdb;
+	struct regmap *regmap_tx_lane_cdb[MAX_NUM_LANES];
+	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
+	struct regmap_field *phy_pll_cfg;
+	struct regmap_field *phy_pma_cmn_ctrl_2;
+	struct regmap_field *phy_pma_pll_raw_ctrl;
 };
 
 enum phy_powerstate {
@@ -213,23 +252,106 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
-/* PHY mmr access functions */
+struct cdns_torrent_data {
+		u8 block_offset_shift;
+		u8 reg_offset_shift;
+};
 
-static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
-				   u32 offset, u32 val)
+struct cdns_regmap_cdb_context {
+	struct device *dev;
+	void __iomem *base;
+	u8 reg_offset_shift;
+};
+
+static int cdns_regmap_write(void *context, unsigned int reg, unsigned int val)
 {
-	writel(val, cdns_phy->sd_base + offset);
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg << ctx->reg_offset_shift;
+
+	writew(val, ctx->base + offset);
+
+	return 0;
 }
 
-static u32 cdns_torrent_phy_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
+static int cdns_regmap_read(void *context, unsigned int reg, unsigned int *val)
 {
-	return readl(cdns_phy->sd_base + offset);
+	struct cdns_regmap_cdb_context *ctx = context;
+	u32 offset = reg << ctx->reg_offset_shift;
+
+	*val = readw(ctx->base + offset);
+	return 0;
 }
 
-#define cdns_torrent_phy_read_poll_timeout(cdns_phy, offset, val, cond, \
-					   delay_us, timeout_us) \
-	readl_poll_timeout((cdns_phy)->sd_base + (offset), \
-			   val, cond, delay_us, timeout_us)
+#define TORRENT_TX_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "torrent_tx_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+#define TORRENT_RX_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "torrent_rx_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static struct regmap_config cdns_torrent_tx_lane_cdb_config[] = {
+	TORRENT_TX_LANE_CDB_REGMAP_CONF("0"),
+	TORRENT_TX_LANE_CDB_REGMAP_CONF("1"),
+	TORRENT_TX_LANE_CDB_REGMAP_CONF("2"),
+	TORRENT_TX_LANE_CDB_REGMAP_CONF("3"),
+};
+
+static struct regmap_config cdns_torrent_rx_lane_cdb_config[] = {
+	TORRENT_RX_LANE_CDB_REGMAP_CONF("0"),
+	TORRENT_RX_LANE_CDB_REGMAP_CONF("1"),
+	TORRENT_RX_LANE_CDB_REGMAP_CONF("2"),
+	TORRENT_RX_LANE_CDB_REGMAP_CONF("3"),
+};
+
+static struct regmap_config cdns_torrent_common_cdb_config = {
+	.name = "torrent_common_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
+static struct regmap_config cdns_torrent_phy_pcs_cmn_cdb_config = {
+	.name = "torrent_phy_pcs_cmn_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
+static struct regmap_config cdns_torrent_phy_pma_cmn_cdb_config = {
+	.name = "torrent_phy_pma_cmn_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
+/* PHY mmr access functions */
+
+static void cdns_torrent_phy_write(struct regmap *regmap, u32 offset, u32 val)
+{
+	regmap_write(regmap, offset, val);
+}
+
+static u32 cdns_torrent_phy_read(struct regmap *regmap, u32 offset)
+{
+	unsigned int val;
+
+	regmap_read(regmap, offset, &val);
+	return val;
+}
 
 /* DPTX mmr access functions */
 
@@ -376,16 +498,16 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	u32 read_val;
 
 	/* Disable the cmn_pll0_en before re-programming the new data rate. */
-	cdns_torrent_phy_write(cdns_phy, PHY_PMA_PLL_RAW_CTRL, 0);
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
 
 	/*
 	 * Wait for PLL ready de-assertion.
 	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
 	 */
-	ret = cdns_torrent_phy_read_poll_timeout(cdns_phy, PHY_PMA_CMN_CTRL2,
-						 read_val,
-						 ((read_val >> 2) & 0x01) != 0,
-						 0, POLL_TIMEOUT_US);
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+					     read_val,
+					     ((read_val >> 2) & 0x01) != 0,
+					     0, POLL_TIMEOUT_US);
 	if (ret)
 		return ret;
 	ndelay(200);
@@ -405,16 +527,16 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
 
 	/* Enable the cmn_pll0_en. */
-	cdns_torrent_phy_write(cdns_phy, PHY_PMA_PLL_RAW_CTRL, 0x3);
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x3);
 
 	/*
 	 * Wait for PLL ready assertion.
 	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
 	 */
-	ret = cdns_torrent_phy_read_poll_timeout(cdns_phy, PHY_PMA_CMN_CTRL2,
-						 read_val,
-						 (read_val & 0x01) != 0,
-						 0, POLL_TIMEOUT_US);
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+					     read_val,
+					     (read_val & 0x01) != 0,
+					     0, POLL_TIMEOUT_US);
 	return ret;
 }
 
@@ -606,44 +728,41 @@ static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
 {
 	u8 lane;
 	u16 val;
-	unsigned int lane_bits;
 
 	for (lane = 0; lane < dp->lanes; lane++) {
-		lane_bits = (lane & LANE_MASK) << 11;
-
-		val = cdns_torrent_phy_read(cdns_phy,
-					    (TX_DIAG_ACYA | lane_bits));
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+					    TX_DIAG_ACYA);
 		/*
 		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
 		 * current state of the analog TX driver.
 		 */
 		val |= TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_DIAG_ACYA | lane_bits), val);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_DIAG_ACYA, val);
 
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_TXCC_CTRL | lane_bits), 0x08A4);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_CTRL, 0x08A4);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
-		cdns_torrent_phy_write(cdns_phy,
-				       (DRV_DIAG_TX_DRV | lane_bits), val);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       DRV_DIAG_TX_DRV, val);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_TXCC_MGNFS_MULT_000 | lane_bits),
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_MGNFS_MULT_000,
 				       val);
 		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_TXCC_CPOST_MULT_00 | lane_bits),
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_CPOST_MULT_00,
 				       val);
 
-		val = cdns_torrent_phy_read(cdns_phy,
-					    (TX_DIAG_ACYA | lane_bits));
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+					    TX_DIAG_ACYA);
 		/*
 		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
 		 * analog TX driver to reflect the new programmed one.
 		 */
 		val &= ~TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_DIAG_ACYA | lane_bits), val);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_DIAG_ACYA, val);
 	}
 };
 
@@ -805,43 +924,45 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
 static
 void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy)
 {
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
 	/* refclock registers - assumes 19.2 MHz refclock */
-	cdns_torrent_phy_write(cdns_phy, CMN_SSM_BIAS_TMR, 0x0014);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
-	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_INIT_TMR, 0x0060);
-	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_ITER_TMR, 0x0060);
-	cdns_torrent_phy_write(cdns_phy, CMN_IBCAL_INIT_TMR, 0x0014);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_INIT_TMR, 0x0018);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_INIT_TMR, 0x0018);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_INIT_TMR, 0x0240);
-	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_INIT_TMR, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_ITER_TMR, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_REFTIM_START, 0x000B);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x0137);
+	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0014);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x0060);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x0060);
+	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0014);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x0018);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x0018);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x0240);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000B);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x0137);
 
 	/* PLL registers */
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
 }
 
 /*
@@ -852,44 +973,48 @@ static
 void cdns_torrent_dp_enable_ssc_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 					u32 ctrl2_val, u32 ctrl3_val)
 {
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0003);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
 }
 
 static
 void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 					     u32 rate, bool ssc)
 {
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
 	/* Assumes 19.2 MHz refclock */
 	switch (rate) {
 	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_INTDIV_M0, 0x0119);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_HIGH_THR_M0, 0x00BC);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL0_CTRL_M0, 0x0012);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_INTDIV_M0, 0x0119);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_HIGH_THR_M0, 0x00BC);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL1_CTRL_M0, 0x0012);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A,
@@ -899,25 +1024,25 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	case 1620:
 	case 2430:
 	case 3240:
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_INTDIV_M0, 0x01FA);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_HIGH_THR_M0, 0x0152);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_INTDIV_M0, 0x01FA);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_HIGH_THR_M0, 0x0152);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD,
@@ -926,25 +1051,25 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_INTDIV_M0, 0x01C2);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_HIGH_THR_M0, 0x012C);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_INTDIV_M0, 0x01C2);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_HIGH_THR_M0, 0x012C);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536,
@@ -952,25 +1077,25 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 		break;
 	/* Setting VCO for 8.1GHz */
 	case 8100:
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_INTDIV_M0, 0x01A5);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVL_M0, 0xE000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_HIGH_THR_M0, 0x011A);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_INTDIV_M0, 0x01A5);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVL_M0, 0xE000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_HIGH_THR_M0, 0x011A);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7,
@@ -979,88 +1104,90 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	}
 
 	if (ssc) {
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
 	} else {
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
 		/* Set reset register values to disable SSC */
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
 	}
 
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
 }
 
 static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
 	/* refclock registers - assumes 25 MHz refclock */
-	cdns_torrent_phy_write(cdns_phy, CMN_SSM_BIAS_TMR, 0x0019);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
-	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_INIT_TMR, 0x007D);
-	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_ITER_TMR, 0x007D);
-	cdns_torrent_phy_write(cdns_phy, CMN_IBCAL_INIT_TMR, 0x0019);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_INIT_TMR, 0x001E);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_INIT_TMR, 0x001E);
-	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_INIT_TMR, 0x02EE);
-	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_INIT_TMR, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_ITER_TMR, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_REFTIM_START, 0x000E);
-	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x012B);
+	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0019);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x007D);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x007D);
+	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0019);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x02EE);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000E);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x012B);
 
 	/* PLL registers */
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
 }
 
 /*
@@ -1070,33 +1197,37 @@ void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 static void cdns_torrent_dp_enable_ssc_25mhz(struct cdns_torrent_phy *cdns_phy,
 					     u32 ctrl2_val)
 {
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x007F);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0003);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x007F);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
 }
 
 static
 void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 					   u32 rate, bool ssc)
 {
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
 	/* Assumes 25 MHz refclock */
 	switch (rate) {
 	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x01B0);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0120);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x01B0);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x0120);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0120);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0120);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x0423);
 		break;
@@ -1104,82 +1235,82 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 	case 1620:
 	case 2430:
 	case 3240:
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0184);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0104);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0184);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x0104);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0104);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0104);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x03B9);
 		break;
 	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0159);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x999A);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00E7);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0159);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x999A);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x00E7);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00E7);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00E7);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x034F);
 		break;
 	/* Setting VCO for 8.1GHz */
 	case 8100:
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0144);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00D8);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_INTDIV_M0, 0x0144);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_HIGH_THR_M0, 0x00D8);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00D8);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00D8);
 		if (ssc)
 			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x031A);
 		break;
 	}
 
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 
 	if (ssc) {
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0315);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0315);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
 	} else {
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0317);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0317);
 		/* Set reset register values to disable SSC */
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy, CMN_PLL1_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(cdns_phy,
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
 				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
 	}
 
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
-	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
 }
 
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
@@ -1190,7 +1321,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 	unsigned int i;
 
 	/* 16'h0000 for single DP link configuration */
-	cdns_torrent_phy_write(cdns_phy, PHY_PLL_CFG, 0x0000);
+	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
 
 	switch (rate) {
 	case 1620:
@@ -1218,54 +1349,58 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 		break;
 	}
 
-	cdns_torrent_phy_write(cdns_phy,
+	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
 			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
-	cdns_torrent_phy_write(cdns_phy,
+	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
 			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
 
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < cdns_phy->num_lanes; i++)
-		cdns_torrent_phy_write(cdns_phy,
-				       (XCVR_DIAG_HSCLK_DIV | (i << 11)),
-				       hsclk_div_val);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
+				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
 }
 
 static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane)
 {
-	unsigned int lane_bits = (lane & LANE_MASK) << 11;
-
 	/* Per lane, refclock-dependent receiver detection setting */
 	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_RCVDET_ST_TMR | lane_bits), 0x0780);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_RCVDET_ST_TMR, 0x0780);
 	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
-		cdns_torrent_phy_write(cdns_phy,
-				       (TX_RCVDET_ST_TMR | lane_bits), 0x09C4);
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_RCVDET_ST_TMR, 0x09C4);
 
 	/* Writing Tx/Rx Power State Controllers registers */
-	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A0 | lane_bits), 0x00FB);
-	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A2 | lane_bits), 0x04AA);
-	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A3 | lane_bits), 0x04AA);
-	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A0 | lane_bits), 0x0000);
-	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A2 | lane_bits), 0x0000);
-	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A3 | lane_bits), 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy, (RX_PSC_CAL | lane_bits), 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy,
-			       (RX_REE_GCSM1_CTRL | lane_bits), 0x0000);
-	cdns_torrent_phy_write(cdns_phy,
-			       (RX_REE_GCSM2_CTRL | lane_bits), 0x0000);
-	cdns_torrent_phy_write(cdns_phy,
-			       (RX_REE_PERGCSM_CTRL | lane_bits), 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy,
-			       (XCVR_DIAG_BIDI_CTRL | lane_bits), 0x000F);
-	cdns_torrent_phy_write(cdns_phy,
-			       (XCVR_DIAG_PLLDRC_CTRL | lane_bits), 0x0001);
-	cdns_torrent_phy_write(cdns_phy,
-			       (XCVR_DIAG_HSCLK_SEL | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A0, 0x00FB);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A2, 0x04AA);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A3, 0x04AA);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A0, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A2, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A3, 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_CAL, 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_GCSM1_CTRL, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_GCSM2_CTRL, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_PERGCSM_CTRL, 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_BIDI_CTRL, 0x000F);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_PLLDRC_CTRL, 0x0001);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_HSCLK_SEL, 0x0000);
 }
 
 static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
@@ -1394,14 +1529,142 @@ static int cdns_torrent_phy_off(struct phy *phy)
 	return reset_control_assert(cdns_phy->phy_rst);
 }
 
+static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
+				       u32 block_offset,
+				       u8 reg_offset_shift,
+				       const struct regmap_config *config)
+{
+	struct cdns_regmap_cdb_context *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->base = base + block_offset;
+	ctx->reg_offset_shift = reg_offset_shift;
+
+	return devm_regmap_init(dev, NULL, ctx, config);
+}
+
+static int cdns_regfield_init(struct cdns_torrent_phy *cdns_phy)
+{
+	struct device *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct regmap *regmap;
+
+	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PLL_CFG reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pll_cfg = field;
+
+	regmap = cdns_phy->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_2);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_CMN_CTRL2 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pma_cmn_ctrl_2 = field;
+
+	regmap = cdns_phy->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pma_pll_raw_ctrl);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_PLL_RAW_CTRL reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pma_pll_raw_ctrl = field;
+
+	return 0;
+}
+
+static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
+				       void __iomem *sd_base,
+				       void __iomem *base,
+				       u8 block_offset_shift,
+				       u8 reg_offset_shift)
+{
+	struct device *dev = cdns_phy->dev;
+	struct regmap *regmap;
+	u32 block_offset;
+	int i;
+
+	for (i = 0; i < MAX_NUM_LANES; i++) {
+		block_offset = TORRENT_TX_LANE_CDB_OFFSET(i, block_offset_shift,
+							  reg_offset_shift);
+		regmap = cdns_regmap_init(dev, sd_base, block_offset,
+					  reg_offset_shift,
+					  &cdns_torrent_tx_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init tx lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		cdns_phy->regmap_tx_lane_cdb[i] = regmap;
+
+		block_offset = TORRENT_RX_LANE_CDB_OFFSET(i, block_offset_shift,
+							  reg_offset_shift);
+		regmap = cdns_regmap_init(dev, sd_base, block_offset,
+					  reg_offset_shift,
+					  &cdns_torrent_rx_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init rx lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		cdns_phy->regmap_rx_lane_cdb[i] = regmap;
+	}
+
+	block_offset = TORRENT_COMMON_CDB_OFFSET;
+	regmap = cdns_regmap_init(dev, sd_base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_common_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	cdns_phy->regmap_common_cdb = regmap;
+
+	block_offset = TORRENT_PHY_PCS_COMMON_OFFSET(block_offset_shift);
+	regmap = cdns_regmap_init(dev, sd_base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_phy_pcs_cmn_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init PHY PCS common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	cdns_phy->regmap_phy_pcs_common_cdb = regmap;
+
+	block_offset = TORRENT_PHY_PMA_COMMON_OFFSET(block_offset_shift);
+	regmap = cdns_regmap_init(dev, sd_base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_phy_pma_cmn_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init PHY PMA common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	cdns_phy->regmap_phy_pma_common_cdb = regmap;
+
+	return 0;
+}
+
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
 	struct cdns_torrent_phy *cdns_phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
+	const struct of_device_id *match;
+	struct cdns_torrent_data *data;
 	struct phy *phy;
-	int err;
+	int err, ret;
+
+	/* Get init data for this PHY */
+	match = of_match_device(cdns_torrent_phy_of_match, dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct cdns_torrent_data *)match->data;
 
 	cdns_phy = devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
 	if (!cdns_phy)
@@ -1416,15 +1679,15 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cdns_phy->base = devm_ioremap_resource(&pdev->dev, regs);
-	if (IS_ERR(cdns_phy->base))
-		return PTR_ERR(cdns_phy->base);
-
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(cdns_phy->sd_base))
 		return PTR_ERR(cdns_phy->sd_base);
 
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cdns_phy->base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(cdns_phy->base))
+		return PTR_ERR(cdns_phy->base);
+
 	cdns_phy->phy_rst = devm_reset_control_array_get_exclusive(dev);
 
 	err = device_property_read_u32(dev, "num_lanes",
@@ -1474,6 +1737,17 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 
 	phy_set_drvdata(phy, cdns_phy);
 
+	ret = cdns_regmap_init_torrent_dp(cdns_phy, cdns_phy->sd_base,
+					  cdns_phy->base,
+					  data->block_offset_shift,
+					  data->reg_offset_shift);
+	if (ret)
+		return ret;
+
+	ret = cdns_regfield_init(cdns_phy);
+	if (ret)
+		return ret;
+
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
 	dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
@@ -1484,9 +1758,15 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const struct cdns_torrent_data cdns_map_torrent = {
+	.block_offset_shift = 0x2,
+	.reg_offset_shift = 0x2,
+};
+
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
-		.compatible = "cdns,torrent-phy"
+		.compatible = "cdns,torrent-phy",
+		.data = &cdns_map_torrent,
 	},
 	{}
 };
-- 
2.7.4

