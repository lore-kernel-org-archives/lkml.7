Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231AD2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RWDYfOpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfKZLyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:54:36 -0500
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:11231
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbfKZLyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:54:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT8OAxi5b/I9IgkBMRzWryqR4SdFkqtC6wxSul58K6CO9LVf7Q89HW/jndUp2VvkwIbcXDp2rP+qk5aFd90p098KIgtVF1LMA+hTvblIgslTf5ItKnz4hEUg+WL5u06E64+IO5wEkFj1bfJLEht6ARffbO/Cv3iVdE384fUkooEuY4QRFzZV5Tzmeqh7lXlWQ2WjaLz617OGhNSd6ABnkG/6u+Dl8GeX96KbRXhQAqZecQ2hL5m6S9xIVuctXXR+9ueprM/3wGefW+jDdDPNem+E+IdVBuJzW3lYjaPP7OxbVxHT07NTB8MMa/EY74tNVnlnIm60Gj9MyTzdDqXdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiWcrwMX4a8PjaK5JHvpS8jfS2LFMQXVFu7XacdCwC8=;
 b=liqKP43KSF55hb9Ze0xcH/cNkYaRRHMQ+wNryA9eTGxPkdppplmQj6WVifEQOpKpB0FhokoCalzC1fR3kX3yLcsNcp682ln0BhvpZxyZoHi3f02yo9w/Y5aWuyeVpkxJKjg09k3CGkZW7tTSm+8oATL/oCOYGjgG9EVN7/bozssqKeglYhUtCjYW6n6tTlQdRcPJTr5LO3qBeRYQy2J40XIp34JlDlQHRBtLoxRhQPI/hoKtp5VD//eXJLumQ7MbcuypgsSaV7hoH+Xa1YXluWYo8Q6r5V1MRzQnqrs5RqGNCFgiEyulAalyvOnQnC64klZ8+Ik43tpqVQYpSmeHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiWcrwMX4a8PjaK5JHvpS8jfS2LFMQXVFu7XacdCwC8=;
 b=RWDYfOpIQCVmKeJiz3ghV1z2hFZuwJbkU5LVFB6VAkUPS3f+3L5RkV+sAKzEv7xV3INxyU1pvW/Hj+8zmSdNQg49P514MsW3MwtY+VQC69CHnjYQStcb0deWL70ef2wtJEGVvCgDCVESfL0iFxiC35oRNFFg5VvT8lKQbM86iB4=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (52.135.202.143) by
 BYAPR02MB5206.namprd02.prod.outlook.com (20.177.124.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 11:53:51 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 11:53:51 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Rajan Vaja <RAJANV@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: clocksource: Use ttc driver as platform driver
Thread-Topic: [PATCH] drivers: clocksource: Use ttc driver as platform driver
Thread-Index: AQHVlVdI5PVZKjmzeUyh91CYfTTuTqeddZ/w
Date:   Tue, 26 Nov 2019 11:53:51 +0000
Message-ID: <BYAPR02MB40555C1884AA318D9E79EFFEB7450@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com>
In-Reply-To: <1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [14.142.15.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ab4f90b-a134-41cc-2bc1-08d772674dfe
x-ms-traffictypediagnostic: BYAPR02MB5206:|BYAPR02MB5206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5206EC4003F3C7BB06E1A111B7450@BYAPR02MB5206.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(13464003)(189003)(199004)(76176011)(64756008)(6436002)(66476007)(66556008)(8936002)(66946007)(76116006)(4326008)(229853002)(55016002)(25786009)(8676002)(9686003)(71200400001)(71190400001)(66066001)(52536014)(2906002)(6116002)(3846002)(81166006)(102836004)(6246003)(53546011)(6506007)(7696005)(26005)(11346002)(5660300002)(66446008)(54906003)(33656002)(256004)(14444005)(81156014)(110136005)(2501003)(74316002)(305945005)(14454004)(478600001)(99286004)(446003)(186003)(55236004)(316002)(2201001)(86362001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5206;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArPy/QIAU9XuniTtzrEDxlthmV4ZkLhIIblMjRZmlJY3WB7CDNCyfX2+G6/z9gE/h/IAyXEFoanLs7nVRdUzPOwqlQoAAHaQHpCikRxpPcIjWQVTFXIoFVscp8fGgVASurIQ8L/MwB/J75kekLWsLUHKyqM2BpkmSwTf1oZW++2L8AYN8aivC3JwoFES1cfZc59V2uCckCFnBL8V1+0o3PQspIK8737178yx6NYaidOabK9rTRahfpQolbRvAjtcVSn8bjGX6rOKINE6n/63trWhrEWOK8rFWXc4aSUBCbn8DaEu0kIqBL/oTe/wRk9cTDfSKexeqxdhZxGysAcVtjf7wP5wsotLk7RfISQ77mHv/7yFYyj9uIrBNZPr6I4Gun6aiKl6S7AooBW8VWNl07D0cyRkPuFJSSgV8xk46641YRG1NXKC1tSF5KGDztsA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab4f90b-a134-41cc-2bc1-08d772674dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 11:53:51.1045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISDERRUjmBZkgjgK6Bov2g8mMcd5RortRT8kpKkdFBsQOslcZmZWjvzJ3Z7txo6SlvTg3XQL0nJaE1lvkSy2SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5206
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request for review.

Thanks,
Rajan

> -----Original Message-----
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> Sent: 07 November 2019 04:06 PM
> To: Michal Simek <michals@xilinx.com>; daniel.lezcano@linaro.org;
> tglx@linutronix.de
> Cc: linux-arm-kernel@lists.infradead.org; Jolly Shah <JOLLYS@xilinx.com>;=
 linux-
> kernel@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>
> Subject: [PATCH] drivers: clocksource: Use ttc driver as platform driver
>=20
> Currently TTC driver is TIMER_OF_DECLARE type driver. Because of
> that, TTC driver may be initialized before other clock drivers. If
> TTC driver is dependent on that clock driver then initialization of
> TTC driver will failed.
>=20
> So use TTC driver as platform driver instead of using
> TIMER_OF_DECLARE.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksourc=
e/timer-
> cadence-ttc.c
> index 88fe2e9..38858e1 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -15,6 +15,8 @@
>  #include <linux/of_irq.h>
>  #include <linux/slab.h>
>  #include <linux/sched_clock.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
>=20
>  /*
>   * This driver configures the 2 16/32-bit count-up timers as follows:
> @@ -464,13 +466,7 @@ static int __init ttc_setup_clockevent(struct clk *c=
lk,
>  	return 0;
>  }
>=20
> -/**
> - * ttc_timer_init - Initialize the timer
> - *
> - * Initializes the timer hardware and register the clock source and cloc=
k event
> - * timers with Linux kernal timer framework
> - */
> -static int __init ttc_timer_init(struct device_node *timer)
> +static int __init ttc_timer_probe(struct platform_device *pdev)
>  {
>  	unsigned int irq;
>  	void __iomem *timer_baseaddr;
> @@ -478,6 +474,7 @@ static int __init ttc_timer_init(struct device_node *=
timer)
>  	static int initialized;
>  	int clksel, ret;
>  	u32 timer_width =3D 16;
> +	struct device_node *timer =3D pdev->dev.of_node;
>=20
>  	if (initialized)
>  		return 0;
> @@ -532,4 +529,17 @@ static int __init ttc_timer_init(struct device_node =
*timer)
>  	return 0;
>  }
>=20
> -TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
> +static const struct of_device_id ttc_timer_of_match[] =3D {
> +	{.compatible =3D "cdns,ttc"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
> +
> +static struct platform_driver ttc_timer_driver =3D {
> +	.driver =3D {
> +		.name	=3D "cdns_ttc_timer",
> +		.of_match_table =3D ttc_timer_of_match,
> +	},
> +};
> +builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
> --
> 2.7.4

