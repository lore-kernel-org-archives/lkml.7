Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADCBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C84E21D7B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AeZlrSXf";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AeZlrSXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfKSInH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:43:07 -0500
Received: from mail-eopbgr150057.outbound.protection.outlook.com ([40.107.15.57]:30084
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSInH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi39CFSi4gEgoxjO3SORQRsqTQhzOvLnHb44nCAXsoI=;
 b=AeZlrSXfsKj1UHY+IlFPd8YqIy+jS5GA2KSetrB7YAapJ6pRnu6fjGkbGyfgHfpSX8XlXBILj5Uh3I6/cExvIVL5yTrqzM97LabafTcXlFClRsTZ5K5v5/h4c/tH/HyK+Pl5HjMYIGdYHrc3ISEOjivbpx4EanoL0kYdhJ+FHLo=
Received: from VI1PR08CA0245.eurprd08.prod.outlook.com (2603:10a6:803:dc::18)
 by VE1PR08MB5133.eurprd08.prod.outlook.com (2603:10a6:803:109::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Tue, 19 Nov
 2019 08:43:00 +0000
Received: from AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by VI1PR08CA0245.outlook.office365.com
 (2603:10a6:803:dc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16 via Frontend
 Transport; Tue, 19 Nov 2019 08:43:00 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT053.mail.protection.outlook.com (10.152.16.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 08:42:59 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Tue, 19 Nov 2019 08:42:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cbfe80840a45da1e
X-CR-MTA-TID: 64aa7808
Received: from baa6478d223f.2 (cr-mta-lb-1.cr-mta-net [104.47.5.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A5A7B38F-E022-43B5-B0E7-F445E28A276F.1;
        Tue, 19 Nov 2019 08:42:54 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id baa6478d223f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 19 Nov 2019 08:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBiapNBBR0wMaQ5Vpo5Q6ww1QoMgKpap5r8GIu5ac8CvFxPgaR2fU+9atoV+lHSdqW6huHcyo/OI84Rf6J3Jnq0M0/6M7uhZ3AhWsiOcAau7+LJOmFsPx60l2pZCic5kVgJb9Z84xu6dumNXT59BThIfitXITNmvqMqfjo/IPJD+kALuXpxOismkOBkBfMuUJ4an0y0AFMUXRrgpnenQ6gRLtihqNcE8GgxhIKbiIWV7+NK0BxxibGVaRNJSIr9bU6Jy31X9OHN5s/qdaBCLk9WGiUVqDgldpKqR2MjMwnqgML5LraYRnAwvOPmXRBgGGXvL1s8PGVW2kG68ooWLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi39CFSi4gEgoxjO3SORQRsqTQhzOvLnHb44nCAXsoI=;
 b=hd8acnM+9hzFqwL9dpD2e9EytWwth3fuTbFbge6ycFgO8lSNmYey6wIpMtOp1u7ljXIKcs9VmA6uC6Uh/0ESMVdo18tiWh6nAyT0bxySsvkhz0rEQXBLbniarezjMy00LupfSbZ2ML1mU3oqIfy0NVlH+6XyYvsGgJEUc3+X0WfeLBgitiPpSw8p2oG4TjQBs4QZkLL4j2Kz6z5A0rLufCLGzOnSlwmyhfZw8PluC+73/qMFzlFRfDjeeLgA3lxEPc7pfjw+jmJF6ukuMecWIeT3KJo0Udg9AmWuocOgS8j6lD9W7aBOfS9erZP/BEbW41ugTyWbzCcEwLb7RH2Kgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi39CFSi4gEgoxjO3SORQRsqTQhzOvLnHb44nCAXsoI=;
 b=AeZlrSXfsKj1UHY+IlFPd8YqIy+jS5GA2KSetrB7YAapJ6pRnu6fjGkbGyfgHfpSX8XlXBILj5Uh3I6/cExvIVL5yTrqzM97LabafTcXlFClRsTZ5K5v5/h4c/tH/HyK+Pl5HjMYIGdYHrc3ISEOjivbpx4EanoL0kYdhJ+FHLo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5216.eurprd08.prod.outlook.com (10.255.159.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 08:42:51 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 08:42:51 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v3 2/6] drm/komeda: Add side by side plane_state split
Thread-Topic: [PATCH v3 2/6] drm/komeda: Add side by side plane_state split
Thread-Index: AQHVmsbB0qq5bjF9AkuUGZwZ2Z2ZN6eLWbKAgAbbYIA=
Date:   Tue, 19 Nov 2019 08:42:51 +0000
Message-ID: <20191119084244.GB2881@jamwan02-TSP300>
References: <20191114083658.27237-1-james.qian.wang@arm.com>
 <20191114083658.27237-3-james.qian.wang@arm.com>
 <2843645.837eivR4I8@e123338-lin>
In-Reply-To: <2843645.837eivR4I8@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56b15952-2ce2-4a52-41a9-08d76ccc7ba9
X-MS-TrafficTypeDiagnostic: VE1PR08MB5216:|VE1PR08MB5216:|VE1PR08MB5133:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB51334E4507BDB7426EDC4380B34C0@VE1PR08MB5133.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:1227;OLM:1227;
x-forefront-prvs: 022649CC2C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(71200400001)(229853002)(71190400001)(1076003)(6246003)(66066001)(33656002)(30864003)(6486002)(6636002)(6512007)(9686003)(5660300002)(6862004)(55236004)(6436002)(4326008)(6506007)(102836004)(26005)(256004)(386003)(52116002)(76176011)(14444005)(99286004)(25786009)(186003)(81166006)(81156014)(8676002)(8936002)(66946007)(33716001)(11346002)(446003)(316002)(54906003)(486006)(2906002)(66446008)(64756008)(478600001)(66556008)(66476007)(476003)(6116002)(58126008)(86362001)(7736002)(305945005)(14454004)(3846002)(87944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5216;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lTMj2WKWO3ULNOBPDAlFyQQFkdhusVTnouWH66bkSlYCWm0yfrFmUC9xBpUbsq6pOKvUWRTAs/Mx/sDJwpy+JiMkhHK+wE5DK9ggwPNk1chuh/mCMFlLYKFqItEOrd89S9+wo1+hourvgm2u1HWLbxrrt1Xs9jvydugdEK9aNTjidJr3HeC9GwUcZ4RwnRUh2SltQLCFY8FitnBMujxBrS1xiV3UDCTK1JDSkk5D58tf41towPU4eO+hYLuun3h33vtl9OK1hYNjo/bJFYo/BrQl7KXEcKMiTLhd+egYpD1T1DtWU1PfvvceyPkkKtXxPemiDCZmvsRz8dWxsYiQNwa6qKEAdAkanTN+uODA3O9CwUVdfXnhEgT/VXtb/jEoN0Z1ZolovouaKK39i95nSIbZHgUP8ik4fX7MaLMLbtuYJreOmnYBLYM8XaNzmEFk
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9B20FD6F0F3734BB13520871B087DD4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5216
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(136003)(396003)(39860400002)(1110001)(339900001)(199004)(189003)(50466002)(6636002)(316002)(36906005)(25786009)(58126008)(54906003)(356004)(33656002)(22756006)(3846002)(6116002)(23726003)(47776003)(66066001)(33716001)(14454004)(26826003)(478600001)(105606002)(46406003)(81166006)(76176011)(99286004)(4326008)(1076003)(30864003)(81156014)(86362001)(6512007)(6486002)(2906002)(11346002)(476003)(386003)(6246003)(486006)(446003)(229853002)(126002)(6506007)(70206006)(26005)(186003)(9686003)(6862004)(76130400001)(7736002)(305945005)(97756001)(8676002)(102836004)(14444005)(8936002)(336012)(8746002)(5660300002)(70586007)(87944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5133;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d5c9ea02-26f2-4709-5d4e-08d76ccc7641
NoDisclaimer: True
X-Forefront-PRVS: 022649CC2C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WO3BfQw37+BV6Hux/RiHyKYI5EBXQdvtuXmNlIGiST/ciCueQvrNPLYMU936EXEbuMFHNq1SZKvpYKTuBlQSq096fAv5fojy25gGhmTudBcyF/Lvo33G9TR8J33EkkJQlveszCQm6u7p8H/kBNBBEtYlTSzc/kHD0hufc6dN1fgX+D+ppjp58h+Qhb3uOQjdzNBhuJI2pF26nBoiZQWrrFV81rN95HPwzyPFF1QFmRErIFztfIZhVHgEXimU/4R//KaZp+y8yVEot5o/pR623iMBXbnfxCMnOKf0/r59KIAabMb/hlsGkyAfNRkIgl7bAAoCbUHwAgiVYwsty5oEeeB2MhdPN9Hw26aeJ0ergQGjB6YcOH6n8U+wfOSl382Zm6WwL4Fl/jOjBTulDk272ZRca0ZuThGs8gAwiKXsqoi0Mg0UyWIlpVqfkMILdmk
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 08:42:59.8901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b15952-2ce2-4a52-41a9-08d76ccc7ba9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 12:00:01AM +0000, Mihail Atanassov wrote:
> On Thursday, 14 November 2019 08:37:31 GMT james qian wang (Arm Technolog=
y China) wrote:
> > On side by side mode, The full display frame will be split into two par=
ts
> > (Left/Right), and each part will be handled by a single pipeline separa=
tely
> > master pipeline for left part, slave for right.
> >=20
> > To simplify the usage and implementation, komeda use the following sche=
me
> > to do the side by side split
> > 1. The planes also have been grouped into two classes:
> >    master-planes and slave-planes.
> > 2. The master plane can display its image on any location of the final/=
full
> >    display frame, komeda will help to split the plane configuration to =
two
> >    parts and fed them into master and slave pipelines.
> > 3. The slave plane only can put its display rect on the right part of t=
he
> >    final display frame, and its data is only can be fed into the slave
> >    pipeline.
> >=20
> > From the perspective of resource usage and assignment:
> > The master plane can use the resources from the master pipeline and sla=
ve
> > pipeline both, but slave plane only can use the slave pipeline resource=
s.
> >=20
> > With such scheme, the usage of master planes are same as the none
> > side_by_side mode. user can easily skip the slave planes and no need to
> > consider side_by_side for them.
> >=20
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |  33 ++-
> >  .../display/komeda/komeda_pipeline_state.c    | 188 ++++++++++++++++++
> >  .../gpu/drm/arm/display/komeda/komeda_plane.c |   7 +-
> >  3 files changed, 220 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index 20a076cce635..4c0946fbaac1 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -521,6 +521,20 @@ komeda_component_pickup_output(struct komeda_compo=
nent *c, u32 avail_comps)
> >  	return komeda_pipeline_get_first_component(c->pipeline, avail_inputs)=
;
> >  }
> > =20
> > +static inline const char *
> > +komeda_data_flow_msg(struct komeda_data_flow_cfg *config)
> > +{
> > +	static char str[128];
> > +
> > +	snprintf(str, sizeof(str),
> > +		 "rot: %x src[x/y:%d/%d, w/h:%d/%d] disp[x/y:%d/%d, w/h:%d/%d]",
> > +		 config->rot,
> > +		 config->in_x, config->in_y, config->in_w, config->in_h,
> > +		 config->out_x, config->out_y, config->out_w, config->out_h);
> > +
> > +	return str;
> > +}
> > +
> >  struct komeda_plane_state;
> >  struct komeda_crtc_state;
> >  struct komeda_crtc;
> > @@ -532,22 +546,27 @@ int komeda_build_layer_data_flow(struct komeda_la=
yer *layer,
> >  				 struct komeda_plane_state *kplane_st,
> >  				 struct komeda_crtc_state *kcrtc_st,
> >  				 struct komeda_data_flow_cfg *dflow);
> > -int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
> > -			      struct drm_connector_state *conn_st,
> > -			      struct komeda_crtc_state *kcrtc_st,
> > -			      struct komeda_data_flow_cfg *dflow);
> > -int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
> > -				   struct komeda_crtc_state *kcrtc_st);
> > -
> >  int komeda_build_layer_split_data_flow(struct komeda_layer *left,
> >  				       struct komeda_plane_state *kplane_st,
> >  				       struct komeda_crtc_state *kcrtc_st,
> >  				       struct komeda_data_flow_cfg *dflow);
> > +int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
> > +				     struct komeda_plane_state *kplane_st,
> > +				     struct komeda_crtc_state *kcrtc_st,
> > +				     struct komeda_data_flow_cfg *dflow);
> > +
> > +int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
> > +			      struct drm_connector_state *conn_st,
> > +			      struct komeda_crtc_state *kcrtc_st,
> > +			      struct komeda_data_flow_cfg *dflow);
> >  int komeda_build_wb_split_data_flow(struct komeda_layer *wb_layer,
> >  				    struct drm_connector_state *conn_st,
> >  				    struct komeda_crtc_state *kcrtc_st,
> >  				    struct komeda_data_flow_cfg *dflow);
> > =20
> > +int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
> > +				   struct komeda_crtc_state *kcrtc_st);
> > +
> >  int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
> >  				       struct komeda_crtc_state *kcrtc_st);
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index 0930234abb9d..5de0d231a1c3 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -1130,6 +1130,194 @@ int komeda_build_layer_split_data_flow(struct k=
omeda_layer *left,
> >  	return err;
> >  }
> > =20
> > +/* split func will split configuration of master plane to two layer da=
ta
> > + * flows, which will be fed into master and slave pipeline then.
> > + * NOTE: @m_dflow is first used as input argument to pass the configur=
ation of
> > + *	 master_plane. when the split is done, @*m_dflow @*s_dflow are the
> > + *	 output data flow for pipeline.
> > + */
> > +static int
> > +komeda_split_sbs_master_data_flow(struct komeda_crtc_state *kcrtc_st,
> > +				  struct komeda_data_flow_cfg **m_dflow,
> > +				  struct komeda_data_flow_cfg **s_dflow)
> > +{
> > +	struct komeda_data_flow_cfg *master =3D *m_dflow;
> > +	struct komeda_data_flow_cfg *slave =3D *s_dflow;
> > +	u32 disp_end =3D master->out_x + master->out_w;
> > +	u16 boundary;
> > +
> > +	pipeline_composition_size(kcrtc_st, &boundary, NULL);
> > +
> > +	if (disp_end <=3D boundary) {
> > +		/* the master viewport only located in master side, no need
> > +		 * slave anymore
> > +		 */
> > +		*s_dflow =3D NULL;
> > +	} else if ((master->out_x < boundary) && (disp_end > boundary)) {
> > +		/* the master viewport across two pipelines, split it */
> > +		bool flip_h =3D has_flip_h(master->rot);
> > +		bool r90  =3D drm_rotation_90_or_270(master->rot);
> > +		u32 src_x =3D master->in_x;
> > +		u32 src_y =3D master->in_y;
> > +		u32 src_w =3D master->in_w;
> > +		u32 src_h =3D master->in_h;
> > +
> > +		if (master->en_scaling || master->en_img_enhancement) {
> > +			DRM_DEBUG_ATOMIC("sbs doesn't support to split a scaling image.\n")=
;
> > +			return -EINVAL;
> > +		}
> > +
> > +		memcpy(slave, master, sizeof(*master));
> > +
> > +		/* master for left part of display, slave for the right part */
> > +		/* split the disp_rect */
> > +		master->out_w =3D boundary - master->out_x;
> > +		slave->out_w  =3D disp_end - boundary;
> > +		slave->out_x  =3D 0;
> > +
> > +		if (r90) {
> > +			master->in_h =3D master->out_w;
> > +			slave->in_h =3D slave->out_w;
> > +
> > +			if (flip_h)
> > +				master->in_y =3D src_y + src_h - master->in_h;
> > +			else
> > +				slave->in_y =3D src_y + src_h - slave->in_h;
> > +		} else {
> > +			master->in_w =3D master->out_w;
> > +			slave->in_w =3D slave->out_w;
> > +
> > +			/* on flip_h, the left display content from the right-source */
> > +			if (flip_h)
> > +				master->in_x =3D src_w + src_x - master->in_w;
> > +			else
> > +				slave->in_x =3D src_w + src_x - slave->in_w;
>=20
> It really bugs me that the order here is w/x/w but in the block above
> it's y/h/h.

will refine the order to x/w/w.

> > +		}
> > +	} else if (master->out_x >=3D boundary) {
> > +		/* disp_rect only locate in right part, move the dflow to slave */
> > +		master->out_x -=3D boundary;
> > +		*s_dflow =3D master;
> > +		*m_dflow =3D NULL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +komeda_split_sbs_slave_data_flow(struct komeda_crtc_state *kcrtc_st,
> > +				 struct komeda_data_flow_cfg *slave)
> > +{
> > +	u16 boundary;
> > +
> > +	pipeline_composition_size(kcrtc_st, &boundary, NULL);
> > +
> > +	if (slave->out_x < boundary) {
> > +		DRM_DEBUG_ATOMIC("SBS Slave plane is only allowed to configure the r=
ight part frame.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* slave->disp_rect locate in the right part */
> > +	slave->out_x -=3D boundary;
> > +
> > +	return 0;
> > +}
> > +
> > +/* On side by side mode, The full display frame will be split to two p=
arts
> > + * (Left/Right), and each part will be handled by a single pipeline se=
parately,
> > + * master pipeline for left part, slave for right.
> > + *
> > + * To simplify the usage and implementation, komeda use the following =
scheme
> > + * to do the side by side split
> > + * 1. The planes also have been grouped into two classes:
> > + *    master-planes and slave-planes.
> > + * 2. The master plane can display its image on any location of the fi=
nal/full
> > + *    display frame, komeda will help to split the plane configuration=
 to two
> > + *    parts and fed them into master and slave pipelines.
> > + * 3. The slave plane only can put its display rect on the right part =
of the
> > + *    final display frame, and its data is only can be fed into the sl=
ave
> > + *    pipeline.
> > + *
> > + * From the perspective of resource usage and assignment:
> > + * The master plane can use the resources from the master pipeline and=
 slave
> > + * pipeline both, but slave plane only can use the slave pipeline reso=
urces.
> > + *
> > + * With such scheme, the usage of master planes are same as the none
> > + * side_by_side mode. user can easily skip the slave planes and no nee=
d to
> > + * consider side_by_side for them.
> > + *
> > + * NOTE: side_by_side split is occurred on pipeline level which split =
the plane
> > + *	 data flow into pipelines, but the layer split is a pipeline
> > + *	 internal split which splits the data flow into pipeline layers.
> > + *	 So komeda still supports to apply a further layer split to the sbs
> > + *	 split data flow.
> > + */
> > +int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
> > +				     struct komeda_plane_state *kplane_st,
> > +				     struct komeda_crtc_state *kcrtc_st,
> > +				     struct komeda_data_flow_cfg *dflow)
> > +{
> > +	struct komeda_crtc *kcrtc =3D to_kcrtc(kcrtc_st->base.crtc);
> > +	struct drm_plane *plane =3D kplane_st->base.plane;
> > +	struct komeda_data_flow_cfg temp, *master_dflow, *slave_dflow;
> > +	struct komeda_layer *master, *slave;
> > +	bool master_plane =3D layer->base.pipeline =3D=3D kcrtc->master;
> > +	int err;
> > +
> > +	DRM_DEBUG_ATOMIC("SBS prepare %s-[PLANE:%d:%s]: %s.\n",
> > +			 master_plane ? "Master" : "Slave",
> > +			 plane->base.id, plane->name,
> > +			 komeda_data_flow_msg(dflow));
> > +
> > +	if (master_plane) {
> > +		master =3D layer;
> > +		slave =3D layer->sbs_slave;
> > +		master_dflow =3D dflow;
> > +		slave_dflow  =3D &temp;
> > +		err =3D komeda_split_sbs_master_data_flow(kcrtc_st,
> > +				&master_dflow, &slave_dflow);
> > +	} else {
> > +		master =3D NULL;
> > +		slave =3D layer;
> > +		master_dflow =3D NULL;
> > +		slave_dflow =3D dflow;
> > +		err =3D komeda_split_sbs_slave_data_flow(kcrtc_st, slave_dflow);
> > +	}
> > +
> > +	if (err)
> > +		return err;
> > +
> > +	if (master_dflow) {
> > +		DRM_DEBUG_ATOMIC("SBS Master-%s assigned: %s\n",
> > +			master->base.name, komeda_data_flow_msg(master_dflow));
> > +
> > +		if (master_dflow->en_split)
> > +			err =3D komeda_build_layer_split_data_flow(master,
> > +					kplane_st, kcrtc_st, master_dflow);
> > +		else
> > +			err =3D komeda_build_layer_data_flow(master,
> > +					kplane_st, kcrtc_st, master_dflow);
> > +
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	if (slave_dflow) {
> > +		DRM_DEBUG_ATOMIC("SBS Slave-%s assigned: %s\n",
> > +			slave->base.name, komeda_data_flow_msg(slave_dflow));
> > +
> > +		if (slave_dflow->en_split)
> > +			err =3D komeda_build_layer_split_data_flow(slave,
> > +					kplane_st, kcrtc_st, slave_dflow);
> > +		else
> > +			err =3D komeda_build_layer_data_flow(slave,
> > +					kplane_st, kcrtc_st, slave_dflow);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /* writeback data path: compiz -> scaler -> wb_layer -> memory */
> >  int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
> >  			      struct drm_connector_state *conn_st,
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/driver=
s/gpu/drm/arm/display/komeda/komeda_plane.c
> > index 98e915e325dd..2644f0727570 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > @@ -77,6 +77,7 @@ komeda_plane_atomic_check(struct drm_plane *plane,
> >  	struct komeda_plane_state *kplane_st =3D to_kplane_st(state);
> >  	struct komeda_layer *layer =3D kplane->layer;
> >  	struct drm_crtc_state *crtc_st;
> > +	struct komeda_crtc *kcrtc;
> >  	struct komeda_crtc_state *kcrtc_st;
> >  	struct komeda_data_flow_cfg dflow;
> >  	int err;
> > @@ -94,13 +95,17 @@ komeda_plane_atomic_check(struct drm_plane *plane,
> >  	if (!crtc_st->active)
> >  		return 0;
> > =20
> > +	kcrtc =3D to_kcrtc(crtc_st->crtc);
> >  	kcrtc_st =3D to_kcrtc_st(crtc_st);
> > =20
> >  	err =3D komeda_plane_init_data_flow(state, kcrtc_st, &dflow);
> >  	if (err)
> >  		return err;
> > =20
> > -	if (dflow.en_split)
> > +	if (kcrtc->side_by_side)
> > +		err =3D komeda_build_layer_sbs_data_flow(layer,
> > +				kplane_st, kcrtc_st, &dflow);
> > +	else if (dflow.en_split)
> >  		err =3D komeda_build_layer_split_data_flow(layer,
> >  				kplane_st, kcrtc_st, &dflow);
> >  	else
> >=20
>=20
>=20
> --=20
> Mihail
>=20
>=20
