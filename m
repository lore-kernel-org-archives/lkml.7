Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E577C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B0620679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BkTC3HDY";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BkTC3HDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfJKIbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:31:15 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:45050
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbfJKIbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc5EzkiT6pm5A7kfwvn7ljic7GPKetn1aiDrllkA8qA=;
 b=BkTC3HDYzI/BegczSywSYKJNP4wpz+04vj7acM9Zy2QMlH7wZuUTbnxNmpW4bxZr3axmB4XYPI/DNm1T4UvJCH6mme7XjuqkwAkLK2yOD9s8NCpHYbqfhYLzJ+MNSZytqGmfIeHpe1FXtMZcVKRld5GvaHeNUG6PzEf0r4Wwkvc=
Received: from DB7PR08CA0014.eurprd08.prod.outlook.com (2603:10a6:5:16::27) by
 VI1PR0801MB1661.eurprd08.prod.outlook.com (2603:10a6:800:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Fri, 11 Oct
 2019 08:31:07 +0000
Received: from AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by DB7PR08CA0014.outlook.office365.com
 (2603:10a6:5:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.25 via Frontend
 Transport; Fri, 11 Oct 2019 08:31:06 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT005.mail.protection.outlook.com (10.152.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 08:31:05 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 11 Oct 2019 08:30:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 68e6a326f6d64bf2
X-CR-MTA-TID: 64aa7808
Received: from b8ac5cc8525d.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D47967A5-922A-49B0-970D-B7D8BFE0AD2C.1;
        Fri, 11 Oct 2019 08:30:49 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b8ac5cc8525d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2019 08:30:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiCdfVf81Pu8oCFEA3uNK6zlRncaKdZPEO4XMTtUcw6AM2z4Zx/vbnDQ6rI8IOcApvvZ5um6iU6kltFey+KB4EvAkt1jhn+TJ8Zz2J4priaM/AZHv8tJJWpJ8imwsYQpJGYoBkXuIOGmckxCa28zdDcz0oVr4JpmCYKqgQ+sLOd05PEOML8G8s68xs1Sdkd5PSsuMHIJeZYIfTEgph2EV8Zd+slr6NxoZix16noqhFGtqSTKUfY7L2no997q+ChmZjhX2T/+oqLEnNQPgAxwH1AJfiqa805E1tVp/YSOM4oy1gKpm3B/YPk+kbSAcZKL8stf5LwO8hxYaxneW+elNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc5EzkiT6pm5A7kfwvn7ljic7GPKetn1aiDrllkA8qA=;
 b=kX/PZsTqQsejQdN5Onn7ElE5mcjDpgNaU8u2+jVRRdpjF1uQqKHkwUmgAmRId9SK6REdEFik48NRMG0Qvnp/Lx8oU4jYmi4c8663jrQiVAAXcPd88fHmLiiLtEMq4f9zWpc16a0MBjzJMHhsELumrDAhRyVbf+HceBK4d2V39VZb4nrMEvkZ66WW/aiNISAXyoMd3U1htvbJ5ez+iwFQVvM6/uEvZjoMOgb0HZhsoYUNV7SuxPHtcxK1FmpMnOn4DYAa/NDmu21Hw3CPjAyv0KHufP6miytL7S9H9YtV00funmlIkNb2XGCaRg3WTZKAe0TPjeeN1CMXIK8Gm74pTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc5EzkiT6pm5A7kfwvn7ljic7GPKetn1aiDrllkA8qA=;
 b=BkTC3HDYzI/BegczSywSYKJNP4wpz+04vj7acM9Zy2QMlH7wZuUTbnxNmpW4bxZr3axmB4XYPI/DNm1T4UvJCH6mme7XjuqkwAkLK2yOD9s8NCpHYbqfhYLzJ+MNSZytqGmfIeHpe1FXtMZcVKRld5GvaHeNUG6PzEf0r4Wwkvc=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2910.eurprd08.prod.outlook.com (10.175.245.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 11 Oct 2019 08:30:47 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 08:30:47 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>,
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
Subject: Re: [PATCH v2 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v2 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVf/cgyUi1BihLGUqjRrTFJfR086dVHGuA
Date:   Fri, 11 Oct 2019 08:30:47 +0000
Message-ID: <2583309.pvr1AVrQub@e123338-lin>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
 <20191011054459.17984-3-james.qian.wang@arm.com>
In-Reply-To: <20191011054459.17984-3-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: CWLP123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:56::28) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a67d1d86-eaaf-45b9-12af-08d74e255b98
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB2910:|VI1PR08MB2910:|VI1PR0801MB1661:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB166165C69814C9786C5715E78F970@VI1PR0801MB1661.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:5797;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(54906003)(6246003)(6506007)(76176011)(6486002)(6436002)(305945005)(476003)(7736002)(6116002)(386003)(186003)(102836004)(14454004)(52116002)(2906002)(9686003)(26005)(3846002)(25786009)(229853002)(256004)(14444005)(99286004)(486006)(316002)(33716001)(86362001)(6512007)(66066001)(5660300002)(66446008)(478600001)(71200400001)(71190400001)(4326008)(11346002)(6862004)(66476007)(66946007)(446003)(81156014)(81166006)(64756008)(6636002)(8936002)(8676002)(66556008)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2910;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: v3HSXOnWBvbx/rHxYcbssxlPTwtInk5jUjn6udN7OLHDWycfstavx0RIu5NDDM/W69P2MUreQxq7Yjb1sSX7BoRnNcgjnq49+U2wTpY50bEl0Q385kpHQuUhjqwCC9dx+mg1mJoaJ8XOLU/rAD622C+0TJqAA7kXS75jLayVY3J781L0vJwCMYqjc1lEZjWPE4QoKhDWPJfL0iYeV49iE5fIIMHIjnYePhsUfKJmrKGtybtn0eizdI+aN9E5X5VfKZQd6s+ePwXWjCqY8oBb1dv13D56pjftfFDl+JMR35W4E2Flf5tVozMr9gF1lzdTHlP7F9tyakrSplFCZVJzjw1P2HZAH6J4BLcg508P43E4bO4+pVA9o/m4RByBUOeIpZ+waPJHqc1NYM3J+UjJz5lqtpTCZ+DCTkupmI57Zds=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAD8E2F806A05C4497900F5001DA7AA2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2910
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(39860400002)(396003)(376002)(346002)(189003)(199004)(6486002)(26005)(476003)(5660300002)(305945005)(76176011)(6246003)(186003)(126002)(8936002)(6506007)(97756001)(8746002)(50466002)(14444005)(486006)(336012)(102836004)(63350400001)(478600001)(26826003)(7736002)(46406003)(9686003)(6512007)(47776003)(386003)(14454004)(22756006)(316002)(229853002)(36906005)(54906003)(70206006)(11346002)(4326008)(6636002)(33716001)(446003)(99286004)(76130400001)(25786009)(3846002)(23726003)(6116002)(6862004)(81166006)(81156014)(70586007)(356004)(2906002)(86362001)(66066001)(8676002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1661;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d53e749e-0c48-4ba4-f78d-08d74e255094
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cENdKHJj5mp9zc03b99qtXf3DGW8MMxEXmNWBG2Hj9R9lcQpTI6NfnmsLjWSbxSR5vKOPxMcu0eWqk3VDeddEQMAbHafFOw70AgOADkC38kq92w8kdfK6HAJw8gGRPcTnocKCJRJlCln823jSxcMm6VdegMCItiRjn9pIVs4NLgtciypNtbOcJZELOTlISLTan5QU48CrSZ5byR4CM1RPxdDSjJUmuZulei+55dX2RLyVdSmTWlQtGt+5Opro7IwlYJP0YsDtUNRYrFQf7SpFqdLt5qo8bxJ8fpZt8T6ZJCEKe3YcmENP5yobSyXpJDO4JFV4jwqkbqtQ5nx4Pski9KoBdN0WL2ye7OQzkpwsf0N+fIZhKYThnV62adnzV3xHVdQOffaOALmQU+Juv3tMdmuVZLmjMXeGK+c9qacjQY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 08:31:05.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67d1d86-eaaf-45b9-12af-08d74e255b98
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 11 October 2019 06:45:35 BST james qian wang (Arm Technology Chi=
na) wrote:
> This function is used to convert drm 3dlut to komeda HW required 1d curve
> coeffs values.
>=20
> Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../arm/display/komeda/komeda_color_mgmt.c    | 52 +++++++++++++++++++
>  .../arm/display/komeda/komeda_color_mgmt.h    |  9 +++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> index 9d14a92dbb17..c180ce70c26c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> @@ -65,3 +65,55 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color_enco=
ding, u32 color_range)
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
[bikeshed] I'd name this fgamma_sector_tbl (didn't the previous version
of this patch stack have an gamma_curve_sector for igamma?).
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
> +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs)
> +{
> +	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl))=
;
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> index a2df218f58e7..08ab69281648 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> @@ -11,7 +11,14 @@
>  #include <drm/drm_color_mgmt.h>
> =20
>  #define KOMEDA_N_YUV2RGB_COEFFS		12
> +#define KOMEDA_N_RGB2YUV_COEFFS		12
> +#define KOMEDA_COLOR_PRECISION		12
> +#define KOMEDA_N_GAMMA_COEFFS		65
> +#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)
> +#define KOMEDA_N_CTM_COEFFS		9
[nit] The alignment with the group above seems a bit off.
> +
> +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 *c=
oeffs);
> =20
>  const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_ra=
nge);
> =20
> -#endif
> +#endif /*_KOMEDA_COLOR_MGMT_H_*/
>=20
Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

--=20
Mihail



