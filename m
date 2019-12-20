Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAE3C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BAE2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QJgFuIJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLTGNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:13:34 -0500
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:14318
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfLTGNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:13:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfPuK063QPkFYqInw5UR7PYI67xyJB1TXfQrEnTpb0za8Chhfj/kxcaplyv15tyz6YQZN34Or3GEne3jYsv48THBJAS//pZ0/RY822eKI5TDekxAobGH1eze6fdzKcTM+BN5iAx6WzvQh46iexrGrjOWpKfYIF0qKx7SQclGCWGfm2eCeUdVBGaPAgnJeXmPxe4KwYOf9iB9KGXis4vZCwdgR8Q2bqay5d5ALcNC/X0z1Fkp0/82R/aljNBfvBVklE+UjTiLMSIdIOW7fStg27FsEthUnK/qNu9/sLpKQ13W7vFqE0BBSXMDzPpIFSqDbLPMTb+oQy3/5VF150ldrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp7H+cg23gXApADNamgiSE2RURspLu9tDvGvzf5U5fs=;
 b=amWBj+xy4gV0JnTQCo+LlCC/CxlyawudUy02DJQQCbHQPXWqU8Aaryqzce8vmZJ06B+EjjP4gXZ5M7R9WhOSi8Q8Bx0pM7//XtzS0PMNsgUapCIxE/k5zDvMnTyFGbmjuAF2h+JJvCc/5Jjhl4xbszszJcJ/uEH63GLFuaU7wLSmRKd1YgNsgNFAlJujmO5qttRmYHVDh6m5nlmzetUr0G7MmgO9ydaXIAK00p9+cNDelYRCjnqeSokuUzu2pky7tTTdNxNR9SoEm/dxfcixgLGKucri25MC+mN/vHXiQx2M1C0p9hbASvZMljvGaZX6elvXMZN9Ydkgx6g7xkWEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp7H+cg23gXApADNamgiSE2RURspLu9tDvGvzf5U5fs=;
 b=QJgFuIJ7rHhlxZmieey4AMwrqgUFqYI0vPpF3MOd4z2vBqvKfmIa5jKtjaXLdZfA0U/9d730W9oWuWG8PnE78/R3womkZO0guypbKD0/vWCEa3cgAzbglahz49nL1jO45aTtQrNxnTYk4doECuz6oxPRVGcWwERRa9iX5lOHooQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4801.eurprd04.prod.outlook.com (20.177.41.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 20 Dec 2019 06:13:30 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 06:13:30 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/3] tty: serial: lpuart: cleanup and improve for earlycon
Thread-Topic: [PATCH V2 0/3] tty: serial: lpuart: cleanup and improve for
 earlycon
Thread-Index: AQHVtvyZaPBJM02kmUSDrut+ax1uyw==
Date:   Fri, 20 Dec 2019 06:13:30 +0000
Message-ID: <1576822230-23125-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d9753cb-3ca0-4517-8b81-08d78513bc1e
x-ms-traffictypediagnostic: AM0PR04MB4801:|AM0PR04MB4801:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4801A75025AB90140A22292C882D0@AM0PR04MB4801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(316002)(110136005)(66476007)(66556008)(5660300002)(64756008)(66446008)(26005)(81166006)(81156014)(71200400001)(36756003)(6486002)(4326008)(6512007)(186003)(2906002)(86362001)(54906003)(478600001)(66946007)(8676002)(2616005)(8936002)(52116002)(4744005)(6506007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4801;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLLocU93LT2zhX1Vo8oaPOCBkVtl2g8Z2GjoXfszNc9ysNcLRw+9pRuMi3b2wBMBc9gJjKcIs0Mau0nh5AwOnFfSCVIF8+o8MQQhoewErDa+wb9FPTve7/DkejYWJ9Qi8xrBUmNDhByCHP0i6OUIfvmG7QJBCK+Ot9PUez+it4kdRnPz9Q5htgSxdVY9XOX8vFIuDNfnkX3AFS2h7crJuZGC2DtuxctDAaN9xoDynw3b+jNNiHeBJIF/hCoj+1i6FVYoYNPi1iVZNBnPiQMZ7HQhRIodt6EpcvbinXSzgEstD1fgXSowKU0DZKmgsG8a3ax8sMhnJdeRj/L9rLknonDvu3cnHSnGvS7CBGuEOeBcjBWHhlvTcL5/Tt5a5ciAuIYinWA5L9PU3p6C9sevTKvK8D1n4H02X6+YzVuF6vsSB1Mh8uoCkO3l+N2Ndu6a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9753cb-3ca0-4517-8b81-08d78513bc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 06:13:30.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtD75FZk9V7j+zZ1njy4faNF6eEhbsgbjf24qkME10DYJUKKMovAuAWgLdrg1UmpAk6H4DhJv1TV2Ay+SWGJHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
  Drop a wrong patch which should not be included in this patchset,
  nothing else changed.

EARLYCON_DECLARE could be dropped, since OF_EARLYCON_DECLARE does same.

i.MX8QXP is compatible with i.MX7ULP, no need an extra entry.

When we could not use stdout-path for earlycon for i.MX8QXP,
we need pass mmio32 to earlycon, so update code to support the iotype.

Peng Fan (3):
  tty: serial: fsl_lpuart: drop EARLYCON_DECLARE
  tty: serial: fsl_lpuart: support UPIO_MEM32 for lpuart32
  tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP

 drivers/tty/serial/fsl_lpuart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--=20
2.16.4

