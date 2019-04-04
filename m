Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EBAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60305206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G55B8Scg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfDDH3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:29:01 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:16021
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbfDDH3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao+mOIQkPe1OpvOkEKaeaQGV10WbVR3fnXq5wPM2HR4=;
 b=G55B8ScgE07KNX9gC8j/ZE82vDtgq6gEXgT6a0P/79UU6LGgdTVzpKWpHfjH63VotAONcB0CGQSBO+YR2Cmz46uhnt8BG+wGNPG0ABXgp1ylyMLnOOu2uDTz5R2hHug5mRTS0FGMXVh7fQHvYfDRhl3M8flbw77sqULvhSX2MhM=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5200.eurprd04.prod.outlook.com (20.177.51.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Thu, 4 Apr 2019 07:28:57 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::6462:e965:413a:e1c1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::6462:e965:413a:e1c1%3]) with mapi id 15.20.1750.014; Thu, 4 Apr 2019
 07:28:57 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH 5/5] usb: chipidea: msm: get optional clock by
 devm_clk_get_optional()
Thread-Topic: [PATCH 5/5] usb: chipidea: msm: get optional clock by
 devm_clk_get_optional()
Thread-Index: AQHU5tr32Yus0+PYTEa0T3lsIXLCKKYrokxA
Date:   Thu, 4 Apr 2019 07:28:57 +0000
Message-ID: <VI1PR04MB53271D981843769FEFDD60E78B500@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <2ec86ffd7de45dabaa7257019a79f1e80751934c.1553937592.git.chunfeng.yun@mediatek.com>
 <2f4b8d77c6ec99ef6cc8e71155d820e080ad9af5.1553937592.git.chunfeng.yun@mediatek.com>
In-Reply-To: <2f4b8d77c6ec99ef6cc8e71155d820e080ad9af5.1553937592.git.chunfeng.yun@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5188c489-6710-47bd-292d-08d6b8cf331a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5200;
x-ms-traffictypediagnostic: VI1PR04MB5200:
x-microsoft-antispam-prvs: <VI1PR04MB5200B7CB26FFC91539BED19B8B500@VI1PR04MB5200.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(86362001)(44832011)(6506007)(7736002)(52536014)(66066001)(99286004)(7696005)(316002)(11346002)(76176011)(4744005)(68736007)(5660300002)(81156014)(81166006)(54906003)(478600001)(102836004)(8676002)(110136005)(3846002)(105586002)(14454004)(4326008)(476003)(486006)(6246003)(33656002)(9686003)(106356001)(8936002)(446003)(55016002)(6436002)(25786009)(26005)(229853002)(256004)(71190400001)(71200400001)(2906002)(74316002)(186003)(6116002)(53936002)(305945005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5200;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z8tbVzlflDmTmdZc1CgpCeLUcHRgvOQXdlno1EsJ5ruxCpcZBNazp2P+pWVos/NXK70xdBNr6zPzoGsZ4ZS49JOq/F8lk+NUnEtKlcFAdzJoG8LaMFF41GEs8YJrH2nMJgfP16S8Qpt8Q6L/omPaVC+5aqxwqGAGHdPpQZ1oQHZWJGe1H9OHQui2l/3SKL5gNzuxQ10V1khctXQlTwtwuUBJoymrpXSn585BPRvjArqXkvvc/tguldOVDwYS5ITSVSrDFw/hLrJOWxLsukhMutmuZs5ytXpRqyWhcxzg/NWKqZs6UtdqkJNdbvxkRbrB6LrV2fVlgFRJ/51osWsMQfI5b2R+vLYt/cYHLFdgsHF7vxJSAGIbycbdbIVNSpFGeoQ4xds3O/PFfzXsDotIoUZogKBkeA83KpbvI+PLVk4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5188c489-6710-47bd-292d-08d6b8cf331a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 07:28:57.3506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>  drivers/usb/chipidea/ci_hdrc_msm.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c
> b/drivers/usb/chipidea/ci_hdrc_msm.c
> index 880009987460..b8b3caad889c 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -205,12 +205,9 @@ static int ci_hdrc_msm_probe(struct platform_device
> *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>=20
> -	ci->fs_clk =3D clk =3D devm_clk_get(&pdev->dev, "fs");
> -	if (IS_ERR(clk)) {
> -		if (PTR_ERR(clk) =3D=3D -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -		ci->fs_clk =3D NULL;
> -	}
> +	ci->fs_clk =3D clk =3D devm_clk_get_optional(&pdev->dev, "fs");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
>=20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	ci->base =3D devm_ioremap_resource(&pdev->dev, res);
> --
> 2.20.1

Acked-by: Peter Chen <peter.chen@nxp.com>
