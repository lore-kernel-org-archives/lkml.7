Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542CDC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E187217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1W/cvQwH";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1W/cvQwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfKFRwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:52:00 -0500
Received: from mail-eopbgr50042.outbound.protection.outlook.com ([40.107.5.42]:2214
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbfKFRv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ipv5bL6v/AFxOVK/z8rESLfOAYZ98PHBjQVkKUKY8YY=;
 b=1W/cvQwH1DHJJhSgf5jd0t9f6HFzeWniVs3WunxCFeo0L1eWBUitVWcsg+14YHE86eCifKoELXUerOV3A9BwBVJsYhrcbDaaNQL7yyFmlU8dPdG/uTUR3r9Uj8LfoW3dMWWYLvjrVFMsW+E8UJS1xqVuwVJ6qfZK5viBJR7NUEU=
Received: from HE1PR08CA0063.eurprd08.prod.outlook.com (2603:10a6:7:2a::34) by
 HE1PR0801MB1818.eurprd08.prod.outlook.com (2603:10a6:3:7b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 17:51:53 +0000
Received: from AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by HE1PR08CA0063.outlook.office365.com
 (2603:10a6:7:2a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 17:51:53 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT040.mail.protection.outlook.com (10.152.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2430.21 via Frontend Transport; Wed, 6 Nov 2019 17:51:53 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Wed, 06 Nov 2019 17:51:51 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a289ec9c161cbd34
X-CR-MTA-TID: 64aa7808
Received: from cc64c54e40ce.1 (cr-mta-lb-1.cr-mta-net [104.47.10.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1A7515C2-77E5-4A4C-B19A-689A266CB20F.1;
        Wed, 06 Nov 2019 17:51:46 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cc64c54e40ce.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 06 Nov 2019 17:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJymDEVR4BjZIOrCtnNpypwWKnZx73R2lLEepPEF80XIL/BVUr1wf92VSQ946jMny0pWIbhC+3H6NnKEPbDkMd3cQ0BHl9prYRd2DiTn9XWygKXPN3JpbfF6URm8ueowfbIpFb5eMNpcp0/bGasGMbdQUfZQkfqQlBqxzDkJpSvYh0BDjNG+6JT7HBCx4HJztlV1SKRSPio++HcdZA8e4/WcMWwAvvIBJ+8Kco0Xx5lFhHGVLySH4893Z4XwNXMEvFZO2WvHhCyRDrgPE8HKaaqGrDPpxNh7tDHMvteL6HW//NqeIFg5KZ20O99USc39dGhlNC6KYI7Iugqo0soHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ipv5bL6v/AFxOVK/z8rESLfOAYZ98PHBjQVkKUKY8YY=;
 b=liZXZMq4N8KWL9viasjchV6wa+ib3sYemBL92+a2Od1MAhE2Xwm0pecRAmCngIdeOfPGr9qT4YMLkyHsNB98QnO527h2qd4WlSQRYGhsesvTJLadsiSbk9zm4oR+CqROsK0/S61C1ylkhHFhzBgx55oL9OhsvGMzqvRTU/iLVKrzYf9MsYmekhBvgQUhN+pAOHnEQtz6jRMx0Nzrbq1TE/m1kk+dv/JvBiWchv4WOICtz6E1p7OjujlqzFs3eHi3L0Cv+RJzpqQvXb/brgJtRK+g9u6SRyFqve/oRfqXVhg+cDY6B4rStENFOX15jngkR/8M3cDYWElBc80KmfBqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ipv5bL6v/AFxOVK/z8rESLfOAYZ98PHBjQVkKUKY8YY=;
 b=1W/cvQwH1DHJJhSgf5jd0t9f6HFzeWniVs3WunxCFeo0L1eWBUitVWcsg+14YHE86eCifKoELXUerOV3A9BwBVJsYhrcbDaaNQL7yyFmlU8dPdG/uTUR3r9Uj8LfoW3dMWWYLvjrVFMsW+E8UJS1xqVuwVJ6qfZK5viBJR7NUEU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB5533.eurprd08.prod.outlook.com (52.133.244.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 6 Nov 2019 17:51:45 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 17:51:45 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: drm/komeda: Use devm_platform_ioremap_resource() in
 komeda_dev_create()
Thread-Topic: drm/komeda: Use devm_platform_ioremap_resource() in
 komeda_dev_create()
Thread-Index: AQHVfn+X0ywwD9NhU0O9ZT09tcfr2Kd+kFmA
Date:   Wed, 6 Nov 2019 17:51:43 +0000
Message-ID: <28103957.GdvMQdgHhr@e123338-lin>
References: <64a6ea39-3e4b-2ebe-74f7-98720e581e3e@web.de>
 <20191009085704.GA26615@jamwan02-TSP300>
In-Reply-To: <20191009085704.GA26615@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0478.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::34) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71738190-8277-449b-1792-08d762e2021b
X-MS-TrafficTypeDiagnostic: VI1PR08MB5533:|VI1PR08MB5533:|HE1PR0801MB1818:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB18187FC1CE07025066AE4E818F790@HE1PR0801MB1818.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 02135EB356
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(386003)(64756008)(66556008)(66446008)(6506007)(66946007)(102836004)(5660300002)(66476007)(305945005)(71190400001)(81156014)(6486002)(86362001)(76176011)(486006)(33716001)(52116002)(6436002)(81166006)(8676002)(446003)(71200400001)(476003)(11346002)(9686003)(6246003)(6512007)(2351001)(5640700003)(2501003)(26005)(25786009)(186003)(8936002)(4326008)(6306002)(6116002)(3846002)(478600001)(229853002)(7736002)(99286004)(14454004)(966005)(256004)(316002)(2906002)(54906003)(14444005)(66066001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5533;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vXwzzM7EYQuQCoBmEwIo/DQLZq5WQWtOTUh6D6K+VKR0XKJMYIxbX3xRG0ES4yMmD3wsW6Blg/QBLYhN2+Ge4ZnnzCKtrnpSEnGSIflQryyc7Tu8xF2xNxODPGPerzQR9G/Y8g2De9TRL1Y78hhG9A1Hj0QvCk7WZrgmvVnZawpwC7fgpMW22nrzCtVzoqTiHiKqZSLpAQRxHE4+Pk2rTER2QSIb/lV9B99jA5w7NFhGO3kiv4GyHy1p8rnN7cdZcpHGVZAKqZDHdSccaHwJRUu+JXdAxyvlCjaIiDV8ompDg8knYTioOExpW5F6hPf+nwBl5wNw6oZTvP/nZlU7Hb/iO3zkSEjHLepaDjE5s8X19HhibemWMNC/pdINCCNdX55wUZBm16ELYVujmjVKXSMympht9eAtrHzW5/s7xOlrWFI9oHJBOisx2EZ767tF3Zps8tjn152Fw5hpm6Xl9ADZegKDgYlDDPBxxctsleI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <184B2102DD5CE648896FEEA08791FEB1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5533
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1110001)(339900001)(199004)(189003)(54906003)(5640700003)(86362001)(22756006)(66066001)(8746002)(450100002)(2906002)(305945005)(81166006)(81156014)(70586007)(478600001)(966005)(26826003)(7736002)(99286004)(36906005)(316002)(25786009)(26005)(2501003)(47776003)(2351001)(3846002)(6116002)(105606002)(356004)(76130400001)(50466002)(23726003)(102836004)(6506007)(386003)(14454004)(70206006)(8676002)(8936002)(46406003)(6512007)(33716001)(11346002)(9686003)(6306002)(126002)(486006)(446003)(476003)(4326008)(14444005)(186003)(336012)(6862004)(6486002)(5660300002)(229853002)(76176011)(97756001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1818;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: af046850-12c4-428a-10f7-08d762e1fc27
NoDisclaimer: True
X-Forefront-PRVS: 02135EB356
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBLvvWXGtHkbFtxpkIdtoJGC/HS1GpWzjh+ybSr4ucsMcUJr8K6oT/rgg3glB/233b3YyXLbmbhj4YYFqTGOgDhvf9x7Ye597iXRrgiMHmxMxxwi9GQzyKd2jcmYMxUMp9V6zJVVWmT3HKC8SVDybzFWsa1TT5CGK5oZLp2F5XR+w9puTrVXtZAn6N+akMcstz276mvKf96btDMwzl55Kr5dxVam0ARyDKPfYVWaiY0cV6mfSxWYI4Eyautix/oXXTSZRVMWtY4QStEj55cq35INL05E7qyMhyMxpRdWkFfVuJ/2PMTqh7sMGKQlpdLnfyHNxSySkxyzKIRtXDl8MuBOMRslWqFdVd2CsPn6rDL4QK62lCkiUalisnewcuxFAOVhXaaxqvY6DrBgBobmFipNRJwLfhq07HdDooda2wAYqYznvFqXjGcKYefzKwX35KeuWzIxtbLmEhaLOxC6F+9vQO6IEKx/0SMAsNlul8M=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 17:51:53.2844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71738190-8277-449b-1792-08d762e2021b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1818
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 9 October 2019 09:57:11 GMT james qian wang (Arm Technology C=
hina) wrote:
> On Sat, Sep 21, 2019 at 07:50:46PM +0200, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 21 Sep 2019 19:43:51 +0200
> >=20
> > Simplify this function implementation by using a known wrapper function=
.
> >=20
> > This issue was detected by using the Coccinelle software.
> >=20
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>=20
> Thank you for the patch.
>=20
> Looks good to me.
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>

Applied to drm-misc-next - 50ec5b563bed04b0b262822b755f6aa336f1f40a

>=20
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >=20
> > --
> > 2.23.0
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_dev.c
> > index ca64a129c594..a387d923962e 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> > @@ -172,19 +172,12 @@ struct komeda_dev *komeda_dev_create(struct devic=
e *dev)
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> >  	const struct komeda_product_data *product;
> >  	struct komeda_dev *mdev;
> > -	struct resource *io_res;
> >  	int err =3D 0;
> >=20
> >  	product =3D of_device_get_match_data(dev);
> >  	if (!product)
> >  		return ERR_PTR(-ENODEV);
> >=20
> > -	io_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (!io_res) {
> > -		DRM_ERROR("No registers defined.\n");
> > -		return ERR_PTR(-ENODEV);
> > -	}
> > -
> >  	mdev =3D devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
> >  	if (!mdev)
> >  		return ERR_PTR(-ENOMEM);
> > @@ -192,7 +185,7 @@ struct komeda_dev *komeda_dev_create(struct device =
*dev)
> >  	mutex_init(&mdev->lock);
> >=20
> >  	mdev->dev =3D dev;
> > -	mdev->reg_base =3D devm_ioremap_resource(dev, io_res);
> > +	mdev->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(mdev->reg_base)) {
> >  		DRM_ERROR("Map register space failed.\n");
> >  		err =3D PTR_ERR(mdev->reg_base);
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20


--=20
Mihail



