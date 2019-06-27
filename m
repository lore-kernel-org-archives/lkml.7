Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37960C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7572083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j2IRPp0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfF0JYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:24:42 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:52098
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0JYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kewAd5QsFLfO+HBGzhwAh2DS2MwIoqG4Yen6Geb0zJ0=;
 b=j2IRPp0A4mBOUOt56SnKR7JydtRjYRp+0ZlGWuDZpFnd8cK79pB4KjaoUJ/qaPjBVtDpDDV2qMB91M1GCH5U7OZMk7VgtdHnZjm8qpLaFqZOZdvAwa3srAJqqGajj82mp+ei9ZcCcjVlvWH1z8qUwjyWB1V4ei+AqEPfnzVGTys=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4766.eurprd08.prod.outlook.com (10.255.113.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 09:22:52 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::81b4:f737:4690:8605]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::81b4:f737:4690:8605%2]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 09:22:52 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
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
Thread-Index: AQHVLMnlF55Q+VuwzE+Dr7I9ZjiOsA==
Date:   Thu, 27 Jun 2019 09:22:52 +0000
Message-ID: <20190627092243.GA21701@james-ThinkStation-P300>
References: <1561604994-26925-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1561604994-26925-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50192d48-abc8-4ad8-d90d-08d6fae1076f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4766;
x-ms-traffictypediagnostic: VE1PR08MB4766:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB476634FAF8D5820CEC3AAEEEB3FD0@VE1PR08MB4766.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(3846002)(446003)(256004)(81156014)(486006)(476003)(5660300002)(6636002)(71190400001)(6116002)(316002)(73956011)(66476007)(71200400001)(14454004)(8676002)(99286004)(33656002)(14444005)(64756008)(66446008)(66556008)(81166006)(11346002)(58126008)(54906003)(66066001)(66946007)(1076003)(33716001)(7736002)(386003)(55236004)(6486002)(26005)(52116002)(6436002)(76176011)(305945005)(86362001)(2906002)(4326008)(25786009)(478600001)(102836004)(229853002)(68736007)(8936002)(186003)(6512007)(9686003)(53936002)(6246003)(6862004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4766;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eZxJaQepb0DPoTB+dBDmKt//+NKF+/bkqPX1tWqSNerBxMEpJe3dVNr22bs/7Nt+5W8jDUII4a/vNaUjGzhwRrWLHFMKX034g/J6G4Lqrw8bASGrIKTirepAZ4+9Po+pfwTs7bWUkVI9ftmDUyzne+gyxWZMRDwuVpY7+dlx0Ql1z3W7jdzNhgSE+48zk3+KFAWXKI9AZqtq0xy+UXRtQGampNXbwXswQshVPzWASJsvoRXvWAclWtJ1y9QayxIubDfBvbqYme4Yyw3F1+Ci0UPOElqPU42pQdfd4IrbzEdhXd1tb2uABOG/7ja5CqlAFI8cD1qspSwPxQRYPNz7e16d3rU8FaYdWyN/nIwkl0BjE6Wp0fcVmIKZWlk/HekdrWRwXcIkcN1eoRItBVaoQ8ShLamTXdC6+h8996ohxbk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <258A0B1F600C124C8F3E4D6DF412C360@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50192d48-abc8-4ad8-d90d-08d6fae1076f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 09:22:52.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:10:36AM +0800, Lowry Li (Arm Technology China) w=
rote:
> Adds to print the event message when error happens and the same event
> will not be printed until next vsync.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/Makefile       |   1 +
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   |  13 ++
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 144 ++++++++++++++++=
++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   |   2 +
>  4 files changed, 160 insertions(+)
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_event.c
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/dr=
m/arm/display/komeda/Makefile
> index 38aa584..3f53d2d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -7,6 +7,7 @@ ccflags-y :=3D \
>  komeda-y :=3D \
>  	komeda_drv.o \
>  	komeda_dev.o \
> +	komeda_event.o \
>  	komeda_format_caps.o \
>  	komeda_coeffs.o \
>  	komeda_color_mgmt.o \
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index 096f9f7..e863ec3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -40,6 +40,17 @@
>  #define KOMEDA_ERR_TTNG			BIT_ULL(30)
>  #define KOMEDA_ERR_TTF			BIT_ULL(31)
> =20
> +#define KOMEDA_ERR_EVENTS	\
> +	(KOMEDA_EVENT_URUN	| KOMEDA_EVENT_IBSY	| KOMEDA_EVENT_OVR |\
> +	KOMEDA_ERR_TETO		| KOMEDA_ERR_TEMR	| KOMEDA_ERR_TITR |\
> +	KOMEDA_ERR_CPE		| KOMEDA_ERR_CFGE	| KOMEDA_ERR_AXIE |\
> +	KOMEDA_ERR_ACE0		| KOMEDA_ERR_ACE1	| KOMEDA_ERR_ACE2 |\
> +	KOMEDA_ERR_ACE3		| KOMEDA_ERR_DRIFTTO	| KOMEDA_ERR_FRAMETO |\
> +	KOMEDA_ERR_ZME		| KOMEDA_ERR_MERR	| KOMEDA_ERR_TCF |\
> +	KOMEDA_ERR_TTNG		| KOMEDA_ERR_TTF)
> +
> +#define KOMEDA_WARN_EVENTS	KOMEDA_ERR_CSCE
> +
>  /* malidp device id */
>  enum {
>  	MALI_D71 =3D 0,
> @@ -207,6 +218,8 @@ struct komeda_dev {
> =20
>  struct komeda_dev *dev_to_mdev(struct device *dev);
> =20
> +void komeda_print_events(struct komeda_events *evts);
> +
>  int komeda_dev_resume(struct komeda_dev *mdev);
>  int komeda_dev_suspend(struct komeda_dev *mdev);
>  #endif /*_KOMEDA_DEV_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_event.c
> new file mode 100644
> index 0000000..309dbe2
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -0,0 +1,144 @@
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
> +	free_sz =3D str->sz - str->len;
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
> +		str->len +=3D num;
> +		err =3D 0;
> +	} else {
> +		str->len =3D str->sz;
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
> +		evt_sprintf(str, 1, "None");
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
> +	return (a->pipes[0] | a->pipes[1]) & KOMEDA_EVENT_FLIP;
> +}
> +
> +void komeda_print_events(struct komeda_events *evts)
> +{
> +	u64 print_evts =3D KOMEDA_ERR_EVENTS;
> +	static bool en_print =3D true;
> +
> +	/* reduce the same msg print, only print the first evt for one frame */
> +	if (evts->global || is_new_frame(evts))
> +		en_print =3D true;
> +	if (!en_print)
> +		return;
> +
> +#ifdef DEBUG
> +	print_evts |=3D KOMEDA_WARN_EVENTS;
> +#endif
> +
> +	if ((evts->global | evts->pipes[0] | evts->pipes[1]) & print_evts) {
> +		#define STR_SZ		128
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
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 647bce5..1462bac 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -47,6 +47,8 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void=
 *data)
>  	memset(&evts, 0, sizeof(evts));
>  	status =3D mdev->funcs->irq_handler(mdev, &evts);
> =20
> +	komeda_print_events(&evts);
> +
>  	/* Notify the crtc to handle the events */
>  	for (i =3D 0; i < kms->n_crtcs; i++)
>  		komeda_crtc_handle_event(&kms->crtcs[i], &evts);
> --=20
> 1.9.1
>=20

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
