Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBA3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83082173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="J5+/rvRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfC2QZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:25:50 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:60032
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728720AbfC2QZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9dLcbYcIrmQMpgZtJs22bToZyhUo2XkTuW64QPZDHA=;
 b=J5+/rvRNBksCo3nQMxPbZEmNzG1jOxfI8E9rFXVDbLyuKEEOrmvlWK07ecJOUUvGzj9HwI/smX5w7jBihCPT5DwYUguc0ERXTTJaaQ5gwRmmh7Nup2kxh79U9RtOqyzlY85Erpu57+X/HWNFHycqPnmL13JpKPF3CtdXwh8hwzw=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB5076.eurprd08.prod.outlook.com (10.255.29.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Fri, 29 Mar 2019 16:25:46 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c%4]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 16:25:46 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
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
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [RFC PATCH] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Topic: [RFC PATCH] drm/komeda: Creates plane alpha and blend mode
 properties
Thread-Index: AQHU5frlAU9hEdci3kKU4rRJ3aBkWqYizCiA
Date:   Fri, 29 Mar 2019 16:25:46 +0000
Message-ID: <20190329162545.GA8314@arm.com>
References: <1553841845-20174-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1553841845-20174-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::21) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc2c1410-e19a-4731-2a43-08d6b4633290
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB5076;
x-ms-traffictypediagnostic: AM0PR08MB5076:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB50768913F70B6B82A3F83ED6E45A0@AM0PR08MB5076.eurprd08.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(106356001)(33656002)(81166006)(386003)(476003)(81156014)(105586002)(5024004)(8936002)(256004)(3846002)(8676002)(26005)(25786009)(44832011)(68736007)(2906002)(486006)(6486002)(11346002)(37006003)(316002)(53936002)(6436002)(6512007)(6306002)(54906003)(86362001)(6246003)(99286004)(6636002)(305945005)(71190400001)(72206003)(71200400001)(478600001)(5660300002)(446003)(229853002)(2616005)(7736002)(4326008)(6862004)(97736004)(36756003)(76176011)(52116002)(966005)(186003)(66066001)(102836004)(14454004)(6506007)(1076003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5076;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VZuYfsDRXp9FdueG42IFFxWtgiK31DjAy2tj6AQ4TkIySCDCNl8uoJG1K6bIS66EJBRQWjg58rTe8mmliMzoerghjkZktIo8jmOedDZJSKhYbPr9eWbfxKxqqMMRc3602WO6uqwUcHl+YRiDPGtWVQFLoXMK/b0Qw2pzfdNFTq252BLVG7HxbctZkdFxqU+Qke7QV2hyeUQoHMoIev6lgxXmRKeuFppp+zOaBIOyJS0cRZOmmgies3PvgYXttnHAVa4cKvqD4m2e4Ojq5U605p+dqcpH2MONUGDjCJI8He73cPHk+ErLPtTxKbYmHpww3t4SnTFbULmLk3o6rGFOtsAvnVdkFE5/fX/KtqvnT2HL5hkB4TfWyHi0MltXknJ5pSwsQz3+5/uAMBY8JQ/r1FQj6Z3BNAf4RO7Ij7a2CIc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF2285F98C04A044BFDB6085BFA1F8BC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2c1410-e19a-4731-2a43-08d6b4633290
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 16:25:46.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 06:44:45AM +0000, Lowry Li (Arm Technology China) w=
rote:
> Creates plane alpha and blend mode properties attached to plane.
>=20
> Signed-off-by: Lowry Li <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index af51f0c..0ebec39 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -212,6 +212,17 @@ static int komeda_plane_add(struct komeda_kms_dev *k=
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
> --=20

Please rebase and test your patches on drm-misc-next.=20
https://drm.pages.freedesktop.org/maintainer-tools/repositories.html

> 1.9.1
