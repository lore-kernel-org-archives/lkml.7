Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32200C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12BA206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MLJzrbnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbfHBKNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:13:09 -0400
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:38734
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388321AbfHBKNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:13:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEC6ouCjG6Tmrwm25EeGM5FLJJQmlufaGvsfJZnoJrQJcVZcvz0cqX8BDJ/0M1FMIAnshN69ciDzg+6DqrP3VzwavdOXXef8Yal8HGJE06Eu32JOzT+QoVdzczVdQfcYYljnvE7bvjYIyMDLYm38+h0GjRAFZ5pdSiNmWu95eVqiqXspPLsySmEEF94lBafx680qDeT7fYhBJ6wwVM1ccNW5tmwsgPCrpiMDdQkWi0n1mxd0xWIl02TYFnjdIK3felMHiZyfhzg091Os5kkV8UnZy9dqhKE0HF+i9HmGNgQu0awEXiUFa0lp7xoiQJQ9F4IZgjsgdhXW+lw04BouuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atPz3fr1kRzQkItURmX31/oJGGRivlx4sWhiXtx1aLI=;
 b=PXD0BpdLLHF7jR1CzU/mfWilOlyICOKLx6MfJ0Wg4ZSwXsa9kp/+omE0hkuH2bfeDRcUTLQQoWm7/Z+QncROzFJdUqiEkbsA8uy2a5tTA3eEZIRQ3cSEJJFBgFJabFEME8dpof5DWTOmxXP28cCEPbPBz0bbIx2+ayA1QwH0GsDcV/E3XHxMPfqzL4gkPyi65lifRWgIjRrWwvNa13DLb+P9F75/fXHEHC5ABPVPjz8v6B/Jw1AMwz46mR/Abg05qKhecuaK+MjfqL7cA6QbsxGJnvqmf8A22gsInPO1EgIodOTZXlbirevQ9cPRU/hU8yFzAW+7kwwjVba63C7NjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atPz3fr1kRzQkItURmX31/oJGGRivlx4sWhiXtx1aLI=;
 b=MLJzrbnFrTTaU5RsZycnyaEFj8goHF+7duZE+IcNaWQskB21wHjUyAiNXutev7Rv4DWwXq8xqeR8mGAopgdD3tKm2TuoA4wpIn40W6Rcl9JhJ3/16IQCTQTYZvXz3AK8hl1FuFAbVE5godaM6F6CxNgEcgDjHvjiPrQycTpOEz8=
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com (20.178.13.156) by
 VI1PR08MB3152.eurprd08.prod.outlook.com (52.133.15.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 2 Aug 2019 10:13:03 +0000
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::6d04:e478:d795:5d80]) by VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::6d04:e478:d795:5d80%4]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 10:13:03 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: drm/komeda: Add support for generation of CRC data per frame.
Thread-Topic: drm/komeda: Add support for generation of CRC data per frame.
Thread-Index: AQHVSFXc8W0TT39kcU6NFE7L1JWtC6bnm5cAgAADpYCAAAXVgA==
Date:   Fri, 2 Aug 2019 10:13:03 +0000
Message-ID: <20190802101303.s6vod63363nnbjgv@DESKTOP-E1NTVVP.localdomain>
References: <20190801104231.23938-1-Liviu.Dudau@arm.com>
 <20190802093908.7tt4navdtdnfvksf@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uF83+jbqqog9skkyqefAjzG0FbWtKQLKhBP0PqHj=aasg@mail.gmail.com>
