Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C28CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBA9217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yNndyyEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390665AbfEXKuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:50:17 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:40877
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389448AbfEXKuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xqeAvNqdBn60d0nx9GinGOt5ujMTtwBY7H9n0wfzBk=;
 b=yNndyyEtBKVvwirkyzCze9iwXc+rGNbJIHNI33qSe3iiujUjugStQeB1N/tDZjHQGjiBZGvYujSsVpbEoqE8npCyj/6P5pFVOM5tdEigzpOkSTFY1icqhFtqP3YXl7xldhzRvivXrIlVj7rWxoglwnzUmb293M3xtL5Perwh5aE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4671.eurprd08.prod.outlook.com (10.255.115.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Fri, 24 May 2019 10:50:12 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1922.017; Fri, 24 May 2019
 10:50:12 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
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
Subject: Re: [PATCH] drm/komeda: Creates plane alpha and blend mode properties
Thread-Topic: [PATCH] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Index: AQHVEh52xJ4Oo9wXlU+wcwM2IPE1kA==
Date:   Fri, 24 May 2019 10:50:12 +0000
Message-ID: <20190524105006.GA18826@james-ThinkStation-P300>
References: <1558689598-2215-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1558689598-2215-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:203:52::14) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6165d8d-9ec6-4147-57f5-08d6e03598ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4671;
x-ms-traffictypediagnostic: VE1PR08MB4671:
x-ms-exchange-purlcount: 5
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB46718AA9F9BEB9600D029B7BB3020@VE1PR08MB4671.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(66446008)(66476007)(66556008)(64756008)(478600001)(54906003)(81156014)(81166006)(7736002)(14454004)(8936002)(58126008)(66946007)(5660300002)(8676002)(6486002)(73956011)(966005)(66066001)(5024004)(256004)(305945005)(33656002)(9686003)(6512007)(6636002)(6306002)(71200400001)(71190400001)(86362001)(6436002)(33716001)(386003)(6506007)(4326008)(55236004)(229853002)(6246003)(6862004)(53936002)(6116002)(102836004)(3846002)(26005)(25786009)(186003)(1076003)(316002)(68736007)(76176011)(52116002)(446003)(2906002)(476003)(99286004)(11346002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4671;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tUG3+C6inCWKDDkgogpgEm7tQQ+fpcDJ1YDeLJ5MueKBt4PetBpIqdvgnhb+NPoj18osByM1tqP2VXlDE4cjGDGN5R+mftHjuXoZvvyVqv1TF1LzWZw2UmV1xkXmzNkN9bVBsS9zywj+x4Lsl76ib+C24CDHAqOEjWwj79olYzXD0N3WaJXlAYGaAoEb1Z6+PgAWjcDw1m4xy0lv00jmgxg52TAZjYpdy2fTsxg9KQMI8Q7C5lnLHfF+5Qz7nTRzW6ulKCxDWC8adERfGqBoMT1TolBzBdZ6XJZb9f1CiqJhvJqHlLA+Au9zHrgDurHKOFgmt4SQLon0X+bKpAWU+xAK4DiKbE4W99kETna8Jb5+fhpxEQPz4f3BwQx5uzXM5PQMLUuSzj56gimnZ5+DEGyJWht1QIhTh41p7/UpGEk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6181A7944D56264781C2D7AE991D99DD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6165d8d-9ec6-4147-57f5-08d6e03598ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 10:50:12.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 05:20:24PM +0800, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Creates plane alpha and blend mode properties attached to plane.
>=20
> This patch depends on:
> - https://patchwork.freedesktop.org/series/59915/
> - https://patchwork.freedesktop.org/series/58665/
> - https://patchwork.freedesktop.org/series/59000/
> - https://patchwork.freedesktop.org/series/59002/
> - https://patchwork.freedesktop.org/series/59471/
>=20
> Changes since v1:
> - Adds patch denpendency in the comment
>=20
> Changes since v2:
> - Remove [RFC] from the subject
>=20
> Changes since v3:
> - Rebase the code
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index e7cd690..9b87c25 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -303,6 +303,17 @@ static int komeda_plane_add(struct komeda_kms_dev *k=
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
>  	err =3D komeda_plane_create_layer_properties(kplane, layer);
>  	if (err)
>  		goto cleanup;
> --=20
> 1.9.1
>=20

lgtm.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
