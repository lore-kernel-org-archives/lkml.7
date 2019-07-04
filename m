Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE3CC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FD3218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pRJ+BuOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfGDK5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:57:07 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:19652
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727403AbfGDK5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOalziR2iRck34YtVsj/pi/J/YeYBvGCJoxbZLNn73c=;
 b=pRJ+BuOplcxSZX+5CeqBzKQpZJDMcar9PXwP91OaJkoZAW1/zc4DZN8ufl4KBrn3uTxCeVPAo+nGNDYTEZdnJHMzMQcUCn3YAY73Qx44s0o4vJ5NRtpaYM6BRnxw7L0nPSU5dhCbHTNaUHxl3jctTBvGgndKYu6eA1CIfoCTSsQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5072.eurprd08.prod.outlook.com (20.179.29.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 10:57:00 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 10:57:00 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
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
Subject: Re: [PATCH] drm/komeda: Adds VRR support
Thread-Topic: [PATCH] drm/komeda: Adds VRR support
Thread-Index: AQHVMXCZgYg0h2S+S0iZ8YXT6sjbY6a4qceAgAGhuIA=
Date:   Thu, 4 Jul 2019 10:57:00 +0000
Message-ID: <20190704105653.GB9747@jamwan02-TSP300>
References: <1562138723-29546-1-git-send-email-lowry.li@arm.com>
 <20190703100149.GF15868@phenom.ffwll.local>
In-Reply-To: <20190703100149.GF15868@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:202:17::36) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 164d6562-9e40-4f9a-03c7-08d7006e56f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5072;
x-ms-traffictypediagnostic: VE1PR08MB5072:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VE1PR08MB5072F5DA544E07E32EA00AA8B3FA0@VE1PR08MB5072.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(39860400002)(396003)(366004)(346002)(136003)(189003)(199004)(40434004)(305945005)(110136005)(58126008)(2906002)(6246003)(64756008)(53386004)(81156014)(316002)(8936002)(6636002)(33716001)(53936002)(81166006)(8676002)(2201001)(86362001)(7736002)(478600001)(6306002)(5024004)(256004)(486006)(14454004)(11346002)(33656002)(446003)(68736007)(66446008)(386003)(476003)(102836004)(6506007)(25786009)(14444005)(186003)(6512007)(6116002)(6436002)(26005)(6486002)(99286004)(5660300002)(9686003)(1076003)(3846002)(76176011)(66556008)(52116002)(66946007)(30864003)(966005)(229853002)(73956011)(66066001)(55236004)(587094005)(71190400001)(66476007)(71200400001)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5072;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u7GW0pXQKefB8zcUgXcLgJEo8vhrIkulDJRlxnamHY8ea8KfAjF6OLXbGoJSux9+Vsjd0lh3dBu0avtw3yt/Txq8A2Q/nlA6mGWt26SKq/TwWiggGlaozkO5QDwxAQ/5v58lrOnreqkMyjnRe3KHL6xI1MKebS27OXgOXlKcY+iK8KHN8HIG2eIFp6JrradL8XHnxPOjr6DjNg3gV94SDhLqybu+JHXS4A53ZgAbZ9VCULeZZGPfntg94ZvCyJnmTLB0o49BefsFI+GlHL2fpjySXOFOand1Rd0sM/ftv22NKjSxiiyPp4BpMNerV9jFcRXtQFDpGNOlpAdhCRFec0BI8IoKwuDBq3y9jnPxlrkWK709GFlRVktDBQVnF1K9Kf+zhH6yXzifBbHkYe6YI7Sm00goZ+T/4PVjeEjvmiU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0FC6E6D3B4D824C9D0E1BBB20007239@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164d6562-9e40-4f9a-03c7-08d7006e56f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 10:57:00.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 12:01:49PM +0200, Daniel Vetter wrote:
> On Wed, Jul 03, 2019 at 07:26:16AM +0000, Lowry Li (Arm Technology China)=
 wrote:
