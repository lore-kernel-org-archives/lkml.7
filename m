Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1FAC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D31820665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M7qr/Ft5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfG3V0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:26:06 -0400
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:29538
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387646AbfG3V0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:26:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3qSgI0tK6xOr5nEte/WuwZVmiC4m2zb4hjnO7OnIpltHkYMWmLoJsD9SyqqXR5fr7BV1bu2KmMLJDIi06lJpJfXDs5zAUaUertQwFwWH+VBvsVKHGLdPrF9Mp28tZh3UD3J2REDDRLFK+eyNA0BUi9zlvcgNHN7y9YzquA+7Znjs5BVCH8UG0sW2FyNfZS3OC3gs2JeEDvSAwgBA6nkRBHzDo9bWBCBaALnu1AHiEA+tD9AHD5H4Ov9sTzbbMAGph56Aoka1d/9QeKLuCytVZB6xJ7Yku/vF0CrYWtef1cGgHJuCXwinmJEScQF0f3SW98w0WySnUdm9c7QXKfN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KnYgtxTLK4tjSTwb9zJm07cL3uTEWGXR8smzCRkX4k=;
 b=A6K74LNEXk9tSG0Kn0mXPGLyd2WSXEL0Nr71WvRh6gdRRRO4bhnGUJjcJ0EM7+NpJ/rLGBaaOxUeKMNm3oBrOdjnnwNU5o8qPEqb1F1i8otDkN9q3Azg0OjL3L5A4xcbl1vQZM6SX7Q5fjUA6rNau0js+Q4UgoxmRNC0TZRVb4Z3yMaYDSpmo49OSCyj7MrRlGqmc2NtDqT182Wl/pPcTSSKTTMpgyhpdR3AR3tPmRuG4E4w6GsGLU2JCKIQAv4ERM5ANqHswkgO3ULUjxnc+LwXQOsCPAqsma+Ug5cvklO5yi6s7zyo8sPYAQC3MLHdrMbmMTFHQcurKwgMpSXfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KnYgtxTLK4tjSTwb9zJm07cL3uTEWGXR8smzCRkX4k=;
 b=M7qr/Ft58wsoag+V7oz/6eZj6TOuE+xun1fTJzxjredmCnf4PsIXJxLau0tWIexZLy2GmGdLuXTVBwKdaOElHkU1xFAmF6syWBycgUHGcnkP9qSn1Yn4ypVDcaTjsbjyU4/G5D7tvKeIvv5Otsm1gor7JM2lMvtH2VU7/iY42WU=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.235.152) by
 VE1PR04MB6463.eurprd04.prod.outlook.com (20.179.233.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 21:26:01 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::3d61:6e52:a83c:7c59]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::3d61:6e52:a83c:7c59%6]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 21:26:01 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v6 40/57] soc: Remove dev_err() usage after
 platform_get_irq()
Thread-Topic: [PATCH v6 40/57] soc: Remove dev_err() usage after
 platform_get_irq()
Thread-Index: AQHVRwLsgxvK/p3xe0OrkqH352Tx2qbjfPqAgAAvHfA=
Date:   Tue, 30 Jul 2019 21:26:01 +0000
Message-ID: <VE1PR04MB668744C680C7AC2498AE9A478FDC0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-41-swboyd@chromium.org>
 <20190730183503.GX7234@tuxbook-pro>
