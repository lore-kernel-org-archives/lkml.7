Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF38C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427902176D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cpdEphxn";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cpdEphxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLBLII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:08:08 -0500
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:21574
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfLBLIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZP+y+mLEBtGUUH7f/yCOcI3dXKnWIX3blNz+PP9TKc=;
 b=cpdEphxnIZHIigTjaxb5ZdW6H5GB361TBf8csoEsR43YQoYZTbSEMs2JWM9N0qFkOxamfvoWDUVt+1wBEKWjqGox4DSiyO+rvwcTLF/0qMVdiNQf1ONiOajiGgyTSdFfSwNzI7vYaXIInF3eOMmPJ1TFrnkSYpzNYPOLlKWvJxU=
Received: from VI1PR08CA0200.eurprd08.prod.outlook.com (2603:10a6:800:d2::30)
 by DB8PR08MB5034.eurprd08.prod.outlook.com (2603:10a6:10:e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Mon, 2 Dec
 2019 11:08:00 +0000
Received: from VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0200.outlook.office365.com
 (2603:10a6:800:d2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.21 via Frontend
 Transport; Mon, 2 Dec 2019 11:08:00 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT027.mail.protection.outlook.com (10.152.18.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Mon, 2 Dec 2019 11:08:00 +0000
Received: ("Tessian outbound d55de055a19b:v37"); Mon, 02 Dec 2019 11:07:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a6d8f8852ab7fa30
X-CR-MTA-TID: 64aa7808
Received: from b8fd53e17d71.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 37580B3D-7091-43F5-AAE4-4FB28579F711.1;
        Mon, 02 Dec 2019 11:07:54 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b8fd53e17d71.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 02 Dec 2019 11:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFG1nCdXONjYJBha3WejRIqVSNVgGScdigg4xwMvCwR92VykKb0fvRMOcSWDC/pj8DCLLJmtM6mCsYZ1/VeUPQPcoWLX/28fAV4xFM4Ghf+cwkVE/Lg+VF4Q2JB8+BJj44rn9jCZzJuS8EXw6Ux9yKTYixnCroQIZOP1vppPTZdwhBZG932W+dQb8wy1Ov5xzJelmYgzbRXF6vnE6Pw/uBtWd3Q61dQqmPSix3Gh6ZUAGca9rXF1fJpMl2tibnZTzxkjmCzGnhcEH92hlrIlM0p90k+DX76ymgfFjDiMXLjoTokZTm8/1+5XiSqeKHhxR5IjP8XHhJdjE0njZRMCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZP+y+mLEBtGUUH7f/yCOcI3dXKnWIX3blNz+PP9TKc=;
 b=cpk70qyXqhv06y+O1W3AsJCWzmn7OzZ5jh7ssLDcwZAEfxyPhTEBJRi7YK3zQJjTEDKdDoIyv7gMskn9W+XJHWq0rfJ6WaN39z7AoOEAatiiuYoc8zQW7PkzC9665+BOvT8shsaS8fwQR9ygC3VOJVrqnQRpd2R2mkNLDodUQCq85a+SvAYiZIjn8MeyG3ocoF8CRjO3vruZuIeHMUE1j0szxOGACSuvpdVFdEKZnoLncJkh191eSASCFskzWPJcN78cIhYBzJ4eC7j4ShCU7AfHpsRmINslfX/EuPcSDZ00++V0h4Ctofqz/V/e803Af8oG2nEanIbN0PzVPH/1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZP+y+mLEBtGUUH7f/yCOcI3dXKnWIX3blNz+PP9TKc=;
 b=cpdEphxnIZHIigTjaxb5ZdW6H5GB361TBf8csoEsR43YQoYZTbSEMs2JWM9N0qFkOxamfvoWDUVt+1wBEKWjqGox4DSiyO+rvwcTLF/0qMVdiNQf1ONiOajiGgyTSdFfSwNzI7vYaXIInF3eOMmPJ1TFrnkSYpzNYPOLlKWvJxU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3280.eurprd08.prod.outlook.com (52.134.30.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 11:07:52 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 11:07:52 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVoEQsEzx6hPV6tkqMxpVwDMM7k6emwEqA
Date:   Mon, 2 Dec 2019 11:07:52 +0000
Message-ID: <15788924.1fOzIsmBsr@e123338-lin>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
 <20191121081717.29518-3-james.qian.wang@arm.com>
In-Reply-To: <20191121081717.29518-3-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::18) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bd7fae3-3d51-4087-3a07-08d77717e51a
X-MS-TrafficTypeDiagnostic: VI1PR08MB3280:|VI1PR08MB3280:|DB8PR08MB5034:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5034BC681230E5FF78AEB23C8F430@DB8PR08MB5034.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 0239D46DB6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(6486002)(316002)(54906003)(2906002)(305945005)(8936002)(33716001)(7736002)(25786009)(81166006)(3846002)(26005)(99286004)(8676002)(6116002)(81156014)(66066001)(14444005)(256004)(11346002)(446003)(4326008)(6436002)(6246003)(71200400001)(71190400001)(6636002)(6862004)(186003)(478600001)(229853002)(86362001)(66446008)(66556008)(66476007)(66946007)(76176011)(52116002)(386003)(6506007)(64756008)(102836004)(5660300002)(6512007)(9686003)(14454004)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3280;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0dTHrLfnwn9HVDr2v9oNRP/+S2iCBtlHf1vf19nt8J9539EjPvz15GkoJ/sFci5kVDzmHK/a2/v+zxBTjOOfTLvRlEwC7p/cTE7ec4seyaaTM+oOACcByq25i3zUrQahqtTH/JvzDvK4yWqrBuXgpC+fUNTEa8wD78+NtnxvoJpzBU36wUfjjcgRmwDzlyLoi+X2Ax5omLl3OGNn7+8BxqnOTobTP/ooo429luQzVl8+nW4/j6ZS0u4cDqNHSnOz/8sPESf/DbcGwqSEuTWwzCl0TCCjLcnl0OTgUEwFDnohTxQ6ODNMx4iw0MPHSMftCZOnXat5O9Griemm1ZbMGzEGHTM2UdfvHFWGFQLGPpZ7dL7di2MOXo+ewKq3FcSySPY0RcOutjZL7jzjqpYNmqYwBMRECSeP4FEd58YCASTz5bQZ8WyhbREEAJ+0D0Kc
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85D38DF456872B48AD5F4C60CB24323E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3280
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(376002)(136003)(39860400002)(346002)(189003)(199004)(26005)(5660300002)(386003)(6636002)(23726003)(102836004)(6506007)(33716001)(47776003)(46406003)(316002)(22756006)(76130400001)(70586007)(106002)(26826003)(36906005)(6246003)(6862004)(66066001)(4326008)(478600001)(14454004)(14444005)(356004)(99286004)(8936002)(229853002)(186003)(6486002)(446003)(7736002)(305945005)(86362001)(97756001)(50466002)(70206006)(54906003)(8746002)(76176011)(336012)(11346002)(25786009)(6512007)(9686003)(6116002)(3846002)(2906002)(8676002)(81166006)(81156014)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5034;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 27fae5a3-311e-450a-ff20-08d77717e019
NoDisclaimer: True
X-Forefront-PRVS: 0239D46DB6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2wV95Q17YPwc50NoDi81QNfkGjw+LKKTeHOT8tnZk+mPvZ5FKttu8kPP3y5WnIs2dWA5e56E5bNEPLBasG+iN9whPCi43tZPRC7sslsinFeFTsAEoD7CIArAJLsyHl6lbOtyBodr8ilG0Xvu+tX/hrRL4pum+hV9pvoEOP6NtoNtp6E6U2sz5JJJ1Y+YaMhB60IoY4x8iIdRwKD94FuQYFLzjN8k7YefJmZk/h2tJKuVD+RyD4f/omp5Z1M67RQoDopE99xTqzIwVNkG33Mqmbymp+1GDdNcUgG+Jwom0EApKVytUsu85Z7cs6EQYOIru079I+V8FrfbgZVmjkgvk58zdais/Mo1VMuga/gi8GR5T/QwH622LFOyBzTx68cm3PPi9LQSFGLd0YAPMs6sxz7hukn2x+IlPSVXAUN7GIeofaVi869bbKTDQnl3ECI
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 11:08:00.6798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd7fae3-3d51-4087-3a07-08d77717e51a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 21 November 2019 08:17:45 GMT james qian wang (Arm Technology =
China) wrote:
> D32 is simple version of D71, the difference is:
> - Only has one pipeline
> - Drop the periph block and merge it to GCU
>=20
> v2: Rebase.
>=20
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../drm/arm/display/include/malidp_product.h  |  3 +-
>  .../arm/display/komeda/d71/d71_component.c    |  2 +-
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 43 ++++++++++++-------
>  .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++++
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
>  5 files changed, 44 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drive=
rs/gpu/drm/arm/display/include/malidp_product.h
> index 96e2e4016250..dbd3d4765065 100644
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
> index 6dadf4413ef3..c7f7e9c545c7 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -1274,7 +1274,7 @@ static int d71_timing_ctrlr_init(struct d71_dev *d7=
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
> index 9b3bf353b6cc..2d429e310e5b 100644
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
> @@ -415,7 +425,7 @@ static int d71_enum_resources(struct komeda_dev *mdev=
)
>  	}
> =20
>  	/* loop the register blks and probe */
> -	i =3D 2; /* exclude GCU and PERIPH */
> +	i =3D 1; /* exclude GCU */
>  	offset =3D D71_BLOCK_SIZE; /* skip GCU */
>  	while (i < d71->num_blocks) {
>  		blk_base =3D mdev->reg_base + (offset >> 2);
> @@ -425,9 +435,9 @@ static int d71_enum_resources(struct komeda_dev *mdev=
)
>  			err =3D d71_probe_block(d71, &blk, blk_base);
>  			if (err)
>  				goto err_cleanup;
> -			i++;
>  		}
> =20
> +		i++;

This change doesn't make much sense if you want to count how many
blocks are available, since you're now counting the reserved ones, too.

On the counting note, the prior code rides on the assumption the periph
block is last in the map, and I don't see how you still handle not
counting it in the D71 case.

>  		offset +=3D D71_BLOCK_SIZE;
>  	}
> =20
> @@ -603,6 +613,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_chi=
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



