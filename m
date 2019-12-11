Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9726C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE86208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="w2A9WgAU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="w2A9WgAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfLKRaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:30:21 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:31159
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729609AbfLKRaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u06jmu2D/8YUMymSB5K7vVkoOJMOJErSBpiGDn56oxM=;
 b=w2A9WgAUpN+ROmgBi1zDDIBWwMwaaHmmbcGGgSYeWgWQpkrqmoRZpuvdZH+82LOIdNfok1sTuOJIsibld9HGUAA8mYgkqzwW75s3wghxac06HLogTvq157sGNLyhW4BwWixLJWhG8VIlB1tjTLAFbNKW2Dpu7weZsbrCiXTWKeQ=
Received: from VI1PR0801CA0084.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::28) by AM5PR0801MB1777.eurprd08.prod.outlook.com
 (2603:10a6:203:3a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Wed, 11 Dec
 2019 17:30:13 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VI1PR0801CA0084.outlook.office365.com
 (2603:10a6:800:7d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 17:30:13 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 17:30:12 +0000
Received: ("Tessian outbound 5574dd7ffaa4:v37"); Wed, 11 Dec 2019 17:30:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 789f128aa5f3e7d5
X-CR-MTA-TID: 64aa7808
Received: from 0c035635b898.6
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C4B34377-D237-493F-A40E-A505506A9E6E.1;
        Wed, 11 Dec 2019 17:30:07 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0c035635b898.6
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 11 Dec 2019 17:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0ckJwhUhP7DfShkKQCD5oeA5SSvOUpxu9zTyFaT+BZMrcaztbEh5vzs2ntkhHHH23YSf673K0loGYoCR4hD70xlATUERgtYTIPxFuDyBm+RLC/NU/FaV/ExL4Xrh+uS/LPnAlB5Cn32XAy4SgHMTQp6ESORWNNekyatpvGeFmPyFNDWhkV1UZ5dsNq4vnqyAaIuwmbf5NqTV47dE5BoAzXP5xyyiYqrlNsT18f1nSmq88iUH+N7veW4LqaKFfls69Or3Toc0QtaQxhre8S3TumzbCn+ocaUJyhWaA/sUbY4OnH2M7s1ZFuDJGuG4oQmGuI8CrL9ZCwWv3SstQO62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u06jmu2D/8YUMymSB5K7vVkoOJMOJErSBpiGDn56oxM=;
 b=lKDoal9PPOLKXOKMHjIQFE63VvQ+viIlSLt6ohOJGByGZhvSR/Z9DWum6mREJ2L1fL8BB1vg/nvbm4BDONniBYD33XkpVk/vWDA9l2GOqbNaWYgGCIn6dFi2gXbKq1oHvqsBM7s3rl+uBnFV55foKAFIUqgqVasjk0Ohw82xAUIIeO9uWCWvkiT+mElEd/rO5ofpoupNet+6wvqehuiUGYvQ7P7LP5E2AJBaw2TNQWQ1y0JzppGmvCANJbvRWqhgZDlVhnz7eJN3KstPURQuKn977G2+GZDsJv9iYDcaTdHF5gCm5WktZuc3K9COVjE1NQsUXhHj47drztOcAfuWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u06jmu2D/8YUMymSB5K7vVkoOJMOJErSBpiGDn56oxM=;
 b=w2A9WgAUpN+ROmgBi1zDDIBWwMwaaHmmbcGGgSYeWgWQpkrqmoRZpuvdZH+82LOIdNfok1sTuOJIsibld9HGUAA8mYgkqzwW75s3wghxac06HLogTvq157sGNLyhW4BwWixLJWhG8VIlB1tjTLAFbNKW2Dpu7weZsbrCiXTWKeQ=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3151.eurprd08.prod.outlook.com (52.133.15.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 11 Dec 2019 17:30:03 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::3d0a:7cde:7f1f:fe7c%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 17:30:02 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v3 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH v3 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVrzaqVXP2GgFQ50yR2yvi7QM25Ke1G/iA
Date:   Wed, 11 Dec 2019 17:30:02 +0000
Message-ID: <1885100.onhcTcTa0I@e123338-lin>
References: <20191210084828.19664-1-james.qian.wang@arm.com>
 <20191210084828.19664-3-james.qian.wang@arm.com>
In-Reply-To: <20191210084828.19664-3-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::22) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d99211b3-5610-4dfe-c4b1-08d77e5fc75e
X-MS-TrafficTypeDiagnostic: VI1PR08MB3151:|VI1PR08MB3151:|AM5PR0801MB1777:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB17778AB260859D9994F218628F5A0@AM5PR0801MB1777.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 024847EE92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(8936002)(5660300002)(86362001)(478600001)(6636002)(2906002)(54906003)(71200400001)(8676002)(81156014)(81166006)(66446008)(52116002)(186003)(4326008)(6512007)(26005)(64756008)(316002)(33716001)(9686003)(6862004)(6486002)(6506007)(66476007)(66556008)(66946007)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3151;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: D7ckdVs9JX8ipyN6F3LUMkyhocP1HfH6eqoZwI4dAxOWsC5BWmGlrb3FfBNaQzLpv5yDFZlcAEbDiFXMOCrW7JKKByyXDBVtfmWvQmBQukv3Rq6CI1iIejvOVqaC90K4bFtT01yFs/K2IuxU9IGWMFyDwqg6xSs9n2r+Y9ht+ELHqPquRFriiy3aOnRFU/PYM4fzBhR7oX5wf0a4mS6HmDQEmDSmbVmqaOUsKyTmugxpjq23EfQRVk5F6HnJFq2ppT+OtsqGzzjKGD8L4yFpNYtYKaf9DA9O2lutXnI8NmTy0hmyLVhjq1JCdx0LB2H7CqJdKCIlJ8K3EZeBqkZKtjJcKM9XVE0h3yQSvCy7FvWZDB0ovSt21wRfwQFb5Tpujlk02rn7S3x+EQqm/PVpEw32whJsjegSXPCkNTE1aK4ONhDmxeHbbHIw+45wycLaE+7bpnJnhsA24G07p+fEkEf26HhuDuo9rj3ulrAdngdxw5E2+C7EutJz7vRoaM0E
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20B3528BBC97F947823614B53546D8A1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3151
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(26826003)(316002)(9686003)(86362001)(5660300002)(478600001)(36906005)(76130400001)(6486002)(33716001)(6636002)(54906003)(6512007)(6506007)(186003)(26005)(336012)(81166006)(8936002)(81156014)(70586007)(4326008)(70206006)(2906002)(6862004)(8676002)(356004)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1777;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3239391d-82a8-428b-230c-08d77e5fc106
NoDisclaimer: True
X-Forefront-PRVS: 024847EE92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTKNIlno/wE4pciNksco2hRTnmILwttmbAObhKfVRg76sytuy4Yk3swstGtwSWVYP3CrlC/ajyh+tw1gd5YlsFTNjDqau3z+S3AM9lLC3jFyzy/4rA3BLe3M1eMp1r80Y9s2S3QavQX6aEllsxMm+tZLSfHPdTw85l2wH/lGEqYEOgbE/LYo4JDujHHPj61C9hylNN+faYxOjmOURKdE02/9hJ7CPe9kFvoDHFh0Sh5fVaUzKlcPK/nM69tz1r7fqi+QRmn3trVqwHQeK6qYjbFoTaZeczVhOi2yVHNb+49LeHc+pXxYZWEg+MDE0YLI9URo58z7MzG71ZIYEv3Kzg8fJTCI9c0qUZ9Y4NNEJUG415Ma5Q4gGocWgZR2ftqKHXDJ0RO5etYrXHmy+zjebevqX18dkv3qTXTqT7g9QDf2mXLuckmlTtgaOifeY3fPGzyHLOe8wGL45oWP4Zz4KIniDIlOZSWBabFpjVdFavWt5EfdG7LUJPzD6mdzAnod
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 17:30:12.7283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99211b3-5610-4dfe-c4b1-08d77e5fc75e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1777
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 10 December 2019 08:48:51 GMT james qian wang (Arm Technology C=
hina) wrote:
> D32 is simple version of D71, the difference is:
> - Only has one pipeline
> - Drop the periph block and merge it to GCU
>=20
> v2: Rebase.
> v3: Isolate the block counting fix to a new patch

I would've expected the fix to be a part of this series as 2/3 and this
patch as 3/3.

Otherwise, this patch is
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

>=20
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../drm/arm/display/include/malidp_product.h  |  3 +-
>  .../arm/display/komeda/d71/d71_component.c    |  2 +-
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 39 ++++++++++++-------
>  .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 +++++++
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
>  5 files changed, 42 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drive=
rs/gpu/drm/arm/display/include/malidp_product.h
> index 1053b11352eb..16a8a2c22c42 100644
> --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> @@ -18,7 +18,8 @@
>  #define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id)) & 0xF=
F)
> =20
>  /* Mali-display product IDs */
> -#define MALIDP_D71_PRODUCT_ID   0x0071
> +#define MALIDP_D71_PRODUCT_ID	0x0071
> +#define MALIDP_D32_PRODUCT_ID	0x0032
> =20
>  union komeda_config_id {
>  	struct {
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index b6517c46e670..8a02ade369db 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -1270,7 +1270,7 @@ static int d71_timing_ctrlr_init(struct d71_dev *d7=
1,
> =20
>  	ctrlr =3D to_ctrlr(c);
> =20
> -	ctrlr->supports_dual_link =3D true;
> +	ctrlr->supports_dual_link =3D d71->supports_dual_link;
> =20
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index 7e79c2e88421..dd1ecf4276d3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -371,23 +371,33 @@ static int d71_enum_resources(struct komeda_dev *md=
ev)
>  		goto err_cleanup;
>  	}
> =20
> -	/* probe PERIPH */
> +	/* Only the legacy HW has the periph block, the newer merges the periph
> +	 * into GCU
> +	 */
>  	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
> -	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
> -		DRM_ERROR("access blk periph but got blk: %d.\n",
> -			  BLOCK_INFO_BLK_TYPE(value));
> -		err =3D -EINVAL;
> -		goto err_cleanup;
> +	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH)
> +		d71->periph_addr =3D NULL;
> +
> +	if (d71->periph_addr) {
> +		/* probe PERIPHERAL in legacy HW */
> +		value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
> +
> +		d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
> +		d71->max_vsize		=3D 4096;
> +		d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> +		d71->supports_dual_link	=3D !!(value & PERIPH_SPLIT_EN);
> +		d71->integrates_tbu	=3D !!(value & PERIPH_TBU_EN);
> +	} else {
> +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID0);
> +		d71->max_line_size	=3D GCU_MAX_LINE_SIZE(value);
> +		d71->max_vsize		=3D GCU_MAX_NUM_LINES(value);
> +
> +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID1);
> +		d71->num_rich_layers	=3D GCU_NUM_RICH_LAYERS(value);
> +		d71->supports_dual_link	=3D GCU_DISPLAY_SPLIT_EN(value);
> +		d71->integrates_tbu	=3D GCU_DISPLAY_TBU_EN(value);
>  	}
> =20
> -	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
> -
> -	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
> -	d71->max_vsize		=3D 4096;
> -	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> -	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : false;
> -	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
> -
>  	for (i =3D 0; i < d71->num_pipelines; i++) {
>  		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline),
>  					   &d71_pipeline_funcs);
> @@ -606,6 +616,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_chi=
p_info *chip)
> =20
>  	switch (product_id) {
>  	case MALIDP_D71_PRODUCT_ID:
> +	case MALIDP_D32_PRODUCT_ID:
>  		funcs =3D &d71_chip_funcs;
>  		break;
>  	default:
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/drivers/=
gpu/drm/arm/display/komeda/d71/d71_regs.h
> index 1727dc993909..81de6a23e7f3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> @@ -72,6 +72,19 @@
>  #define GCU_CONTROL_MODE(x)	((x) & 0x7)
>  #define GCU_CONTROL_SRST	BIT(16)
> =20
> +/* GCU_CONFIGURATION registers */
> +#define GCU_CONFIGURATION_ID0	0x100
> +#define GCU_CONFIGURATION_ID1	0x104
> +
> +/* GCU configuration */
> +#define GCU_MAX_LINE_SIZE(x)	((x) & 0xFFFF)
> +#define GCU_MAX_NUM_LINES(x)	((x) >> 16)
> +#define GCU_NUM_RICH_LAYERS(x)	((x) & 0x7)
> +#define GCU_NUM_PIPELINES(x)	(((x) >> 3) & 0x7)
> +#define GCU_NUM_SCALERS(x)	(((x) >> 6) & 0x7)
> +#define GCU_DISPLAY_SPLIT_EN(x)	(((x) >> 16) & 0x1)
> +#define GCU_DISPLAY_TBU_EN(x)	(((x) >> 17) & 0x1)
> +
>  /* GCU opmode */
>  #define INACTIVE_MODE		0
>  #define TBU_CONNECT_MODE	1
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_drv.c
> index b7a1097c45c4..ad38bbc7431e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -125,6 +125,7 @@ static int komeda_platform_remove(struct platform_dev=
ice *pdev)
> =20
>  static const struct of_device_id komeda_of_match[] =3D {
>  	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
> +	{ .compatible =3D "arm,mali-d32", .data =3D d71_identify, },
>  	{},
>  };
> =20
>=20


--=20
Mihail



