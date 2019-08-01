Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847BBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367A220665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="V2Oa1VaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbfHAOs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:48:57 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:55516
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbfHAOs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:48:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElOlAVSPRT+ZaycR3wtcTRziWKpPTkKJNwmsbl5cr6o4PexH97UhEHqLhxS75395x+NKq99T8Vf1FPF0dUu0Twd3HvwHZNbySgbCQWfQqlTUB5CikhDpKMNCvK/UDN5cSzJ8xNsNESwQt5pfsEFbjL/742UmKlTimEEYzO3VxJYNojkHM267Q9y0qMgdZS7DmkkNwZX5NPNcu0aWfRR8oq9Kf5Mk3I+kYgHXkI5C17DF/Ml71karypFXgcZK9xeFF1VpJJWKVJ6fZiG3fb9jKtelPwrOUJWmD8YZ83d3B8k99l3vLLS/hbijizc05WIRgwvrAnE8WgV6R84mjceV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTYk5iHEYGbES7x9nIDQ3jVrT/kwEyNTfb7SVnQY1jI=;
 b=FQYPHaskq6hrMsHk0DtCSDznlhR62G9OtCJDf/9QmW5ITmJXOnALfC4J51Ek4Tjkdg38EIASYWxyPuaGnlnhW6eiC9i6AE8kVzrJwGoB9A5xhkxsy10NqLQtlYjqXSEimiB0oXE7hc/VSMZ7sd9dcW/zVu33aPjXorhkyjqaToK7ivPfMRWVb6k8LLwrUtPUNooh8KlGCE51fBFXr0ls1SC8xJN7XgRo6o8hy4tF/GVdyCBheq8YfWDAmiJmFLc0NArVnLK8Qq5UW8rahjyIBPV6YKMgZcPVApeZh0ICX/WCFiZddnCC3UPP0iPRCoB2KrABLosU9c/k0OHELxh/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTYk5iHEYGbES7x9nIDQ3jVrT/kwEyNTfb7SVnQY1jI=;
 b=V2Oa1VaUQAAC9A0r4/E1iJqZApS91JneOrjOhL/UQ3m0J+3Dcep7E22mcSOYhxTasI7xCvItsONuqMiwUPICS2PSZw4TH654qmgMF3PhwZjGkXdk015U2tQZGmKOkZ8XM9B3/fB02A3WXOiSuAhta2aa482/ntfe9AIePwVZGQE=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4576.eurprd08.prod.outlook.com (20.178.126.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Thu, 1 Aug 2019 14:48:45 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888%3]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 14:48:45 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds error event print functionality
Thread-Topic: [PATCH] drm/komeda: Adds error event print functionality
Thread-Index: AQHVSF13B+//d/diR06VTAGnMwmj+KbmX7KA
Date:   Thu, 1 Aug 2019 14:48:45 +0000
Message-ID: <3215981.n852bepVxH@e123338-lin>
References: <1564659415-14548-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1564659415-14548-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::26) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69bf3b6e-2dd9-438b-c97e-08d7168f5a92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4576;
x-ms-traffictypediagnostic: VI1PR08MB4576:
x-microsoft-antispam-prvs: <VI1PR08MB45762F0D0CDD87A8FE4EAA528FDE0@VI1PR08MB4576.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(9686003)(478600001)(6512007)(81156014)(81166006)(446003)(33716001)(229853002)(11346002)(8676002)(25786009)(186003)(76176011)(26005)(64756008)(6436002)(5640700003)(6506007)(386003)(66556008)(66476007)(66446008)(66946007)(14454004)(6916009)(102836004)(66066001)(2906002)(8936002)(6116002)(71200400001)(3846002)(86362001)(2351001)(2501003)(305945005)(53936002)(6486002)(52116002)(71190400001)(54906003)(6246003)(316002)(7736002)(256004)(14444005)(486006)(99286004)(68736007)(5660300002)(476003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4576;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ybvQFO58vnJC2iT3K861AOqHP2wvvtRUh3u2oFHcq8tvkirKnTDExWT0/KQ6LyEzPF38MB2xQo//HcRyzd8c/bs3KUKcuHweaGwsxPPA8T3ESpDFoKhDmHDr89GJF9qfFehf5toqikKTdcnrzW0yas0wBfJ3cBfFP7jVAkks2DM5LB3Xr7ck4+rEw1JVFHt1DAXZm1u8qTzA9GEf0KhukCoficM+oX0IjeXz/IsnvGvsV5ZrDbks+MvIk454MqmJjDNiw7gTvjcGbw5k0hLfZhQ5MAUS/uRniACLM4cFUvAuazr9/kedqaymqJ7docM607pIzRtxcIH/s+szBBUO7Rrdh7OZWxKZPzlF4OeTlJFT6ZcQkhmxqrr5WB+JLMryjHooPQlijLgGJXArXXv3HoPE3vTQAqzZ7+XrdrSqCoc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C005F8E5A435744A9D8E54C8CAA4B68@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bf3b6e-2dd9-438b-c97e-08d7168f5a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 14:48:45.4696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mihail.Atanassov@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lowry,

On Thursday, 1 August 2019 12:37:15 BST Lowry Li (Arm Technology China) wro=
te:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Adds to print the event message when error happens and the same event
> will not be printed until next vsync.
>=20
> Changes since v1:
> 1. Handling the event print by CONFIG_KOMEDA_ERROR_PRINT;
> 2. Changing the max string size to 256.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/Kconfig               |   6 +
>  drivers/gpu/drm/arm/display/komeda/Makefile       |   2 +
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  15 +++
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 141
> ++++++++++++++++++++++ drivers/gpu/drm/arm/display/komeda/komeda_kms.c   =
|=20
>  4 +
>  5 files changed, 168 insertions(+)
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
> index 0000000..57b60cd
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -0,0 +1,141 @@
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
The lack of '\0'-termination in the truncation case is quite disconcerting,=
=20
especially since vsnprintf does it. This would be quite surprising to the=20
casual passer-by.
> +{
> +	va_list args;
> +	int num, free_sz;
> +	int err;
> +
> +	free_sz =3D str->sz - str->len;
That's off by 1, you need to account for the null byte.
> +	if (free_sz <=3D 0)
> +		return -ENOSPC;
> +
> +	va_start(args, fmt);
> +
> +	num =3D vsnprintf(str->str + str->len, free_sz, fmt, args);
> +
> +	va_end(args);
> +
> +	if (num <=3D free_sz) {
Strictly less than. To quote from the doc of vsnprintf:=20
""" [...] If the return is greater than or equal to @size, the resulting=20
string is truncated. """
> +		str->len +=3D num;
> +		err =3D 0;
> +	} else {
> +		str->len =3D str->sz;
Off by 1 here, too.
> +		err =3D -ENOSPC;
That error code isn't used anywhere, so there's no value to having it in th=
e=20
current version of this patch. Either check the error code somewhere=20
downstream and handle it, or change that to an actionable message for the=20
person reading the kernel log. As it stands truncation is completely silent=
.
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
> +		evt_sprintf(str, 1, "None");
[nit] Call `komeda_sprintf(str, "None")` directly?
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
> +		#define STR_SZ		256
[nit] I'd undef that once it's no longer needed
> +		char msg[STR_SZ];
> +		struct komeda_str str;
> +
> +		str.str =3D msg;
> +		str.sz  =3D STR_SZ;
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

BR,
Mihail


