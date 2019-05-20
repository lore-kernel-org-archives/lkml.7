Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124F0C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ED320815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qjRpQRZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfETGDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:03:46 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:29999
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfETGDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLfpWUZDJSUEKFO8mAY8uLihx9jQzdbYjAS15FSkWAE=;
 b=qjRpQRZ8Cie6IhIbgbq7zUP9An3uSQvDhxcSybl3YlDRbcoP/SMjafSTKMu1+a46wrhkZZKXOUz59Z6tMi1vosJGk64ZlcxQLana/ncNj9dpeilEAsiLGR70jOvw7ohpFjCB4kw9kIRArTPtJ5Rh8wQmeNK3JbPYh5qpczOL30M=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4832.eurprd08.prod.outlook.com (10.255.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 20 May 2019 06:03:41 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 06:03:41 +0000
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
Subject: Re: [v2] drm/komeda: Creates plane alpha and blend mode properties
Thread-Topic: [v2] drm/komeda: Creates plane alpha and blend mode properties
Thread-Index: AQHVDtHFUO59T3T3VkWZqubG8mkPOA==
Date:   Mon, 20 May 2019 06:03:40 +0000
Message-ID: <20190520060334.GA2690@james-ThinkStation-P300>
References: <1554971844-22101-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1554971844-22101-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:2e::16) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7068d6b7-f7be-4ac4-2d18-08d6dce8e844
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4832;
x-ms-traffictypediagnostic: VE1PR08MB4832:
x-ms-exchange-purlcount: 3
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB48327FF72C4B9192DDDC1865B3060@VE1PR08MB4832.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(6862004)(6506007)(52116002)(99286004)(4326008)(68736007)(316002)(966005)(54906003)(53936002)(86362001)(58126008)(478600001)(386003)(6436002)(6306002)(55236004)(9686003)(305945005)(486006)(7736002)(5660300002)(11346002)(6246003)(14454004)(476003)(66066001)(102836004)(446003)(76176011)(6512007)(66476007)(66556008)(73956011)(64756008)(66446008)(25786009)(81156014)(81166006)(2906002)(256004)(66946007)(33656002)(3846002)(6116002)(186003)(6486002)(71190400001)(6636002)(26005)(229853002)(8676002)(33716001)(71200400001)(1076003)(5024004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4832;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qIGSsB0OKNsvp1XCbKtVvYOsCUZKr5HuLKVqS+oP/81f6PsOFz1I1nsDnEozeMDMYNbWdwSnHVAlXwFSCHE8YEsvx5gzSy7sim0GD8CiYAv+FjxV7TpzaO6dZTYCZXRR1vsdbRMyGpeg/gTqZLCkg7b5mciiA38KAC/baGJeFe1NSzL6jDn2uaF55pCnkguozkmsX6I07scPjqCm8N5cEzhP9Q36ouYI2zLRfgVChI2lgAoH2yM0ZokwRhD+uMv4564vdI3tzRoWm41gLDcF8d1Y9Jx0jlK0YOHCsdk/F0bwwoKy1oIStB+syW7WAnM8VcTeHIJCHGRQC1lRBoOanFa1VV8IQME5HEdDePQb7CMn8zMGURGv9H+TsB/I4eM3ZWBmX0jbSimtVszt5sg21/B1WHtFMJiON7UH6gBbpsk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0431D2006ACF2543B05189EAD3AC6BCB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7068d6b7-f7be-4ac4-2d18-08d6dce8e844
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 06:03:40.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:37:43AM +0000, Lowry Li (Arm Technology China) w=
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
> --=20
> 1.9.1
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
