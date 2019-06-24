Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD26C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430D920674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ODw6DWkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfFXLXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:23:07 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:63393
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727722AbfFXLXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU5RfhzATYnNtEbzdJMlg5nJO49fQr6OkPY21klfCjA=;
 b=ODw6DWkrXfKmQzJie9qkjHYISE1j07zlDFs45LObIu6PhdoWNBdp9d2X6urbGNDWZlG+xqAmY90HadbrqbD04LZPF5zDlqATIjcZnI2cpk5iUoDQBHB2H6hgXX3xbcpfLgO/rzOk2c/dFc1GJ0u8YRZ4csCgVFG9FVW0K8Es+jk=
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com (20.178.13.156) by
 VI1PR08MB5293.eurprd08.prod.outlook.com (20.178.126.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 11:23:03 +0000
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::f00e:b5de:6aa:4a64]) by VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::f00e:b5de:6aa:4a64%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 11:23:03 +0000
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
Thread-Index: AQHVKBsKBvRwqAaS30eXmbt21cTJQqamO1MAgART94CAAAdigIAAF3uA
Date:   Mon, 24 Jun 2019 11:23:02 +0000
Message-ID: <20190624112301.dmczf2vofxnpzqqi@DESKTOP-E1NTVVP.localdomain>
References: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
 <CAKMK7uEjh+GrSy5AgbVLVQd1S5oJ8KFiWEUmxtMMVdcMSBtdCQ@mail.gmail.com>
 <20190624093233.73f3tcshewlbogli@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uG02qAqH8MMpE6kzRO99HTjnadTFDrY1vVr9RmAiFPvJA@mail.gmail.com>
