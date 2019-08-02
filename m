Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2A82067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OsJW7t7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407291AbfHBKFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:05:20 -0400
Received: from mail-eopbgr50058.outbound.protection.outlook.com ([40.107.5.58]:37830
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404751AbfHBKFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:05:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3cw8lPvE+JVFMR/XGl5hU2KPlxXpI3GPzltqO0oS91jMf3KyQ2K9/YJvj6KfkH/gf7xdGLCppFxOHQ2FoOwEKKDL3K5l4qGTiEL1zs5vp/z1D6Nw2YSiyl78oqfL1KEviwAtPmo8GP351/hDmUYiICzZMOyR5/hvldmPGhIg9CPl7q16cbe8l+k6zdtvLCVTQLXInU4RVpZarSAd5k5ZDYDHXq3weNfUlfDth9opfvg18aArCVY20+mMzExV+D5OK6vNKlrqX0rNDfT0Yew4i7Y/LkFNfsnvAifsSWKhoZp5wd+tNZohvdhFr9TALec2Weh8Ku24fZhnFuRbgvO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G585tkazTx9Gj+B2V36WlJXmSV4FUj3sMKCKNYD2Xe4=;
 b=XaO1HQ3mOF3N6RMeZTLdOSTxxLbxB1v9jcmfMqc+ehQkVa/dTSXUpJnG68lq8Ag84y4KKEqjt/n1u8l9QmHobgpzdVd+UqKQNFWJFO2ekvrRTlBkdlUXCmk90Z2sxBb4F9ZG96shfPTElwJQr1SP5qGnUHcVSY6gDDKbUVv33uPOa0TqC36J7WvAmIkDAiLEvJHcpBd7Nr6SYLB04YQ7k2quUc3RAvuxif3l9hWheOR8q4fOZKQkG05X6r5gl3o6/4fZuE7OCfOfLazM5sYjlCyhUHNR1J6GNmlHkRp2uXcWWz9OfH5RJk8O4x9bwb6lDzVuHa45T13/EhIz67NAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G585tkazTx9Gj+B2V36WlJXmSV4FUj3sMKCKNYD2Xe4=;
 b=OsJW7t7ndjwTo9RtYnw5SvVuSeiUdDIcQu1IyS3x5rEQ0n+KzvrClIC0RFvqi7ujG1PwVJ9m39toF56w5ZwUH4H1FRhBxUeaTRNQ3nHZYGFgSNoqctYIbvEPY7FmboatpUyy9whmtmmPGTAQXaLAVVWS0j3+de7KSyAYsx/am0s=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2832.eurprd08.prod.outlook.com (10.175.245.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 2 Aug 2019 10:05:08 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888%3]) with mapi id 15.20.2115.005; Fri, 2 Aug 2019
 10:05:08 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds error event print functionality
