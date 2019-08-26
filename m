Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EDDC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738F921881
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ffa8nu70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbfHZUbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:31:13 -0400
Received: from mail-eopbgr690088.outbound.protection.outlook.com ([40.107.69.88]:61764
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726903AbfHZUbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok5UDT1VZciUBklyuM1kKBrjiC8VfHpyAMCoy8xS9GjKsz+goAwiVLsCaG/34r6fGQbjRYV8gvGwM0rMn/4EFZByRc+UAkSIfCi2B8iKgiAByCdO5D482NGqDwRHehHrLkIdLHgOwwJE4Cs8Ois6V7I1eH6lnRRJ3HizOLKhwCZ7539WLtxnWr4fU0hg5XQUnU6vVa3U1a3tYgWmVAq03xQhKdLGmYHHSQPL45b4gxZa6vtfoliOY5YQbAb3QSkm35FhAdDFWJCbXY90oC7qN1Q6n7BBu1Zt+P0ejaPdl0QM11LFNrFHVXseLKu/wwjfBIgpoBWOBw1yycyN49jHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Kf0ZeWm66x6Ns0Ui4jDDO6DrAY2zLPRDZXq+2fM/M=;
 b=PtzkzjsnBgSZ/a6z2JHC2f2uv5HnBdfAiep/2C4c1FyLaLUphldxP0Q1TppRwbjFPziDyLlDtLODCyCyyMe2mG6zR/I0lW738bvzenqtr29+ZUAWIcvnuFECCt5h8Y8giwu6bnrqVds38eWL5UE8Cm79iJCw9CchZ6l+abFmS8WwVRSNvgkxEPHMU7Ys8V+gZhzYiWbdSBzr69J/BYibYQdMCNwb+oD3huSRJuStnyMBBlFzFkZSfk9jTeYS6Saq0gvIRILRdUDKLb5SLva3Pff1n/GcUy00rrgIDDIsv5NGnCoFgeodPvprO6a5qjx+8c6BZ1pkM9iIfBLwIfIueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Kf0ZeWm66x6Ns0Ui4jDDO6DrAY2zLPRDZXq+2fM/M=;
 b=Ffa8nu70HheJCJwRf6EyadyIIAgXtuDRd/sgBOK3e8zuumLXR8Asxtb9oiq+14KGAeuNHRUFRGu2q2IzC64pH0URbmJVnKJiZVlF/Ng591JCT27a0bNI40AzfWuJQJckB/vRVlUF9u2rh/M00jMQ5T8TPXXnNZINfoOO3ME96Ks=
Received: from SN6PR02CA0006.namprd02.prod.outlook.com (2603:10b6:805:a2::19)
 by SN6PR02MB5613.namprd02.prod.outlook.com (2603:10b6:805:eb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Mon, 26 Aug
 2019 20:31:00 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by SN6PR02CA0006.outlook.office365.com
 (2603:10b6:805:a2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.14 via Frontend
 Transport; Mon, 26 Aug 2019 20:31:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2199.13
 via Frontend Transport; Mon, 26 Aug 2019 20:31:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45971 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1i2Ldj-00011q-D6; Mon, 26 Aug 2019 13:30:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1i2Lde-00067Z-9r; Mon, 26 Aug 2019 13:30:54 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1i2LdY-00064f-A1; Mon, 26 Aug 2019 13:30:48 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     matthias.bgg@gmail.com, andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v2] soc: xilinx: Set CAP_UNUSABLE requirement for versal while powering down domain
Date:   Mon, 26 Aug 2019 13:30:44 -0700
Message-Id: <1566851444-22842-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(199004)(189003)(48376002)(36386004)(54906003)(106002)(478600001)(8936002)(36756003)(6666004)(14444005)(4326008)(356004)(316002)(107886003)(50466002)(305945005)(16586007)(81156014)(81166006)(426003)(2906002)(8676002)(6636002)(486006)(126002)(2616005)(9786002)(476003)(336012)(26005)(44832011)(70586007)(70206006)(186003)(47776003)(7696005)(51416003)(50226002)(5660300002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5613;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 123ea151-07ac-452c-c295-08d72a644ed8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:SN6PR02MB5613;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5613:
X-Microsoft-Antispam-PRVS: <SN6PR02MB561354600CB3A7427BD1BEC0B8A10@SN6PR02MB5613.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01415BB535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FCzMbUcn3GYKt7zoicPL+s9XFPUrrvtjNg9hJFJTYv60zyjKh0G2CQkm6lHutiZgZh33DDdl47U4lx+DhGs7OZVBu01+fViQfqbLpQlFOtqJyd8evYjV4sAWtspkhxjqYSEO/LdQRJA1jrqHxODXC0AiOOUSAlXA5fQ9kkCS+UYduWDWjrx+F5MOUMQ+KUYL7lbmPn6hBvndG7kFWsso8A7IyL2Y9wZXNmOrQf70R4qbb+jKf6pSat+tz9JdQHK3osH+6LcXhkOc79CEwMe1Qfen7yr6WTRgJBfiBMKjdyuV1/ZoRV7XdFT0+RmAtdhRI+npQlqkmmPh74jSAIKyYyE+8gbElBgW3C8wZ7LaO1oOHPGqhvX2me2yTOtr1MrkmgBKuGiLmegY3wktX957igpFJK1xPjrgH4RDlKpe+qo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2019 20:31:00.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123ea151-07ac-452c-c295-08d72a644ed8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

For "0" requirement which is used to inform firmware that device is
not required currently by master, Versal PLM (Platform Loader and
Manager) which runs on Platform Management Controller and is responsible
platform management of devices that disables clock, power it down
and reset the device. genpd_power_off() is being called during runtime
suspend also. So, if any device goes to runtime suspend state during
resumes it needs to be re-initialized again. It is possible that
drivers do not reinitialize device upon resume from runtime suspend
every time ans so dont want it to be powered down or get reset
during runtime suspend.

In Versal PLM new PM_CAP_UNUSABLE capability is added, which disables
clock only and avoids power down and reset during runtime suspend. Power
and reset will be gated with core suspend.So, this patch sets 
CAPABILITY_UNUSABLE requirement during gpd_power_off()
if platform is other than zynqmp.

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/soc/xilinx/zynqmp_pm_domains.c | 10 ++++++++--
 include/linux/firmware/xlnx-zynqmp.h   |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
index 600f57c..23d90cb 100644
--- a/drivers/soc/xilinx/zynqmp_pm_domains.c
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -2,7 +2,7 @@
 /*
  * ZynqMP Generic PM domain support
  *
- *  Copyright (C) 2015-2018 Xilinx, Inc.
+ *  Copyright (C) 2015-2019 Xilinx, Inc.
  *
  *  Davorin Mista <davorin.mista@aggios.com>
  *  Jolly Shah <jollys@xilinx.com>
@@ -25,6 +25,8 @@
 
 static const struct zynqmp_eemi_ops *eemi_ops;
 
+static int min_capability;
+
 /**
  * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
  * @gpd:		Generic power domain
@@ -106,7 +108,7 @@ static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
 	int ret;
 	struct pm_domain_data *pdd, *tmp;
 	struct zynqmp_pm_domain *pd;
-	u32 capabilities = 0;
+	u32 capabilities = min_capability;
 	bool may_wakeup;
 
 	if (!eemi_ops->set_requirement)
@@ -283,6 +285,10 @@ static int zynqmp_gpd_probe(struct platform_device *pdev)
 	if (!domains)
 		return -ENOMEM;
 
+	if (!of_device_is_compatible(dev->parent->of_node,
+				     "xlnx,zynqmp-firmware"))
+		min_capability = ZYNQMP_PM_CAPABILITY_UNUSABLE;
+
 	for (i = 0; i < ZYNQMP_NUM_DOMAINS; i++, pd++) {
 		pd->node_id = 0;
 		pd->gpd.name = kasprintf(GFP_KERNEL, "domain%d", i);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 778abbb..b8a7c22 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -2,7 +2,7 @@
 /*
  * Xilinx Zynq MPSoC Firmware layer
  *
- *  Copyright (C) 2014-2018 Xilinx
+ *  Copyright (C) 2014-2019 Xilinx
  *
  *  Michal Simek <michal.simek@xilinx.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -46,6 +46,7 @@
 #define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
 #define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
+#define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
 
 /*
  * Firmware FPGA Manager flags
-- 
2.7.4