In-Reply-To: <CAKMK7uG02qAqH8MMpE6kzRO99HTjnadTFDrY1vVr9RmAiFPvJA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LNXP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::28) To VI1PR08MB3696.eurprd08.prod.outlook.com
 (2603:10a6:803:b6::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e896d14c-d1c6-423e-c665-08d6f8965226
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB5293;
x-ms-traffictypediagnostic: VI1PR08MB5293:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB5293E22A088CA5422852CB99F0E00@VI1PR08MB5293.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(229853002)(7736002)(305945005)(2906002)(1076003)(81166006)(8676002)(81156014)(8936002)(71190400001)(71200400001)(4326008)(68736007)(66556008)(66476007)(66066001)(73956011)(5660300002)(86362001)(64756008)(66446008)(66946007)(25786009)(478600001)(44832011)(6306002)(386003)(6506007)(99286004)(6512007)(76176011)(9686003)(53546011)(486006)(256004)(6916009)(6436002)(6246003)(53386004)(6486002)(11346002)(476003)(14444005)(52116002)(6116002)(3846002)(53936002)(58126008)(316002)(54906003)(102836004)(186003)(26005)(966005)(72206003)(14454004)(446003)(587094005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5293;H:VI1PR08MB3696.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8FW0NZ9y6DT6mP22xdeO1UwP5wZKwoHwrPzA3kIBrcYKLCUz9LAnWsYnRN1yIbIbyovBsdbfADjjbInMVU41y8zV6y/PPzEewTiojcJUtrWrZCmiEdFB99eR97iAG+AqUQnh9GEoebWYMQynca9XgKnNAD0cI3f1IRRgOYI/pwxLg1e6mtvP6Bk1AYMnqOQFs/2Lgt+5PUeZSJNG6hiLv0L919r8VVUiKd8ktDpGuJMa0gHgQ6L2Iy4hSQeQssbES1vnD1GpqREAeKJS3IOy4V2QcMWuxayZWNcudk4sGhWcDPhpbJSVmo8v5nCwiP54BN1Y9mYfElQO77CJnur9IFzobTll/f9xeZ1tAZDl/8T0JnMyt7rRKVmPYLaYbqmjBGGpau6bhjlf3BnM1cBZYZo37VyJc+ZmtOvXti3DtjQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE26A5E2E77051458B19FA94DBC13C81@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e896d14c-d1c6-423e-c665-08d6f8965226
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 11:23:02.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:58:59AM +0200, Daniel Vetter wrote:
> On Mon, Jun 24, 2019 at 11:32 AM Brian Starkey <Brian.Starkey@arm.com> wr=
ote:
> >
> > Hi Daniel,
> >
> > On Fri, Jun 21, 2019 at 05:27:00PM +0200, Daniel Vetter wrote:
> > > On Fri, Jun 21, 2019 at 12:21 PM Raymond Smith <Raymond.Smith@arm.com=
> wrote:
> > > >
> > > > Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
> > > > denote the 16x16 block u-interleaved format used in Arm Utgard and
> > > > Midgard GPUs.
> > > >
> > > > Signed-off-by: Raymond Smith <raymond.smith@arm.com>
> > > > ---
> > > >  include/uapi/drm/drm_fourcc.h | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_f=
ourcc.h
> > > > index 3feeaa3..8ed7ecf 100644
> > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > @@ -743,6 +743,16 @@ extern "C" {
> > > >  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> > > >
> > > >  /*
> > > > + * Arm 16x16 Block U-Interleaved modifier
> > > > + *
> > > > + * This is used by Arm Mali Utgard and Midgard GPUs. It divides th=
e image
> > > > + * into 16x16 pixel blocks. Blocks are stored linearly in order, b=
ut pixels
> > > > + * in the block are reordered.
> > > > + */
> > > > +#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
> > > > +       fourcc_mod_code(ARM, ((1ULL << 55) | 1))
> > >
> > > This seems to be an extremely random pick for a new number. What's th=
e
> > > thinking here? Aside from "doesnt match any of the afbc combos" ofc.
> > > If you're already up to having thrown away 55bits, then it's not goin=
g
> > > to last long really :-)
> > >
> > > I think a good idea would be to reserve a bunch of the high bits as
> > > some form of index (afbc would get index 0 for backwards compat). And
> > > then the lower bits would be for free use for a given index/mode. And
> > > the first mode is probably an enumeration, where possible modes simpl=
e
> > > get enumerated without further flags or anything.
> >
> > Yup, that's the plan:
> >
> >         (0 << 55): AFBC
> >         (1 << 55): This "non-category" for U-Interleaved
> >         (1 << 54): Whatever the next category is
> >         (3 << 54): Whatever comes after that
> >         (1 << 53): Maybe we'll get here someday
>=20
> Uh, so the index would be encoded with least-significant bit first,
> starting from bit55 downwards?=20

Yeah.

> Clever idea, but I think this needs a
> macro (or at least a comment). Not sure there's a ready-made bitmask
> mirror function for this stuff, works case we can hand-code it and
> extend every time we need one more bit encoded. Something like:
>=20
> MIRROR_U32((u & (BIT(0)) << 31 | (u & BIT(1) << 30 | ...)
>=20

Is it really worth it? People can just use the definitions as written
in drm_fourcc.h. I agree that we should have the high bits described
in a comment though.

> And then shift that to the correct place. Probably want an
>=20
> ARM_MODIFIER_ENCODE(space_idx, flags) macro which assembles everything.
>=20
> >         ...
> >
> > I didn't want to explicitly reserve some high bits, because we've no
> > idea how many to reserve. This way, we can assign exactly as many
> > high bits as we need, when we need them. If any of the "modes" start
> > encroaching towards the high bits, we'll have to make a decision at
> > that point.
> >
> > Also, this is the only U-Interleaved format (that I know of), so it's
> > not worth calling bit 55 "The U-Interleaved bit" because that would be
> > a waste of space. It's more like the "misc" bit, but that's not a
> > useful name to enshrine in UAPI.
>=20
> Yeah that's what I meant. Also better to explicitly reserve this, i.e.
>=20
> #define ARM_FBC_MODIFIER_SPACE 0
> #define ARM_MISC_MODIFIER_SPACE 1
>=20
> and then encode with the mirror trickery.
>=20

I don't really see the value in that either, it's just giving
userspace the opportunity to depend on more stuff: more future
headaches. So long as the 64-bit values are stable, that should be
enough.

> > Note that isn't the same as the "not-AFBC bit", because we may well
> > have something in the future which is neither AFBC nor "misc".
> >
> > We've been very careful in our code to enforce all
> > undefined/unrecognised bits to be zero, to ensure that this works.
> >
> > >
> > > The other bit: Would be real good to define the format a bit more
> > > precisely, including the layout within the tile.
> >
> > It's U-Interleaved, obviously ;-)
>=20
> :-) I mean full code exists in panfrost/lima, so this won't change
> anything really ...

Yeah, so for us to provide a more detailed description would require
another lengthy loop through our legal approval process, and I'm not
sure we can make a strong business case (which is what we need) for
why this is needed.

Of course, if someone happens to know the layout and wants to
contribute to this file... Then I don't know how ack/r-b would work in
that case, but I imagine the subsystem maintainer(s) might take issue
with us attempting to block that contribution.

Thanks,
-Brian

>=20
> Cheers, Daniel
>=20
> >
> > -Brian
> >
> > >
> > > Also ofc needs acks from lima/panfrost people since I assume they'll
> > > be using this, too.
> > >
> > > Thanks, Daniel
> > >
> > > > +
> > > > +/*
> > > >   * Allwinner tiled modifier
> > > >   *
> > > >   * This tiling mode is implemented by the VPU found on all Allwinn=
er platforms,
> > > > --
> > > > 2.7.4
> > > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>=20
>=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
