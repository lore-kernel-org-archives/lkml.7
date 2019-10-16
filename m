Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0343AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73EA2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HcWKKX3Q";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HcWKKX3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404068AbfJPIUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:20:35 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:20816
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729083AbfJPIUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br5D2E+/gkSE/5iZSR9wblRLN0ErYP8RSiT/0pbfLtU=;
 b=HcWKKX3Qyqhv+XMSNbXMErAlAdMdqqXy1jgMGqM4LqTguHnRc8xQI9r9ye+S/KGcT4iPcVUDiLvmxUl/Nf/QFkp2LeTiSBfOJ8wZm69MPlDWuMqMhd3ueZX70URLupz+YIJ7LG3jx128MRDf/QwwlRFFVP0spyP9VW1woFkZY/4=
Received: from DB7PR08CA0064.eurprd08.prod.outlook.com (2603:10a6:10:26::41)
 by VE1PR08MB5248.eurprd08.prod.outlook.com (2603:10a6:803:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Wed, 16 Oct
 2019 08:20:24 +0000
Received: from DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by DB7PR08CA0064.outlook.office365.com
 (2603:10a6:10:26::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 08:20:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT060.mail.protection.outlook.com (10.152.21.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 08:20:22 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Wed, 16 Oct 2019 08:20:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ffda825c481c9712
X-CR-MTA-TID: 64aa7808
Received: from bcdf780fb782.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EAB1415B-9E5E-4034-A0E7-CE757535BA36.1;
        Wed, 16 Oct 2019 08:20:13 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2057.outbound.protection.outlook.com [104.47.6.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bcdf780fb782.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 08:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxTYlfx1CkjsuDGxZFLzbTE3vs2am9V6eWVK7aua/w7Ylz+DVsbTUZ970Xg7Zb7lkKsl5sCh8/C3a1XvrY0rdIupwU1cMA1SHGYRQ3s1tmY09Wan90gqmsDEecTBhQnd8IdGGjtK+3HFTsiZsQu98nxnr2fmjKn+AHDAsSuGHeBnzUFYtikAdHkaWI4COpCCakq6SG7L6/1zghcD+epXhgYTElGscsfBGe1rVyCYeCuvNfleewrBq/fSfZm2Lj4fueCyInhIPjCGBdFfm/cPI/nsvpci2qMBXjG0eyF6xjvCSSoqFZf/yzv2IYzFakj4n3cyjZTxYXRP8bnD8x5fAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br5D2E+/gkSE/5iZSR9wblRLN0ErYP8RSiT/0pbfLtU=;
 b=SpDGlrdfl0dKkXBaTiRWyiZv82dhjfLnulTaRerGtstXXZlHeb0fr3Bp71s6Kdkf1zV/djY19tzPVRAEC44qovy5NGcqXRLQ3pbaiq0nisnW8i21VaPdyK+mmZiijCDQffqHE9HWmGGFEL1F00NnrgTxT/9lyfjcXJUU+mM9dXQTFe6RrhZdOB4g3gLGCmJQmELzqrgC3Qg7gr1RkeoIPaKlsfkDSzFzpvvGe1C2bkHKfFGrQPaDixu/RlXoGHaG3tRNuiSsjGWnBXgl2z+f4OYnIie47SpYEtA0TQ0UtBWaU3hECwaEFcBaNtswjmhZ9IHaK2opV15bW/Nja0y2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br5D2E+/gkSE/5iZSR9wblRLN0ErYP8RSiT/0pbfLtU=;
 b=HcWKKX3Qyqhv+XMSNbXMErAlAdMdqqXy1jgMGqM4LqTguHnRc8xQI9r9ye+S/KGcT4iPcVUDiLvmxUl/Nf/QFkp2LeTiSBfOJ8wZm69MPlDWuMqMhd3ueZX70URLupz+YIJ7LG3jx128MRDf/QwwlRFFVP0spyP9VW1woFkZY/4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5264.eurprd08.prod.outlook.com (20.179.29.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 08:20:11 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 08:20:11 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: drm/komeda: Adds output-color format support
Thread-Topic: drm/komeda: Adds output-color format support
Thread-Index: AQHVg/qHbAZVfv9eaEWdG+FF14zPEA==
Date:   Wed, 16 Oct 2019 08:20:11 +0000
Message-ID: <20191016082002.GA18432@jamwan02-TSP300>
References: <20191015091019.26021-1-lowry.li@arm.com>
In-Reply-To: <20191015091019.26021-1-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0049.apcprd03.prod.outlook.com
 (2603:1096:202:17::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7ddef257-7081-4a78-c701-08d75211b07b
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5264:|VE1PR08MB5264:|VE1PR08MB5248:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB5248230B1DB1B74DC943CFF4B3920@VE1PR08MB5248.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:287;OLM:287;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(189003)(199004)(81166006)(81156014)(7736002)(8676002)(6636002)(305945005)(2906002)(14454004)(229853002)(8936002)(5660300002)(25786009)(6436002)(478600001)(33716001)(99286004)(6246003)(6486002)(54906003)(486006)(33656002)(58126008)(256004)(26005)(71190400001)(186003)(11346002)(476003)(102836004)(1076003)(71200400001)(386003)(6862004)(446003)(9686003)(6512007)(76176011)(6116002)(4326008)(52116002)(66066001)(66946007)(64756008)(55236004)(316002)(86362001)(66476007)(14444005)(3846002)(66446008)(66556008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5264;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fvsqCSQ2u5R0VwD6ezlwdjyUQnX8zD4CvtJuSI3xN+5wNgfJ92aC5nRq2yGndNUVgyU6pn84wVrM7WyZh3ekssWwnaPXxCei0cENfd8K5IA+9zEZHQIey1BnudXTAXZW9KkUj7dByhSRCB9ScbW1ujBhWk9+rtXm0rDRN+pogLz9kEp+lTn9pWR/uktbjHiXeuxrJqCkQ/eluMkAvNxOrws/puP4Tij+RCLDKXu6DWn5B4V3KcT/mp/DwPEjZ+QQQT7RBPZveExNu2/PVBZhnV4vDQ5cqvkRuQXynpdQcwgCsyeefGAUweFcUgZMnxTUkmSvCMS3CSfo71hRfLRsDddFT3xdM/ww54l9rBNqApB+kDzA4xFTxSpFspvHKvnLFDPKVP/CBnXUd4PLS8DZFlYoPmw51ei1sF+TlpbMNmc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45F1B9E780CB384F9EC2F209C7F0258A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5264
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(70206006)(22756006)(336012)(305945005)(86362001)(5660300002)(33716001)(54906003)(70586007)(6636002)(76130400001)(26826003)(478600001)(316002)(33656002)(46406003)(81166006)(7736002)(66066001)(47776003)(1076003)(58126008)(8746002)(8676002)(81156014)(8936002)(4326008)(23726003)(356004)(446003)(25786009)(6862004)(11346002)(14454004)(63350400001)(97756001)(476003)(486006)(50466002)(14444005)(3846002)(6116002)(2906002)(229853002)(9686003)(6512007)(6246003)(6486002)(386003)(26005)(6506007)(102836004)(76176011)(99286004)(186003)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5248;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a004c38d-7d07-4ba8-1a45-08d75211a9bc
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGpt5WsH+g/fGC4NClalTons/T2kXBjypewX5wU8kRnaLPkzUiUG+aOsOPymue9u8yktlHWVa++TpMtHVCjwX8phmLQcRd4BenuZI5+IYE16j/K+ddNSywyRYxN1/8bv73DOteevCHk8MrHgvX8X5xqjwn7c7NMsgslZM3oSD5DmOcczx3XtfCIDwCG20LkrDgDn27h9FjB9ZU/Xc93kldTg1GnMupGPath4NWIR7rEBXLExwdQRfU7U2YZLUmDO5uP0RbJD5lfMgAQkhW330Inw6Dj+sgplxSiOLv4Xu9/a91R50V9kF4wNMFmH7y2maPL7ad25cEtmKcmsVKkKQhJOvMplRiLLRhX1J9g23qIN0I4hoyd9tWAn9TYMI0rFgaC8XqCLq4po0MibjdAeOtaBsE7FT1BAakUb6mbnfEY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 08:20:22.4527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddef257-7081-4a78-c701-08d75211b07b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:10:36AM +0000, Lowry Li (Arm Technology China) w=
rote:
> Sets output color format according to the connector formats and
> display supported formats. Default value is RGB444 and only force
> YUV format which must be YUV.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../drm/arm/display/komeda/d71/d71_component.c  | 14 +++++++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c    |  9 ++++++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h |  2 +-
>  .../drm/arm/display/komeda/komeda_pipeline.h    |  2 +-
>  .../arm/display/komeda/komeda_pipeline_state.c  | 17 ++++++++++++++---
>  .../arm/display/komeda/komeda_wb_connector.c    |  1 +
>  6 files changed, 38 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 27cdb03573c1..7b374a3b911e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -944,7 +944,7 @@ static void d71_improc_update(struct komeda_component=
 *c,
>  {
>  	struct komeda_improc_state *st =3D to_improc_st(state);
>  	u32 __iomem *reg =3D c->reg;
> -	u32 index;
> +	u32 index, mask =3D 0, ctrl =3D 0;
> =20
>  	for_each_changed_input(state, index)
>  		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
> @@ -952,6 +952,18 @@ static void d71_improc_update(struct komeda_componen=
t *c,
> =20
>  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
>  	malidp_write32(reg, IPS_DEPTH, st->color_depth);
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
> index fe295c4fca71..c9b8d2d5e195 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -18,10 +18,11 @@
>  #include "komeda_kms.h"
> =20
>  void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> -				  u32 *color_depths)
> +				  u32 *color_depths, u32 *color_formats)
>  {
>  	struct drm_connector *conn;
>  	struct drm_connector_state *conn_st;
> +	u32 conn_color_formats =3D ~0u;
>  	int i, min_bpc =3D 31, conn_bpc =3D 0;
> =20
>  	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
> @@ -29,12 +30,18 @@ void komeda_crtc_get_color_config(struct drm_crtc_sta=
te *crtc_st,
>  			continue;
> =20
>  		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
> +		conn_color_formats &=3D conn->display_info.color_formats;
> =20
>  		if (conn_bpc < min_bpc)
>  			min_bpc =3D conn_bpc;
>  	}
> =20
> +	/* connector doesn't config any color_format, use RGB444 as default */
> +	if (!conn_color_formats)
> +		conn_color_formats =3D DRM_COLOR_FORMAT_RGB444;
> +
>  	*color_depths =3D GENMASK(min_bpc, 0);
> +	*color_formats =3D conn_color_formats;
>  }
> =20
>  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcr=
tc_st)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index a42503451b5d..456f3c435719 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -167,7 +167,7 @@ static inline bool has_flip_h(u32 rot)
>  }
> =20
>  void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> -				  u32 *color_depths);
> +				  u32 *color_depths, u32 *color_formats);
>  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st);
> =20
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev=
 *mdev);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index 7653f134a8eb..c0f53b19b62d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -323,7 +323,7 @@ struct komeda_improc {
> =20
>  struct komeda_improc_state {
>  	struct komeda_component_state base;
> -	u8 color_depth;
> +	u8 color_format, color_depth;
>  	u16 hsize, vsize;
>  };
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index e64bfeaa06c7..948d1951c8eb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -758,10 +758,11 @@ komeda_improc_validate(struct komeda_improc *improc=
,
>  	st->vsize =3D dflow->in_h;
> =20
>  	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> -		u32 output_depths;
> -		u32 avail_depths;
> +		u32 output_depths, output_formats;
> +		u32 avail_depths, avail_formats;
> =20
> -		komeda_crtc_get_color_config(crtc_st, &output_depths);
> +		komeda_crtc_get_color_config(crtc_st, &output_depths,
> +					     &output_formats);
> =20
>  		avail_depths =3D output_depths & improc->supported_color_depths;
>  		if (avail_depths =3D=3D 0) {
> @@ -771,7 +772,17 @@ komeda_improc_validate(struct komeda_improc *improc,
>  			return -EINVAL;
>  		}
> =20
> +		avail_formats =3D output_formats &
> +				improc->supported_color_formats;
> +		if (!avail_formats) {
> +			DRM_DEBUG_ATOMIC("No available color_formats, conn formats 0x%x & dis=
play: 0x%x\n",
> +					 output_formats,
> +					 improc->supported_color_formats);
> +			return -EINVAL;
> +		}
> +
>  		st->color_depth =3D __fls(avail_depths);
> +		st->color_format =3D BIT(__ffs(avail_formats));
>  	}
> =20
>  	komeda_component_add_input(&st->base, &dflow->input, 0);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 740a81250630..abfa587db189 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -174,6 +174,7 @@ static int komeda_wb_connector_add(struct komeda_kms_=
dev *kms,
> =20
>  	info =3D &kwb_conn->base.base.display_info;
>  	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
> +	info->color_formats =3D kcrtc->master->improc->supported_color_formats;
> =20
>  	kcrtc->wb_conn =3D kwb_conn;
>

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
