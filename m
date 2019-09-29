Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E4EC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 03:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112DB214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 03:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pLsHE+lG";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pLsHE+lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfI2D06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 23:26:58 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:7794
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbfI2D05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 23:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQUMJ/KHvy6Fw3Jt0ojdvB/x+XAr3Kg1GqxM7j5PdmI=;
 b=pLsHE+lGMMdgPniIRPV5erkqg8DLKmSuREFAAYS5WpLpwIWG1C5eMpG0uNVcNJxi3yx1j5RnNPLHWlgM1ZDo0aAzYyLhSaHVzMtQAJlBT86uPmflC/uuAJtzeL+sZK2SLeyfhZUKk8pI7HqkXKA8hs0Y2LFzVznKwwSI4Kczp4Y=
Received: from DB6PR0802CA0047.eurprd08.prod.outlook.com (2603:10a6:4:a3::33)
 by DBBPR08MB4678.eurprd08.prod.outlook.com (2603:10a6:10:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Sun, 29 Sep
 2019 03:26:49 +0000
Received: from DB5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by DB6PR0802CA0047.outlook.office365.com
 (2603:10a6:4:a3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Sun, 29 Sep 2019 03:26:49 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT016.mail.protection.outlook.com (10.152.20.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sun, 29 Sep 2019 03:26:47 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Sun, 29 Sep 2019 03:26:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d019f9c4b4c08c50
X-CR-MTA-TID: 64aa7808
Received: from d51c355ab390.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F670F9C4-1214-4A51-928F-E4E45F68C521.1;
        Sun, 29 Sep 2019 03:26:40 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d51c355ab390.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Sun, 29 Sep 2019 03:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkufrvGUe2u0q84huNwDWv9zJ9J0lFG2r3vCfaKKJ+6cPs7wu4zhPXM4iULnJQGCXHrvGWbmv+hrsdeGodkPIbcxcIgZA1OuMgdBKmOxz6drBXyLfgs5Mz82rXCqrYsdf7J5RVtg52zKyYYphsRt1JrfDM8khkQrO2vPqAXk12hc4TO/dPsob2+18TqmcSnHmJhRsYf9iqXxFVDItj0dU/zOiaUUg9PObeBg8j/cGdfd7bU8OYUAhP0N2pPBVQbAIKbC8gGTDDrHWq1p9pSmWZqMsYmG5JRGyg6DyfsCN3YVK/1GNoszaDRY+8KpFGO5y1FeoII5W/0noXxWoFwB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQUMJ/KHvy6Fw3Jt0ojdvB/x+XAr3Kg1GqxM7j5PdmI=;
 b=dUg1akc5N0r1T+CBecLbwKDiohsLrJxE/O16O9Q5wCaWDSmnPr6Xtop3KxjZc6A8kgFewmj3SRDUW2hYp09ps5YkZlKWBkzhW5ZMyLMjo8Kp65xXOojOCy0nm7No1on5KjVjudNQ56nH+Lpu6A5wZ4JJMdavPJC36V9RtY/jFsBZF61y3kEAC9/R/yIj4L0jPfi70lLv0wGmEu9inEbKjiob4sbIPaqGsb4n5nEDZv2LGtce7+9kRliKX4HPri4TneXP3wu+ZwF4ts0hNuHjpAXkIwCcZ+oW8ElxV51tcM++cQG7HtvaHVL3yH/ZohyoNDpZSakLQ5W3Ux/3rIkK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQUMJ/KHvy6Fw3Jt0ojdvB/x+XAr3Kg1GqxM7j5PdmI=;
 b=pLsHE+lGMMdgPniIRPV5erkqg8DLKmSuREFAAYS5WpLpwIWG1C5eMpG0uNVcNJxi3yx1j5RnNPLHWlgM1ZDo0aAzYyLhSaHVzMtQAJlBT86uPmflC/uuAJtzeL+sZK2SLeyfhZUKk8pI7HqkXKA8hs0Y2LFzVznKwwSI4Kczp4Y=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4781.eurprd08.prod.outlook.com (10.255.114.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Sun, 29 Sep 2019 03:26:39 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a0a6:ad4c:b7a7:f879%5]) with mapi id 15.20.2284.028; Sun, 29 Sep 2019
 03:26:38 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Sandy Huang <hjc@rock-chips.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [v2,1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Thread-Topic: [v2,1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Thread-Index: AQHVdnWzqsA4YhPoH0G4L3W1+ovDcg==
Date:   Sun, 29 Sep 2019 03:26:38 +0000
Message-ID: <20190929032630.GA26869@jamwan02-TSP300>
References: <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
In-Reply-To: <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fc2abbb1-47d0-4d2a-ed70-08d7448cdc4b
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4781:|DBBPR08MB4678:
X-Microsoft-Antispam-PRVS: <DBBPR08MB46786D492FBF09260248C25EB3830@DBBPR08MB4678.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3631;OLM:3631;
x-forefront-prvs: 017589626D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39850400004)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(476003)(386003)(26005)(54906003)(8936002)(8676002)(81166006)(52116002)(11346002)(446003)(58126008)(6506007)(102836004)(81156014)(99286004)(76176011)(55236004)(186003)(486006)(64756008)(4326008)(33716001)(33656002)(66556008)(6246003)(66946007)(6512007)(9686003)(66476007)(229853002)(6486002)(6436002)(305945005)(7736002)(5660300002)(71200400001)(71190400001)(66446008)(256004)(86362001)(25786009)(478600001)(1076003)(66066001)(3846002)(6116002)(2906002)(316002)(6916009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4781;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jnB10YajSvhHGYDVvtMEeCB1lT+OJ+o8OUyrhJyGzT2KbEbbsREmTrRboHeSV4R/ErNt86nkzdmmsTjPR4jUAei18Je9Yb3myx+9kefquBhgZ7tIajtIVN8hR1c28aAMrD2coOfYkY083yOM86aLSlHG+RhPkp+Ur1BB5JPKwVxtVsOZd/K8DfP4EVtzLe/7sBokWpPrUMO3VyTy7bpWMlDxPEIU7c1Z08I+0WtNlWEznBN2teE5RxYYanda2aD6T5l87LovStnTFBtnxG3jGBwFYkeLku1py/UeHylHdPw92FtPRDnz/6wsmBcYabjiT85QwbUDdvGgo0ib+6EKYJOE+kWM/9bbahxGsR3pgqb2Bn+GS/gY9hkzGlp0e635kM3S4w22a7PKnfa9lf1M9ojdAC13GlNmGMHEo6c50hY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FEF978B46090B04D86508D5484487008@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4781
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(136003)(39850400004)(346002)(189003)(199004)(6862004)(22756006)(446003)(4326008)(336012)(11346002)(58126008)(6486002)(7736002)(54906003)(2906002)(229853002)(316002)(305945005)(9686003)(476003)(97756001)(126002)(6512007)(47776003)(66066001)(486006)(33656002)(356004)(6246003)(63350400001)(1076003)(99286004)(386003)(26826003)(25786009)(46406003)(76176011)(50466002)(70206006)(70586007)(102836004)(33716001)(76130400001)(5660300002)(478600001)(8936002)(6116002)(3846002)(26005)(86362001)(23726003)(186003)(6506007)(14454004)(8676002)(81156014)(8746002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4678;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1855e459-4ddd-41f2-5502-08d7448cd665
NoDisclaimer: True
X-Forefront-PRVS: 017589626D
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHFARzGd64kh/0KzhcPPavdmhlMFbiUTmlAJPt6HQFvWhYm9tXQTP85eujqNMrXiOogApusq+o9GOCHOINQfWDsKxlRGyKZVweaLsdgUVXVvIX0VMG+XnfVO9Jny4ZMQfNgz9JzpJ+TpIurTFoW9oc8YD//HJdn63XW+MByvKD6tM7eYTd8WZ/z0KawxkEZdE0Hf1ktszlqNLOS9YQNSg6/88vaJ2qcUR0e6d7E7ofmnQeiBYnh04MaxR/uBjoSf2sjot62jYnQyKEpfoca6qcPGu3D97tJ01LO+3CGfM5/YjLovBn0SrjIIXOPYFPco0zE304a4NcJQI4E0ftMtK24B53FKvvvQvftrCp/Ddv9ae6IsXhjFvvVvj5cCf+sHoHPzVV1WeD2Nd1y8LfyHG0n0jXapQQwBV3heDi5DMGE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2019 03:26:47.7797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2abbb1-47d0-4d2a-ed70-08d7448cdc4b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 04:24:47PM +0800, Sandy Huang wrote:
> These new format is supported by some rockchip socs:
>=20
> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
>=20
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
>  include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index c630064..ccd78a3 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -261,6 +261,24 @@ const struct drm_format_info *__drm_format_info(u32 =
format)
>  		{ .format =3D DRM_FORMAT_P016,		.depth =3D 0,  .num_planes =3D 2,
>  		  .char_per_block =3D { 2, 4, 0 }, .block_w =3D { 1, 0, 0 }, .block_h =
=3D { 1, 0, 0 },
>  		  .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
> +		{ .format =3D DRM_FORMAT_NV12_10,		.depth =3D 0,  .num_planes =3D 2,
> +		  .char_per_block =3D { 5, 10, 0 }, .block_w =3D { 4, 4, 0 }, .block_h=
 =3D { 4, 4, 0 },

Hi Sandy:

Their is a problem here for char_per_block size of plane[0]:

Since: 5 * 8 !=3D 4 * 4 * 10;

Seems you mis-set the block_w/h, per your block size the block is 2x2, and =
it should be:

 .char_per_block =3D { 5, 10, 0 }, .block_w =3D { 2, 2, 0 }, .block_h =3D {=
 2, 2, 0 },


Best Regards:
James

> +		  .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
> +		{ .format =3D DRM_FORMAT_NV21_10,		.depth =3D 0,  .num_planes =3D 2,
> +		  .char_per_block =3D { 5, 10, 0 }, .block_w =3D { 4, 4, 0 }, .block_h=
 =3D { 4, 4, 0 },
> +		  .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true},
> +		{ .format =3D DRM_FORMAT_NV16_10,		.depth =3D 0,  .num_planes =3D 2,
> +		  .char_per_block =3D { 5, 10, 0 }, .block_w =3D { 4, 4, 0 }, .block_h=
 =3D { 4, 4, 0 },
> +		  .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true},
> +		{ .format =3D DRM_FORMAT_NV61_10,		.depth =3D 0,  .num_planes =3D 2,
> +		  .char_per_block =3D { 5, 10, 0 }, .block_w =3D { 4, 4, 0 }, .block_h=
 =3D { 4, 4, 0 },
> +		  .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true},
> +		{ .format =3D DRM_FORMAT_NV24_10,		.depth =3D 0,  .num_planes =3D 2,
> +		  .char_per_block =3D { 5, 10, 0 }, .block_w =3D { 4, 4, 0 }, .block_h=
 =3D { 4, 4, 0 },
> +		  .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true},
> +		{ .format =3D DRM_FORMAT_NV42_10,		.depth =3D 0,  .num_planes =3D 2,
> +		  .char_per_block =3D { 5, 10, 0 }, .block_w =3D { 4, 4, 0 }, .block_h=
 =3D { 4, 4, 0 },
> +		  .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true},
>  		{ .format =3D DRM_FORMAT_P210,		.depth =3D 0,
>  		  .num_planes =3D 2, .char_per_block =3D { 2, 4, 0 },
>  		  .block_w =3D { 1, 0, 0 }, .block_h =3D { 1, 0, 0 }, .hsub =3D 2,
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.=
h
> index 3feeaa3..08e2221 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -238,6 +238,20 @@ extern "C" {
>  #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampl=
ed Cb:Cr plane */
> =20
>  /*
> + * 2 plane YCbCr
> + * index 0 =3D Y plane, Y3:Y2:Y1:Y0 10:10:10:10
> + * index 1 =3D Cb:Cr plane, Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:=
10:10:10:10
> + * or
> + * index 1 =3D Cr:Cb plane, Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:=
10:10:10:10
> + */
> +#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsam=
pled Cr:Cb plane */
> +#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsam=
pled Cb:Cr plane */
> +#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsam=
pled Cr:Cb plane */
> +#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsam=
pled Cb:Cr plane */
> +#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsam=
pled Cr:Cb plane */
> +#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsam=
pled Cb:Cr plane */
> +
> +/*
>   * 2 plane YCbCr MSB aligned
>   * index 0 =3D Y plane, [15:0] Y:x [10:6] little endian
>   * index 1 =3D Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
