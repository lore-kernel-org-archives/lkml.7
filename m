Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6353CC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A974208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OjNy+9GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfGAFaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:30:10 -0400
Received: from mail-eopbgr780058.outbound.protection.outlook.com ([40.107.78.58]:8398
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbfGAFaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie1+wGn0PES2/NEMdUXGVrt+v4AbRb2I3CXm2bJOTvs=;
 b=OjNy+9GK8xHX59kjNnUb2jYUDnR7XGbQtdg0LNlszX1/XqgAu1PCF527+bZJh7p7OBS+fqOYI0KyEUW94hDzVBd2jyLdNT2RGgTSlwRE2RRc0I5fhDti4MuOwA90HD7+/9/Kmbu8r8hjKWm4ARbWvvKLZkLzUxWLGR2SI0+RdT0=
Received: from BL0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:207:3d::33)
 by DM6PR02MB5241.namprd02.prod.outlook.com (2603:10b6:5:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Mon, 1 Jul
 2019 05:30:07 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BL0PR02CA0056.outlook.office365.com
 (2603:10b6:207:3d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.20 via Frontend
 Transport; Mon, 1 Jul 2019 05:30:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 05:30:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35852 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhotB-0006Te-M4; Sun, 30 Jun 2019 22:30:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhot6-0003EO-Ie; Sun, 30 Jun 2019 22:30:00 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x615Tuah023632;
        Sun, 30 Jun 2019 22:29:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hhot2-0003Cd-4S; Sun, 30 Jun 2019 22:29:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 4D3BC12174A; Mon,  1 Jul 2019 10:59:54 +0530 (IST)
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
Subject: [PATCH v2 07/11] dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
Date:   Mon,  1 Jul 2019 10:59:47 +0530
Message-Id: <1561958991-21935-8-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(47776003)(8936002)(76176011)(26005)(336012)(5660300002)(51416003)(36756003)(70586007)(70206006)(186003)(356004)(6666004)(106002)(6266002)(7416002)(42186006)(16586007)(316002)(72206003)(44832011)(478600001)(48376002)(63266004)(36386004)(52956003)(2906002)(50466002)(103686004)(50226002)(305945005)(81166006)(81156014)(8676002)(4326008)(426003)(446003)(11346002)(2616005)(476003)(126002)(486006)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5241;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7612f162-5e4b-46ae-37f9-08d6fde52d36
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR02MB5241;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5241:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB52417F19BB9EF1186140D0EAC1F90@DM6PR02MB5241.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: iWTgQ5tZmByGckLlXyZ6JXq46iC/ZUxOtCJd6MCUggSaQZ6rALXY6qrhkQdWOi4Mya2F3dpEhhgcFls4E5FmoJ5nEUDPtUAusO1Yfbl7hPPkiUDW0bp4A0n0y4+8Tkp2zW0I8CoBj4QmPnSOSw9Xi9toSesusn04H4fksUTrsHDdz5FFJ9kqLBK5rmiRVCynvvui8akrqmcaGXAGCJwWJwy2Hw2M3qo0ENi4jXcO2j8sADN77zrr68OlyAhn4bb3Z1ohYXhmaefqTx3ffWwuXRj7HGCEiAbUuHmxtlo9WVpuwEPp8yB0FUEMwAV0rs34hdtfk7nyqwxLRcBsigbnJMhz4TnGjasxUapLGvki1URWbWxE35QpYAryU1CRegm1iUEMsNBpHcX747t2wZjb2tbwnz6vEYpvwXGEzZihihg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 05:30:06.0877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7612f162-5e4b-46ae-37f9-08d6fde52d36
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional propeties for Arasan SDHCI which are used to set clk delays
for different speed modes in the controller.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7c79496..7425d52 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -49,6 +49,21 @@ Optional Properties:
     properly. Test mode can be used to force the controller to function.
   - xlnx,int-clock-stable-broken: when present, the controller always reports
     that the internal clock is stable even when it is not.
+  - clk-phase-legacy: Input/Output Clock Delay pair in degrees for Legacy Mode.
+  - clk-phase-mmc-hs: Input/Output Clock Delay pair degrees for MMC HS.
+  - clk-phase-sd-hs: Input/Output Clock Delay pair in degrees for SD HS.
+  - clk-phase-uhs-sdr12: Input/Output Clock Delay pair in degrees for SDR12.
+  - clk-phase-uhs-sdr25: Input/Output Clock Delay pair in degrees for SDR25.
+  - clk-phase-uhs-sdr50: Input/Output Clock Delay pair in degrees for SDR50.
+  - clk-phase-uhs-sdr104: Input/Output Clock Delay pair in degrees for SDR104.
+  - clk-phase-uhs-ddr50: Input/Output Clock Delay pair in degrees for SD DDR50.
+  - clk-phase-mmc-ddr52: Input/Output Clock Delay pair in degrees for MMC DDR52.
+  - clk-phase-mmc-hs200: Input/Output Clock Delay pair in degrees for MMC HS200.
+  - clk-phase-mmc-hs400: Input/Output Clock Delay pair in degrees for MMC HS400.
+
+  Above mentioned are the clock (phase) delays which are to be configured in the
+  controller while switching to particular speed mode. If not specified, driver
+  will configure the default value defined for particular mode in it.
 
 Example:
 	sdhci@e0100000 {
-- 
2.1.1

