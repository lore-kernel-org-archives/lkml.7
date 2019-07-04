Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304A0C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D2B21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0mtK+8/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfGDPlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:41:44 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:17987
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727066AbfGDPlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTdugZ1/JA6Ns7Zqq6an+FUm1L7yJsNeBsA16X+gVrA=;
 b=0mtK+8/q+ONXwk4kAkB6EnC4Teg3csn4CTT7sXeA0cqdFGKJ3RZeXO5MG6jUEM2lJGrZl+YfGUjJTOWR8E4B0j+pRy0KI3IplLotDbKI07lMweW0LpNWlKbZVIcqj7iGx5isRMt5z63i7GoNC8cZ3mTpLXwdV1URI8YVNMEmtYw=
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com (20.178.13.156) by
 VI1PR08MB4496.eurprd08.prod.outlook.com (20.179.28.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 15:41:39 +0000
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::f00e:b5de:6aa:4a64]) by VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::f00e:b5de:6aa:4a64%6]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 15:41:38 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds VRR support
Thread-Topic: [PATCH] drm/komeda: Adds VRR support
Thread-Index: AQHVMXCZgYg0h2S+S0iZ8YXT6sjbY6a4qceAgAGhuICAAE+MAA==
Date:   Thu, 4 Jul 2019 15:41:38 +0000
Message-ID: <20190704154136.gib3puo7dzivnasu@DESKTOP-E1NTVVP.localdomain>
References: <1562138723-29546-1-git-send-email-lowry.li@arm.com>
 <20190703100149.GF15868@phenom.ffwll.local>
 <20190704105653.GB9747@jamwan02-TSP300>
