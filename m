Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06FAC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2FC206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PibWdqb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:56:48 -0500
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:18693
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfLRC4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:56:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4SoXf9p1yyP/S19fQfRFxDTTmjOojphTJ3hSGv7YTPvheiVePLR2AeGpUiBYSG8D216M0TrbopDgszkcGEKuEAfTykYyGpgQiK/GnN856vwrl1QC7WDmG8XzIyIni9xhGOpqoRPY3pgv8XUgnj2818XZQN/SteKeUmGXuJoe7GKDgLGglh3vwwpvZGtr4Uy20EVNAionauGE3gf6AQJLiv2/UI93qCEYcH1h5Q2DZkb9Rw4KVKK4tumatM/zYTHiXdIEZjfdUdrZHolYwQYCS0nBj1uIyIClefeMw5dEoDyOpNZumhR8IsYAsWT/QtrKZUt4ISEGb3heMUn+rY6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC1G+nCTLVo09nu9Ubd0AXHpakgJIzE0q9YijDtSFmA=;
 b=dsq88kdFtcn7Cae91TAIkginf0WcVRgikn2+IgitJzUMf59lyUeWree1tUWkRqU4iuq4GkV2gMBwqmmPoYQQYm1Cg70NE6Izy97AL/xWPZ99UpmjCqgOInkSvMCE2qDi6eHSbkmCcdVxS7egxIGlbCLXgQA1JphpFT68tI/dtbhxWlXVTg3JfLnbVd6RHVHGkiYYwsIOYgIiO7IJTaynjS3xUQx51m2JOomH5p7np5JCiDKBiilYN2dK67k5YN7QPT2w4SbNlfx5Ue+giYjn2qLj5fC/tyyZWVZrNuLlSdP+zGc1Y6ooxl0PCANSMKOuUD7uC4QWhVGRGt0/ykZ2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC1G+nCTLVo09nu9Ubd0AXHpakgJIzE0q9YijDtSFmA=;
 b=PibWdqb6Pil3ioZyseJLlh+76KHjaujzDMDW0RiOH8Fr56plg2rc9YY7erNTzdbd8tEEVD0c77HeltaLgsXEoOicM0TUqUFYoax0ILL93fNMM9bfy5sRBp21bqH8tNG9604Iripjx/V5pnexnKCgE9otLxa07QbniTed/iH+/fI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5715.eurprd04.prod.outlook.com (20.178.117.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 02:56:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 02:56:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] tty: serial: lpuart: cleanup and improve for earlycon
Thread-Topic: [PATCH 0/3] tty: serial: lpuart: cleanup and improve for
 earlycon
Thread-Index: AQHVtU7HAd5KGlN8D0qUxWmsG1isoA==
Date:   Wed, 18 Dec 2019 02:56:43 +0000
Message-ID: <1576637626-19317-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: KL1PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72839cbd-30f3-4c18-51cd-08d78365e9ab
x-ms-traffictypediagnostic: AM0PR04MB5715:|AM0PR04MB5715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB57153C8128E6BB62B2A38CD988530@AM0PR04MB5715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(110136005)(54906003)(316002)(71200400001)(5660300002)(26005)(186003)(66476007)(86362001)(66946007)(64756008)(66446008)(6506007)(52116002)(66556008)(8936002)(81156014)(81166006)(4326008)(2906002)(478600001)(36756003)(44832011)(2616005)(6512007)(4744005)(6486002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5715;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlAR8TtEdVqge+jNYGx8bcE2fKY6azpENMtLubcJm0hSxJYnP9MUPCxCS2q+r0mZ2V81BiNTs03OqSaKLvoMW3QQ+y151vHM6AD7S/Jh/4riCCQMIRiyblUSs/7ayKwgALtu+Lwg4dzPGXluKDw5kHfbL97NksF6UPTVFBdPVfKZLuR0p0rWAzB/Xe5YLSn4e5gsZqqs+R2koy/lll6WDJaDFw01Kcf3i6B6OTJgs1fCRsy+WCplVL2bimfrHDFMHEA2W1dzLH0Oj4/0oKQ5Ao2etqwEO9WPQIGv25trogKvtuzG5IasgkHt0WCE0A+t6aVaanRvEaf0uD+fC4qWOHtyGQmEEUSiAKzyH3LGmZGc8+Bb1sauGzo7t+Yrf0TGM6rPZpmhMAuYj2kFFe1IpJBRbJiQlvyUHkjbAYaOHHGUlXJwiKMs2EKZFuaSit5B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72839cbd-30f3-4c18-51cd-08d78365e9ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:56:43.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBrkO5089QtmVCvb5KcZmYy5gDtwPXAKgrE244c8Zq7QQn6XdsCoRWSf80c2rPZPkAkJG7o33TadUv7G+zbFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

EARLYCON_DECLARE could be dropped, since OF_EARLYCON_DECLARE does same.
i.MX8QXP is compatible with i.MX7ULP, no need an extra entry.
when we could not use stdout-path for earlycon for i.MX8QXP, we need
pass mmio32 to earlycon, so update code to support the iotype.

Peng Fan (3):
  tty: serial: fsl_lpuart: drop EARLYCON_DECLARE
  tty: serial: fsl_lpuart: support UPIO_MEM32 for lpuart32
  tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP

 drivers/tty/serial/fsl_lpuart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--=20
2.16.4

