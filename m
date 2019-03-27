Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10129C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86842146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bHBgFCWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfC0NV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:26 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:29764
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730179AbfC0NVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chzbau7PQniR3EdZFc5CRKQhYLFO8FHL1edsCSZByYQ=;
 b=bHBgFCWCuIE75sQYOIo8cpf8auZZVD8kQjRH1XXC/Vwa9tG9o6eLCQkjmi5u2YqWzWK/GfuV3KdXtkQrzYCTCcMv/At/YVy+/RxOl3Jr3LF+ewPrVey1v5D4tt/KMPvueqtFh4IhVfHCHoRTwq7qRZbpdqIbhElUwpe5qeo+h/8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6051.eurprd04.prod.outlook.com (20.179.35.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 13:21:18 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:21:18 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 7/7] arm64: dts: imx8mq: Add cpu-sleep state with poke wake-up
 enabled
Thread-Topic: [RFC 7/7] arm64: dts: imx8mq: Add cpu-sleep state with poke
 wake-up enabled
Thread-Index: AQHU5J/2q/iaUo72jkeAq5bzHgxofw==
Date:   Wed, 27 Mar 2019 13:21:18 +0000
Message-ID: <1553692845-20983-8-git-send-email-abel.vesa@nxp.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0038.eurprd07.prod.outlook.com
 (2603:10a6:800:90::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 485101a1-9101-46ce-d4e1-08d6b2b718bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6051;
x-ms-traffictypediagnostic: AM0PR04MB6051:
x-microsoft-antispam-prvs: <AM0PR04MB6051EA2EAC598F1DD2872FC0F6580@AM0PR04MB6051.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(25786009)(14444005)(68736007)(4326008)(6436002)(5660300002)(6116002)(71200400001)(71190400001)(3846002)(256004)(8936002)(8676002)(6636002)(2501003)(66066001)(305945005)(2906002)(53936002)(81156014)(6512007)(7736002)(81166006)(7416002)(97736004)(6486002)(36756003)(54906003)(44832011)(50226002)(486006)(106356001)(6506007)(386003)(186003)(110136005)(102836004)(446003)(14454004)(476003)(86362001)(99286004)(11346002)(52116002)(478600001)(316002)(2616005)(26005)(105586002)(76176011)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6051;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ID2ZJyjZo9PTVXPQW4fabxhcOhw3pmNuS0nO58cxyR9zuhf0jCZ865NAHs4S13YzBvq+vvV71PF95FGrOpkYRXfSdyUFt8rjvHpNOM2QzpruQtObJqmlHV+h1ZYs/OU5WjBw2++96VHrqMZMyDvGGu6k4TD4xV8a/+ZP4OQ6eGbmsN6JoleckDS4PA/7+EOEeZLTHQs4gN8rUtUaF9/NtmXZ2eUXMjrbODP+agBt0KeV0ioXt6kMsF95KxJv4YXbXhMZzabcftlwmCutcm0Qe7rZN8bM5aOAOfLrp+hQ+yskvnwWvDtMZKbZw+2Sz0FHV2REQECKTekF3BWDBsoRYGzaWJmkzS14knUTFZ5WCAOQ+WLnuqb3ttBcVYPgjj4y5j5xsd1TE4cOrFK4MNF748uqSpB4sSrro0stGHICLeQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485101a1-9101-46ce-d4e1-08d6b2b718bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:21:18.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the idle state cpu-sleep to each core. This idle state
makes use of 'local-wakeup-poke' property which basically tells
the cpuidle-arm driver to enable the poking for this state.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 230f198..8b7303d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -84,6 +84,22 @@
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
=20
+		idle-states {
+			entry-method =3D "psci";
+
+			CPU_SLEEP: cpu-sleep {
+				compatible =3D "arm,idle-state";
+				arm,psci-suspend-param =3D <0x0010033>;
+				local-timer-stop;
+				local-wakeup-poke;
+				entry-latency-us =3D <1000>;
+				exit-latency-us =3D <700>;
+				min-residency-us =3D <2700>;
+				wakeup-latency-us =3D <1500>;
+			};
+		};
+
+
 		A53_0: cpu@0 {
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
@@ -94,6 +110,7 @@
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			cpu-idle-states =3D <&CPU_SLEEP>;
 		};
=20
 		A53_1: cpu@1 {
@@ -106,6 +123,7 @@
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			cpu-idle-states =3D <&CPU_SLEEP>;
 		};
=20
 		A53_2: cpu@2 {
@@ -118,6 +136,7 @@
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			cpu-idle-states =3D <&CPU_SLEEP>;
 		};
=20
 		A53_3: cpu@3 {
@@ -130,6 +149,7 @@
 			next-level-cache =3D <&A53_L2>;
 			operating-points-v2 =3D <&a53_opp_table>;
 			#cooling-cells =3D <2>;
+			cpu-idle-states =3D <&CPU_SLEEP>;
 		};
=20
 		A53_L2: l2-cache0 {
--=20
2.7.4