In-Reply-To: <20190704105653.GB9747@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.96.140]
x-clientproxiedby: LO2P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::35) To VI1PR08MB3696.eurprd08.prod.outlook.com
 (2603:10a6:803:b6::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a7e503b-2038-4280-97c2-08d700961a31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4496;
x-ms-traffictypediagnostic: VI1PR08MB4496:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR08MB449605BA6D570C1FAF432E5BF0FA0@VI1PR08MB4496.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(189003)(199004)(64756008)(66446008)(66556008)(1076003)(14454004)(73956011)(66476007)(2906002)(66946007)(9686003)(52116002)(76176011)(6116002)(4326008)(5660300002)(6862004)(3846002)(6636002)(86362001)(966005)(6486002)(186003)(66066001)(229853002)(26005)(71200400001)(53936002)(7736002)(14444005)(102836004)(6436002)(25786009)(8936002)(305945005)(81156014)(81166006)(316002)(6512007)(486006)(6506007)(478600001)(256004)(71190400001)(476003)(5024004)(6246003)(6306002)(58126008)(446003)(68736007)(99286004)(8676002)(54906003)(72206003)(386003)(11346002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4496;H:VI1PR08MB3696.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wGqBl7b0cM+L+m0vp229Ir3kZo8iF35nIeoBBFOjDGCMSNcI0wounbjKnrTXFFgvXEEK2IHuYf8Ymx8dJGYOn8HqK79iWWDgPNLj4XANthYEIT8QUwPUlQO3B4YuOdwh59ep29LOGPmBUUJa+wcFQX8Dw09UfgEw7H9lXZVQ4PpqGrXwcriJfRaqDTvuCH+kB2gQZ/CnObJULeEpmTj5XQROnjsCMTvDdj6kCeWF/4DCKWNXO3QPqyXs/BW78Jsez4yErgM44BIWZDeocBhc62sDKV852p3LaDH5dbP7GiSRXB/BkssBkgzA84UwWNQP5T6l+M66D16f913Qvd/qjLVThTA4B0RqmQ1nytoRmCroeyO0WZQ2c2MxeaFhgay6J23soiBS92wEBMDBzvrVSdJavTjzbjf6Um4aagFtkwI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8DE79AAD28694044976DBF8EE0EFE2BB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e503b-2038-4280-97c2-08d700961a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 15:41:38.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 04, 2019 at 11:57:00AM +0100, james qian wang (Arm Technology C=
hina) wrote:
> On Wed, Jul 03, 2019 at 12:01:49PM +0200, Daniel Vetter wrote:
> >=20
> > Uh, what exactly are you doing reinventing uapi properties that we alre=
ady
> > standardized?
> >=20
>=20
> Sorry, Will use the mode_config->VRR_ENABLED

Let's have a chat about what you're planning here. The upstream VRR
properties aren't a direct match for our HW (which we discussed
before) - so either we need to hide that in the kernel with some frame
timing heuristics, or we shouldn't expose our feature via the existing
properties.

IMO, it's better for Komeda to just allow setting a new CRTC mode to
one with a different VFP (but everything else the same) without a full
modeset.

You could try and implement the upstream VRR properties too - but you
can get the functionality added by this patch without changing any
UAPI.

(Note the only reason we ever added the idea of passing in VFP by
itself is because in ADF, modeset was a separate ioctl entirely, so we
couldn't do it atomically)

>=20
> we use this private property because we're switching to in-tree, before
> finish the switch, we still need to maintain our out-of-tree driver which
> depend on a older and doesn't have the VRR_ENABLED property. for avoid
> diverging the two branch. my old plan is first switch to in-tree, then dr=
op
> the out-of-tree driver and then unify the usage.
>=20
> > > +	if (!prop)
> > > +		return -ENOMEM;
> > > +
> > > +	drm_object_attach_property(&crtc->base, prop, 0);
> > > +	kcrtc->vrr_enable_property =3D prop;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static struct drm_plane *
> > >  get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crt=
c)
> > >  {
> > > @@ -659,6 +717,10 @@ static int komeda_crtc_add(struct komeda_kms_dev=
 *kms,
> > >  	if (err)
> > >  		return err;
> > > =20
> > > +	err =3D komeda_crtc_create_vrr_property(kcrtc);
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	return err;
> > >  }
> > > =20
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/driver=
s/gpu/drm/arm/display/komeda/komeda_kms.h
> > > index dc1d436..d0cf838 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > @@ -98,6 +98,12 @@ struct komeda_crtc {
> > > =20
> > >  	/** @slave_planes_property: property for slaves of the planes */
> > >  	struct drm_property *slave_planes_property;
> >=20
> > And this seems to not be the first time this happened. Looking at komed=
a
> > with a quick git grep on properties you've actually accumulated quite a
> > pile of such driver properties already. Where's the userspace for this?
> > Where's the uapi discussions for this stuff? Where's the igt tests for
> > this (yes a bunch are after we agreed to have testcases for this).
> >=20
> > I know that in the past we've been somewhat sloppy properties, but that
> > was a mistake and we've cranked down on this hard. Probably need to fix
> > this with a pile of reverts and start over.
> > -Daniel
>=20
> Sorry again.
>=20
> First I'll send some patches to remove these private properties.
>=20
> and then discuss for how to impelement them.
>=20
> The current komeda privates are:
>=20
> crtc:
>    clock_ratio
>    slave_planes
>=20
> plane:
>    img_enhancement
>    layer_split
>=20
> Layer_split: it can be deleted and computed in kernel.
>=20
> img_enhancement:
>   it is for image enhancement, can be removed and computed in kernel.
>   but I'd like to have it, since it's a seperated function (NOT only
>   for scaling or YUV format), I think only user can real know if need
>   to enable it.
>=20
>=20
> img_enhancement:
>   it is for image enhancement, can be removed and computed in kernel.
>   but I'd like to have it, since it's a seperated function (NOT only
>   for scaling or YUV format), I think only user can real know if need
>   to enable it.
>   I think maybe we can add it CORE as an optional drm_plane property.

I really don't think we should be exposing this. It's purely there to
help improve an image after scaling (effectively, sharpening). It's
not a general purpose "image enhancer". Exposing a property which says
"image enhancement" isn't useful to any application - what kind of
enhancement is it doing?

>=20
> clock_ratio:
>   It's the clock ratio of (main engine lock/output pixel clk) for
>   komeda HW's downscaling restriction, as below:
>=20
>   D71 downscaling must satisfy the following equation
>=20
>   MCLK                   h_in * v_in
>  ------- >=3D ---------------------------------------------
>  PXLCLK     (h_total - (1 + 2 * v_in / v_out)) * v_out
>=20
>  In only horizontal downscaling situation, the right side should be
>  multiplied by (h_total - 3) / (h_active - 3), then equation becomes
>=20
>   MCLK          h_in
>  ------- >=3D ----------------
>   PXLCLK     (h_active - 3)
>=20
> slave_planes:
>   it's not only for the zpos, but most importantly for notify the user
>   to group the planes to two resource sets (pipeline-0 resources and pipe=
line1).
>   Per our HW design the two pipelines can be dynamic assigned to CRTC
>   according to the usage.
>   - like user only enable one CRTC which can use all two pipelines
>     (two resource resource sets)
>   - but if enabled two CRTCs, only one resource set available for
>     each CRTC.
>=20
> komeda user need to known the clock_ratio and slave_planes, but how
> to expose them: private_property, sysfs or other ways, seems we need
> to disscuss. :)

@Daniel,

These two are a symptom of a fundamental impedance mismatch between
how KMS works and actually making optimal use of HW (or: how Android
works).

HWComposer is expected to have good knowledge of how the underlying HW
operates, so that it can effectively schedule a scene. "TEST_ONLY til
it works" isn't a viable strategy, and it absolutely shouldn't be
needed for a piece of code which has been written _specifically_ to
drive komeda.

It's acknowledged that HW-specific planners may be needed even in
drm-hwcomposer, and those planners are going to need to get told some
stuff about the HW. Whether that info should go through atomic
properties or not is up for debate (adding properties without
following the rules notwithstanding).

What's certain is that debugfs is not workable, because it's not
available in a production Android device (nor should it be).

And of course, there's room for making the information more generic as
far as possible, at which point they might be better candidates for
DRM UAPI.

Thanks,
-Brian

>=20
> Thanks
> James
>=20
> > > +
> > > +	/** @vrr_property: property for variable refresh rate */
> > > +	struct drm_property *vrr_property;
> > > +
> > > +	/** @vrr_enable_property: property for enable/disable the vrr */
> > > +	struct drm_property *vrr_enable_property;
> > >  };
> > > =20
> > >  /**
> > > @@ -126,6 +132,12 @@ struct komeda_crtc_state {
> > > =20
> > >  	/** @max_slave_zorder: the maximum of slave zorder */
> > >  	u32 max_slave_zorder;
> > > +
> > > +	/** @vfp: the value of vertical front porch */
> > > +	u32 vfp;
> > > +
> > > +	/** @en_vrr: enable status of variable refresh rate */
> > > +	u8 en_vrr : 1;
> > >  };
> > > =20
> > >  /** struct komeda_kms_dev - for gather KMS related things */
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > index 00e8083..66d7664 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > @@ -336,7 +336,9 @@ struct komeda_improc_state {
> > >  /* display timing controller */
> > >  struct komeda_timing_ctrlr {
> > >  	struct komeda_component base;
> > > -	u8 supports_dual_link : 1;
> > > +	u8 supports_dual_link : 1,
> > > +	   supports_vrr : 1;
> > > +	struct malidp_range vfp_range;
> > >  };
> > > =20
> > >  struct komeda_timing_ctrlr_state {
> > > --=20
> > > 1.9.1
> > >=20
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >=20
> > --=20
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
