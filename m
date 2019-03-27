Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C06C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D9921734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ag2Nwhrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfC0NVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:22 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:29764
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730114AbfC0NVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnnvC8rrbllreco+SztEGDJRUJfZW3+oDSGTnyNzkbg=;
 b=Ag2NwhrfQYTotQRRC/5XIW3pnNkdksFiYh9UzG9vffDxvfBdkfu9F80CWsDtdukXUnnLPYj53fpzZnQZsp/YXbEsOAK5+5UCsFIfjgEtYKUgOE0preqBpBCIcVs3qPxB97tJnP2oIy9ETULGFSYb8O0Qt0ECv4CWyau35tWOSAI=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6051.eurprd04.prod.outlook.com (20.179.35.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 13:21:17 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:21:17 +0000
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
Subject: [RFC 6/7] cpuidle-arm: Add arm64 wake helper for cpu_poke op
Thread-Topic: [RFC 6/7] cpuidle-arm: Add arm64 wake helper for cpu_poke op
Thread-Index: AQHU5J/1bOMxExZCXkCLbXm+Qvy5kg==
Date:   Wed, 27 Mar 2019 13:21:16 +0000
Message-ID: <1553692845-20983-7-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5ba16ad8-f60f-45a4-0f71-08d6b2b71798
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6051;
x-ms-traffictypediagnostic: AM0PR04MB6051:
x-microsoft-antispam-prvs: <AM0PR04MB6051BA7A7B347670300259B7F6580@AM0PR04MB6051.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(25786009)(14444005)(68736007)(4326008)(6436002)(5660300002)(6116002)(71200400001)(71190400001)(3846002)(256004)(8936002)(8676002)(6636002)(2501003)(66066001)(305945005)(2906002)(53936002)(81156014)(6512007)(7736002)(81166006)(7416002)(97736004)(6486002)(36756003)(54906003)(44832011)(50226002)(486006)(106356001)(6506007)(386003)(186003)(110136005)(102836004)(446003)(14454004)(476003)(86362001)(99286004)(11346002)(52116002)(478600001)(316002)(2616005)(26005)(105586002)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6051;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eSXvAMa0U6xLbvi2tcE/ajWZzzIv0+K15d7D82d/6eLP4dGOoihiAWS5FwjDTob5LuJSTiFDg/4vFkQhGPPDEuW34dJS3z31HPCtCZJNLt8bQU2evFJllwD2ssHV2IiqhOGcJW6n6iqWMq+VJHoSIN0rXksPwpAGjqqmzjz05/KxY7855UNzpFnN1YHx91/oQ/wH1UYke+GN5klQgHMn4shU+3y52h5yIuQxqGIGKdKBsgp4BX9X9VHW0LwlA1JY/UADPwlORki1mrCz9gTQ8z0/eMlPiiIxfca1dlhSztUOXNtkP0eJuOWA8CV5kjm4lVU0RYxSLUDSAzfWFp+y2BzbTxTb2jsrK84P06Y9a281PEOEMtyC3r7y+LuK8v5ckMYJ3DyLgmV7+pP+ByZfRB4Y9UHKvT8oOTbx0gpOdLM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba16ad8-f60f-45a4-0f71-08d6b2b71798
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:21:16.9428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the arm_poke_idle_state gets called, the poking
cpu_ops of the current core gets called, passing on the
the index of the core to be poked.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/include/asm/cpuidle.h | 6 ++++++
 arch/arm64/kernel/cpuidle.c      | 8 ++++++++
 drivers/cpuidle/cpuidle-arm.c    | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpui=
dle.h
index 3c5ddb4..e637d4d 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -7,6 +7,7 @@
 #ifdef CONFIG_CPU_IDLE
 extern int arm_cpuidle_init(unsigned int cpu);
 extern int arm_cpuidle_suspend(int index);
+extern int arm_cpuidle_wake(int index);
 #else
 static inline int arm_cpuidle_init(unsigned int cpu)
 {
@@ -17,5 +18,10 @@ static inline int arm_cpuidle_suspend(int index)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int arm_cpuidle_wake(int index)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index f2d1381..af00955 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -43,6 +43,14 @@ int arm_cpuidle_suspend(int index)
 	return cpu_ops[cpu]->cpu_suspend(index);
 }
=20
+int arm_cpuidle_wake(int index)
+{
+	int cpu =3D smp_processor_id();
+
+	return cpu_ops[cpu]->cpu_poke(index);
+}
+
+
 #ifdef CONFIG_ACPI
=20
 #include <acpi/processor.h>
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 76ee7ac..d5d3eef 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -48,7 +48,7 @@ static int arm_enter_idle_state(struct cpuidle_device *de=
v,
 static int arm_poke_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int cpu)
 {
-	return 0;
+	return arm_cpuidle_wake(cpu);
 }
=20
 static struct cpuidle_driver arm_idle_driver __initdata =3D {
--=20
2.7.4

