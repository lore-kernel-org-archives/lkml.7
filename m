Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A202C010C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477F7206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KiuoMFEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfKELgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:36:48 -0500
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:61989
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730636AbfKELgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:36:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNk5ZXRN8tbuJTqMz02r+cbh87OiYCSIwfRhs5ZnGpS5q8aR90GP8HOGHLyUELg/i1DnZpNypSpH7x2WEZsgBsbVfEUHtnGOanK25Ra92mSOoEU/dovTDrb+fL3reNLExqaifuc+tn1WfeH9FzU9bJsTiBvXm+lVYGhGF9GU1GCfI7eWsQlNeVdm+hBEAGjzU2MUxEVXghxRWO573t43id6OMCp0ksKRt2U4DRbBUjdcDzmvU2lYfUutjfj2UHCHXGC2mLoUu/ghU7fMNQSqPVZgqIXJRs5k61fy2h2NiAD/cCCVGVRT94CmGFJc28bTWB18UQw/hLbqqgqCgrQ/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5GK/SRnyvxDk0UH/yjYL38NqanFe4eDxBiMo/yr8fg=;
 b=DogFVzbLsPL8Gi7N+4B04KiiZy2FweGg9AEbXGhLTBfd59b2KOdrZTO7wlm1A1Lw4GsqeUMHPqStcoV+7WSa2atHqNDqj3qJtTUJovs4x4d2nd4IbSDpiY28hgHDDyvPTsIz8ZMCsu3BZRAY7b6GvDgQ9D7iP43OQVv/9ximzuR72PFO+ecnIKDXUjXN7YAS34Q2Fpc2gdd8U0j2w9Q3NR4oVHvPiBPPj3f6f9ppNTFywJw4tOoxPjGiVr7FS/4HhCaBOTXeYMEvChUycOpjSTlyUEp9BaVRy/bkUyQdFIrKAr6i2L2xrNIU5qMlSbK/lLDf2t9Qktm2NbTZJBR6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5GK/SRnyvxDk0UH/yjYL38NqanFe4eDxBiMo/yr8fg=;
 b=KiuoMFEUt9dJziYshMlUv+wSQBolN5oQ+A6er/e3h+EWLMTdjn0lMiVuBrzdl/WGjS50KzjwggFoJ+qfA5Usz7rwxL4GTrcWgyTPEG464jhxxt1OLJ15lkyzrvavBts25JGJP0JQFHy4hj5IGQh/z5jDZdYvvd3htps6Swb5GR8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5201.eurprd04.prod.outlook.com (20.177.42.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 11:36:44 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 11:36:44 +0000
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
Subject: Re: [PATCH] clk: imx: imx8mn: add IMX8MN_CLK_SAI7_IPG clk
Thread-Topic: [PATCH] clk: imx: imx8mn: add IMX8MN_CLK_SAI7_IPG clk
Thread-Index: AQHVkuiWYOV+kg2wl0yC3cmY9ucIdad8dMaA
Date:   Tue, 5 Nov 2019 11:36:44 +0000
Message-ID: <20191105113643.542aaahiiabccrm7@fsr-ub1664-175>
References: <1572855483-10624-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572855483-10624-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::39) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfb30290-4e7f-4b22-c155-08d761e46f6e
x-ms-traffictypediagnostic: AM0PR04MB5201:|AM0PR04MB5201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB52014C7DC64056DB34E61F4FF67E0@AM0PR04MB5201.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(66556008)(64756008)(66066001)(54906003)(476003)(102836004)(7736002)(6636002)(76176011)(256004)(8936002)(66476007)(478600001)(6486002)(8676002)(386003)(26005)(66446008)(6246003)(71190400001)(71200400001)(81166006)(6436002)(2906002)(6116002)(99286004)(1076003)(3846002)(6512007)(9686003)(229853002)(6506007)(4326008)(305945005)(86362001)(5660300002)(52116002)(316002)(186003)(446003)(486006)(44832011)(81156014)(11346002)(66946007)(25786009)(53546011)(14454004)(6862004)(33716001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5201;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fAXWuLVaXwe+As2wxEqp3IVM+ePW0hzEEZUczrcrjdIs2enmAXNIv1NOqruPr3xnIO+/877EOoxPlNoIOtO2numhpLJnzI5BjcMLjjO8VTWFRD5jeOI7eEOEPhowSGMUje6drfpAoHdpCBn3tg9yJpMLsE1Vl5SCEDaZTa35NN08CN8IAF5RSMuuWTc4+I/pRE9BubUouCM/6A3wzYy2uGazThU/Vv8zvuwNQaDxi+noVyCU/QlW3N8BpL9eZn/eGYvNFNTVcWRgdPpW0fcJzGGAyzD0hv0J//ksqVoFtSlug0U1knIb5L1Exeyxv0CXZeiyOGA17Yr8GKPyRdEMPRBbamnvKK8HX8yrTP4pxgu3ACnsAHOw95mCCEl5xoFPRxjGi2P9mLQVMqwJLlm2efV+r2RdpAFG4WOl8F/Mh7XoGOvTDy7I4+d1PifcD7iq
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5F8A37A58208042ABF7A82BFBFA95FD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb30290-4e7f-4b22-c155-08d761e46f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 11:36:44.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gciK5sSkgLDeMppey5ojrx1hkKbw4QNao7hjEB0as2uxY1MKtamJmmfh5pdYg+8g874amkJ6V2usxvrHJa/L3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-04 08:19:33, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> It does not make sense to use shared count for IMX8MN_CLK_SAI7_ROOT
> without ipg clk. Actually there are ipg clks for other sai clks,
> let's add IMX8MN_CLK_SAI7_IPG clk.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-imx8mn.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 838f6e2347f1..5e801892c631 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -556,6 +556,7 @@ static int imx8mn_clocks_probe(struct platform_device=
 *pdev)
>  	clks[IMX8MN_CLK_SDMA2_ROOT] =3D imx_clk_hw_gate4("sdma2_clk", "ipg_audi=
o_root", base + 0x43b0, 0);
>  	clks[IMX8MN_CLK_SDMA3_ROOT] =3D imx_clk_hw_gate4("sdma3_clk", "ipg_audi=
o_root", base + 0x45f0, 0);
>  	clks[IMX8MN_CLK_SAI7_ROOT] =3D imx_clk_hw_gate2_shared2("sai7_root_clk"=
, "sai7", base + 0x4650, 0, &share_count_sai7);
> +	clks[IMX8MN_CLK_SAI7_IPG] =3D imx_clk_hw_gate2_shared2("sai7_ipg_clk", =
"ipg_audio_root", base + 0x4650, 0, &share_count_sai7);
> =20
>  	clks[IMX8MN_CLK_DRAM_ALT_ROOT] =3D imx_clk_hw_fixed_factor("dram_alt_ro=
ot", "dram_alt", 1, 4);
> =20
> --=20
> 2.16.4
>=20
