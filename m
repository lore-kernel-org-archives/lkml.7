Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7173C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C32168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="t9U6iJUc";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="t9U6iJUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404080AbfJPIVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:21:49 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:44502
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfJPIVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx8dmJezPpKue/92t1I5DN14Moel2ReZxXZfv3XRPfo=;
 b=t9U6iJUcPavlzCmpFYaG5iCdyMDnMdNlCCiIO2WK0hxm7OWtQ+qSser3hue8cwAI6uJSPXs6pYZuRutlqtRl5cR8po02ZEFPOgp+XVM6+Mfz9Q3LKlO4nlR6aEOxXEcKp+Tro7DQn/fAy4W34hih8sPvB9Wo/xFjbXi2q1qaalE=
Received: from DB7PR08CA0043.eurprd08.prod.outlook.com (2603:10a6:10:26::20)
 by AM4PR08MB2675.eurprd08.prod.outlook.com (2603:10a6:205:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22; Wed, 16 Oct
 2019 08:21:37 +0000
Received: from AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by DB7PR08CA0043.outlook.office365.com
 (2603:10a6:10:26::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 08:21:37 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT056.mail.protection.outlook.com (10.152.17.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 08:21:36 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Wed, 16 Oct 2019 08:21:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 08b1ce87ffbcd7ef
X-CR-MTA-TID: 64aa7808
Received: from ea902729bbed.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F71D2B3E-0CDA-422C-AC07-43DB00D1E71C.1;
        Wed, 16 Oct 2019 08:21:26 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ea902729bbed.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 08:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZRVhuNPkfXliCO9IBECFd6tqRhKaUOT8e0raf0VtupcgtORYRxpEnCm1Gp52NYQMY5hnEG5GwQmv/hcpTaOB0YgWBX+HQ/XKRTv1/ksPDW7Qgi4vT0lVy+sNegdR4eONKPJMw/uIujMBvc9S+vyG0fAVTd8vC+Jyz7Wz0hEVgK9974U4K7nb6b0GaSQqCAhexkzq0D4pmltlucYa+x7b9oOOY5U1EzM2wm6H75nXBR5WE3CvFCOo5aBxfTdfuph2NDGZx4l2RV5GrH7nQrZHZum5takPUOMueM+5XQ42SVv+M1V1OWEzfiHlUAJtoX0O2uW7aRTJNsJUKAPNMJcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx8dmJezPpKue/92t1I5DN14Moel2ReZxXZfv3XRPfo=;
 b=VAyS3uHRbKC5CWKmg2ZO99nbdQoxCQVw5VyR2m7pQSfsKeCDOxSSL5Yz359aP07ByEg9MUlPFZ3ccZsvKiVC1v7Yo/YQB7hNf4ugj60E7lKZVMH5FjDLvjPGwqXEz2VgpEyuYiCODFD30jApuAAuCyPL8L6a27wYAt79jecqzwspFmoUb5GL3GNv8BuZl0yGv9PGso+/zB1wFNGug3L1rkMSxUnxkDAkSzUOwiX+jeb/HDm7/Gla1eSGC97KkiEC1cIqUrlsfBGq7mhNx8Z9z0xgoeHupe6wlpa5UQ0tbOAz0GnkEhXhdWhQ6CO6h/WuV13adKVFAXijU/nLy0p5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx8dmJezPpKue/92t1I5DN14Moel2ReZxXZfv3XRPfo=;
 b=t9U6iJUcPavlzCmpFYaG5iCdyMDnMdNlCCiIO2WK0hxm7OWtQ+qSser3hue8cwAI6uJSPXs6pYZuRutlqtRl5cR8po02ZEFPOgp+XVM6+Mfz9Q3LKlO4nlR6aEOxXEcKp+Tro7DQn/fAy4W34hih8sPvB9Wo/xFjbXi2q1qaalE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5088.eurprd08.prod.outlook.com (10.255.158.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Wed, 16 Oct 2019 08:21:24 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 08:21:24 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: drm/komeda: Don't flush inactive pipes
Thread-Topic: drm/komeda: Don't flush inactive pipes
Thread-Index: AQHVg/qy9vCXt00JukKh3lKp5LBlUg==
Date:   Wed, 16 Oct 2019 08:21:24 +0000
Message-ID: <20191016082117.GA18601@jamwan02-TSP300>
References: <20191010102950.56253-1-mihail.atanassov@arm.com>
In-Reply-To: <20191010102950.56253-1-mihail.atanassov@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0005.apcprd03.prod.outlook.com
 (2603:1096:202::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 57a6e671-78f4-4101-aa6c-08d75211dccf
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5088:|VE1PR08MB5088:|AM4PR08MB2675:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB2675F9DD602D758DD95E59EFB3920@AM4PR08MB2675.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:147;OLM:147;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(64756008)(386003)(55236004)(66446008)(102836004)(66066001)(6506007)(33716001)(26005)(14444005)(71190400001)(25786009)(256004)(14454004)(186003)(71200400001)(11346002)(446003)(476003)(33656002)(5660300002)(486006)(2906002)(66946007)(66476007)(66556008)(229853002)(9686003)(86362001)(1076003)(6246003)(478600001)(4326008)(6486002)(7736002)(54906003)(58126008)(316002)(8676002)(305945005)(6862004)(81156014)(52116002)(76176011)(6512007)(8936002)(3846002)(6116002)(6636002)(99286004)(6436002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5088;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 3PaNHNE67Y+NHeSc1/clKHzj+U6HpvpQLovV+Xiepv9KmJZpUAgl0Nd7a9qjKKJ23DT1kWljq8f7PTlbwxMFgEnt5uPqHnRDLWjY0cOi0t4v7BcsUFC8r3NOPhZnn5Tx/X/nP2JcUrVLqzg7aiYosHn1Ute0gW7LVo8Lwpmxq33PQVAtnO4ha7CTeIovxBiXfg4ASGZOg7Wwn/poD0/t62E42nNv7IeKrXCyO5/ZFsFz6eRaxhLtf323Rt992IUxGuhxiok87e8aIQrqRd6wOy7JVPEaiyqvB8whEkYO2iTGmbZdLmQu1PbnrDndvtwKQhNIB8RY4KRAsWz0JZTJ49Zh1JfVL8qgWh3BNWSDJTekAFtMwu5ZVi9tWCUHcE7pL66lZ7poHcSJumt1/LfRda2fSDWGFdrPkMSINVISZTI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A1DD0FEC62ADD4882EA118DD1D6989E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5088
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(33716001)(6636002)(47776003)(5660300002)(476003)(6246003)(22756006)(6862004)(446003)(126002)(11346002)(14444005)(33656002)(46406003)(63350400001)(486006)(1076003)(4326008)(336012)(6486002)(58126008)(70586007)(99286004)(102836004)(2906002)(36906005)(86362001)(316002)(8746002)(478600001)(81166006)(305945005)(26826003)(6512007)(81156014)(8936002)(8676002)(186003)(70206006)(229853002)(66066001)(23726003)(54906003)(76176011)(76130400001)(14454004)(26005)(9686003)(6116002)(3846002)(386003)(7736002)(6506007)(50466002)(25786009)(97756001)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2675;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 652180b1-cfef-4c71-b29b-08d75211d554
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wyBcC8OsPSHLvzt/L1cIB+7hqJBeANCzenOewIrymNTMQq3bzHky/QNKyIhGSNHV1TCl2Hfez6doRKEfZoTWdz0kK3tWkaA4KSf6E/qfF0YMyKz4LOKe+8U5641nLxjBZjX/U413cwbDFU2VhMOi0dNceHpc/si1TJPp5E1BpolPriOxH3RWfTi+NVULrQa+rj9+sbfh66j/Q8dOBj92RsFzElA4X2G0NHU7pS3x7GnPJ24smsOzu+T2bIh2BRreySc9ZHE2SfJ3Qf7uOoRLr/uRn9cglYs6sYhvdyVucfID+DU4VF46IOyT0MH9aq17cfvJvckmWeYnJX+vlv4qYB88g987OlB0iTr/9SOCESYbiqoq2c2Zf6BqIsyrf9bqEmYwLamSYww/TXeyJ7cr8ocB4/I6garl+hpVnUiSSU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 08:21:36.8172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a6e671-78f4-4101-aa6c-08d75211dccf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:30:07AM +0000, Mihail Atanassov wrote:
> HW doesn't allow flushing inactive pipes and raises an MERR interrupt
> if you try to do so. Stop triggering the MERR interrupt in the
> middle of a commit by calling drm_atomic_helper_commit_planes
> with the ACTIVE_ONLY flag.
>=20
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 8820ce15ce37..ae274902ff92 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -82,7 +82,8 @@ static void komeda_kms_commit_tail(struct drm_atomic_st=
ate *old_state)
> =20
>  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> =20
> -	drm_atomic_helper_commit_planes(dev, old_state, 0);
> +	drm_atomic_helper_commit_planes(dev, old_state,
> +					DRM_PLANE_COMMIT_ACTIVE_ONLY);
>

Looks good to me.
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

>  	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> =20
