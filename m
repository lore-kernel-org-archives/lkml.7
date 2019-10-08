Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DBEC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6412206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="x4BOGGVx";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="x4BOGGVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfJHLTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:19:24 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:17980
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729876AbfJHLTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+8cPpEdvE0a0oBV2As+q8KHgTvRTUMZbOIyj+3YYM8=;
 b=x4BOGGVxb4FBNWWIPSJD9EOetfYFNHIhLKEm4qWUhCMckFiq500BaKj+fgsLjeXEd/AOEkJ2EtJkCbmemZNUX6loS3vEaWPutucaEScLjESBZyJiVE7MkRHxBH2knPou2jWpm6dsnMCAI91lgAvsnEU38IBlRCQ7IBRwRzQNQVs=
Received: from AM4PR08CA0077.eurprd08.prod.outlook.com (2603:10a6:205:2::48)
 by DBBPR08MB4540.eurprd08.prod.outlook.com (2603:10a6:10:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 8 Oct
 2019 11:19:13 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by AM4PR08CA0077.outlook.office365.com
 (2603:10a6:205:2::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 8 Oct 2019 11:19:13 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 11:19:12 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Tue, 08 Oct 2019 11:19:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a54996235a096243
X-CR-MTA-TID: 64aa7808
Received: from 9b174ae686e9.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 42C8EA41-777F-43D2-BA26-D10ADEB49D94.1;
        Tue, 08 Oct 2019 11:19:02 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9b174ae686e9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Oct 2019 11:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOfhit/IXGkP3WDaxKes6456FcAkxcw4J14O3XQaIgS5sawAX2tsO6l6C7AsBiV4bC7256wFXJZjkymYU2xe8mXknSQjghqFcuPK7JxCPl+ZJ6IloFz7bDVGM0hIhgNhPsOg2BX6nc0AFiNNGdrdbnG26joFZOKML3TFYXrQds2CMyXVJKw+o34+KOwK6CfBHnXKprCKM83Rp5f+1kpi/Vwz8MDpGELbTpou8mWuvPBa36BrkoCbqkl2gzIVL8N19+er0pxSe4WRD8X25VYO8hossgYwRunE72Z7zhVRQ9/o9yBUNXV9siwKGW0N4NUb62/GJxUYcMT0bAR4D7pO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+8cPpEdvE0a0oBV2As+q8KHgTvRTUMZbOIyj+3YYM8=;
 b=iPbKPc7iI2IVc9M94/Fn/VHSKZFg4Jf3Gim2jMvTtcgogt5XP1zbgq3TMXa0azSPrjvpFXJ+zQqwuORoQ4/9dx5S+Xkh/3Ji/hlNjDhPtatTgJV2mlvxj9XfNf+1Myj9XkVrwNK0pVD2UEG/jLTj18DVVzQMl2g+sJGZn7NDYPMLyTtjbfezBPrBgM4f4QP48cDekevzTC7qyHUcP+5GConkNHZDaUvHGm4mIaI2txBauJOwZkPm1TStJAPLAwAuzkpAFIyj+4Wa+FeteiRrncTKicoVQqjKvemxK/U81SdgSpV7VWUpw6KwI+iBAd0n2lDxB6QwASYZ7v7HM3ySNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+8cPpEdvE0a0oBV2As+q8KHgTvRTUMZbOIyj+3YYM8=;
 b=x4BOGGVxb4FBNWWIPSJD9EOetfYFNHIhLKEm4qWUhCMckFiq500BaKj+fgsLjeXEd/AOEkJ2EtJkCbmemZNUX6loS3vEaWPutucaEScLjESBZyJiVE7MkRHxBH2knPou2jWpm6dsnMCAI91lgAvsnEU38IBlRCQ7IBRwRzQNQVs=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4015.eurprd08.prod.outlook.com (20.178.126.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 11:18:56 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 11:18:56 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Set output color depth for output
Thread-Topic: [PATCH] drm/komeda: Set output color depth for output
Thread-Index: AQHVfblD7I+ubO1huUCp0qQz7Z0Q4adQfC0AgAAOlYCAAA4iAA==
Date:   Tue, 8 Oct 2019 11:18:56 +0000
Message-ID: <3803267.CWkr2XGRCA@e123338-lin>
References: <20191008091734.19509-1-lowry.li@arm.com>
 <20191008093608.eyr5ygc2lkkaaqia@DESKTOP-E1NTVVP.localdomain>
 <20191008102818.GB16398@lowli01-ThinkStation-P300>
In-Reply-To: <20191008102818.GB16398@lowli01-ThinkStation-P300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0151.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::19) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 44c49e26-b477-4ae3-8405-08d74be15905
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4015:|VI1PR08MB4015:|DBBPR08MB4540:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB45406C1B6F297CD1DC31C7118F9A0@DBBPR08MB4540.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(6116002)(3846002)(6636002)(478600001)(86362001)(71190400001)(71200400001)(7736002)(8676002)(81166006)(81156014)(8936002)(54906003)(316002)(2906002)(25786009)(14444005)(256004)(14454004)(33716001)(486006)(186003)(66556008)(66946007)(66476007)(64756008)(386003)(6506007)(4326008)(476003)(76176011)(11346002)(66446008)(446003)(26005)(5660300002)(6246003)(6862004)(6436002)(9686003)(99286004)(66066001)(6486002)(229853002)(6512007)(52116002)(102836004)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4015;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: AUjSNZdZeG6imk9J02mDPPurxJyMNPpYtwkS/wo605pes9PG/M+z03xQNIqAYAfNyj8+vZ/st61nwIATqXQndn5p+JRHVYhYuqHolY4El/63sOrQqELvS4WbUwZWuBbHExsO0PeCgde3bAY0PSIk8zn3hZxAdVxLIYZLOY6jAYG9YLs/AmT2MZmvmSrAMg7B7SbG8hYVPReHJvJcljQyMDJBWu3m83ecIahRS77JTwAjb1Bg0DWWCwgC2mTifrAS4zD7Q7ZOfbgmnl+kjmEYKZqWSWRtMUXwq+QMCmkYHNIyopaggqOcPPWcGBEN3ZOfYV8vwVVihDDv3CZ992vCoz0KRM/IchDO+bk8uO8AymMWz/Cqo/3DR+gCY6CzOWYc0yhFymOqf8KjgS1H1fsELxSk+JgV8HomQswy4Hl7btk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90B299F6B6C45D4EA7BD032BEF584247@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4015
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(33716001)(70586007)(70206006)(76130400001)(46406003)(66066001)(336012)(478600001)(2906002)(26826003)(47776003)(126002)(6512007)(9686003)(86362001)(486006)(6486002)(476003)(23726003)(22756006)(229853002)(6636002)(386003)(81166006)(11346002)(6116002)(3846002)(14444005)(25786009)(316002)(26005)(97756001)(7736002)(446003)(63350400001)(305945005)(6246003)(6862004)(76176011)(186003)(14454004)(81156014)(99286004)(6506007)(4326008)(54906003)(50466002)(356004)(8676002)(8936002)(5660300002)(8746002)(102836004)(36906005)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR08MB4540;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e96d1e4e-532b-47c1-da70-08d74be14ee3
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnNES14y403KsKb30yqu7si7COEt21uTmKg8TDWcxXeize4hzWIrOFNsOH9YpCOc+c8ixXU8CHiP1QAt7gRzpZ2OmLfVYYiHKmDL8WOHG/kerquuJPoz0G0UO8oqsc7PkmrVrgDWxYeiD3k5j8cjPbqpejZP1Y+rRq8UQxz3FeL8tH8qV4SsClXFAVlFDucYp2FiHTCn/LE/gjCAwMta3LpT70kpjN/MwIOkPzNAEx/6D33rnS+0/3ka8p0TRgl6xIDp8xejYKoef1BWvt7SywaVb62Cq/jAfMMviqgJkFyAp30x4ygOvPq4GVlG9QgORNyjDmrzAGx4kvaiCp3iPRuCltnO7z73d5wrVlJw3QvhlyqW7D92beHEjV0kAoAbInVOKVHoXrug00AwFg9J6pk+qbxu/d3wv9P9BKxXitg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 11:19:12.8742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c49e26-b477-4ae3-8405-08d74be15905
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4540
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 8 October 2019 11:28:24 BST Lowry Li (Arm Technology China) wro=
te:
> Hi Brian,
> On Tue, Oct 08, 2019 at 09:36:09AM +0000, Brian Starkey wrote:
> > Hi Lowry,
> >=20
> > On Tue, Oct 08, 2019 at 09:17:52AM +0000, Lowry Li (Arm Technology Chin=
a) wrote:
> > > Set color_depth according to connector->bpc.
> > >=20
> > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > ---
> > >  .../arm/display/komeda/d71/d71_component.c    |  1 +
> > >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 20 +++++++++++++++++=
++
> > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  2 ++
> > >  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
> > >  .../display/komeda/komeda_pipeline_state.c    | 19 +++++++++++++++++=
+
> > >  .../arm/display/komeda/komeda_wb_connector.c  |  4 ++++
> > >  6 files changed, 47 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b=
/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > index c3d29c0b051b..27cdb03573c1 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > @@ -951,6 +951,7 @@ static void d71_improc_update(struct komeda_compo=
nent *c,
> > >  			       to_d71_input_id(state, index));
> > > =20
> > >  	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> > > +	malidp_write32(reg, IPS_DEPTH, st->color_depth);
> > >  }
> > > =20
> > >  static void d71_improc_dump(struct komeda_component *c, struct seq_f=
ile *sf)
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > index 75263d8cd0bd..baa986b70876 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > @@ -17,6 +17,26 @@
> > >  #include "komeda_dev.h"
> > >  #include "komeda_kms.h"
> > > =20
> > > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > > +				  u32 *color_depths)
> > > +{
> > > +	struct drm_connector *conn;
> > > +	struct drm_connector_state *conn_st;
> > > +	int i, min_bpc =3D 31, conn_bpc =3D 0;
> > > +
> > > +	for_each_new_connector_in_state(crtc_st->state, conn, conn_st, i) {
> > > +		if (conn_st->crtc !=3D crtc_st->crtc)
> > > +			continue;
> > > +
> > > +		conn_bpc =3D conn->display_info.bpc ? conn->display_info.bpc : 8;
> >=20
> > We can have multiple connectors on a single CRTC (e.g. normal +
> > writeback), so what's the expected behaviour here in that case?
> >=20
> > > +
> > > +		if (conn_bpc < min_bpc)
> > > +			min_bpc =3D conn_bpc;
> > > +	}
> > > +
> > > +	*color_depths =3D GENMASK(conn_bpc, 0);
> > > +}
> > > +
> > >  static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state =
*kcrtc_st)
> > >  {
> > >  	u64 pxlclk, aclk;
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/driver=
s/gpu/drm/arm/display/komeda/komeda_kms.h
> > > index 45c498e15e7a..a42503451b5d 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > @@ -166,6 +166,8 @@ static inline bool has_flip_h(u32 rot)
> > >  		return !!(rotation & DRM_MODE_REFLECT_X);
> > >  }
> > > =20
> > > +void komeda_crtc_get_color_config(struct drm_crtc_state *crtc_st,
> > > +				  u32 *color_depths);
> > >  unsigned long komeda_crtc_get_aclk(struct komeda_crtc_state *kcrtc_s=
t);
> > > =20
> > >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda=
_dev *mdev);
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > index b322f52ba8f2..7653f134a8eb 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > @@ -323,6 +323,7 @@ struct komeda_improc {
> > > =20
> > >  struct komeda_improc_state {
> > >  	struct komeda_component_state base;
> > > +	u8 color_depth;
> > >  	u16 hsize, vsize;
> > >  };
> > > =20
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state=
.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > index 0ba9c6aa3708..e68e8f85ab27 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > > @@ -743,6 +743,7 @@ komeda_improc_validate(struct komeda_improc *impr=
oc,
> > >  		       struct komeda_data_flow_cfg *dflow)
> > >  {
> > >  	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
> > > +	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
> > >  	struct komeda_component_state *c_st;
> > >  	struct komeda_improc_state *st;
> > > =20
> > > @@ -756,6 +757,24 @@ komeda_improc_validate(struct komeda_improc *imp=
roc,
> > >  	st->hsize =3D dflow->in_w;
> > >  	st->vsize =3D dflow->in_h;
> > > =20
> > > +	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
> > > +		u32 output_depths;
> > > +		u32 avail_depths;
> > > +
> > > +		komeda_crtc_get_color_config(crtc_st,
> > > +					     &output_depths);
> > > +
> > > +		avail_depths =3D output_depths & improc->supported_color_depths;
> > > +		if (avail_depths =3D=3D 0) {
> > > +			DRM_DEBUG_ATOMIC("No available color depths, conn depths: 0x%x & =
display: 0x%x\n",
> > > +					 output_depths,
> > > +					 improc->supported_color_depths);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		st->color_depth =3D __fls(avail_depths);
> > > +	}
> > > +
> > >  	komeda_component_add_input(&st->base, &dflow->input, 0);
> > >  	komeda_component_set_output(&dflow->input, &improc->base, 0);
> > > =20
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > index 2851cac94d86..740a81250630 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > > @@ -142,6 +142,7 @@ static int komeda_wb_connector_add(struct komeda_=
kms_dev *kms,
> > >  	struct komeda_dev *mdev =3D kms->base.dev_private;
> > >  	struct komeda_wb_connector *kwb_conn;
> > >  	struct drm_writeback_connector *wb_conn;
> > > +	struct drm_display_info *info;
> > >  	u32 *formats, n_formats =3D 0;
> > >  	int err;
> > > =20
> > > @@ -171,6 +172,9 @@ static int komeda_wb_connector_add(struct komeda_=
kms_dev *kms,
> > > =20
> > >  	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_fun=
cs);
> > > =20
> > > +	info =3D &kwb_conn->base.base.display_info;
> > > +	info->bpc =3D __fls(kcrtc->master->improc->supported_color_depths);
> > > +
> >=20
> > The IPS color depth doesn't really apply to writeback. Maybe we should
> > just skip the writeback connector?
> >=20
> > Thanks,
> > -Brian
> >=20
> Yes, the color depth not apply to writeback. We adds it because:
>=20
> In the komeda_crtc_get_color_config() will loop all connectors of CRTC
> including the wb_conn, since crtc always has wb_conn. If not setting
> here, wb_conn->bpc will be set it to 8bit forcely in komeda_crtc_get_colo=
r_config() which will lead crtc bpc to 8bits all the time. So we are settin=
g the
> largest supported depth to kwb_conn->bpc here.
>=20
I agree with Brian here, it sounds like you need to fix
komeda_crtc_get_color_config() rather than putting in arcane bpc
values and invoking spooky action. Connectors have a type [1], so
it's easy to filter WB connectors out of the loop.

[1] e.g. DRM_MODE_CONNECTOR_WRITEBACK in this case.

> > >  	kcrtc->wb_conn =3D kwb_conn;
> > > =20
> > >  	return 0;
>=20


--=20
Mihail



