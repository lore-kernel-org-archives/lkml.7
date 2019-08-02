Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8561BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE6620679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NFZTDzkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbfHBJjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:39:17 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:30414
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387682AbfHBJjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:39:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY+kxqCSgnCrkTg1wjwwDTDhEb+fpac/7GRdNsykPftkS93u99hYyRgTj36APT5nqwkDAGihU438jH5Z8nHmYqjAZaLea5FF3mDj9OxSSK6iUEOvUd5QtPKVh3HuGOEv3M2mgKBR1BMcwDPD19gJ1JnOW/yvZkfzoSAAIm76NnZNYx7EmFRW6SObzYoB0vmnuxLqbxbGAsyaTlAAF7HnXVKIOHQ0Rwj1EXWFBZsZ2VZEUOyVTDdYyR8FLnxhOKjYbNO31QrPQknZfYGcQ1h0K0yRlLPrGuSk3E/BFRnf8sci+VGTKfA89DS5G+yulpqBF3XT/2nfsNXzEdAEU2rRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tNCTL/+LjPacd9jCblwOmQgouyRm105f5sX4I+xVfc=;
 b=nMP5XX8kdQlWYmk+49+Fdtt6YFOOlzx5fVn9Ht/8gakrujLVXjeVn/dWb0HA1gtZ7mr4RsyMDHhX/wskxEo0ujM4T0e/RjHiE2dFpvme4rBwqyrVD2eHpcggVFzZN9k3r6rZd9cRa4AR9RFtEOqZJq77rLUWsETFcVglaFt9aBa4SamAgNE2+rA8tHWtdZRWwHPBEnzahidPU/E8BKsZqidcXDefj6LhT1F6yjaIl153t+EDQph//6UyuZTErlkX3eKBD5z07AW+JPv+70//1rVkQr3pOXTTXhD21N4luEuJE5rXxixYj8RKpTlAiJ0k545WtW95OXupx5Mt0bbA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tNCTL/+LjPacd9jCblwOmQgouyRm105f5sX4I+xVfc=;
 b=NFZTDzkYA8eIK9/1+qiEtl0oFlcDQZlRpOUoLlMu2ABTv2u9XGxRJkeMeJ9a8MsXAS2xN1sDwvPhnfIusy4l3ilVcs43tGXunPysr52+Feqq0jr3AOrygeMFIlNeF3L8M1u4BqpDYX8RyxFJHsgDpAeyluM7zVXd9zK/s9c0bno=
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com (20.178.13.156) by
 VI1PR08MB3534.eurprd08.prod.outlook.com (20.177.61.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Fri, 2 Aug 2019 09:39:08 +0000
Received: from VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::6d04:e478:d795:5d80]) by VI1PR08MB3696.eurprd08.prod.outlook.com
 ([fe80::6d04:e478:d795:5d80%4]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 09:39:08 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, nd <nd@arm.com>
Subject: Re: drm/komeda: Add support for generation of CRC data per frame.
Thread-Topic: drm/komeda: Add support for generation of CRC data per frame.
Thread-Index: AQHVSFXc8W0TT39kcU6NFE7L1JWtC6bnm5cA
Date:   Fri, 2 Aug 2019 09:39:08 +0000
Message-ID: <20190802093908.7tt4navdtdnfvksf@DESKTOP-E1NTVVP.localdomain>
References: <20190801104231.23938-1-Liviu.Dudau@arm.com>
In-Reply-To: <20190801104231.23938-1-Liviu.Dudau@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::24) To VI1PR08MB3696.eurprd08.prod.outlook.com
 (2603:10a6:803:b6::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de6499cf-dc08-47aa-da77-08d7172d4480
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3534;
x-ms-traffictypediagnostic: VI1PR08MB3534:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB35348963EB0F9A994B0ACF8EF0D90@VI1PR08MB3534.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(66066001)(6486002)(2906002)(229853002)(86362001)(486006)(44832011)(14454004)(1076003)(68736007)(54906003)(305945005)(8676002)(8936002)(81156014)(81166006)(7736002)(478600001)(4326008)(6116002)(3846002)(6862004)(6246003)(58126008)(66556008)(186003)(386003)(6506007)(64756008)(316002)(99286004)(476003)(11346002)(446003)(52116002)(66946007)(66476007)(256004)(14444005)(66446008)(6636002)(966005)(71190400001)(102836004)(6436002)(71200400001)(53936002)(9686003)(76176011)(26005)(5660300002)(6306002)(6512007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3534;H:VI1PR08MB3696.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qC+QKfx9vpHAAAjTYm15JARgVlB+s3S6vTfTYp3d74lfpYAxCc1ZbrS26VSAmNnaTKL8TPeufcbG+XuJH03528OojAHCWyiCcppQrPHyrpH4mEp2yEsyXtyeZc2JCxeXJKh6fEk/ea7ZyfTx0xZui2gZzUm55M21aiJZsxQYTxCUZ7HlnXM6pnKmzDdEqn82eZHjsPDLq+dl+EUNHC29RiwBr/ImqbpuFddBg4KbkvuU4VMoWTDqJkGmIIsCX3zPukrdvh3Tbt4iGan2QgncAZMH4DFQn6RgkHUjxmXyjwQ3wTA/Eit+JTl+dwuNlVCsmZRErvv7hAYWvtyeLMSOkybxVK9UNO1TpYJM6LVz3lO+JNCeIRkEk6dCRNeftiK96DUt2gR5XefRN8e/ZZ7JHB3jYv1prNovsdAw8Q+fIGk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <260D9E799AD8B84E986CC1AAD12074A9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de6499cf-dc08-47aa-da77-08d7172d4480
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 09:39:08.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Brian.Starkey@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

On Thu, Aug 01, 2019 at 11:42:31AM +0100, Liviu Dudau wrote:
> Komeda has support to generate per-frame CRC values in the DOU
> backend subsystem. Implement necessary hooks to expose the CRC
> "control" and "data" file over debugfs and program the DOUx_BS
> accordingly.
>=20
> This patch makes use of PL1 (programmable line 1) interrupt to
> know when the CRC generation has finished.
>=20
> Patch is also dependent on the series that adds dual-link support
> for komeda: https://patchwork.freedesktop.org/series/62280/
>=20
> Cc: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  .../arm/display/komeda/d71/d71_component.c    |  2 +-
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 29 ++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 61 ++++++++++++++++++-
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  2 +
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
>  6 files changed, 94 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 55a8cc94808a1..3c45468848ee4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -1061,7 +1061,7 @@ static void d71_timing_ctrlr_update(struct komeda_c=
omponent *c,
>  	malidp_write32(reg, BS_PREFETCH_LINE, D71_DEFAULT_PREPRETCH_LINE);
> =20
>  	/* configure bs control register */
> -	value =3D BS_CTRL_EN | BS_CTRL_VM;
> +	value =3D BS_CTRL_EN | BS_CTRL_VM | BS_CTRL_CRC;
>  	if (c->pipeline->dual_link) {
>  		malidp_write32(reg, BS_DRIFT_TO, hfront_porch + 16);
>  		value |=3D BS_CTRL_DL;
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index d567ab7ed314e..05bfd9891c540 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -115,6 +115,8 @@ static u64 get_dou_event(struct d71_pipeline *d71_pip=
eline)
>  	raw_status =3D malidp_read32(reg, BLK_IRQ_RAW_STATUS);
>  	if (raw_status & DOU_IRQ_PL0)
>  		evts |=3D KOMEDA_EVENT_VSYNC;
> +	if (raw_status & DOU_IRQ_PL1)
> +		evts |=3D KOMEDA_EVENT_CRCDONE;
>  	if (raw_status & DOU_IRQ_UND)
>  		evts |=3D KOMEDA_EVENT_URUN;
> =20
> @@ -149,7 +151,7 @@ static u64 get_dou_event(struct d71_pipeline *d71_pip=
eline)
> =20
>  static u64 get_pipeline_event(struct d71_pipeline *d71_pipeline, u32 gcu=
_status)
>  {
> -	u32 evts =3D 0ULL;
> +	u64 evts =3D 0ULL;
> =20
>  	if (gcu_status & (GLB_IRQ_STATUS_LPU0 | GLB_IRQ_STATUS_LPU1))
>  		evts |=3D get_lpu_event(d71_pipeline);
> @@ -163,6 +165,26 @@ static u64 get_pipeline_event(struct d71_pipeline *d=
71_pipeline, u32 gcu_status)
>  	return evts;
>  }
> =20
> +static void get_frame_crcs(struct d71_pipeline *d71_pipeline, u32 pipe,
> +			   struct komeda_events *evts)
> +{
> +	if (evts->pipes[pipe] & KOMEDA_EVENT_CRCDONE) {
> +		struct komeda_component *c;
> +
> +		c =3D komeda_pipeline_get_component(&d71_pipeline->base,
> +						  KOMEDA_COMPONENT_TIMING_CTRLR);
> +		if (!c)
> +			return;
> +
> +		evts->crcs[pipe][0] =3D malidp_read32(c->reg, BS_CRC0_LOW);
> +		evts->crcs[pipe][1] =3D malidp_read32(c->reg, BS_CRC0_HIGH);
> +		if (d71_pipeline->base.dual_link) {
> +			evts->crcs[pipe][2] =3D malidp_read32(c->reg, BS_CRC1_LOW);
> +			evts->crcs[pipe][3] =3D malidp_read32(c->reg, BS_CRC1_HIGH);
> +		}
> +	}
> +}
> +
>  static irqreturn_t
>  d71_irq_handler(struct komeda_dev *mdev, struct komeda_events *evts)
>  {
> @@ -195,6 +217,9 @@ d71_irq_handler(struct komeda_dev *mdev, struct komed=
a_events *evts)
>  	if (gcu_status & GLB_IRQ_STATUS_PIPE1)
>  		evts->pipes[1] |=3D get_pipeline_event(d71->pipes[1], gcu_status);
> =20
> +	get_frame_crcs(d71->pipes[0], 0, evts);
> +	get_frame_crcs(d71->pipes[1], 1, evts);
> +
>  	return gcu_status ? IRQ_HANDLED : IRQ_NONE;
>  }
> =20
> @@ -202,7 +227,7 @@ d71_irq_handler(struct komeda_dev *mdev, struct komed=
a_events *evts)
>  				 GCU_IRQ_MODE | GCU_IRQ_ERR)
>  #define ENABLED_LPU_IRQS	(LPU_IRQ_IBSY | LPU_IRQ_ERR | LPU_IRQ_EOW)
>  #define ENABLED_CU_IRQS		(CU_IRQ_OVR | CU_IRQ_ERR)
> -#define ENABLED_DOU_IRQS	(DOU_IRQ_UND | DOU_IRQ_ERR)
> +#define ENABLED_DOU_IRQS	(DOU_IRQ_UND | DOU_IRQ_ERR | DOU_IRQ_PL1)
> =20
>  static int d71_enable_irq(struct komeda_dev *mdev)
>  {
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index fa9a4593bb375..4b9f5d33e999d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -207,10 +207,13 @@ void komeda_crtc_handle_event(struct komeda_crtc   =
*kcrtc,
>  			drm_crtc_send_vblank_event(crtc, event);
>  		} else {
>  			DRM_WARN("CRTC[%d]: FLIP happen but no pending commit.\n",
> -				 drm_crtc_index(&kcrtc->base));
> +				 drm_crtc_index(crtc));
>  		}
>  		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
>  	}
> +
> +	if ((kcrtc->crc_enabled) && (events & KOMEDA_EVENT_CRCDONE))
> +		drm_crtc_add_crc_entry(crtc, false, 0, evts->crcs[kcrtc->master->id]);
>  }
> =20
>  static void
> @@ -487,6 +490,59 @@ static void komeda_crtc_vblank_disable(struct drm_cr=
tc *crtc)
>  	mdev->funcs->on_off_vblank(mdev, kcrtc->master->id, false);
>  }
> =20
> +static const char * const komeda_pipe_crc_sources[] =3D {"auto"};
> +
> +static const char *const *komeda_crtc_get_crc_sources(struct drm_crtc *c=
rtc,
> +						      size_t *count)
> +{
> +	*count =3D ARRAY_SIZE(komeda_pipe_crc_sources);
> +	return komeda_pipe_crc_sources;
> +}
> +
> +static int komeda_crtc_parse_crc_source(const char *source)
> +{
> +	if (!source)
> +		return 0;
> +	if (strcmp(source, "auto") =3D=3D 0)
> +		return 1;
> +
> +	return -EINVAL;
> +}
> +
> +static int komeda_crtc_verify_crc_source(struct drm_crtc *crtc,
> +					 const char *source_name,
> +					 size_t *values_count)
> +{
> +	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
> +	int source =3D komeda_crtc_parse_crc_source(source_name);
> +
> +	if (source < 0) {
> +		DRM_DEBUG_DRIVER("Unknown or invalid CRC source for CRTC%d\n",
> +				 drm_crtc_index(crtc));
> +		return -EINVAL;
> +	}
> +
> +	*values_count =3D kcrtc->master->dual_link ? 4 : 2;

Can CRC generation continue across a modeset? If so I think we could
end up with a case where dual_link changes while CRC is active. Maybe
we should just always return 4 values, but set the third and fourth
values to 0 in the event handler, if dual-link isn't active.

Cheers,
-Brian

> +
> +	return 0;
> +}
> +
> +static int komeda_crtc_set_crc_source(struct drm_crtc *crtc, const char =
*source)
> +{
> +	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
> +	int src =3D komeda_crtc_parse_crc_source(source);
> +
> +	if (src < 0) {
> +		DRM_DEBUG_DRIVER("Unknown or invalid CRC source for CRTC%d\n",
> +				 drm_crtc_index(crtc));
> +		return -EINVAL;
> +	}
> +
> +	kcrtc->crc_enabled =3D src & 1;
> +
> +	return 0;
> +}
> +
>  static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
>  	.gamma_set		=3D drm_atomic_helper_legacy_gamma_set,
>  	.destroy		=3D drm_crtc_cleanup,
> @@ -497,6 +553,9 @@ static const struct drm_crtc_funcs komeda_crtc_funcs =
=3D {
>  	.atomic_destroy_state	=3D komeda_crtc_atomic_destroy_state,
>  	.enable_vblank		=3D komeda_crtc_vblank_enable,
>  	.disable_vblank		=3D komeda_crtc_vblank_disable,
> +	.set_crc_source		=3D komeda_crtc_set_crc_source,
> +	.verify_crc_source	=3D komeda_crtc_verify_crc_source,
> +	.get_crc_sources	=3D komeda_crtc_get_crc_sources,
>  };
> =20
>  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index d1c86b6174c80..244227b945f63 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -20,6 +20,7 @@
>  #define KOMEDA_EVENT_OVR		BIT_ULL(4)
>  #define KOMEDA_EVENT_EOW		BIT_ULL(5)
>  #define KOMEDA_EVENT_MODE		BIT_ULL(6)
> +#define KOMEDA_EVENT_CRCDONE		BIT_ULL(7)
> =20
>  #define KOMEDA_ERR_TETO			BIT_ULL(14)
>  #define KOMEDA_ERR_TEMR			BIT_ULL(15)
> @@ -69,6 +70,7 @@ struct komeda_dev;
>  struct komeda_events {
>  	u64 global;
>  	u64 pipes[KOMEDA_MAX_PIPELINES];
> +	u32 crcs[KOMEDA_MAX_PIPELINES][KOMEDA_MAX_CRCS];
>  };
> =20
>  /**
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index 45c498e15e7ae..de7c93b2d0a11 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -84,6 +84,9 @@ struct komeda_crtc {
> =20
>  	/** @disable_done: this flip_done is for tracing the disable */
>  	struct completion *disable_done;
> +
> +	/** @crc_enabled: true if per-frame generation of CRC is enabled */
> +	bool crc_enabled;
>  };
> =20
>  /**
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index a7a84e66549d6..dfe2482c6274b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -16,6 +16,7 @@
>  #define KOMEDA_PIPELINE_MAX_LAYERS	4
>  #define KOMEDA_PIPELINE_MAX_SCALERS	2
>  #define KOMEDA_COMPONENT_N_INPUTS	5
> +#define KOMEDA_MAX_CRCS			4
> =20
>  /* pipeline component IDs */
>  enum {
> --=20
> 2.22.0
>=20
