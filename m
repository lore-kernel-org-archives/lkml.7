Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD527C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4D020684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eYOmT2qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfCFBGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:06:50 -0500
Received: from mail-eopbgr30054.outbound.protection.outlook.com ([40.107.3.54]:6366
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfCFBGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROgUXJYN0cLDnCabertgAXqrrpgKNFEmbnEQ1X5+Yjo=;
 b=eYOmT2qIcfmJMDoCSA4i2LHMrwm88WYetG5i2Z089TagLPZciX10BicefqyeRAcJKIU3z237jyGQizeaKouX+B79NUVmCWyDamoGPvsAWnOiCS9MYxoOt1AL58rYDId6E0n9AHuRn1Fpy+V4qtq+Leff0Pes1drcjLkGWUDjXNM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3723.eurprd04.prod.outlook.com (52.134.72.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Wed, 6 Mar 2019 01:06:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 01:06:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 3/3] firmware: imx: imx-scu: register build-in child
 devices
Thread-Topic: [PATCH V7 3/3] firmware: imx: imx-scu: register build-in child
 devices
Thread-Index: AQHU07jXrMvH/zwkr0CO9FJmEedWMA==
Date:   Wed, 6 Mar 2019 01:06:33 +0000
Message-ID: <1551834095-19950-3-git-send-email-Anson.Huang@nxp.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d467cbe-3765-4d8e-3e0c-08d6a1cff924
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3723;
x-ms-traffictypediagnostic: DB3PR0402MB3723:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3723;23:i30aCKepLxGgMkGtmEEyvjOEsObIqxFbfdvp9?=
 =?iso-8859-1?Q?HfNJA/zy1xXnnhS4hMvBCIEhPZeUNrFjPaeNGBxbny+Ao74wF0/KibnrbG?=
 =?iso-8859-1?Q?YpAsmI9MW6NO18bNBJ2hz04QYBti/eSAft0bhnQUX6OLcPnHVBofnc2ygu?=
 =?iso-8859-1?Q?1I1NnCeogBUzQteUvRM79aejMHORG8TenlF/evLyeMSeukq8FdfD5FruR/?=
 =?iso-8859-1?Q?0HAnJfN6nG26QJdZ0Qj+qcFwQFB+BVyeaQ2hbZEAXtn4tIejs5yS53N52A?=
 =?iso-8859-1?Q?6zB6/WlMGuDNp3Ohul3jnpTeT8VfdIM+TzYxkJapeNvp33PND2p1wNRCBi?=
 =?iso-8859-1?Q?OzLCMidQwvYT7DoHczw0qz84IZ4Gc02YL+++c5nWp1oCXR+GILrYaqPYoA?=
 =?iso-8859-1?Q?VyWziGbcw7N0CBgL5UU54rjUR14vBH1TKDc1iYC2ZkKaYSz6B0YkcVh2pk?=
 =?iso-8859-1?Q?g25mBc2vOhGEX2UmpGBpOnw/Eg6pSNvjq0nf18u85IS75duSwO7HVKclNN?=
 =?iso-8859-1?Q?h9y3iAdCypJnJsB4z2SrF0zOQSmk2ZAUB+X/TNJvuKO2W43c0eLOIZIK+v?=
 =?iso-8859-1?Q?YM3S7iDqLFjm8AyQjLEFaR1Fn81GD1pHVAcIqYbsMO1QOuWO1LuApeUzu5?=
 =?iso-8859-1?Q?aniKlX1tzq26IH2HOcY1HMPk7jztTgxPPVP/zOPGtIwHeox4lfuitp1Lwg?=
 =?iso-8859-1?Q?/eGgn7yganVBcM7hXQf4OvHxWm8n5C4xxqgI5s+ib5IZjKL9vD1FnXrrwf?=
 =?iso-8859-1?Q?oNBUzAfj/5hiTy48PiXdyO5UbF2z1vD3VwRLBiXMpNXTuLVcwZyjiYeAYJ?=
 =?iso-8859-1?Q?iOtiAyl8q7jMEJrBT4jXpjNbmmFxFCRJqnE+y+tPEirm0Jm0rBYdc3BQ36?=
 =?iso-8859-1?Q?oyUzkWwDlX49mJ2Ez/qbTUXoQXW3RgnIH6HArV7W/tDN6UaDNf1hjG8oEd?=
 =?iso-8859-1?Q?tLZNyzCUpGMdhy3L9tT56UIJeHSI3nrU4mGZymEX6wXyatpzUMBc738D+g?=
 =?iso-8859-1?Q?9IPuqSIVg675iTZPBH81fA+Ldvlp8KI611GpfWQWXCp/vMNKu+RxQUmGMl?=
 =?iso-8859-1?Q?pNvH6WwwrkmUc4qJS/Iq4/WM7Mm4j+E2usCXDrEqg/BSngfnpN/wUgbpdW?=
 =?iso-8859-1?Q?uXKsbfrJttck2IUYH2DDOZEfqSaFnaR6KiU63B2HzPR0tYVACHbgmVhamE?=
 =?iso-8859-1?Q?kF8XtpSX9rMkqR2XdGyLKspUxwn/xfvv8rog9HJHbiwG0toMBKP5ZMttaU?=
 =?iso-8859-1?Q?LgakuAlCmn0kIPIbhfGZCYvDPAFbW/bnir0Eqs3gO7w/w7aC0qPiYlxl/F?=
 =?iso-8859-1?Q?pX9s=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB372324099A97FF03652A6731F5730@DB3PR0402MB3723.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(36756003)(68736007)(71190400001)(71200400001)(86362001)(256004)(2906002)(110136005)(316002)(105586002)(106356001)(6436002)(2501003)(6512007)(7736002)(305945005)(2201001)(6486002)(53936002)(478600001)(8936002)(7416002)(476003)(2616005)(486006)(11346002)(4326008)(14454004)(81156014)(5660300002)(3846002)(6116002)(25786009)(81166006)(8676002)(50226002)(52116002)(6506007)(99286004)(386003)(26005)(66066001)(76176011)(446003)(102836004)(97736004)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3723;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jg7Qf2Dy5bVupHRtE/0Ysq3WzjJ/hXqiPFjAc7U5sdHrVFvBqliAzRyyNRaQykVQC1truHNp2n9VLIC4+MNshfDHX8MnDTLZeUklNidBpVEtjykqZ96e+lK6E4c6SUkzOFet7s1Zxnray4K5kUHOPj5rd17jFdHWL87rVMUx4fCVmZ20jAqLbWGFw+PWsXaPNzSfz7tZVE4yq0zfRa+odMz1gNOKCFL/s45A5ju46ZqYhH34LDmmw9ZcInueqfo4fTED58Gng6tyMpdBMApZwSnnhwaNruwSRiogbJ/qoyoYduuthKuzLYJZHV0Dri182sOKAKhylIxDiUuCMhbknyUAMCtVH/+KX5+qXr+BR7Sp0GvReUCCYAMbTQ6N1Tda+bEBohpXi2COFpQU3wg01RTV1iJ2uhtjv4rIrsOrmXs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d467cbe-3765-4d8e-3e0c-08d6a1cff924
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 01:06:33.5692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some devices which are controlled by system controller,
they are NOT present in device tree since no hardware info
needed, just register these devices as children of SCU device.
This patch registers i.MX system controller watchdog platform
device as child device of SCU.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 drivers/firmware/imx/imx-scu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.=
c
index 2bb1a19..df75ead 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -196,6 +196,7 @@ EXPORT_SYMBOL(imx_scu_call_rpc);
=20
 static int imx_scu_probe(struct platform_device *pdev)
 {
+	struct platform_device *child_pdev;
 	struct device *dev =3D &pdev->dev;
 	struct imx_sc_ipc *sc_ipc;
 	struct imx_sc_chan *sc_chan;
@@ -248,6 +249,13 @@ static int imx_scu_probe(struct platform_device *pdev)
=20
 	dev_info(dev, "NXP i.MX SCU Initialized\n");
=20
+	/* register SCU child devices which are NOT in device tree */
+	child_pdev =3D platform_device_register_data(dev, "imx-sc-wdt",
+				PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(child_pdev))
+		dev_warn(dev, "failed to register scu watchdog device %ld!\n",
+			 PTR_ERR(child_pdev));
+
 	return devm_of_platform_populate(dev);
 }
=20
--=20
2.7.4

