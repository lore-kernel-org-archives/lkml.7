Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C9C010C5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DA7217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0yq1dT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfKELiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:38:03 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:4763
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730636AbfKELiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:38:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQVGwOglq8TcNHDGKLeNQkBAH9QKmoX3fq6p5qEJnRaA+ci1xDF+M8X6Z5RcioI97VdN82EYE5AG8ZdefshnKRRCGYEO0/pEa+kqfXq5SWl1Om3ZUmbBPP1hTISxA4h1NkgvPTk9TYUTcg5J4PtNyJVUd3TLSvjdZ1CI0GZa20J0X6QEUij4nuY/Gdx3MhzIsxQibYgfS9UdGr7VJORFUdJCbuaqHT4kTwgwbXTSI8Yvq/AKjhwzsLX9E/2WqK/pjBzXfipOT2MF5gFCp/yAWeWNfeqyzko+ic1R4iDPFAYWa/bEXnxiEPjCql84QWYo9g8lcfXMtYGrlT+Yy/wrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y98z3OBgAdzDOLCLxyD+9+dC7Pj2S+fFajW8lxMzebw=;
 b=ItwjNsFw9e1hs0SHatIa8Sw9Kv3sBwaKAKYsKLX0ubJSGKE3KzRCuhbDlITOh3NdKLyvfQr4qb26QW+hnor51MXVX/lNv+qKx8FWDCr74TifQv54Fuh8s//6GO5ZzwIbiEABUcvAgC2MlypM0F/+IbEeX6xGY9YCPiCO+KjCQ2H/NzBIe4qGu6h4fETxF3st7qXU4DJu3H+SExY4Yc0gervzA1INMxTdcZTIo+1tA5f4ctVzNH++xAvMdat5YN/64X71TH6XT1RYsJEN7JwkcKdVMFQwTSNWY2aTL6/VSrI5vDNkV7tIqvKEkgAH4CTzVuCV4M05GIAAREoDuoJHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y98z3OBgAdzDOLCLxyD+9+dC7Pj2S+fFajW8lxMzebw=;
 b=A0yq1dT+oCjApIiyHpANTEdhkszjCFpVMNWhjNUxOQf0RQThV8HNpVLHxYWuCaH/Nco5EO4EVIMovhYXM8z3sLrchlHfG1rxU1zCPP/9eRGFjL37409QjOgrpDH9gvMGy8QFApNq4G2y8W8lXJgBipf7V+F12VO87GDyWnhMQ1o=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4595.eurprd04.prod.outlook.com (52.135.148.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 11:37:58 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 11:37:58 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx: clk-divider-gate: drop redundant
 initialization
Thread-Topic: [PATCH 2/2] clk: imx: clk-divider-gate: drop redundant
 initialization
Thread-Index: AQHVkvg/xrfIJzKQG0a+hb51V+MVqad8dP+A
Date:   Tue, 5 Nov 2019 11:37:58 +0000
Message-ID: <20191105113757.7emblygbcqfa6gyl@fsr-ub1664-175>
References: <1572862200-29923-1-git-send-email-peng.fan@nxp.com>
 <1572862200-29923-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572862200-29923-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:208:154::28) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b5ddda4-83f1-4e8b-68d2-08d761e49b74
x-ms-traffictypediagnostic: AM0PR04MB4595:|AM0PR04MB4595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB45959DDEAEBA6202C9C220B2F67E0@AM0PR04MB4595.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(86362001)(476003)(478600001)(5660300002)(81156014)(6436002)(1076003)(44832011)(14454004)(486006)(25786009)(33716001)(6636002)(71190400001)(305945005)(71200400001)(7736002)(11346002)(9686003)(6506007)(6512007)(99286004)(229853002)(102836004)(53546011)(52116002)(6486002)(76176011)(316002)(2906002)(386003)(54906003)(6246003)(4326008)(256004)(14444005)(66476007)(66556008)(66946007)(64756008)(66066001)(66446008)(446003)(6862004)(8936002)(81166006)(186003)(26005)(8676002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4595;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aCiiY8Xr1W7vGmM/Z2U/Pdt7lPeYxvcgRhHADcY+nc0zm5sLS7rYRT97NsowwSgIHftgnjk6Git70ZtANy5UWBBvBHIzqIscVuMRo8W6evHEUp/QVx36lH1DcQsG5k29SG42+oq/76pOqQEyVIcbtyI7wZVauFqAdZIJGNcPDKJY2XBalephnsmId+QQxhoiEQ992DRAT2u1WdRqIdgIHvhFnHMrjZpH23HUTBViF7nf+RwD/80KGtqw/Ct6x74I9Jtb/GgiHv6cfvU7hq3K7+US8tfQeqw1fnLQKJjQHjiVNsVYEz6keMs5TeTGjGNeOz0fYNlw0qQAut3CScKjv+TOticv1nlSLrGg8f6X/ZWuSK8Qbxu3FNuretdEKtwKHMkttpjccUWPlUjcfITpYcJdPOEYrua+Bz/+L4hjnW5HosCI8mYO2COEqSY4VPB1
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4DAE11B15D0F814F82A82AE72658CCDF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5ddda4-83f1-4e8b-68d2-08d761e49b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 11:37:58.7858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4q+yUkdCi9aiXspDBFEe1T+WklC3gjZlZET0zbzi5JZoQxMmzMMoFtYNtZJ2psUUr9XwjplB4qggnKEhCPLeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4595
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-04 10:11:37, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> There is no need to initialize flags as 0.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-divider-gate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-divider-gate.c b/drivers/clk/imx/clk-div=
ider-gate.c
> index 214e18eb2b22..4145594af53b 100644
> --- a/drivers/clk/imx/clk-divider-gate.c
> +++ b/drivers/clk/imx/clk-divider-gate.c
> @@ -43,7 +43,7 @@ static unsigned long clk_divider_gate_recalc_rate(struc=
t clk_hw *hw,
>  {
>  	struct clk_divider_gate *div_gate =3D to_clk_divider_gate(hw);
>  	struct clk_divider *div =3D to_clk_divider(hw);
> -	unsigned long flags =3D 0;
> +	unsigned long flags;
>  	unsigned int val;
> =20
>  	spin_lock_irqsave(div->lock, flags);
> @@ -75,7 +75,7 @@ static int clk_divider_gate_set_rate(struct clk_hw *hw,=
 unsigned long rate,
>  {
>  	struct clk_divider_gate *div_gate =3D to_clk_divider_gate(hw);
>  	struct clk_divider *div =3D to_clk_divider(hw);
> -	unsigned long flags =3D 0;
> +	unsigned long flags;
>  	int value;
>  	u32 val;
> =20
> @@ -104,7 +104,7 @@ static int clk_divider_enable(struct clk_hw *hw)
>  {
>  	struct clk_divider_gate *div_gate =3D to_clk_divider_gate(hw);
>  	struct clk_divider *div =3D to_clk_divider(hw);
> -	unsigned long flags =3D 0;
> +	unsigned long flags;
>  	u32 val;
> =20
>  	if (!div_gate->cached_val) {
> @@ -127,7 +127,7 @@ static void clk_divider_disable(struct clk_hw *hw)
>  {
>  	struct clk_divider_gate *div_gate =3D to_clk_divider_gate(hw);
>  	struct clk_divider *div =3D to_clk_divider(hw);
> -	unsigned long flags =3D 0;
> +	unsigned long flags;
>  	u32 val;
> =20
>  	spin_lock_irqsave(div->lock, flags);
> --=20
> 2.16.4
>=20