Thread-Topic: [PATCH] drm/komeda: Adds error event print functionality
Thread-Index: AQHVSRayAboXOjuz1kKxLGlCvtrW0abnoVcA
Date:   Fri, 2 Aug 2019 10:05:08 +0000
Message-ID: <1646739.69SqAVYMUr@e123338-lin>
References: <1564738954-6101-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1564738954-6101-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0165.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::33) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4019ab01-32c1-4a33-7fae-08d71730e5e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB2832;
x-ms-traffictypediagnostic: VI1PR08MB2832:
x-microsoft-antispam-prvs: <VI1PR08MB28324127F4E755A99EF4B2938FD90@VI1PR08MB2832.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(66066001)(33716001)(99286004)(476003)(11346002)(446003)(186003)(6506007)(52116002)(64756008)(478600001)(66446008)(14454004)(5660300002)(3846002)(6116002)(66946007)(66476007)(66556008)(8676002)(7736002)(2906002)(305945005)(14444005)(256004)(53936002)(6486002)(6636002)(25786009)(71190400001)(71200400001)(26005)(316002)(81166006)(8936002)(54906003)(81156014)(229853002)(6512007)(9686003)(386003)(486006)(76176011)(6436002)(6246003)(102836004)(6862004)(86362001)(4326008)(68736007)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2832;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w+9vzpVC/X6/cj/uokJSJ3gRTNJl1ekDAL9Ow0MnALoRVcW0nnF7XL1bYoFcb0JdaKSnpZExeNXr7Y6WEfFIPh+/t+GEjPMyxP408YmuMW9SoHGlMi0et1+9NtdcL7aGSoO4Bqo8znQ5GFjqhcgkemd1VrGUPfy3KntGHHjqhUcYgaWd0w6VAeCL8jOYuTYPmMtj07uaGbX0Zp6yAR+QvF4aIWZaHZ3K/FEsZo0R06d/O/GsmxEDLapo+om8Xk1RiHBbA7fpNJ1PtPIQdg/zi5BW6c+o09QQCIm+B/RFz6eT5+PDZHW5g0TeV9wufQ8Cm4qD9jwUiZlwk9cbt69xI4slU+s1VxzTVRAy+nWiL/VA+9tuX97yjHL+harvWg/jsg20vcTKZZyTwwyV8t0iF2QLF0uyz12h7bhFGkOwQKs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F8E279EBDAC5448B9DE01078CB3C2E0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4019ab01-32c1-4a33-7fae-08d71730e5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 10:05:08.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mihail.Atanassov@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2 August 2019 10:43:10 BST Lowry Li (Arm Technology China) wrote=
:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Adds to print the event message when error happens and the same event
> will not be printed until next vsync.
>=20
> Changes since v2:
> 1. Refine komeda_sprintf();
> 2. Not using STR_SZ macro for the string size in komeda_print_events().
>=20
> Changes since v1:
> 1. Handling the event print by CONFIG_KOMEDA_ERROR_PRINT;
> 2. Changing the max string size to 256.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>

Reviewed-by: Mihail Atanassov <mihail.atanassov@arm.com>

BR,
Mihail

