Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F42CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B3920679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ARWIyfCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437200AbfJXC5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:57:43 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:3332
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437113AbfJXC5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:57:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+2PMbsYoa2PaQ4tjm3oIYf5wp3CyyFDDDS4Y3wAxf8WcJkb7yy9W29PqAmD4mBWwp+RELd49cCAROpYVToKJ0gDBMvkMvonfa9LUXfU/VO3UdMtbcQ1j+DOXhqKq2mqiVkiZ31IC16o0WsKqTh+3bqiVnUFVA6THG6WNhW6v5gBsCSBK7F5wr3DSD7z5CeZxGW2O9HigTbWgzPZT5E2th+rxcHYWNMYfvTxJrwmTBRbu/A4qN7w/vReKd86KtUlQuNue384NcaAmWIkeRnHUev5bYjGfqWWmqWq352iMS9C46EWoNRia7/Uaj70L9n2pBdVj6EhVs5TZzIIgYvxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s/3rRA6QxN2yzgRix40R1LkLzzlsXwcMY7YwLaVTgU=;
 b=IE240OiFl6HavstcYnuC5gTN4GbQPsy1ozRSU0o3ol0vPbnu2GF8re6IJu7UoZOlHXmCbObyLMsVVnhAluep0Sm9wuy/l9Xk2Z1P4mrU4BbHf1zl84eU67TIlZfWuCbzND26tICzED2OskS7g0YtO+nFqUh7TOMYFiBMr5yqx9I08Y8xTrjPib6mkS87EtqPYt59We1DNF6oSxKmGib4CVzH7zH51GHTr4Ol3yG6GGCOkm+NHw566ZovYVI6zOq5BO3YrY0n2py+98kvfeaD5FOv5i98wAlhZPlqs8dBzagEx+XNV7jD2zB3dbzZL2M99y0toqOgxS4USFzPGuQ4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s/3rRA6QxN2yzgRix40R1LkLzzlsXwcMY7YwLaVTgU=;
 b=ARWIyfCNeiAv68gCyAzkEP38HMm7IMyD/5bBSWFNQ9rIt2LvPw/iOkmd6IYV4pfWUxv6UXepDv+fUtHOinp2os2czCRxidK31YgSJpFS0atVeN793CCNz7x3818MiZOAU9aE64h+1MbvQpF3VVs5b8C/Pb3MtPVYVI8k4PxGTXE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4372.eurprd04.prod.outlook.com (52.135.149.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 02:57:38 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 02:57:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH 0/3] clk: imx: imx6x: use imx_obtain_fixed_clk_hw
Thread-Topic: [PATCH 0/3] clk: imx: imx6x: use imx_obtain_fixed_clk_hw
Thread-Index: AQHVihMHWm1jS7cCrE+ghlbtE9L0L6dpGVLg
Date:   Thu, 24 Oct 2019 02:57:38 +0000
Message-ID: <AM0PR04MB4481226E209D2851DA1FCFA0886A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1571884049-29263-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1571884049-29263-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f7ca6b2-029b-43fc-7f67-08d7582dee10
x-ms-traffictypediagnostic: AM0PR04MB4372:|AM0PR04MB4372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB43729DD765FFF33C8BADF183886A0@AM0PR04MB4372.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(64756008)(66946007)(66476007)(66556008)(52536014)(66446008)(4744005)(8676002)(8936002)(81156014)(76116006)(305945005)(74316002)(66066001)(7736002)(2501003)(2201001)(81166006)(54906003)(99286004)(86362001)(186003)(33656002)(5660300002)(14454004)(76176011)(316002)(7696005)(6506007)(26005)(102836004)(256004)(9686003)(6436002)(71190400001)(71200400001)(110136005)(446003)(11346002)(229853002)(25786009)(55016002)(486006)(44832011)(4326008)(476003)(2906002)(6246003)(478600001)(6116002)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4372;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWpTfRKmVDUbgb/fD242/K103awrfTf1KFnA2YW7WpHUfU9kgpEN9/Fv2BdhVKJIQ/q4bOVp2N57DoXLFIczlEy5sWIhcFLU6wQmH9C5TcdS6py3XsSSd1o1cgJ5qVIzBQU9mr2bw2f3WngBstLkG71iIQxHP1+Y+Bh74n9q3v6DlLijm57ekLsadlxE560pwtSIzlkJ1Gmw/yM+jZZpbGW82Gzd1nwJIO38RdQgFi8jmY6DUuqY5uq5cTTZMHabXz5VjzWQqTwOUQ3BbsLaI6P/CK6Vnt8efCKba7LC00kUMGN00apIIk3H+Fk+B5WAVQVtTmIYCpyPdL0WuB/ggQNnhz7NVPj+Sh+ruEHy2Fc2IN2tGa+ucSJJ8PkP1Jt6salgu6c0su5i0TRYDrW8AvWshq/He2vqygo2qqfGbx5JuFzqcYQAdOfV9RwLDbu/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7ca6b2-029b-43fc-7f67-08d7582dee10
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 02:57:38.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jo9v8yhWANwy/ohM6zboSvfaKVZcuqDhhXhy0oiZzq9N6z8Unc7P3l2iXint6EZCkkPYC3egrF7Cu1bD9bPX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 0/3] clk: imx: imx6x: use imx_obtain_fixed_clk_hw

Drop this v1, push button early, need a fix for 6ul.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This is to use imx_obtain_fixed_clk_hw to replace
> __clk_get_hw(of_clk_get_by_name(node, "name")) to simplify code.
>=20
> Peng Fan (3):
>   clk: imx: imx6sll: use imx_obtain_fixed_clk_hw to simplify code
>   clk: imx: imx6sx: use imx_obtain_fixed_clk_hw to simplify code
>   clk: imx: imx6ul: use imx_obtain_fixed_clk_hw to simplify code
>=20
>  drivers/clk/imx/clk-imx6sll.c |  8 ++++----  drivers/clk/imx/clk-imx6sx.=
c
> | 12 ++++++------  drivers/clk/imx/clk-imx6ul.c  |  8 ++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
>=20
> --
> 2.16.4

