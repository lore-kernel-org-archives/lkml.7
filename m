Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F528C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF07F2070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="h/ivjOuD";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="h/ivjOuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393353AbfITKED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:04:03 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:36327
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389030AbfITKEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnbFxFW2m+gzv4CHTDOHyozsyKgab27QRIOAGibnx0I=;
 b=h/ivjOuDVWeVfXY3HzzfF26fQWeGoncd2Gxyk9YIAKkrZXbebVNL4Ei5BoKxcbug0yEMYrvezsqFYMmbDGHOxx+/ntgphD/vIUXfvxrBBSPWySOUUJ0R+zuJEmLDymCVR8h+j8SqbIThr7KboG8GuWU8qJu1QyApaCAaT9k2qd8=
Received: from VE1PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:803:104::39)
 by VI1PR0802MB2286.eurprd08.prod.outlook.com (2603:10a6:800:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21; Fri, 20 Sep
 2019 10:03:51 +0000
Received: from VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by VE1PR08CA0026.outlook.office365.com
 (2603:10a6:803:104::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21 via Frontend
 Transport; Fri, 20 Sep 2019 10:03:51 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT004.mail.protection.outlook.com (10.152.18.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Fri, 20 Sep 2019 10:03:50 +0000
Received: ("Tessian outbound fd4ad9e68831:v31"); Fri, 20 Sep 2019 10:03:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f233540e18bf7854
X-CR-MTA-TID: 64aa7808
Received: from be450001e679.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BBFA21BB-CB2A-4D05-A2FD-0876FB77D10D.1;
        Fri, 20 Sep 2019 10:03:41 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id be450001e679.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Sep 2019 10:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZO8rpAOAqI8+9bKoIQCO4KgP/RXNw8ywR3SwC60Lsoa5dt6p+YFJ24biuAAmKdvUEbeKXfMzQSAmeKhOVZEgWnIPe0qbsvaw+F42meIEdC8Zp3f7+G0xXgaCU+sS28u/3DDfWKki+p/z46wfP9XZNWedMGcg8s/f9AAiGmu/Mbcpk2ORY5cr3L56wVkHqo/ri9IgevB1N6qKcmVHJ669UVAsl1U2aO4wI2yR1XpK25EevmunEQ/HuT9at97y5B+eizp3Mc72WafdZUhtt3xZptMCDKUWET5dsOzRRy16Dt3dwoENkNbwHv/Uebu3jyePg+2x4Rf79eLfI7T1BTdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnbFxFW2m+gzv4CHTDOHyozsyKgab27QRIOAGibnx0I=;
 b=Mo0wVCZlspshU/tgZwwBN0zaarcEhT9EnOt+I/4zPY3BJsuLdPFiiIq/BtJ8cfASOII+7v5GctRVec92Z4nt9Z/HQtdiX7IEoyf7JP+gqmPeA5xhis9oHa5aJ2kiN0Nm+UCmrUK/2i3Xr1w6+e6vp8dHTHYAsLIwl3fBGCwag9nSzHBBWkJ3HLQv0zWVahB7ha3vvSzZWoioSo/X3KC0tTH7B1qGPNIpBBfLcdmQGXUJ7HqQds0eHpojiqP1GuJG0yEP1hieKnxe32zTRQvHVDOA3/zjdg/ehyFHNoBDRvPoZ+HDaLtlMngwsWl8fOb6sEXq4C3uZ3UhYcfYD0/hig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnbFxFW2m+gzv4CHTDOHyozsyKgab27QRIOAGibnx0I=;
 b=h/ivjOuDVWeVfXY3HzzfF26fQWeGoncd2Gxyk9YIAKkrZXbebVNL4Ei5BoKxcbug0yEMYrvezsqFYMmbDGHOxx+/ntgphD/vIUXfvxrBBSPWySOUUJ0R+zuJEmLDymCVR8h+j8SqbIThr7KboG8GuWU8qJu1QyApaCAaT9k2qd8=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3134.eurprd08.prod.outlook.com (52.133.15.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14; Fri, 20 Sep 2019 10:03:38 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::f164:4d79:79f:dc6f%7]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019
 10:03:38 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Topic: [PATCH] drm/komeda: Adds output-color format/depth support
Thread-Index: AQHVb5fml3iiEtk+MEOqXjNduhm+kKc0VieA
Date:   Fri, 20 Sep 2019 10:03:38 +0000
Message-ID: <2379631.WB1HUilIrr@e123338-lin>
References: <20190920094329.17513-1-lowry.li@arm.com>
In-Reply-To: <20190920094329.17513-1-lowry.li@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0365.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::17) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 315cdb95-1943-489e-722e-08d73db1d5d8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3134;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3134:|VI1PR08MB3134:|VI1PR0802MB2286:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB228635971490E2771CB42E0B8F880@VI1PR0802MB2286.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0166B75B74
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(11346002)(6512007)(76176011)(9686003)(3846002)(33716001)(6116002)(52116002)(99286004)(71190400001)(71200400001)(5660300002)(2906002)(14444005)(256004)(446003)(476003)(6636002)(305945005)(478600001)(316002)(7736002)(64756008)(66556008)(229853002)(66476007)(14454004)(6862004)(66946007)(6436002)(81166006)(81156014)(8676002)(102836004)(8936002)(386003)(6506007)(54906003)(26005)(4326008)(25786009)(6486002)(66066001)(6246003)(86362001)(486006)(30864003)(66446008)(186003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3134;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: IaxiZy5ZGiN3UFkdO/d63cj/WvTPl1JENJeuwKwdsB3giRwLbNnZerGya2gUoIsmIiEYi4fXblDcgw2GUMrFi8bIDlFARVdeKEbnmQLrjLkjLDr1sNVlKfoDH41bTQGxoaWZBIOLTdOAIrcJczLPaKwWkudBaOIgPfOLIFuKGm6Ptr/Ze3t4XdAebZZXSE+kmPa3TvFIQgAswnmywxxlHGHm6CNIzTejLDGRBcEWnwH/pR9t03aJvcdIlZlyzVfclZ7TK75AHpn3i7nTEEQKnVR4Tid/bHzaVlbdgRFPwPpobjo6JHO5f4fEmcMoc3sg/GsgZV4r7AIB8Ep3PWfLKyIw+yxOas9BdFFBFS1v1bfr9iYeLoHxPxP0CQDC8yNeihQBwlZ9x7C1zstXiLk3FQD5isxwstRdt/PaonGDtQI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB502D627E23AF409CF74324F32DF28F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3134
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(4326008)(6636002)(6512007)(9686003)(316002)(6862004)(126002)(54906003)(81166006)(6486002)(305945005)(70586007)(229853002)(6246003)(22756006)(14454004)(70206006)(26826003)(11346002)(7736002)(336012)(446003)(8676002)(36906005)(23726003)(3846002)(50466002)(356004)(63350400001)(486006)(5660300002)(25786009)(76176011)(99286004)(476003)(478600001)(86362001)(66066001)(81156014)(6116002)(102836004)(26005)(76130400001)(8746002)(2906002)(97756001)(186003)(46406003)(47776003)(386003)(14444005)(6506007)(33716001)(30864003)(8936002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2286;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 20da21f5-afa2-4434-a312-08d73db1ceba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0802MB2286;
NoDisclaimer: True
X-Forefront-PRVS: 0166B75B74
X-Microsoft-Antispam-Message-Info: FcdoLIoh7tkWCBO0HceiseSfKDKUUrLjIAPUrFHhAPnoRcPSSRu4ylg2KCBCSoAkD8GZsilOelTOgPMsYyYFo+dJ8Gcvtkqrsg6z+EyTWrsw/mZvMToMeM0BTnvZpj8vT612Iis9YnyCAu76zd3YiCcMcEjmBJ21yoP+iG2Df3YYx2cLcGx9k9PKKJUA4fyhlooyr8MNrHXunVIYrgIFOmYH1jZA76vrJ3dUoHswiTo9xUfmvT9tVGUsfGEFuEI0pqis9OLcYmhtPA+BFPJ9+pWQbFFGZ/jz9Cui7cUpmeY+ym6e9E+wPswEqJTKvYVaD1ejrHtmVbpRdUSFTnveJ8HAp0Lf/ag1KC7GCNF4U4u9xYJkS2bsuN2v2s9/UvR3NlS1FrgZnD5h2Ob7kvHQXwrYnCqmObsQZ5gPbnHP1gg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 10:03:50.1391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315cdb95-1943-489e-722e-08d73db1d5d8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Friday, 20 September 2019 10:43:47 BST Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Sets color_depth according to connector->bpc.
> Adds a new optional DT attribute "color-format" to represent a

I don't see the hunk with the updated doc for the DT binding.

> preferred color formats for a specific pipeline, and the select order
> is:
> 	YCRCB420 > YCRCB422 > YCRCB444 > RGB444
> The color-format can be anyone of these 4 format, one color-format not
> only represent one format, but also include the lower formats, like
>=20
> color-format         preferred_color_formats
> YCRCB420        YCRCB420 > YCRCB422 > YCRCB444 > RGB444
> YCRCB422        YCRCB422 > YCRCB444 > RGB444
> YCRCB444        YCRCB444 > RGB444
> RGB444          RGB444
>=20
> Then the final color_format is calculated by 3 steps:
> 1. calculate HW available formats.
>   avail_formats =3D connector_color_formats & improc->color_formats;
> 2. filter out un-preferred format.
>   avail_formats &=3D preferred_color_formats;
> 3. select the final format according to the preferred order.
>   color_format =3D BIT(__fls(aval_formats));
>=20
> Changes since v1:
> Rebased to the drm-misc-next branch.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    | 15 ++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 27 ++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 32 ++++++++++++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  3 ++
>  .../display/komeda/komeda_pipeline_state.c    | 31 ++++++++++++++++++
>  .../arm/display/komeda/komeda_wb_connector.c  |  5 +++
>  7 files changed, 113 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index c3d29c0b051b..7b374a3b911e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -944,13 +944,26 @@ static void d71_improc_update(struct komeda_compone=
nt *c,
>  {
>  	struct komeda_improc_state *st =3D to_improc_st(state);
>  	u32 __iomem *reg =3D c->reg;
> -	u32 index;
> +	u32 index, mask =3D 0, ctrl =3D 0;
> =20
>  	for_each_changed_input(state, index)
>  		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
>  			       to_d71_input_id(state, index));
> =20
>  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> +	malidp_write32(reg, IPS_DEPTH, st->color_depth);
> +
> +	mask |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
> +
> +	/* config color format */
> +	if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB420)
> +		ctrl |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422 | IPS_CTRL_CHD420;
> +	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB422)
> +		ctrl |=3D IPS_CTRL_YUV | IPS_CTRL_CHD422;
> +	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB444)
> +		ctrl |=3D IPS_CTRL_YUV;
> +
> +	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
>  }
> =20
>  static void d71_improc_dump(struct komeda_component *c, struct seq_file =
*sf)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 624d257da20f..38d5cb20e908 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -18,6 +18,33 @@
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> =20
> +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> +				  u32 *color_depths, u32 *color_formats)
> +{
> +	struct drm_connector *conn;
> +	struct drm_connector_state *conn_st;
> +	u32 conn_color_formats =3D ~0u;
> +	int i, min_bpc =3D 31, conn_bpc =3D 0;
> +
> +	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
> +		if (conn_st->crtc !=3D crtc_st->crtc)
> +			continue;
> +
> +		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
> +		conn_color_formats &=3D conn->display_info.color_formats;
> +
> +		if (conn_bpc < min_bpc)
> +			min_bpc =3D conn_bpc;
> +	}
> +
> +	/* connector doesn't config any color_format, use RGB444 as default */
> +	if (conn_color_formats =3D=3D 0)
> +		conn_color_formats =3D DRM_COLOR_FORMAT_RGB444;
> +
> +	*color_depths =3D GENMASK(conn_bpc, 0);
> +	*color_formats =3D conn_color_formats;
> +}
> +
>  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcr=
tc_st)
>  {
>  	u64 pxlclk, aclk;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 9cbcd56e54cd..bee4633cdd9f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -113,12 +113,34 @@ static struct attribute_group komeda_sysfs_attr_gro=
up =3D {
>  	.attrs =3D komeda_sysfs_entries,
>  };
> =20
> +static int to_color_format(const char *str)
> +{
> +	int format;
> +
> +	if (!strncmp(str, "RGB444", 7)) {
> +		format =3D DRM_COLOR_FORMAT_RGB444;
> +	} else if (!strncmp(str, "YCRCB444", 9)) {
> +		format =3D DRM_COLOR_FORMAT_YCRCB444;
> +	} else if (!strncmp(str, "YCRCB422", 9)) {
> +		format =3D DRM_COLOR_FORMAT_YCRCB422;
> +	} else if (!strncmp(str, "YCRCB420", 9)) {
> +		format =3D DRM_COLOR_FORMAT_YCRCB420;
> +	} else {
> +		DRM_WARN("invalid color_format: %s, please set it to RGB444, YCRCB444,=
 YCRCB422 or YCRCB420\n",
> +			 str);
> +		format =3D DRM_COLOR_FORMAT_RGB444;
> +	}
> +
> +	return format;
> +}
> +
>  static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_n=
ode *np)
>  {
>  	struct komeda_pipeline *pipe;
>  	struct clk *clk;
>  	u32 pipe_id;
> -	int ret =3D 0;
> +	int ret =3D 0, color_format;
> +	const char *str;
> =20
>  	ret =3D of_property_read_u32(np, "reg", &pipe_id);
>  	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
> @@ -133,6 +155,14 @@ static int komeda_parse_pipe_dt(struct komeda_dev *m=
dev, struct device_node *np)
>  	}
>  	pipe->pxlclk =3D clk;
> =20
> +	/* fetch DT configured color-format, if not set, use RGB444 */
> +	if (!of_property_read_string(np, "color-format", &str))
> +		color_format =3D to_color_format(str);
> +	else
> +		color_format =3D DRM_COLOR_FORMAT_RGB444;
> +
> +	pipe->improc->preferred_color_formats =3D (color_format << 1) - 1;
> +
>  	/* enum ports */
>  	pipe->of_output_links[0] =3D
>  		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index 45c498e15e7a..456f3c435719 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
>  		return !!(rotation & DRM_MODE_REFLECT_X);
>  }
> =20
> +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> +				  u32 *color_depths, u32 *color_formats);
>  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st);
> =20
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev=
 *mdev);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index a7a84e66549d..910d279ae48d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -315,6 +315,8 @@ struct komeda_splitter_state {
>  struct komeda_improc {
>  	struct komeda_component base;
>  	u32 supported_color_formats;  /* DRM_RGB/YUV444/YUV420*/
> +	/* the preferred order is from MSB to LSB YUV420 --> RGB444 */
> +	u32 preferred_color_formats;
>  	u32 supported_color_depths; /* BIT(8) | BIT(10)*/
>  	u8 supports_degamma : 1;
>  	u8 supports_csc : 1;
> @@ -323,6 +325,7 @@ struct komeda_improc {
> =20
>  struct komeda_improc_state {
>  	struct komeda_component_state base;
> +	u8 color_format, color_depth;
>  	u16 hsize, vsize;
>  };
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index ea26bc9c2d00..5526731f5a33 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -743,6 +743,7 @@ komeda_improc_validate(struct komeda_improc *improc,
>  		       struct komeda_data_flow_cfg *dflow)
>  {
>  	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
> +	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
>  	struct komeda_component_state *c_st;
>  	struct komeda_improc_state *st;
> =20
> @@ -756,6 +757,36 @@ komeda_improc_validate(struct komeda_improc *improc,
>  	st->hsize =3D dflow->in_w;
>  	st->vsize =3D dflow->in_h;
> =20
> +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> +		u32 output_depths, output_formats;
> +		u32 avail_depths, avail_formats;
> +
> +		komeda_crtc_get_color_config(crtc_st, &output_depths,
> +					     &output_formats);
> +
> +		avail_depths =3D output_depths & improc->supported_color_depths;
> +		if (avail_depths =3D=3D 0) {
> +			DRM_DEBUG_ATOMIC("No available color depths, conn depths: 0x%x & disp=
lay: 0x%x\n",
> +					 output_depths,
> +					 improc->supported_color_depths);
> +			return -EINVAL;
> +		}
> +
> +		avail_formats =3D output_formats &
> +				improc->supported_color_formats &
> +				improc->preferred_color_formats;
> +		if (avail_formats =3D=3D 0) {
> +			DRM_DEBUG_ATOMIC("No available color_formats, conn formats 0x%x & dis=
play: 0x%x & preferred: 0x%x\n",
> +					 output_formats,
> +					 improc->supported_color_formats,
> +					 improc->preferred_color_formats);
> +			return -EINVAL;
> +		}
> +
> +		st->color_depth =3D __fls(avail_depths);
> +		st->color_format =3D BIT(__fls(avail_formats));
> +	}
> +
>  	komeda_component_add_input(&st->base, &dflow->input, 0);
>  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 617e1f7b8472..49e5469ba48e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -142,6 +142,7 @@ static int komeda_wb_connector_add(struct komeda_kms_=
dev *kms,
>  	struct komeda_dev *mdev =3D kms->base.dev_private;
>  	struct komeda_wb_connector *kwb_conn;
>  	struct drm_writeback_connector *wb_conn;
> +	struct drm_display_info *info;
>  	u32 *formats, n_formats =3D 0;
>  	int err;
> =20
> @@ -171,6 +172,10 @@ static int komeda_wb_connector_add(struct komeda_kms=
_dev *kms,
> =20
>  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
> =20
> +	info =3D &kwb_conn->base.base.display_info;
> +	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
> +	info->color_formats =3D kcrtc->master->improc->supported_color_formats;
> +
>  	kcrtc->wb_conn =3D kwb_conn;
> =20
>  	return 0;
>=20


--=20
Mihail



