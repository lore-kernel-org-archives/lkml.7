Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C93C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B64520663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Z6WIb6Kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfCFXQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:16:27 -0500
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:32096
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbfCFXQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkezuVihIiF/SGNm0FgndOUpv8T1hma6KrgXxfNDKJY=;
 b=Z6WIb6Kk36I6V5qeA7TZjbP8bA0ZzrH7vukDUzka/MHmAuyJ5Ul1+XpWsZPrTS6DhA5Sd/31CSM4Xt9El6bvLylLHPlZ2oQtiL9dVv8xTamuSqCPoUa2ZbEA3vqr9S/1zH0fe732zJtOWy2x/iJUHRjvkjmEkCyYLaYlG9MzMx0=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4592.eurprd02.prod.outlook.com (20.178.12.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 23:15:56 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 23:15:56 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
Subject: [PATCH v2 5/5] i2c: mux: pca9541: add support for PCA9641
Thread-Topic: [PATCH v2 5/5] i2c: mux: pca9541: add support for PCA9641
Thread-Index: AQHU1HKNjSK6x+/IzUatPrdqzggr/g==
Date:   Wed, 6 Mar 2019 23:15:56 +0000
Message-ID: <20190306231521.29367-6-peda@axentia.se>
References: <20190306231521.29367-1-peda@axentia.se>
In-Reply-To: <20190306231521.29367-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56759a6e-cab9-4598-af7b-08d6a289af8c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4592;
x-ms-traffictypediagnostic: VI1PR02MB4592:
x-microsoft-antispam-prvs: <VI1PR02MB45928396C4753E97FF7B5C34BC730@VI1PR02MB4592.eurprd02.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(136003)(39840400004)(189003)(199004)(5640700003)(53936002)(6486002)(71200400001)(6436002)(2501003)(71190400001)(99286004)(4326008)(6916009)(476003)(102836004)(76176011)(256004)(446003)(486006)(52116002)(3846002)(86362001)(386003)(74482002)(6506007)(6512007)(26005)(6116002)(97736004)(66066001)(305945005)(7736002)(2351001)(186003)(2616005)(14444005)(11346002)(25786009)(106356001)(36756003)(8936002)(8676002)(68736007)(81156014)(81166006)(5660300002)(508600001)(2906002)(54906003)(1076003)(50226002)(316002)(14454004)(105586002)(13158425004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4592;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR02MB4592;23:bHOiRmPX8rE7fkuHVGAnr9cwtTYvRywPgJ7WR0Y?=
 =?iso-8859-1?Q?+0aDezxTbAgbQjXBL0wMQCgaX3oHVEDzJ8AmaXbF+TA01p8LoucijVqUw4?=
 =?iso-8859-1?Q?LvSCk3RAUaP4cQ2bthaHH5kcV9fZLR5WYGEZ8yQBIxMrh4U34TiDto4jsi?=
 =?iso-8859-1?Q?g3tcfLqvdtI0B1MxsweT6JnvTs19lJ/FHv5JCxdrs/efA6s9Vb/YSbBb/2?=
 =?iso-8859-1?Q?XvOhUDawzFNkFyn1oHBfvl0QP1fFoQ4YdOvyPbGnnbqnWTE+uccC60qKDr?=
 =?iso-8859-1?Q?6XY/OKAiUGmIlcMubBTAl6H52siaxoR8FiOgc3o3ztIb4oAdW+SnNbSQmX?=
 =?iso-8859-1?Q?2zegIA2a9f+AMKGtVj00p0+bZ4kYLknGcH+SdwFOqGRH9sw54cf7C1wGYJ?=
 =?iso-8859-1?Q?xwP+kcpYiUzsMnMDNPa5OuD+nThk0xbkGg/bGWlqtDZSlFtSOzNGehzoCs?=
 =?iso-8859-1?Q?UIRV/IzYWyWDbRplEkZpRpwqL15KFlRm8Ifd5wa20eeqJTzOElykxp0uxy?=
 =?iso-8859-1?Q?m1Mw2kRN+xfrFD7Pjm+GIaALQmWv970ft5fMslO15B6HDvDSZfCrQ7+hZV?=
 =?iso-8859-1?Q?ZY2Wl7qb1RMLj9t37VyMLsNWMxHKK42z6MiOqiuXzoqzrIhigYyO5EkpkG?=
 =?iso-8859-1?Q?fFZu38FLrE3t609rRMvArJ8/PTXEdiLL/m9GbpnvVNVg9RCac4NRESaVSR?=
 =?iso-8859-1?Q?dxxA8DD5gSIbjtNMKPPmILts2vrGe3c1wJDn1Yk0z3WU861ZX2jvEGa2wy?=
 =?iso-8859-1?Q?EBuZ7zYgMgywsCmzU0wGNHQ5CB3DPjZeJcPK04olhNXQH3Ngg5JzMBZVrS?=
 =?iso-8859-1?Q?+lEtd7wNk/9fV8lGSUdxPsK3LwbIpt+k4CU2X6k36Qf7uMPtFRBXPUaBs9?=
 =?iso-8859-1?Q?eEyAio+zzwrUqPqKkwAU4ioBKVE2olPyiuhqMqoGMDur4eh5QBZXO4ciKl?=
 =?iso-8859-1?Q?sUOsis4jJQziPBraJJVc25bW4v9DABG8sjyAsD+Sh4AKrsTCPlOBdpv50/?=
 =?iso-8859-1?Q?SKUsRoCj0WCLPbGzpFR4oEfJ37c52n2QJIOqIWAU1OKRmnMevuoTEGR/R1?=
 =?iso-8859-1?Q?pJl9wRtPq9+45w0FUh0yH0sFU/6di2GrogqkIwuqzHamSxhTQKD9BEe70p?=
 =?iso-8859-1?Q?5gvjxAU9idKRjG3KbRyL9HsLtqu06+WpJdke4ugcJDs4eOC2Ib5ltUnz69?=
 =?iso-8859-1?Q?VCuxiwZoik/w1g2HknfHNOT6y3W9r7DTwiGssATcmX5os1z64UN/bwJ3/a?=
 =?iso-8859-1?Q?1F3cl6D6LBXt0yH7fb9Lj+Ydtl3dONnafmSAktBQ+xNlyz0PwQ2JZIcDB+?=
 =?iso-8859-1?Q?GKXIAPcHEVgDhp+dGKv3FdpQeBdQH3bMuBmlUd2BXu9cFvtNVfYIEy8kin?=
 =?iso-8859-1?Q?eJ3YaZU0cHqeru+KTWpL6kLeLiYsk?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ChFEKlijmToOAlVn5rSC5lQ23vfeWR5nyPDWa3As4cT66vcRI/27JNVs/lSD1vDwvwg998lHULJ3uMECTirBEVWdYsb2oLmxs1wlSF/gbxHdXS3O3QrZG7bqEQSLlwZMpaoq5QKU53KnXACchbz31J+d+zVZZbfuI2FcWKMjpV1KoW5vc+ygaNi91yj4IXdA/ZwUkVlqBC5slp8XpFXH9V8fqaWsQMw0lYpH0qhQz2dBOh24Ef9hlj8DVVdf/iom8LdG1laNXUwW8YLrMYtnsci82SvEF0BS3Cj7v/FGD6JdqOSN51SuEhnBvOBCeKwA5WFrouQDNUzLNIohOioOlQ2kpB8MzCnOwsFucxCFLbMH5B6TM07/Ob+PcmzRqFkpUNxXbBxA/hnpujRJ4rQ3m3U/BGkFvA4E3SW/PMRImbk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 56759a6e-cab9-4598-af7b-08d6a289af8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 23:15:56.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heavily based on code from Ken Chen <chen.kenyy@inventec.com>.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/Kconfig           |   6 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c | 137 ++++++++++++++++++++++++++++++++=
++--
 2 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 52a4a922e7e6..8532841de5db 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -55,10 +55,10 @@ config I2C_MUX_LTC4306
 	  will be called i2c-mux-ltc4306.
=20
 config I2C_MUX_PCA9541
-	tristate "NXP PCA9541 I2C Master Selector"
+	tristate "NXP PCA9541/PCA9641 I2C Master Selectors"
 	help
-	  If you say yes here you get support for the NXP PCA9541
-	  I2C Master Selector.
+	  If you say yes here you get support for the NXP PCA9541/PCA9641
+	  I2C Master Selectors.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-pca9541.
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mu=
x-pca9541.c
index 5eb36e3223d5..5d4e0c92e978 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -1,5 +1,5 @@
 /*
- * I2C multiplexer driver for PCA9541 bus master selector
+ * I2C multiplexer driver for PCA9541/PCA9641 bus master selectors
  *
  * Copyright (c) 2010 Ericsson AB.
  *
@@ -28,8 +28,8 @@
 #include <linux/slab.h>
=20
 /*
- * The PCA9541 is a bus master selector. It supports two I2C masters conne=
cted
- * to a single slave bus.
+ * The PCA9541 and PCA9641 are bus master selector. They support two I2C m=
asters
+ * connected to a single slave bus.
  *
  * Before each bus transaction, a master has to acquire bus ownership. Aft=
er the
  * transaction is complete, bus ownership has to be released. This fits we=
ll
@@ -63,6 +63,33 @@
 #define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
 #define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
=20
+#define PCA9641_ID			0x00
+#define PCA9641_ID_MAGIC		0x38
+
+#define PCA9641_CONTROL			0x01
+#define PCA9641_STATUS			0x02
+#define PCA9641_TIME			0x03
+
+#define PCA9641_CTL_LOCK_REQ		BIT(0)
+#define PCA9641_CTL_LOCK_GRANT		BIT(1)
+#define PCA9641_CTL_BUS_CONNECT		BIT(2)
+#define PCA9641_CTL_BUS_INIT		BIT(3)
+#define PCA9641_CTL_SMBUS_SWRST		BIT(4)
+#define PCA9641_CTL_IDLE_TIMER_DIS	BIT(5)
+#define PCA9641_CTL_SMBUS_DIS		BIT(6)
+#define PCA9641_CTL_PRIORITY		BIT(7)
+
+#define PCA9641_STS_OTHER_LOCK		BIT(0)
+#define PCA9641_STS_BUS_INIT_FAIL	BIT(1)
+#define PCA9641_STS_BUS_HUNG		BIT(2)
+#define PCA9641_STS_MBOX_EMPTY		BIT(3)
+#define PCA9641_STS_MBOX_FULL		BIT(4)
+#define PCA9641_STS_TEST_INT		BIT(5)
+#define PCA9641_STS_SCL_IO		BIT(6)
+#define PCA9641_STS_SDA_IO		BIT(7)
+
+#define PCA9641_RES_TIME		0x03
+
 /* arbitration timeouts, in jiffies */
 #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
 #define ARB2_TIMEOUT	(HZ / 4)	/* 250 ms until acquisition failure */
@@ -73,6 +100,7 @@
=20
 enum chip_name {
 	pca9541,
+	pca9641,
 };
=20
 struct chip_desc {
@@ -102,6 +130,21 @@ static bool pca9541_busoff(int ctl)
 	return (ctl & PCA9541_BUSON) =3D=3D PCA9541_BUSON;
 }
=20
+static bool pca9641_lock_grant(int ctl)
+{
+	return !!(ctl & PCA9641_CTL_LOCK_GRANT);
+}
+
+static bool pca9641_other_lock(int sts)
+{
+	return !!(sts & PCA9641_STS_OTHER_LOCK);
+}
+
+static bool pca9641_busoff(int ctl, int sts)
+{
+	return !pca9641_lock_grant(ctl) && !pca9641_other_lock(sts);
+}
+
 /*
  * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
  * as they will try to lock the adapter a second time.
@@ -256,6 +299,86 @@ static int pca9541_arbitrate(struct i2c_client *client=
)
 	return 0;
 }
=20
+/* Release bus. */
+static void pca9641_release_bus(struct i2c_client *client)
+{
+	pca9541_reg_write(client, PCA9641_CONTROL, 0);
+}
+
+/*
+ * Channel arbitration
+ *
+ * Return values:
+ *  <0: error
+ *  0 : bus not acquired
+ *  1 : bus acquired
+ */
+static int pca9641_arbitrate(struct i2c_client *client)
+{
+	struct i2c_mux_core *muxc =3D i2c_get_clientdata(client);
+	struct pca9541 *data =3D i2c_mux_priv(muxc);
+	int reg_ctl, reg_sts;
+
+	reg_ctl =3D pca9541_reg_read(client, PCA9641_CONTROL);
+	if (reg_ctl < 0)
+		return reg_ctl;
+	reg_sts =3D pca9541_reg_read(client, PCA9641_STATUS);
+
+	if (pca9641_busoff(reg_ctl, reg_sts)) {
+		/*
+		 * Bus is off. Request ownership or turn it on unless
+		 * other master requested ownership.
+		 */
+		reg_ctl |=3D PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+		reg_ctl =3D pca9541_reg_read(client, PCA9641_CONTROL);
+
+		if (pca9641_lock_grant(reg_ctl)) {
+			/*
+			 * Other master did not request ownership,
+			 * or arbitration timeout expired. Take the bus.
+			 */
+			reg_ctl |=3D PCA9641_CTL_BUS_CONNECT |
+				PCA9641_CTL_LOCK_REQ;
+			pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+			data->select_timeout =3D SELECT_DELAY_SHORT;
+
+			return 1;
+		}
+
+		/*
+		 * Other master requested ownership.
+		 * Set extra long timeout to give it time to acquire it.
+		 */
+		data->select_timeout =3D SELECT_DELAY_LONG * 2;
+
+		return 0;
+	}
+
+	if (pca9641_lock_grant(reg_ctl)) {
+		/*
+		 * Bus is on, and we own it. We are done with acquisition.
+		 */
+		reg_ctl |=3D PCA9641_CTL_BUS_CONNECT | PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+
+		return 1;
+	}
+
+	if (pca9641_other_lock(reg_sts)) {
+		/*
+		 * Other master owns the bus.
+		 * If arbitration timeout has expired, force ownership.
+		 * Otherwise request it.
+		 */
+		data->select_timeout =3D SELECT_DELAY_LONG;
+		reg_ctl |=3D PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+	}
+
+	return 0;
+}
+
 static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
 {
 	struct pca9541 *data =3D i2c_mux_priv(muxc);
@@ -295,10 +418,15 @@ static const struct chip_desc chips[] =3D {
 		.arbitrate =3D pca9541_arbitrate,
 		.release_bus =3D pca9541_release_bus,
 	},
+	[pca9641] =3D {
+		.arbitrate =3D pca9641_arbitrate,
+		.release_bus =3D pca9641_release_bus,
+	},
 };
=20
 static const struct i2c_device_id pca9541_id[] =3D {
 	{ "pca9541", pca9541 },
+	{ "pca9641", pca9641 },
 	{}
 };
=20
@@ -307,6 +435,7 @@ MODULE_DEVICE_TABLE(i2c, pca9541_id);
 #ifdef CONFIG_OF
 static const struct of_device_id pca9541_of_match[] =3D {
 	{ .compatible =3D "nxp,pca9541", .data =3D &chips[pca9541] },
+	{ .compatible =3D "nxp,pca9641", .data =3D &chips[pca9641] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pca9541_of_match);
@@ -392,5 +521,5 @@ static struct i2c_driver pca9541_driver =3D {
 module_i2c_driver(pca9541_driver);
=20
 MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
-MODULE_DESCRIPTION("PCA9541 I2C master selector driver");
+MODULE_DESCRIPTION("PCA9541/PCA9641 I2C master selector driver");
 MODULE_LICENSE("GPL v2");
--=20
2.11.0

