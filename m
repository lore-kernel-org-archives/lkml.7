Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D4E20828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8Pt/S4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfCYDxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:53:46 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:45901
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729380AbfCYDxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP5ge8NN8QWOJ7XbY5/o9OSG0UZq+WdWiKRaPAoSm9g=;
 b=Z8Pt/S4aUPxfGdOpEs0SwPF7EjkAiXiGwtC5MWWaaBMIk0hy1lnHHHhb+KYSNONeVZRRcHLPk1SeguauH8Z4jDCZGBVExVa4KXm0NtZNm4CzSI9TIQjcV/j5+HfXyNWcYhJynEyZME9YuU4UHaW1PRnnQ28ADyN5YIuG7FU25eE=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB5711.eurprd04.prod.outlook.com (20.178.126.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 03:53:42 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 03:53:41 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: [patch v14 3/4] irqchip/qeic: merge qeic_of_init into qe_ic_init
Thread-Topic: [patch v14 3/4] irqchip/qeic: merge qeic_of_init into qe_ic_init
Thread-Index: AQHU4r5WlKmoIST/HUu8zhs5mf2kHg==
Date:   Mon, 25 Mar 2019 03:53:41 +0000
Message-ID: <20190325035418.19065-4-qiang.zhao@nxp.com>
References: <20190325035418.19065-1-qiang.zhao@nxp.com>
In-Reply-To: <20190325035418.19065-1-qiang.zhao@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To VI1PR04MB3247.eurprd04.prod.outlook.com
 (2603:10a6:802:11::32)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae200435-1966-45e6-fedc-08d6b0d57886
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5711;
x-ms-traffictypediagnostic: VI1PR04MB5711:
x-microsoft-antispam-prvs: <VI1PR04MB5711CA216637C01B84CEC850915E0@VI1PR04MB5711.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(478600001)(2906002)(44832011)(1076003)(53936002)(66066001)(2201001)(256004)(50226002)(81166006)(2501003)(106356001)(316002)(305945005)(7736002)(186003)(8676002)(105586002)(71200400001)(86362001)(26005)(97736004)(486006)(3846002)(76176011)(110136005)(54906003)(11346002)(71190400001)(25786009)(81156014)(5660300002)(8936002)(386003)(6506007)(6116002)(476003)(4326008)(6486002)(6512007)(99286004)(6436002)(446003)(2616005)(68736007)(14454004)(36756003)(102836004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5711;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JMMfvRvutTNfW9NEfUUyCoDrattihP1kryCi0WMH6MVAyWq0OiaaJd8OtzSonRWdquNDxxI4VydVDsMGiGXB6f3AsI9vNpb61CWxPvRBI2BHM0xnKthj8vHKHfguIp4LUXb9z9V2ANlB15u+1ww/fOq3P/4FoDHGepog0QKIHGheqnj/dAB0/Qjgejp4wVJl6F1m5GKvl/lfV4+R6It8dNxMUdMH7jN3+Hrap90wGENo3YGjXbXg2zcFKkgoPl6kscRYO21LVTdeksbkEnWf8Pm+o5P9004IQh8KiPwdoxSYOyldtW2FaLiwrJo700Wv0FUFkc6agCvCWc6xiqTipE+1Fg9oEhEbdJpZLM2P2DcfZlnoyOrydEqiYY0xjVPJcrQ9cKheSaDqNq9H3B0VycgzTldqUDNcjwYBXVgNS4M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae200435-1966-45e6-fedc-08d6b0d57886
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 03:53:41.8551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qeic_of_init just get device_node of qeic from dtb and call qe_ic_init,
pass the device_node to qe_ic_init.
So merge qeic_of_init into qe_ic_init to get the qeic node in
qe_ic_init.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/irqchip/irq-qeic.c |  110 ++++++++++++----------------------------=
----
 include/soc/fsl/qe/qe_ic.h |    7 ---
 2 files changed, 30 insertions(+), 87 deletions(-)

diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
index 673afb4..a6ccbfb 100644
--- a/drivers/irqchip/irq-qeic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -407,27 +407,30 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
=20
-void __init qe_ic_init(struct device_node *node, unsigned int flags,
-		       void (*low_handler)(struct irq_desc *desc),
-		       void (*high_handler)(struct irq_desc *desc))
+static int __init qe_ic_init(struct device_node *node,
+			     struct device_node *parent)
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp =3D 0, ret, high_active =3D 0;
+	int ret =3D 0;
=20
 	ret =3D of_address_to_resource(node, 0, &res);
-	if (ret)
-		return;
+	if (ret) {
+		ret =3D -ENODEV;
+		goto err_put_node;
+	}
=20
 	qe_ic =3D kzalloc(sizeof(*qe_ic), GFP_KERNEL);
-	if (qe_ic =3D=3D NULL)
-		return;
+	if (qe_ic =3D=3D NULL) {
+		ret =3D -ENOMEM;
+		goto err_put_node;
+	}
=20
 	qe_ic->irqhost =3D irq_domain_add_linear(node, NR_QE_IC_INTS,
 					       &qe_ic_host_ops, qe_ic);
 	if (qe_ic->irqhost =3D=3D NULL) {
-		kfree(qe_ic);
-		return;
+		ret =3D -ENOMEM;
+		goto err_free_qe_ic;
 	}
=20
 	qe_ic->regs =3D ioremap(res.start, resource_size(&res));
@@ -438,42 +441,30 @@ void __init qe_ic_init(struct device_node *node, unsi=
gned int flags,
 	qe_ic->virq_low =3D irq_of_parse_and_map(node, 1);
=20
 	if (qe_ic->virq_low =3D=3D NO_IRQ) {
-		printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
-		kfree(qe_ic);
-		return;
-	}
-
-	/* default priority scheme is grouped. If spread mode is    */
-	/* required, configure cicr accordingly.                    */
-	if (flags & QE_IC_SPREADMODE_GRP_W)
-		temp |=3D CICR_GWCC;
-	if (flags & QE_IC_SPREADMODE_GRP_X)
-		temp |=3D CICR_GXCC;
-	if (flags & QE_IC_SPREADMODE_GRP_Y)
-		temp |=3D CICR_GYCC;
-	if (flags & QE_IC_SPREADMODE_GRP_Z)
-		temp |=3D CICR_GZCC;
-	if (flags & QE_IC_SPREADMODE_GRP_RISCA)
-		temp |=3D CICR_GRTA;
-	if (flags & QE_IC_SPREADMODE_GRP_RISCB)
-		temp |=3D CICR_GRTB;
-
-	/* choose destination signal for highest priority interrupt */
-	if (flags & QE_IC_HIGH_SIGNAL) {
-		temp |=3D (SIGNAL_HIGH << CICR_HPIT_SHIFT);
-		high_active =3D 1;
+		pr_err("Failed to map QE_IC low IRQ\n");
+		ret =3D -ENOMEM;
+		goto err_domain_remove;
 	}
=20
-	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
-
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
-	irq_set_chained_handler(qe_ic->virq_low, low_handler);
+	irq_set_chained_handler(qe_ic->virq_low, qe_ic_cascade_low_mpic);
=20
 	if (qe_ic->virq_high !=3D NO_IRQ &&
 			qe_ic->virq_high !=3D qe_ic->virq_low) {
 		irq_set_handler_data(qe_ic->virq_high, qe_ic);
-		irq_set_chained_handler(qe_ic->virq_high, high_handler);
+		irq_set_chained_handler(qe_ic->virq_high,
+					qe_ic_cascade_high_mpic);
 	}
+	of_node_put(node);
+	return 0;
+
+err_domain_remove:
+	irq_domain_remove(qe_ic->irqhost);
+err_free_qe_ic:
+	kfree(qe_ic);
+err_put_node:
+	of_node_put(node);
+	return ret;
 }
=20
 void qe_ic_set_highest_priority(unsigned int virq, int high)
@@ -570,45 +561,4 @@ int qe_ic_set_high_priority(unsigned int virq, unsigne=
d int priority, int high)
 	return 0;
 }
=20
-static struct bus_type qe_ic_subsys =3D {
-	.name =3D "qe_ic",
-	.dev_name =3D "qe_ic",
-};
-
-static struct device device_qe_ic =3D {
-	.id =3D 0,
-	.bus =3D &qe_ic_subsys,
-};
-
-static int __init init_qe_ic_sysfs(void)
-{
-	int rc;
-
-	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
-
-	rc =3D subsys_system_register(&qe_ic_subsys, NULL);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys class\n");
-		return -ENODEV;
-	}
-	rc =3D device_register(&device_qe_ic);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys device\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static int __init qeic_of_init(struct device_node *node,
-			       struct device_node *parent)
-{
-	if (!node)
-		return -ENODEV;
-	qe_ic_init(node, 0, qe_ic_cascade_low_mpic,
-		   qe_ic_cascade_high_mpic);
-	of_node_put(node);
-	return 0;
-}
-
-IRQCHIP_DECLARE(qeic, "fsl,qe-ic", qeic_of_init);
-subsys_initcall(init_qe_ic_sysfs);
+IRQCHIP_DECLARE(qeic, "fsl,qe-ic", qe_ic_init);
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 1e155ca..6113699 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -58,16 +58,9 @@ enum qe_ic_grp_id {
 };
=20
 #ifdef CONFIG_QUICC_ENGINE
-void qe_ic_init(struct device_node *node, unsigned int flags,
-		void (*low_handler)(struct irq_desc *desc),
-		void (*high_handler)(struct irq_desc *desc));
 unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
 unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
 #else
-static inline void qe_ic_init(struct device_node *node, unsigned int flags=
,
-		void (*low_handler)(struct irq_desc *desc),
-		void (*high_handler)(struct irq_desc *desc))
-{}
 static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 { return 0; }
 static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
--=20
1.7.1