In-Reply-To: <20190730183503.GX7234@tuxbook-pro>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25bd870a-daed-49be-6a38-08d715348576
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6463;
x-ms-traffictypediagnostic: VE1PR04MB6463:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VE1PR04MB646337D4D58F6DB886B0DD328FDC0@VE1PR04MB6463.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(13464003)(189003)(199004)(68736007)(11346002)(71190400001)(9686003)(256004)(71200400001)(186003)(26005)(110136005)(486006)(6506007)(102836004)(76116006)(53936002)(53546011)(54906003)(305945005)(6246003)(99286004)(66556008)(66476007)(81166006)(8936002)(478600001)(229853002)(64756008)(3846002)(4326008)(25786009)(76176011)(66946007)(2906002)(66446008)(316002)(14454004)(52536014)(6116002)(14444005)(446003)(81156014)(7736002)(33656002)(8676002)(55016002)(7696005)(6436002)(74316002)(66066001)(5660300002)(476003)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6463;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O+oIWJoHriOAUIhmwH6fVJVn+mU5aLXcQhvLVagVsfSSEqTMyvz8kdAOavy/ijCtpBuEbHcOcqNUmitCGh6jsuMW60OAOeQn29CjVGImx09LFRJoh9Ktl0IirC0YLMwegTo9Jy+D7U433sza0WsvKUqO0Tvi8HSaqDmsXPsoXwL3Wg2C6oYyT9bk+tM2meo+IO5qb2BiO+NhCyHOkyuI/kM7RqgXkCH+CYt3h8U6WWBPoLfCgkBGh21L1WGi+YnTi72e+/4YWQ4Y/heK0U2fZ49V9z2mzkZsCzv2q7sg8Qp2i+MLOuudsDWwzWremY8Lrd4ZCouSFsEkt7rDP3xLhjEB2PkZnWpf9xww5WB89jt9O7V0F/X0YzzmzuOCarNMyAgpXKIgOZ0J+/1drN5kN1i/U+BSuJyPn9qhwY9gIk8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bd870a-daed-49be-6a38-08d715348576
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 21:26:01.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leoyang.li@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> Sent: Tuesday, July 30, 2019 1:35 PM
> To: Stephen Boyd <swboyd@chromium.org>
> Cc: linux-kernel@vger.kernel.org; Andy Gross <andy.gross@linaro.org>;
> Thierry Reding <treding@nvidia.com>; Leo Li <leoyang.li@nxp.com>; Simon
> Horman <horms+renesas@verge.net.au>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: Re: [PATCH v6 40/57] soc: Remove dev_err() usage after
> platform_get_irq()
>=20
> On Tue 30 Jul 11:15 PDT 2019, Stephen Boyd wrote:
>=20
> > We don't need dev_err() messages when platform_get_irq() fails now
> > that
> > platform_get_irq() prints an error message itself when something goes
> > wrong. Let's remove these prints with a simple semantic patch.
> >
> > // <smpl>
> > @@
> > expression ret;
> > struct platform_device *E;
> > @@
> >
> > ret =3D
> > (
> > platform_get_irq(E, ...)
> > |
> > platform_get_irq_byname(E, ...)
> > );
> >
> > if ( \( ret < 0 \| ret <=3D 0 \) )
> > {
> > (
> > -if (ret !=3D -EPROBE_DEFER)
> > -{ ...
> > -dev_err(...);
> > -... }
> > |
> > ...
> > -dev_err(...);
> > )
> > ...
> > }
> > // </smpl>
> >
> > While we're here, remove braces on if statements that only have one
> > statement (manually).
> >
> > Cc: Andy Gross <andy.gross@linaro.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> > Cc: Li Yang <leoyang.li@nxp.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Please apply directly to subsystem trees
> >
> >  drivers/soc/fsl/qbman/bman_portal.c | 4 +---
> > drivers/soc/fsl/qbman/qman_portal.c | 4 +---
> >  drivers/soc/qcom/smp2p.c            | 4 +---
>=20
> If you had split this in a fsl and a qcom patch I would have just merged =
the
> latter.
>=20
> I don't see a problem with Li taking this patch through the Freescale tre=
e
> though (or vise versa).

The patch looks good to me too.  I can take it through my tree with your re=
viewed-by.

Regards,
Leo
>=20
> Regards,
> Bjorn
>=20
> >  3 files changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/soc/fsl/qbman/bman_portal.c
> > b/drivers/soc/fsl/qbman/bman_portal.c
> > index cf4f10d6f590..e4ef35abb508 100644
> > --- a/drivers/soc/fsl/qbman/bman_portal.c
> > +++ b/drivers/soc/fsl/qbman/bman_portal.c
> > @@ -135,10 +135,8 @@ static int bman_portal_probe(struct
> platform_device *pdev)
> >  	pcfg->cpu =3D -1;
> >
> >  	irq =3D platform_get_irq(pdev, 0);
> > -	if (irq <=3D 0) {
> > -		dev_err(dev, "Can't get %pOF IRQ'\n", node);
> > +	if (irq <=3D 0)
> >  		goto err_ioremap1;
> > -	}
> >  	pcfg->irq =3D irq;
> >
> >  	pcfg->addr_virt_ce =3D memremap(addr_phys[0]->start, diff --git
> > a/drivers/soc/fsl/qbman/qman_portal.c
> > b/drivers/soc/fsl/qbman/qman_portal.c
> > index e2186b681d87..991c35a72e00 100644
> > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > @@ -275,10 +275,8 @@ static int qman_portal_probe(struct
> platform_device *pdev)
> >  	pcfg->channel =3D val;
> >  	pcfg->cpu =3D -1;
> >  	irq =3D platform_get_irq(pdev, 0);
> > -	if (irq <=3D 0) {
> > -		dev_err(dev, "Can't get %pOF IRQ\n", node);
> > +	if (irq <=3D 0)
> >  		goto err_ioremap1;
> > -	}
> >  	pcfg->irq =3D irq;
> >
> >  	pcfg->addr_virt_ce =3D memremap(addr_phys[0]->start, diff --git
> > a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c index
> > c7300d54e444..07183d731d74 100644
> > --- a/drivers/soc/qcom/smp2p.c
> > +++ b/drivers/soc/qcom/smp2p.c
> > @@ -474,10 +474,8 @@ static int qcom_smp2p_probe(struct
> platform_device *pdev)
> >  		goto report_read_failure;
> >
> >  	irq =3D platform_get_irq(pdev, 0);
> > -	if (irq < 0) {
> > -		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
> > +	if (irq < 0)
> >  		return irq;
> > -	}
> >
> >  	smp2p->mbox_client.dev =3D &pdev->dev;
> >  	smp2p->mbox_client.knows_txdone =3D true;
> > --
> > Sent by a computer through tubes
> >
