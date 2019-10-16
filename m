Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FCFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D04A20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Q0YNch8z";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Q0YNch8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406141AbfJPQW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:22:27 -0400
Received: from mail-eopbgr40071.outbound.protection.outlook.com ([40.107.4.71]:31553
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfJPQW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwAVU8DMBRXoCxI4Y5ThhDt7ZZgwbBWLo+ACfp2m2GE=;
 b=Q0YNch8zhNJveZ53+6eveRcqBvh13eVzLRZnZ3hwG81JyLLZSnDognk7AxkVJaC9rz+4XpXv7i1DNAXi5WB7zOa4HN2aouoTjMKiHboljdidZN9dutbFvs6groHRu5ifZEKscjrvtbDXFd0Az+X3djw4rqa0CBjqTbEul1oMsmQ=
Received: from VI1PR08CA0259.eurprd08.prod.outlook.com (2603:10a6:803:dc::32)
 by AM0PR08MB4084.eurprd08.prod.outlook.com (2603:10a6:208:129::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Wed, 16 Oct
 2019 16:22:21 +0000
Received: from DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR08CA0259.outlook.office365.com
 (2603:10a6:803:dc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 16:22:20 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT057.mail.protection.outlook.com (10.152.20.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 16:22:19 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Wed, 16 Oct 2019 16:22:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dea8a41f654d0657
X-CR-MTA-TID: 64aa7808
Received: from 19d2d4a07253.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 94619A02-F8EF-4356-82CD-17337E33A3C5.1;
        Wed, 16 Oct 2019 16:22:10 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 19d2d4a07253.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 16:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUK6cBXUzubK2gKO7ycUM0MKVx/74tRDV5lagyAswI6YXo+9RPAKI/iV2CFDqTW2aqggolIoI2j0vexBhVYbGm4D9pf17we0IVUpK5X+ss3aSK6zJFDu4fy1aTRAVhRHp46NZ9fQGOBsPzoEVYAZPacg7RcSgWXSdzBphqRz+DVa+48xfHvfT+bLI4LxNJDtHhS4FzvfQbfwmGsC00GnNUBkZ8i1c5RwURzOzEg2GlMCDgvGDug5NwlUddpx/JRWfjapzGv/AECWJYWVBhethBmQxfSuC5UCX/0VrzdBBBueSEf5qX6XE1UkzXFrfvFFRB5zoRJkSHp+YJ/3/dr/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwAVU8DMBRXoCxI4Y5ThhDt7ZZgwbBWLo+ACfp2m2GE=;
 b=ICoybZbMW8R8ia/+RweapZIdZQcEW8t5SNgiwtMMgJiRF96n6+z9TvlVqLhuEz8a32cm/SaOI/fo3zt1L2W9mDo+Ct5Ts8SoalebXwU0jInoH++YaK/SJ/Wlj+GRYMGpnzNitSvFSFc1drpeWv1cSDGPs+uVflUDJbDaLwiT/2741Xukc1ZT0WZbLFAmaw4NaPl19j968L74yc+vRnn62ZszN2BRXKclNPx8umH9rv0GAKJpJR64/oXvDVczEwRmNP/AeMAoZrMdbT9kMBssMCoIVAKJ8ed0T5EZtrH9P0fKL+0zAOUpFF4wKRF74XdyukSBYpiwEmv7dioS8XLgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwAVU8DMBRXoCxI4Y5ThhDt7ZZgwbBWLo+ACfp2m2GE=;
 b=Q0YNch8zhNJveZ53+6eveRcqBvh13eVzLRZnZ3hwG81JyLLZSnDognk7AxkVJaC9rz+4XpXv7i1DNAXi5WB7zOa4HN2aouoTjMKiHboljdidZN9dutbFvs6groHRu5ifZEKscjrvtbDXFd0Az+X3djw4rqa0CBjqTbEul1oMsmQ=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3877.eurprd08.prod.outlook.com (20.178.89.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 16:22:08 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 16:22:08 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Topic: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Thread-Index: AQHVhDme1+iX/Utgt0y74txJGijIlKddc0AA
Date:   Wed, 16 Oct 2019 16:22:07 +0000
Message-ID: <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
In-Reply-To: <5390495.Gzyn2rW8Nj@e123338-lin>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: AM4PR08CA0077.eurprd08.prod.outlook.com
 (2603:10a6:205:2::48) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 010478e7-004e-44c1-dc81-08d75255044c
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3877:|AM6PR08MB3877:|AM0PR08MB4084:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB408444E99FAAA6E9E0472FC8F0920@AM0PR08MB4084.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(8936002)(66446008)(71190400001)(14454004)(256004)(6436002)(6116002)(71200400001)(3846002)(186003)(86362001)(102836004)(81156014)(81166006)(8676002)(66946007)(478600001)(5024004)(6246003)(66066001)(6486002)(9686003)(64756008)(66556008)(66476007)(6862004)(6512007)(229853002)(316002)(99286004)(52116002)(4326008)(7736002)(76176011)(5660300002)(386003)(305945005)(26005)(44832011)(476003)(11346002)(6636002)(2906002)(6506007)(446003)(58126008)(1076003)(54906003)(25786009)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3877;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rbND41QvIK+LVw6GvQYKy1/yY3STh9OqbjdrXzjE3FyS5QhmNwz/o//72+Rkm8hW0V0MlWYgJ/SB8K4XLvY6qYkhNSFhA1DouXYsBWJMNC0RwD5mUPgGQe691t1jUVIV0uzmJsDHm7bxvzenF0C8dW930CDUzLbXNClk2TU2UhW8VB2YAo3LyVlR6wq9eUNWRzOI/AuHLFyRCnskegJ7d2Ukh7BsnequGgIXuQ3bePpIfK8rI+X99t6qQ/vXhRJRMKAtESxecTB0K5k5TjfmSGGKrcZj8onDPHzMJtgf4K3eWrAjT2j0ejHI+HGlbXdZ58YAGZncb6+ixCkuqsiD/sA+b8o+OvuHZJoOR+DANVrtJJ+mDI85+E4eK32ZcswDzuPB7FlR2qWlmcmdRGGe+lQJ2jt+OTlOC0OPqy5+gU0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBEBC93168CBA34FAB6A62F3A77C54FC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3877
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(14454004)(1076003)(50466002)(99286004)(26005)(186003)(86362001)(478600001)(97756001)(316002)(26826003)(54906003)(356004)(102836004)(58126008)(386003)(6506007)(47776003)(25786009)(66066001)(76176011)(5660300002)(22756006)(3846002)(446003)(6116002)(23726003)(476003)(6636002)(2906002)(6486002)(5024004)(336012)(486006)(126002)(6862004)(7736002)(107886003)(6246003)(4326008)(229853002)(305945005)(11346002)(8676002)(8746002)(81156014)(81166006)(8936002)(46406003)(9686003)(6512007)(70586007)(70206006)(76130400001)(63350400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4084;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3f12aae1-6b2f-473b-569f-08d75254fd5f
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkNrX00/dS0N1sKX5VtmPc9sJ1aBzUG8y1b+K0pQAf4X1LJe0WQpzaegCpveOKFVbVm6F+1vUTQtDU8Y9dmFq0/q/+JLEaylXwcBrV+5xh2Yc8a7xTVSnGlY45bghAgM4FqyP8M/mNKGf9vkx8Z8b3Ui5qkBCSeJwgsZpaFg8h0qgOOgB3VlTlxzdU9tDGmSylwLMBT8xSFwhvyeJlSfhth7iXzy78GMl9C4/9DpaTtTypw3w2vvZgMRstZVuQiEGhRVanwvL/mI9MHe4pdgIA8XEkxXY/lJnyT/QjRuyZxT0DrdNQvDk57cF1x3NQ2y/x8qkCP8gg+enCQBfhJStAG12GXqLL75KcnYXKTlWIW0RQcOwfzdktfPYDrVLwrw6nSqDKC/Gegs90otC5/RZn7FGEB1IB6JEKQ9P7c0hUY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 16:22:19.3557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010478e7-004e-44c1-dc81-08d75255044c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 16, 2019 at 03:51:39PM +0000, Mihail Atanassov wrote:
> Hi James,
>=20
> On Wednesday, 9 October 2019 06:54:15 BST james qian wang (Arm Technology=
 China) wrote:
> > On Fri, Oct 04, 2019 at 02:34:42PM +0000, Mihail Atanassov wrote:
> > > To support transmitters other than the tda998x, we need to allow
> > > non-component framework bridges to be attached to a dummy drm_encoder=
 in
> > > our driver.
> > >=20
> > > For the existing supported encoder (tda998x), keep the behaviour as-i=
s,
> > > since there's no way to unbind if a drm_bridge module goes away under
> > > our feet.
> > >=20
> > > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > > ---
> > >  .../gpu/drm/arm/display/komeda/komeda_dev.h   |   5 +
> > >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  58 ++++++--
> > >  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 133 ++++++++++++++++=
+-
> > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |   5 +
> > >  4 files changed, 187 insertions(+), 14 deletions(-)
> > >=20
> > > [snip]
> > > =20
> > > +static void komeda_encoder_destroy(struct drm_encoder *encoder)
> > > +{
> > > +	drm_encoder_cleanup(encoder);
> > > +}
> > > +
> > > +static const struct drm_encoder_funcs komeda_dummy_enc_funcs =3D {
> > > +	.destroy =3D komeda_encoder_destroy,
> > > +};
> > > +
> > > +bool komeda_remote_device_is_component(struct device_node *local,
> > > +				       u32 port, u32 endpoint)
> > > +{
> > > +	struct device_node *remote;
> > > +	char const * const component_devices[] =3D {
> > > +		"nxp,tda998x",
> >=20
> > I really don't think put this dummy_encoder into komeda is a good
> > idea.
> >=20
> > And I suggest to seperate this dummy_encoder to a individual module
> > which will build the drm_ridge to a standard drm encoder and component
> > based module, which will be enable by DT, totally transparent for komed=
a.
> >=20
> > BTW:
> > I really don't like such logic: distingush the SYSTEM configuration
> > by check the connected device name, it's hard to maintain and code
> > sharing, and that's why NOW we have the device-tree.

It's not ideal to have such special cases, for sure. However, I don't
see this approach causing us any issues. tda998x really is "special",
and as far as I can see the code here scales to other devices pretty
easily.

>=20
> +Cc Brian
>=20
> I didn't think DT is the right place for pseudo-devices.

I agree. DT should represent the HW, not the structure of the
linux kernel subsystem.

> The tda998x
> looks to be in a small group of drivers that contain encoder +
> bridge + connector; my impression of the current state of affairs is
> that the drm_encoder tends to live where the CRTC provider is rather
> than representing a HW entity (hence why drm_bridge based drivers
> exist in drivers/gpu/drm/bridge). See the overview DOC comment in
> drm_encoder.c ("drivers are free to use [drm_encoder] however they
> wish"). I may be completely wrong, so would appreciate some
> context and comment from others on the Cc list.
>=20
> In any case, converting a do-nothing dummy encoder into its own
> component-module will add a lot more bloat compared to the current
> ~10 SLoC implementation of the drm_encoder. probe/remove/bind/unbind,
> a few extra structs here and there, yet another object file, DT
> bindings, docs for the same, and maintaining all of that? It's a hard
> sell for me. I'd prefer if we went ahead with the code as-is and fix it
> up later if it really proves unwieldy and too hard to maintain. Could
> this patch be improved? Sure! Can we improve it in follow-up work
> though, as I think this is valuable enough on its own without any major
> drawbacks?
>=20

Even if we implemented a separate component encoder, as far as I can
tell there's no way to use it without either:

a) sticking it in DT
b) invoking it from komeda based on a "of_device_is_compatible" list

IMO a) isn't acceptable, and b) doesn't have any advantages over this
approach.

> As per my cover letter, in an ideal world we'd have the encoder locally
> and do drm_bridge_attach() even for tda998x, but the lifetime issues
> around bridges inside modules mean that doing that now is a bit of a
> step back for this specific case.
>=20

Yeah, my feeling is that being able to keep tda998x as a component
(for the superior bind/unbind behaviour) is worth the slight ugliness,
at least until bridges get the same functionality.

If James is strongly against merging this, maybe we just swap
wholesale to bridge? But for me, the pragmatic approach would be this
stop-gap.

Cheers,
-Brian

> >=20
> > Thanks
> > James
> >=20
> > > [snip]
> >=20
>=20
> --=20
> Mihail
>=20
>=20
>=20