> > Adds a new drm property "vrr" and "vrr_enable" and implemented
> > the set/get functions, through which userspace could set vfp
> > data to komeda.
> >
> > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > ---
> >  .../gpu/drm/arm/display/komeda/d71/d71_component.c |  6 +++
> >  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   | 62 ++++++++++++++=
++++++++
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.h    | 12 +++++
> >  .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  4 +-
> >  4 files changed, 83 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index ed3f273..c1355f5 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -1065,6 +1065,7 @@ static void d71_timing_ctrlr_update(struct komeda=
_component *c,
> >      struct komeda_component_state *state)
> >  {
> >  struct drm_crtc_state *crtc_st =3D state->crtc->state;
> > +struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc_st);
> >  struct drm_display_mode *mode =3D &crtc_st->adjusted_mode;
> >  u32 __iomem *reg =3D c->reg;
> >  u32 hactive, hfront_porch, hback_porch, hsync_len;
> > @@ -1102,6 +1103,9 @@ static void d71_timing_ctrlr_update(struct komeda=
_component *c,
> >  value |=3D BS_CTRL_DL;
> >  }
> >
> > +if (kcrtc_st->en_vrr)
> > +malidp_write32_mask(reg, BS_VINTERVALS, 0x3FFF, kcrtc_st->vfp);
> > +
> >  malidp_write32(reg, BLK_CONTROL, value);
> >  }
> >
> > @@ -1171,6 +1175,8 @@ static int d71_timing_ctrlr_init(struct d71_dev *=
d71,
> >  ctrlr =3D to_ctrlr(c);
> >
> >  ctrlr->supports_dual_link =3D true;
> > +ctrlr->supports_vrr =3D true;
> > +set_range(&ctrlr->vfp_range, 0, 0x3FF);
> >
> >  return 0;
> >  }
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 4f580b0..3744e6d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -467,6 +467,8 @@ static void komeda_crtc_reset(struct drm_crtc *crtc=
)
> >
> >  state =3D kzalloc(sizeof(*state), GFP_KERNEL);
> >  if (state) {
> > +state->vfp =3D 0;
> > +state->en_vrr =3D 0;
> >  crtc->state =3D &state->base;
> >  crtc->state->crtc =3D crtc;
> >  }
> > @@ -487,6 +489,8 @@ static void komeda_crtc_reset(struct drm_crtc *crtc=
)
> >  new->affected_pipes =3D old->active_pipes;
> >  new->clock_ratio =3D old->clock_ratio;
> >  new->max_slave_zorder =3D old->max_slave_zorder;
> > +new->vfp =3D old->vfp;
> > +new->en_vrr =3D old->en_vrr;
> >
> >  return &new->base;
> >  }
> > @@ -525,6 +529,30 @@ static void komeda_crtc_vblank_disable(struct drm_=
crtc *crtc)
> >
> >  if (property =3D=3D kcrtc->clock_ratio_property) {
> >  *val =3D kcrtc_st->clock_ratio;
> > +} else if (property =3D=3D kcrtc->vrr_property) {
> > +*val =3D kcrtc_st->vfp;
> > +} else if (property =3D=3D kcrtc->vrr_enable_property) {
> > +*val =3D kcrtc_st->en_vrr;
> > +} else {
> > +DRM_DEBUG_DRIVER("Unknown property %s\n", property->name);
> > +return -EINVAL;
> > +}
> > +
> > +return 0;
> > +}
> > +
> > +static int komeda_crtc_atomic_set_property(struct drm_crtc *crtc,
> > +   struct drm_crtc_state *state,
> > +   struct drm_property *property,
> > +   uint64_t val)
> > +{
> > +struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
> > +struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(state);
> > +
> > +if (property =3D=3D kcrtc->vrr_property) {
> > +kcrtc_st->vfp =3D val;
> > +} else if (property =3D=3D kcrtc->vrr_enable_property) {
> > +kcrtc_st->en_vrr =3D val;
> >  } else {
> >  DRM_DEBUG_DRIVER("Unknown property %s\n", property->name);
> >  return -EINVAL;
> > @@ -544,6 +572,7 @@ static void komeda_crtc_vblank_disable(struct drm_c=
rtc *crtc)
> >  .enable_vblank=3D komeda_crtc_vblank_enable,
> >  .disable_vblank=3D komeda_crtc_vblank_disable,
> >  .atomic_get_property=3D komeda_crtc_atomic_get_property,
> > +.atomic_set_property=3D komeda_crtc_atomic_set_property,
> >  };
> >
> >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
> > @@ -613,6 +642,35 @@ static int komeda_crtc_create_slave_planes_propert=
y(struct komeda_crtc *kcrtc)
> >  return 0;
> >  }
> >
> > +static int komeda_crtc_create_vrr_property(struct komeda_crtc *kcrtc)
> > +{
> > +struct drm_crtc *crtc =3D &kcrtc->base;
> > +struct drm_property *prop;
> > +struct komeda_timing_ctrlr *ctrlr =3D kcrtc->master->ctrlr;
> > +
> > +if (!ctrlr->supports_vrr)
> > +return 0;
> > +
> > +prop =3D drm_property_create_range(crtc->dev, DRM_MODE_PROP_ATOMIC, "v=
rr",
> > + ctrlr->vfp_range.start,
> > + ctrlr->vfp_range.end);
> > +if (!prop)
> > +return -ENOMEM;
> > +
> > +drm_object_attach_property(&crtc->base, prop, 0);
> > +kcrtc->vrr_property =3D prop;
> > +
> > +prop =3D drm_property_create_bool(crtc->dev, DRM_MODE_PROP_ATOMIC,
> > +"enable_vrr");
>
> Uh, what exactly are you doing reinventing uapi properties that we alread=
y
> standardized?
>

Sorry, Will use the mode_config->VRR_ENABLED

we use this private property because we're switching to in-tree, before
finish the switch, we still need to maintain our out-of-tree driver which
depend on a older and doesn't have the VRR_ENABLED property. for avoid
diverging the two branch. my old plan is first switch to in-tree, then drop
the out-of-tree driver and then unify the usage.

> > +if (!prop)
> > +return -ENOMEM;
> > +
> > +drm_object_attach_property(&crtc->base, prop, 0);
> > +kcrtc->vrr_enable_property =3D prop;
> > +
> > +return 0;
> > +}
> > +
> >  static struct drm_plane *
> >  get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
> >  {
> > @@ -659,6 +717,10 @@ static int komeda_crtc_add(struct komeda_kms_dev *=
kms,
> >  if (err)
> >  return err;
> >
> > +err =3D komeda_crtc_create_vrr_property(kcrtc);
> > +if (err)
> > +return err;
> > +
> >  return err;
> >  }
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.h
> > index dc1d436..d0cf838 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > @@ -98,6 +98,12 @@ struct komeda_crtc {
> >
> >  /** @slave_planes_property: property for slaves of the planes */
> >  struct drm_property *slave_planes_property;
>
> And this seems to not be the first time this happened. Looking at komeda
> with a quick git grep on properties you've actually accumulated quite a
> pile of such driver properties already. Where's the userspace for this?
> Where's the uapi discussions for this stuff? Where's the igt tests for
> this (yes a bunch are after we agreed to have testcases for this).
>
> I know that in the past we've been somewhat sloppy properties, but that
> was a mistake and we've cranked down on this hard. Probably need to fix
> this with a pile of reverts and start over.
> -Daniel

Sorry again.

First I'll send some patches to remove these private properties.

and then discuss for how to impelement them.

The current komeda privates are:

crtc:
   clock_ratio
   slave_planes

plane:
   img_enhancement
   layer_split

Layer_split: it can be deleted and computed in kernel.

img_enhancement:
  it is for image enhancement, can be removed and computed in kernel.
  but I'd like to have it, since it's a seperated function (NOT only
  for scaling or YUV format), I think only user can real know if need
  to enable it.


img_enhancement:
  it is for image enhancement, can be removed and computed in kernel.
  but I'd like to have it, since it's a seperated function (NOT only
  for scaling or YUV format), I think only user can real know if need
  to enable it.
  I think maybe we can add it CORE as an optional drm_plane property.

clock_ratio:
  It's the clock ratio of (main engine lock/output pixel clk) for
  komeda HW's downscaling restriction, as below:

  D71 downscaling must satisfy the following equation

  MCLK                   h_in * v_in
 ------- >=3D ---------------------------------------------
 PXLCLK     (h_total - (1 + 2 * v_in / v_out)) * v_out

 In only horizontal downscaling situation, the right side should be
 multiplied by (h_total - 3) / (h_active - 3), then equation becomes

  MCLK          h_in
 ------- >=3D ----------------
  PXLCLK     (h_active - 3)

slave_planes:
  it's not only for the zpos, but most importantly for notify the user
  to group the planes to two resource sets (pipeline-0 resources and pipeli=
ne1).
  Per our HW design the two pipelines can be dynamic assigned to CRTC
  according to the usage.
  - like user only enable one CRTC which can use all two pipelines
    (two resource resource sets)
  - but if enabled two CRTCs, only one resource set available for
    each CRTC.

komeda user need to known the clock_ratio and slave_planes, but how
to expose them: private_property, sysfs or other ways, seems we need
to disscuss. :)

Thanks
James

> > +
> > +/** @vrr_property: property for variable refresh rate */
> > +struct drm_property *vrr_property;
> > +
> > +/** @vrr_enable_property: property for enable/disable the vrr */
> > +struct drm_property *vrr_enable_property;
> >  };
> >
> >  /**
> > @@ -126,6 +132,12 @@ struct komeda_crtc_state {
> >
> >  /** @max_slave_zorder: the maximum of slave zorder */
> >  u32 max_slave_zorder;
> > +
> > +/** @vfp: the value of vertical front porch */
> > +u32 vfp;
> > +
> > +/** @en_vrr: enable status of variable refresh rate */
> > +u8 en_vrr : 1;
> >  };
> >
> >  /** struct komeda_kms_dev - for gather KMS related things */
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index 00e8083..66d7664 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -336,7 +336,9 @@ struct komeda_improc_state {
> >  /* display timing controller */
> >  struct komeda_timing_ctrlr {
> >  struct komeda_component base;
> > -u8 supports_dual_link : 1;
> > +u8 supports_dual_link : 1,
> > +   supports_vrr : 1;
> > +struct malidp_range vfp_range;
> >  };
> >
> >  struct komeda_timing_ctrlr_state {
> > --
> > 1.9.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
