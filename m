Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17C1C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5A421850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PK6Wbnya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfGEMgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:36:00 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:24197
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfGEMf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RAVUZ4WKn2hUTgwR8RKmPNXNviViUuEXwO7+nrBzgk=;
 b=PK6WbnyarGQpC3QqEopj9rTjZzIKTRyfKXBn2gs6UTfpcCC4rS1yks2gad79nhqoTBSSvbGi2LoYgHbc1c0QzavYc747X7W31O3elBDOxjri4H7s8pR0CVHXOa0vm7mgnIkuE/BOWvjU4UGge9vjE5LUm4f+axAhmzOtyHbP/c4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5086.eurprd08.prod.outlook.com (20.179.29.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 5 Jul 2019 12:33:15 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Fri, 5 Jul 2019
 12:33:15 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Brian Starkey <Brian.Starkey@arm.com>
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
Thread-Index: AQHVMXCZgYg0h2S+S0iZ8YXT6sjbY6a4qceAgAGhuICAAE+MAIABXayA
Date:   Fri, 5 Jul 2019 12:33:14 +0000
Message-ID: <20190705123307.GA8435@jamwan02-TSP300>
References: <1562138723-29546-1-git-send-email-lowry.li@arm.com>
 <20190703100149.GF15868@phenom.ffwll.local>
 <20190704105653.GB9747@jamwan02-TSP300>
 <20190704154136.gib3puo7dzivnasu@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190704154136.gib3puo7dzivnasu@DESKTOP-E1NTVVP.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0055.apcprd04.prod.outlook.com
 (2603:1096:202:14::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 337cef65-f3c4-4e34-e3f2-08d70144f2f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5086;
x-ms-traffictypediagnostic: VE1PR08MB5086:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VE1PR08MB508689C541D969EF9A04838BB3F50@VE1PR08MB5086.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(33656002)(486006)(25786009)(6862004)(4326008)(5660300002)(14454004)(2906002)(99286004)(478600001)(6116002)(3846002)(52116002)(68736007)(66066001)(66446008)(66946007)(66476007)(64756008)(66556008)(6636002)(73956011)(54906003)(58126008)(316002)(33716001)(256004)(14444005)(5024004)(6512007)(8936002)(86362001)(6306002)(9686003)(186003)(53936002)(6486002)(26005)(71190400001)(71200400001)(229853002)(8676002)(81166006)(81156014)(446003)(55236004)(386003)(6506007)(102836004)(11346002)(476003)(6436002)(1076003)(7736002)(30864003)(76176011)(966005)(6246003)(305945005)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5086;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Se0OvP2t7zMnA1l1vmA+0piqUBddeSrU0QXhU3Iuzl8VUn/3yQnRl9TkdMFYoimop27Km4Ru9+Fi+992VRTMi1mnNGIlfO1S/ZsedBQNyFRUh3tbVMWFmZsyheRyDQwKW26fpCHkgq6rV3BsBFg5lZJ31uiTy1cjBlB5Dv/67Sl5j5hZIGEj/Bn3tgq2DRJJ8Pko1CJYi02bI2AwNLg3ZB7B9+UuCANC85uSzLzTEMeMGrY1Os3Ubgi4G07rZSB0LZhMckV2UczK4ABR2NK56vr2eYMOQk9QPKnym4fHv/ELCwThNpcipGw/2zK4vW2NkM8HgTHJHtVDDw0iL6UNod0XxVilR5QO6jIdBlhgC3+SyCommSTVY2NKRXfrevlqR+wujtcU/cbFuhTCJYjARMPQxRVBr9Oa5VIGcGB0e8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEAEB2CC5278A04FAE1B210A576867C4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337cef65-f3c4-4e34-e3f2-08d70144f2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 12:33:14.7877
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

On Thu, Jul 04, 2019 at 11:41:38PM +0800, Brian Starkey wrote:
> Hi,
>=20
> On Thu, Jul 04, 2019 at 11:57:00AM +0100, james qian wang (Arm Technology=
 China) wrote:
> > On Wed, Jul 03, 2019 at 12:01:49PM +0200, Daniel Vetter wrote:
> > >=20
> > > Uh, what exactly are you doing reinventing uapi properties that we al=
ready
> > > standardized?
> > >=20
> >=20
> > Sorry, Will use the mode_config->VRR_ENABLED
>=20
> Let's have a chat about what you're planning here. The upstream VRR
> properties aren't a direct match for our HW (which we discussed
> before) - so either we need to hide that in the kernel with some frame
> timing heuristics, or we shouldn't expose our feature via the existing
> properties.

@Brian:

	/**
	 * @vrr_enabled:
	 *
	 * Indicates if variable refresh rate should be enabled for the CRTC.
	 * Support for the requested vrr state will depend on driver and
	 * hardware capabiltiy - lacking support is not treated as failure.
	 */
	bool vrr_enabled;

It's not HW specific flag (like AMD freesync), I think can use this standar=
d
flag.=20

> IMO, it's better for Komeda to just allow setting a new CRTC mode to
> one with a different VFP (but everything else the same) without a full
> modeset.
>=20
> You could try and implement the upstream VRR properties too - but you
> can get the functionality added by this patch without changing any
> UAPI.
>=20
> (Note the only reason we ever added the idea of passing in VFP by
> itself is because in ADF, modeset was a separate ioctl entirely, so we
> couldn't do it atomically)

Yes, we can.
But DRM-KMS (the helpers) default doesn't support such light mode-set.
we can not rely on the helpers, but need to implement by ourselves.
Is it worth to do it?

My plan is:

First:
I think the key problem here is not how to enable VRR for our display,
but how to pass the VRR caps from the connector to our display.

And it's not only the VRR prblem but like the command_mode/dual-link
all the none standard connector features that needed by our HW.

Unlike the intel/amd/NV mostly they have their own transmitter HW
(and connector driver), So they can easily pass the info between
connector and display.

But for us that's the third part, and we can not do any assumption to
them, and for us they are the drm_connector, but we can not got these
infos via a drm_connector.

So I think we need a standard way to pass these private infos.

I plan to add a new query function to drm_bridge like

  (*query)(u64 query_id, xxx-type return_va);

and query_id is like the modifiers: first 8bit is vendor_id.

when the third part connector integrats to our display, if the
transmitter HW support the features that our display needed, they
can supply this query function to notify the caps support to us.
If the connector doesn't have this query, or query fail we treat
the feature is not support by this connector.

And For this VRR.

User only need to En/Dis VRR, Once komeda received Enable command
- query the connector for VFP range
  1. connector doesn't support VRR,  ignore or return error ?.
  2. got the VFP range, configure the display according the range.

Once the disable received, restore the mode vfp.

Thanks
James

> >=20
> > we use this private property because we're switching to in-tree, before
> > finish the switch, we still need to maintain our out-of-tree driver whi=
ch
> > depend on a older and doesn't have the VRR_ENABLED property. for avoid
> > diverging the two branch. my old plan is first switch to in-tree, then =
drop
> > the out-of-tree driver and then unify the usage.
> >=20
> > > > +	if (!prop)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	drm_object_attach_property(&crtc->base, prop, 0);
> > > > +	kcrtc->vrr_enable_property =3D prop;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static struct drm_plane *
> > > >  get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *c=
rtc)
> > > >  {
> > > > @@ -659,6 +717,10 @@ static int komeda_crtc_add(struct komeda_kms_d=
ev *kms,
> > > >  	if (err)
> > > >  		return err;
> > > > =20
> > > > +	err =3D komeda_crtc_create_vrr_property(kcrtc);
> > > > +	if (err)
> > > > +		return err;
> > > > +
> > > >  	return err;
> > > >  }
> > > > =20
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > index dc1d436..d0cf838 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > > @@ -98,6 +98,12 @@ struct komeda_crtc {
> > > > =20
> > > >  	/** @slave_planes_property: property for slaves of the planes */
> > > >  	struct drm_property *slave_planes_property;
> > >=20
> > > And this seems to not be the first time this happened. Looking at kom=
eda
> > > with a quick git grep on properties you've actually accumulated quite=
 a
> > > pile of such driver properties already. Where's the userspace for thi=
s?
> > > Where's the uapi discussions for this stuff? Where's the igt tests fo=
r
> > > this (yes a bunch are after we agreed to have testcases for this).
> > >=20
> > > I know that in the past we've been somewhat sloppy properties, but th=
at
> > > was a mistake and we've cranked down on this hard. Probably need to f=
ix
> > > this with a pile of reverts and start over.
> > > -Daniel
> >=20
> > Sorry again.
> >=20
> > First I'll send some patches to remove these private properties.
> >=20
> > and then discuss for how to impelement them.
> >=20
> > The current komeda privates are:
> >=20
> > crtc:
> >    clock_ratio
> >    slave_planes
> >=20
> > plane:
> >    img_enhancement
> >    layer_split
> >=20
> > Layer_split: it can be deleted and computed in kernel.
> >=20
> > img_enhancement:
> >   it is for image enhancement, can be removed and computed in kernel.
> >   but I'd like to have it, since it's a seperated function (NOT only
> >   for scaling or YUV format), I think only user can real know if need
> >   to enable it.
> >=20
> >=20
> > img_enhancement:
> >   it is for image enhancement, can be removed and computed in kernel.
> >   but I'd like to have it, since it's a seperated function (NOT only
> >   for scaling or YUV format), I think only user can real know if need
> >   to enable it.
> >   I think maybe we can add it CORE as an optional drm_plane property.
>=20
> I really don't think we should be exposing this. It's purely there to
> help improve an image after scaling (effectively, sharpening). It's
> not a general purpose "image enhancer". Exposing a property which says
> "image enhancement" isn't useful to any application - what kind of
> enhancement is it doing?
>=20
> >=20
> > clock_ratio:
> >   It's the clock ratio of (main engine lock/output pixel clk) for
> >   komeda HW's downscaling restriction, as below:
> >=20
> >   D71 downscaling must satisfy the following equation
> >=20
> >   MCLK                   h_in * v_in
> >  ------- >=3D ---------------------------------------------
> >  PXLCLK     (h_total - (1 + 2 * v_in / v_out)) * v_out
> >=20
> >  In only horizontal downscaling situation, the right side should be
> >  multiplied by (h_total - 3) / (h_active - 3), then equation becomes
> >=20
> >   MCLK          h_in
> >  ------- >=3D ----------------
> >   PXLCLK     (h_active - 3)
> >=20
> > slave_planes:
> >   it's not only for the zpos, but most importantly for notify the user
> >   to group the planes to two resource sets (pipeline-0 resources and pi=
peline1).
> >   Per our HW design the two pipelines can be dynamic assigned to CRTC
> >   according to the usage.
> >   - like user only enable one CRTC which can use all two pipelines
> >     (two resource resource sets)
> >   - but if enabled two CRTCs, only one resource set available for
> >     each CRTC.
> >=20
> > komeda user need to known the clock_ratio and slave_planes, but how
> > to expose them: private_property, sysfs or other ways, seems we need
> > to disscuss. :)
>=20
> @Daniel,
>=20
> These two are a symptom of a fundamental impedance mismatch between
> how KMS works and actually making optimal use of HW (or: how Android
> works).
>=20
> HWComposer is expected to have good knowledge of how the underlying HW
> operates, so that it can effectively schedule a scene. "TEST_ONLY til
> it works" isn't a viable strategy, and it absolutely shouldn't be
> needed for a piece of code which has been written _specifically_ to
> drive komeda.
>=20
> It's acknowledged that HW-specific planners may be needed even in
> drm-hwcomposer, and those planners are going to need to get told some
> stuff about the HW. Whether that info should go through atomic
> properties or not is up for debate (adding properties without
> following the rules notwithstanding).
>=20
> What's certain is that debugfs is not workable, because it's not
> available in a production Android device (nor should it be).
>=20
> And of course, there's room for making the information more generic as
> far as possible, at which point they might be better candidates for
> DRM UAPI.
>=20
> Thanks,
> -Brian
>=20
> >=20
> > Thanks
> > James
> >=20
> > > > +
> > > > +	/** @vrr_property: property for variable refresh rate */
> > > > +	struct drm_property *vrr_property;
> > > > +
> > > > +	/** @vrr_enable_property: property for enable/disable the vrr */
> > > > +	struct drm_property *vrr_enable_property;
> > > >  };
> > > > =20
> > > >  /**
> > > > @@ -126,6 +132,12 @@ struct komeda_crtc_state {
> > > > =20
> > > >  	/** @max_slave_zorder: the maximum of slave zorder */
> > > >  	u32 max_slave_zorder;
> > > > +
> > > > +	/** @vfp: the value of vertical front porch */
> > > > +	u32 vfp;
> > > > +
> > > > +	/** @en_vrr: enable status of variable refresh rate */
> > > > +	u8 en_vrr : 1;
> > > >  };
> > > > =20
> > > >  /** struct komeda_kms_dev - for gather KMS related things */
> > > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > index 00e8083..66d7664 100644
> > > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > > @@ -336,7 +336,9 @@ struct komeda_improc_state {
> > > >  /* display timing controller */
> > > >  struct komeda_timing_ctrlr {
> > > >  	struct komeda_component base;
> > > > -	u8 supports_dual_link : 1;
> > > > +	u8 supports_dual_link : 1,
> > > > +	   supports_vrr : 1;
> > > > +	struct malidp_range vfp_range;
> > > >  };
> > > > =20
> > > >  struct komeda_timing_ctrlr_state {
> > > > --=20
> > > > 1.9.1
> > > >=20
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >=20
> > > --=20
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
