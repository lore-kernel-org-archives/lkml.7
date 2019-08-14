Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18DDC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE5C2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HA6isbss";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HA6isbss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfHNILC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:11:02 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:61444
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfHNILC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5plvyXDuYHwdMq6GgqYT/Jcu0D+sseOyN3TPyqZ45qg=;
 b=HA6isbssB3dnCYoS/ziUjj4TJ3CvZjiDaS+MfkOe2QHDsjMT2+Ztjr5D+xhVdxbeV0cn4EwjBQ9WrPyCSqQlWr0L90aKU6Y0jMpro4x4XS3O/D9m+0+ewHG4sUmm0pkOqqYLTTKtisR9KuY09O1KiOCeEgbzj8I/TSpfh0qw2DI=
Received: from VE1PR08CA0004.eurprd08.prod.outlook.com (2603:10a6:803:104::17)
 by HE1PR0802MB2603.eurprd08.prod.outlook.com (2603:10a6:3:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15; Wed, 14 Aug
 2019 08:10:51 +0000
Received: from AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::204) by VE1PR08CA0004.outlook.office365.com
 (2603:10a6:803:104::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.13 via Frontend
 Transport; Wed, 14 Aug 2019 08:10:50 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT021.mail.protection.outlook.com (10.152.16.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.18 via Frontend Transport; Wed, 14 Aug 2019 08:10:49 +0000
Received: ("Tessian outbound 6d016ca6b65d:v26"); Wed, 14 Aug 2019 08:10:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2e33aa14a5b109f7
X-CR-MTA-TID: 64aa7808
Received: from 5d8e972d1d06.1 (cr-mta-lb-1.cr-mta-net [104.47.1.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A1F32F0B-455B-4375-8A5A-B3D7B14B85E0.1;
        Wed, 14 Aug 2019 08:10:37 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5d8e972d1d06.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 14 Aug 2019 08:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/4MVpyqB4vFbg+ZzHseyyCvOoJAsH3iy43ugJCvtO/nnJn8H+q9PnkwFSaeVs90WIRjXutF+iUp0XP9UBvKevPsZHzL1FhyyBCAQ6ttvorXAkrdByz2iElZL5bDHtcNKfEkcoaFVDTNj6x2JAket9Tt5/z2srYFTkUQ4GV62PTWHq4rXgXYL1PE+N516/r3+GXLVpQQjcGYRkc7S1N0pljqmG1uERt56s3YK4Mc3hHyhZ5YJ9DNdcHyBGFpLhtW36gtU5tsC+SKM0J8R8tjT/VjlewINBlXFPzRQ6eBJwQZWrCzk8HgWy8ouSndFk63+61DYZbllCJqeqyswnz+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5plvyXDuYHwdMq6GgqYT/Jcu0D+sseOyN3TPyqZ45qg=;
 b=KfKP1YiM8gKq2MxqvpHkzCetKEyxvi1CZlBqJeszsmDlwSesiU3boFajgXQ1QMc6c+EuAwhdJTQ6i80bFBANTDSBCUU/jLkXaGXg79vnBnbuc7J0sZl6T/mgip657fBy0ne0MoyMWtTz8euG9IvklDF7s2JfYjOyGmzGWfdbzHo6b6IN5/1ireLOQ4FzjqGB6aJ8R0MCjkAoAwVl0vBYGazjk2NU068vwcwvHtnIIq5NlVb5zPkmbRQShOpH8ObJele5OT5+J1MJbQ1Nn7D6o4w0E99GXOFY6QwQhazfk+x7GDAezxq70jitbU1m3VCbKuQBr/fW1Nm4507b6bR1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5plvyXDuYHwdMq6GgqYT/Jcu0D+sseOyN3TPyqZ45qg=;
 b=HA6isbssB3dnCYoS/ziUjj4TJ3CvZjiDaS+MfkOe2QHDsjMT2+Ztjr5D+xhVdxbeV0cn4EwjBQ9WrPyCSqQlWr0L90aKU6Y0jMpro4x4XS3O/D9m+0+ewHG4sUmm0pkOqqYLTTKtisR9KuY09O1KiOCeEgbzj8I/TSpfh0qw2DI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4864.eurprd08.prod.outlook.com (10.255.113.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Wed, 14 Aug 2019 08:10:34 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 08:10:34 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
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
Subject: Re: [PATCH v2 4/4] drm/komeda: Enable Layer color management for
 komeda
Thread-Topic: [PATCH v2 4/4] drm/komeda: Enable Layer color management for
 komeda
Thread-Index: AQHVUZNyccESoC2zR0ORWyBtwFKZLKb42rUAgAFxmoA=
Date:   Wed, 14 Aug 2019 08:10:34 +0000
Message-ID: <20190814081027.GB24984@jamwan02-TSP300>
References: <20190813045536.28239-1-james.qian.wang@arm.com>
 <20190813045536.28239-5-james.qian.wang@arm.com>
 <3251837.i0RyjatB9e@e123338-lin>
In-Reply-To: <3251837.i0RyjatB9e@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3833160a-afca-4e5e-24d5-08d7208eeaed
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4864;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4864:|HE1PR0802MB2603:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB26030E52559BDD8D3171BAEBB3AD0@HE1PR0802MB2603.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01294F875B
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(6512007)(33656002)(7736002)(6636002)(6436002)(9686003)(33716001)(6306002)(6486002)(229853002)(66066001)(5660300002)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(966005)(11346002)(446003)(8676002)(71190400001)(305945005)(386003)(476003)(71200400001)(6506007)(102836004)(486006)(81156014)(52116002)(256004)(30864003)(1076003)(53936002)(14444005)(54906003)(99286004)(58126008)(6862004)(6116002)(316002)(478600001)(25786009)(76176011)(2906002)(6246003)(55236004)(3846002)(14454004)(186003)(4326008)(26005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4864;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: O8Mn/pSSTh5v3mFiAKcmIO2l6z6/g3htLODqkLS72gVUbhsbi3upjQJ5PF8oaIdPmqIrMvFbVmdoYaFGxAaxJKwQk1ZShxLdsAkP89l4zAcVD9ZUJr7GZrUJKf2LPHi7zDb+lmU8zP90pzsRZFhiWzSV9IwFFE/M0EiQ6fFoHY/0af4jjKi6sKtyL/LeuJMfbSbJQIgOWLfCzi7kbjCfvrHFh6fSHjK/UUk/JXx5wf0agxMyRz0UCOVJff3DlHHolW1zqu8l7QyuaBsJmUMJ6Vi0pyMMYBL9/kFfzpQ+WvXv/kqLU0eUzijkhrkNyAJRDDJlMvXn+o4lMLfgcoTuNOq2ZobmpSmbwZ7FqNIYggaSjuPQJNFpR+MeRmftShKmgfC37yEs7K4c+BxH8Waq7S1/TOyLncMM0r8bUBm1Vl4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A19C9DC2ECE5C4D9A7DD174615B3AB8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4864
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT021.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(189003)(199004)(63350400001)(8746002)(81166006)(1076003)(63370400001)(2906002)(70206006)(126002)(486006)(336012)(33656002)(70586007)(8936002)(6636002)(7736002)(5660300002)(6862004)(66066001)(446003)(81156014)(476003)(305945005)(3846002)(11346002)(30864003)(23726003)(6116002)(25786009)(46406003)(8676002)(97756001)(4326008)(22756006)(6512007)(316002)(356004)(54906003)(50466002)(14444005)(36906005)(58126008)(33716001)(6486002)(26826003)(186003)(76130400001)(76176011)(26005)(478600001)(99286004)(47776003)(6246003)(86362001)(102836004)(386003)(6306002)(9686003)(6506007)(966005)(229853002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2603;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e81e2b06-e419-4478-3bc9-08d7208ee19f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR0802MB2603;
NoDisclaimer: True
X-Forefront-PRVS: 01294F875B
X-Microsoft-Antispam-Message-Info: WtudVWD5qbDf7W+xjE1yV/49Gj4AOLNf3qs61+R4q7t97sWEgW7rSxONHocVLPUHM4TYoO1/s8oNGvL5p8fe5TKbr3aQdBvR81GRA9xjkN1uRnsdySRqxAe9yzfcJU7igS7WWwX2YXFe633hTBoww0X/JCaHqWdQpAEgA55ETqKUU5JclilIJEMKfJrLYwYvvr/cgGpWT+diXLNEc+ekfahhSMWTVRdFti5K0vnhFtXyTlFoFmZZ7ZFYSYU0og2iwboy6A35lVcT6c5w5/sfQ2Oi49lIjZoxQb2NbzdRbtHL0E2udp9gveQCWtkbvZ3dL7YkLsh7K0sliT3gkHgx+bDftPELj+TxaKe8J0/XYNjbVDE6RBrO07cSAxo/75OqE7lVku0Wup1JOP3f5IVdcNlRjiDKUDVw3IbgGkny0oo=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2019 08:10:49.4148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3833160a-afca-4e5e-24d5-08d7208eeaed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:07:36AM +0000, Mihail Atanassov wrote:
> Hi James,
>=20
> On Tuesday, 13 August 2019 05:56:19 BST james qian wang (Arm Technology C=
hina) wrote:
> > - D71 has 3 global layer gamma table which can be used for all layers a=
s
> >   gamma lookup table, no matter inverse or forward.
> > - Add komeda_color_manager/state to layer/layer_state for describe the
> >   color caps for the specific layer which will be initialized in
> >   d71_layer_init, and for D71 only layer with L_INFO_CM (color mgmt) bi=
t
> >   can support forward gamma, and CSC.
> > - Update komeda-CORE code to validate and convert the plane color state=
 to
> >   komeda_color_state.
> > - Enable plane color mgmt according to layer komeda_color_manager
> >=20
> > This patch depends on:
> > - https://patchwork.freedesktop.org/series/30876/
> >=20
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  .../arm/display/komeda/d71/d71_component.c    | 64 +++++++++++++++++++
> >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  5 +-
> >  .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |  2 +
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |  4 +-
> >  .../display/komeda/komeda_pipeline_state.c    | 53 ++++++++++++++-
> >  .../gpu/drm/arm/display/komeda/komeda_plane.c | 12 ++++
> >  .../arm/display/komeda/komeda_private_obj.c   |  4 ++
> >  7 files changed, 139 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index 55a8cc94808a..c9c40a36e4d2 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -189,6 +189,46 @@ static void d71_layer_update_fb(struct komeda_comp=
onent *c,
> >  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
> >  }
> > =20
> > +static u32 d71_layer_update_color(struct drm_plane_state *st,
> > +				  u32 __iomem *reg,
> > +				  struct komeda_color_state *color_st,
> > +				  u32 *mask)
> > +{
> > +	struct komeda_coeffs_table *igamma =3D color_st->igamma;
> > +	struct komeda_coeffs_table *fgamma =3D color_st->fgamma;
> > +	u32 ctrl =3D 0, v =3D 0;
> > +
> > +	if (!st->color_mgmt_changed)
> > +		return 0;
> > +
> > +	*mask |=3D L_IT | L_R2R | L_FT;
> > +
> > +	if (igamma) {
> > +		komeda_coeffs_update(igamma);
> > +		ctrl |=3D L_IT;
> > +		v =3D L_ITSEL(igamma->hw_id);
> > +	}
> > +
> > +	if (st->ctm) {
> > +		u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
> > +
> > +		drm_ctm_to_coeffs(st->ctm, ctm_coeffs);
> > +		malidp_write_group(reg, LAYER_RGB_RGB_COEFF0,
> > +				   ARRAY_SIZE(ctm_coeffs),
> > +				   ctm_coeffs);
> > +		ctrl |=3D L_R2R; /* enable RGB2RGB conversion */
> > +	}
> > +
> > +	if (fgamma) {
> > +		komeda_coeffs_update(fgamma);
> > +		ctrl |=3D L_FT;
> > +		v |=3D L_FTSEL(fgamma->hw_id);
> > +	}
> > +
> > +	malidp_write32(reg, LAYER_LT_COEFFTAB, v);
> > +	return ctrl;
> > +}
> > +
> >  static void d71_layer_disable(struct komeda_component *c)
> >  {
> >  	malidp_write32_mask(c->reg, BLK_CONTROL, L_EN, 0);
> > @@ -261,6 +301,8 @@ static void d71_layer_update(struct komeda_componen=
t *c,
> > =20
> >  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
> > =20
> > +	ctrl |=3D d71_layer_update_color(plane_st, reg, &st->color_st, &ctrl_=
mask);
> > +
> >  	if (kfb->is_va)
> >  		ctrl |=3D L_TBU_EN;
> >  	malidp_write32_mask(reg, BLK_CONTROL, ctrl_mask, ctrl);
> > @@ -365,6 +407,12 @@ static int d71_layer_init(struct d71_dev *d71,
> >  	else
> >  		layer->layer_type =3D KOMEDA_FMT_SIMPLE_LAYER;
> > =20
> > +	layer->color_mgr.igamma_mgr =3D d71->glb_lt_mgr;
> > +	if (layer_info & L_INFO_CM) {
> > +		layer->color_mgr.has_ctm =3D true;
> > +		layer->color_mgr.fgamma_mgr =3D d71->glb_lt_mgr;
> > +	}
> > +
> >  	set_range(&layer->hsize_in, 4, d71->max_line_size);
> >  	set_range(&layer->vsize_in, 4, d71->max_vsize);
> > =20
> > @@ -1140,6 +1188,21 @@ static int d71_timing_ctrlr_init(struct d71_dev =
*d71,
> >  	return 0;
> >  }
> > =20
> > +static void d71_gamma_update(struct komeda_coeffs_table *table)
> > +{
> > +	malidp_write_group(table->reg, GLB_LT_COEFF_DATA,
> > +			   GLB_LT_COEFF_NUM, table->coeffs);
> > +}
> > +
> > +static int d71_lt_coeff_init(struct d71_dev *d71,
> > +			     struct block_header *blk, u32 __iomem *reg)
> > +{
> > +	struct komeda_coeffs_manager *mgr =3D d71->glb_lt_mgr;
> > +	int hw_id =3D BLOCK_INFO_TYPE_ID(blk->block_info);
> > +
> > +	return komeda_coeffs_add(mgr, hw_id, reg, d71_gamma_update);
> > +}
> > +
> >  int d71_probe_block(struct d71_dev *d71,
> >  		    struct block_header *blk, u32 __iomem *reg)
> >  {
> > @@ -1202,6 +1265,7 @@ int d71_probe_block(struct d71_dev *d71,
> >  		break;
> > =20
> >  	case D71_BLK_TYPE_GLB_LT_COEFF:
> > +		err =3D d71_lt_coeff_init(d71, blk, reg);
> >  		break;
> > =20
> >  	case D71_BLK_TYPE_GLB_SCL_COEFF:
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers=
/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > index d567ab7ed314..edd5d7c7f2a2 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > @@ -341,7 +341,7 @@ static int d71_enum_resources(struct komeda_dev *md=
ev)
> >  	struct komeda_pipeline *pipe;
> >  	struct block_header blk;
> >  	u32 __iomem *blk_base;
> > -	u32 i, value, offset;
> > +	u32 i, value, offset, coeffs_size;
> >  	int err;
> > =20
> >  	d71 =3D devm_kzalloc(mdev->dev, sizeof(*d71), GFP_KERNEL);
> > @@ -398,6 +398,9 @@ static int d71_enum_resources(struct komeda_dev *md=
ev)
> >  		d71->pipes[i] =3D to_d71_pipeline(pipe);
> >  	}
> > =20
> > +	coeffs_size =3D GLB_LT_COEFF_NUM * sizeof(u32);
> > +	d71->glb_lt_mgr =3D komeda_coeffs_create_manager(coeffs_size);
> > +
> >  	/* loop the register blks and probe */
> >  	i =3D 2; /* exclude GCU and PERIPH */
> >  	offset =3D D71_BLOCK_SIZE; /* skip GCU */
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h b/drivers=
/gpu/drm/arm/display/komeda/d71/d71_dev.h
> > index 84f1878b647d..009c164a1584 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
> > @@ -39,6 +39,8 @@ struct d71_dev {
> >  	u32 __iomem	*periph_addr;
> > =20
> >  	struct d71_pipeline *pipes[D71_MAX_PIPELINE];
> > +	 /* global layer transform coefficient table manager */
> > +	struct komeda_coeffs_manager *glb_lt_mgr;
> >  };
> > =20
> >  #define to_d71_pipeline(x)	container_of(x, struct d71_pipeline, base)
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index a7a84e66549d..4104c81e5032 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/types.h>
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> > +#include "komeda_color_mgmt.h"
> >  #include "malidp_utils.h"
> > =20
> >  #define KOMEDA_MAX_PIPELINES		2
> > @@ -226,6 +227,7 @@ struct komeda_layer {
> >  	struct komeda_component base;
> >  	/* accepted h/v input range before rotation */
> >  	struct malidp_range hsize_in, vsize_in;
> > +	struct komeda_color_manager color_mgr;
> >  	u32 layer_type; /* RICH, SIMPLE or WB */
> >  	u32 supported_rots;
> >  	/* komeda supports layer split which splits a whole image to two part=
s
> > @@ -238,7 +240,7 @@ struct komeda_layer {
> > =20
> >  struct komeda_layer_state {
> >  	struct komeda_component_state base;
> > -	/* layer specific configuration state */
> > +	struct komeda_color_state color_st;
> >  	u16 hsize, vsize;
> >  	u32 rot;
> >  	u16 afbc_crop_l;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index ea26bc9c2d00..803715c1128e 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -95,6 +95,21 @@ komeda_pipeline_get_state_and_set_crtc(struct komeda=
_pipeline *pipe,
> >  	return st;
> >  }
> > =20
> > +static bool komeda_component_is_new_active(struct komeda_component *c,
> > +					   struct drm_atomic_state *state)
> > +{
> > +	struct komeda_pipeline_state *ppl_old_st;
> > +
> > +	ppl_old_st =3D komeda_pipeline_get_old_state(c->pipeline, state);
> > +	if (IS_ERR(ppl_old_st))
> > +		return true;
> > +
> > +	if (has_bit(c->id, ppl_old_st->active_comps))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static struct komeda_component_state *
> >  komeda_component_get_state(struct komeda_component *c,
> >  			   struct drm_atomic_state *state)
> > @@ -279,6 +294,29 @@ komeda_rotate_data_flow(struct komeda_data_flow_cf=
g *dflow, u32 rot)
> >  	}
> >  }
> > =20
> > +static int
> > +komeda_validate_plane_color(struct komeda_component *c,
> > +			    struct komeda_color_manager *color_mgr,
> > +			    struct komeda_color_state *color_st,
> > +			    struct drm_plane_state *plane_st)
> > +{
> > +	int err;
> > +
> > +	if (komeda_component_is_new_active(c, plane_st->state))
> > +		plane_st->color_mgmt_changed =3D true;
> > +
> > +	if (!plane_st->color_mgmt_changed)
> > +		return 0;
> > +
> > +	err =3D komeda_color_validate(color_mgr, color_st,
> > +				    plane_st->degamma_lut,
> > +				    plane_st->gamma_lut);
> > +	if (err)
> > +		DRM_DEBUG_ATOMIC("%s validate color failed.\n", c->name);
> > +
> > +	return err;
> > +}
> > +
> >  static int
> >  komeda_layer_check_cfg(struct komeda_layer *layer,
> >  		       struct komeda_fb *kfb,
> > @@ -362,6 +400,11 @@ komeda_layer_validate(struct komeda_layer *layer,
> >  		st->addr[i] =3D komeda_fb_get_pixel_addr(kfb, dflow->in_x,
> >  						       dflow->in_y, i);
> > =20
> > +	err =3D komeda_validate_plane_color(&layer->base, &layer->color_mgr,
> > +					  &st->color_st, plane_st);
> > +	if (err)
> > +		return err;
> > +
> >  	err =3D komeda_component_validate_private(&layer->base, c_st);
> >  	if (err)
> >  		return err;
> > @@ -1177,7 +1220,7 @@ komeda_pipeline_unbound_components(struct komeda_=
pipeline *pipe,
> >  {
> >  	struct drm_atomic_state *drm_st =3D new->obj.state;
> >  	struct komeda_pipeline_state *old =3D priv_to_pipe_st(pipe->obj.state=
);
> > -	struct komeda_component_state *c_st;
> > +	struct komeda_component_state *st;
> >  	struct komeda_component *c;
> >  	u32 disabling_comps, id;
> > =20
> > @@ -1188,9 +1231,13 @@ komeda_pipeline_unbound_components(struct komeda=
_pipeline *pipe,
> >  	/* unbound all disabling component */
> >  	dp_for_each_set_bit(id, disabling_comps) {
> >  		c =3D komeda_pipeline_get_component(pipe, id);
> > -		c_st =3D komeda_component_get_state_and_set_user(c,
> > +		st =3D komeda_component_get_state_and_set_user(c,
> >  				drm_st, NULL, new->crtc);
> > -		WARN_ON(IS_ERR(c_st));
> > +
> > +		WARN_ON(IS_ERR(st));
> I think this needs to be:
> if (WARN_ON(IS_ERR(st)))
>         continue;
> ...because...
> > +
> > +		if (has_bit(id, KOMEDA_PIPELINE_LAYERS))
> > +			komeda_color_cleanup_state(&to_layer_st(st)->color_st);
> ... this may deref an invalid `st' otherwise.

Because I don't real think unbound will return a error, so just a lazy
WARN_ON for the error handling. :)

But you are right. here we check the error we need to handle it
correctly. will refine the logic as you suggested.

thanks
james

> >  	}
> >  }
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/driver=
s/gpu/drm/arm/display/komeda/komeda_plane.c
> > index 98e915e325dd..69fa1dea41c9 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > @@ -11,6 +11,7 @@
> >  #include "komeda_dev.h"
> >  #include "komeda_kms.h"
> >  #include "komeda_framebuffer.h"
> > +#include "komeda_color_mgmt.h"
> > =20
> >  static int
> >  komeda_plane_init_data_flow(struct drm_plane_state *st,
> > @@ -250,6 +251,7 @@ static int komeda_plane_add(struct komeda_kms_dev *=
kms,
> >  {
> >  	struct komeda_dev *mdev =3D kms->base.dev_private;
> >  	struct komeda_component *c =3D &layer->base;
> > +	struct komeda_color_manager *color_mgr;
> >  	struct komeda_plane *kplane;
> >  	struct drm_plane *plane;
> >  	u32 *formats, n_formats =3D 0;
> > @@ -306,6 +308,16 @@ static int komeda_plane_add(struct komeda_kms_dev =
*kms,
> >  	if (err)
> >  		goto cleanup;
> > =20
> > +	err =3D drm_plane_color_create_prop(plane->dev, plane);
> > +	if (err)
> > +		goto cleanup;
> > +
> > +	color_mgr =3D &layer->color_mgr;
> > +	drm_plane_enable_color_mgmt(plane,
> > +			color_mgr->igamma_mgr ? KOMEDA_COLOR_LUT_SIZE : 0,
> > +			color_mgr->has_ctm,
> > +			color_mgr->fgamma_mgr ? KOMEDA_COLOR_LUT_SIZE : 0);
> > +
> >  	err =3D drm_plane_create_zpos_property(plane, layer->base.id, 0, 8);
> >  	if (err)
> >  		goto cleanup;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/=
drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > index 914400c4af73..4c474663f554 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > @@ -19,12 +19,15 @@ komeda_component_state_reset(struct komeda_componen=
t_state *st)
> >  static struct drm_private_state *
> >  komeda_layer_atomic_duplicate_state(struct drm_private_obj *obj)
> >  {
> > +	struct komeda_layer_state *old =3D to_layer_st(priv_to_comp_st(obj->s=
tate));
> >  	struct komeda_layer_state *st;
> > =20
> >  	st =3D kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
> >  	if (!st)
> >  		return NULL;
> > =20
> > +	komeda_color_duplicate_state(&st->color_st, &old->color_st);
> > +
> >  	komeda_component_state_reset(&st->base);
> >  	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->base.obj);
> > =20
> > @@ -37,6 +40,7 @@ komeda_layer_atomic_destroy_state(struct drm_private_=
obj *obj,
> >  {
> >  	struct komeda_layer_state *st =3D to_layer_st(priv_to_comp_st(state))=
;
> > =20
> > +	komeda_color_cleanup_state(&st->color_st);
> >  	kfree(st);
> >  }
> > =20
> >=20
>=20
> BR,
> Mihail
>=20
>=20
