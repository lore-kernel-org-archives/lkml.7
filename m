Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3D02071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KulnQ5KP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfL3JD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:03:56 -0500
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:7171
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfL3JD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:03:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC5qAI7hejVIrgUeFHpsfczyQwspjaf+60+owUmFhbQl3eRVIlG908JVeXQUDKXcIzMF8RxkR56eFy4ktZuIVbvcKtefMDX6WCOL8du/SqshnB0LFehAeIx9E1JafB6f5Lp8CdA7dwFzWRdRShjXDc0SxC4JFeTekfcHs/X9oHK6AAcoFqrlXUJlTjiWq0bWeQt2wkRWnK3lrqED2bBzMQZJWbI171svt93xZdTcBspOew4uX4FMrlfmMs5QpAF2H6DuUVacl0R5ufNENCh9aedBEcPnt7+zlZNzA5yPjDbppA1woRzpGCSUn+zFG+mRu3IRqYqAmj9i2lVBuLQlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4L3MzR2o6uZGqxIakM7tPEhQ4hhMPBTbcxMQLFauVA=;
 b=LQWGJeRBa7gwFf6FYeZ/2ioHvcalq4aswmR07c2I3W91W/OzM4lQnUES/ju+MGUTrnI/+HOFNYuhSXpI0mjQhH5/Ewfnbvz74RtF1mLA256m6q8OnmyKSKFRv2nqNLfK8MTzCmhzhEWWke2kuTuRQkPI0ATRuWR6G3uGEuD0i4mCHlIGFAi+ghlLpMmDq9mobE1nOn25yblhG8xfOWw4sPuhoZaRpHzhN6rh0tUr7UWiF6VzYjheeZLD4WOQMu6aDXdJOfG2iQGXEkaMPO3mb6X67d9ojADLdVbTLO249y6kTnnoHSLvH6fpDDXisn6t3ewRlxH1o01+Brr8iHLXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4L3MzR2o6uZGqxIakM7tPEhQ4hhMPBTbcxMQLFauVA=;
 b=KulnQ5KPWLSsOLgCzEpgbyOX1hRW1j8IGxXMNeJoS/oDac5TTRNtNZ5MtGLO/C2RQM2f9A2XsxcAm26qmsOlytdPD6LnMvxDhWbEz4nswychFxo1032+SF2mUuoe8VFdyRULS0KdMWBnfJ6h+Y8noZY2HEetQsRoGlpO2c3eY3I=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5347.eurprd04.prod.outlook.com (20.178.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 09:03:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 09:03:51 +0000
Received: from localhost.localdomain (119.31.174.67) by HK2PR0401CA0002.apcprd04.prod.outlook.com (2603:1096:202:2::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2581.11 via Frontend Transport; Mon, 30 Dec 2019 09:03:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ARM: imx: use of_root to simplify code
Thread-Topic: [PATCH] ARM: imx: use of_root to simplify code
Thread-Index: AQHVvvAOkP5pfM/SI0ufVklMt6+Kwg==
Date:   Mon, 30 Dec 2019 09:03:51 +0000
Message-ID: <1577696316-27635-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0002.apcprd04.prod.outlook.com
 (2603:1096:202:2::12) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad0930dc-d534-4405-e1c2-08d78d07306a
x-ms-traffictypediagnostic: AM0PR04MB5347:|AM0PR04MB5347:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5347FE777C67F861F3AA7E2F88270@AM0PR04MB5347.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(189003)(199004)(86362001)(956004)(52116002)(6506007)(71200400001)(16526019)(66556008)(66476007)(26005)(6666004)(316002)(44832011)(81166006)(8676002)(186003)(64756008)(6486002)(2616005)(66446008)(8936002)(69590400006)(81156014)(66946007)(4326008)(36756003)(6512007)(2906002)(54906003)(110136005)(5660300002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5347;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQSlAbDFSehprei1uR8t5gyOWBVCbCXPWJF31OC03XGW+B+lagjTorfO6jh8u9gVurdxoVHnyG0uy8n8SOHeyuV29TwbAio9pT41HkPUBGcSburIELJlzdwLtlsC8+dr3gNfy3iNn+qxiEj3AtwB/GVc6p6AQrbw81xWdhwKH4S+8ywzilQ6Ju7u9nt9ImrR83ixmm0VWaSURYbG+uHFwPNNZ3Ibvcmh5ksL+K2eNpxccu50IMHBdEa27F9FwBDiLVPhvd4C4UdsFKsrHA/rfhAwe6L234JdKC+2SoMcEknRSCjQBRjo7/4MFYjKtezJCNectKEzLc9Il17PdmhhRPlb+HpBhM2E+/Ncg/n6+fsHePh5ZAbMC4D+eVApaKhpV8dtWqUI5N7P9SNdQ2IkhGIjEGFTkwnxsxSG2s7mTJBaurTl/bze+131YFeF1CfV6sdyH7nHY2PcScJ5DneBEfqk5Ui31iDjY4TnyYKjLKi/x7GnfPL3etuUWCVAh3Dd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0930dc-d534-4405-e1c2-08d78d07306a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 09:03:51.6420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lp/83E+mcCxrFlXylClC2byJgFPXDf6WAmWYy8McLt15PZqdgh0pWCWTW0yq4lq1Q5xurugpa6Y6rNVFrcl27A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5347
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

start_kernel
     |->setup_arch
     |       |->unflatten_device_tree->of_root ready
     |
     |->do_initcalls
           |->customize_machine
                       |->init_machine
                              |->imx_soc_device_init

When imx_soc_device_init, of_root is ready, so we could directly use it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Tested on i.MX7D-SDB

 arch/arm/mach-imx/cpu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 06f8d64b65af..77319b359070 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -88,7 +88,6 @@ struct device * __init imx_soc_device_init(void)
 	struct soc_device_attribute *soc_dev_attr;
 	const char *ocotp_compat =3D NULL;
 	struct soc_device *soc_dev;
-	struct device_node *root;
 	struct regmap *ocotp =3D NULL;
 	const char *soc_id;
 	u64 soc_uid =3D 0;
@@ -101,9 +100,7 @@ struct device * __init imx_soc_device_init(void)
=20
 	soc_dev_attr->family =3D "Freescale i.MX";
=20
-	root =3D of_find_node_by_path("/");
-	ret =3D of_property_read_string(root, "model", &soc_dev_attr->machine);
-	of_node_put(root);
+	ret =3D of_property_read_string(of_root, "model", &soc_dev_attr->machine)=
;
 	if (ret)
 		goto free_soc;
=20
--=20
2.16.4

