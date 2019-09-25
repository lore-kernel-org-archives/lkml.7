Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007ADC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0DD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LxSRHkIy";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LxSRHkIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfIYJfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:35:24 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:58611
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732820AbfIYJfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wPizz3GutmUJswB6mTwLOROSCCHCA1H3L9ZljLjieQ=;
 b=LxSRHkIyYGMWfVdm1UldE/XadrpqgNZR0BQ3PXEnPVQ0Lq/GU6BaxjYPGJG4DgXm6baTXeNmgXj0NuTROEnpBAcgE7CGmJosqEtAHT3VsNP9BDgEpNe5/sEu25SITa5W32BHrVfwvEZ6ndMlZmfFjj6/iv5izENHZrGIalrDx/s=
Received: from VE1PR08CA0028.eurprd08.prod.outlook.com (2603:10a6:803:104::41)
 by AM0PR08MB3811.eurprd08.prod.outlook.com (2603:10a6:208:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Wed, 25 Sep
 2019 09:35:13 +0000
Received: from DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VE1PR08CA0028.outlook.office365.com
 (2603:10a6:803:104::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21 via Frontend
 Transport; Wed, 25 Sep 2019 09:35:13 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT055.mail.protection.outlook.com (10.152.21.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Wed, 25 Sep 2019 09:35:12 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Wed, 25 Sep 2019 09:35:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6424ea4d94a928c9
X-CR-MTA-TID: 64aa7808
Received: from 827c4abc28f0.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 33A544C2-3B3B-429E-938D-BEE7EA5BCD26.1;
        Wed, 25 Sep 2019 09:35:03 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2059.outbound.protection.outlook.com [104.47.1.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 827c4abc28f0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 25 Sep 2019 09:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGjDw+MHHn7zGOnWrVCPwUqB+xeL7YdqZqTMkgOpt48VUEvjwcXBJ35eipixfoV0bkPACpzbMISlIIEk7zM6D+bs86Dy/ieg+brD97ajdRhoTxmHnnvXOS/L7iBKxmpff3JvC1utkzd2DHQ9mrftRIymwrEgD+e8CEQp+xwO+a/yn9fUqihJuNqGs0fYMN5WQFRI00zp52mMRXIGyQZGHWHZoc0MULL/+VpEUHKlfHEwd+NJU9Ney+9N2scoJpW6DJk2j5zpfH21Rjx4esWMaFw2S5gJWaYZ8aGySew2X75Rs/DIqQoOIW6fmJjxHZrWqv5hitJvpAbn08J+YbMwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wPizz3GutmUJswB6mTwLOROSCCHCA1H3L9ZljLjieQ=;
 b=LXIapqGSV1x2Gjm6JyvttRf+MXUaasfGkiBjzIdT7uZ12Ha3bzThLdqC86irX26IBwxY8kWXiI2gasbiqRyZ83vczcGUiM92/7LMv2eY8HXkxMSCOZhUY9XyiQnZh9wjjlSXpfW1YoY8l4ZfbeZT23Aep1w1JqLZp67P6jCVK88sp569WwkC5N452L3J88QJ1/s19imiQsQ/6OfuHwgBrxCNm1jqmK23MY5RLyxBcvocaYYUpQ60ZUIiklyZGJASlogrODgTrrETOxVb5qJJh/qOGZgyg9ys5gJW2RiQk0kXComOhKdbkLjf1Lxi7Y51IIm09ey0H2ISXtPtn7yzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wPizz3GutmUJswB6mTwLOROSCCHCA1H3L9ZljLjieQ=;
 b=LxSRHkIyYGMWfVdm1UldE/XadrpqgNZR0BQ3PXEnPVQ0Lq/GU6BaxjYPGJG4DgXm6baTXeNmgXj0NuTROEnpBAcgE7CGmJosqEtAHT3VsNP9BDgEpNe5/sEu25SITa5W32BHrVfwvEZ6ndMlZmfFjj6/iv5izENHZrGIalrDx/s=
Received: from DB8PR08MB5354.eurprd08.prod.outlook.com (52.133.240.216) by
 DB8PR08MB5484.eurprd08.prod.outlook.com (52.133.242.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 09:35:01 +0000
Received: from DB8PR08MB5354.eurprd08.prod.outlook.com
 ([fe80::b076:40e8:6e7b:6a18]) by DB8PR08MB5354.eurprd08.prod.outlook.com
 ([fe80::b076:40e8:6e7b:6a18%3]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 09:35:01 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>
Subject: Re: [PATCH] drm/rockchip: Add AFBC support
Thread-Topic: [PATCH] drm/rockchip: Add AFBC support
Thread-Index: AQHVcglQgFQKNg7dnEKeB+EcOCgUI6c8JO0A
Date:   Wed, 25 Sep 2019 09:35:01 +0000
Message-ID: <20190925093500.GB21018@arm.com>
References: <20190923122014.18229-1-andrzej.p@collabora.com>
In-Reply-To: <20190923122014.18229-1-andrzej.p@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0701CA0037.eurprd07.prod.outlook.com
 (2603:10a6:200:42::47) To DB8PR08MB5354.eurprd08.prod.outlook.com
 (2603:10a6:10:114::24)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fade1b2d-306f-4f62-2a6b-08d7419ba9db
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR08MB5484;
X-MS-TrafficTypeDiagnostic: DB8PR08MB5484:|AM0PR08MB3811:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <AM0PR08MB381191B6974D84B9D317065CE4870@AM0PR08MB3811.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2803;OLM:2803;
x-forefront-prvs: 01713B2841
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(36756003)(33656002)(6306002)(14444005)(6512007)(256004)(6246003)(66066001)(6916009)(71200400001)(71190400001)(229853002)(486006)(86362001)(54906003)(478600001)(44832011)(2616005)(26005)(186003)(316002)(476003)(25786009)(4326008)(446003)(11346002)(14454004)(6436002)(2906002)(966005)(52116002)(6506007)(386003)(6486002)(76176011)(66476007)(66446008)(3846002)(64756008)(66556008)(66946007)(99286004)(102836004)(30864003)(6116002)(305945005)(7736002)(5660300002)(81156014)(7416002)(81166006)(8676002)(1076003)(8936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5484;H:DB8PR08MB5354.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: /3I1PV/5cW0Kj8RfuDJkd7fS4ccJ9r4VrT28S5Uj+TLQtWCwxKh7BTgkVOtALPPpeyDE29IQTLHJVfxW5U/9FqzGtx1qo6iy6YG4pU5JXnxdv8twlTLn9PxfeElB1w1fYtsS0S8YCW3LGXoJK3o2g5du/R2OC3famKkoZ5ZwyyHKNHm3/xQ5ZCNOMlgVkLA8I0OiY/6LJ9vGr2i90OFkhKuzv0doKGN5K0R5wkHcEC1JNjKu8dsgj5D8Cb5HyppjSTVK9wNMyNfCnm2rxCi2ihJqRO6+pi66Eo5k+VJAdcSx6IGlY+q1hfAhT+Q2gYyD7dPXfzBlBsCuhTXfoGBf+ycNaBRsq838bASYE4ycU/HVZV1AUqwUFy2Po1evbJYaamnt9T6Vu+EmDq/rSVjEcszUUq4JctdQPwl2ouIjkwNkhJca+F3tpnqVzlaqEZQHEH6dpLRcB+LPpRt7LYD5ug==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD692A5B3B938242AACF43A84D240C5E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5484
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(126002)(70206006)(70586007)(476003)(2616005)(47776003)(356004)(486006)(26005)(186003)(76176011)(99286004)(6306002)(478600001)(6486002)(50466002)(229853002)(6246003)(966005)(336012)(36756003)(76130400001)(66066001)(446003)(14454004)(26826003)(1076003)(63350400001)(11346002)(6512007)(30864003)(4326008)(81166006)(6862004)(8676002)(81156014)(25786009)(8746002)(14444005)(3846002)(86362001)(305945005)(33656002)(22756006)(7736002)(23726003)(6506007)(102836004)(8936002)(97756001)(386003)(316002)(46406003)(54906003)(5660300002)(2906002)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3811;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 64d47b03-5d00-4c5f-dc21-08d7419ba32a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3811;
NoDisclaimer: True
X-Forefront-PRVS: 01713B2841
X-Microsoft-Antispam-Message-Info: TLJkrSh6/s66JuMkaKN2yfEy7XPO+3XxUfcFNJmoNTVIj6P5XLhIXV3x0QWuYw9XL39EUh5SMdm9ikZ6NP/BSj1VzasdX2+fd30eLTKLVHFDukSOxiKOeFBDON+p4YnU3cHFe1gOAdnnrm0N+PqFd31tlszLJTDOtLhDAdZUSzLd+hCOLaPwYzCDufCYvRAa1mbmvQEX+vRwYB4SMKI05OXCg/bJNzJC/TiBDjpIay6yB6g008Ts1dU5pxaRz69jCsV5bBcj3Z9fNXu9f+OCBjzZMceFiOwm2fhTz/jS3ms/xbmsmuSdhB9EQYOwTMy234Ev4n2nX+dbLBdv+Nx9iioNHb99bYkX+CFCTOB0Vd/5NZzYiA3Z/Py5oLBBtAx1u4VrBFNTCnnsLArLkk1SuTPmnewxySIrLWq0MErhIst1CEHDYGxxKj3kjt5c9UMkcWE3U7EWKych5eUN1AQmjA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2019 09:35:12.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fade1b2d-306f-4f62-2a6b-08d7419ba9db
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 02:20:13PM +0200, Andrzej Pietrasiewicz wrote:
> From: Ezequiel Garcia <ezequiel@collabora.com>
>=20
> AFBC is a proprietary lossless image compression protocol and format.
> It helps reduce memory bandwidth of the graphics pipeline operations.
> This, in turn, improves power efficiency.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> [locking improvements]
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> [squashing the above, commit message and Rockchip AFBC modifier]
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 27 ++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 94 ++++++++++++++++++++-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 12 +++
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 18 ++++
>  include/uapi/drm/drm_fourcc.h               |  3 +
>  5 files changed, 151 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm=
/rockchip/rockchip_drm_fb.c
> index 64ca87cf6d50..5178939a9c29 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -24,6 +24,27 @@ static const struct drm_framebuffer_funcs rockchip_drm=
_fb_funcs =3D {
>  	.dirty	       =3D drm_atomic_helper_dirtyfb,
>  };
> =20
> +static int
> +rockchip_verify_afbc_mod(struct drm_device *dev,
> +			 const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	if (mode_cmd->modifier[0] &
> +	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_ROCKCHIP)) {
> +		DRM_DEV_ERROR(dev->dev,
> +			      "Unsupported format modifier 0x%llx\n",
> +			      mode_cmd->modifier[0]);
> +		return -EINVAL;
> +	}
> +
> +	if (mode_cmd->width > 2560) {
> +		DRM_DEV_ERROR(dev->dev,
> +			      "Unsupported width %d\n", mode_cmd->width);
> +		return -EINVAL;
> +	}
> +
I think you are missing one additional check here.
framebuffer width and height should be aligned to 16 pixels as you are
using AFBC_FORMAT_MOD_BLOCK_SIZE_16x16.
Please have a look at malidp_verify_afbc_framebuffer_caps()

> +	return 0;
> +}
> +
>  static struct drm_framebuffer *
>  rockchip_fb_alloc(struct drm_device *dev, const struct drm_mode_fb_cmd2 =
*mode_cmd,
>  		  struct drm_gem_object **obj, unsigned int num_planes)
> @@ -32,6 +53,12 @@ rockchip_fb_alloc(struct drm_device *dev, const struct=
 drm_mode_fb_cmd2 *mode_cm
>  	int ret;
>  	int i;
> =20
> +	if (mode_cmd->modifier[0]) {
> +		ret =3D rockchip_verify_afbc_mod(dev, mode_cmd);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
>  	fb =3D kzalloc(sizeof(*fb), GFP_KERNEL);
>  	if (!fb)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/dr=
m/rockchip/rockchip_drm_vop.c
> index 21b68eea46cc..50bf214d21da 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -46,6 +46,13 @@
>  		vop_reg_set(vop, &win->phy->scl->ext->name, \
>  			    win->base, ~0, v, #name)
> =20
> +#define VOP_AFBC_SET(x, name, v) \
> +	do { \
> +		if (vop->data->afbc) \
> +			vop_reg_set(vop, &vop->data->afbc->name, \
> +				0, ~0, v, #name); \
> +	} while (0)
> +
>  #define VOP_WIN_YUV2YUV_SET(vop, win_yuv2yuv, name, v) \
>  	do { \
>  		if (win_yuv2yuv && win_yuv2yuv->name.mask) \
> @@ -123,6 +130,8 @@ struct vop {
>  	struct drm_device *drm_dev;
>  	bool is_enabled;
> =20
> +	struct vop_win *afbc_win;
> +
>  	struct completion dsp_hold_completion;
> =20
>  	/* protected by dev->event_lock */
> @@ -245,6 +254,30 @@ static bool has_rb_swapped(uint32_t format)
>  	}
>  }
> =20
> +#define AFBC_FMT_RGB565        0x0
> +#define AFBC_FMT_U8U8U8U8      0x5
> +#define AFBC_FMT_U8U8U8        0x4
> +
> +static int vop_convert_afbc_format(uint32_t format)
> +{
> +	switch (format) {
> +	case DRM_FORMAT_XRGB8888:
> +	case DRM_FORMAT_ARGB8888:
> +	case DRM_FORMAT_XBGR8888:
> +	case DRM_FORMAT_ABGR8888:
> +		return AFBC_FMT_U8U8U8U8;
> +	case DRM_FORMAT_RGB888:
> +	case DRM_FORMAT_BGR888:
> +		return AFBC_FMT_U8U8U8;
> +	case DRM_FORMAT_RGB565:
> +	case DRM_FORMAT_BGR565:
> +		return AFBC_FMT_RGB565;
> +	default:
> +		DRM_ERROR("unsupported afbc format[%08x]\n", format);
> +		return -EINVAL;
> +	}
> +}
> +
>  static enum vop_data_format vop_convert_format(uint32_t format)
>  {
>  	switch (format) {
> @@ -587,10 +620,16 @@ static int vop_enable(struct drm_crtc *crtc)
> =20
>  		vop_win_disable(vop, win);
>  	}
> -	spin_unlock(&vop->reg_lock);
> +
> +	if (vop->data->afbc) {
> +		VOP_AFBC_SET(vop, enable, 0);
> +		vop->afbc_win =3D NULL;
> +	}
> =20
>  	vop_cfg_done(vop);
> =20
> +	spin_unlock(&vop->reg_lock);
> +
>  	/*
>  	 * At here, vop clock & iommu is enable, R/W vop regs would be safe.
>  	 */
> @@ -719,6 +758,32 @@ static int vop_plane_atomic_check(struct drm_plane *=
plane,
>  		return -EINVAL;
>  	}
> =20
> +	if (fb->modifier & DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_ROCKCHIP)) {
> +		struct vop *vop =3D to_vop(crtc);
> +
> +		if (!vop->data->afbc) {
> +			DRM_ERROR("VOP does not support AFBC\n");
> +			return -EINVAL;
> +		}
> +
> +		ret =3D vop_convert_afbc_format(fb->format->format);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (state->src.x1 || state->src.y1) {
> +			DRM_ERROR("AFBC does not support offset display\n");
> +			DRM_ERROR("xpos=3D%d, ypos=3D%d, offset=3D%d\n",
> +				state->src.x1, state->src.y1, fb->offsets[0]);
> +			return -EINVAL;
> +		}
> +
> +		if (state->rotation && state->rotation !=3D DRM_MODE_ROTATE_0) {
> +			DRM_ERROR("AFBC does not support rotation\n");
> +			DRM_ERROR("rotation=3D%d\n", state->rotation);
> +			return -EINVAL;
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -732,6 +797,9 @@ static void vop_plane_atomic_disable(struct drm_plane=
 *plane,
>  	if (!old_state->crtc)
>  		return;
> =20
> +	if (vop->afbc_win =3D=3D vop_win)
> +		vop->afbc_win =3D NULL;
> +
>  	spin_lock(&vop->reg_lock);
> =20
>  	vop_win_disable(vop, win);
> @@ -774,6 +842,9 @@ static void vop_plane_atomic_update(struct drm_plane =
*plane,
>  	if (WARN_ON(!vop->is_enabled))
>  		return;
> =20
> +	if (vop->afbc_win =3D=3D vop_win)
> +		vop->afbc_win =3D NULL;
> +
>  	if (!state->visible) {
>  		vop_plane_atomic_disable(plane, old_state);
>  		return;
> @@ -808,6 +879,20 @@ static void vop_plane_atomic_update(struct drm_plane=
 *plane,
> =20
>  	spin_lock(&vop->reg_lock);
> =20
> +	if (fb->modifier & DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_ROCKCHIP)) {
> +		int afbc_format =3D vop_convert_afbc_format(fb->format->format);
> +
> +		VOP_AFBC_SET(vop, format, afbc_format | 1 << 4);
> +		VOP_AFBC_SET(vop, hreg_block_split, 0);
> +		VOP_AFBC_SET(vop, win_sel, win_index);
> +		VOP_AFBC_SET(vop, hdr_ptr, dma_addr);
> +		VOP_AFBC_SET(vop, pic_size, act_info);
> +
> +		vop->afbc_win =3D vop_win;
> +
> +		pr_info("AFBC on plane %s\n", plane->name);
> +	}
> +
>  	VOP_WIN_SET(vop, win, format, format);
>  	VOP_WIN_SET(vop, win, yrgb_vir, DIV_ROUND_UP(fb->pitches[0], 4));
>  	VOP_WIN_SET(vop, win, yrgb_mst, dma_addr);
> @@ -1163,6 +1248,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *=
crtc,
> =20
>  	spin_lock(&vop->reg_lock);
> =20
> +	VOP_AFBC_SET(vop, enable, vop->afbc_win ? 0x1 : 0);
>  	vop_cfg_done(vop);
> =20
>  	spin_unlock(&vop->reg_lock);
> @@ -1471,7 +1557,8 @@ static int vop_create_crtc(struct vop *vop)
>  					       0, &vop_plane_funcs,
>  					       win_data->phy->data_formats,
>  					       win_data->phy->nformats,
> -					       NULL, win_data->type, NULL);
> +					       win_data->phy->format_modifiers,
> +					       win_data->type, NULL);
>  		if (ret) {
>  			DRM_DEV_ERROR(vop->dev, "failed to init plane %d\n",
>  				      ret);
> @@ -1511,7 +1598,8 @@ static int vop_create_crtc(struct vop *vop)
>  					       &vop_plane_funcs,
>  					       win_data->phy->data_formats,
>  					       win_data->phy->nformats,
> -					       NULL, win_data->type, NULL);
> +					       win_data->phy->format_modifiers,
> +					       win_data->type, NULL);
>  		if (ret) {
>  			DRM_DEV_ERROR(vop->dev, "failed to init overlay %d\n",
>  				      ret);
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/dr=
m/rockchip/rockchip_drm_vop.h
> index 2149a889c29d..dc8b12025269 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> @@ -77,6 +77,16 @@ struct vop_misc {
>  	struct vop_reg global_regdone_en;
>  };
> =20
> +struct vop_afbc {
> +	struct vop_reg enable;
> +	struct vop_reg win_sel;
> +	struct vop_reg format;
> +	struct vop_reg hreg_block_split;
> +	struct vop_reg pic_size;
> +	struct vop_reg hdr_ptr;
> +	struct vop_reg rstn;
> +};
> +
>  struct vop_intr {
>  	const int *intrs;
>  	uint32_t nintrs;
> @@ -128,6 +138,7 @@ struct vop_win_phy {
>  	const struct vop_scl_regs *scl;
>  	const uint32_t *data_formats;
>  	uint32_t nformats;
> +	const uint64_t *format_modifiers;
> =20
>  	struct vop_reg enable;
>  	struct vop_reg gate;
> @@ -169,6 +180,7 @@ struct vop_data {
>  	const struct vop_output *output;
>  	const struct vop_win_yuv2yuv_data *win_yuv2yuv;
>  	const struct vop_win_data *win;
> +	const struct vop_afbc *afbc;
>  	unsigned int win_size;
> =20
>  #define VOP_FEATURE_OUTPUT_RGB10	BIT(0)
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/dr=
m/rockchip/rockchip_vop_reg.c
> index 7b9c74750f6d..e9ff0c43c396 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -30,6 +30,12 @@
>  #define VOP_REG_MASK_SYNC(off, _mask, _shift) \
>  		_VOP_REG(off, _mask, _shift, true, false)
> =20
> +static const uint64_t format_modifiers_afbc[] =3D {
> +	DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_ROCKCHIP),
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
>  static const uint32_t formats_win_full[] =3D {
>  	DRM_FORMAT_XRGB8888,
>  	DRM_FORMAT_ARGB8888,
> @@ -667,6 +673,7 @@ static const struct vop_win_phy rk3368_win01_data =3D=
 {
>  	.scl =3D &rk3288_win_full_scl,
>  	.data_formats =3D formats_win_full,
>  	.nformats =3D ARRAY_SIZE(formats_win_full),
> +	.format_modifiers =3D format_modifiers_afbc,
>  	.enable =3D VOP_REG(RK3368_WIN0_CTRL0, 0x1, 0),
>  	.format =3D VOP_REG(RK3368_WIN0_CTRL0, 0x7, 1),
>  	.rb_swap =3D VOP_REG(RK3368_WIN0_CTRL0, 0x1, 12),
> @@ -758,6 +765,16 @@ static const struct vop_data rk3366_vop =3D {
>  	.win_size =3D ARRAY_SIZE(rk3368_vop_win_data),
>  };
> =20
> +static const struct vop_afbc rk3399_afbc =3D {
> +	.rstn =3D VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 3),
> +	.enable =3D VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 0),
> +	.win_sel =3D VOP_REG(RK3399_AFBCD0_CTRL, 0x3, 1),
> +	.format =3D VOP_REG(RK3399_AFBCD0_CTRL, 0x1f, 16),
> +	.hreg_block_split =3D VOP_REG(RK3399_AFBCD0_CTRL, 0x1, 21),
> +	.hdr_ptr =3D VOP_REG(RK3399_AFBCD0_HDR_PTR, 0xffffffff, 0),
> +	.pic_size =3D VOP_REG(RK3399_AFBCD0_PIC_SIZE, 0xffffffff, 0),
> +};
> +
>  static const struct vop_output rk3399_output =3D {
>  	.dp_pin_pol =3D VOP_REG(RK3399_DSP_CTRL1, 0xf, 16),
>  	.rgb_pin_pol =3D VOP_REG(RK3368_DSP_CTRL1, 0xf, 16),
> @@ -808,6 +825,7 @@ static const struct vop_data rk3399_vop_big =3D {
>  	.modeset =3D &rk3288_modeset,
>  	.output =3D &rk3399_output,
>  	.misc =3D &rk3368_misc,
> +	.afbc =3D &rk3399_afbc,
>  	.win =3D rk3368_vop_win_data,
>  	.win_size =3D ARRAY_SIZE(rk3368_vop_win_data),
>  	.win_yuv2yuv =3D rk3399_vop_big_win_yuv2yuv_data,
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.=
h
> index 3feeaa3f987a..ba6caf06c824 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -742,6 +742,9 @@ extern "C" {
>   */
>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> =20
> +#define AFBC_FORMAT_MOD_ROCKCHIP \
> +	(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 | AFBC_FORMAT_MOD_SPARSE)
> +
>  /*
>   * Allwinner tiled modifier
>   *
> --=20
> 2.17.1
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
