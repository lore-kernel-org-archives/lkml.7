Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6628FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W6mXA4S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfKKHyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:54:50 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:5401
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbfKKHyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:54:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mANoakNXYnhzeIkh14cErE2NjZE5zv4a9MbRNc1Sfe85dyEd60rFutps4lrlYvRNulO6qPrhR7Ei+7zZGmfc1oFxicLiS4KCFeSWlBJk99KF5zDVRhNmjkII31nCP4lsbycgmr3cZ7dy3bqLXUVBnHUKcG1vK2fSssa1G9K998uCSnJUHLQAkjXnO6fWGF6OBBAevn8N3EqgNySC8H6f8Rp0BZjZUX9h5CtxBoLPB7Jb5EnaesIRXQnCzN8AAcqE47q08i8HtacUsvpHHsUUpMQddozGdU6giAX6TIOMiOkQkqVP4SHTM5KG7D5Q6t26oLwcmgoRGtyctlPynxQ5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvbbnzIryOVVl80iIfs8Ei12JSMdoYhPRXKeWzn0DPY=;
 b=NuTJASCnvFwWqsPzzNAZ5jrcYwYBQhydVSzHw75Krbtd5xTA3cZEc7wGOP7iQqJzQCtCbdSquRoqSzi3knejRJ5WKtSjgpThbbIdvt7Tb06n32zyfJzy9K5MjRx8KilMpFN3s5yLBxoZKEQCRbsrXqXVGXBk7ovwl/ijdq69bttxuOTsb7DyFR3KCoyYaF6eSTGtjdmxxy/Mh74N7BMO6bpaeByRJ0sQGcMrIXVz6jw3BAF+O08xopsvXLSvItEIRYhLRVLuvgIXbyxLxzykNFXYRkcMPgaoU6uxXFPQ1WzkbyIj5V4qcQ2wfIZQkVaGLIclhXJv2wHye0fCKyXlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvbbnzIryOVVl80iIfs8Ei12JSMdoYhPRXKeWzn0DPY=;
 b=W6mXA4S5ZIt+1KilR30CLXWKqGc1FibgQtb6/p5soBP06r9wNUd/RgkQthns2ZfDvhN+UR591m0BLMBVqsNXND5fn9DvQ3M+KdA6rhWzCXOLg0KPKx5FMF/9dtEXHaW1hHBLd2NZlZqXQFwKz8NZcftE8qDO/ly+AYTcDhcdWe8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4915.eurprd04.prod.outlook.com (20.176.215.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 07:54:43 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 07:54:43 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Topic: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Index: AQHVH4Y/3naZJOmQTkOgrNdQmlNuA6eCDj6AgAAIBACAACkeAIAETB+A
Date:   Mon, 11 Nov 2019 07:54:42 +0000
Message-ID: <20191111075441.usbd62w45vxnwcj4@fsr-ub1664-175>
References: <d217a9d2-fc60-e057-6775-116542e39e8d@posteo.de>
 <7d3a868a-768c-3cb1-c6d8-bf5fcd1ddd1c@posteo.de>
 <20191030080727.7pcvhd4466dproy4@fsr-ub1664-175>
 <523f92bd-7e89-b48a-afd0-0a9a8bca8344@posteo.de>
 <20191104103525.qjkxh2zhhgaaectk@fsr-ub1664-175>
 <433f3f03-f780-c327-f1e8-fbf046a8374c@posteo.de>
 <VI1PR04MB70231EA80BB20C9A84B1B799EE790@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <c3519156-9769-980b-d9e7-af372ced8797@posteo.de>
 <20191108115002.cqzvpxydzwos64vp@fsr-ub1664-175>
 <26d3834d-6fba-be48-5b3c-5abf86d121a7@posteo.de>
In-Reply-To: <26d3834d-6fba-be48-5b3c-5abf86d121a7@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::28) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bf65f17-5e22-4542-ab74-08d7667c695c
x-ms-traffictypediagnostic: AM0PR04MB4915:|AM0PR04MB4915:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB491592FFE9EA7310769BEAA5F6740@AM0PR04MB4915.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(51914003)(6486002)(229853002)(9686003)(478600001)(1076003)(33716001)(966005)(14454004)(6436002)(8676002)(316002)(6512007)(14444005)(256004)(45080400002)(81156014)(81166006)(6306002)(3846002)(6116002)(44832011)(54906003)(86362001)(6246003)(8936002)(186003)(7736002)(53546011)(7416002)(4326008)(26005)(476003)(6916009)(486006)(99286004)(66556008)(64756008)(66446008)(2906002)(66476007)(71190400001)(71200400001)(102836004)(76176011)(25786009)(66066001)(386003)(6506007)(66946007)(5660300002)(11346002)(52116002)(305945005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4915;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIamg94k+hsDMYsTke51ZCjGgQRHKX4xnAi/WYpCAzFexa1b2f7oft3Jn5MDINVAG4HjDgHc7gntRFjp9J7xUQuuW3tTd4n2UMY0SurVhn0YOx85VDxDoQ2HTPLMWrpOm1bDbcq3A7O9sN9+cyr+V77em87bOeVDgvoZLWEM76rIgEO8/5y8xA2p/sLM9dBu8Ei2O5xvqc6eVzEuLhRHRfc+Gry4ciCfNMMlh+p9dO0w3obMNtYQM0cF0WgS0hVma/rDcNyqcDrQRt/Ky6VOuWq17jwPdjf6UzzoMGzwMXuN0HAIG1pSTf7PRAa+nrZPY+viOW4vnSC5Oe0qMOy5Ohw3rD2ubw9DfYCpALAGQrGE+cOEHNj+Xi6Z7mdbu0GEAHJRDy1y8oy+blBfwPG8erqHGktlPbobomvlegi/W16QnpJ98H22m00P6r4XeQEZ6wxsWyWwTMK5Q1RMYTGgNqHGNCS+QZW9jWj4H3HAFM4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F43DEB12F722184E9DC093EBCA2D3D1D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf65f17-5e22-4542-ab74-08d7667c695c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 07:54:43.2969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUi6IY7vbePC1I3FB68Jzv2P+B4kCyH67K9sNreDmuZO0ehn+1CjYbfuFaZ3MOool6wbDri4gC4pTaTnDoIjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-08 15:17:12, Martin Kepplinger wrote:
> On 08.11.19 12:50, Abel Vesa wrote:
> > On 19-11-08 12:21:21, Martin Kepplinger wrote:
> >=20
> >> Hi Leonard, hi Abel,
> >>
> >> Thanks for having a look! To sum up this problem and not to get confus=
ed:
> >>
> >> We have the workaround that changes irq-imx-gpcv2 from this very email
> >> thread, to be used with mainline ATF. when applying Abel's recent diff=
,
> >> Linux 5.4 boots but I still don't have a cpuidle driver.
> >>
> >> When I enable CONFIG_ARM_PSCI_CPUIDLE, the kernel hangs during boot
> >> (after probing mmc, but that doesn't tell much)
> >>
> >> What do I miss?
> >>
> >=20
> > OK, please fetch the branches called "imx8mq-err11171" from both follow=
ing github repos and give it a try:
> >=20
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2Fabelvesa%2Flinux.git&amp;data=3D02%7C01%7Cabel.vesa%40nxp.com%7C6=
63191bd4af6489d08f808d764565ca2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%=
7C637088194388256459&amp;sdata=3DHydsZLtPExbRx7qDByTI%2FCYFGYS67fU9FDsLmHy7=
x7o%3D&amp;reserved=3D0
> >=20
> > and
> >=20
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
hub.com%2Fabelvesa%2Farm-trusted-firmware.git&amp;data=3D02%7C01%7Cabel.ves=
a%40nxp.com%7C663191bd4af6489d08f808d764565ca2%7C686ea1d3bc2b4c6fa92cd99c5c=
301635%7C0%7C0%7C637088194388256459&amp;sdata=3DzkCpOrEvoiNGj7BBuVuHzTWmBFa=
Zk0SCuePOKZA3T2o%3D&amp;reserved=3D0
> >=20
> > I just tested it. Works with defconfig.
> >=20
>=20
> thanks for the reminder. I was missing IMX_SCU_PD appearently.
>=20

There is no SCU on 8MQ so I don't think that was the problem.

Maybe something else.

> thanks for the effort, I hope this is useful for others too.

I'll try to keep those up-to-date.

>=20
>                          martin
>=20
