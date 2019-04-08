Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89FCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF6020870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gjsqDx62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfDHHdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:33:25 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:27269
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbfDHHdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RXtrUTV/i/t7lept2PD7W47FA6JGD+lYwtCHBfum3Q=;
 b=gjsqDx623AKbQYzTDsbC1be0xNNWBnecjlYFPx0lWKQoEByDCN4Vv1Xxgct9oYNFCithvdZBliZxpr0EIupiDEXDQv6YJAT//pFJVVJ/eeU72sUtK5HAvqR4SyeSwdAXAHqeitTHOOeYk/VeY/jA9dTjvmUKMFRdj9fhR3PAkwU=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1735.eurprd08.prod.outlook.com (10.169.226.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 07:33:20 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::e47e:4064:53b5:86dc]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::e47e:4064:53b5:86dc%11]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 07:33:20 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [RFC,v2] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Topic: [RFC,v2] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Index: AQHU7d1WKUuPsGOeO0KOLFLgeLy+Kw==
Date:   Mon, 8 Apr 2019 07:33:20 +0000
Message-ID: <20190408073312.GA1419@james-ThinkStation-P300>
References: <1554372625-3659-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1554372625-3659-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bff90a6-0fb3-4329-af11-08d6bbf4791e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0801MB1735;
x-ms-traffictypediagnostic: DB6PR0801MB1735:
x-ms-exchange-purlcount: 3
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB173569401A09696A846715C8B32C0@DB6PR0801MB1735.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(136003)(396003)(39850400004)(346002)(376002)(199004)(189003)(386003)(102836004)(52116002)(476003)(446003)(11346002)(33656002)(6862004)(486006)(58126008)(76176011)(55236004)(256004)(54906003)(5024004)(4326008)(97736004)(316002)(105586002)(186003)(33716001)(25786009)(106356001)(6506007)(99286004)(26005)(71200400001)(71190400001)(53936002)(1076003)(14454004)(81156014)(66066001)(8936002)(8676002)(7736002)(305945005)(6116002)(81166006)(6512007)(5660300002)(6436002)(2906002)(478600001)(86362001)(6486002)(6636002)(6246003)(68736007)(966005)(6306002)(3846002)(9686003)(229853002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1735;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pXKNZYeLxJjrIEW1bYt934p8GZ3b0WimiSqK5PGOpnT8+0nJzC04/qevCVNBYrLRJVvf2ZOo40Ut3j3doyqTJN9NHp3x0KvwQbyXA6Voe0LamJ/YoOi2amPbfrIzvvoWk8VrX/DVFnDdxlk0FK6vbsJoGI3Y9/PDjUP/1pCmVf5Wq4WB9GBHlbwKuJe8VbBHRUB+hXQRmPtvpH8wyFESllo4aWea1iUfEIEJTr4assF74dTIQXCzqVcz3GWHT9Ga+Y7LUmILi3arA0EuIpOXMIvHe/qvwwiqjyfJJ8dPaqtgNxIqfUigSH2nkWaFpp3n8PDVMhoHE3DE5EGSw8PWRWXEL7tTLKXYtDrvto6RQ/YjkuSJ1PgKytIQMad3ws9AsV+vZRRrVh3JOM9ryhnrgxbcK6+tbu3AVVc5EaQblrs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B44572A931DEE0499D5E647368CB6A9D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bff90a6-0fb3-4329-af11-08d6bbf4791e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 07:33:20.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:10:36AM +0000, Lowry Li (Arm Technology China) w=
rote:
> Creates plane alpha and blend mode properties attached to plane.
>=20
> This patch depends on:
> - https://patchwork.freedesktop.org/series/54448/
> - https://patchwork.freedesktop.org/series/54449/
> - https://patchwork.freedesktop.org/series/54450/
>=20
> Changes since v1:
> - Adds patch denpendency in the comment
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index 68cd2c9e..aae5e80 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -220,6 +220,17 @@ static int komeda_plane_add(struct komeda_kms_dev *k=
ms,
> =20
>  	drm_plane_helper_add(plane, &komeda_plane_helper_funcs);
> =20
> +	err =3D drm_plane_create_alpha_property(plane);
> +	if (err)
> +		goto cleanup;
> +
> +	err =3D drm_plane_create_blend_mode_property(plane,
> +			BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +			BIT(DRM_MODE_BLEND_PREMULTI)   |
> +			BIT(DRM_MODE_BLEND_COVERAGE));
> +	if (err)
> +		goto cleanup;
> +
>  	return 0;
>  cleanup:
>  	komeda_plane_destroy(plane);

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
