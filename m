Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F557C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7B217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F0FPr0vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfC0NVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:48 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:29764
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfC0NVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJoxWhmCyb3/U5EQiMFlg+3tnG1hrEoxJr+Q2jp8qb4=;
 b=F0FPr0vgVEoD406wyJs3lSN4FABwuOgxpn2IacEjm5eAAfLdvGLQQ6dTZs9mSppKTbFjP7ZIi3rYb+CXJhxCFkKX7LCcLx6UTzCS58ldIbwI5NFheKK3XOT2I9voyEFLxXw70diiVj6kcPRezU6YQu0jbKJay92Dsca/BIlzLFE=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6051.eurprd04.prod.outlook.com (20.179.35.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 13:21:10 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 13:21:09 +0000
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
Subject: [RFC 2/7] cpuidle: Add cpu poke support
Thread-Topic: [RFC 2/7] cpuidle: Add cpu poke support
Thread-Index: AQHU5J/xpRRIW2AJek+3mcOjLL/sJg==
Date:   Wed, 27 Mar 2019 13:21:09 +0000
Message-ID: <1553692845-20983-3-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3ab53a77-04b0-4d0c-da77-08d6b2b7138d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6051;
x-ms-traffictypediagnostic: AM0PR04MB6051:
x-microsoft-antispam-prvs: <AM0PR04MB6051D251911006D51B670105F6580@AM0PR04MB6051.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(25786009)(14444005)(68736007)(4326008)(6436002)(5660300002)(6116002)(71200400001)(71190400001)(3846002)(256004)(8936002)(8676002)(6636002)(2501003)(66066001)(305945005)(2906002)(53936002)(81156014)(6512007)(7736002)(81166006)(7416002)(97736004)(6486002)(36756003)(54906003)(44832011)(50226002)(486006)(106356001)(6506007)(386003)(186003)(110136005)(102836004)(446003)(14454004)(476003)(86362001)(99286004)(11346002)(52116002)(478600001)(316002)(2616005)(26005)(105586002)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6051;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TWH2+42YzTL6r44EZTcRdorG9+5Np9ttK6YSpIXGF/hrUeQvdfNgtu7oZUyCeQWDbW7dWBaqqOChfu+Hq0Klo9+F5IaA9IyoPzS/8eRFdmwo0QrjFSLcC8MynB7byLhB4w5gk2L4WMzw0mw8w+QCQ+O1f3utBRcRocvv0F6QQ5S3scocSOrvk/mEWuDxolBgfsLMRA5iI5LE4bug1qU3FgC6LTTkmDaZlX/cuIcTIvtGBoKDDX4bhzd8SIYBil/lTrpW7Sr+q8dH+fAG548PXvli26DFVu5vwTJaim6lnrgH6+sKwgyeN/tGFtYDIsXfkGDxZjhF9sI+0hYQPXtahAFb175eXZLSGX0YVuSt/rAZW4OA53rtfnffJwj8U0PHyJP4216wsMYLrZR/p7AFLWnNEGvXsyUhgEFXDkTphZ4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab53a77-04b0-4d0c-da77-08d6b2b7138d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 13:21:09.9348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a poke operation per state, allows each cpuidle driver to
implement, for each state, different ways of waking up (poking) cores.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/cpuidle/cpuidle.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h   |  6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f10830..fca5313 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -297,6 +297,29 @@ int cpuidle_enter_state(struct cpuidle_device *dev, st=
ruct cpuidle_driver *drv,
 }
=20
 /**
+ * cpuidle_poke_single - poke the specified cpu to wake up from
+ *		         current idle state
+ *
+ * @dev: cpuidle device for this cpu
+ * @drv: cpuidle driver for this cpu
+ * @cpu: the index of the cpu
+ */
+int cpuidle_poke_single(struct cpuidle_driver *drv, struct cpuidle_device =
*dev,
+			int cpu)
+{
+	struct cpuidle_state *state;
+
+	if (cpuidle_disabled())
+		return 0;
+
+	state =3D sched_idle_get_state(cpu);
+	if (state && state->poke)
+		return state->poke(dev, drv, cpu);
+
+	return 0;
+}
+
+/**
  * cpuidle_select - ask the cpuidle framework to choose an idle state
  *
  * @drv: the cpuidle driver
@@ -414,6 +437,17 @@ void cpuidle_resume(void)
 	mutex_unlock(&cpuidle_lock);
 }
=20
+void cpuidle_poke(const struct cpumask *mask)
+{
+	struct cpuidle_device *dev =3D cpuidle_get_device();
+	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		WARN_ON(cpuidle_poke_single(drv, dev, cpu));
+	}
+}
+
 /**
  * cpuidle_enable_device - enables idle PM for a CPU
  * @dev: the CPU
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 88a9119..0270771 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -55,6 +55,10 @@ struct cpuidle_state {
 			struct cpuidle_driver *drv,
 			int index);
=20
+	int (*poke)	(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int cpu);
+
 	int (*enter_dead) (struct cpuidle_device *dev, int index);
=20
 	/*
@@ -145,6 +149,7 @@ extern void cpuidle_unregister(struct cpuidle_driver *d=
rv);
 extern void cpuidle_pause_and_lock(void);
 extern void cpuidle_resume_and_unlock(void);
 extern void cpuidle_pause(void);
+extern void cpuidle_poke(const struct cpumask *mask);
 extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
@@ -181,6 +186,7 @@ static inline void cpuidle_unregister(struct cpuidle_dr=
iver *drv) { }
 static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline void cpuidle_pause(void) { }
+static inline void cpuidle_poke(const struct cpumask *mask) { }
 static inline void cpuidle_resume(void) { }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
 {return -ENODEV; }
--=20
2.7.4