In-Reply-To: <CAKMK7uF83+jbqqog9skkyqefAjzG0FbWtKQLKhBP0PqHj=aasg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To VI1PR08MB3696.eurprd08.prod.outlook.com
 (2603:10a6:803:b6::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e701e38-66e1-48b5-eac1-08d71732013c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB3152;
x-ms-traffictypediagnostic: VI1PR08MB3152:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB315217CB54C6D12572031A5CF0D90@VI1PR08MB3152.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(53936002)(54906003)(58126008)(476003)(6506007)(386003)(7736002)(966005)(6306002)(71190400001)(9686003)(11346002)(44832011)(305945005)(71200400001)(6512007)(102836004)(66946007)(66446008)(81166006)(66476007)(64756008)(66556008)(8676002)(26005)(99286004)(8936002)(81156014)(486006)(66066001)(6246003)(52116002)(14454004)(316002)(6116002)(3846002)(186003)(53546011)(256004)(86362001)(14444005)(2906002)(68736007)(446003)(1076003)(25786009)(4326008)(5660300002)(76176011)(478600001)(6436002)(229853002)(6486002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3152;H:VI1PR08MB3696.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 34gLhiirCqCVDPDBIUYDD58clmIEY4rmXyPlCArZ55eA3JCZZf0xXNdVf9D1SnyCXuBUzQnaOpTJHTWkUpxmbr9V0MgVgmRvP/NGqYK/OKohQmM3vZBOooxnOuTW6k/eEGgxyRn1vsCBIfDhGRctAjkEnLCeLXKcLnE3PahXB9vvR6KcgKiJAs5bP2n8oLMDKWaGJhO9SvxbJp8e26BashLvjGt+t5q346rjQuZ4+s8kAqqopRGcRmhArAKAb+tCpoKiYEc4wgvYmPlCz/ziPgugYDz8PSNkHODL+yTtQT5+1vbuEdbMkYBYjaaU4n7p8TGnJqYA4S9fe3HTF+IpNBEjsOgDY27Vc9XEySubysbb0Ww5I72BwF3iT9QIw3ZG4VE0arjA9jdcYl4h72KGqCqnZFinYPyAvcJ2ijFkTSM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <827FD1F585CFD64E85B7337F0D42ADE4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e701e38-66e1-48b5-eac1-08d71732013c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 10:13:03.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Aug 02, 2019 at 11:52:11AM +0200, Daniel Vetter wrote:
> On Fri, Aug 2, 2019 at 11:39 AM Brian Starkey <Brian.Starkey@arm.com> wro=
te:
> >
> > Hi Liviu,
> >
> > On Thu, Aug 01, 2019 at 11:42:31AM +0100, Liviu Dudau wrote:
> > > Komeda has support to generate per-frame CRC values in the DOU
> > > backend subsystem. Implement necessary hooks to expose the CRC
> > > "control" and "data" file over debugfs and program the DOUx_BS
> > > accordingly.
> > >
> > > This patch makes use of PL1 (programmable line 1) interrupt to
> > > know when the CRC generation has finished.
> > >
> > > Patch is also dependent on the series that adds dual-link support
> > > for komeda: https://patchwork.freedesktop.org/series/62280/
> > >
> > > Cc: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com=
>
> > > Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> > > ---
> > >  .../arm/display/komeda/d71/d71_component.c    |  2 +-
> > >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 29 ++++++++-
> > >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 61 +++++++++++++++++=
+-
> > >  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  2 +
> > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
> > >  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
> > >  6 files changed, 94 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b=
/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > index 55a8cc94808a1..3c45468848ee4 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > @@ -1061,7 +1061,7 @@ static void d71_timing_ctrlr_update(struct kome=
da_component *c,
> > >       malidp_write32(reg, BS_PREFETCH_LINE, D71_DEFAULT_PREPRETCH_LIN=
E);
> > >
> > >       /* configure bs control register */
> > > -     value =3D BS_CTRL_EN | BS_CTRL_VM;
> > > +     value =3D BS_CTRL_EN | BS_CTRL_VM | BS_CTRL_CRC;
> > >       if (c->pipeline->dual_link) {
> > >               malidp_write32(reg, BS_DRIFT_TO, hfront_porch + 16);
> > >               value |=3D BS_CTRL_DL;
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > index d567ab7ed314e..05bfd9891c540 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > @@ -115,6 +115,8 @@ static u64 get_dou_event(struct d71_pipeline *d71=
_pipeline)
> > >       raw_status =3D malidp_read32(reg, BLK_IRQ_RAW_STATUS);
> > >       if (raw_status & DOU_IRQ_PL0)
> > >               evts |=3D KOMEDA_EVENT_VSYNC;
> > > +     if (raw_status & DOU_IRQ_PL1)
> > > +             evts |=3D KOMEDA_EVENT_CRCDONE;
> > >       if (raw_status & DOU_IRQ_UND)
> > >               evts |=3D KOMEDA_EVENT_URUN;
> > >
> > > @@ -149,7 +151,7 @@ static u64 get_dou_event(struct d71_pipeline *d71=
_pipeline)
> > >
> > >  static u64 get_pipeline_event(struct d71_pipeline *d71_pipeline, u32=
 gcu_status)
> > >  {
> > > -     u32 evts =3D 0ULL;
> > > +     u64 evts =3D 0ULL;
> > >
> > >       if (gcu_status & (GLB_IRQ_STATUS_LPU0 | GLB_IRQ_STATUS_LPU1))
> > >               evts |=3D get_lpu_event(d71_pipeline);
> > > @@ -163,6 +165,26 @@ static u64 get_pipeline_event(struct d71_pipelin=
e *d71_pipeline, u32 gcu_status)
> > >       return evts;
> > >  }
> > >
> > > +static void get_frame_crcs(struct d71_pipeline *d71_pipeline, u32 pi=
pe,
> > > +                        struct komeda_events *evts)
> > > +{
> > > +     if (evts->pipes[pipe] & KOMEDA_EVENT_CRCDONE) {
> > > +             struct komeda_component *c;
> > > +
> > > +             c =3D komeda_pipeline_get_component(&d71_pipeline->base=
,
> > > +                                               KOMEDA_COMPONENT_TIMI=
NG_CTRLR);
> > > +             if (!c)
> > > +                     return;
> > > +
> > > +             evts->crcs[pipe][0] =3D malidp_read32(c->reg, BS_CRC0_L=
OW);
> > > +             evts->crcs[pipe][1] =3D malidp_read32(c->reg, BS_CRC0_H=
IGH);
> > > +             if (d71_pipeline->base.dual_link) {
> > > +                     evts->crcs[pipe][2] =3D malidp_read32(c->reg, B=
S_CRC1_LOW);
> > > +                     evts->crcs[pipe][3] =3D malidp_read32(c->reg, B=
S_CRC1_HIGH);
> > > +             }
> > > +     }
> > > +}
> > > +
> > >  static irqreturn_t
> > >  d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
> > >  {
> > > @@ -195,6 +217,9 @@ d71_irq_handler(struct komeda_dev *mdev, struct k=
omeda_events *evts)
> > >       if (gcu_status & GLB_IRQ_STATUS_PIPE1)
> > >               evts->pipes[1] |=3D get_pipeline_event(d71->pipes[1], g=
cu_status);
> > >
> > > +     get_frame_crcs(d71->pipes[0], 0, evts);
> > > +     get_frame_crcs(d71->pipes[1], 1, evts);
> > > +
> > >       return gcu_status ? IRQ_HANDLED : IRQ_NONE;
> > >  }
> > >
> > > @@ -202,7 +227,7 @@ d71_irq_handler(struct komeda_dev *mdev, struct k=
omeda_events *evts)
> > >                                GCU_IRQ_MODE | GCU_IRQ_ERR)
> > >  #define ENABLED_LPU_IRQS     (LPU_IRQ_IBSY | LPU_IRQ_ERR | LPU_IRQ_E=
OW)
> > >  #define ENABLED_CU_IRQS              (CU_IRQ_OVR | CU_IRQ_ERR)
> > > -#define ENABLED_DOU_IRQS     (DOU_IRQ_UND | DOU_IRQ_ERR)
> > > +#define ENABLED_DOU_IRQS     (DOU_IRQ_UND | DOU_IRQ_ERR | DOU_IRQ_PL=
1)
> > >
> > >  static int d71_enable_irq(struct komeda_dev *mdev)
> > >  {
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > index fa9a4593bb375..4b9f5d33e999d 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > @@ -207,10 +207,13 @@ void komeda_crtc_handle_event(struct komeda_crt=
c   *kcrtc,
> > >                       drm_crtc_send_vblank_event(crtc, event);
> > >               } else {
> > >                       DRM_WARN("CRTC[%d]: FLIP happen but no pending =
commit.\n",
> > > -                              drm_crtc_index(&kcrtc->base));
> > > +                              drm_crtc_index(crtc));
> > >               }
> > >               spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> > >       }
> > > +
> > > +     if ((kcrtc->crc_enabled) && (events & KOMEDA_EVENT_CRCDONE))
> > > +             drm_crtc_add_crc_entry(crtc, false, 0, evts->crcs[kcrtc=
->master->id]);
> > >  }
> > >
> > >  static void
> > > @@ -487,6 +490,59 @@ static void komeda_crtc_vblank_disable(struct dr=
m_crtc *crtc)
> > >       mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, false);
> > >  }
> > >
> > > +static const char * const komeda_pipe_crc_sources[] =3D {"auto"};
> > > +
> > > +static const char *const *komeda_crtc_get_crc_sources(struct drm_crt=
c *crtc,
> > > +                                                   size_t *count)
> > > +{
> > > +     *count =3D ARRAY_SIZE(komeda_pipe_crc_sources);
> > > +     return komeda_pipe_crc_sources;
> > > +}
> > > +
> > > +static int komeda_crtc_parse_crc_source(const char *source)
> > > +{
> > > +     if (!source)
> > > +             return 0;
> > > +     if (strcmp(source, "auto") =3D=3D 0)
> > > +             return 1;
> > > +
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static int komeda_crtc_verify_crc_source(struct drm_crtc *crtc,
> > > +                                      const char *source_name,
> > > +                                      size_t *values_count)
> > > +{
> > > +     struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
> > > +     int source =3D komeda_crtc_parse_crc_source(source_name);
> > > +
> > > +     if (source < 0) {
> > > +             DRM_DEBUG_DRIVER("Unknown or invalid CRC source for CRT=
C%d\n",
> > > +                              drm_crtc_index(crtc));
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     *values_count =3D kcrtc->master->dual_link ? 4 : 2;
> >
> > Can CRC generation continue across a modeset? If so I think we could
> > end up with a case where dual_link changes while CRC is active. Maybe
> > we should just always return 4 values, but set the third and fourth
> > values to 0 in the event handler, if dual-link isn't active.
>=20
> Modeset is allowed to destry the crc setup. Maybe not the smartest
> decision (it prevents us from making sure the first frame is perfect),
> but pretty deeply in-grained into tests by now. If we want to move
> this I think first step would be to add new basic testcases to igt to
> validate crc generation against modesets (maybe start with dpms
> off/on, then suspend/resume, then full modesets). Really not sure
> there's a need, and I've seen too many cases like this where crc
> generation changes depending upon modeset (bpp, routing, ...) to
> assume we can just make it work.
>=20
> I'd not bother and leave things as-is.

OK good, glad we're not alone. Do we need to do anything specific to
stop/reconfigure generation over modeset, or we just rely on userspace
to reconfigure?

Thanks,
-Brian

> -Daniel
> >
> > Cheers,
> > -Brian
> >
