Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3667CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E420874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FWjEutTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfJ3KVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:21:12 -0400
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:27733
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfJ3KVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:21:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3Z0zuSCPPMvyBlw6NQqKc/TfRpgxt+mQMMgAIbGr30zccJRIexpq3l+6D967pchiJnSKC1LabLAdIgbyDkBUJ8ejzwqp2rbAKJjOGwPv7buGKQwLBRpwf2hpIxvqpUBmLLzWo+L/Zjwlc5oh2abQiTVektfHivElvkYfk8O8PX5A/MWmxsvxRiKY6n27yZQ5Bfh+glSu5SkXQrW93dDSECiPv4quUKfeEQxZuQqECGoRbUKiVJq4+/aqR+WWMII1lp3oeB5eXiKSfZzRIwLrGMrkIjwjdYlDjzkaQBsZFFrZrRiiPw3ZMo9N6gatbVEhOgauWEUarcbJUjsVyjgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdq9QOAVIZ8f0JCm8tQbe+C3f0MeU7KlFAJZhP6HpT8=;
 b=JAjVR9tzQIAbC5dRbMrkGA/t/XflT3HbPIYlnT3oV/GvTNaX860h8oYNq8WL0T75nfx8HgRUzpGC+r3RWtJ9qvwWOA2s2ippmzqwcuWDKFAjDK13JjxGTYvKRmRum7zDx7REQNXzjSmIbRbgHBOW/1Pe75B9m6p9oUrvQMLVtSe0ir30jBRGXeXLurvoDbWq8Ccsn+POT7SN+Fa598k9tI/tgD/XEMrLLGrBDDbSXTkX34YJOm7HrVRqXmgXJKgU/UB7fVooEXlRF1nv6Stxttj5SlEyg2mbVrdze/dW62p643gFAjmHeG6JjnHErWVE622TEHleWmaN4bH0cw40nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdq9QOAVIZ8f0JCm8tQbe+C3f0MeU7KlFAJZhP6HpT8=;
 b=FWjEutTHJJasS8V4jN4xqtP6bb/7qv2KX+6VVMqAVLrkssxfLVqSB82eXoZtOLIHC8i/7hCeoJy7d4bZjZdgHSbKQutj8sr1BXDfea8kqy+mJj78mEvSHEO0vlqFhWawMKsOU20k5ab6koAoBB9cin4SfySBEUa9ZeI3k+uy9TY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4260.eurprd04.prod.outlook.com (52.134.124.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Wed, 30 Oct 2019 10:21:08 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02%3]) with mapi id 15.20.2347.033; Wed, 30 Oct 2019
 10:21:08 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
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
Subject: Re: [PATCH 0/7] clk: imx: switch to clk_hw based API
Thread-Topic: [PATCH 0/7] clk: imx: switch to clk_hw based API
Thread-Index: AQHVjl55CLrCj3Q1sEiGZunySWSfBKdy+rWA
Date:   Wed, 30 Oct 2019 10:21:08 +0000
Message-ID: <20191030102059.ppb7le3qnfhbcii5@fsr-ub1664-175>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::41) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7aa7261a-7d9f-4896-caac-08d75d22e0ed
x-ms-traffictypediagnostic: AM0PR04MB4260:|AM0PR04MB4260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4260328A2042C6C35AFC5A4BF6600@AM0PR04MB4260.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(11346002)(66476007)(66446008)(66946007)(8676002)(64756008)(76176011)(81166006)(66556008)(486006)(386003)(52116002)(81156014)(316002)(99286004)(102836004)(8936002)(478600001)(26005)(186003)(3846002)(6116002)(256004)(25786009)(4326008)(446003)(2906002)(476003)(6862004)(44832011)(86362001)(33716001)(6512007)(9686003)(6436002)(66066001)(229853002)(1076003)(71190400001)(71200400001)(6486002)(14454004)(305945005)(7736002)(54906003)(6506007)(53546011)(6246003)(5660300002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4260;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHdaHsUC6QmpjWwoN4FRqrOPDS1BK1t0zwKSmoHceM++j5YENN+XUe9npcuU59mD6uVqaBKBp60C6H82SbzhgRZyFqSjJ0nYeEID2d+JVN3ZOrFu+yZAnKwX2eF16lsCeXsV9yD5wpfdm7E/LjygNgAT7GTq0/zTN9dMQxIikGGQdSxtHYjnernokiGScZtgrjPciKDkacL6qWIJaPPBoJbELwYWh8ZS0nl1E/wf3zJbBPXmVjr7h5Lre7wMv4fXl1mOyEMuJQHj6p7r4skmLzHmn2pSrgdxdk00ThGX3b4e+FpzzmeUPItGTsSsZ6ACFyvgaHpP6nJbCRp8h43YAXf4zTLmz3DE7iuKsLhDgfSyF17vQ+Yu6K/YQmdpxWjNPzAPxismWUybTCpm6m2O9JBSqDng2RXarn53Ul/rM4fCE/cNQF/scTwhmExDtPKr
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43350CFBC5517E408DDBE9D9EFAFA719@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa7261a-7d9f-4896-caac-08d75d22e0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 10:21:08.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MG1w9bPkz9j8DbOEYMeQPyXUqSd1O98yfGuNl8quB567JEGEEkvbtgSCGf10mY3JXp/EAjGltDCthECu0nLLwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-29 13:40:49, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This is a preparation patch set to switch i.MX8MM/N/Q clk
> driver to clk_hw based API.
>=20
> There are some patches under reviewing for i.MX8M clk driver,
> to avoid conflicts, so not include i.MX8M clk_hw patches in this
> pach set.
>=20
> The patch set covers the APIs used by i.MX8M clk driver.
>=20

Thanks for working on this.

The entire series looks good.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> Peng Fan (7):
>   clk: imx: clk-pll14xx: Switch to clk_hw based API
>   clk: imx: clk-composite-8m: Switch to clk_hw based API
>   clk: imx: add imx_unregister_hw_clocks
>   clk: imx: add hw API imx_clk_hw_mux2_flags
>   clk: imx: frac-pll: Switch to clk_hw based API
>   clk: imx: sccg-pll: Switch to clk_hw based API
>   clk: imx: gate3: Switch to clk_hw based API
>=20
>  drivers/clk/imx/clk-composite-8m.c |  4 +--
>  drivers/clk/imx/clk-frac-pll.c     |  4 +--
>  drivers/clk/imx/clk-pll14xx.c      | 22 ++++++++-----
>  drivers/clk/imx/clk-sccg-pll.c     |  4 +--
>  drivers/clk/imx/clk.c              |  8 +++++
>  drivers/clk/imx/clk.h              | 67 ++++++++++++++++++++++++++++++--=
------
>  6 files changed, 80 insertions(+), 29 deletions(-)
>=20
> --=20
> 2.16.4
>=20
