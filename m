Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D6C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBD72168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I8ch/+BP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="I8ch/+BP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391472AbfJPIKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:10:11 -0400
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]:6006
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391446AbfJPIKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z80pWqedfnhFFNI7iJtzIpb35fhHBNOf5hrlUIMxdSY=;
 b=I8ch/+BP52tIssYSVk3D9EEjO4NDzFHK2JB0r4tNVXjBtRh/jjPD5sUruvrimJzqBLuMq+DIt1Zu34saHmAnSmdCdYYFkpl2Ir6GcbkAWKEAM3vGPbn5tIaeaxorG6P6FuJr0ZfCqtnIAwwmBcAL1AnbtiFMVd3UG0r3NhIXb5c=
Received: from AM6PR08CA0043.eurprd08.prod.outlook.com (2603:10a6:20b:c0::31)
 by AM0PR08MB3442.eurprd08.prod.outlook.com (2603:10a6:208:d7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18; Wed, 16 Oct
 2019 08:10:04 +0000
Received: from AM5EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by AM6PR08CA0043.outlook.office365.com
 (2603:10a6:20b:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via Frontend
 Transport; Wed, 16 Oct 2019 08:10:04 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT050.mail.protection.outlook.com (10.152.17.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 08:10:02 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Wed, 16 Oct 2019 08:09:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 133d53414703e0b1
X-CR-MTA-TID: 64aa7808
Received: from 2a8688507bc6.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 23BFBCD8-4B83-49EF-B528-CE6E488EE332.1;
        Wed, 16 Oct 2019 08:09:50 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2a8688507bc6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 08:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuHsY5fp+BOsJXoFSSmT/ZW5efTg8Ph5R5m1N1LC+Zu0xV8LzgqLQ67NolVzdApxcOiJMyt+g58107obQRnzMJC4cXqEDUrq/3jEZHgVY7LoPLa91t+PFH7geDes6CWbddqiWPCrkDNVnwfsCAsU6sDH5pWGP65jR3/EoOVi5tjfQMtTgO03vtfE9mnSPXQaOIreLhURvz2xTiknrVSVLXxzh/oKA52egL1/H8K26jK9rnejDBb+U5akKURSoRedi4tX9Grg0/ma4wvm/P3T5vWIemXY4TdZmtGP8xpHezcIJL+WOoAky5jQXcIpBvHZlFG/opnhsd+owrehnTIuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z80pWqedfnhFFNI7iJtzIpb35fhHBNOf5hrlUIMxdSY=;
 b=EJ3wFEafd6o7O/T6JfGs4LXr8MHvd3+ruxU8iMiq5idZ8wRNAd50vKZyToEaDqwzEl4pc6WoNuKV51IiL9+nVuSMk6GNg7lPH3D5kFfIMAOx90lLQpZqg+2F+jCcH/REdhc17qnwkerDBNIMhhZc1Svo0W+S63eEImOWp5zBPsxIKrqaB0SbZLKss290duhe60uAOY2XtSZntTQuNvnl0GQfy3WS+WeTCD/RJm+hTN5x0OPHbg+F/4jG5vFjtm4Aseawd9g5iZA+6fhmoOhULt88uZxOJETQT73FMMaa6sKM5QIv49hSvOUcPxxfvhE2ZeYzmB3VbBqJ+pTkosZrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z80pWqedfnhFFNI7iJtzIpb35fhHBNOf5hrlUIMxdSY=;
 b=I8ch/+BP52tIssYSVk3D9EEjO4NDzFHK2JB0r4tNVXjBtRh/jjPD5sUruvrimJzqBLuMq+DIt1Zu34saHmAnSmdCdYYFkpl2Ir6GcbkAWKEAM3vGPbn5tIaeaxorG6P6FuJr0ZfCqtnIAwwmBcAL1AnbtiFMVd3UG0r3NhIXb5c=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5231.eurprd08.prod.outlook.com (10.255.112.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 08:09:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 08:09:46 +0000
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
Subject: Re: drm/komeda: Set output color depth for output
Thread-Topic: drm/komeda: Set output color depth for output
Thread-Index: AQHVg/kSgDabgbeV5EilMum8jdKQuA==
Date:   Wed, 16 Oct 2019 08:09:46 +0000
Message-ID: <20191016080938.GA4009@jamwan02-TSP300>
References: <20191012065030.12691-1-lowry.li@arm.com>
In-Reply-To: <20191012065030.12691-1-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 2532aad9-4270-4cc9-652d-08d752103f01
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5231:|VE1PR08MB5231:|AM0PR08MB3442:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB34424D6995B0E9BA7BE2D13DB3920@AM0PR08MB3442.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:255;OLM:255;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(9686003)(11346002)(102836004)(486006)(2906002)(5660300002)(55236004)(3846002)(1076003)(6436002)(66066001)(4326008)(476003)(446003)(25786009)(33656002)(33716001)(6512007)(229853002)(6862004)(6486002)(478600001)(26005)(6116002)(6246003)(71200400001)(305945005)(6636002)(71190400001)(256004)(316002)(14454004)(66446008)(66476007)(66946007)(64756008)(66556008)(8676002)(7736002)(52116002)(186003)(8936002)(81156014)(58126008)(81166006)(86362001)(386003)(76176011)(99286004)(6506007)(54906003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5231;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: WjENv1gKZ8PAh9t2BOlzf3kMVfiWZLQxGlRbdPjryz/0TP0DU4zl7F2yy0nOahfW6Eg6Rc70xOGqefrNZASzCluncUFwt58DMi5yc4mfCg3WjcZow6UJMnxT/m4zXtwKWy//j4g14FD4ox9FAMTBDqaSs7DMWOMA5csbJqucsGi/OTS0w/QYkvrCwCBonMMsUH7r9cjApsy3BnNE24DcLnF6ITeZk/7uZBwhHdmolMOH3gXnhXYBarjQLDNLGuA4zIbRji28LiMYFvMeqG3XLMgJPvRga0yyPO4brzK3N/g6P5CmoqSKTfTuxs3dlPBfti2IquEHg5aHlaPPs06eS1pUDTss5o2RRjwAT6t+cddK3jcrhsTY8HBhkVbY04DN1YTBQf9IVPAQptIgvu/V2fiXSnIHuqHLXkL8nxLrbDk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D771C47678B1FE4180A577426A754556@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5231
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(50466002)(81156014)(11346002)(86362001)(99286004)(70586007)(76130400001)(3846002)(6116002)(476003)(63350400001)(186003)(70206006)(76176011)(6506007)(386003)(8676002)(2906002)(81166006)(23726003)(486006)(4326008)(126002)(6862004)(102836004)(446003)(8746002)(46406003)(8936002)(25786009)(6636002)(66066001)(7736002)(6512007)(33656002)(305945005)(9686003)(6246003)(229853002)(14444005)(356004)(26826003)(478600001)(22756006)(36906005)(47776003)(97756001)(316002)(336012)(6486002)(5660300002)(26005)(1076003)(33716001)(14454004)(54906003)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3442;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f5e7d49-4125-4fad-ec26-08d752103513
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVCDevkT2YgITuTZBvEmNSSkVdEAqpCOLCXqZ4JCLRD4edFIEFhJAjwDVf1jR0ThFBOogbKBX+HeheBMiDlZIgMfwR1TyFv8Emabaizfy9/k6osO8eUkvVNp47TSfFfXrDnYZti+kbKvd6CwWf/nHHay3oG8Kl+/D0mQg41WerUy6ofD/deH90vqwdCzR6DXpQcciWsphjaulGxBTrTsCewaHQhko0y96QBkSsvgK2L87oYjjG10qCL3CEs4WcfCEC0S6RWOnOf2hw1i3aykjYLl7/oBFeC7dS4Xv64QxT6liWK18iiDFOobefhuVUiiJAAfeRNnvAAviwxM6HYkuDHToJsnhp4xDUxaJ7whL8fJ3nrC+MzPUJMzfGz0a+jzvjNthAWRmWuLxK9C9l2lvcVbtYKGT2+SeaoDtPBDae8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 08:10:02.5674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2532aad9-4270-4cc9-652d-08d752103f01
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3442
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 06:50:46AM +0000, Lowry Li (Arm Technology China) w=
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
> Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
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

Looks good to me.

I'll push it to drm-misc-next.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>


