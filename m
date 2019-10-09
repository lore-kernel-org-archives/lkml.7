Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2760C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945C82054F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qad99nxG";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qad99nxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfJIFP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 01:15:56 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:18913
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730358AbfJIFPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 01:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjYKmM+cUPHlMrma1ekAHkovTYiuxaPPdO5HGBtdcs0=;
 b=qad99nxGt7zHYVywCSKHQanGUG1ZH53dM+VPJyEEH3G3k5Prc0K8/h5m41UShf41Cs0fty+Y2QBNqnayswSWKzVDVA0BZUts+7PBDCUb+eC9FMAckCLIejWYn+Od4a2yba1+p9D997RmGywrHBj0ZBroc/WREVR1ggouq9pDj+M=
Received: from VI1PR0802CA0035.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::21) by DB6PR0802MB2598.eurprd08.prod.outlook.com
 (2603:10a6:4:97::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Wed, 9 Oct
 2019 05:15:42 +0000
Received: from AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR0802CA0035.outlook.office365.com
 (2603:10a6:800:a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 9 Oct 2019 05:15:41 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT037.mail.protection.outlook.com (10.152.17.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 9 Oct 2019 05:15:40 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Wed, 09 Oct 2019 05:15:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fc217f88326ac08b
X-CR-MTA-TID: 64aa7808
Received: from aa1899477da5.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9E8409CE-D700-416D-A596-714BC71FE6DE.1;
        Wed, 09 Oct 2019 05:15:29 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id aa1899477da5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 09 Oct 2019 05:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8G/ioOEb/lF3KorQ0xiG5z7ABHGJXzcFnWprCCuR4OF8sjat5VWwFgKQTcA3zp3R2hY24efBsELCxiOI1y407I8dEin7UehGMTBZuOyqTiNANdpVD3r93lvrbyX3Dy7U6FGNYDffXg7jX/4s0tzkaxDGjju8kl5u+l1aE0CaidJFWx1+z6JweMDlVfN+gnw85GI4NWJfuLaH2SJ5ABVsNsRiJjreimw1ce6XhI6pPN2aH9olloGD7R00o8B2RFIDcUN4lonKJ5XcSS5UcMbVQSYFBrkAv+3h7T3K43JTW9zwNc+qDBv8A3IFTFvctF69RjGHghLj3ejbOokH/cZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjYKmM+cUPHlMrma1ekAHkovTYiuxaPPdO5HGBtdcs0=;
 b=aoV7OnGlVbLxMsmSwiqZZ0Mp11qb3drckWEyMfVGNkqnxBMGfitJ6N6BSjeqjEwLaoScsArCOXallVnIH3z4wowM1xZaAJ0IX59DXbydJBclF4ObsL38OfL1VpV/r3q7VbRPrG+Tr3u+U0tk4AO6xwN/W7v43AUwYgDflzldNn3M7i55gf2I8LWlKXQe4zAKdOr4141GgK3SztuIVBz7cll+DE856oYujK08ng4pF433p61XqGClOusvJMuL/H6LpSLKW/QmVn7QfVVWX5otxXoDyeV4QhUXlsesZrEevSY7ET+xqLj/RU6l9u0CbLY/M+es9AQ+LvHEHkRI02qZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjYKmM+cUPHlMrma1ekAHkovTYiuxaPPdO5HGBtdcs0=;
 b=qad99nxGt7zHYVywCSKHQanGUG1ZH53dM+VPJyEEH3G3k5Prc0K8/h5m41UShf41Cs0fty+Y2QBNqnayswSWKzVDVA0BZUts+7PBDCUb+eC9FMAckCLIejWYn+Od4a2yba1+p9D997RmGywrHBj0ZBroc/WREVR1ggouq9pDj+M=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5039.eurprd08.prod.outlook.com (10.255.159.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 05:15:24 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2305.023; Wed, 9 Oct 2019
 05:15:24 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
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
Subject: Re: [PATCH] drm/komeda: Adds zorder support
Thread-Topic: [PATCH] drm/komeda: Adds zorder support
Thread-Index: AQHVDrzEWlPnOqPw50SK0mX5g3+JP6dRtNoAgADuv4A=
Date:   Wed, 9 Oct 2019 05:15:24 +0000
Message-ID: <20191009051517.GA30868@jamwan02-TSP300>
References: <1558323179-18857-1-git-send-email-lowry.li@arm.com>
 <CAKMK7uEEQUdSHFPP7UoXs9jv2CLiPQBFQv9gsxyVnsSjApFyVQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEEQUdSHFPP7UoXs9jv2CLiPQBFQv9gsxyVnsSjApFyVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 812f6508-8658-479e-e88d-08d74c77ba0c
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5039:|VE1PR08MB5039:|DB6PR0802MB2598:
X-MS-Exchange-PUrlCount: 10
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2598A02A53284F8F63B76961B3950@DB6PR0802MB2598.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3173;OLM:1728;
x-forefront-prvs: 018577E36E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10019001)(6009001)(428001)(377454003)(51704005)(24454002)(199002)(189002)(20776003)(69226001)(63696002)(74876001)(74706001)(33716001)(33656001)(77096001)(76786001)(76796001)(81542001)(54356001)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(15975445006)(77982001)(59766001)(56816005)(80022001)(66066001)(76482001)(90146001)(65816001)(87936001)(56776001)(15202345003)(54316002)(74366001)(44376005)(87266001)(2656002)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(85306002)(79102001)(85852003)(83072002)(83506001)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1102;SCL:1;SRVR:VE1PR08MB5039;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ElazSRpzNrtxNOQ3QA7sND4WXZHMPmXNRomrSursmAd8HBy07YrSonvCm0x1Q3aBIR8gJK/wfsmVziyy52jGjgMsx5f0jQBZ7RweL6cOrjShqN8CtZ8IldBEWNDoOd9mnD2VkfDjuTbhJCvBU+7IDi2k5oagarVixEAZnAXeW+kYHi1jjQVSEAyT4NeY4YFd0xP0LIfWc2gew5ElKHN5dEz1rxqvPasJdIvtPnluiDKw5bEm3HXNB3NnUaxmSXUyM4lh6tXqGNzJjm3b4gZjfin+CcpHWyWv0qU8FpCD58xrWELwxVhe9KDoR8E5Ha6fnwZV1YtaCnCLAqryZ6a8VVs/1rIIO5zF7Y4SDKK6rbXzdiLEdOlNb9iixHjebpvvEXlTXn+0ltvPDFzS1uFsm31JhrF7B6PkX8SAUsSJC5ht07Kw9ZpgX6AbNNIyIhYO36ioS3LLh40W2XDW9iJ1eQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <074B98328AF0BB4483CE23B8F92D13E5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5039
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(81166006)(9686003)(186003)(26826003)(25786009)(81156014)(6512007)(33656002)(8746002)(6306002)(33716001)(26005)(446003)(97756001)(4326008)(11346002)(476003)(6862004)(126002)(486006)(66066001)(6246003)(478600001)(8676002)(76176011)(7736002)(336012)(6506007)(386003)(5660300002)(53546011)(99286004)(86362001)(14454004)(63350400001)(6486002)(23726003)(305945005)(8936002)(1076003)(50466002)(3846002)(966005)(102836004)(229853002)(6116002)(316002)(36906005)(54906003)(58126008)(46406003)(47776003)(70206006)(70586007)(22756006)(2906002)(356004)(14444005)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2598;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7169e787-1068-4b17-4f4c-08d74c77b035
NoDisclaimer: True
X-Forefront-PRVS: 018577E36E
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uzt02YGXWxYPIvLRC9RKEXi8IalptGczd93VtnGJoJctSTXsJ+f7lQp7hyXWgv7n7iAhhB4ITQcDWtuNkdgXOThINUWJl8POAspuk9vcoFyWU0E2RRAR6e1sljhr0ZVxGHP87/jaCMaoqRPE57nJCLVdVRuIx/xw+efZiIp92g73rlaFrXy09wWJTOCrRgKKWI4m9Fb9+fjT5aYf4G9hRmz6G2h6G8by6jaQ3kd81ONmh2fKGQDnubPls+yIzhS6UncHB7lA8cAGnBW8b1QZpnh5f7CToNo2ce8DAFbo06BGNU+CzhX7DwFlmcxrSx0E44MDSVu1wqx2h7kp2b9UEVAabMseOs8ZyVIM5ya9HJyGibi3nXbpT1rt8q1st1D+NM3+jjuHNcXI5cAMiC69ZSbYjHsgy0X6exFg3ai8w6Ef+o9nmFMat+5lCxJgMzt2XAl0uM3uWQjC6VG+YwxXOw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 05:15:40.1701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 812f6508-8658-479e-e88d-08d74c77ba0c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:00:46PM +0200, Daniel Vetter wrote:
> On Mon, May 20, 2019 at 5:33 AM Lowry Li (Arm Technology China)
> <Lowry.Li@arm.com> wrote:
> >
> > - Creates the zpos property.
> > - Implement komeda_crtc_normalize_zpos to replace
> > drm_atomic_normalize_zpos, reasons as the following:
> >
> > 1. The drm_atomic_normalize_zpos allows to configure same zpos for
> > different planes, but komeda doesn't support such configuration.
>=20
> Just stumbled over your custom normalized_zpos calculation, and it
> looks very fishy. You seem to reinvent the normalized zpos
> computation, which has the entire job of resolving duplicated zpos
> values (which can happen with legacy kms). So the above is definitely
> wrong.
>=20
> Can you pls do a patch to remove your own code, and replace it with
> helper usage? Or at least explain why exactly you can't use the
> standard normalized zpos stuff and need your own (since it really
> looks like just reinventing the same thing).
> -Daniel
>=20
> > 2. For further slave pipline case, Komeda need to calculate the
> > max_slave_zorder, we will merge such calculation into
> > komed_crtc_normalize_zpos to save a separated plane_state loop.

> > 3. For feature none-scaling layer_split, which a plane_state will be
> > assigned to two individual layers(left/right), which requires two
> > normalize_zpos for this plane, plane_st->normalize_zpos will be used
> > by left layer, normalize_zpos + 1 for right_layer.
> >

Yes, the komeda/drm zpos_normalize are simlilar,=20

First requirement is here the "layer split" support.

Komeda HW has a input size limitation for YUV format, compare with
RGB, which only has the half capablities, like

- Layer support 4K RGB input size.
- YUV only can support 2K.

To hide this limitation, we introdue Layer split, which splits
one drm_plane data flows to two halves (left/right), and handle them by
two individual HW layers, and of course, two layers need two different
normalize_zpos. but drm_atomic_normalize_zpos() only assign one value
to this plane, but we need two values for layer_split.

Secondary requirement:

we also need the ordered plane list that built by normalize_zpos(),
but current drm version doesn't return it.

For more komeda things:
https://www.kernel.org/doc/html/latest/gpu/komeda-kms.html?highlight=3Dkome=
da

LAST.
Yes, the komeda and drm version zpos normalize are similar,
we can not use the standard version only because some tiny but
special requirements.
I saw the upstream is working for the zorder refinement, maybe we
can add komeda's requirements into the drm_atomic_normalize_zpos()
and drop komeda version together with this refinement.

Best Regards
James

> > This patch series depends on:
> > - https://patchwork.freedesktop.org/series/58710/
> > - https://patchwork.freedesktop.org/series/59000/
> > - https://patchwork.freedesktop.org/series/59002/
> > - https://patchwork.freedesktop.org/series/59747/
> > - https://patchwork.freedesktop.org/series/59915/
> > - https://patchwork.freedesktop.org/series/60083/
> > - https://patchwork.freedesktop.org/series/60698/
> >
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   | 90 +++++++++++++++=
+++++++-
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
> >  drivers/gpu/drm/arm/display/komeda/komeda_plane.c |  6 +-
> >  3 files changed, 97 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 306ea06..0ec7665 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -100,6 +100,90 @@ static void komeda_kms_commit_tail(struct drm_atom=
ic_state *old_state)
> >         .atomic_commit_tail =3D komeda_kms_commit_tail,
> >  };
> >
> > +static int komeda_plane_state_list_add(struct drm_plane_state *plane_s=
t,
> > +                                      struct list_head *zorder_list)
> > +{
> > +       struct komeda_plane_state *new =3D to_kplane_st(plane_st);
> > +       struct komeda_plane_state *node, *last;
> > +
> > +       last =3D list_empty(zorder_list) ?
> > +              NULL : list_last_entry(zorder_list, typeof(*last), zlist=
_node);
> > +
> > +       /* Considering the list sequence is zpos increasing, so if list=
 is empty
> > +        * or the zpos of new node bigger than the last node in list, n=
o need
> > +        * loop and just insert the new one to the tail of the list.
> > +        */
> > +       if (!last || (new->base.zpos > last->base.zpos)) {
> > +               list_add_tail(&new->zlist_node, zorder_list);
> > +               return 0;
> > +       }
> > +
> > +       /* Build the list by zpos increasing */
> > +       list_for_each_entry(node, zorder_list, zlist_node) {
> > +               if (new->base.zpos < node->base.zpos) {
> > +                       list_add_tail(&new->zlist_node, &node->zlist_no=
de);
> > +                       break;
> > +               } else if (node->base.zpos =3D=3D new->base.zpos) {
> > +                       struct drm_plane *a =3D node->base.plane;
> > +                       struct drm_plane *b =3D new->base.plane;
> > +
> > +                       /* Komeda doesn't support setting a same zpos f=
or
> > +                        * different planes.
> > +                        */
> > +                       DRM_DEBUG_ATOMIC("PLANE: %s and PLANE: %s are c=
onfigured same zpos: %d.\n",
> > +                                        a->name, b->name, node->base.z=
pos);
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
> > +                                     struct drm_crtc_state *crtc_st)
> > +{
> > +       struct drm_atomic_state *state =3D crtc_st->state;
> > +       struct komeda_plane_state *kplane_st;
> > +       struct drm_plane_state *plane_st;
> > +       struct drm_framebuffer *fb;
> > +       struct drm_plane *plane;
> > +       struct list_head zorder_list;
> > +       int order =3D 0, err;
> > +
> > +       DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos valu=
es\n",
> > +                        crtc->base.id, crtc->name);
> > +
> > +       INIT_LIST_HEAD(&zorder_list);
> > +
> > +       /* This loop also added all effected planes into the new state =
*/
> > +       drm_for_each_plane_mask(plane, crtc->dev, crtc_st->plane_mask) =
{
> > +               plane_st =3D drm_atomic_get_plane_state(state, plane);
> > +               if (IS_ERR(plane_st))
> > +                       return PTR_ERR(plane_st);
> > +
> > +               /* Build a list by zpos increasing */
> > +               err =3D komeda_plane_state_list_add(plane_st, &zorder_l=
ist);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       list_for_each_entry(kplane_st, &zorder_list, zlist_node) {
> > +               plane_st =3D &kplane_st->base;
> > +               fb =3D plane_st->fb;
> > +               plane =3D plane_st->plane;
> > +
> > +               plane_st->normalized_zpos =3D order++;
> > +
> > +               DRM_DEBUG_ATOMIC("[PLANE:%d:%s] zpos:%d, normalized zpo=
s: %d\n",
> > +                                plane->base.id, plane->name,
> > +                                plane_st->zpos, plane_st->normalized_z=
pos);
> > +       }
> > +
> > +       crtc_st->zpos_changed =3D true;
> > +
> > +       return 0;
> > +}
> > +
> >  static int komeda_kms_check(struct drm_device *dev,
> >                             struct drm_atomic_state *state)
> >  {
> > @@ -111,7 +195,7 @@ static int komeda_kms_check(struct drm_device *dev,
> >         if (err)
> >                 return err;
> >
> > -       /* komeda need to re-calculate resource assumption in every com=
mit
> > +       /* Komeda need to re-calculate resource assumption in every com=
mit
> >          * so need to add all affected_planes (even unchanged) to
> >          * drm_atomic_state.
> >          */
> > @@ -119,6 +203,10 @@ static int komeda_kms_check(struct drm_device *dev=
,
> >                 err =3D drm_atomic_add_affected_planes(state, crtc);
> >                 if (err)
> >                         return err;
> > +
> > +               err =3D komeda_crtc_normalize_zpos(crtc, new_crtc_st);
> > +               if (err)
> > +                       return err;
> >         }
> >
> >         err =3D drm_atomic_helper_check_planes(dev, state);
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.h
> > index 178bee6..d1cef46 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _KOMEDA_KMS_H_
> >  #define _KOMEDA_KMS_H_
> >
> > +#include <linux/list.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc_helper.h>
> > @@ -46,6 +47,8 @@ struct komeda_plane {
> >  struct komeda_plane_state {
> >         /** @base: &drm_plane_state */
> >         struct drm_plane_state base;
> > +       /** @zlist_node: zorder list node */
> > +       struct list_head zlist_node;
> >
> >         /* @img_enhancement: on/off image enhancement */
> >         u8 img_enhancement : 1;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/driver=
s/gpu/drm/arm/display/komeda/komeda_plane.c
> > index bcf30a7..aad7663 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > @@ -21,7 +21,7 @@
> >
> >         memset(dflow, 0, sizeof(*dflow));
> >
> > -       dflow->blending_zorder =3D st->zpos;
> > +       dflow->blending_zorder =3D st->normalized_zpos;
> >
> >         /* if format doesn't have alpha, fix blend mode to PIXEL_NONE *=
/
> >         dflow->pixel_blend_mode =3D fb->format->has_alpha ?
> > @@ -343,6 +343,10 @@ static int komeda_plane_add(struct komeda_kms_dev =
*kms,
> >         if (err)
> >                 goto cleanup;
> >
> > +       err =3D drm_plane_create_zpos_property(plane, layer->base.id, 0=
, 8);
> > +       if (err)
> > +               goto cleanup;
> > +
> >         return 0;
> >  cleanup:
> >         komeda_plane_destroy(plane);
> > --
> > 1.9.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
>=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
