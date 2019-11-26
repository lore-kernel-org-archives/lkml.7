Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8861DC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5525F2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Y8HjHE2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfKZL5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:57:21 -0500
Received: from mail-eopbgr790055.outbound.protection.outlook.com ([40.107.79.55]:59808
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727250AbfKZL5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:57:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5RUw7q0ndUpTWrrrcdCwgmEtGPUxIUI189c4GaJDHSVzRSPt0PLHMRXdiWMw95O3+D+rbvlypj+gcZxDo0O1GfHj+/MnD1CXZHSd5v8SLk/3Q9UJt0npIW+VoP9bRTV6bcveU8UGD5HOwc3eVTmrmcMVn/oWhVDKiOQ3+O9DkiBA8YgWO1Onyi9qnZ80++nUN99yS8sM73wsCGF/rrAJbxWHYWgv+PcFNzDXfrFbir280brBkQtkVV0GCCbpo6DZRhObLe4bN8TEbOrxn3JXrRkdzpusVNuypCwnV18qpW4/qor5F1e9F0TZLfTZWh8MERfcTY+KF/zAuwiDqB/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoz0kP7TlyyO8x7+RhU2QNe28uAYxMWtipV31PkCT0k=;
 b=bHx6hKpoutKIkx1wk+nFTYJE+SjAQFRiEACe/bdSsh2YXE1yiTggKcAHXeRdEDqvWvkq+JW2rCd2YFLxd1B+pkGDKI/L7gJ3OJdcY0f88rVMUx3mDej57csBzKvFSfzhT9YjnOBbP8D+4HuapdL7I3BbWHIPaWzOQHgXBNvqJP5eyCEz9XXoMxxRn5bNS4lEmPkQwJLwXw6FBB4s4+nReRB8fXIPUFrFIFI8rB9vsgZKNTrZLjjJGT7ZmlRCUF1P6FhNsf04opLE9S4FRq+iiOSP/amA+exPSSXx2jd3KySOPVkFS6kzoyD+Tj6Lhe9WcpsStWzadnavor9xmQNG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoz0kP7TlyyO8x7+RhU2QNe28uAYxMWtipV31PkCT0k=;
 b=Y8HjHE2YaJE3kYJyDQhY3ki4AKAgZrlMd/wgufzTjZNNffRsKfTfLblagSj+ID7M800/Y0zwlO+BIVRVqiMbF/jObEfq5ytKZML8RLhcxw5EQLfJ/9CdH+tEyWhN1x9/NN2iloPNqXWF9q/6jUHkVB5ueTnaY78DFzsXPV7UWPw=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (52.135.202.143) by
 BYAPR02MB4696.namprd02.prod.outlook.com (52.135.235.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Tue, 26 Nov 2019 11:56:37 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 11:56:36 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: clocksource: Use ttc driver as platform driver
Thread-Topic: [PATCH] drivers: clocksource: Use ttc driver as platform driver
Thread-Index: AQHVlVaOW+EHQwVffUWJv7WplPkHr6edcAHggAAGWTA=
Date:   Tue, 26 Nov 2019 11:56:36 +0000
Message-ID: <BYAPR02MB40553CE8C7355FBA8E659F22B7450@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1573122659-13947-1-git-send-email-rajan.vaja@xilinx.com>
 <BYAPR02MB4055F607B83F35B5FBF68CC6B7450@BYAPR02MB4055.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4055F607B83F35B5FBF68CC6B7450@BYAPR02MB4055.namprd02.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 8258dc0f-0f8f-4d65-4eea-08d77267b0ce
x-ms-traffictypediagnostic: BYAPR02MB4696:
x-microsoft-antispam-prvs: <BYAPR02MB4696C40008F7EE939F514F56B7450@BYAPR02MB4696.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(189003)(13464003)(199004)(478600001)(14454004)(8936002)(86362001)(66946007)(66476007)(66556008)(64756008)(55236004)(2501003)(76176011)(316002)(7696005)(6506007)(5660300002)(55016002)(66446008)(229853002)(256004)(14444005)(2906002)(33656002)(7736002)(305945005)(102836004)(74316002)(3846002)(26005)(186003)(71190400001)(6116002)(4326008)(71200400001)(52536014)(110136005)(53546011)(54906003)(99286004)(25786009)(76116006)(2940100002)(81156014)(9686003)(8676002)(66066001)(446003)(6436002)(6246003)(81166006)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4696;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cd09L+3NHlOri9vCPQS1U+EVyakNttCHioqctZRvSWN8AJeYde/E4cxohZ+DmqFysmaPGCv+wU/YPKyx/0JZMjwggtWaQZStm5ZQGjWXNTF7ST7I8nhBA8eambNwUKfwqIdKz0LdofjE0KYKwhgzPdl5jp+vR3bO5YjFX7LRkJZS6TeHyheIY1WYHPE04jx4lm0o+5khTMIdj7BRsAia8nEmbFwNcfymOLFHUduOdg+r3eAEtLFg986DeQdZMxk28p/1b69Isa7cGiusgTx1qO32TIgiC8xQ7UYpwp4MpDv0SAHH3dygKPs08ASbR68tCzOo73mtaEses5zKKY3l8MBnwSBWNubw1q2cCNBOyDzZe7KYGMpDXYqbV89RCF9ogkUnnXyF7qzsarrdnA7/m27H2W+41nO2SKgrr6JS8WPYS5BhOZKQgLpSxSKc90VZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8258dc0f-0f8f-4d65-4eea-08d77267b0ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 11:56:36.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cGXQUABB1zs/9WRWPHSHi3m0HtnNJ8v1acP01rgR6tL4LWUaAqe7hp+mrZOL9M5ap+wQyrbsHahhLCsNvP2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this request.

Thanks,
Rajan

> -----Original Message-----
> From: Rajan Vaja
> Sent: 26 November 2019 05:06 PM
> To: Rajan Vaja <RAJANV@xilinx.com>; ichal.simek@xilinx.com;
> daniel.lezcano@linaro.org; tglx@linutronix.de
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] drivers: clocksource: Use ttc driver as platform dri=
ver
>=20
> Request for review.
>=20
> Thanks,
> Rajan
>=20
> > -----Original Message-----
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> > Sent: 07 November 2019 04:01 PM
> > To: ichal.simek@xilinx.com; daniel.lezcano@linaro.org; tglx@linutronix.=
de
> > Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;=
 Rajan
> Vaja
> > <RAJANV@xilinx.com>
> > Subject: [PATCH] drivers: clocksource: Use ttc driver as platform drive=
r
> >
> > Currently TTC driver is TIMER_OF_DECLARE type driver. Because of
> > that, TTC driver may be initialized before other clock drivers. If
> > TTC driver is dependent on that clock driver then initialization of
> > TTC driver will failed.
> >
> > So use TTC driver as platform driver instead of using
> > TIMER_OF_DECLARE.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > ---
> >  drivers/clocksource/timer-cadence-ttc.c | 26 ++++++++++++++++++-------=
-
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksou=
rce/timer-
> > cadence-ttc.c
> > index 88fe2e9..38858e1 100644
> > --- a/drivers/clocksource/timer-cadence-ttc.c
> > +++ b/drivers/clocksource/timer-cadence-ttc.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched_clock.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> >
> >  /*
> >   * This driver configures the 2 16/32-bit count-up timers as follows:
> > @@ -464,13 +466,7 @@ static int __init ttc_setup_clockevent(struct clk =
*clk,
> >  	return 0;
> >  }
> >
> > -/**
> > - * ttc_timer_init - Initialize the timer
> > - *
> > - * Initializes the timer hardware and register the clock source and cl=
ock event
> > - * timers with Linux kernal timer framework
> > - */
> > -static int __init ttc_timer_init(struct device_node *timer)
> > +static int __init ttc_timer_probe(struct platform_device *pdev)
> >  {
> >  	unsigned int irq;
> >  	void __iomem *timer_baseaddr;
> > @@ -478,6 +474,7 @@ static int __init ttc_timer_init(struct device_node=
 *timer)
> >  	static int initialized;
> >  	int clksel, ret;
> >  	u32 timer_width =3D 16;
> > +	struct device_node *timer =3D pdev->dev.of_node;
> >
> >  	if (initialized)
> >  		return 0;
> > @@ -532,4 +529,17 @@ static int __init ttc_timer_init(struct device_nod=
e
> *timer)
> >  	return 0;
> >  }
> >
> > -TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
> > +static const struct of_device_id ttc_timer_of_match[] =3D {
> > +	{.compatible =3D "cdns,ttc"},
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
> > +
> > +static struct platform_driver ttc_timer_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "cdns_ttc_timer",
> > +		.of_match_table =3D ttc_timer_of_match,
> > +	},
> > +};
> > +builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
> > --
> > 2.7.4

