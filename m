Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B45CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E5F21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nWI00kdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfKAKmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:42:54 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:20519
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728293AbfKAKmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:42:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFqOHl642LZ4wOOAmWJKE+GfhryzlSrnW80CVBFBh87EKQewMtnxE/ezy3XAFp5T5D831zS7xNOx+fbnvLSzfi+mFhAsLZYg7s7TdooKUGN6i+SZSpPuLopHuPXjZkQLa3pzMbcKslnjvF9HOJwYzR0iW1Pf+3wMiXGVPyP+fCpr5gCZbPtlzuIDOwnE1ONkWT4BaNVslci2gYoBxNbnzWpEZvdBS2QzOsNspGrV29focLDL5Ath2r94oBVeCsaMHjZKuNAR5+vQwpriZrMj0rMWftjSjQy+YYmRxO3pYb67A7oJg8V3YhwRDVAgclnO4Fg52Acu+lom4KgAW2o1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABF9wcCz+X+0ikMg81YgNSDGQvyS5akFNiD1j8XVvu4=;
 b=b00qau+cog1Qq7Tgn3m1laxTZiNECgJgUgIze3WQyDEkcib4Jqmidrnjb8AmFTqbfCnoD0wUfQ6QyCnosczeAm+R3n7AQMBBRAufWk+/0UAp1OI3Tu59vDjqo9frjIt+a5JZaP0ZLbb0SZoHWaRZeyrN+kj5iTLb+RjuIjlIIfStzNf3BAh7VDC0pEzkpkOIgHPS/528xlxqz2v/XyzsiiAiJwnvD18O9D+zNDIF38k+EkctxnLvadaXCZW+AzYZrNRaWfc0QT9MA6q9f7+4ghoA+SUZrywxBFHwO0Mr69o5LOfVS2mvhqrYCxREHym/144XKTs7XsTduB0dvgWMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABF9wcCz+X+0ikMg81YgNSDGQvyS5akFNiD1j8XVvu4=;
 b=nWI00kdPHzbHeCcS0rFcTju2h1yn+NhuOuKZRMKSausg7EZKoei/UxijbkXXZUCpXuw3xY9qHj4JULZxyEXAcE0vGURnKyCPsGnR7/1pcBwK7sqx7yGm3xZzodJ8FKs0M0F1g5WULgjKtHBQT5nyAUMmzuL7FVrtuXmb3lIii38=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6547.eurprd04.prod.outlook.com (20.179.253.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Fri, 1 Nov 2019 10:42:50 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2408.024; Fri, 1 Nov 2019
 10:42:50 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] clk: imx: clk-composite-8m: add lock to gate/mux
Thread-Topic: [PATCH] clk: imx: clk-composite-8m: add lock to gate/mux
Thread-Index: AQHVkJ1nitbWRrQWUkuauMi+K6eGNad2IPkA
Date:   Fri, 1 Nov 2019 10:42:49 +0000
Message-ID: <20191101104248.qqpt3hg437rccsri@fsr-ub1664-175>
References: <1572603166-24594-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572603166-24594-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0023.eurprd04.prod.outlook.com
 (2603:10a6:203:90::33) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 753b6fa0-79af-46ce-f5ac-08d75eb83da1
x-ms-traffictypediagnostic: AM0PR04MB6547:|AM0PR04MB6547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB654704AE6BBB37D78A5628B2F6620@AM0PR04MB6547.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(476003)(76176011)(6116002)(5660300002)(33716001)(71200400001)(71190400001)(229853002)(81156014)(1076003)(14454004)(3846002)(81166006)(478600001)(8936002)(6636002)(316002)(66066001)(8676002)(54906003)(86362001)(6506007)(99286004)(6246003)(6436002)(102836004)(386003)(6486002)(6862004)(66946007)(66476007)(64756008)(66446008)(14444005)(256004)(2906002)(25786009)(53546011)(186003)(11346002)(446003)(7736002)(305945005)(44832011)(4326008)(26005)(66556008)(52116002)(6512007)(9686003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6547;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JzmC8m3eXdyFitZxH6nhYc8aOBZ4MZ/xpau8xIvxu5qHOIJUEqbmUGALwIWjTdxnQcdgztDAMEhDzu0b9Ba7GBA2wsZLLUvd11D7YT/R2ARxws0cPKHcD7BBZ5ffvAMAsO4FQjClP0uV2Uo3apvxWRVAwofndFVJbebFhIOFhpKHxIyvBK9hZdpRs/GTQIMZauB87NXEixHMiDDGflSvwB0JLPKojWv33OS0YcvKTYcVi+iIy5XOmcLkucSHvk7hUZ5Z70DtChhOjCFCSImauAJG93qvmpHcfReNS+yROEdimgCwusgrL9Wwn5T4VITxnZ6nIVrz/nwnfPB437TNPxTu2R70cFY2pOhjpuUD9XqbwM/PnRt8nEYjhJQtzhJjYlmshhZHPcEiauX9mATdWlBcIDLCgQBUOTlollKqqz69kYLwD5vX4/0pXABdftUc
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3789F8DAE0BB44AAFCACCD50CF0592F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753b6fa0-79af-46ce-f5ac-08d75eb83da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 10:42:49.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DoAsqaxmWHnOZv/q3K7xpp7lXKrj0ZPKuVGxaYQ7I602t9k/uwKK/JFklFmha8gcWNAVWKgWq4/vJZsKr36N0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-01 10:16:19, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> There is a lock to diviver in the composite driver, but that's not
> enought. lock to gate/mux are also needed to provide exclusive access
> to the register.
>=20
> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Looks good to me.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-composite-8m.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-com=
posite-8m.c
> index e0f25983e80f..20f7c91c03d2 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -142,6 +142,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const cha=
r *name,
>  	mux->reg =3D reg;
>  	mux->shift =3D PCG_PCS_SHIFT;
>  	mux->mask =3D PCG_PCS_MASK;
> +	mux->lock =3D &imx_ccm_lock;
> =20
>  	div =3D kzalloc(sizeof(*div), GFP_KERNEL);
>  	if (!div)
> @@ -161,6 +162,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const cha=
r *name,
>  	gate_hw =3D &gate->hw;
>  	gate->reg =3D reg;
>  	gate->bit_idx =3D PCG_CGC_SHIFT;
> +	gate->lock =3D &imx_ccm_lock;
> =20
>  	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents,
>  			mux_hw, &clk_mux_ops, div_hw,
> --=20
> 2.16.4
>=20
