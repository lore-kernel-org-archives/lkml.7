Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC7FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906EC21734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lQHbIAXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfC0NVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:41 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:27108
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729924AbfC0NVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F10FU/nMBELMll6buxzdkIXlVxK85wRW3zUgJupC9Y=;
 b=lQHbIAXLjwEsMbk898r0shYoxQxw/1LaXT08YGpOonMAk2yb0yjmuS/q/zRE5GtlmTkjfRiJzXvM9bq2j/kOuHBgUd0nog7NZbkFsIXY+Yx4x8tpjQtkE2lGa/0GQqJXAHmTzy0pbpM4Plqam0EmOILTQddnX1dM75kgtkUyKnA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5907.eurprd04.prod.outlook.com (20.178.202.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 13:21:13 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:21:13 +0000
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
Subject: [RFC 4/7] psci: Add cpu_poke ops to support core poking
Thread-Topic: [RFC 4/7] psci: Add cpu_poke ops to support core poking
Thread-Index: AQHU5J/zprrbGAWi1k63FnonWZEQSg==
Date:   Wed, 27 Mar 2019 13:21:13 +0000
Message-ID: <1553692845-20983-5-git-send-email-abel.vesa@nxp.com>
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
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd29c57d-4a49-40a1-b67c-08d6b2b71594
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5907;
x-ms-traffictypediagnostic: AM0PR04MB5907:
x-microsoft-antispam-prvs: <AM0PR04MB5907B0E85A750833ED56B860F6580@AM0PR04MB5907.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(25786009)(2906002)(26005)(386003)(54906003)(8676002)(68736007)(102836004)(6512007)(71200400001)(7416002)(71190400001)(446003)(5660300002)(8936002)(50226002)(4326008)(81166006)(2616005)(476003)(81156014)(44832011)(97736004)(11346002)(6116002)(3846002)(36756003)(105586002)(86362001)(106356001)(2501003)(6486002)(76176011)(6636002)(14454004)(478600001)(6506007)(316002)(52116002)(7736002)(186003)(53936002)(110136005)(6346003)(66066001)(99286004)(14444005)(256004)(486006)(6436002)(305945005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5907;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gh5VASb52UD4ucQoargW+Pj/M13yvK8y5tsNhjebMg1lP3FXxSLA8rfN3zoOV7LXV4d36KwR0oOSI3g2G5BsZwkouZ/+mIN/m6FzTaFJrLEMvzL79r9lFRAzwiP9ytO2lMqf6SntFsgsbBK4CWJXGIktpoOrQVigR2xm/i2AlM7An1z/1HRU91zG6t9aEoRB6lpW7lb6JkD3EE35xYuqtNUDldyh1y0/ABa/x7qhwJSDiV77QUNgS3X1+0/SzGsZeCtacqFy90YDXBWvBLt3PsJiIpHdUSMrAerqvMPjy3ZoczCsnnAS00MLV858kMP15IwpEMtM4GPtZWIJAyvv5sHzv9dkC6etHDPSMpxOuniHFpmvkMjpAIgvqwnldGBVfflkbmv9JOwprS2iPghzjOxIV2ohG2VVv8KcBlgPk0k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd29c57d-4a49-40a1-b67c-08d6b2b71594
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:21:13.2882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be platforms that need a dedicated work to be done
in TF-A before the specified core can be woken up through an IPI.
Allow those platforms to call into the TF-A to do that work
by making use of the cpu_poke operation.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/include/asm/cpu_ops.h | 1 +
 arch/arm64/kernel/psci.c         | 1 +
 drivers/firmware/psci.c          | 6 ++++++
 include/linux/psci.h             | 1 +
 include/uapi/linux/psci.h        | 2 ++
 5 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_=
ops.h
index 8f03446..913afef 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -60,6 +60,7 @@ struct cpu_operations {
 #ifdef CONFIG_CPU_IDLE
 	int		(*cpu_init_idle)(unsigned int);
 	int		(*cpu_suspend)(unsigned long);
+	int		(*cpu_poke)(unsigned int);
 #endif
 };
=20
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 8cdaf25..53227eb 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -115,6 +115,7 @@ const struct cpu_operations cpu_psci_ops =3D {
 #ifdef CONFIG_CPU_IDLE
 	.cpu_init_idle	=3D psci_cpu_init_idle,
 	.cpu_suspend	=3D psci_cpu_suspend_enter,
+	.cpu_poke	=3D psci_cpu_suspend_exit,
 #endif
 	.cpu_init	=3D cpu_psci_cpu_init,
 	.cpu_prepare	=3D cpu_psci_cpu_prepare,
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d..282bc47 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -73,6 +73,7 @@ enum psci_function {
 	PSCI_FN_CPU_ON,
 	PSCI_FN_CPU_OFF,
 	PSCI_FN_MIGRATE,
+	PSCI_FN_CPU_POKE,
 	PSCI_FN_MAX,
 };
=20
@@ -424,6 +425,11 @@ int psci_cpu_suspend_enter(unsigned long index)
 	return ret;
 }
=20
+int psci_cpu_suspend_exit(unsigned int index)
+{
+	return invoke_psci_fn(PSCI_0_2_FN_CPU_POKE, index, 0, 0);
+}
+
 /* ARM specific CPU idle operations */
 #ifdef CONFIG_ARM
 static const struct cpuidle_ops psci_cpuidle_ops __initconst =3D {
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 8b1b3b5..d863733 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -24,6 +24,7 @@ bool psci_tos_resident_on(int cpu);
=20
 int psci_cpu_init_idle(unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
+int psci_cpu_suspend_exit(unsigned int index);
=20
 enum psci_conduit {
 	PSCI_CONDUIT_NONE,
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index b3bcabe..19e7481 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -40,8 +40,10 @@
 #define PSCI_0_2_FN_MIGRATE_INFO_UP_CPU		PSCI_0_2_FN(7)
 #define PSCI_0_2_FN_SYSTEM_OFF			PSCI_0_2_FN(8)
 #define PSCI_0_2_FN_SYSTEM_RESET		PSCI_0_2_FN(9)
+#define PSCI_0_2_FN_CPU_POKE			PSCI_0_2_FN(11)
=20
 #define PSCI_0_2_FN64_CPU_SUSPEND		PSCI_0_2_FN64(1)
+#define PSCI_0_2_FN64_CPU_POKE			PSCI_0_2_FN64(11)
 #define PSCI_0_2_FN64_CPU_ON			PSCI_0_2_FN64(3)
 #define PSCI_0_2_FN64_AFFINITY_INFO		PSCI_0_2_FN64(4)
 #define PSCI_0_2_FN64_MIGRATE			PSCI_0_2_FN64(5)
--=20
2.7.4

