Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C42C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3B12080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aMLA567e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfKZLft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:35:49 -0500
Received: from mail-eopbgr750049.outbound.protection.outlook.com ([40.107.75.49]:62614
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbfKZLft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:35:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmnFpKvK9pT/pggg8bC5INq0BUbNnneiBn7w55FkFGrVxrrx+T+Bxw4mzIK+TxyQdb5tGz9hrYtEPDGH/E3vK9RgTbnvRS4Sk5WdYTkZgh3N4/5xdUkFUi2OUgFObcwg2ktPeltAEHimei7BzLEjKMhFXLBHuzqQLJigYdty2cZQS+AWCgTZ/zsLvLRIjeKHLVdyqOYFryJbAZnOhDE4oyIycam4EWK28Gqa55WJfb9+UlRMLtMexcbOaYj0O2P6ZxqnNtM8VXdqzsmAKrgeo/S9xpvoJoEh1M4rllTKksTvdN4WudxJTE+VBNO9AE6Wl5uLOWOnQMdaXpSjFlr1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rmhTS8OhLr9p37Bg+hspR0aRgFuFDo9W34xYs1FsBA=;
 b=TJTynvOxsGtmb8JJTtrZ0rLfsrWLpDYFdSamG6M/oVXjeoYOng6/unKQ0BnznDhb/T/orSxkx+GUnTlUzChGvuouxCxPi+NNnJ3KgavPiRDaxF4vod6v5Yid4SocFjcNSvdrJIht+h3EoQr9l55szpGC3ZeKn2ZXUMrg82ngwZ1auF8BgcJMx0WzTPD2MNLSlYNwPPiFKxJK+aGG1ZZwLhVx1JOiovhflQ1qK9iyz9Sz01+LTjTGZpmWH5R60GTcjcwuMIBk5zGlFIxz4W/cr1UXAdF8vI+rVip4Z2yD/7bzA94KKf/8bmPOWziTdj1/pNvxT8Q7G20qN+lSYVdYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rmhTS8OhLr9p37Bg+hspR0aRgFuFDo9W34xYs1FsBA=;
 b=aMLA567e12c1SHCsKxZ0npL/2SS7x6ppaYv68O99fu7aOTRFchMYoX+owzEe8SjWXQfftwcmm37CoFp/dn3nnAcjZkOgzTWNQpOVjuB2Y+qswW005c54GCWBKaI0NjNyahY4o/Kbgsw53eUHUMrkz9RTDSzDDm4D4yBKShikAYU=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (52.135.202.143) by
 BYAPR02MB5064.namprd02.prod.outlook.com (20.176.253.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 11:35:43 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 11:35:43 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Rajan Vaja <RAJANV@xilinx.com>,
        "ichal.simek@xilinx.com" <ichal.simek@xilinx.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: clocksource: Use ttc driver as platform driver
Thread-Topic: [PATCH] drivers: clocksource: Use ttc driver as platform driver
Thread-Index: AQHVlVaOW+EHQwVffUWJv7WplPkHr6edcAHg
Date:   Tue, 26 Nov 2019 11:35:42 +0000
Message-ID: <BYAPR02MB4055F607B83F35B5FBF68CC6B7450@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1573122659-13947-1-git-send-email-rajan.vaja@xilinx.com>
In-Reply-To: <1573122659-13947-1-git-send-email-rajan.vaja@xilinx.com>
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
x-ms-office365-filtering-correlation-id: 8f102ac7-620c-4447-5dbd-08d77264c570
x-ms-traffictypediagnostic: BYAPR02MB5064:|BYAPR02MB5064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5064A643998992D2F48B7D9CB7450@BYAPR02MB5064.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(13464003)(199004)(189003)(66946007)(2201001)(14444005)(86362001)(7736002)(74316002)(316002)(25786009)(305945005)(76116006)(256004)(2906002)(14454004)(478600001)(54906003)(8676002)(81156014)(446003)(6116002)(81166006)(3846002)(8936002)(66556008)(64756008)(66446008)(33656002)(2501003)(11346002)(186003)(26005)(6436002)(76176011)(7696005)(99286004)(229853002)(55016002)(55236004)(53546011)(71200400001)(71190400001)(9686003)(6246003)(66066001)(6506007)(102836004)(4326008)(5660300002)(52536014)(66476007)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5064;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrUhqpN+MAC5hxKzz2+YjKRtUhFDrZuUipj3SdUl8aXz72mbdlTOg74lq8fBxN9fHz1rsARzf6kCzTQ9dZ2sJrkMXMRuA9RH6Yv6BecqHsrYzDbZ/+Wbzaa2hQHMWMyU733iLuIMD/kSyBvhUXjpTdJbzY6m42DwvjedqQwxYZAheqKgr3jW2kxwTaCQTceeW2ERXrKSQ1cOeHmmQJ93UUYIwE2LabhGnD5sG1FiYlCqiQwpJq5aiJZ+YhzqoAVvfkba5/8pZjpkrEZh6DeQlAqXK+0FhyKt7+JkELf6jjgOSSQQrkredKrAgHX9C4hVq8w+8QiKO8FH8Y23kLJs2eo9zCZDzNCHbmXeqU8fvPcG/QxQIrGPcehHrSVaIdGVICGhoG+WxZx4MLroyJI8lmWdGZossbkQfR7GjPYUCx7ZzYb+dYGb202U8NIYgUtJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f102ac7-620c-4447-5dbd-08d77264c570
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 11:35:42.9357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvzbvrrPmtvYcmzWm0rvC22oGhfkcLv5yUz9wXyQOfjskKPsqBRbrgN02oWECTl0lh+ewpg0wCEzIxhn4rrNGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request for review.

Thanks,
Rajan

> -----Original Message-----
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> Sent: 07 November 2019 04:01 PM
> To: ichal.simek@xilinx.com; daniel.lezcano@linaro.org; tglx@linutronix.de
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; R=
ajan Vaja
> <RAJANV@xilinx.com>
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

