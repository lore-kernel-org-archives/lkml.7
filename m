Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D9C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F15206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="d5kMuFaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfETFtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:49:50 -0400
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:30093
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfETFtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b9NKP3c8ONCNOt4K+K4sntV2sS4sDajcCt5sSyFWO8=;
 b=d5kMuFawAfrpvWd43KPWcl4fvvGJPu6+NyokKEf+hPcfuDHZ/Md5KcdwDeoJ1T9kWVBVVZWw+AqTbwsXClJmjxYGaOjKX/hRF89jeeR84aUmTC70Txt6YriuEVXXHrI4a0pJTFyLxmEwevjVRoxuLrpkuX1vZIH6Y688kyyQLuE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4736.eurprd08.prod.outlook.com (10.255.112.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 20 May 2019 05:49:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 05:49:46 +0000
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
Subject: Re: [PATCH v1 1/2] drm/komeda: Update HW up-sampling on D71
Thread-Topic: [PATCH v1 1/2] drm/komeda: Update HW up-sampling on D71
Thread-Index: AQHVDs/U4h0vo+oh40m7tROen1856A==
Date:   Mon, 20 May 2019 05:49:46 +0000
Message-ID: <20190520054940.GA2308@james-ThinkStation-P300>
References: <1557987170-24032-1-git-send-email-lowry.li@arm.com>
 <1557987170-24032-2-git-send-email-lowry.li@arm.com>
In-Reply-To: <1557987170-24032-2-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 151c42a4-741d-4642-111e-08d6dce6f6c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4736;
x-ms-traffictypediagnostic: VE1PR08MB4736:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4736C1A9B5E9E58A9B2930CCB3060@VE1PR08MB4736.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(189003)(199004)(386003)(14454004)(4326008)(1076003)(66446008)(6506007)(2906002)(6862004)(5660300002)(25786009)(66476007)(6636002)(58126008)(52116002)(76176011)(15650500001)(64756008)(33656002)(26005)(6116002)(102836004)(55236004)(73956011)(66066001)(66556008)(54906003)(99286004)(66946007)(68736007)(3846002)(186003)(11346002)(6512007)(33716001)(446003)(86362001)(486006)(316002)(476003)(229853002)(6436002)(256004)(71190400001)(81156014)(8936002)(478600001)(7736002)(305945005)(9686003)(14444005)(71200400001)(6246003)(6486002)(81166006)(53936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4736;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VBmiEO3iLCWqwfy7z4vR8CDK1SKqmK5O+24BktXr7Vb1y3tXnKTAIUnhnW8hZlERmdFhDZAEDzp6e7BllSuheFg1vMKbdjLr3qBQ2k+mZ4lKma+OPVMcKaT51vgk3xmX54Nera7J5X7mm9Zf2wlJHRNGiKyZmEUQxH6vBBop6ivLLHrOsypE2y0xVF6sSkQQt9NngiHDGNQDrq5aft0dOG3Xsn6v4URqjoVsa8VcnpDNg4wfSJcB1v08Pc8JXmOLP91YifMv/cUkczNBKxn3hnqkSDZC5cYxEomWhEqo4NdjADtd+TdRUfyoHqvSHaMtMH3VlHqE4tgbRBjMTbdR1pK+VOdX7wTLXvmawxny8lgYhdy2CfdlOARfp6B1oP/LfKAHMVx1Zdftc3mVuIi+Twd5NPch75UMgHCwSsX6ncE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3AB093332EF3A14790F8A6FBC982D88C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151c42a4-741d-4642-111e-08d6dce6f6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 05:49:46.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 02:13:09PM +0800, Lowry Li (Arm Technology China) w=
rote:
> Updates HW up-sampling method according to the format type.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c | 29 ++++++++++++++++=
++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index f8846c6..dfc70f5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -212,6 +212,35 @@ static void d71_layer_update(struct komeda_component=
 *c,
>  		malidp_write32(reg, BLK_P1_PTR_HIGH, upper_32_bits(addr));
>  	}
> =20
> +	if (fb->format->is_yuv) {
> +		u32 upsampling =3D 0;
> +
> +		switch (kfb->format_caps->fourcc) {
> +		case DRM_FORMAT_YUYV:
> +			upsampling =3D fb->modifier ? LR_CHI422_BILINEAR :
> +				     LR_CHI422_REPLICATION;
> +			break;
> +		case DRM_FORMAT_UYVY:
> +			upsampling =3D LR_CHI422_REPLICATION;
> +			break;
> +		case DRM_FORMAT_NV12:
> +		case DRM_FORMAT_YUV420_8BIT:
> +		case DRM_FORMAT_YUV420_10BIT:
> +		case DRM_FORMAT_YUV420:
> +		case DRM_FORMAT_P010:
> +		/* these fmt support MPGE/JPEG both, here perfer JPEG*/
> +			upsampling =3D LR_CHI420_JPEG;
> +			break;
> +		case DRM_FORMAT_X0L2:
> +			upsampling =3D LR_CHI420_JPEG;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		malidp_write32(reg, LAYER_R_CONTROL, upsampling);
> +	}
> +
>  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
>  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
> =20
> --=20
> 1.9.1
>=20
=20
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

Looks good to me.

Thank you