> ---
>  drivers/gpu/drm/arm/display/Kconfig               |   6 +
>  drivers/gpu/drm/arm/display/komeda/Makefile       |   2 +
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  15 +++
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 140
> ++++++++++++++++++++++ drivers/gpu/drm/arm/display/komeda/komeda_kms.c   =
|=20
>  4 +
>  5 files changed, 167 insertions(+)
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_event.c
>=20
> diff --git a/drivers/gpu/drm/arm/display/Kconfig
> b/drivers/gpu/drm/arm/display/Kconfig index cec0639..e87ff86 100644
> --- a/drivers/gpu/drm/arm/display/Kconfig
> +++ b/drivers/gpu/drm/arm/display/Kconfig
> @@ -12,3 +12,9 @@ config DRM_KOMEDA
>  	  Processor driver. It supports the D71 variants of the hardware.
>=20
>  	  If compiled as a module it will be called komeda.
> +
> +config DRM_KOMEDA_ERROR_PRINT
> +	bool "Enable komeda error print"
> +	depends on DRM_KOMEDA
> +	help
> +	  Choose this option to enable error printing.
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile
> b/drivers/gpu/drm/arm/display/komeda/Makefile index 5c3900c..f095a1c 1006=
44
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -22,4 +22,6 @@ komeda-y +=3D \
>  	d71/d71_dev.o \
>  	d71/d71_component.o
>=20
> +komeda-$(CONFIG_DRM_KOMEDA_ERROR_PRINT) +=3D komeda_event.o
> +
>  obj-$(CONFIG_DRM_KOMEDA) +=3D komeda.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h index d1c86b6..e28e7e6
> 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -40,6 +40,17 @@
>  #define KOMEDA_ERR_TTNG			BIT_ULL(30)
>  #define KOMEDA_ERR_TTF			BIT_ULL(31)
>=20
> +#define KOMEDA_ERR_EVENTS	\
> +	(KOMEDA_EVENT_URUN	| KOMEDA_EVENT_IBSY	| KOMEDA_EVENT_OVR |
\
> +	KOMEDA_ERR_TETO		| KOMEDA_ERR_TEMR	|=20
KOMEDA_ERR_TITR |\
> +	KOMEDA_ERR_CPE		| KOMEDA_ERR_CFGE	|=20
KOMEDA_ERR_AXIE |\
> +	KOMEDA_ERR_ACE0		| KOMEDA_ERR_ACE1	|=20
KOMEDA_ERR_ACE2 |\
> +	KOMEDA_ERR_ACE3		| KOMEDA_ERR_DRIFTTO	|=20
KOMEDA_ERR_FRAMETO |\
> +	KOMEDA_ERR_ZME		| KOMEDA_ERR_MERR	|=20
KOMEDA_ERR_TCF |\
> +	KOMEDA_ERR_TTNG		| KOMEDA_ERR_TTF)
> +
> +#define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
> +
>  /* malidp device id */
>  enum {
>  	MALI_D71 =3D 0,
> @@ -207,4 +218,8 @@ struct komeda_dev {
>=20
>  struct komeda_dev *dev_to_mdev(struct device *dev);
>=20
> +#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> +void komeda_print_events(struct komeda_events *evts);
> +#endif
> +
>  #endif /*_KOMEDA_DEV_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> b/drivers/gpu/drm/arm/display/komeda/komeda_event.c new file mode 100644
> index 0000000..a36fb86
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#include <drm/drm_print.h>
> +
> +#include "komeda_dev.h"
> +
> +struct komeda_str {
> +	char *str;
> +	u32 sz;
> +	u32 len;
> +};
> +
> +/* return 0 on success,  < 0 on no space.
> + */
> +static int komeda_sprintf(struct komeda_str *str, const char *fmt, ...)
> +{
> +	va_list args;
> +	int num, free_sz;
> +	int err;
> +
> +	free_sz =3D str->sz - str->len - 1;
> +	if (free_sz <=3D 0)
> +		return -ENOSPC;
> +
> +	va_start(args, fmt);
> +
> +	num =3D vsnprintf(str->str + str->len, free_sz, fmt, args);
> +
> +	va_end(args);
> +
> +	if (num < free_sz) {
> +		str->len +=3D num;
> +		err =3D 0;
> +	} else {
> +		str->len =3D str->sz - 1;
> +		err =3D -ENOSPC;
> +	}
> +
> +	return err;
> +}
> +
> +static void evt_sprintf(struct komeda_str *str, u64 evt, const char *msg=
)
> +{
> +	if (evt)
> +		komeda_sprintf(str, msg);
> +}
> +
> +static void evt_str(struct komeda_str *str, u64 events)
> +{
> +	if (events =3D=3D 0ULL) {
> +		komeda_sprintf(str, "None");
> +		return;
> +	}
> +
> +	evt_sprintf(str, events & KOMEDA_EVENT_VSYNC, "VSYNC|");
> +	evt_sprintf(str, events & KOMEDA_EVENT_FLIP, "FLIP|");
> +	evt_sprintf(str, events & KOMEDA_EVENT_EOW, "EOW|");
> +	evt_sprintf(str, events & KOMEDA_EVENT_MODE, "OP-MODE|");
> +
> +	evt_sprintf(str, events & KOMEDA_EVENT_URUN, "UNDERRUN|");
> +	evt_sprintf(str, events & KOMEDA_EVENT_OVR, "OVERRUN|");
> +
> +	/* GLB error */
> +	evt_sprintf(str, events & KOMEDA_ERR_MERR, "MERR|");
> +	evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> +
> +	/* DOU error */
> +	evt_sprintf(str, events & KOMEDA_ERR_DRIFTTO, "DRIFTTO|");
> +	evt_sprintf(str, events & KOMEDA_ERR_FRAMETO, "FRAMETO|");
> +	evt_sprintf(str, events & KOMEDA_ERR_TETO, "TETO|");
> +	evt_sprintf(str, events & KOMEDA_ERR_CSCE, "CSCE|");
> +
> +	/* LPU errors or events */
> +	evt_sprintf(str, events & KOMEDA_EVENT_IBSY, "IBSY|");
> +	evt_sprintf(str, events & KOMEDA_ERR_AXIE, "AXIE|");
> +	evt_sprintf(str, events & KOMEDA_ERR_ACE0, "ACE0|");
> +	evt_sprintf(str, events & KOMEDA_ERR_ACE1, "ACE1|");
> +	evt_sprintf(str, events & KOMEDA_ERR_ACE2, "ACE2|");
> +	evt_sprintf(str, events & KOMEDA_ERR_ACE3, "ACE3|");
> +
> +	/* LPU TBU errors*/
> +	evt_sprintf(str, events & KOMEDA_ERR_TCF, "TCF|");
> +	evt_sprintf(str, events & KOMEDA_ERR_TTNG, "TTNG|");
> +	evt_sprintf(str, events & KOMEDA_ERR_TITR, "TITR|");
> +	evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> +	evt_sprintf(str, events & KOMEDA_ERR_TTF, "TTF|");
> +
> +	/* CU errors*/
> +	evt_sprintf(str, events & KOMEDA_ERR_CPE, "COPROC|");
> +	evt_sprintf(str, events & KOMEDA_ERR_ZME, "ZME|");
> +	evt_sprintf(str, events & KOMEDA_ERR_CFGE, "CFGE|");
> +	evt_sprintf(str, events & KOMEDA_ERR_TEMR, "TEMR|");
> +
> +	if (str->len > 0 && (str->str[str->len - 1] =3D=3D '|')) {
> +		str->str[str->len - 1] =3D 0;
> +		str->len--;
> +	}
> +}
> +
> +static bool is_new_frame(struct komeda_events *a)
> +{
> +	return (a->pipes[0] | a->pipes[1]) &
> +	       (KOMEDA_EVENT_FLIP | KOMEDA_EVENT_EOW);
> +}
> +
> +void komeda_print_events(struct komeda_events *evts)
> +{
> +	u64 print_evts =3D KOMEDA_ERR_EVENTS;
> +	static bool en_print =3D true;
> +
> +	/* reduce the same msg print, only print the first evt for one=20
frame */
> +	if (evts->global || is_new_frame(evts))
> +		en_print =3D true;
> +	if (!en_print)
> +		return;
> +
> +	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts)=20
{
> +		char msg[256];
> +		struct komeda_str str;
> +
> +		str.str =3D msg;
> +		str.sz  =3D sizeof(msg);
> +		str.len =3D 0;
> +
> +		komeda_sprintf(&str, "gcu: ");
> +		evt_str(&str, evts->global);
> +		komeda_sprintf(&str, ", pipes[0]: ");
> +		evt_str(&str, evts->pipes[0]);
> +		komeda_sprintf(&str, ", pipes[1]: ");
> +		evt_str(&str, evts->pipes[1]);
> +
> +		DRM_ERROR("err detect: %s\n", msg);
> +
> +		en_print =3D false;
> +	}
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c index 419a8b0..0fafc36
> 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -47,6 +47,10 @@ static irqreturn_t komeda_kms_irq_handler(int irq, voi=
d
> *data) memset(&evts, 0, sizeof(evts));
>  	status =3D mdev->funcs->irq_handler(mdev, &evts);
>=20
> +#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
> +	komeda_print_events(&evts);
> +#endif
> +
>  	/* Notify the crtc to handle the events */
>  	for (i =3D 0; i < kms->n_crtcs; i++)
>  		komeda_crtc_handle_event(&kms->crtcs[i], &evts);




