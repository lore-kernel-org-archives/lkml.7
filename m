Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE529ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC43206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CWJSmCfP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CWJSmCfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfJII5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:57:32 -0400
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:45380
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfJII5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoCjD4qCMe4MgrXzYbULyLrTEH+GD+vnMY4AexS2hzY=;
 b=CWJSmCfPgbHwBM9QIneZbi4k6VE3yZKuZsE4SgTzqQaQY9IjI7aQqPDLkJchnfMrlYoStex/PgruWuYITyeNaEaYB2F/BAFCqkX4SDJOGdgm+GRTpEMedyhBiftoPxdF7/CzIMZXOSJ/s9hnby7MTF6ko2DirmgyymcjPTsgBXo=
Received: from VI1PR0802CA0047.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::33) by HE1PR08MB2795.eurprd08.prod.outlook.com
 (2603:10a6:7:33::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Wed, 9 Oct
 2019 08:57:24 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR0802CA0047.outlook.office365.com
 (2603:10a6:800:a9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 9 Oct 2019 08:57:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 9 Oct 2019 08:57:23 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Wed, 09 Oct 2019 08:57:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9dad7964282252ec
X-CR-MTA-TID: 64aa7808
Received: from 00afeece4153.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 40D1C92B-17D4-4FA3-A7CA-2A1D2981EF7E.1;
        Wed, 09 Oct 2019 08:57:13 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 00afeece4153.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 09 Oct 2019 08:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ1R0ENa5YwivWG0a6eXQGEc235petWvVe/sSt6y7OWRoWEiqnupOgj8Fr5SC5jK5XkweAtumEUuulh8KaOVIgH/m5hDT8AqRjpQdaXQlH+QqezgxoBcY0dAalFuCdDvAiPS32Hj84hTN9VTT76af5XCM93I+TaOVLSHkT3oDfmCqotRPpi8eo2tbAOqYi6z4hdtOqhOhj2N/neCDVshpecnT4gaGqkoZgauzGv+wsMWPmUl1FAqqmdEpHrUzNZApFGAC0eSGT8+8FxvNeSwZzMcBtjDVo6xISe1oime1EqYCgt/frcRP1NM07kza6bAEfXaU0Ibjj6hNjQ2/4C7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoCjD4qCMe4MgrXzYbULyLrTEH+GD+vnMY4AexS2hzY=;
 b=g75Bi1CIysZqmWzW7QYZUV5qNgK/hOTQtHPuQphc324Dk+RcqbCibyntP9zy1B3AVdgG/u9IMUoVs3roRi61VNLWaM2zcaLwOq3a6iwYaNRP3SxugI6wa0gj9OkauVL8I1KEbd0yGFJJdt3tYVOGlFbKf847l73HO/Qzc0b08TNW4vpcnarIlP94m/BHpsAVDPzJNxtXjiTQnPzqhCpdg6LQNkwLnK2ZPI1njxqYBJUQmjL/jx1TXdNVkmK4nudEsEHOtMB2iJCL/C0yrZJcG0zqVk+4OdmcVnRkvgh7mHAUgLD5pYD3zr5oD6s4SSCK1bfd3tNz3zQVkl+ayg5ZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoCjD4qCMe4MgrXzYbULyLrTEH+GD+vnMY4AexS2hzY=;
 b=CWJSmCfPgbHwBM9QIneZbi4k6VE3yZKuZsE4SgTzqQaQY9IjI7aQqPDLkJchnfMrlYoStex/PgruWuYITyeNaEaYB2F/BAFCqkX4SDJOGdgm+GRTpEMedyhBiftoPxdF7/CzIMZXOSJ/s9hnby7MTF6ko2DirmgyymcjPTsgBXo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5232.eurprd08.prod.outlook.com (10.255.27.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 08:57:11 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2305.023; Wed, 9 Oct 2019
 08:57:11 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Markus Elfring <Markus.Elfring@web.de>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: drm/komeda: Use devm_platform_ioremap_resource() in
 komeda_dev_create()
Thread-Topic: drm/komeda: Use devm_platform_ioremap_resource() in
 komeda_dev_create()
Thread-Index: AQHVfn+JvQC/QoqWmUy+DBMQjxCdOg==
Date:   Wed, 9 Oct 2019 08:57:11 +0000
Message-ID: <20191009085704.GA26615@jamwan02-TSP300>
References: <64a6ea39-3e4b-2ebe-74f7-98720e581e3e@web.de>
In-Reply-To: <64a6ea39-3e4b-2ebe-74f7-98720e581e3e@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 6c5c7715-d4a4-4cb3-b33e-08d74c96b33e
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5232:|VE1PR08MB5232:|HE1PR08MB2795:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB279522A3FC941BC9F7092BC7B3950@HE1PR08MB2795.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 018577E36E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(5660300002)(54906003)(14454004)(58126008)(1076003)(66946007)(186003)(2906002)(478600001)(66066001)(66476007)(66556008)(64756008)(66446008)(386003)(6506007)(102836004)(99286004)(76176011)(52116002)(3846002)(55236004)(6116002)(71200400001)(71190400001)(33656002)(316002)(26005)(6916009)(256004)(14444005)(8936002)(8676002)(81166006)(81156014)(4326008)(11346002)(86362001)(476003)(446003)(6246003)(7736002)(229853002)(25786009)(486006)(9686003)(6512007)(6486002)(305945005)(33716001)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5232;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FqncX2CMcD2ZgZwmC4oh2yeybjlDAIP7KWZKzi6QRChtVtyT87fLg/JIrVqFmT0KwN0TBYm1q4wPC9cuiSp/1vpbxjrcILuyFQFQ8pt9gKn6KAD8VR7+fh8J0tBoq6RXgmxR3b3uzZWv25dghNJqetJA8LaLloc+s15Fm9mjeAjIwwWwNIc/LrTuxZlZ3QgyCT3U/m2dUD4cF4blcJqSk3eLutL2gzzgKBCCSLtAZ9GGJe4MgbLLuFFhWZxBmksthwmWt/8bJg+mj80RCSPyZb3LjD8ya1yIjWCD5JJwtNVNjWj3iQfGRsgeGyyqkeOVXdidAv5T7owF1z4Ph6bmuSoCMAsNlozZWtK8M+UMM32kIL+CYLkecNABLK1Awu25Daw6Zm0X6cEJ5Dic8VocS0eO0lIQB68XPKvrQnVdbew=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6224130653DB3F4D90F736A8E942E43B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5232
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(39860400002)(346002)(136003)(199004)(189003)(76130400001)(8936002)(478600001)(6506007)(47776003)(1076003)(50466002)(33716001)(26826003)(386003)(46406003)(316002)(36906005)(14444005)(6246003)(2906002)(81156014)(81166006)(25786009)(76176011)(6116002)(102836004)(22756006)(66066001)(99286004)(26005)(8746002)(8676002)(3846002)(86362001)(23726003)(356004)(186003)(14454004)(54906003)(6486002)(4326008)(6512007)(486006)(63350400001)(450100002)(336012)(70206006)(9686003)(305945005)(70586007)(446003)(476003)(126002)(58126008)(11346002)(33656002)(5660300002)(7736002)(229853002)(6862004)(97756001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB2795;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6ed1062f-feaa-4608-ad35-08d74c96abf5
NoDisclaimer: True
X-Forefront-PRVS: 018577E36E
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RuevkkL1KYXHo1CmWbOedYnXLpb0w2wzH+KuQtQKlCpxpFnUFE7yQ1P/7/70iYhRqOB52TTgmPMXw+qmKx1Q8wn4eTSSdQRA+B3U8qCzyLL0o25YTbgscLqaNB/529feKOLY83YrSkIXv/W/zSKb6alPFRn2SXd3TMSeMAaBUuyb5jhjat+F58LAN5dSd8gQC0M4Jo0wt2NKfXS4ZISOv0+Q3gKKircl/LR7WfC1PUXUCNK7ptSuHGmWw9HXKeUbk1JY5R5vwcSSkuyeJhlsnwUxmQ/AaebcmCdtipKTfbFtToJduf/6drI4XMWsQV8Dr8MldV5Ob4CM81OiXqMwT5+v5QSFAIJs4692VmiTjl00/DZ1iqjeiVADoDn5PHBXB94FxSmQU+qoMfGSRHmU+WmrYB5xEwfd7mgd6/jyk8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 08:57:23.0839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5c7715-d4a4-4cb3-b33e-08d74c96b33e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 07:50:46PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Sep 2019 19:43:51 +0200
>=20
> Simplify this function implementation by using a known wrapper function.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thank you for the patch.

Looks good to me.
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> --
> 2.23.0
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index ca64a129c594..a387d923962e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -172,19 +172,12 @@ struct komeda_dev *komeda_dev_create(struct device =
*dev)
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	const struct komeda_product_data *product;
>  	struct komeda_dev *mdev;
> -	struct resource *io_res;
>  	int err =3D 0;
>=20
>  	product =3D of_device_get_match_data(dev);
>  	if (!product)
>  		return ERR_PTR(-ENODEV);
>=20
> -	io_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!io_res) {
> -		DRM_ERROR("No registers defined.\n");
> -		return ERR_PTR(-ENODEV);
> -	}
> -
>  	mdev =3D devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
>  	if (!mdev)
>  		return ERR_PTR(-ENOMEM);
> @@ -192,7 +185,7 @@ struct komeda_dev *komeda_dev_create(struct device *d=
ev)
>  	mutex_init(&mdev->lock);
>=20
>  	mdev->dev =3D dev;
> -	mdev->reg_base =3D devm_ioremap_resource(dev, io_res);
> +	mdev->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mdev->reg_base)) {
>  		DRM_ERROR("Map register space failed.\n");
>  		err =3D PTR_ERR(mdev->reg_base);
