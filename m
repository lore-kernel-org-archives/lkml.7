Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBA3C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60820725
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="z/YMS7TZ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="z/YMS7TZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKOACY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:02:24 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:58439
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfKOACX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+K8la7NVtCnO9mwhfRNJRdP2O1FO4w3w3RGXdcefZM=;
 b=z/YMS7TZfUX/6a+41AuX6a8vp5T6mNAcAsU1nuUcFsADmUXkOLlK/d6EoJmQzC12SIpkjvInKW0pafTVRJMABkMj7bXkg/BoWggb4FdX4lmq8d5gVrR2GXie79fKvhtx+mZ+tNKUdFdtcwHCV4wNoshgz9YzcWh9rQffQ/nvBTU=
Received: from VE1PR08CA0017.eurprd08.prod.outlook.com (2603:10a6:803:104::30)
 by DB6PR0801MB1702.eurprd08.prod.outlook.com (2603:10a6:4:2f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Fri, 15 Nov
 2019 00:02:13 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by VE1PR08CA0017.outlook.office365.com
 (2603:10a6:803:104::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 00:02:13 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Fri, 15 Nov 2019 00:02:12 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Fri, 15 Nov 2019 00:02:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a3b8982bc5ee555a
X-CR-MTA-TID: 64aa7808
Received: from 32eea7984d57.2 (cr-mta-lb-1.cr-mta-net [104.47.9.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 155D8689-8CA9-4379-AE64-12E13DF5E87F.1;
        Fri, 15 Nov 2019 00:02:02 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 32eea7984d57.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 Nov 2019 00:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTYdAT0JZ0tyAHGE4MLHxD4uSzKLFMQT+69W6DDYenAUBKHEBE3eBrUDzqQlk6OxPxDlP9/EhpJpjw7QgOQM6bjX0Biq0naSduzvRl/oO0Vj+cBDc7ZPy6pSYUh0L7uAvalQshNq+2p1dUCEDflMWqc1FcHX97p9Jz5HPwjsiHP0ONPShqZJ/bKlaV+0zbecsPxi3KySerejFcLC6H2wgcKhGFcmfCrA4sXYtZJMUwHLWOTL9pIA9s3erV+kAZld07vK7BL+Z733Cbe1I4bgw65J2WpfCKkLuW9ovzd/pSTsUaAlcnfU6HIh2ASGHMo0PtabGYnCfAPeDO1oweRW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+K8la7NVtCnO9mwhfRNJRdP2O1FO4w3w3RGXdcefZM=;
 b=dEqNnK1OCS81UMYDDp9nmFOoyWiK/NrrPMLwXuqli2VswR/5hIKUZEneSDaG9YqZt6IY9MC8dTEfLOdV+4Z8DjdXwDiTk7cQ7t5m9sYgfdiaYwhDWPvH+7YY9ampBlEsu1n9y4BLtKD3GDJf3X2xusiz2zgJ821q7SkPZufvryobdTMccv3Eua4tHJTlw1Xv6UxNVo32+fJiHjAvuGDUH5yffYfUaL0Sgp2ISqJ0Y2DoA2dDF8OLZqL7F8Pf5BHiVcueSt3v3qnZA0HSOCaivuFSzAYwekr7zaG61FkU/9ILu2cBDzBLXv/XyEdvyAQhDgGhVlte16QKqApiC9nVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+K8la7NVtCnO9mwhfRNJRdP2O1FO4w3w3RGXdcefZM=;
 b=z/YMS7TZfUX/6a+41AuX6a8vp5T6mNAcAsU1nuUcFsADmUXkOLlK/d6EoJmQzC12SIpkjvInKW0pafTVRJMABkMj7bXkg/BoWggb4FdX4lmq8d5gVrR2GXie79fKvhtx+mZ+tNKUdFdtcwHCV4wNoshgz9YzcWh9rQffQ/nvBTU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4383.eurprd08.prod.outlook.com (20.179.28.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 00:02:00 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 00:02:00 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
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
Subject: Re: [PATCH v3 1/6] drm/komeda: Add side by side assembling
Thread-Topic: [PATCH v3 1/6] drm/komeda: Add side by side assembling
Thread-Index: AQHVmsbDb0TRDDY6qUmWKK8J6ZmYzqeLWj+A
Date:   Fri, 15 Nov 2019 00:02:00 +0000
Message-ID: <6478126.Gfiuz5foDL@e123338-lin>
References: <20191114083658.27237-1-james.qian.wang@arm.com>
 <20191114083658.27237-2-james.qian.wang@arm.com>
In-Reply-To: <20191114083658.27237-2-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::25) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a5dd59f-9fb9-4f1d-c5ab-08d7695f116b
X-MS-TrafficTypeDiagnostic: VI1PR08MB4383:|VI1PR08MB4383:|DB6PR0801MB1702:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1702C3E08741CEA741526D498F700@DB6PR0801MB1702.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:813;OLM:813;
x-forefront-prvs: 02229A4115
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(66556008)(6246003)(478600001)(66066001)(476003)(486006)(26005)(6636002)(52116002)(102836004)(25786009)(86362001)(6862004)(33716001)(11346002)(446003)(186003)(14444005)(7736002)(256004)(305945005)(386003)(6506007)(4326008)(54906003)(14454004)(6436002)(6512007)(9686003)(71190400001)(71200400001)(8676002)(316002)(76176011)(6116002)(3846002)(66476007)(5660300002)(81156014)(2906002)(81166006)(66946007)(6486002)(99286004)(64756008)(66446008)(229853002)(8936002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4383;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6oZ7jOLbBq3XXK8lem0eSIkUI7b+I0F7xT6NzGi8gPpQ5Fijn3BQpa03Z4YdkAhoA+eoUrVQ4yhEJSWFnEE7t4ANW56deKMHqwN4tHAsw5tdoKnLlI8F8UEoylucKvIepGKnrcshPwqJgzvPMrR6T+QNKNkQmdYzjqVuT7aaOMZeCX6V2HPw0i+acYU2E4qu1jBoVYAc34oqeFjMg21hb698jYh7k9P1Gme9fKTENQjOIcwoGmozZ/9a23okaMtiTcNkI6nT+3/bbnrdwIfHDN/qX2JB5Y3LIMYR85R4al4lyD66CT1z4/hLYInIrCDpMsXhkzJfsiHpnjDzKo6ribm9I6IVgG3TtNdw/TFYqxqQA5jLMwZ6s9ujM5L263hjeCrdHNntJ+GgdO81ThdVgE3hWlE+QJHWqnA/Xw8di1DyC4DjOTCe45UiHUZBerop
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59DC05BA19F9514BB2B6EADC810B420F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4383
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(346002)(136003)(376002)(39860400002)(1110001)(339900001)(189003)(199004)(6486002)(14444005)(81166006)(76176011)(446003)(2906002)(316002)(47776003)(33716001)(14454004)(81156014)(66066001)(5660300002)(25786009)(6636002)(229853002)(86362001)(54906003)(22756006)(186003)(486006)(476003)(6512007)(9686003)(26005)(126002)(97756001)(50466002)(8936002)(8746002)(4326008)(6862004)(36906005)(105606002)(76130400001)(46406003)(305945005)(7736002)(336012)(6506007)(386003)(70206006)(23726003)(3846002)(356004)(8676002)(99286004)(478600001)(11346002)(102836004)(26826003)(6246003)(6116002)(70586007)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1702;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 007294e7-747e-4f85-276d-08d7695f09d8
NoDisclaimer: True
X-Forefront-PRVS: 02229A4115
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icq9sfkAHHjIqxR5r1O6qqaBZbzLXFrdEmMXDqXAO9fdYr7Bkk13kPhT0kDxl3APYNVpt3gqruBmsZ2ss7BS1s0XUh2bykgZON1rtqiTPtDiy1CoEQCaPsfQzZ+MsY2W1Fu+SMy+vEi3+kSZHpCB9xekWs9jZuyHbhUcQEx6ZQeOd9o3C+uqtkeJoIFle/mn9SNUgYk8mbHDoR4ByNTCKEG+/m5Muwziyg888Kl1IvESaxJlr0mmLiwtVb02wLwAYpo7JUxMFFNueOLmxvevt/TFYCOkJS1vLDN3etu02MJ/lGAoH5SDeeB9efTCe+bnZbZuChyJXSiMEEGLy4ty7KSZLczFJu1KEs9IBSPO1cvoqSeGa/Mp305xefMk3FBWOtU1q6jVtNPLK9fY1qUabgqDf63YEIkqbx+rHRNa5Wy1c6+cwJ85a/xPrUOZXkI7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 00:02:12.9848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5dd59f-9fb9-4f1d-c5ab-08d7695f116b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1702
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thursday, 14 November 2019 08:37:24 GMT james qian wang (Arm Technology =
China) wrote:
> Komeda HW can support side by side, which splits the internal display
> processing to two single halves (LEFT/RIGHT) and handle them by two
> pipelines separately.
> komeda "side by side" is enabled by DT property: "side_by_side_master",
> once DT configured side by side, komeda need to verify it with HW's
> configuration, and assemble it for the further usage.

A few problems I see with this approach:
 - This property doesn't scale to >2 pipes;
 - Our HW is capable of dynamically switching between SBS and non-SBS
modes, with this DT property you're effectively denying the opportunity
to use the second pipe when the first one can be satisfied with
4 planes and 1px/clk.

If we only want to fix the first problem, then at least we need this
to be a property of the pipeline node with a phandle linking slave to
master (or bidirectional).

For the second, why not do the SBS decision at modeset time?
If the first CRTC has dual-link output and the commit:
 - only drives one CRTC
 - uses up to 4 planes
 - doesn't meet clk requirements without SBS but does with SBS
then we can switch SBS on dynamically.

And we can tweak that decision with power use in mind later on since
there's no user-visible knob.

We can still keep a DT property if we have a use case for it (e.g.
forcing SBS on for some reason), but we might want to name it slightly
more conservatively then, so it doesn't imply that we never do SBS
when it's not there.

Lastly, maintaining that property in combination with the dynamic
modeset-time SBS decision tree means extra code for more or less the
same functionality. <2c>I'm not 100% sure it's worth it.</2c>

>=20
> v3: Correct a typo.
>=20
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@ar=
m.com>
> ---
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 13 ++++-
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   |  3 ++
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  9 ++++
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 ++
>  .../drm/arm/display/komeda/komeda_pipeline.c  | 50 +++++++++++++++++--
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
>  6 files changed, 73 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index 1c452ea75999..cee9a1692e71 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -561,21 +561,30 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *k=
ms,
>  	kms->n_crtcs =3D 0;
> =20
>  	for (i =3D 0; i < mdev->n_pipelines; i++) {
> +		/* if sbs, one komeda_dev only can represent one CRTC */
> +		if (mdev->side_by_side && i !=3D mdev->side_by_side_master)
> +			continue;
> +
>  		crtc =3D &kms->crtcs[kms->n_crtcs];
>  		master =3D mdev->pipelines[i];
> =20
>  		crtc->master =3D master;
>  		crtc->slave  =3D komeda_pipeline_get_slave(master);
> +		crtc->side_by_side =3D mdev->side_by_side;
> =20
>  		if (crtc->slave)
>  			sprintf(str, "pipe-%d", crtc->slave->id);
>  		else
>  			sprintf(str, "None");
> =20
> -		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
> -			 kms->n_crtcs, master->id, str);
> +		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s) sbs(%s).\n",
> +			 kms->n_crtcs, master->id, str,
> +			 crtc->side_by_side ? "On" : "Off");
> =20
>  		kms->n_crtcs++;
> +
> +		if (mdev->side_by_side)
> +			break;
>  	}
> =20
>  	return 0;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 4e46f650fddf..c3fa4835cb8d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -178,6 +178,9 @@ static int komeda_parse_dt(struct device *dev, struct=
 komeda_dev *mdev)
>  		}
>  	}
> =20
> +	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master",
> +						   &mdev->side_by_side_master);
> +
>  	return ret;
>  }
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index d406a4d83352..471604b42431 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -183,6 +183,15 @@ struct komeda_dev {
> =20
>  	/** @irq: irq number */
>  	int irq;
> +	/**
> +	 * @side_by_side:
> +	 *
> +	 * on sbs the whole display frame will be split to two halves (1:2),
> +	 * master pipeline handles the left part, slave for the right part
> +	 */
> +	bool side_by_side;

That's a duplicate of the one in komeda_crtc. You don't need both.

> +	/** @side_by_side_master: master pipe id for side by side */
> +	int side_by_side_master;

As I detailed above, this should be on the crtc, otherwise we can't
scale to >2 pipes.

> =20
>  	/** @lock: used to protect dpmode */
>  	struct mutex lock;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index 456f3c435719..ae6654fe95e2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -76,6 +76,9 @@ struct komeda_crtc {
>  	 */
>  	struct komeda_pipeline *slave;
> =20
> +	/** @side_by_side: if the master and slave works on side by side mode *=
/
> +	bool side_by_side;
> +
>  	/** @slave_planes: komeda slave planes mask */
>  	u32 slave_planes;
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.c
> index 452e505a1fd3..104e27cc1dc3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> @@ -326,14 +326,56 @@ static void komeda_pipeline_assemble(struct komeda_=
pipeline *pipe)
>  struct komeda_pipeline *
>  komeda_pipeline_get_slave(struct komeda_pipeline *master)
>  {
> -	struct komeda_component *slave;
> +	struct komeda_dev *mdev =3D master->mdev;
> +	struct komeda_component *comp, *slave;
> +	u32 avail_inputs;
> +
> +	/* on SBS, slave pipeline merge to master via image processor */
> +	if (mdev->side_by_side) {
> +		comp =3D &master->improc->base;
> +		avail_inputs =3D KOMEDA_PIPELINE_IMPROCS;
> +	} else {
> +		comp =3D &master->compiz->base;
> +		avail_inputs =3D KOMEDA_PIPELINE_COMPIZS;
> +	}
> =20
> -	slave =3D komeda_component_pickup_input(&master->compiz->base,
> -					      KOMEDA_PIPELINE_COMPIZS);
> +	slave =3D komeda_component_pickup_input(comp, avail_inputs);
> =20
>  	return slave ? slave->pipeline : NULL;
>  }
> =20
> +static int komeda_assemble_side_by_side(struct komeda_dev *mdev)
> +{
> +	struct komeda_pipeline *master, *slave;
> +	int i;
> +
> +	if (!mdev->side_by_side)
> +		return 0;
> +
> +	if (mdev->side_by_side_master >=3D mdev->n_pipelines) {
> +		DRM_ERROR("DT configured side by side master-%d is invalid.\n",
> +			  mdev->side_by_side_master);
> +		return -EINVAL;
> +	}
> +
> +	master =3D mdev->pipelines[mdev->side_by_side_master];
> +	slave =3D komeda_pipeline_get_slave(master);
> +	if (!slave || slave->n_layers !=3D master->n_layers) {
> +		DRM_ERROR("Current HW doesn't support side by side.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!master->dual_link) {
> +		DRM_DEBUG_ATOMIC("SBS can not work without dual link.\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < master->n_layers; i++)
> +		master->layers[i]->sbs_slave =3D slave->layers[i];
> +
> +	return 0;
> +}
> +
>  int komeda_assemble_pipelines(struct komeda_dev *mdev)
>  {
>  	struct komeda_pipeline *pipe;
> @@ -346,7 +388,7 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev=
)
>  		komeda_pipeline_dump(pipe);
>  	}
> =20
> -	return 0;
> +	return komeda_assemble_side_by_side(mdev);
>  }
> =20
>  void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index ac8725e24853..20a076cce635 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -237,6 +237,7 @@ struct komeda_layer {
>  	 * not the source buffer.
>  	 */
>  	struct komeda_layer *right;
> +	struct komeda_layer *sbs_slave;
>  };
> =20
>  struct komeda_layer_state {
>=20


--=20
Mihail



