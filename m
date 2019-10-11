Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804D9C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456B2206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Y9BTc5gn";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Y9BTc5gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfJKK1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:27:33 -0400
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:47133
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfJKK1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRH/Vo7PHh+Mj/xV0P+N1GoX5oDFaK1F4F1qNakJvjc=;
 b=Y9BTc5gn4jYu5D3B3GVHHNjUDWpCL8jrT9a2+V+KkXbpn4ctMuQ8P2Q82udEzqzRjSbQLWWPKACAEbQENdC/PO8lqcRcS88szomDSmER4K3UeH4KOe+ZGaV+4fcznhQyIDO2EhrfZwmGz4tZJ3ATYnSrSZv3JrXyYN+WwE39KUo=
Received: from VI1PR08CA0197.eurprd08.prod.outlook.com (2603:10a6:800:d2::27)
 by HE1PR08MB2843.eurprd08.prod.outlook.com (2603:10a6:7:37::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.25; Fri, 11 Oct
 2019 10:27:25 +0000
Received: from DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR08CA0197.outlook.office365.com
 (2603:10a6:800:d2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Fri, 11 Oct 2019 10:27:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT009.mail.protection.outlook.com (10.152.20.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 10:27:22 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Fri, 11 Oct 2019 10:27:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 952d77da221d4a59
X-CR-MTA-TID: 64aa7808
Received: from 2de4edb3fe02.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D3F7BC72-3023-4573-8C60-0964E706F96D.1;
        Fri, 11 Oct 2019 10:27:09 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2de4edb3fe02.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2019 10:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBuyrxfDx1xOP+TYTHbGib7zeXKYHyUa5ZTAedeaReTQ858we9MCI5MvCz0aMpVY6hBKC/CWxRueomZt0rBBr/2lwLo2OF8vmC2JkPlQUyxvjsmCwMNvh8AAtNYjf2jhkR7jEY72D9KeyNBK2pix+u3/Cf4ThmvVkk8KjG5dIgiZ68BP4q/0thsC8EIb52dDSswP9oJ9zwai2Rc1KCjLC6+vsrdgeGOLA4BSjv9llHiNygeNl5Bdt0BhXTjYWGS2zTFR4jgsrap4XsRLu8JJIWrl77Mwj3jBvcs590KMF20/lQBdP8/KScejkWO6a/tYdlxYZqnMfFl6lwiVCIMBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRH/Vo7PHh+Mj/xV0P+N1GoX5oDFaK1F4F1qNakJvjc=;
 b=fVxRZoCQd2XjxvrKGru5usLKBTWu+4LpI1Xs75crsro0H7pcz2TRXRVbBAojLSbAC92nErNO/Cw9gmwW03udaVkq03xU4e68KNCZvOVIo9IhgnRJAz6OjEKwgTx0pFzeoUUDgMYralm5jkfCiGA3MinFLJkcD2GB/If40PANBUeEvyYmB7//UAGdtjzgisviF6cD0HfmNjUK3i5N/u2HjBJXayvrLPWoP9ebGQFktOSKdRnutXWnQ/ilWw8LZrKKXwa40xgkvzP4qO6uVsC2O7U9gq61eFXs5zYQv53WraO7npyb27dGLfjUDk+Lwqn+4npcjDgeF8kmYHreHdV9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRH/Vo7PHh+Mj/xV0P+N1GoX5oDFaK1F4F1qNakJvjc=;
 b=Y9BTc5gn4jYu5D3B3GVHHNjUDWpCL8jrT9a2+V+KkXbpn4ctMuQ8P2Q82udEzqzRjSbQLWWPKACAEbQENdC/PO8lqcRcS88szomDSmER4K3UeH4KOe+ZGaV+4fcznhQyIDO2EhrfZwmGz4tZJ3ATYnSrSZv3JrXyYN+WwE39KUo=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4381.eurprd08.prod.outlook.com (20.179.28.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 10:27:06 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 10:27:06 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform support
 for DOU-IPS
Thread-Topic: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform
 support for DOU-IPS
Thread-Index: AQHVf/cp1ECrFKcx7E6lw4dO6fyhYKdVM6+AgAAFQ4CAAAPyAA==
Date:   Fri, 11 Oct 2019 10:27:06 +0000
Message-ID: <2088952.DRTgVpPakT@e123338-lin>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
 <8416585.jh9292Gg6g@e123338-lin>
 <20191011101244.GA13428@lowli01-ThinkStation-P300>
In-Reply-To: <20191011101244.GA13428@lowli01-ThinkStation-P300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::20) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f9cba568-3d7f-44a1-bba8-08d74e359a9c
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4381:|VI1PR08MB4381:|HE1PR08MB2843:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2843D2366AAB5C1CD76188478F970@HE1PR08MB2843.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(25786009)(76176011)(229853002)(6486002)(9686003)(8936002)(6512007)(99286004)(8676002)(54906003)(81166006)(6636002)(6116002)(3846002)(81156014)(446003)(11346002)(476003)(52116002)(486006)(6436002)(33716001)(102836004)(71200400001)(186003)(7736002)(26005)(6506007)(386003)(2906002)(4326008)(6246003)(66066001)(71190400001)(256004)(316002)(14454004)(5660300002)(14444005)(6862004)(66476007)(66446008)(86362001)(66946007)(478600001)(66556008)(305945005)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4381;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7xeH9raUzYrykU2cgAKXuolDB1g9H+wwbbmGpyyJKzJTC5h3bTOhD+Y+fWPyp4vy9DzCErsvUhsOx7Ct7n7e8g7RUllQArTGV8XBvVcvxNgDg+dX6n9JJq1dR22IBs/a0FHShwHZ/dnDrjnf0bWIGM24/Wr51TNnYjwQcH8+tjfBMm2XdrrAF8doNRBqQudTOOxPCBEItC4ZsnI/uN5GFFg7zQJ/mflBDoA8LSSpbpjeDG7jYSoN2j40Zv6E/fPPSIyHArKJ3rLYnDgGRBbhV0cSXxNztdinD0WvI12s1nwfVprtEoBZ1MGO/47FW+HhHEvISC6VbtmG5/ELYyt8zljBB06KAXiVT4xYdq2ny4ipK7cDRUN8nOcm9p8cvkO54m+C2HfQuI4GzCNb2Apg2kRlbJRf9aUs6pjOOUkin4o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <689BC901C64D9345B9BF7D5EBDE95279@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4381
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(26826003)(86362001)(33716001)(46406003)(14454004)(47776003)(6116002)(66066001)(23726003)(478600001)(3846002)(25786009)(70206006)(356004)(22756006)(70586007)(2906002)(50466002)(76176011)(386003)(6486002)(5660300002)(14444005)(76130400001)(336012)(63350400001)(26005)(6506007)(8746002)(81156014)(11346002)(97756001)(99286004)(486006)(229853002)(186003)(446003)(126002)(316002)(54906003)(102836004)(4326008)(6636002)(305945005)(7736002)(6512007)(8676002)(476003)(9686003)(6246003)(81166006)(8936002)(6862004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR08MB2843;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e3ef8dc9-a32f-4d5e-e7c9-08d74e359087
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06WFf47ZJoprBZ0xf4oDHeiD+qL2Va1EOg53ESj5AWfFSALB3ah1UOpJBnFm4Wk9Cb54Wa6HsIfgKWEwdiyj3TlqHtP0pRMmKgejle9ZL6XMKIKf9aT21N/mbzXJwMoosCyu6Fi/p9hRGL3/56W5vYoY1UUSWPiAWbrZnjykwDohxhMCxpqNk8MJCsY5IOVaXf+LBWOdZinsQK2cC34lajOJa04UZJR7oQcOOr7p/unZYaJtV/Sw834AxaHgRY5astcYuCDGZ5U0efEpuM525C5+ftrtk6eZ/jPdFqsZmynID9B/kC2ilpdL0mfwuq1ax0dcoygoQiVJVaNYyg4c5LYSoIj8AeYOfIA5QLnUqBuQw+ELq1oJVYKAdkw7ONtRvm1lXyi2mdGeoGdttc9JxiJhMjMbahmQUx/9mq33r5s=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 10:27:22.9249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cba568-3d7f-44a1-bba8-08d74e359a9c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2843
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 11 October 2019 11:12:51 BST Lowry Li (Arm Technology China) wro=
te:
> Hi Mihail,
> On Fri, Oct 11, 2019 at 08:54:03AM +0000, Mihail Atanassov wrote:
> > Hi James, Lowry,
> >=20
> > On Friday, 11 October 2019 06:45:50 BST james qian wang (Arm Technology=
 China) wrote:
> > > From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> > >=20
> > > Adds gamma and color-transform support for DOU-IPS.
> > > Adds two caps members fgamma_coeffs and ctm_coeffs to komeda_improc_s=
tate.
> > > If color management changed, set gamma and color-transform accordingl=
y.
> > >=20
> > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > ---
> > >  .../arm/display/komeda/d71/d71_component.c    | 24 +++++++++++++++++=
++
> > >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
> > >  .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
> > >  .../display/komeda/komeda_pipeline_state.c    |  6 +++++
> > >  4 files changed, 35 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b=
/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > index c3d29c0b051b..e7e5a8e4430e 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > @@ -942,15 +942,39 @@ static int d71_merger_init(struct d71_dev *d71,
> > >  static void d71_improc_update(struct komeda_component *c,
> > >  			      struct komeda_component_state *state)
> > >  {
> > > +	struct drm_crtc_state *crtc_st =3D state->crtc->state;
> > I'm not sure it's a good idea to introduce a dependency on drm state
> > so far down in the HW funcs, is there a good reason for the direct prod=
?
> We dicussed about this before. To decide using this way is to avoid of
> duplicated state between DRM and Komeda.
Fair, r-b me.

>=20
> Regards,
> Lowry
> > >  	struct komeda_improc_state *st =3D to_improc_st(state);
> > > +	struct d71_pipeline *pipe =3D to_d71_pipeline(c->pipeline);
> > >  	u32 __iomem *reg =3D c->reg;
> > >  	u32 index;
> > > +	u32 mask =3D 0, ctrl =3D 0;
> > > =20
> > >  	for_each_changed_input(state, index)
> > >  		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
> > >  			       to_d71_input_id(state, index));
> > > =20
> > >  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> > > +
> > > +	if (crtc_st->color_mgmt_changed) {
> > > +		mask |=3D IPS_CTRL_FT | IPS_CTRL_RGB;
> > > +
> > > +		if (crtc_st->gamma_lut) {
> > > +			malidp_write_group(pipe->dou_ft_coeff_addr, FT_COEFF0,
> > > +					   KOMEDA_N_GAMMA_COEFFS,
> > > +					   st->fgamma_coeffs);
> > > +			ctrl |=3D IPS_CTRL_FT; /* enable gamma */
> > > +		}
> > > +
> > > +		if (crtc_st->ctm) {
> > > +			malidp_write_group(reg, IPS_RGB_RGB_COEFF0,
> > > +					   KOMEDA_N_CTM_COEFFS,
> > > +					   st->ctm_coeffs);
> > > +			ctrl |=3D IPS_CTRL_RGB; /* enable gamut */
> > > +		}
> > > +	}
> > > +
> > > +	if (mask)
> > > +		malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
> > >  }
> > > =20
> > >  static void d71_improc_dump(struct komeda_component *c, struct seq_f=
ile *sf)
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > index 9beeda04818b..406b9d0ca058 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > @@ -590,6 +590,8 @@ static int komeda_crtc_add(struct komeda_kms_dev =
*kms,
> > > =20
> > >  	crtc->port =3D kcrtc->master->of_output_port;
> > > =20
> > > +	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
> > > +
> > >  	return err;
> > >  }
> > > =20
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > index b322f52ba8f2..c5ab8096c85d 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > @@ -11,6 +11,7 @@
> > >  #include <drm/drm_atomic.h>
> > >  #include <drm/drm_atomic_helper.h>
> > >  #include "malidp_utils.h"
> > > +#include "komeda_color_mgmt.h"
> > > =20
> > >  #define KOMEDA_MAX_PIPELINES		2
> > >  #define KOMEDA_PIPELINE_MAX_LAYERS	4
> > > @@ -324,6 +325,8 @@ struct komeda_improc {
> > >  struct komeda_improc_state {
> > >  	struct komeda_component_state base;
> > >  	u16 hsize, vsize;
> > > +	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
> > > +	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
> > >  };
> > > =20
> > >  /* display timing controller */
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state=
.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > index 0ba9c6aa3708..4a40b37eb1a6 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > @@ -756,6 +756,12 @@ komeda_improc_validate(struct komeda_improc *imp=
roc,
> > >  	st->hsize =3D dflow->in_w;
> > >  	st->vsize =3D dflow->in_h;
> > > =20
> > > +	if (kcrtc_st->base.color_mgmt_changed) {
> > > +		drm_lut_to_fgamma_coeffs(kcrtc_st->base.gamma_lut,
> > > +					 st->fgamma_coeffs);
> > > +		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
> > > +	}
> > > +
> > >  	komeda_component_add_input(&st->base, &dflow->input, 0);
> > >  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> > > =20
> > >=20
> >=20
> >=20
>=20


--=20
Mihail



