Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4D20657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bN7bWivm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfCFKBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:01:32 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:55781
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729791AbfCFKBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmsE8oz7B63+C4vH+/YcfEFTbdU9Ot7+J58GDQR8Qm0=;
 b=bN7bWivmTNH46obyDJ24/YyDwtS4CkD54NUERV04FEtPTcn03PumlrdsiPTQPkCWKO1wVWuX/JRFGRlhew+Ym1zExs+08+C+qM1PGP1/r3etkvqP6lsKzG1/QoPnHX5z8Icp/VR3sdd/f7fu4nBcoq5BQgz4IxnBvAFHaCoVaR8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4763.eurprd04.prod.outlook.com (20.176.233.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Wed, 6 Mar 2019 10:01:07 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1686.018; Wed, 6 Mar 2019
 10:01:07 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND 5/5] can: flexcan: add imx8qm support
Thread-Topic: [PATCH RESEND 5/5] can: flexcan: add imx8qm support
Thread-Index: AQHU1AOE4LznLW1bukG0o8/I1gnnwA==
Date:   Wed, 6 Mar 2019 10:01:07 +0000
Message-ID: <20190306095833.20922-6-qiangqing.zhang@nxp.com>
References: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4b22e79-d5e7-4402-dc53-08d6a21aa715
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4763;
x-ms-traffictypediagnostic: DB7PR04MB4763:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB4763;23:H6gGp6IlklESbAC2ca/mpiu0zpdJGxD0zLCCCPV?=
 =?iso-8859-1?Q?b4J84SPEAnNU26kw8Os77NgH9oPu/oa11EhZO+jafE7gDICzqm671FGkaD?=
 =?iso-8859-1?Q?AKNGmeR/5lbM1Jg2+DI05l2gBrpcyCH91fgG08VM2ofJ5cRTex733qZ6EZ?=
 =?iso-8859-1?Q?vdqowHBocKsv7AqTpNckijxOW3CVu5pwcRltzrV/E2e0iy3k5/Ml9T+Hwe?=
 =?iso-8859-1?Q?bmp3Y9sofxi8HnNHLzkC41V0bhLPdxh1FKXStuaYrXR5QLcjjRtbCFNc4W?=
 =?iso-8859-1?Q?fShOyVP3Vle2ApdsPJDvwHpmuZUmSMIDUvlyPQLt0seVnBs6HZxye9yDTo?=
 =?iso-8859-1?Q?H4u+3nqjWeX55pbs5sDSrKgbFxz+Ei10NwHvN71qtteRN/ZRaMZhI8Q2/b?=
 =?iso-8859-1?Q?NraYshY/5ukTrs6pGQln0my91jiFjfmH8RSAl294xziqtCKhi6+oZdiRLu?=
 =?iso-8859-1?Q?CiA/3fT+QNHf7KzITwbfYHq8cB6GN4tf9Fwby9NU96xM/juXZgGHdcVUKB?=
 =?iso-8859-1?Q?gPAwN7TtZ/L4ikNpGvYajNCseVMFwbK7QbBCQv/AUZr3CNw3yq9yQNHlal?=
 =?iso-8859-1?Q?gEF3FcstrKvLotSj1gXT2snQIlrPmqIWAhpr3Drp7yIIfOsbclQJssxkuA?=
 =?iso-8859-1?Q?kc55mg5hrlkp7Tnu97mkWtLJP5R/CbU1nFYdGUJvFFBSQ8CBcJJ2cP0gsM?=
 =?iso-8859-1?Q?1ITID+0Zjo2+9q36ewEzwVmmW8JdrmjRrhAb5VAKAvBuURC1uR4PMYFyPd?=
 =?iso-8859-1?Q?V+Qe50rvt2LYu0lh+emTHNs+v4OHsi8nE4nkjTZjA9qD20/3c/C5ft9DYc?=
 =?iso-8859-1?Q?/FscrlfICnZ6x2tl3uIvzk08JXoJBPwM+pSN45MVEcZY6sP4QOhXAPvFEM?=
 =?iso-8859-1?Q?I3srcWXo37OejOrhNm3244a5oRQ8K5iuOwahYx3Ak7eHkiVtDB+TSTVS3J?=
 =?iso-8859-1?Q?YLeKbebzw8CGMLJjLNTtRpr+a0bcFakRsHHxCH2gZxS9mNc2FZMigBEqiQ?=
 =?iso-8859-1?Q?Vb1bclCe2ohvzkcyw9JTzM/sJGWUenHja2F0RJazHfXz/UZZRpOrJzn/Ww?=
 =?iso-8859-1?Q?Kh7b1ojYmfgb5oJi+jbeWBWbT/vnQPexnFtIQo9Q3sUlYY+u1K76kBPzw+?=
 =?iso-8859-1?Q?WxfkECcRB8lGI3RvH1H1kgD90V9tWuvM0JxCALTiZdNq3w49a7zSGKrFDN?=
 =?iso-8859-1?Q?D+L0ML8HJnBbEU90TiTBV+oESZ4vybesPzE6AZx+pVpuIX2a9VQ+5BibV+?=
 =?iso-8859-1?Q?5gASreycP/4tp2fstTZScyYsHNTKggsvNogY/Rk93YpoaNfLoTmFJszzGm?=
 =?iso-8859-1?Q?38=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB4763A38EE6E9163705C14A4BE6730@DB7PR04MB4763.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(99286004)(2501003)(5660300002)(52116002)(71200400001)(71190400001)(53936002)(6436002)(76176011)(6512007)(1076003)(446003)(36756003)(14454004)(11346002)(476003)(2616005)(486006)(256004)(26005)(186003)(6486002)(86362001)(386003)(6506007)(102836004)(478600001)(2906002)(7736002)(25786009)(50226002)(54906003)(106356001)(110136005)(6116002)(4326008)(105586002)(66066001)(68736007)(305945005)(8936002)(316002)(97736004)(3846002)(8676002)(81166006)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4763;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l4M9X13SCWGT5hi1bZ22sFi2eTN9p5vn/AA0zPOFJCCl9efF0LwtRbvIA4gAZ1WsyM3+ffeS9EzeXszbP+3JaBByWwYqZJRFWfCQpde/kiFZ/+s6iPJduW9imPRmv2iHLlE5sX71gmW0eUoyNIN8VboN3GtBChDXmARdTMqgyOEtE29zdDu/TSzUfOdW4BoZodkpxVxSnI+Wh1ZNHLFFoMyPDutbF9vPzWQaFGF4m1i+YF4XTt0dBroCy5YkqEKYuSnts/Um3Xv8LVD62gaOtj8MEkh+M3YS40S03/CPKgQkTW/qFPL/tdV67ct6MCWn/FOf0ImwHlsbtbFjmf0vI6dQNIt68+oBfLTWoqTzmT2uZo9nXRJPkYXkTedz3jYXqmHfPX3ome45fZ1XmcQFxUt4Di53B93lJGIikUIAgpE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b22e79-d5e7-4402-dc53-08d6a21aa715
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 10:01:07.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The Flexcan on i.MX8QM supports CAN FD protocol.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index fca014bc530a..49615cc42436 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -346,6 +346,12 @@ static const struct flexcan_devtype_data fsl_imx6q_dev=
type_data =3D {
 		FLEXCAN_QUIRK_SETUP_STOP_MODE,
 };
=20
+static struct flexcan_devtype_data fsl_imx8qm_devtype_data =3D {
+	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD,
+};
+
 static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
 	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
@@ -1633,6 +1639,7 @@ static int flexcan_setup_stop_mode(struct platform_de=
vice *pdev)
 }
=20
 static const struct of_device_id flexcan_of_match[] =3D {
+	{ .compatible =3D "fsl,imx8qm-flexcan", .data =3D &fsl_imx8qm_devtype_dat=
a, },
 	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx53-flexcan", .data =3D &fsl_imx25_devtype_data,=
 },
--=20
2.17.1

