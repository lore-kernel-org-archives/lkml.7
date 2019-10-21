Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA99CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DB52166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="txuicf13";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="txuicf13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfJUOEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:04:04 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:34977
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728872AbfJUOED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsxpaGl0iXPX6O+vPrVzlmc6FU5s+0aVjjhbQk+L4pw=;
 b=txuicf139TZXXypkp/90sbrM9K7bZmrjVgxxn9MnS9qOhqFlmzVNI1okXlhq1k4oOyJ6I/IguCI/+o3sBGOqZDaY6CB9j+kU4d1KGP0e/tyLPEiI04A8ZE9ntHOXCD7M9MKMzEfwHD24eR/6I1eprO3oeePNJ35byti4JHYX8qk=
Received: from VI1PR0802CA0019.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::29) by VI1PR08MB5422.eurprd08.prod.outlook.com
 (2603:10a6:803:133::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.28; Mon, 21 Oct
 2019 14:03:58 +0000
Received: from AM5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR0802CA0019.outlook.office365.com
 (2603:10a6:800:aa::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21 via Frontend
 Transport; Mon, 21 Oct 2019 14:03:58 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT009.mail.protection.outlook.com (10.152.16.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Mon, 21 Oct 2019 14:03:57 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Mon, 21 Oct 2019 14:03:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: deb0673e18c02376
X-CR-MTA-TID: 64aa7808
Received: from 7f710b4e19ac.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.2.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BF963E55-1B4D-4DB7-AD40-47F4880E83E2.1;
        Mon, 21 Oct 2019 14:03:49 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7f710b4e19ac.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 14:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS166ByFYw/oJJfMbj+7rp7VAI3+fNTP8j/lMG0Yj3yzSdDkg36ld98mL6dNtxAwC4I6cg9EFbkZCMCAKsm7LGYv5u3NbAjh+r1zVu/Jyaq69ispsaeXbTJGRPSY7kgbD5mto0FoGlHHiPkKmSasCn3LL6TddcSgPYCVzI/lVzE0601214k8AznJHD1iHGGdXdme2w18h8ifqpY1mS0IM4dyDX56/Ey9nqORVHCq2iI9x52aEiSfKa8UCiuGsHhqTMiPIFZONhDyXQolELnZdwNta/Q85KJqOELStrNT9wojj0x9hdmcNEx7GIrym7pt0i4PjKsyoDdSYgztECYhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsxpaGl0iXPX6O+vPrVzlmc6FU5s+0aVjjhbQk+L4pw=;
 b=dlQkl/ofmdFwwseMOcvv3xl8IXfSlYYcLp8hlEy0wuwV59EjouXv8ieXIEPlR6QddXQ6+B2DVxXqPjeWJYjSUf9ciUU9q7GNQbQZDXBMsOcnyIgltdVOlUvXxZdmbQyMZBx/qO+onw7/5A9MGZqU+pX/BSXtRJ3MhJEKr0uQEvzAFw4wIDWxxF+S3hP7zWwvPae8BKsPEMrsq0ZEmcv6iEsHwhjFXqnefl1UJL0BWKAWSYs3jj6rh4x32G5d0ZioQUBdA78hHoZj+tx573sfHXVI0vYdtf6s1REFXx3LFImXUw1dVIooByCgHNHjLYfM64WuXZd8IAkPy5z2UTVJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsxpaGl0iXPX6O+vPrVzlmc6FU5s+0aVjjhbQk+L4pw=;
 b=txuicf139TZXXypkp/90sbrM9K7bZmrjVgxxn9MnS9qOhqFlmzVNI1okXlhq1k4oOyJ6I/IguCI/+o3sBGOqZDaY6CB9j+kU4d1KGP0e/tyLPEiI04A8ZE9ntHOXCD7M9MKMzEfwHD24eR/6I1eprO3oeePNJ35byti4JHYX8qk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3262.eurprd08.prod.outlook.com (52.133.15.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Mon, 21 Oct 2019 14:03:48 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 14:03:48 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: drm/komeda: Don't flush inactive pipes
Thread-Topic: drm/komeda: Don't flush inactive pipes
Thread-Index: AQHVg/q5HtMJ9aPBjkqhwpfRyiPcGKdlKMGA
Date:   Mon, 21 Oct 2019 14:03:48 +0000
Message-ID: <4038026.EQVCqvRzMf@e123338-lin>
References: <20191010102950.56253-1-mihail.atanassov@arm.com>
 <20191016082117.GA18601@jamwan02-TSP300>
In-Reply-To: <20191016082117.GA18601@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::36)
 To VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fdb7ca8e-cea2-43cc-2530-08d7562f83ef
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3262:|VI1PR08MB3262:|VI1PR08MB5422:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB542257628CB3CB22C2C9C6238F690@VI1PR08MB5422.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:170;OLM:170;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(39860400002)(346002)(376002)(136003)(396003)(51914003)(199004)(189003)(14454004)(54906003)(9686003)(6512007)(6436002)(5660300002)(81156014)(33716001)(6246003)(305945005)(66066001)(7736002)(14444005)(256004)(6862004)(81166006)(8936002)(8676002)(2906002)(186003)(26005)(478600001)(71190400001)(71200400001)(446003)(11346002)(476003)(86362001)(316002)(6636002)(52116002)(6486002)(486006)(6506007)(99286004)(229853002)(76176011)(102836004)(386003)(3846002)(6116002)(66946007)(4326008)(66556008)(64756008)(25786009)(66476007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3262;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +MUz9LpuNA4fqRvIdNIYYqcAU/ADcCmqYQvfxg06UCCdBpGyL1/Fiu3Kvw9wVCbKOICnJhw4z5M7y7hQLJtVWxVGAJXD01EqV5P5L5PqKPV58cykoqxudW/X17HYy+1BEmSsRPuOIFAjw+KdqYZmmM9k5OoUpEj3OmJBHAf6C7lQlPDAmXRGFjZt/fx8IsZ6jPfU/SmGvmZnc8vZ7QuMGQWwKgmddTMhl3aOyIpUXChHRRD05gK+2kfx+N7vrb2E7rkzoUbXaNhKHUrvNLuP4uf2MgR7gpTfANmKXWU/nMGN7F0wF4KkHfCzdXQ/tsBeoNA1LSpZRE7rg5GDp8ip80x4pZyNukiE69GDVBZnmsaGy7JnwaTurRwun8cbV6tiqSuEHSxr+JW8Cya2eBxwrOpogO7QX1Ng2funxzwF4Dg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0533DF58170BF348BE6D64481660898F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3262
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(51914003)(14454004)(46406003)(76176011)(26826003)(102836004)(478600001)(14444005)(6506007)(386003)(66066001)(25786009)(6512007)(9686003)(5660300002)(6486002)(99286004)(70586007)(70206006)(47776003)(36906005)(356004)(81156014)(81166006)(8676002)(316002)(50466002)(54906003)(7736002)(229853002)(305945005)(8936002)(8746002)(22756006)(3846002)(6116002)(446003)(23726003)(186003)(63350400001)(76130400001)(6636002)(6246003)(486006)(2906002)(97756001)(126002)(86362001)(33716001)(4326008)(26005)(6862004)(336012)(476003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5422;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d2f8b61-df74-4eb9-e65e-08d7562f7e4e
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJIraMe9MSOd2cKDuumnbU8WuTisWYa5tMUBWgB8CAl+y1n3q+dnltICmEAvKGA6yfuBpuZpVPoz0/0RE4zOm9lF48p3/895s3Jh5b48m733UoeS7kQ2Bm0XDG1gw1rS48nekM2aInexogyaHRvOqMmj21Ke5DQbbVRDoxVp/4NDOZAPWM+eq83X0NtJ9Z0Lri0ZUFM5kDEgMh+1Dvju5hybAAzY4JL5qFjy0dt9X50gdPAWz+weiaePjhVeodap9gbQ2smdVazCfJ95Rv/1wzUiw3nrxmSUKqZHY03EAf+1sRziSxnolTDU1AHqxA5EcSFmW3drNaUL34KZ7ZvNwJcGuSQ+qafngGa2VhJonOHPVou9CXwiqNv2JwYMyaSMg6D0cQvrBcU13p74Syag35WGBWDrk9ES0N3bZtqqh88=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 14:03:57.2583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb7ca8e-cea2-43cc-2530-08d7562f83ef
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 16 October 2019 09:21:24 BST james qian wang (Arm Technology =
China) wrote:
> On Thu, Oct 10, 2019 at 10:30:07AM +0000, Mihail Atanassov wrote:
> > HW doesn't allow flushing inactive pipes and raises an MERR interrupt
> > if you try to do so. Stop triggering the MERR interrupt in the
> > middle of a commit by calling drm_atomic_helper_commit_planes
> > with the ACTIVE_ONLY flag.
> >=20
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 8820ce15ce37..ae274902ff92 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -82,7 +82,8 @@ static void komeda_kms_commit_tail(struct drm_atomic_=
state *old_state)
> > =20
> >  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> > =20
> > -	drm_atomic_helper_commit_planes(dev, old_state, 0);
> > +	drm_atomic_helper_commit_planes(dev, old_state,
> > +					DRM_PLANE_COMMIT_ACTIVE_ONLY);
> >
>=20
> Looks good to me.
> Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>

Thanks for the review, applied to drm-misc-fixes -
b88639b8e3808c948169af390bd7e84e909bde8d.

>=20
> >  	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> > =20
>=20


--=20
Mihail



