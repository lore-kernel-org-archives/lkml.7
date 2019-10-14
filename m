Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1664EC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C147B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GHDIR/Gb";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GHDIR/Gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfJNKj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:39:29 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:15269
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731249AbfJNKj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8NZV1eSAwBJgjS43JUI8pJOnNSb6IlZ5O8HD3LIauA=;
 b=GHDIR/Gbrmex1D1GzuhyZMXfqfrmXF1Y49f9+9SUWQw6S5AEFZetRya4TNyqeCwS/QdbuG/cCce6oyzGrBEzxJmIK8rpZy0YtR0B/ZHaz5fgP/jURbVyYqDLGIAwE0W7yZ3fyDNtkf5Wcljd8c9k/tJriIzEQ4Cxi8JexbJDaDU=
Received: from HE1PR0802CA0016.eurprd08.prod.outlook.com (2603:10a6:3:bd::26)
 by VI1PR08MB4511.eurprd08.prod.outlook.com (2603:10a6:803:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22; Mon, 14 Oct
 2019 10:39:21 +0000
Received: from DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::206) by HE1PR0802CA0016.outlook.office365.com
 (2603:10a6:3:bd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Mon, 14 Oct 2019 10:39:21 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT049.mail.protection.outlook.com (10.152.20.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 14 Oct 2019 10:39:19 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Mon, 14 Oct 2019 10:39:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6a09c42ab0b4103a
X-CR-MTA-TID: 64aa7808
Received: from 0be161cbbc76.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 696B6BF9-AD22-4001-BBF2-8C709AFDB6AD.1;
        Mon, 14 Oct 2019 10:39:10 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0be161cbbc76.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Oct 2019 10:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH3lYIK+AdgfG+wI/WBqaXn1TsfRQpFqORlxzo2XIwpqGEM3kVxWKDZvC5TNXiEWrZ3Z7InLnqWouxZoQ1CNM5MysRLGEJ+/74RNsBf0iCpk4EaBtnHWMDzMbnrQp0vyq3hyUbOCdoLc0cRNjYvNfBNb7o8GeLlkUZtlMajTwQ0N7ZAljfnGchWQn0h+FEfhIFTotqIPetkZMRbX21zX3Z5GCbq8gneyunV8C53WwDwORMGFHszBETyjIPeQsz7vZY89CflUZioUz7xrdYn4svNP4pe2/XnTJ7TdoAuFTGIsKTYQ2fxUYtAq24ORv18BggB7LIRLlVwPgJCdMOCkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8NZV1eSAwBJgjS43JUI8pJOnNSb6IlZ5O8HD3LIauA=;
 b=ZScLVlvuknhkgKzxoXq88n404AwGqzOIB7TTC4ajjVfeG7d9nwYskyB4wqpHNcCyzg+a6kGGlEHW1GuC5lQBDaoOXNBGg5Fz4ieynQqSpORfeca3Aa1xgieajg4yIDqd/LRCzat1kiQ0hVJDeVPh5Kkz0SsP8hJJ+MghGO36VoivGVtUgQxzTKaFuHDqelLDtR99DQ8MkQBIUYWNBKcEh+ihCWZ0Q0Ik/i1kUq2uyQ91tUScfXbNoyHR+uSVJ3x3FHvJ77bdhP7etv1lmtzUtWznMCUUg26xoiU5HRYMjck042ZwVgjDoSuJOKx4PeHBZWr8Iehoa0byBbrfkQrj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8NZV1eSAwBJgjS43JUI8pJOnNSb6IlZ5O8HD3LIauA=;
 b=GHDIR/Gbrmex1D1GzuhyZMXfqfrmXF1Y49f9+9SUWQw6S5AEFZetRya4TNyqeCwS/QdbuG/cCce6oyzGrBEzxJmIK8rpZy0YtR0B/ZHaz5fgP/jURbVyYqDLGIAwE0W7yZ3fyDNtkf5Wcljd8c9k/tJriIzEQ4Cxi8JexbJDaDU=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3038.eurprd08.prod.outlook.com (52.134.122.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Mon, 14 Oct 2019 10:39:08 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 10:39:07 +0000
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
Subject: Re: [PATCH v2 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Topic: [PATCH v2 1/4] drm: Add a new helper
 drm_color_ctm_s31_32_to_qm_n()
Thread-Index: AQHVf/cdAHid3tH8+UyzZeXX5YE1LKdVLBiAgAS7sICAAA99gA==
Date:   Mon, 14 Oct 2019 10:39:07 +0000
Message-ID: <2848496.aPtRGPrWej@e123338-lin>
References: <20191011054459.17984-1-james.qian.wang@arm.com>
 <1622787.6FTe1jSl1W@e123338-lin> <20191014094332.GA15094@jamwan02-TSP300>
In-Reply-To: <20191014094332.GA15094@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::23) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 81dd7b79-8a02-4bbb-2691-08d75092c521
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB3038:|VI1PR08MB3038:|VI1PR08MB4511:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4511846F444B038374DFB4488F900@VI1PR08MB4511.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:4941;
x-forefront-prvs: 01901B3451
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(14454004)(52116002)(186003)(4326008)(386003)(478600001)(76176011)(7736002)(6636002)(102836004)(6506007)(305945005)(229853002)(71200400001)(71190400001)(6436002)(6486002)(66476007)(66446008)(86362001)(26005)(66556008)(64756008)(8676002)(54906003)(6862004)(81166006)(81156014)(25786009)(316002)(8936002)(6116002)(14444005)(256004)(66066001)(3846002)(446003)(486006)(2906002)(66946007)(5660300002)(11346002)(476003)(99286004)(6246003)(9686003)(6512007)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3038;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lIwJOPQByM5FOaYKtud+vBQkQ5QRUphgBagUNsNYk6a6RwWch3OH+fyJzlAroh6GG72Q7KM9YCBnv7lFHWlLY83rAXXsD+f7DJDwm6JaIekcOmusyqsPHrrNlPLuusfLirRFMgJZslN0fRp21VnQV+n6rN4T0zhTseCHT4rcVnK2pHbPpqsQz6/LMsQYJiQ0wfHbiEUhcTTH+CeyR6H+nu3h4QBMyBnqtYR9V6HBo7EYrnoMVr3h1N5ExJWcPinnIrPDpy86rDMgIL7hahPhhI6gXDmsiYysxhnnmnkFG/24RBgpb6Wp6BnQU/c8zqjCvhgHx6NquujJm0g43oSYlH4DrcWxU7dVFjjKqYzmMuQOcQLDxp35AudJivfDRcOWU0OAUvx8/1ubknlUbap477URd6pf7DznKJRF8oAlMX0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD6F5598FC4AA84B847968F8A2E29CC6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3038
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(356004)(2906002)(86362001)(66066001)(47776003)(316002)(54906003)(46406003)(126002)(486006)(23726003)(6116002)(3846002)(6862004)(5660300002)(229853002)(50466002)(476003)(336012)(4326008)(11346002)(22756006)(446003)(6636002)(63350400001)(9686003)(8746002)(8936002)(97756001)(6512007)(6246003)(76176011)(6486002)(81166006)(81156014)(478600001)(102836004)(386003)(305945005)(70206006)(7736002)(6506007)(99286004)(70586007)(14444005)(14454004)(26005)(186003)(76130400001)(25786009)(8676002)(33716001)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4511;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 839fdb88-da10-4781-c09e-08d75092bd95
NoDisclaimer: True
X-Forefront-PRVS: 01901B3451
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3/k+3OZIouBnAKBU9Nbvt15SPS6/BS6ItY3cZrZjF3DnvQhFy+S9vdJjKXMhhlOupcw44duRlcMZUL3WZstZ9Xv3+KIws8WT9O6hsYPY5xU+DO0Of2MMsgGYhezXcdT7Gb/XB+Mk7Yf6zcJZXC678hdB9Xe0PZ5YVz4n5xn1CSUUzAGDqOt3XXwzovIkNH54elmuJGBod/4oFJ9NAjBUuTbJx+fD9D/2OBH5SA8Iw0NSxmaqzWTypNxrgpmSV+9Pict2upaNzj04Rdv27PezaOpIz0LNHIDQ8ZSm3DwtkqXu7Lqeki9UttblXwWpeiT2SHQYVbe6/g0ZvjSzQYuuFpjKz3M3+c/P9odKnQy2yBjOE7l7HrKVABVCMRBQzk1PAk+iq3noyjePPnT4tfR20IUUf5n4SEY3b93ZtJ4BAw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2019 10:39:19.8415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81dd7b79-8a02-4bbb-2691-08d75092c521
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 14 October 2019 10:43:39 BST james qian wang (Arm Technology Chi=
na) wrote:
> On Fri, Oct 11, 2019 at 08:26:53AM +0000, Mihail Atanassov wrote:
> > Hi James,
> >=20
> > On Friday, 11 October 2019 06:45:27 BST james qian wang (Arm Technology=
 China) wrote:
> > > Add a new helper function drm_color_ctm_s31_32_to_qm_n() for driver t=
o
> > > convert S31.32 sign-magnitude to Qm.n 2's complement that supported b=
y
> > > hardware.
> > >=20
> > > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wan=
g@arm.com>
> > > ---
> > >  drivers/gpu/drm/drm_color_mgmt.c | 23 +++++++++++++++++++++++
> > >  include/drm/drm_color_mgmt.h     |  2 ++
> > >  2 files changed, 25 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_c=
olor_mgmt.c
> > > index 4ce5c6d8de99..3d533d0b45af 100644
> > > --- a/drivers/gpu/drm/drm_color_mgmt.c
> > > +++ b/drivers/gpu/drm/drm_color_mgmt.c
> > > @@ -132,6 +132,29 @@ uint32_t drm_color_lut_extract(uint32_t user_inp=
ut, uint32_t bit_precision)
> > >  }
> > >  EXPORT_SYMBOL(drm_color_lut_extract);
> > >=20
> > > +/**
> > > + * drm_color_ctm_s31_32_to_qm_n
> > > + *
> > > + * @user_input: input value
> > > + * @m: number of integer bits, the m must <=3D 31
> > > + * @n: number of fractinal bits the n must <=3D 32
>=20
> @m: number of integer bits, only support m <=3D 31
> @n: number of fractinal bitsm only support n <=3D 32
>=20

Hehe, guess what I didn't do? Also, [nit], s/fractinal/fractional/.

> > > + *
> > > + * Convert and clamp S31.32 sign-magnitude to Qm.n 2's complement.
> > > + */
> > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > +				      uint32_t m, uint32_t n)
> > > +{
> > > +	u64 mag =3D (user_input & ~BIT_ULL(63)) >> (32 - n);
> > This doesn't account for n > 32, which is perfectly possible (e.g. Q1.6=
3).
> > > +	bool negative =3D !!(user_input & BIT_ULL(63));
> > > +	s64 val;
> > > +
> > > +	/* the range of signed 2s complement is [-2^n+m, 2^n+m - 1] */
> > > +	val =3D clamp_val(mag, 0, negative ? BIT(n + m) : BIT(n + m) - 1);
> > This also doesn't account for n + m =3D=3D 64.
>=20
> Yes the func is only for support m <=3D 31, n <=3D 32
>=20
> But I'm not sure, how to handle the unsupport case ?
> Maybe just mention it in Doc is enough.

I'd personally appreciate a WARN_ON(...)*. My comment was motivated by
the unchecked nature of the limitation, which might surprise
a dev who didn't read the doc before using the function (like myself :)).

Actually, the limitations are more than specified, BIT(n + m) is only
valid for (n + m < 32) on LP32 systems.

At least change those to BIT_ULL(), then:

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

* - gcc9.2 doesn't give me any compile-time warnings for using this func
incorrectly.

>=20
> > > +
> > > +	return negative ? 0ll - val : val;
> > > +}
> > > +EXPORT_SYMBOL(drm_color_ctm_s31_32_to_qm_n);
> > > +
> > >  /**
> > >   * drm_crtc_enable_color_mgmt - enable color management properties
> > >   * @crtc: DRM CRTC
> > > diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgm=
t.h
> > > index d1c662d92ab7..60fea5501886 100644
> > > --- a/include/drm/drm_color_mgmt.h
> > > +++ b/include/drm/drm_color_mgmt.h
> > > @@ -30,6 +30,8 @@ struct drm_crtc;
> > >  struct drm_plane;
> > >=20
> > >  uint32_t drm_color_lut_extract(uint32_t user_input, uint32_t bit_pre=
cision);
> > > +uint64_t drm_color_ctm_s31_32_to_qm_n(uint64_t user_input,
> > > +				      uint32_t m, uint32_t n);
> > >=20
> > >  void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
> > >  				uint degamma_lut_size,
> > > --
> > > 2.20.1
> > >=20
> >=20
> >=20
>=20


--=20
Mihail



