Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D452CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3DC2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Yh8IKFTN";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Yh8IKFTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfJHJfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:35:38 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:65249
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728866AbfJHJfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9L3+imPDX/KEb8UvgiO9nbSknawneWULxiBOKHuxxI=;
 b=Yh8IKFTNPMLRno9041t5d6DM/H7R+MsXh7zCqti1w9elL7/fXPdKtqxFIzJqKZDvvNTf7YZcZ9mM4Tk0hzEMdlYWHxLsmPRlKhTgbC1rf9LJFah7ydHCIDG1bhKQhN62hOAj4OJErhjIvYGl523QsIRHK8mzqq4kGGpj91IUvis=
Received: from AM4PR08CA0051.eurprd08.prod.outlook.com (2603:10a6:205:2::22)
 by VE1PR08MB5040.eurprd08.prod.outlook.com (2603:10a6:803:114::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 09:35:28 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by AM4PR08CA0051.outlook.office365.com
 (2603:10a6:205:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 8 Oct 2019 09:35:28 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 09:35:26 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Tue, 08 Oct 2019 09:35:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2bf21b3adae9510c
X-CR-MTA-TID: 64aa7808
Received: from 8e943aff869d.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4DF80D64-ACC6-46B0-885E-B32C09DD3D0A.1;
        Tue, 08 Oct 2019 09:35:17 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8e943aff869d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Oct 2019 09:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS5YhvvqN1V6f6ZG7/W68zVYsdso1zNJ8YaTZTSYtryvpQMdk39681GFHz3x/5pztjNf0dKnwNul8ONRJp5cXdtJWtWjZBSn+FMRvYUDk/pXaAK1VFXpbMAeRjlDOXpIH1FXIkxExgbL9q6WHyt82TyG7SrW4ze3tAQZVhOjoZtA9ssg7kpMWpeNaEOH32Gn/jlTwI/qP2900rO5vIScd6RLwbrkBsBFy1fAZAlcgLGuoj8CdCf6N7AmpuAMuvmP8/fq/A5O2eJLSmG0zkmSyyv+d00Z5js6BYf+SaTauAxT3nPb3LC8bUJ6/7jeWe+aGwBQcjH/++88BWe8mIVeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9L3+imPDX/KEb8UvgiO9nbSknawneWULxiBOKHuxxI=;
 b=T5sl8I+Q8vGyu5KGSSVGFOim51BTEVO15FA3E1+6m14WNZnGBKyqzBrp+Kaz9idt9z1ZtJy+dYLDkL6HOR5BNuY7VnDBHZgs00IKfrhoOXQeU0m4QMHyk83JPMEIv5TDy/LR0Vrk9GR7+tepVFCPQ65KTaoB91Q3XMskIdJ/U54yt6ILKF3CAxWgzfzO4damVxEoXGkHsvD6SirZ1gY3ZVUKzEEFz/PVNsDFXTSsW0mWBBjor11e4MDkwj/E2kcJ7pDimelcKRumrCSYowL1Zfupt6Tcy4++1qt3yNOyBLIj/6dUFkOkSnvWo07Hxw08W11ovjo8ynfoaKgVgUGUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9L3+imPDX/KEb8UvgiO9nbSknawneWULxiBOKHuxxI=;
 b=Yh8IKFTNPMLRno9041t5d6DM/H7R+MsXh7zCqti1w9elL7/fXPdKtqxFIzJqKZDvvNTf7YZcZ9mM4Tk0hzEMdlYWHxLsmPRlKhTgbC1rf9LJFah7ydHCIDG1bhKQhN62hOAj4OJErhjIvYGl523QsIRHK8mzqq4kGGpj91IUvis=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2941.eurprd08.prod.outlook.com (10.170.238.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Tue, 8 Oct 2019 09:35:15 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 09:35:15 +0000
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
Subject: Re: [PATCH] drm/komeda: Set output color depth for output
Thread-Topic: [PATCH] drm/komeda: Set output color depth for output
Thread-Index: AQHVfblD7I+ubO1huUCp0qQz7Z0Q4adQe+uA
Date:   Tue, 8 Oct 2019 09:35:15 +0000
Message-ID: <3337512.00vBK9FLud@e123338-lin.cambridge.arm.com>
References: <20191008091734.19509-1-lowry.li@arm.com>
In-Reply-To: <20191008091734.19509-1-lowry.li@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::24) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a268c5b2-8aa7-48ac-45fe-08d74bd2da06
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB2941:|VI1PR08MB2941:|VE1PR08MB5040:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB504021D98F5F54F3B5A90A4F8F9A0@VE1PR08MB5040.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:418;OLM:418;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(81166006)(6636002)(8676002)(3846002)(81156014)(8936002)(6862004)(71190400001)(2906002)(6246003)(14444005)(6116002)(66066001)(256004)(14454004)(6436002)(6486002)(25786009)(4326008)(229853002)(99286004)(478600001)(476003)(11346002)(446003)(71200400001)(386003)(486006)(6506007)(54906003)(102836004)(6512007)(86362001)(76176011)(52116002)(316002)(26005)(186003)(305945005)(7736002)(66476007)(66556008)(64756008)(66446008)(5660300002)(66946007)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2941;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gvV6HRjzV03bNVTVKi8DPYM+pgOxIB9mp/qjBSu11TOKpyoC4SD+eizZW7A1kfKt24tQaLusWkqBoL68kXzuE/ylMBkfB6aQP9DXeHKVizZHiSztSLuVbsqO/mT7erzFltzcXw7enu9IxebzB6sNl5MQ9v5zBNB/iuhH1lQEGq+Ux0nKrx+rEFeetEQXksasPX5Xrgbt3Imm2btTE9avpj75t0XLEiJhWYU8stK5Jouo/qKcjv/TceZl9J9FgRTSakXOa2q8De3YnsuuKVrXAPTAsV2IR7+cw90zu6swhqZUdcEk/CGG9U9kJLEiMdEMYbh/0LUWbmptW4lmwUSuygUMzd9sOLWfcprKUY58eWT6142qjOOtu+IrMxvCCSBethlG/KTClfJE4G+cyyIxVZulPonzYuafJaZRutg3yak=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B7F00DD901F17478EF1242A28829348@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2941
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(126002)(25786009)(76130400001)(14444005)(305945005)(47776003)(8746002)(8936002)(70586007)(63350400001)(486006)(478600001)(99286004)(70206006)(26826003)(86362001)(446003)(11346002)(6512007)(7736002)(6636002)(66066001)(6486002)(476003)(26005)(54906003)(76176011)(356004)(4326008)(186003)(316002)(50466002)(23726003)(6506007)(6116002)(36906005)(386003)(22756006)(3846002)(102836004)(336012)(8676002)(46406003)(6246003)(97756001)(2906002)(14454004)(81166006)(229853002)(5660300002)(6862004)(81156014)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5040;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4c9b7b64-07e1-4684-0d6f-08d74bd2d2f8
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzXiMeM4r6BTBrEcpdNyxdtSeyzBW4APa56gg0FdfVXeG59TwWIFxhG2t2qI0wGMkHSMqISBvuVM9PIqeJvUbabLzoutw5pPnLYnyTyDc9gbhfBhT5u4x1LIbgSLiaVQ8zlhJVVdagyVH4gxw6W1L0wWuaJPdI9uG2I9yVF/grsaiUpxkn7jqp2AgM+yUVNoKQRH7/REYRV8ovrb01NHUQU3UZGoF7+bJKN55HZDjeBhd/gJc7hVkKF7N6MzZLcHR4y2H/onngbUVTBeaTm9KAZ11o4n9GSE2BG4BBiZtNbwKXOscm43xrOpZ+cHt2URSehc4/7oU6nSIaVAx7vCdfsCgdDaq5rHTRb15oMmBUV81k1zLmx3EN1u3Edt2MOXwuoWGg2ggURzTmuVAS93ywRHYL1L5xaUjr9p65rWCh0=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 09:35:26.8043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a268c5b2-8aa7-48ac-45fe-08d74bd2da06
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Tuesday, 8 October 2019 10:17:52 BST Lowry Li (Arm Technology China) wro=
te:
> Set color_depth according to connector->bpc.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    |  1 +
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 +++++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
>  .../display/komeda/komeda_pipeline_state.c    | 19 ++++++++++++++++++
>  .../arm/display/komeda/komeda_wb_connector.c  |  4 ++++
>  6 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index c3d29c0b051b..27cdb03573c1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -951,6 +951,7 @@ static void d71_improc_update(struct komeda_component=
 *c,
>  			       to_d71_input_id(state, index));
> =20
>  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> +	malidp_write32(reg, IPS_DEPTH, st->color_depth);
>  }
> =20
>  static void d71_improc_dump(struct komeda_component *c, struct seq_file =
*sf)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 75263d8cd0bd..baa986b70876 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -17,6 +17,26 @@
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> =20
> +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> +				  u32 *color_depths)
> +{
> +	struct drm_connector *conn;
> +	struct drm_connector_state *conn_st;
> +	int i, min_bpc =3D 31, conn_bpc =3D 0;
> +
> +	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
> +		if (conn_st->crtc !=3D crtc_st->crtc)
> +			continue;
> +
> +		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
> +
> +		if (conn_bpc < min_bpc)
> +			min_bpc =3D conn_bpc;
Something doesn't add up here. min_bpc is effectively set but not used.
> +	}
> +
> +	*color_depths =3D GENMASK(conn_bpc, 0);
> +}
> +
>  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcr=
tc_st)
>  {
>  	u64 pxlclk, aclk;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index 45c498e15e7a..a42503451b5d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
>  		return !!(rotation & DRM_MODE_REFLECT_X);
>  }
> =20
> +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> +				  u32 *color_depths);
>  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_st);
> =20
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev=
 *mdev);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index b322f52ba8f2..7653f134a8eb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -323,6 +323,7 @@ struct komeda_improc {
> =20
>  struct komeda_improc_state {
>  	struct komeda_component_state base;
> +	u8 color_depth;
>  	u16 hsize, vsize;
>  };
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 0ba9c6aa3708..e68e8f85ab27 100644
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
> @@ -756,6 +757,24 @@ komeda_improc_validate(struct komeda_improc *improc,
>  	st->hsize =3D dflow->in_w;
>  	st->vsize =3D dflow->in_h;
> =20
> +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> +		u32 output_depths;
> +		u32 avail_depths;
> +
> +		komeda_crtc_get_color_config(crtc_st,
> +					     &output_depths);
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
> +		st->color_depth =3D __fls(avail_depths);
> +	}
> +
>  	komeda_component_add_input(&st->base, &dflow->input, 0);
>  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 2851cac94d86..740a81250630 100644
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
> @@ -171,6 +172,9 @@ static int komeda_wb_connector_add(struct komeda_kms_=
dev *kms,
> =20
>  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
> =20
> +	info =3D &kwb_conn->base.base.display_info;
> +	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
> +
>  	kcrtc->wb_conn =3D kwb_conn;
> =20
>  	return 0;
>=20


--=20
Mihail



