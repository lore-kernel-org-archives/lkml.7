Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE272C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC8E208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="o1QdZZXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfGAFaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:30:20 -0400
Received: from mail-eopbgr790049.outbound.protection.outlook.com ([40.107.79.49]:56512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbfGAFaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44lPQNBv4Qss0Y/664dDb1zlXgS1vXv8HytEmDen4uI=;
 b=o1QdZZXos0hAY1/Uq8QJKmwGBieSVs/6GJ6K/oZWAOlm0e7zsJWv0L0boXRF1ACO9kWU/RuG8RPxwA/ZgRHLB813jrmUVhy4gh5EVKZ//hYGqW/F6DWAkzq4zLA035b8JJAHlbsfU1/IA+ve1lnEj+FPLacFQCIZiIU+jnhTVdE=
Received: from SN4PR0201CA0004.namprd02.prod.outlook.com
 (2603:10b6:803:2b::14) by MN2PR02MB6334.namprd02.prod.outlook.com
 (2603:10b6:208:182::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.18; Mon, 1 Jul
 2019 05:30:08 +0000
Received: from SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by SN4PR0201CA0004.outlook.office365.com
 (2603:10b6:803:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.18 via Frontend
 Transport; Mon, 1 Jul 2019 05:30:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT042.mail.protection.outlook.com (10.152.73.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 05:30:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhotC-0002rm-CY; Sun, 30 Jun 2019 22:30:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhot7-0003EO-6j; Sun, 30 Jun 2019 22:30:01 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x615Tt9A008173;
        Sun, 30 Jun 2019 22:29:55 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hhot1-0003CP-0Y; Sun, 30 Jun 2019 22:29:55 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 3318012172B; Mon,  1 Jul 2019 10:59:54 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com,
        christoph.muellner@theobroma-systems.com,
        philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org,
        scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk,
        tony.xie@rock-chips.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        manish.narani@xilinx.com, olof@lixom.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 03/11] mmc: sdhci-of-arasan: Replace deprecated clk API calls
Date:   Mon,  1 Jul 2019 10:59:43 +0530
Message-Id: <1561958991-21935-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(189003)(199004)(5660300002)(336012)(50466002)(478600001)(6266002)(76176011)(106002)(48376002)(36386004)(81156014)(52956003)(4326008)(8676002)(426003)(2906002)(50226002)(70206006)(70586007)(8936002)(103686004)(356004)(6666004)(81166006)(446003)(486006)(47776003)(63266004)(305945005)(11346002)(476003)(51416003)(2616005)(44832011)(42186006)(72206003)(316002)(7416002)(16586007)(36756003)(186003)(26005)(126002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6334;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a739239-ed2b-473c-56c2-08d6fde52da7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR02MB6334;
X-MS-TrafficTypeDiagnostic: MN2PR02MB6334:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MN2PR02MB63342DA6A0217CBB2379E0D4C1F90@MN2PR02MB6334.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZVZu/RTgJ+dark0bD+GsU/ZLfnmJzwa69OnJKwM1ZLxK3H69qoyFJLNa05oED4As5spZbagpvwax2V94SolJYhoW0NURV1jIbL3xTf9SNJATUyomNynetZgInTjfWC58VWjhQVz9f1XZmOXQzTLuVnQPBicSB/7gkHqiEQvF6OfBR/602zzamqn1IVs3sqwmOlFpaKC/pSJbQFRblporxegu17pUhJX0RVVCEDymZkn5Mdnp/gRpfG7YS66wRyS8IZiR3Kzb4za43A/1q4L2SlzUVRNFPVHJAItxPsRMK6pSNwQWvy/ycfwiMgOER8BSRCWdWdWjbf+sNAkt0U1UZT1wOfpnHzqjKJZ3vzkLgZzFDOjYdLYXIbkqlqMkd20KEFsiBkCEB9O28MVFSO48JXx+s0qKAf/EltYKEncemGc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 05:30:06.7958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a739239-ed2b-473c-56c2-08d6fde52da7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk framework APIs devm_clk_register and of_clk_add_provider, which
are used here, are deprecated. Replace the calls with the new API calls.
Also add an API call devm_clk_get() to get the clock from DT.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b12abf9..d60a2e8 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -641,14 +641,25 @@ static int sdhci_arasan_register_sdclk(struct sdhci_arasan_data *sdhci_arasan,
 	sdcardclk_init.ops = &arasan_sdcardclk_ops;
 
 	sdhci_arasan->sdcardclk_hw.init = &sdcardclk_init;
-	sdhci_arasan->sdcardclk =
-		devm_clk_register(dev, &sdhci_arasan->sdcardclk_hw);
+	ret = devm_clk_hw_register(dev, &sdhci_arasan->sdcardclk_hw);
+	if (ret) {
+		dev_err(dev, "Failed to register SD clk_hw\n");
+		return ret;
+	}
 	sdhci_arasan->sdcardclk_hw.init = NULL;
 
-	ret = of_clk_add_provider(np, of_clk_src_simple_get,
-				  sdhci_arasan->sdcardclk);
-	if (ret)
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get,
+				     &sdhci_arasan->sdcardclk_hw);
+	if (ret) {
 		dev_err(dev, "Failed to add clock provider\n");
+		return ret;
+	}
+
+	sdhci_arasan->sdcardclk = devm_clk_get(dev, "clk_sdcard");
+	if (IS_ERR(sdhci_arasan->sdcardclk)) {
+		dev_err(dev, "sdcardclk clock not found.\n");
+		ret = PTR_ERR(sdhci_arasan->sdcardclk);
+	}
 
 	return ret;
 }
-- 
2.1.1

