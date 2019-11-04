Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E806CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9BF2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Chmri8aO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfKDIVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:21:33 -0500
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:54018
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfKDIVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:21:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaNn8DdGpEaBrALSPMfZqadWYlSQcF3ZjnQ3xOqrzZ9I8waGnBd6EmsLCSjHdbd5YjK9uYJJ9oHrg4NGU5XG9NQC7HNv24qlMSHGdzY33I9C+QcJyB9Mu/73Wbh0kfPku31AQ3iYSzgi+dPLNXjGdQPNVufmzw8n9GPv2QDnGcDdCKs/RQ/fn7+4qOAplbQ2kZwWWG0Au+CvYl68VXXO1dsWz9I1fQcgg9K4X60hf8zzd72l6uZ8ECOUY7aHFz7toulKArOwKrAvz/Uu6U/HbY9hAoO20+prpfykBwXlmjwcnK3Iu4zxWKMDkQy3gykJdzOothaKRkEhPq14+AI1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RilCkss77TeLxKUVQcHdpjD+XmztKI3ZNQLE/dyurls=;
 b=bQJnphs/+UUzbLWlX8I2EiQS3osJiexmFpX2sctWXL66UaU8GsbAoZLpxEm3ZzO4wfQifgCaZQje+cgXd8J6aasGwREV/jtSAe8YQQJ47hGHO5r5xC13/MRyJdA/J0UEtt14V18lvRE3QCUPFzMx725TNDx4Dr/wVWKNRVEf9/zhxxN8lfe2lw0TBp1kQR/Dwg/GR3zKG89/Reu6x6fsxIGjDzMZw+tFpXlmzIvpD9XXuc4J8wsR8oVO74J3+xJTyR6sAwnpzTwnh426NKigJSMSKvkkYxwLX/tAO45lWpLKf5lwr558hlYlVC7fR9EkuU1WWsB1r7ng62kLZb6SEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RilCkss77TeLxKUVQcHdpjD+XmztKI3ZNQLE/dyurls=;
 b=Chmri8aOWeFtoxpQ67GboFVoZw1hWaXZ0cIWGn8VeWa55JMU/4n4Vz2MJqOLRfyKyqqu7f8ZmlxRXw6HgjjEEm+IEEH5jXB/7hRJabqF43sVuKU1+dk3nLSEPjWL2wqXXTv7kFB9NJepOUsDe/4iNpBEiFLufwm7TcrLeUOAY5M=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6212.eurprd04.prod.outlook.com (20.179.36.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 08:21:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 08:21:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH] clk: imx: imx8mn: add IMX8MN_CLK_SAI7_IPG clk
Thread-Topic: [PATCH] clk: imx: imx8mn: add IMX8MN_CLK_SAI7_IPG clk
Thread-Index: AQHVkuiWYOV+kg2wl0yC3cmY9ucIdad6q63w
Date:   Mon, 4 Nov 2019 08:21:27 +0000
Message-ID: <AM0PR04MB44810E5691E823CD4259F920887F0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1572855483-10624-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572855483-10624-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f61ee09d-d36d-4881-9e0b-08d760fffcfd
x-ms-traffictypediagnostic: AM0PR04MB6212:|AM0PR04MB6212:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6212080DA19CC96544712828887F0@AM0PR04MB6212.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(2906002)(305945005)(7736002)(66066001)(52536014)(256004)(25786009)(3846002)(6116002)(81166006)(186003)(476003)(26005)(2201001)(76176011)(7696005)(316002)(81156014)(86362001)(54906003)(44832011)(6246003)(99286004)(8936002)(110136005)(66556008)(66476007)(6636002)(5660300002)(102836004)(4326008)(8676002)(486006)(9686003)(33656002)(966005)(6436002)(229853002)(55016002)(74316002)(14454004)(11346002)(446003)(478600001)(71200400001)(6506007)(71190400001)(76116006)(6306002)(64756008)(66446008)(2501003)(66946007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6212;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lY5NU6Dz9T2axX6HWE3ITKfQBs0OuY2C0fGrhxj2ooEVPG+bU7dNa/RdkxZOX/2w57EIlgKD7Bbvns5D+sKpXGWsn/OQqESaLJLQf3QH4ssTjVPdrbJ4RqDmQwGSsPW0Yw0hl8pKbu8zJ5skzoMf/CApMTE6MtsyqWlZCV2qei4rcPuItwbS03hdeTGMbauCwJP390vwMkpVH2CeC3QssnDzrVF5CkWRA4gOzPybf0XLULuq20Em71T7+C89D8uFj15a/7lzJQkKmDLXQYg/4jrwbjPUXx+IFHz7trq2UC6Lv8YwzEjaH1pC/ePDDKCPq4ioFBJYryT5HL54crPO7xwk8g/I8jsc4uPsaH4cFJm/JcWE2VexNgDWW+qfMl60Ke7EJE1ezjZLUuohDQCVaKrVxAkhHAWfz+MfAGlReQm4oMPZacpbBco7w0EOGeDgCSOYbbe4wn/WVpq/GvPGFq8F5+Rd7bIdrgEZNxG5IlI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61ee09d-d36d-4881-9e0b-08d760fffcfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 08:21:27.2751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIB+Q3A4JHHC965h92ybuzMYMpo697I+xCwXEvdAngLb3/vsJOvuUqUrUUMwCcGV+bvFWH8A/xK0GhwL/WqK8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: imx8mn: add IMX8MN_CLK_SAI7_IPG clk

Missed to add, patch was made based on clk_hw API patch
https://patchwork.kernel.org/patch/11224941/

Thanks,
Peng.
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> It does not make sense to use shared count for IMX8MN_CLK_SAI7_ROOT
> without ipg clk. Actually there are ipg clks for other sai clks, let's ad=
d
> IMX8MN_CLK_SAI7_IPG clk.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mn.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 838f6e2347f1..5e801892c631 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -556,6 +556,7 @@ static int imx8mn_clocks_probe(struct
> platform_device *pdev)
>  	clks[IMX8MN_CLK_SDMA2_ROOT] =3D imx_clk_hw_gate4("sdma2_clk",
> "ipg_audio_root", base + 0x43b0, 0);
>  	clks[IMX8MN_CLK_SDMA3_ROOT] =3D imx_clk_hw_gate4("sdma3_clk",
> "ipg_audio_root", base + 0x45f0, 0);
>  	clks[IMX8MN_CLK_SAI7_ROOT] =3D
> imx_clk_hw_gate2_shared2("sai7_root_clk", "sai7", base + 0x4650, 0,
> &share_count_sai7);
> +	clks[IMX8MN_CLK_SAI7_IPG] =3D
> imx_clk_hw_gate2_shared2("sai7_ipg_clk",
> +"ipg_audio_root", base + 0x4650, 0, &share_count_sai7);
>=20
>  	clks[IMX8MN_CLK_DRAM_ALT_ROOT] =3D
> imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
>=20
> --
> 2.16.4

