Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E869AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A6B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1Rme2eM/";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1Rme2eM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfJNJzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:55:23 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:33830
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731001AbfJNJzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Klz+9hMdl8fouUUvlSsItuNHFkyXDK66yx8iuW8dFo=;
 b=1Rme2eM/C3fxHBOoP936ybruw7yQbJFgT8kgBVwesF/FuHvc+gHQHUdPqlbm0L/k5KSeGSUDTWlwu2sZeBQNZBtTL48KI+jq9NZcgxkUyFlil9X5NPmm9qrAJYmHooORcpx5zZ7qmlC9s+3z75ND5n/68c4jiY/ergCt0B1VZso=
Received: from VI1PR08CA0275.eurprd08.prod.outlook.com (2603:10a6:803:dc::48)
 by DB6PR0802MB2552.eurprd08.prod.outlook.com (2603:10a6:4:a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Mon, 14 Oct
 2019 09:55:16 +0000
Received: from AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR08CA0275.outlook.office365.com
 (2603:10a6:803:dc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Mon, 14 Oct 2019 09:55:16 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT047.mail.protection.outlook.com (10.152.16.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 14 Oct 2019 09:55:14 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Mon, 14 Oct 2019 09:55:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6fd901d59fb9c6bd
X-CR-MTA-TID: 64aa7808
Received: from dee179f10278.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 98325F3E-F3E9-4E4D-AB6C-639A8CAAEE33.1;
        Mon, 14 Oct 2019 09:55:01 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dee179f10278.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Oct 2019 09:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F69uU0Me8LAoNzLkuo6YkTHMCOq4Ma0PXP8N8JXC0EVOf2eqxXyTs25PuJ4LZ7FzuHIEBunAbiFqCOB6j3/qEHE7LAOTPxyYBR8Swfx2rzEAlNUHQ+7rtSRVzvPlvQ3VPFaQynY3OfrwzRnV9NJBMKd6dIpx9u+q29Drdcs044cBwAorL7c7KARvjd2BrJwI2vKOSx7CF1sf7YNI0Ck6tJD7e1yOew5rbw2/+4sgSNT32sqTAeg/W78oxbQQkZt+DJK/OscJ1iAiPyu9XQl/1PcrSKrkdXOhyEjcujyHvW46+62h6QSPFt/lym8Ym68L6MtOoC/6kFuHYBTrPGUV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Klz+9hMdl8fouUUvlSsItuNHFkyXDK66yx8iuW8dFo=;
 b=hgAPc5S5j1n7roR8MGegn6176AxLxFWjqdLkzNiJboBi1MZOCp+5I7dy50BhSdu/Mf/9dse9Ep2lPDklcRxGlWwqo7gvfmDg2Qgb/YVjGQukPkTVpe1KSHD3CX3lWAJD3ft3E6KYDAy49mh5nwmD3a/L28lPGV9MsV6n/4+h/sXzMYpPaWt1Y3bEZRbb3/QBEN+pOioG13i0YIS+otDrBFv4jso7QIp3t5UskZwAfdUlnCDwTywNAXgTE+maHkonNViPIPVhkYIHDZp16lIAZEwnJo6V2tkEwb+H7oLjQegtJLXt8AfgXOmyWYyFHVtjRrj0QQlgcRZiPaykMdEDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Klz+9hMdl8fouUUvlSsItuNHFkyXDK66yx8iuW8dFo=;
 b=1Rme2eM/C3fxHBOoP936ybruw7yQbJFgT8kgBVwesF/FuHvc+gHQHUdPqlbm0L/k5KSeGSUDTWlwu2sZeBQNZBtTL48KI+jq9NZcgxkUyFlil9X5NPmm9qrAJYmHooORcpx5zZ7qmlC9s+3z75ND5n/68c4jiY/ergCt0B1VZso=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2893.eurprd08.prod.outlook.com (10.170.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Mon, 14 Oct 2019 09:54:58 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 09:54:58 +0000
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
Thread-Index: AQHVgMlgRjNZSavPFUK1VMeh9loRYKdZ6UoA
Date:   Mon, 14 Oct 2019 09:54:57 +0000
Message-ID: <2096697.gnXSny8DX0@e123338-lin>
References: <20191012065030.12691-1-lowry.li@arm.com>
In-Reply-To: <20191012065030.12691-1-lowry.li@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 6b3cd3e4-951b-4c78-8c7d-08d7508c9c71
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB2893:|VI1PR08MB2893:|DB6PR0802MB2552:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB255201712D9B7D1ADBEA32A98F900@DB6PR0802MB2552.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4714;OLM:4714;
x-forefront-prvs: 01901B3451
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(5660300002)(386003)(11346002)(6636002)(446003)(71200400001)(476003)(6116002)(71190400001)(6246003)(14454004)(6506007)(486006)(186003)(26005)(54906003)(316002)(8676002)(66476007)(66946007)(8936002)(64756008)(66446008)(66556008)(3846002)(81156014)(81166006)(6486002)(14444005)(102836004)(256004)(99286004)(4326008)(86362001)(66066001)(33716001)(229853002)(7736002)(305945005)(52116002)(6512007)(9686003)(25786009)(6436002)(76176011)(6862004)(2906002)(478600001)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2893;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3ShnrpKYNbaH/DA6hNB9LW7g2eAMckAxL+eAvgyMkoTqPCHk+1soyrzySF1L0fLLT+YL8BahpK3NR6mMGxQW1hSYi5NCPMANAOo62tZzxa0lFSr2/CVsmxgaUqymuw3jRwyjsZhv90AGQxEBtcd6FvNIU2XLGn0ug3cEXMxlAbM0tisSc/KR2MMi1ytwGjxw+Ul6iBQWeQ5bmApViRy867Uomxm7srUTfD7EZS+ClTj6B/hd11t+xgyPFTg0xpjfffZUhX4L8yT5EtHcYHRHYW92knHo5V5BVQw1DIvLI1M13vgHIIqGX9A/37tE4atGHTvhxZ5enzGDRFWGELGxDMywDpPHiuBhjBg4BWKHvkaydD2RWIFD3j/pNgIhgVlOKZEFzTiSz3fpuA1U+zAckwap5HrNa9nd2tdif//PMYI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14A88B7A30E7704C8BA8278A63477613@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2893
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(305945005)(3846002)(186003)(70206006)(2906002)(6862004)(6636002)(6116002)(26005)(26826003)(478600001)(6506007)(5660300002)(386003)(102836004)(22756006)(33716001)(6486002)(7736002)(46406003)(6246003)(23726003)(70586007)(76176011)(126002)(66066001)(14454004)(99286004)(47776003)(76130400001)(50466002)(81156014)(486006)(4326008)(6512007)(446003)(8936002)(81166006)(8746002)(476003)(11346002)(356004)(316002)(25786009)(9686003)(36906005)(336012)(8676002)(14444005)(54906003)(86362001)(229853002)(97756001)(63350400001)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2552;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 59f51bc8-1df2-4089-33cb-08d7508c9242
NoDisclaimer: True
X-Forefront-PRVS: 01901B3451
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1qTo9+aGGQQosyVsq0kTGyDO1PMRfc31IC4NRQJHE7xozyAvpEfqYMHaXK2xtiS/uo1wL/bScCcD1EZZm8tr68lcaWy53ByeiB7aOHumAaGzs1CZhjBNsPSykcB78Qttb2N8Nib3lEo3uQtvxNvtWg/eThZDE0g1nW/U2FiBTAEa9iHKVL8HRnjMI3yjOHhjIZ0qETZ5IEnrqJJdZhuU3hESZD4CWE7kddzdNu53ciBXFczC5vHBR1BCylR+XfiZaBuC1QR7303ZtiUpKr1xKGq2c976eVqwQ+9sTvqXkqJ8PS4cqvmIrtvLAy/hbl2J1xUZHyvHyilVmGAXsYN7QXD3DSY2SkTwAoFj1s8QR+DiRu452ejgjUa4qdxIVyLWF2iZHEWlynQfJKDYA41q6U+4k+yr+VX2AWoWd6k1Hg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2019 09:55:14.4733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3cd3e4-951b-4c78-8c7d-08d7508c9c71
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

For future reference, it's quite useful for the reader if you put the
patch version in the subject line (e.g. [PATCH v3] ...) :).


On Saturday, 12 October 2019 07:50:46 BST Lowry Li (Arm Technology China) w=
rote:
> Set color_depth according to connector->bpc.
>=20
> Changes since v1:
>  - Fixed min_bpc is effectively set but not used in
> komeda_crtc_get_color_config().
>=20
> Changes since v2:
>  - Align the code.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    |  1 +
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 +++++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
>  .../display/komeda/komeda_pipeline_state.c    | 18 +++++++++++++++++
>  .../arm/display/komeda/komeda_wb_connector.c  |  4 ++++
>  6 files changed, 46 insertions(+)
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
> index 75263d8cd0bd..fe295c4fca71 100644
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
> +	}
> +
> +	*color_depths =3D GENMASK(min_bpc, 0);
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
> index 0ba9c6aa3708..e64bfeaa06c7 100644
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
> @@ -756,6 +757,23 @@ komeda_improc_validate(struct komeda_improc *improc,
>  	st->hsize =3D dflow->in_w;
>  	st->vsize =3D dflow->in_h;
> =20
> +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> +		u32 output_depths;
> +		u32 avail_depths;
> +
> +		komeda_crtc_get_color_config(crtc_st, &output_depths);
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

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

--=20
Mihail



