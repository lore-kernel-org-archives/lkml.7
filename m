Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2095FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4A5206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="G7scHcWg";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="G7scHcWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfJHJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:36:35 -0400
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:54336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730057AbfJHJge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u3fsA7IgHO3lkDUiux/XCJy1VY+fTxvvhg4ueY+n/Q=;
 b=G7scHcWgdN3Gvmmm2z/JmJyWelMER3b7VNn9QuMhMIrqsh3q0G3li7nGnzOZybX//Ba8v9vYWcgqB5kHf0s/GvG45etS8WYWZrEPWVncRO59xDOgz/ydUprOO+EScXL5uvGoaDEA43VUMFAnQbbKIPAqEaWbwdbKKJqahdZQAMA=
Received: from VI1PR0802CA0029.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::15) by AM7PR08MB5366.eurprd08.prod.outlook.com
 (2603:10a6:20b:107::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 09:36:23 +0000
Received: from DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by VI1PR0802CA0029.outlook.office365.com
 (2603:10a6:800:a9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 8 Oct 2019 09:36:23 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT029.mail.protection.outlook.com (10.152.20.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 09:36:21 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Tue, 08 Oct 2019 09:36:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 325ce9b1d1615056
X-CR-MTA-TID: 64aa7808
Received: from d1a38d61bde0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 45A2E712-6474-42AE-A206-D92D326E6655.1;
        Tue, 08 Oct 2019 09:36:12 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d1a38d61bde0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Oct 2019 09:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VapN4JiVHPLuJzRskgaH7WAbHtRb2Uqstlr/4blVZrKEJy9wEXrbVe7Z5QOvwlN+yMjeDmP149SS1Txg2Q1vHIa2BpFq4A4Cbl6ohkF8VtryA7IJPan13egHEbSqWZbVaEMBEBL0qJ9/idCjLFaMsIkRKW1mHfH1n1JEnnOgLwmwuUt0XWUE6InDy9dwDqbARzki9CV8lTF8znnvOoDrITgemjjD0kGkyiqtNj4F22sPrancstGHOg1VRpI+7gnSPczVcM8bajZITw248XIqM9m4K1JWNHqG9QGC9FwgZnvd5zEfDTwV1yLFUpoXDygU8w5k/+9X1xNj0O9QatBxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u3fsA7IgHO3lkDUiux/XCJy1VY+fTxvvhg4ueY+n/Q=;
 b=CbpReX5Kc1B5VX+Bqq04YzD67/hAIESnolr0F5ATLsXYpieyYTuc4Akum7+AAIPzCGXRLkqyt1i+z2CTxhKhcjmkXPSkxZGbx2BVaEUv6dspMxDiVa5hhbwRDbjdV70V7MIFGL42S1FDimKlDq8bbqOjM/K4Nd8VmNyOcTqWikMUiNdcDa4u8HZZUVO8ab8t/k48728qyLInBeze3rGfZzmVvTUjeWDvTT/Y+VAZg1kTFuHvWB2e9RIyM34Ugz+idoFpt7BAOqJgO6o0cLCByZJgISks37Umw5WHhbTKOD1EwN7iprB7mF1CRenl8fc1dLLrArYpW72Ur1xwLSgJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u3fsA7IgHO3lkDUiux/XCJy1VY+fTxvvhg4ueY+n/Q=;
 b=G7scHcWgdN3Gvmmm2z/JmJyWelMER3b7VNn9QuMhMIrqsh3q0G3li7nGnzOZybX//Ba8v9vYWcgqB5kHf0s/GvG45etS8WYWZrEPWVncRO59xDOgz/ydUprOO+EScXL5uvGoaDEA43VUMFAnQbbKIPAqEaWbwdbKKJqahdZQAMA=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3143.eurprd08.prod.outlook.com (52.135.163.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 09:36:09 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.016; Tue, 8 Oct 2019
 09:36:09 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Set output color depth for output
Thread-Topic: [PATCH] drm/komeda: Set output color depth for output
Thread-Index: AQHVfblD7I+ubO1huUCp0qQz7Z0Q4adQfC0A
Date:   Tue, 8 Oct 2019 09:36:09 +0000
Message-ID: <20191008093608.eyr5ygc2lkkaaqia@DESKTOP-E1NTVVP.localdomain>
References: <20191008091734.19509-1-lowry.li@arm.com>
In-Reply-To: <20191008091734.19509-1-lowry.li@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0365.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::17) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 353daf48-2675-466f-add5-08d74bd2fab0
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3143:|AM6PR08MB3143:|AM7PR08MB5366:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53663A6D92CE5FDB52046B49F09A0@AM7PR08MB5366.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4714;OLM:4714;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(6116002)(6862004)(4326008)(25786009)(66946007)(2906002)(6512007)(9686003)(66066001)(58126008)(6506007)(6636002)(316002)(11346002)(71200400001)(8676002)(476003)(71190400001)(44832011)(6486002)(305945005)(386003)(81166006)(66476007)(66556008)(64756008)(66446008)(1076003)(81156014)(486006)(446003)(54906003)(6246003)(7736002)(86362001)(256004)(52116002)(14454004)(14444005)(76176011)(26005)(99286004)(5660300002)(229853002)(8936002)(102836004)(478600001)(186003)(3846002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3143;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /mHMHO+fxnaO8KfMEKwlTXG1vAir0pi3lyypcmqtl8C3r3Jcynyn2j8vBsvDjZgu/PzFeJ35zpdhkGhBqEJ2phcXydmkHQoy/+7nLAlAm5aFsmjlC8qFLONMdqjf/yVkQnEW5pG0tM2RWLf6UNlaSowWU6d19oF4UFoSt1yxGO0tttOisoewgi3xn7EMGuAJzIItWhcz+Icooi1McDsGpHh6ZWNqGrzY7h3w1cqad3D5OVA63tPXTJKDeGJSsdkEw1v7PzJcbyS4gdhTfZmu64wLOxMj6wHVvHKwMcr4VsM3/p7hzznkGkYGHcHeKzsY1t+66GjwF4S4r9XkVX1AVu/jVJTnQiMvWLu1Azcsd6GgGu7JHUcfLrYiA1Bn2PEDNTO0OVINYjHOJl/ed0z8sqhyHgniMpSieVR0zn0HlcA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <280E1A7559980D48B01470CD2513E1D7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3143
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(66066001)(5660300002)(25786009)(7736002)(70586007)(9686003)(6512007)(386003)(47776003)(6506007)(6246003)(316002)(70206006)(4326008)(3846002)(356004)(23726003)(305945005)(76176011)(99286004)(54906003)(6116002)(6862004)(97756001)(58126008)(14444005)(186003)(486006)(126002)(6636002)(476003)(2906002)(86362001)(26005)(8936002)(102836004)(81156014)(50466002)(11346002)(8746002)(81166006)(14454004)(22756006)(76130400001)(6486002)(46406003)(1076003)(478600001)(8676002)(229853002)(26826003)(63350400001)(446003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5366;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: f45ce3ad-cc85-4994-857f-08d74bd2f359
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3+OmKLYRnsc+m8GuZ5zgFqRIdNLGBbKNTKYmFGHg4AbUoW4frxeYa6vCEmvQ60SAF6uHk3PO1mgDoqDADIE95GGVsAGEmE2UpGgN+6MncZIdXkclE+/5dK5TiPwrcqgrv3ctaO4BOJGNjo+8aRxzYVRxc6YUio/34Uuhzvqz6DsJ+EJHsTGmtyyVKXcMR43HsimZBCIGxKmmQDRMMbAa2fa6A9SPSDIZzHqEN3bLI9QAyJ3cBCVlBKY674PrOFu1lgXumSQgRvuoHdPbCcpDbnPEqqHL5HsNxd55o0Ora0tf3w044ADZ8GDEbTLqlv953AOMYffsVp6nRx2HWrzakfTmOVcIAeH0242jQJ0iQsFgGhurw5gjbSTIyxUa+EMlH76dwhf81vyQ3KFGPahRx5E601mwqgbSkhKo86omI4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 09:36:21.6812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353daf48-2675-466f-add5-08d74bd2fab0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Tue, Oct 08, 2019 at 09:17:52AM +0000, Lowry Li (Arm Technology China) w=
rote:
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

We can have multiple connectors on a single CRTC (e.g. normal +
writeback), so what's the expected behaviour here in that case?

> +
> +		if (conn_bpc < min_bpc)
> +			min_bpc =3D conn_bpc;
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

The IPS color depth doesn't really apply to writeback. Maybe we should
just skip the writeback connector?

Thanks,
-Brian

>  	kcrtc->wb_conn =3D kwb_conn;
> =20
>  	return 0;
> --=20
> 2.17.1
>=20
