Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76257C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34033205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0HT1Uv1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfFXJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:32:40 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:58624
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfFXJck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv5Xqog5f/Dc9maPP2LdqiIYxbtPDzmV6HbKrukCNDU=;
 b=0HT1Uv1IdM8VE0Nc4gRRUPkJhD7Y9Z5cqIQop2EPOXpLUYMZjLtmLAAbqa1/CXbs0kC/UjuYaBXnNYJBMZedD5UmDHZUOWmG2ItcTggobOYb2XC0z2gi7/1YPkujY89IZH0NnOtgNsxQBTKVL95ELntOmnG1QUlM6yvMVC1cFow=
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com (20.178.13.156) by
 VI1PR08MB3118.eurprd08.prod.outlook.com (52.133.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Mon, 24 Jun 2019 09:32:35 +0000
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::f00e:b5de:6aa:4a64]) by VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::f00e:b5de:6aa:4a64%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:32:35 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Raymond Smith <Raymond.Smith@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuq825@gmail.com" <yuq825@gmail.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVKBsKBvRwqAaS30eXmbt21cTJQqamO1MAgART94A=
Date:   Mon, 24 Jun 2019 09:32:35 +0000
Message-ID: <20190624093233.73f3tcshewlbogli@DESKTOP-E1NTVVP.localdomain>
References: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
 <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0086.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::26) To VI1PR08MB3696.eurprd08.prod.outlook.com
 (2603:10a6:803:b6::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5c4cdfa-ffeb-40fa-6607-08d6f886e3be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3118;
x-ms-traffictypediagnostic: VI1PR08MB3118:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB3118843B1B8A5ED1AC0A63D7F0E00@VI1PR08MB3118.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(66476007)(53936002)(7736002)(6486002)(102836004)(99286004)(52116002)(14454004)(6506007)(81166006)(8676002)(72206003)(81156014)(76176011)(316002)(6916009)(8936002)(53546011)(44832011)(26005)(966005)(6246003)(476003)(2906002)(54906003)(186003)(11346002)(486006)(446003)(58126008)(9686003)(6116002)(3846002)(6512007)(256004)(229853002)(305945005)(6436002)(1076003)(14444005)(386003)(25786009)(478600001)(6306002)(5660300002)(71200400001)(66066001)(68736007)(66446008)(86362001)(66556008)(71190400001)(4326008)(73956011)(64756008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3118;H:VI1PR08MB3696.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UoPjhhq+tJbmaI6exE1fk9ud0O9pG/XLf2tS1mHYFeGaLBU3Rmnq7dXBY/ieKDm6Cjx/llt0iD2kl4DhV0XM1pLmb3n8DX96MAiff60+aiuEZfRQ+sc4D9nJrwbDXIv8JJeZ16M3hrzsSLDBNz3rPMShFQvFjhgGLe0vbUSGSnW9VNYnEYJMgMRFk6Ve0tqYxA/H1825sM3zjAvs3h5+etn7Bk1XZBqHekhHSoqA3HgxACSE8wwOCihXu7PM+41dJ3Mgh8lt3SdID1DxdblGykAtXKC4Txx+B+pNIzbVEdKwQ/+FihQEX2QyIGTzLExVEL3F733c31Qb1Hg3eWZlPX3GO0UiutmHcmJqcFCZ711YhNYJZ83+OHr+eubcUobet8o7W17pTw8ECvHlQKELIGjBdi4jTU4jzulAULuYZA8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C330A0BE0BC8B2479ECC7057B841D34C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c4cdfa-ffeb-40fa-6607-08d6f886e3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:32:35.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Jun 21, 2019 at 05:27:00PM +0200, Daniel Vetter wrote:
> On Fri, Jun 21, 2019 at 12:21 PM Raymond Smith <Raymond.Smith@arm.com> wr=
ote:
> >
> > Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> > denote the 16x16 block u-interleaved format used in Arm Utgard and
> > Midgard GPUs.
> >
> > Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> > ---
> >  include/uapi/drm/drm_fourcc.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourc=
c.h
> > index 3feeaa3..8ed7ecf 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -743,6 +743,16 @@ extern "C" {
> >  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> >
> >  /*
> > + * Arm 16x16 Block U-Interleaved modifier
> > + *
> > + * This is used by Arm Mali Utgard and Midgard GPUs. It divides the im=
age
> > + * into 16x16 pixel blocks. Blocks are stored linearly in order, but p=
ixels
> > + * in the block are reordered.
> > + */
> > +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> > +       fourcc_mod_code(ARM, ((1ULL << 55) | 1))
>=20
> This seems to be an extremely random pick for a new number. What's the
> thinking here? Aside from "doesnt match any of the afbc combos" ofc.
> If you're already up to having thrown away 55bits, then it's not going
> to last long really :-)
>=20
> I think a good idea would be to reserve a bunch of the high bits as
> some form of index (afbc would get index 0 for backwards compat). And
> then the lower bits would be for free use for a given index/mode. And
> the first mode is probably an enumeration, where possible modes simple
> get enumerated without further flags or anything.

Yup, that's the plan:

	(0 << 55): AFBC
	(1 << 55): This "non-category" for U-Interleaved
	(1 << 54): Whatever the next category is
	(3 << 54): Whatever comes after that
	(1 << 53): Maybe we'll get here someday
	...

I didn't want to explicitly reserve some high bits, because we've no
idea how many to reserve. This way, we can assign exactly as many
high bits as we need, when we need them. If any of the "modes" start
encroaching towards the high bits, we'll have to make a decision at
that point.

Also, this is the only U-Interleaved format (that I know of), so it's
not worth calling bit 55 "The U-Interleaved bit" because that would be
a waste of space. It's more like the "misc" bit, but that's not a
useful name to enshrine in UAPI.

Note that isn't the same as the "not-AFBC bit", because we may well
have something in the future which is neither AFBC nor "misc".

We've been very careful in our code to enforce all
undefined/unrecognised bits to be zero, to ensure that this works.

>=20
> The other bit: Would be real good to define the format a bit more
> precisely, including the layout within the tile.

It's U-Interleaved, obviously ;-)

-Brian

>=20
> Also ofc needs acks from lima/panfrost people since I assume they'll
> be using this, too.
>=20
> Thanks, Daniel
>=20
> > +
> > +/*
> >   * Allwinner tiled modifier
> >   *
> >   * This tiling mode is implemented by the VPU found on all Allwinner p=
latforms,
> > --
> > 2.7.4
> >
>=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
