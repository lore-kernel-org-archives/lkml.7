Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B541C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C74220861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bSr8QV2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfGHHcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:32:41 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:56581
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfGHHcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ6SKalZUucCFu3QGq2CFzjYwVi9cw7ndAPFkZTcQkA=;
 b=bSr8QV2d5PuDlojCxzP5iPtM2KJuT145WM6yRavEbDyy5z78kVH+BX7LOWnzn/uMyuCzBFmvUDcd0aWYuFKaGxdFd7j4Mxr0Tk/ooK0/lIv7rt/c9Hfa1QLqG3tNyAv+rtfIHYBq6A74R9k+FcxA3iERvzNMQ7cpGTQ2gSzOEIE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4685.eurprd08.prod.outlook.com (10.255.115.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 07:32:33 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Mon, 8 Jul 2019
 07:32:33 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
Subject: Re: [PATCH 2/2] drm/komeda: Computing layer_split and image_enhancer
 internally
Thread-Topic: [PATCH 2/2] drm/komeda: Computing layer_split and image_enhancer
 internally
Thread-Index: AQHVMycKXWrZUM5S4k2zCR4X2FJ5Y6a78zwAgARlCgA=
Date:   Mon, 8 Jul 2019 07:32:33 +0000
Message-ID: <20190708073226.GA5492@jamwan02-TSP300>
References: <20190705114427.17456-1-james.qian.wang@arm.com>
 <20190705122546.GO15868@phenom.ffwll.local>
In-Reply-To: <20190705122546.GO15868@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:203:52::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5f2b3aa-51e4-4838-d1d7-08d7037670f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4685;
x-ms-traffictypediagnostic: VE1PR08MB4685:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <VE1PR08MB4685C021B04509A140BCC0A3B3F60@VE1PR08MB4685.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(39850400004)(396003)(346002)(366004)(199004)(189003)(40434004)(26005)(186003)(2906002)(81156014)(386003)(102836004)(55236004)(76176011)(99286004)(6506007)(52116002)(33716001)(71190400001)(81166006)(71200400001)(8936002)(587094005)(11346002)(446003)(486006)(2501003)(8676002)(476003)(14454004)(7736002)(66066001)(256004)(14444005)(5024004)(966005)(68736007)(305945005)(64756008)(66476007)(6116002)(478600001)(3846002)(6246003)(25786009)(33656002)(6636002)(53936002)(53386004)(58126008)(66446008)(316002)(110136005)(229853002)(9686003)(6512007)(6306002)(6486002)(6436002)(1076003)(5660300002)(66556008)(2201001)(73956011)(66946007)(86362001)(921003)(1121003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4685;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1lbmfB+GoTDxqEDkDkiaaQJ6MvWq4BEfcHBELuKDhJ3CTA4rclrWNy8DMMBIE8vSIPftOcScjQU/W6RcssjfyEw2lqcT1IyJ1dAcKVKIgCF4GaqOTa0cSxxR+RYbLuhSxl/topCW7hUpd/M7CjRFIzsofRDVfncGQV893oVogrRj8NouFTcjY4ZhZp0PfIGGwCJTJVARNQ95jSO0s2xO9utQZ0xMt/1Pu6TuZDenAx8QoB2lZtXPfaLEad24hDKdwhtTHzLhmIw4jjkaVrSrZ77QCWUgy6wB9bPdLo6kn7rTiEo84Ca3LGvFwqAo3xDSOZkjwWTj3Lf0RpXWGf9Rae0WoVjK7+2iu0SUFkhHDdUL9SdeFRpSuXhybWQ+Fytm34Er5jD899IHzi5ClZZpIabyuljm+KucZgvSD7P0UQU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A72B491A69BC0409FB0A782BA84A9D2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f2b3aa-51e4-4838-d1d7-08d7037670f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 07:32:33.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 02:25:46PM +0200, Daniel Vetter wrote:
> On Fri, Jul 05, 2019 at 11:44:45AM +0000, james qian wang (Arm Technology=
 China) wrote:
> > For layer_split:
> > Enable it if the scaling exceed the accept range of scaler.
> >
> > For image_enhancer:
> > Enable it if the scaling is a 2x+ scaling
>
> Imo should be two patches. Aside from that (and with 0 knowledge about th=
e
> hw, just looking at this from a kms/atomic uapi pov):
>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Hi Daniel:
I split this change to two patches, please ignore this one, and please
help to review the below sparated ones:
- https://patchwork.freedesktop.org/series/63340/ for layer_split
- https://patchwork.freedesktop.org/series/63341/ for image enhancer

Thanks
James
> >
> > Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  .../gpu/drm/arm/display/komeda/komeda_pipeline.h  |  3 ++-
> >  .../arm/display/komeda/komeda_pipeline_state.c    | 15 ++++++++++++++-
> >  drivers/gpu/drm/arm/display/komeda/komeda_plane.c |  8 +-------
> >  .../drm/arm/display/komeda/komeda_wb_connector.c  | 10 +---------
> >  4 files changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index fc1b8613385e..a90bcbb3cb23 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -537,7 +537,8 @@ void komeda_pipeline_disable(struct komeda_pipeline=
 *pipe,
> >  void komeda_pipeline_update(struct komeda_pipeline *pipe,
> >      struct drm_atomic_state *old_state);
> >
> > -void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
> > +void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
> > +   struct komeda_data_flow_cfg *dflow,
> >     struct drm_framebuffer *fb);
> >
> >  #endif /* _KOMEDA_PIPELINE_H_*/
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index 2b415ef2b7d3..709870bdaa4f 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -784,9 +784,11 @@ komeda_timing_ctrlr_validate(struct komeda_timing_=
ctrlr *ctrlr,
> >  return 0;
> >  }
> >
> > -void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
> > +void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
> > +   struct komeda_data_flow_cfg *dflow,
> >     struct drm_framebuffer *fb)
> >  {
> > +struct komeda_scaler *scaler =3D layer->base.pipeline->scalers[0];
> >  u32 w =3D dflow->in_w;
> >  u32 h =3D dflow->in_h;
> >
> > @@ -803,6 +805,17 @@ void komeda_complete_data_flow_cfg(struct komeda_d=
ata_flow_cfg *dflow,
> >
> >  dflow->en_scaling =3D (w !=3D dflow->out_w) || (h !=3D dflow->out_h);
> >  dflow->is_yuv =3D fb->format->is_yuv;
> > +
> > +/* try to enable image enhancer if it is a 2x+ upscaling */
> > +dflow->en_img_enhancement =3D dflow->out_w >=3D 2 * w ||
> > +    dflow->out_h >=3D 2 * h;
> > +
> > +/* try to enable split if scaling exceed the scaler's acceptable
> > + * input/output range.
> > + */
> > +if (dflow->en_scaling && scaler)
> > +dflow->en_split =3D !in_range(&scaler->hsize, dflow->in_w) ||
> > +  !in_range(&scaler->hsize, dflow->out_w);
> >  }
> >
> >  static bool merger_is_available(struct komeda_pipeline *pipe,
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/driver=
s/gpu/drm/arm/display/komeda/komeda_plane.c
> > index 5bb8553cc117..c095af154216 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > @@ -18,7 +18,6 @@ komeda_plane_init_data_flow(struct drm_plane_state *s=
t,
> >      struct komeda_data_flow_cfg *dflow)
> >  {
> >  struct komeda_plane *kplane =3D to_kplane(st->plane);
> > -struct komeda_plane_state *kplane_st =3D to_kplane_st(st);
> >  struct drm_framebuffer *fb =3D st->fb;
> >  const struct komeda_format_caps *caps =3D to_kfb(fb)->format_caps;
> >  struct komeda_pipeline *pipe =3D kplane->layer->base.pipeline;
> > @@ -57,10 +56,7 @@ komeda_plane_init_data_flow(struct drm_plane_state *=
st,
> >  return -EINVAL;
> >  }
> >
> > -dflow->en_img_enhancement =3D !!kplane_st->img_enhancement;
> > -dflow->en_split =3D !!kplane_st->layer_split;
> > -
> > -komeda_complete_data_flow_cfg(dflow, fb);
> > +komeda_complete_data_flow_cfg(kplane->layer, dflow, fb);
> >
> >  return 0;
> >  }
> > @@ -175,8 +171,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plan=
e *plane)
> >
> >  old =3D to_kplane_st(plane->state);
> >
> > -new->img_enhancement =3D old->img_enhancement;
> > -
> >  return &new->base;
> >  }
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > index bb8a61f6e9a4..617e1f7b8472 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > @@ -13,7 +13,6 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_laye=
r,
> >   struct komeda_crtc_state *kcrtc_st,
> >   struct komeda_data_flow_cfg *dflow)
> >  {
> > -struct komeda_scaler *scaler =3D wb_layer->base.pipeline->scalers[0];
> >  struct drm_framebuffer *fb =3D conn_st->writeback_job->fb;
> >
> >  memset(dflow, 0, sizeof(*dflow));
> > @@ -28,14 +27,7 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_lay=
er,
> >  dflow->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
> >  dflow->rot =3D DRM_MODE_ROTATE_0;
> >
> > -komeda_complete_data_flow_cfg(dflow, fb);
> > -
> > -/* if scaling exceed the acceptable scaler input/output range, try to
> > - * enable split.
> > - */
> > -if (dflow->en_scaling && scaler)
> > -dflow->en_split =3D !in_range(&scaler->hsize, dflow->in_w) ||
> > -  !in_range(&scaler->hsize, dflow->out_w);
> > +komeda_complete_data_flow_cfg(wb_layer, dflow, fb);
> >
> >  return 0;
> >  }
> > --
> > 2.20.1
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
