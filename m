Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C227C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47496218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ivc+Ul8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfGEMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:40:09 -0400
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:20807
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbfGEMkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcIPkfPgE2cVcuJWZ7Ct8k3U3MKQPDpk+EXTeeCh7gQ=;
 b=ivc+Ul8vF6WnsS4euppmrJhi1RFcmKBbF5LfQZZsz1vkb9DPXgRQF1SB6Q1vLq4w5TEVF8+zDKPIEbkLzS7n7S7BeoDN4MG39OZhSL7SLY4ZoNwAQCnQgwUscq+9F7HUZ73bi8e4XY56hiLAByxdkAVcfdvioHh8WND7Prz3JBg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5086.eurprd08.prod.outlook.com (20.179.29.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 5 Jul 2019 12:40:03 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Fri, 5 Jul 2019
 12:40:03 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds VRR support
Thread-Topic: [PATCH] drm/komeda: Adds VRR support
Thread-Index: AQHVMXCZgYg0h2S+S0iZ8YXT6sjbY6a4qceAgAGhuICAAE+MAIABBx4AgABYdIA=
Date:   Fri, 5 Jul 2019 12:40:03 +0000
Message-ID: <20190705123955.GA17590@jamwan02-TSP300>
References: <1562138723-29546-1-git-send-email-lowry.li@arm.com>
 <20190703100149.GF15868@phenom.ffwll.local>
 <20190704105653.GB9747@jamwan02-TSP300>
 <20190704154136.gib3puo7dzivnasu@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uF14_B8uJL+o_BnWvUMk3BBXRrr+aipK3A9mt+0v2W_4g@mail.gmail.com>
In-Reply-To: <CAKMK7uF14_B8uJL+o_BnWvUMk3BBXRrr+aipK3A9mt+0v2W_4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::24) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 681e83fe-8f64-415e-2fd4-08d70145e64a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5086;
x-ms-traffictypediagnostic: VE1PR08MB5086:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <VE1PR08MB50865FBBD4805E732F18E2B8B3F50@VE1PR08MB5086.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6306002)(86362001)(8936002)(9686003)(6512007)(26005)(186003)(6486002)(53936002)(33716001)(14444005)(5024004)(256004)(30864003)(76176011)(53386004)(7736002)(1076003)(6246003)(587094005)(305945005)(966005)(6436002)(53546011)(81156014)(81166006)(446003)(229853002)(71200400001)(71190400001)(8676002)(11346002)(476003)(55236004)(102836004)(6506007)(386003)(52116002)(99286004)(3846002)(6116002)(478600001)(66066001)(68736007)(25786009)(486006)(4326008)(33656002)(5660300002)(2906002)(14454004)(316002)(54906003)(58126008)(66446008)(66556008)(73956011)(64756008)(66946007)(66476007)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5086;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zcgGSVWADu5NFQK6J9HrLRI6H3ezzOn7jpuert1DH+hPhRbkzAR15HQvzoBiDX15UlPPqIDUWhlpX7DxCNoeOhBJ5SGiWMTdouD86efNwUwd2V3B1wjIX3b8ftxQ7UPH51bruDingZUnm4eS+4QSW/Knjrj8xfSxbKZP/WQAxb1YQLwWae4j4KVMh3tSgwIl8AZlCjb5EP1TmTnYA/cpoVV9R5AuY+s9pVVm6kucjJI9KxaQf0W3F2QgRpHURy+H528IhwQAqOq5wtvyto8L7RkKCVkHUbwMc6VrYCq6jqQs/kWp6oTUHyStr+GMfxjvmicEwQKWVBH4UwwSpQ23dgNcTGF8zr1T+nu3vm0Og3ueUJFFuRw940fZfxmou3+PxvjSMEJq3VO/2bexYcOEO2J0p8PK95M6nsFr/txU054=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C0BD6DBE1C0A84FA0AEF301BB241E52@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681e83fe-8f64-415e-2fd4-08d70145e64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 12:40:03.0463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:23:20AM +0200, Daniel Vetter wrote:
> On Thu, Jul 4, 2019 at 5:41 PM Brian Starkey <Brian.Starkey@arm.com> wrot=
e:
> >
> > Hi,
> >
> > On Thu, Jul 04, 2019 at 11:57:00AM +0100, james qian wang (Arm Technolo=
gy China) wrote:
> > > On Wed, Jul 03, 2019 at 12:01:49PM +0200, Daniel Vetter wrote:
> > > >
> > > > Uh, what exactly are you doing reinventing uapi properties that we =
already
> > > > standardized?
> > > >
> > >
> > > Sorry, Will use the mode_config->VRR_ENABLED
> >
> > Let's have a chat about what you're planning here. The upstream VRR
> > properties aren't a direct match for our HW (which we discussed
> > before) - so either we need to hide that in the kernel with some frame
> > timing heuristics, or we shouldn't expose our feature via the existing
> > properties.
> >
> > IMO, it's better for Komeda to just allow setting a new CRTC mode to
> > one with a different VFP (but everything else the same) without a full
> > modeset.
> >
> > You could try and implement the upstream VRR properties too - but you
> > can get the functionality added by this patch without changing any
> > UAPI.
> >
> > (Note the only reason we ever added the idea of passing in VFP by
> > itself is because in ADF, modeset was a separate ioctl entirely, so we
> > couldn't do it atomically)
>=20
> If you want to see an example of how to do changes in the display mode
> (like refresh rate, I have no idea what you mean with VFP, just
> guessing) look at i915. We clear drm_crtc_state->mode_changed if it's
> a mode change we can handle without a full modeset. That gives you
> userspace-controlled variable refresh rate.
>=20
> The VRR properties are for true VRR, i.e. the hw (with or without help
> of the kernel) decides how long to make each vblank for every frame
> individually, within certain limitats set by the monitor in its EDID
> (or for panels maybe in DT).
>=20
> > > we use this private property because we're switching to in-tree, befo=
re
> > > finish the switch, we still need to maintain our out-of-tree driver w=
hich
> > > depend on a older and doesn't have the VRR_ENABLED property. for avoi=
d
> > > diverging the two branch. my old plan is first switch to in-tree, the=
n drop
> > > the out-of-tree driver and then unify the usage.
> > >
> > > > > + if (!prop)
> > > > > +         return -ENOMEM;
> > > > > +
> > > > > + drm_object_attach_property(&crtc->base, prop, 0);
> > > > > + kcrtc->vrr_enable_property =3D prop;
> > > > > +
> > > > > + return 0;
> > > > > +}
> > > > > +
> > > > >  static struct drm_plane *
> > > > >  get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc =
*crtc)
> > > > >  {
> > > > > @@ -659,6 +717,10 @@ static int komeda_crtc_add(struct komeda_kms=
_dev *kms,
> > > > >   if (err)
> > > > >           return err;
> > > > >
> > > > > + err =3D komeda_crtc_create_vrr_property(kcrtc);
> > > > > + if (err)
> > > > > +         return err;
> > > > > +
> > > > >   return err;
> > > > >  }
> > > > >
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > > index dc1d436..d0cf838 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > > @@ -98,6 +98,12 @@ struct komeda_crtc {
> > > > >
> > > > >   /** @slave_planes_property: property for slaves of the planes *=
/
> > > > >   struct drm_property *slave_planes_property;
> > > >
> > > > And this seems to not be the first time this happened. Looking at k=
omeda
> > > > with a quick git grep on properties you've actually accumulated qui=
te a
> > > > pile of such driver properties already. Where's the userspace for t=
his?
> > > > Where's the uapi discussions for this stuff? Where's the igt tests =
for
> > > > this (yes a bunch are after we agreed to have testcases for this).
> > > >
> > > > I know that in the past we've been somewhat sloppy properties, but =
that
> > > > was a mistake and we've cranked down on this hard. Probably need to=
 fix
> > > > this with a pile of reverts and start over.
> > > > -Daniel
> > >
> > > Sorry again.
> > >
> > > First I'll send some patches to remove these private properties.
> > >
> > > and then discuss for how to impelement them.
> > >
> > > The current komeda privates are:
> > >
> > > crtc:
> > >    clock_ratio
> > >    slave_planes
> > >
> > > plane:
> > >    img_enhancement
> > >    layer_split
> > >
> > > Layer_split: it can be deleted and computed in kernel.
> > >
> > > img_enhancement:
> > >   it is for image enhancement, can be removed and computed in kernel.
> > >   but I'd like to have it, since it's a seperated function (NOT only
> > >   for scaling or YUV format), I think only user can real know if need
> > >   to enable it.
> > >
> > >
> > > img_enhancement:
> > >   it is for image enhancement, can be removed and computed in kernel.
> > >   but I'd like to have it, since it's a seperated function (NOT only
> > >   for scaling or YUV format), I think only user can real know if need
> > >   to enable it.
> > >   I think maybe we can add it CORE as an optional drm_plane property.
> >
> > I really don't think we should be exposing this. It's purely there to
> > help improve an image after scaling (effectively, sharpening). It's
> > not a general purpose "image enhancer". Exposing a property which says
> > "image enhancement" isn't useful to any application - what kind of
> > enhancement is it doing?
> >
> > >
> > > clock_ratio:
> > >   It's the clock ratio of (main engine lock/output pixel clk) for
> > >   komeda HW's downscaling restriction, as below:
> > >
> > >   D71 downscaling must satisfy the following equation
> > >
> > >   MCLK                   h_in * v_in
> > >  ------- >=3D ---------------------------------------------
> > >  PXLCLK     (h_total - (1 + 2 * v_in / v_out)) * v_out
> > >
> > >  In only horizontal downscaling situation, the right side should be
> > >  multiplied by (h_total - 3) / (h_active - 3), then equation becomes
> > >
> > >   MCLK          h_in
> > >  ------- >=3D ----------------
> > >   PXLCLK     (h_active - 3)
> > >
> > > slave_planes:
> > >   it's not only for the zpos, but most importantly for notify the use=
r
> > >   to group the planes to two resource sets (pipeline-0 resources and =
pipeline1).
> > >   Per our HW design the two pipelines can be dynamic assigned to CRTC
> > >   according to the usage.
> > >   - like user only enable one CRTC which can use all two pipelines
> > >     (two resource resource sets)
> > >   - but if enabled two CRTCs, only one resource set available for
> > >     each CRTC.
> > >
> > > komeda user need to known the clock_ratio and slave_planes, but how
> > > to expose them: private_property, sysfs or other ways, seems we need
> > > to disscuss. :)
> >
> > @Daniel,
> >
> > These two are a symptom of a fundamental impedance mismatch between
> > how KMS works and actually making optimal use of HW (or: how Android
> > works).
> >
> > HWComposer is expected to have good knowledge of how the underlying HW
> > operates, so that it can effectively schedule a scene. "TEST_ONLY til
> > it works" isn't a viable strategy, and it absolutely shouldn't be
> > needed for a piece of code which has been written _specifically_ to
> > drive komeda.
> >
> > It's acknowledged that HW-specific planners may be needed even in
> > drm-hwcomposer, and those planners are going to need to get told some
> > stuff about the HW. Whether that info should go through atomic
> > properties or not is up for debate (adding properties without
> > following the rules notwithstanding).
> >
> > What's certain is that debugfs is not workable, because it's not
> > available in a production Android device (nor should it be).
> >
> > And of course, there's room for making the information more generic as
> > far as possible, at which point they might be better candidates for
> > DRM UAPI.
>=20
> If you write a specific userspace, you can just hardcode assumptions
> about what the kernel/hw can/cannot do. That's essentially what all
> the gl drivers do between kernel/userspace: They just know what the
> other side expects.
>=20
> Wrt making this more generically useful as hints: I've shared a patch
> series with Liviu about what I think should be done here instead:
>=20
> https://cgit.freedesktop.org/~danvet/drm/log/?h=3Dfor-nashpa

Hi Daniel:

I also sent two more patches based on your removal patches:

1. for Disable slave pipeline support
   https://patchwork.freedesktop.org/patch/315860/
2. Computing layer_split and image_enhancer internally
   https://patchwork.freedesktop.org/patch/315861/

Can you merge them together with properties removal patches.

Thanks
james

> Commit message each have a bunch of thoughts. But fundamentally atomic
> is meant to be used together with TEST_ONLY and following hints from
> the driver. So if you never want to use TEST_ONLY (it's only needed
> for transitions, not for every frame) in your stack, then life is
> going to be very painful indeed.
> -Daniel
>=20
> > Thanks,
> > -Brian
> >
> > >
> > > Thanks
> > > James
> > >
> > > > > +
> > > > > + /** @vrr_property: property for variable refresh rate */
> > > > > + struct drm_property *vrr_property;
> > > > > +
> > > > > + /** @vrr_enable_property: property for enable/disable the vrr *=
/
> > > > > + struct drm_property *vrr_enable_property;
> > > > >  };
> > > > >
> > > > >  /**
> > > > > @@ -126,6 +132,12 @@ struct komeda_crtc_state {
> > > > >
> > > > >   /** @max_slave_zorder: the maximum of slave zorder */
> > > > >   u32 max_slave_zorder;
> > > > > +
> > > > > + /** @vfp: the value of vertical front porch */
> > > > > + u32 vfp;
> > > > > +
> > > > > + /** @en_vrr: enable status of variable refresh rate */
> > > > > + u8 en_vrr : 1;
> > > > >  };
> > > > >
> > > > >  /** struct komeda_kms_dev - for gather KMS related things */
> > > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > > index 00e8083..66d7664 100644
> > > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > > @@ -336,7 +336,9 @@ struct komeda_improc_state {
> > > > >  /* display timing controller */
> > > > >  struct komeda_timing_ctrlr {
> > > > >   struct komeda_component base;
> > > > > - u8 supports_dual_link : 1;
> > > > > + u8 supports_dual_link : 1,
> > > > > +    supports_vrr : 1;
> > > > > + struct malidp_range vfp_range;
> > > > >  };
> > > > >
> > > > >  struct komeda_timing_ctrlr_state {
> > > > > --
> > > > > 1.9.1
> > > > >
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
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
