Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B613C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4321B20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XB5zr7q9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XB5zr7q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392963AbfJCRGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:06:04 -0400
Received: from mail-eopbgr30066.outbound.protection.outlook.com ([40.107.3.66]:16095
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403852AbfJCRGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wndwPiRj3/bmYLqEY1Y2INAsP+KJCyQHFshBbIPiols=;
 b=XB5zr7q9lIrPsCtSYVtDv0f/y54z7bM9CpuIzTbReVH2vLLyDuxNpAJGdiuxEzjsB591/wASKVU94YhNhjyg6kXcNcSeJD8xZ8ybpdi1x74jwGvxPx1JwiR1LDPAiy3/BZci1H3W4C+N+O2xNEqGFudGyIXAe9eVT6gDgW4qUQw=
Received: from DB7PR08CA0047.eurprd08.prod.outlook.com (2603:10a6:10:26::24)
 by AM0PR08MB3811.eurprd08.prod.outlook.com (2603:10a6:208:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Thu, 3 Oct
 2019 17:05:55 +0000
Received: from AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by DB7PR08CA0047.outlook.office365.com
 (2603:10a6:10:26::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20 via Frontend
 Transport; Thu, 3 Oct 2019 17:05:55 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT003.mail.protection.outlook.com (10.152.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 3 Oct 2019 17:05:54 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Thu, 03 Oct 2019 17:05:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3994401ae3fb81dd
X-CR-MTA-TID: 64aa7808
Received: from 1a0d2422a4c2.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 33EC2563-45B6-452A-B168-075759C08DE9.1;
        Thu, 03 Oct 2019 17:05:44 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1a0d2422a4c2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 03 Oct 2019 17:05:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mes9NSRPlhbxpRxVRFtIqd582fa211j++rWsGNMyOn2NXPqsQ2gL2QlMffSAhYw75UACw8vTkTgBAn7aFoyBfLtx9vx1ZBa6M5cqkK8YzEkjVdim+Q/Jxo/3yQs93NebPp++PZIHpNy4hYZ39vhwc/9M9Co0xmunpOY5ZCtLFY3dF76b4eWInc3eDx4diJ2Bc5lHHpK+yILlIYm6y9jhK5x9xZrKP4qO2WykBeXvp72kO/roiYNSxrNJE3aqfZGsMv5EBNZbuUf2kVnumEwRImWd7XGZ+aG74T/TXTIe/c5chd5vd9q8OQ2rHyVY3/YM0qRgpWnZW/Fq5tfznO0Anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wndwPiRj3/bmYLqEY1Y2INAsP+KJCyQHFshBbIPiols=;
 b=jDsJ2OKoeBhan9KXBdh26FdoZaDzuihaesTCWEpyc8o6xCGtp+P3KqOLbDl7MunXXDiaOA3DRurv/xMpe0yVGM4ACysqEPi9vgjFJjecJtWkKzD+E5CKiYKce+wRAp7oJPVOgPZgL25sEg/W6zWkNOUAi3VplA1z9exFE+N9bq9n5zI1TYqrGEZDT+j02vn2Q9kf7tArTHKNTJDy0/Qzh51MDqF/vG/oD4ZFF1x+cWXpO5mXLpAlPtmTfSyh//0FHk6qptjLDGCQsmtOM0yp/WPr7N/jlX+OlA5icwFS7biFkEAhsl1LLa3wg+GkQzEb2jLFbIc2GDAO7RkbxFGlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wndwPiRj3/bmYLqEY1Y2INAsP+KJCyQHFshBbIPiols=;
 b=XB5zr7q9lIrPsCtSYVtDv0f/y54z7bM9CpuIzTbReVH2vLLyDuxNpAJGdiuxEzjsB591/wASKVU94YhNhjyg6kXcNcSeJD8xZ8ybpdi1x74jwGvxPx1JwiR1LDPAiy3/BZci1H3W4C+N+O2xNEqGFudGyIXAe9eVT6gDgW4qUQw=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2653.eurprd08.prod.outlook.com (10.170.237.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 17:05:41 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 17:05:41 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
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
Subject: Re: [PATCH] drm/komeda: Adds more check in mode_valid
Thread-Topic: [PATCH] drm/komeda: Adds more check in mode_valid
Thread-Index: AQHVQ4j/fedIk6fUkkilpyBPPcwKladJkn2A
Date:   Thu, 3 Oct 2019 17:05:40 +0000
Message-ID: <13323280.1D6Sk5SDY4@e123338-lin.cambridge.arm.com>
References: <1564128364-23055-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1564128364-23055-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::20) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f42b97c5-5405-4d24-e0c8-08d74823f3b3
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB2653:|VI1PR08MB2653:|AM0PR08MB3811:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3811ED42FC739BBA1D3F47A58F9F0@AM0PR08MB3811.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2449;OLM:2449;
x-forefront-prvs: 01792087B6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(346002)(376002)(136003)(199004)(189003)(6862004)(446003)(6512007)(86362001)(6246003)(4326008)(52116002)(99286004)(2906002)(478600001)(76176011)(316002)(8936002)(14454004)(81166006)(3846002)(6116002)(81156014)(8676002)(6486002)(66556008)(6436002)(66476007)(26005)(64756008)(66066001)(229853002)(54906003)(11346002)(6506007)(186003)(486006)(305945005)(386003)(66446008)(25786009)(102836004)(71190400001)(66946007)(7736002)(71200400001)(5660300002)(476003)(6636002)(256004)(14444005)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2653;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zD7xfUnZeas9Hg542XE8Pp936Lj8os/pyzGCnq45670Uo4/nJNpmkP1JCm94HqeabjbvEyRbxIrlqp9Xy8xWJ/E5rKrPqjhcPW/Z5fSx7U4wmXhqzKqyfn7N6QDK/8QrHnfn50vbZUwTiOzXNFVuD9HuqqpfuzWvugCEZOuq71fLGXzffB601Lg3DjiqFxdzZsQ4jPMzz7fxnkwH6pmpadLRmRIbXM9tKcSVh5erQqt1QTZ3mqqHCFEzjvj9/2Vv4AaHgeeovyx8DURMJ694qleL51BaoN6CgWGiQm/EjjCrf9T33pmtBZfUuV7b0XPAN/2n8SP/B+URpHo7XdATKnTuAGJ/fnvHXa54Yj51VRKOF49y5IE++I+zQSCe4z4HtJTYHOgN6tjWxfIyalYXmbWQE829WKbwZ2AOyxX6qtw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBC78ACD0000F04F8E820804631F031D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2653
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(396003)(376002)(136003)(189003)(199004)(4326008)(8746002)(8936002)(81156014)(81166006)(8676002)(86362001)(229853002)(6512007)(97756001)(6486002)(99286004)(6862004)(6246003)(47776003)(14444005)(22756006)(66066001)(11346002)(7736002)(486006)(476003)(126002)(3846002)(6506007)(6116002)(386003)(63350400001)(336012)(305945005)(54906003)(76130400001)(46406003)(2906002)(23726003)(356004)(446003)(186003)(26005)(36906005)(25786009)(26826003)(316002)(478600001)(70206006)(70586007)(5660300002)(14454004)(76176011)(6636002)(50466002)(102836004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3811;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 558c4d4e-5e03-44ab-b4a7-08d74823eb2c
NoDisclaimer: True
X-Forefront-PRVS: 01792087B6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3d0OvhyLx1IfL2GKI8gWjMm9aQba+4gVc0BIs4a8K0hbjd26mJBbrXcpRDGAD7IAs51koNK/Uy+etm0vv3zoqUgcnuMRLC7QgyVy2uMb/HI+c7kXCYGEa5z1H4w8NiViEHiHjEXr7ftqAGvLD18hP+qHjRgF/aY0pfi+DKlcjm/q7RFkq8xrpNS3KNeVfoESOjnMaPj3B86tw6vKD5lgqfGVFbEnB5TAseJ31C8LbpV05Q9+i27V7In3owMFp3M1DLKpHCgitk49qIY6ujsrSbk9EPlbNbKc+kZRmEx9rChR/Ngf/B3WhHcYUItTR8xrTN/STMSUDhrRMqNOwfU8Ovg5wt5QtRqHHVgYOeJzsdiMvTjWEtBX7LCxL7Q44d885Cnvq1xY1CN+6CXiYa3R0/xQipAOR4TuGX9wBdDskQ=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2019 17:05:54.5291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42b97c5-5405-4d24-e0c8-08d74823f3b3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3811
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 26 July 2019 09:06:16 BST Lowry Li (Arm Technology China) wrote:
> This patch adds the checks for vrefresh, crtc_hdisplay and crtc_vdisplay.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 28 ++++++++++++++++++=
+++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 2fed1f6..017f6b6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -403,11 +403,37 @@ unsigned long komeda_crtc_get_aclk(struct komeda_cr=
tc_state *kcrtc_st)
>  	struct komeda_dev *mdev =3D crtc->dev->dev_private;
>  	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
>  	struct komeda_pipeline *master =3D kcrtc->master;
> -	unsigned long min_pxlclk, min_aclk;
> +	struct komeda_compiz *compiz =3D master->compiz;
> +	unsigned long min_pxlclk, min_aclk, delta, full_frame;
> +	int hdisplay =3D m->hdisplay;
> =20
>  	if (m->flags & DRM_MODE_FLAG_INTERLACE)
>  		return MODE_NO_INTERLACE;
> =20
> +	full_frame =3D m->htotal * m->vtotal;
> +	delta =3D abs(m->clock * 1000 - m->vrefresh * full_frame);
> +	if (m->vrefresh && (delta > full_frame)) {
> +		DRM_DEBUG_ATOMIC("mode clock check error!\n");
> +		return MODE_CLOCK_RANGE;
> +	}
> +
> +	if (kcrtc->side_by_side)
> +		hdisplay /=3D 2;
> +
> +	if (!in_range(&compiz->hsize, hdisplay)) {
> +		DRM_DEBUG_ATOMIC("hdisplay[%u] is out of range[%u, %u]!\n",
> +				 hdisplay, compiz->hsize.start,
> +				 compiz->hsize.end);
> +		return MODE_BAD_HVALUE;
> +	}
> +
> +	if (!in_range(&compiz->vsize, m->vdisplay)) {
> +		DRM_DEBUG_ATOMIC("vdisplay[%u] is out of range[%u, %u]!\n",
> +				 m->vdisplay, compiz->vsize.start,
> +				 compiz->vsize.end);
> +		return MODE_BAD_VVALUE;
> +	}
> +
>  	min_pxlclk =3D m->clock * 1000;
>  	if (master->dual_link)
>  		min_pxlclk /=3D 2;
>=20
LGTM,

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

--=20
Mihail



