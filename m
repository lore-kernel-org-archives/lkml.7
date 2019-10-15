Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2464B2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="S+KBjcPe";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="S+KBjcPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfJOIzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:55:46 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:22805
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfJOIzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+12jSE9K08bEIL2aEYWoaw3gN6kWnpCy2M6X8Epg2qE=;
 b=S+KBjcPev1sRTGpZfI+0cQpXUO51PldyvoRxcLEpaijv8RPIsTwGT+AtBll673aIp6A/p+Pcil6id23O/o2zHN96c4yllIxIVUx1aWeInQkB0EW7a9tn1OGBTkYDeie9Exa7IH7Bs37sO9PSCwmHn0fOFhjTfnqx3Z2U47jbRIM=
Received: from AM4PR08CA0064.eurprd08.prod.outlook.com (2603:10a6:205:2::35)
 by VI1PR0801MB1936.eurprd08.prod.outlook.com (2603:10a6:800:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 08:55:36 +0000
Received: from VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by AM4PR08CA0064.outlook.office365.com
 (2603:10a6:205:2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 08:55:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT053.mail.protection.outlook.com (10.152.19.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 15 Oct 2019 08:55:35 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Tue, 15 Oct 2019 08:55:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3f537d8ea2c04355
X-CR-MTA-TID: 64aa7808
Received: from 7c1844d741b1.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 69A2A0E9-57F0-4D79-B0FD-70A72885789F.1;
        Tue, 15 Oct 2019 08:55:22 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7c1844d741b1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 15 Oct 2019 08:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHY2RjCRdj1HwLnNdoayOhoJcI5/JuhswcJg8Zek+FoNOu8+P8QljvkGCtbW9FPl5Qjo+iH/kWOqeIzTE5JMkBfdkmbiQZEcHSXKJV3JjnImRS8/hLvf38urpXJyrqwWTSgAPShf6lCxYnpIPsJRZFeEMaCWOxfWBcYQ7HcpTtSFhnWVIPUVQI4ILBDhTNmYp7QPNIRF8iYjdCX0GjIHjA8YtCsXBP2Sw4N2RJDPgKTfLJIUoUAogtYafy/d5WTlP45jKU2Knnv6SWmGBLBL8YRpYB1/HdQZqnjc2BOxlxhKtPBrc9UyZUSDjQ1D6k6PzBoKpzftrZZ5hE16SzHzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+12jSE9K08bEIL2aEYWoaw3gN6kWnpCy2M6X8Epg2qE=;
 b=Yz7aNei3UGDsV+1tjOnEaKqGRD/tgQBwNPHBH9yYiDgQbxtffLMiYJUm4EcVNhc5nzQEpJ71bPpOmIYVLh5lFVryauvAgnDiaZfDKTB6ufvBYRYYlXXcm2GRC6WUxrd+bwlthb4eDiMmrwKgMwRsf9ZB6fF/2iYbomPovlSLL1KaxIPt/+YSlWVJKiWXPI2bivP+YJA3+CAZzwUfFg/FMIKZTRArIx22YHOZ7BOuZJJTZ4D9jlqqCahXMSQLRf6HngouxDdQEicR/dkg2Jmnm6JiWc4DiFui+t49cULB7Uj0dAj/pY7uRbT1UNbTF2fbkEzeGRzKraRFu0lFcCWtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+12jSE9K08bEIL2aEYWoaw3gN6kWnpCy2M6X8Epg2qE=;
 b=S+KBjcPev1sRTGpZfI+0cQpXUO51PldyvoRxcLEpaijv8RPIsTwGT+AtBll673aIp6A/p+Pcil6id23O/o2zHN96c4yllIxIVUx1aWeInQkB0EW7a9tn1OGBTkYDeie9Exa7IH7Bs37sO9PSCwmHn0fOFhjTfnqx3Z2U47jbRIM=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4704.eurprd08.prod.outlook.com (10.255.115.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Tue, 15 Oct 2019 08:55:20 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:55:20 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
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
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
Subject: Re: [PATCH v4 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Topic: [PATCH v4 2/4] drm/komeda: Add drm_lut_to_fgamma_coeffs()
Thread-Index: AQHVgv3GI0L46yKgNUGru0epkUV1d6dbX3IAgAAHFAA=
Date:   Tue, 15 Oct 2019 08:55:19 +0000
Message-ID: <20191015085512.GA1624@jamwan02-TSP300>
References: <20191015021016.327-1-james.qian.wang@arm.com>
 <20191015021016.327-3-james.qian.wang@arm.com>
 <20191015082951.daxl5wpyt4h7xshh@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191015082951.daxl5wpyt4h7xshh@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::21) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 99b4611c-3035-49ef-f8e8-08d7514d71bf
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4704:|VE1PR08MB4704:|VI1PR0801MB1936:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB19363CE3A917F4950448B56AB3930@VI1PR0801MB1936.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:3968;
x-forefront-prvs: 01917B1794
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(39860400002)(396003)(346002)(136003)(366004)(199004)(189003)(478600001)(9686003)(6512007)(33656002)(486006)(256004)(54906003)(99286004)(6246003)(2906002)(7736002)(305945005)(76176011)(4326008)(52116002)(14444005)(25786009)(3846002)(6116002)(6486002)(6436002)(229853002)(71200400001)(26005)(6862004)(14454004)(186003)(71190400001)(102836004)(55236004)(1076003)(6506007)(386003)(8936002)(446003)(8676002)(81156014)(81166006)(58126008)(316002)(33716001)(6636002)(66476007)(66556008)(66446008)(66946007)(64756008)(11346002)(476003)(66066001)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4704;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JDdtVg14Td13O31QvmpNm9KylxbaIT3kmlparakc/f6tb0a59fCooW6X+/6gdk5VP08dBJHqB55wFqZ39YZw7NewghMOCyUxqM2YxbtxJlxEx1oUfG1pCf1R9ZqSFMpq9/GPxaBdDEKiR3yel415QF7nQCuwj504J9AraWg+/B4FqA8mbz7QxA9m8tjMqw3SZ6zCqqzro4vZ5bvDxcQnnlhwby9r3W7hGbl8dqAk2QX+b28zU8tiqvbYuPHxOQF2TJsjrck+lpgCyQXJMflQNor3Y5T+WMBt7sSOftiuL1Bucu+P10fQ6Twk1k7+uoB6ww1SGYBvKLXLprt+eSd8bFQKHfmeBCAob7d1c+JAtvYvj8JhXMLCdSkwIXWe9/PdsRc0r309tNR+u5HWhMl/nwGOyZjDZpzLcjEE4wgz1ls=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EBD8AD90D1CEB4D905F480A8778721B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4704
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(346002)(39860400002)(376002)(396003)(199004)(189003)(7736002)(102836004)(33656002)(76176011)(386003)(70586007)(70206006)(86362001)(229853002)(22756006)(6636002)(6506007)(6246003)(305945005)(76130400001)(23726003)(6116002)(3846002)(46406003)(26005)(186003)(58126008)(316002)(33716001)(8676002)(36906005)(47776003)(50466002)(54906003)(1076003)(6486002)(8746002)(66066001)(14454004)(81166006)(81156014)(5660300002)(6512007)(26826003)(99286004)(8936002)(478600001)(9686003)(14444005)(25786009)(4326008)(63350400001)(476003)(356004)(11346002)(126002)(446003)(97756001)(2906002)(6862004)(336012)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1936;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 64064b69-d978-46fc-e860-08d7514d67fd
NoDisclaimer: True
X-Forefront-PRVS: 01917B1794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwe1CT2mqO4Mt7VXvUkgpVTlnbFzgxtNuZRrruj08K5inPJAb3UlWYAKRKEzO2+pqnO+od/Rg1a2m8sxeQpGcIaspP7ZMW1f31687K05ElsoBuu1s2lMZnwV0fp+Ik/z7huAFXvBcFVajhNzQe1xSR6V8h1Jm394wvguw8S6G922qbKaAY1UC5SJs0Kh6YCssdC+cLrDkLogr2iJL9uwnLVN4wYwh2Z5/+GbG8vu5eZeiI2t2avdgOfE59Kh3cBy4WPopBgDEl5Zk7CB8FiQXyVoAx4Q6Y1WdFW0/auyFWete5WsszHdsXNU+TXC6vCqcz4v0UFs/VPByUz8C9uHcxvt/6JgNSBJSTmHeMDxNYP7m3YoEhnQ76kgpL9e8x6ByswJ3yeXf/DLU5FitIKNokJngdv5cTtvtrq6MbeKwBw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 08:55:35.7881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b4611c-3035-49ef-f8e8-08d7514d71bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 08:29:52AM +0000, Brian Starkey wrote:
> Hi James,
>=20
> On Tue, Oct 15, 2019 at 02:10:53AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > This function is used to convert drm 3dlut to komeda HW required 1d cur=
ve
>=20
> This is a 1D LUT, not a 3D LUT
>

Thank you Brian will correct it in the next version.

James

> Cheers,
> -Brian
>=20
> > coeffs values.
> >=20
> > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  .../arm/display/komeda/komeda_color_mgmt.c    | 52 +++++++++++++++++++
> >  .../arm/display/komeda/komeda_color_mgmt.h    |  9 +++-
> >  2 files changed, 60 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > index 9d14a92dbb17..c180ce70c26c 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> > @@ -65,3 +65,55 @@ const s32 *komeda_select_yuv2rgb_coeffs(u32 color_en=
coding, u32 color_range)
> > =20
> >  	return coeffs;
> >  }
> > +
> > +struct gamma_curve_sector {
> > +	u32 boundary_start;
> > +	u32 num_of_segments;
> > +	u32 segment_width;
> > +};
> > +
> > +struct gamma_curve_segment {
> > +	u32 start;
> > +	u32 end;
> > +};
> > +
> > +static struct gamma_curve_sector sector_tbl[] =3D {
> > +	{ 0,    4,  4   },
> > +	{ 16,   4,  4   },
> > +	{ 32,   4,  8   },
> > +	{ 64,   4,  16  },
> > +	{ 128,  4,  32  },
> > +	{ 256,  4,  64  },
> > +	{ 512,  16, 32  },
> > +	{ 1024, 24, 128 },
> > +};
> > +
> > +static void
> > +drm_lut_to_coeffs(struct drm_property_blob *lut_blob, u32 *coeffs,
> > +		  struct gamma_curve_sector *sector_tbl, u32 num_sectors)
> > +{
> > +	struct drm_color_lut *lut;
> > +	u32 i, j, in, num =3D 0;
> > +
> > +	if (!lut_blob)
> > +		return;
> > +
> > +	lut =3D lut_blob->data;
> > +
> > +	for (i =3D 0; i < num_sectors; i++) {
> > +		for (j =3D 0; j < sector_tbl[i].num_of_segments; j++) {
> > +			in =3D sector_tbl[i].boundary_start +
> > +			     j * sector_tbl[i].segment_width;
> > +
> > +			coeffs[num++] =3D drm_color_lut_extract(lut[in].red,
> > +						KOMEDA_COLOR_PRECISION);
> > +		}
> > +	}
> > +
> > +	coeffs[num] =3D BIT(KOMEDA_COLOR_PRECISION);
> > +}
> > +
> > +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 =
*coeffs)
> > +{
> > +	drm_lut_to_coeffs(lut_blob, coeffs, sector_tbl, ARRAY_SIZE(sector_tbl=
));
> > +}
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/d=
rivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > index a2df218f58e7..08ab69281648 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> > @@ -11,7 +11,14 @@
> >  #include <drm/drm_color_mgmt.h>
> > =20
> >  #define KOMEDA_N_YUV2RGB_COEFFS		12
> > +#define KOMEDA_N_RGB2YUV_COEFFS		12
> > +#define KOMEDA_COLOR_PRECISION		12
> > +#define KOMEDA_N_GAMMA_COEFFS		65
> > +#define KOMEDA_COLOR_LUT_SIZE		BIT(KOMEDA_COLOR_PRECISION)
> > +#define KOMEDA_N_CTM_COEFFS		9
> > +
> > +void drm_lut_to_fgamma_coeffs(struct drm_property_blob *lut_blob, u32 =
*coeffs);
> > =20
> >  const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_=
range);
> > =20
> > -#endif
> > +#endif /*_KOMEDA_COLOR_MGMT_H_*/
> > --=20
> > 2.20.1
> >=20
