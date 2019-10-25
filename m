Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF26ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCAA21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fyrIdOCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404951AbfJYGO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:14:26 -0400
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:19557
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404168AbfJYGOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:14:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J96gkpSIYSDzDAYlEuAF6bBXxZwMV+juIgThiOywQygrwiELM9DYWPOZ6yDhgU6WKBVU+Va9Abhowi1kv4JKjzXILRDFa/eB5lh2+UU03w8vARxOvgayWGlgEXvksssDCDhHzl4LzvAWG/tAnNZfnagUfPN1R57LriGHFXERrka33gmxaMioeiex2xdpAwLgj+tLqAq5tdQVH24RVgUWuKFVqJpjwYAToD27Wd7b8JshM68vSKudE4yI07Q2xflr1DLlfOwOVXtOF/Mo9waKAaoZLTxeyrNuyuFcg6KVVWw1/HDQ3L8STSEsdNbgdYhm/JVS8QqjoLmnrWZLh/GUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjkhcjCUWj+siKB1l4Yb8OFJGodxUcLxEKWB+pCNf/E=;
 b=ZEm0f0BUFeOxHllsuj37Zt2M7oEQGqKxXhcsWmMN+wWqr2J1vCcM8F4IsxiADziCB85PgBI6bwEXPFGHAqbxDzDqcZBhEqxy67sftfkKR7qNerKEzxMckOH6Us7XqBqrmmuyMi0Oo2D7KZvLFuhXblRSsrQWWTgcaCbgG8aKZTM3ZZGV7vP4lkzolymfUVwH/YaiJR6TTRbN1VGW4RnXhdXy+AfjawWJQ/5GtqIj6sWoWKaTEt2xdrXMS8jEtU1b4slEc8EaP6PfvaUdJ2GZBbzxSgEGE4LGNoCbnblhzD3APRFf+jN9SdaPrNuIGFF6X7/MrAhUbbQlobOAljqZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjkhcjCUWj+siKB1l4Yb8OFJGodxUcLxEKWB+pCNf/E=;
 b=fyrIdOCftklTU0Fioa6Q/WO+i4lCVuq/2wdpi2ChvarqWQVY5m8VX7qeZvRRh55me3XulTXjia8ho79/h7rrTd4mo8S0w2Ki3Z2Sm/kvzRGwLIwBrJYZ3qBEfTAVgLhff24JtzdC5T/2qIT6XGjePBahc47jMJDPYz66muUQdvE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6018.eurprd04.prod.outlook.com (20.179.32.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 06:14:21 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 06:14:21 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
Thread-Topic: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
Thread-Index: AQHVfogREXMSqkErfE+B9jsiOEYyjqdq+EWAgAAASoA=
Date:   Fri, 25 Oct 2019 06:14:21 +0000
Message-ID: <AM0PR04MB4481FA56EFA3C34193241D3D88650@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
 <20191025060847.GD3208@dragon>
In-Reply-To: <20191025060847.GD3208@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd91cfa9-a409-4179-25c5-08d759129350
x-ms-traffictypediagnostic: AM0PR04MB6018:|AM0PR04MB6018:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB60182872B3C7B1A1A127E29B88650@AM0PR04MB6018.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(199004)(189003)(76116006)(81166006)(81156014)(8676002)(66066001)(6916009)(66946007)(66476007)(66556008)(66446008)(6436002)(5660300002)(64756008)(4326008)(52536014)(44832011)(9686003)(7696005)(6306002)(74316002)(4744005)(8936002)(478600001)(316002)(54906003)(55016002)(25786009)(966005)(256004)(76176011)(14454004)(102836004)(71200400001)(71190400001)(229853002)(6116002)(6246003)(33656002)(3846002)(11346002)(446003)(186003)(99286004)(476003)(86362001)(2906002)(6506007)(26005)(305945005)(486006)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6018;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPYnM64hOmc+vKnafmlly3zuEcwURc24MNlS9RSpgt1pBPYX11rHtv1qPDoqD9Es/vBSd39hUuHpE/hH2XA3VewhrWIeXTwBQfndhzSR6qus8ha0UT0uMptmeSD1RYAKDlzARayIxu/A6JnJm7/D/TP3f3Ji39BNHY/on8gAiiW6StK8eSa61QoRVdOgRn4PsNUlUCBPmtVV3iAERQdQtjjJzm4XQbP3ISs77BR1POZvItbM52UXGfK/kIpvuF5lPnp8ZAoLk1RYs75s6wHxubPnc/H/lVx1r8uWXTgh974mhIV6w/AV3IYICnYjeBTd0hjPepOgLAxcP/HNBvEdmY2zuN0U1S6ARhLfVg4NB3tnBV2BNVaEWXduUb/k2+tAp2lwBy/iWhgTupA3jiftON7Nk8vgsKKmmN0pUewk2joDYHY9yOAUcdYt5qBHmXDncjFTjsaAdQK2xRSskjvXAL++dx0sphmrI683PodPez0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd91cfa9-a409-4179-25c5-08d759129350
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 06:14:21.1271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzsRh+G3ypVLGUy9XzSGg2eyXPk08A21cPl7bKlp+VrhbJnoA6yv67Mnc4wjbWISPcm1Xazl8Oa3sYxs18E4rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
>=20
> On Wed, Oct 09, 2019 at 09:58:14AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > According Architecture definition guide, SYS_PLL1 is fixed at 800MHz,
> > SYS_PLL2 is fixed at 1000MHz, so let's use imx_clk_fixed to register
> > the clocks and drop code that could change the rate.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Applied all, thanks.

I have a v2 https://patchwork.kernel.org/cover/11208131/ patch=20
based on Lenoard's v3=20
https://patchwork.kernel.org/patch/11193189/ to avoid conflicts
when you apply Lenoard's v3 patch.

It is fine you take my v1, but you will have conflicts if you take
Leonard's v3 after apply my v1.

Regards,
Peng.
