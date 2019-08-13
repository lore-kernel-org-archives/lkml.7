Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EA1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E523620665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="V4ZVhF+Y";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="V4ZVhF+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfHMJvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:51:39 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:33226
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbfHMJvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fwe4U2U0qDuCKnneCwAVGrcoj98mD6qvg73JjQHMHU=;
 b=V4ZVhF+YMiObYpyjMMMbjACJbBvJ9b0eZlAaklrIvg/k9NluWWTt3hMW+AGPe1zMBHhFgQo+AAsPo+FjbXMGIBPnfIIdO/j5qBHpWPdY56XGz1dYP8adxwdhuIkyasjlm2ioj3Me5Yxv8QYL/U412HNjsdWathxoMt9jhzbF0pc=
Received: from DB6PR0801CA0062.eurprd08.prod.outlook.com (2603:10a6:4:2b::30)
 by HE1PR0801MB1851.eurprd08.prod.outlook.com (2603:10a6:3:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Tue, 13 Aug
 2019 09:51:27 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by DB6PR0801CA0062.outlook.office365.com
 (2603:10a6:4:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Tue, 13 Aug 2019 09:51:26 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 09:51:25 +0000
Received: ("Tessian outbound a1fd2c3cfdb0:v26"); Tue, 13 Aug 2019 09:51:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 43255d24ed839f31
X-CR-MTA-TID: 64aa7808
Received: from 214acc971bca.2 (cr-mta-lb-1.cr-mta-net [104.47.10.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D150B111-69E6-45A2-8589-883976518BC8.1;
        Tue, 13 Aug 2019 09:51:12 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2053.outbound.protection.outlook.com [104.47.10.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 214acc971bca.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 13 Aug 2019 09:51:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr4xhA3UXAYn18LzADjt7J2YIGnl4VCIIY0Ha/fr0+O67LBL4c6VUGmGjeMmwZURyMkQlm7SOcUgC/wEHpzRxufEYTWxFO/lFnvUxiMZSQknukTGo/wRFgNLk8Rvdo++F8KZYvxHdE09V9+A1DmvUX1dEUlnBK3GlDyVKOhPJ3xE26paLdCAlSAW/Mquk/dg8nUBzhDBsyyzfyL3dqKOhk77vQ0grrLXLg13igLoQJjPIUv/s5wNP8IJmZPoY5mEzfPs7YFMZHEi7AnayX01jER5TcEUFKdgbFgrwkU/RfbPmxeMB6YLvXFtFCctw+683D6WjHAt/YJZpQ6NUYPERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fwe4U2U0qDuCKnneCwAVGrcoj98mD6qvg73JjQHMHU=;
 b=E/v39t4o6BTC3JDvVEkn+E3z3TQHVOE4wauYV5GW9CMgINA2FvtuF0fnB2kv9Oml0QYHMeRRDrLVq06yQTUeE/0+Utvfd+tjdXUEWq+5K4EPkxpKgGh57Wox4TcNxq+u/U1WAfEUTEz4dGgswCQfSrYOZF6KjwQoJWaM14pSsQhf66AxLfFwE7UjLNiDxXhPAQV0081Ju43LaGbi5bq5MxoCCmwdVQgKjM7+87NYKkcZKy71jvVa5eqS5d1qYBOLN43CZAMir+gZ/hRqB43AHg03K5vPM+1pJ3Gc2D9W5ErTfP8uucO1kWqaqmLbmYd+NJ0On1UVwB6JySENsdgUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fwe4U2U0qDuCKnneCwAVGrcoj98mD6qvg73JjQHMHU=;
 b=V4ZVhF+YMiObYpyjMMMbjACJbBvJ9b0eZlAaklrIvg/k9NluWWTt3hMW+AGPe1zMBHhFgQo+AAsPo+FjbXMGIBPnfIIdO/j5qBHpWPdY56XGz1dYP8adxwdhuIkyasjlm2ioj3Me5Yxv8QYL/U412HNjsdWathxoMt9jhzbF0pc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3615.eurprd08.prod.outlook.com (20.177.61.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 09:51:09 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::2001:a268:ba50:fa51%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 09:51:09 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 2/4] drm/komeda: Introduce komeda_color_manager/state
Thread-Topic: [PATCH v2 2/4] drm/komeda: Introduce komeda_color_manager/state
Thread-Index: AQHVUZN2ECag5jvL6k2i3zNMwO/wrKb41hqA
Date:   Tue, 13 Aug 2019 09:51:08 +0000
Message-ID: <3902025.BCtzpz6JhW@e123338-lin>
References: <20190813045536.28239-1-james.qian.wang@arm.com>
 <20190813045536.28239-3-james.qian.wang@arm.com>
In-Reply-To: <20190813045536.28239-3-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::23) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f90b11a4-d884-49bd-fcf8-08d71fd3ce2d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3615;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3615:|HE1PR0801MB1851:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB18516DD970AD9BD17E0432B28FD20@HE1PR0801MB1851.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(81156014)(66476007)(86362001)(66556008)(478600001)(7736002)(64756008)(66946007)(305945005)(81166006)(6246003)(66446008)(8676002)(14454004)(33716001)(14444005)(2906002)(3846002)(256004)(71190400001)(71200400001)(6116002)(4326008)(66066001)(6636002)(476003)(76176011)(53936002)(6862004)(9686003)(316002)(229853002)(486006)(6486002)(26005)(11346002)(5660300002)(6436002)(446003)(6506007)(386003)(186003)(102836004)(8936002)(25786009)(54906003)(52116002)(99286004)(6512007)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3615;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: U0q++ctwd1l+zyjKJjrODlEBFGFEpz7cLmMxuC8USjrRjoCWCe9m1+G3X+cDp5/UqxllKf8JjJ8IEQJkQicPFkawV5XfTKzcX64Z0/P7dvNFiTppILKrx1hsLFm7yVwVAgNRwhcU3uFM2vfo/GG9TY/453mdjh4vE+OBhcKcSwFIx/oUDBsDDHOtJ3FylFhr/f1+ICV1rIkJ134up8CkqMX53kUV9qQTtlsZR46HTLQipjipJybTgJ47xE0UsuRk2PQKs4q7m1k2I88bhNWlcJ9reR2G0lgpZ3nv78b64s8ldJ0fiSrfRiKZVzshShjCspVwnrbL9nkgajWlM621FMbjS3HXU7Qr+iyuSbIYFHuNJ86ur6EzuE24sm/Rd30BQs7/Fkze2p0dm8ioeF6i7/cizRvTb03TgyTJTMSuwFE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B23C4D5CD665642A771986D6D1C4BFA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3615
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(199004)(189003)(6486002)(81166006)(6862004)(5660300002)(8746002)(8676002)(81156014)(14444005)(8936002)(4326008)(70206006)(3846002)(23726003)(356004)(6116002)(86362001)(25786009)(2906002)(6246003)(54906003)(70586007)(9686003)(6512007)(76130400001)(76176011)(63370400001)(386003)(14454004)(22756006)(46406003)(97756001)(186003)(26005)(229853002)(36906005)(305945005)(126002)(486006)(316002)(47776003)(7736002)(50466002)(66066001)(6506007)(102836004)(99286004)(33716001)(6636002)(336012)(478600001)(63350400001)(26826003)(476003)(446003)(11346002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1851;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fc90dce7-0f22-4808-fba7-08d71fd3c43a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR0801MB1851;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: 1jON0EdXQJEmJZxcCCLkANoT2S7aWlM/raOt9y8y+H44HloOemoqd7Dd6tFpvBaVPHk0BKigzjfxpXnI5yp1xLTWMC8o7QCN08UbCmUshAMxbb3Fbk3r1un6ZVZqPK3whStYHMa7FrkUhcHkf63geNVCQDsBL7KwuDdsaV2syJyVCunMwx5lZmJlL2OiD4T4P2ktUFo52+hqGEeumHyPRZ2WcT0TLBGEzrgw0UbQYBFQGG8Y3v2hnrnndwi+opbLqBdi9p0eU2BXnM5UQWwrYhQV1L/4dTVLWHmeyY5v8JJvbgw6VcoVx2dveLQk+bEmSrFpQqZHPc47T3ZNk530fcoWGk7rCi4+t/oyhGvxhnSHd6+XavJjNmFH90HrlRZiFpQ5PQBel9ToWabetHXdmKtZzqXIWMCCgN2x+VaSmy8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 09:51:25.2584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90b11a4-d884-49bd-fcf8-08d71fd3ce2d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tuesday, 13 August 2019 05:56:07 BST james qian wang (Arm Technology Chi=
na) wrote:
> Many komeda component support color management like layer and IPS, so
> komeda_color_manager/state are introduced to manager gamma, csc and degam=
ma
> together for easily share it to multiple componpent.
>=20
> And for komeda_color_manager which:
> - convert drm 3d gamma lut to komeda specific gamma coeffs
> - gamma table management and hide the HW difference for komeda-CORE
>=20
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../arm/display/komeda/komeda_color_mgmt.c    | 126 ++++++++++++++++++
>  .../arm/display/komeda/komeda_color_mgmt.h    |  32 ++++-
>  2 files changed, 156 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> index 9d14a92dbb17..bf2388d641b9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> @@ -4,7 +4,9 @@
>   * Author: James.Qian.Wang <james.qian.wang@arm.com>
>   *
>   */
> +#include <drm/drm_print.h>
> =20
> +#include "malidp_utils.h"
>  #include "komeda_color_mgmt.h"
> =20
>  /* 10bit precision YUV2RGB matrix */
> @@ -65,3 +67,127 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color_enc=
oding, u32 color_range)
> =20
>  	return coeffs;
>  }
> +
> +struct gamma_curve_sector {
> +	u32 boundary_start;
> +	u32 num_of_segments;
> +	u32 segment_width;
> +};
> +
> +struct gamma_curve_segment {
> +	u32 start;
> +	u32 end;
> +};
> +
> +static struct gamma_curve_sector sector_tbl[] =3D {
> +	{ 0,    4,  4   },
> +	{ 16,   4,  4   },
> +	{ 32,   4,  8   },
> +	{ 64,   4,  16  },
> +	{ 128,  4,  32  },
> +	{ 256,  4,  64  },
> +	{ 512,  16, 32  },
> +	{ 1024, 24, 128 },
> +};
> +
> +static struct gamma_curve_sector igamma_sector_tbl[] =3D {
> +	{0, 64, 64},
> +};
> +
> +static void
> +drm_lut_to_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs,
> +		  struct gamma_curve_sector *sector_tbl, u32 num_sectors)
> +{
> +	struct drm_color_lut *lut;
> +	u32 i, j, in, num =3D 0;
> +
> +	if (!lut_blob)
> +		return;
> +
> +	lut =3D lut_blob->data;
> +
> +	for (i =3D 0; i < num_sectors; i++) {
> +		for (j =3D 0; j < sector_tbl[i].num_of_segments; j++) {
> +			in =3D sector_tbl[i].boundary_start +
> +			     j * sector_tbl[i].segment_width;
> +
> +			coeffs[num++] =3D drm_color_lut_extract(lut[in].red,
> +						KOMEDA_COLOR_PRECISION);
> +		}
> +	}
> +
> +	coeffs[num] =3D BIT(KOMEDA_COLOR_PRECISION);
> +}
> +
> +void drm_lut_to_igamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs)
> +{
> +	drm_lut_to_coeffs(lut_blob, coeffs,
> +			  igamma_sector_tbl, ARRAY_SIZE(igamma_sector_tbl));
> +}
> +
> +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs)
> +{
> +	drm_lut_to_coeffs(lut_blob, coeffs,
> +			  sector_tbl, ARRAY_SIZE(sector_tbl));
> +}
> +
> +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs)
> +{
> +	struct drm_color_ctm *ctm;
> +	u32 i;
> +
> +	if (!ctm_blob)
> +		return;
> +
> +	ctm =3D ctm_blob->data;
> +
> +	for (i =3D 0; i < KOMEDA_N_CTM_COEFFS; ++i) {
> +		/* Convert from S31.32 to Q3.12. */
> +		s64 v =3D ctm->matrix[i];
> +
> +		coeffs[i] =3D clamp_val(v, 1 - (1LL << 34), (1LL << 34) - 1) >> 20;
CTM matrix values are S31.32, i.e. sign-magnitude, so clamp_val won't
give you the right result for negative coeffs. See
malidp_crtc_atomic_check_ctm for the sign-mag -> 2's complement
conversion.
> +	}
> +}
> +
> +void komeda_color_duplicate_state(struct komeda_color_state *new,
> +				  struct komeda_color_state *old)
[bikeshed] not really a _duplicate_state if all it does is refcounts.
kmemdup here and return a pointer (with ERR_PTR on fail), or memcpy if
you want to keep the signature?
> +{
> +	new->igamma =3D komeda_coeffs_get(old->igamma);
> +	new->fgamma =3D komeda_coeffs_get(old->fgamma);
> +}
> +
> +void komeda_color_cleanup_state(struct komeda_color_state *color_st)
> +{
> +	komeda_coeffs_put(color_st->igamma);
> +	komeda_coeffs_put(color_st->fgamma);
> +}
> +
> +int komeda_color_validate(struct komeda_color_manager *mgr,
> +			  struct komeda_color_state *st,
> +			  struct drm_property_blob *igamma_blob,
> +			  struct drm_property_blob *fgamma_blob)
> +{
> +	u32 coeffs[KOMEDA_N_GAMMA_COEFFS];
> +
> +	komeda_color_cleanup_state(st);
> +
> +	if (igamma_blob) {
> +		drm_lut_to_igamma_coeffs(igamma_blob, coeffs);
> +		st->igamma =3D komeda_coeffs_request(mgr->igamma_mgr, coeffs);
> +		if (!st->igamma) {
> +			DRM_DEBUG_ATOMIC("request igamma table failed.\n");
> +			return -EBUSY;
> +		}
> +	}
> +
> +	if (fgamma_blob) {
> +		drm_lut_to_fgamma_coeffs(fgamma_blob, coeffs);
> +		st->fgamma =3D komeda_coeffs_request(mgr->fgamma_mgr, coeffs);
> +		if (!st->fgamma) {
> +			DRM_DEBUG_ATOMIC("request fgamma table failed.\n");
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> index a2df218f58e7..41a96b3b540f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> @@ -4,14 +4,42 @@
>   * Author: James.Qian.Wang <james.qian.wang@arm.com>
>   *
>   */
> -
>  #ifndef _KOMEDA_COLOR_MGMT_H_
>  #define _KOMEDA_COLOR_MGMT_H_
> =20
>  #include <drm/drm_color_mgmt.h>
> +#include "komeda_coeffs.h"
> =20
>  #define KOMEDA_N_YUV2RGB_COEFFS		12
> +#define KOMEDA_N_RGB2YUV_COEFFS		12
> +#define KOMEDA_COLOR_PRECISION		12
> +#define KOMEDA_N_GAMMA_COEFFS		65
> +#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)
I don't see how the number of LUT entries has anything to do with the
bit-precision of each entry.
> +#define KOMEDA_N_CTM_COEFFS		9
> +
> +struct komeda_color_manager {
> +	struct komeda_coeffs_manager *igamma_mgr;
> +	struct komeda_coeffs_manager *fgamma_mgr;
> +	bool has_ctm;
> +};
> +
> +struct komeda_color_state {
> +	struct komeda_coeffs_table *igamma;
> +	struct komeda_coeffs_table *fgamma;
> +};
> +
> +void komeda_color_duplicate_state(struct komeda_color_state *new,
> +				  struct komeda_color_state *old);
> +void komeda_color_cleanup_state(struct komeda_color_state *color_st);
> +int komeda_color_validate(struct komeda_color_manager *mgr,
> +			  struct komeda_color_state *st,
> +			  struct drm_property_blob *igamma_blob,
> +			  struct drm_property_blob *fgamma_blob);
> +
> +void drm_lut_to_igamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs);
> +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs);
> +void drm_ctm_to_coeffs(struct drm_property_blob *ctm_blob, u32 *coeffs);
> =20
>  const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_ra=
nge);
> =20
> -#endif
> +#endif /*_KOMEDA_COLOR_MGMT_H_*/
>=20

BR,
Mihail



