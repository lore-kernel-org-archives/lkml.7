Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3349C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0C9218BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QCBUwvdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfGEIwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:52:23 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:49479
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfGEIwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fgAuLLLFfyUVk/o5jZw3vrfUXIp2EBF7mInEqJ7ne0=;
 b=QCBUwvdyaFmjNuT7K285UCjZyE//6vRx/CWSiLsCVYh8QVwBzZObZWkMVnvdkJnfxE4anYvGwUjHAVNSzpFCbtqq7IM6HCLr3qm7GbaDF4/lB+SRrNB0ghpQDajPjNZ6hRjNM0pKw9+MTWbeZBbeQ/wpJ1s2B1LsxXLUpFronYs=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4050.eurprd04.prod.outlook.com (52.134.91.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 08:52:19 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2032.019; Fri, 5 Jul 2019
 08:52:19 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx8mq: Mark AHB clock as critical
Thread-Topic: [PATCH] clk: imx8mq: Mark AHB clock as critical
Thread-Index: AQHVKzSu7JwgQZ2S+Eecj9cXfCskNaas9UwAgA7SMQA=
Date:   Fri, 5 Jul 2019 08:52:19 +0000
Message-ID: <20190705085218.lvvqnqx6nfph2era@fsr-ub1664-175>
References: <1561453316-11481-1-git-send-email-abel.vesa@nxp.com>
 <20190625223223.3B8EC2053B@mail.kernel.org>
In-Reply-To: <20190625223223.3B8EC2053B@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 371c65a2-b14a-4157-c108-08d701261696
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4050;
x-ms-traffictypediagnostic: AM0PR04MB4050:
x-microsoft-antispam-prvs: <AM0PR04MB405076CA7695BC3A4DF0223DF6F50@AM0PR04MB4050.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(6512007)(68736007)(71190400001)(316002)(99286004)(476003)(9686003)(6506007)(478600001)(102836004)(76176011)(446003)(53546011)(8936002)(71200400001)(53936002)(186003)(54906003)(66066001)(44832011)(6916009)(7736002)(486006)(6246003)(305945005)(5660300002)(4326008)(6116002)(26005)(66946007)(76116006)(3846002)(14454004)(73956011)(66476007)(91956017)(66446008)(64756008)(11346002)(86362001)(66556008)(1076003)(6486002)(256004)(25786009)(229853002)(8676002)(2906002)(81156014)(33716001)(81166006)(14444005)(6436002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4050;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: udm5GVIf1ptBRrhMoptsldP69SzdOKSceS9ONCPHnnsD2C17StC70B9y6Ty/01UXn+bkxp19IAr737+v4G3GCgynRv4s2ejtluw2gVVvD0pIjI8wb7j+8Zge6vYAcbc0SxqoYMb9AHQWryyJVDKtX5L3DQebPzDhNjeV0P1eMpwPpnQzTSEezglLq/DQ4Dqm42CdxtO/M4Wal1unObAEqVtXpaGe/zudOmItvv8FqTv8TM1u3OZvGBfaAHNTlxt0C0lfAfDOIoGo7JGkWHukl96soTvQTwrmtGN1wWeYDVd4SJwpcUNqHmQd+DiurH1NsWdPrBIv64ZNVwwFVe6uXdr79cf8kfIGIK/k+os5kda8aq6qz77WRolwjm8MUJsdXJUaWsNKJMf7RZ7DVmCpWPtc8JLa26VR40fpeBi++jU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7A1A9AF93997B4D8F832386EBDF5AA4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371c65a2-b14a-4157-c108-08d701261696
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 08:52:19.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-25 15:32:22, Stephen Boyd wrote:
> Quoting Abel Vesa (2019-06-25 02:01:56)
> > Keep the AHB clock always on since there is no driver to control it and
> > all the other clocks that use it as parent rely on it being always enab=
led.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8mq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.=
c
> > index 5fbc2a7..b48268b 100644
> > --- a/drivers/clk/imx/clk-imx8mq.c
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -398,7 +398,7 @@ static int imx8mq_clocks_probe(struct platform_devi=
ce *pdev)
> >         clks[IMX8MQ_CLK_NOC_APB] =3D imx8m_clk_composite_critical("noc_=
apb", imx8mq_noc_apb_sels, base + 0x8d80);
> > =20
> >         /* AHB */
> > -       clks[IMX8MQ_CLK_AHB] =3D imx8m_clk_composite("ahb", imx8mq_ahb_=
sels, base + 0x9000);
> > +       clks[IMX8MQ_CLK_AHB] =3D imx8m_clk_composite_critical("ahb", im=
x8mq_ahb_sels, base + 0x9000);
>=20
> Please add a comment into the code why it's critical.

Comment explaining why the AHB bus clock is critical ?
Isn't that self-explanatory ?

>=20
> >         clks[IMX8MQ_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb",=
 imx8mq_audio_ahb_sels, base + 0x9100);
> > =20
> >         /* IPG */
> > --=20
> > 2.7.4
> > =
