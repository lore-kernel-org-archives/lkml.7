Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC49EC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CF2215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PSO0qk7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfH3CuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:50:13 -0400
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:26157
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfH3CuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:50:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPN3hhKwC12xAj1vHz6GUYcksENeOc08YCsCav1PB2LqlE8G/x9pjsYmtMSEQBNbwHImSME3F8a2Y2KrD5mM/iEZ9K42a8L9WVNdoVgcqCE/VyXZc8nBS3HqmwulpuLa440mwkDANmqMHjHhL83Sn0ZZkN7va5V13gyGkOzurYf00SzeN0WKWFicnW0pnqMNfUmfM36DGMkcAL3PKrQQJIzm+t11G0s4LTNxfy+8svaxxdCRWCvcC5+EBUttiQ9Kd8NdlxEDy2j1E46tcj3tfAV3ietpFvuwIDvqpQ9v/QmmT19ehilTnjLRZ1gXHQ/e6+ls58j3uGN6iXAShEZAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM4eMRC1pihVgxOPeLGh00LxTRusVk0fhPpoVJ2JvOs=;
 b=MzmDj4rC3G85kL9ha/yBTe47PkI20TSTJcYIOzrHkS/SdfiHspFyB8IDg2GMUmETh36c0QZCvTg1ptF2H0nblAHRg3IKv5+WoTof3nDa1/zQpIUZtVyJ4LPl75kQFjLgsL+LiFeCLqpHmCEur4JgCDE+CkstaBGeA+VtuUqnQ/UgmawTG28C1yprBb0K4Xh7XK2/QMA560cNbYfwxmLlTl8JUTHtUxnT6FLgiiOmvEqT/RsgoZ0Nlo+AMFR0/F2CH9bJwfiLntYKm2OAXfKijZkUYl8RP2GaqQOBZhuGhZHL/3P/L17h5Yxh61ZHWP6m1sA2beZJPMfjIeHNsiwuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM4eMRC1pihVgxOPeLGh00LxTRusVk0fhPpoVJ2JvOs=;
 b=PSO0qk7f0unEJbRCV4D9tDQU/3MtPKug5O/EVO8A504m1WlaJhQxyMJ8hIQGCw9Ey5xozl/xxrwOszmLZwzetDvzTjg77WpGK7mOPtm905Q4JM14/so6y25S33nmOUnonBkE3Loxp0UR6CQdIl9SNHlzB+/Povx8c1TjmfWuCh8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5794.eurprd04.prod.outlook.com (20.178.117.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Fri, 30 Aug 2019 02:50:05 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Fri, 30 Aug 2019
 02:50:05 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH v5 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVXU0ae8K1wuPrRECT1HUVPDQ2yacQl8yAgAJoF4A=
Date:   Fri, 30 Aug 2019 02:50:05 +0000
Message-ID: <AM0PR04MB4481944FA435E252C786B73888BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-3-git-send-email-peng.fan@nxp.com>
 <20190828140217.GC21614@e107155-lin>
In-Reply-To: <20190828140217.GC21614@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ef33731-de4a-473c-d052-08d72cf4c36d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5794;
x-ms-traffictypediagnostic: AM0PR04MB5794:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5794779080671792B965533F88BD0@AM0PR04MB5794.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(45080400002)(4326008)(478600001)(71200400001)(14454004)(71190400001)(966005)(53936002)(5660300002)(9686003)(55016002)(52536014)(6306002)(25786009)(6246003)(256004)(2906002)(33656002)(54906003)(15650500001)(8936002)(81166006)(81156014)(8676002)(316002)(66066001)(6116002)(3846002)(7696005)(102836004)(486006)(11346002)(446003)(86362001)(476003)(44832011)(76176011)(229853002)(6916009)(6506007)(26005)(99286004)(74316002)(6436002)(66446008)(64756008)(66556008)(66476007)(76116006)(305945005)(66946007)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5794;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6vUiDhrJ1JuWX5PjFQa3RSYSwXX8UdKbEqj/6SgJfXCGEWRazN1ZkD+u2siozVAdlULHstszX4cElShKAcBoGM2+XwilCw6BNjmLxeOW7uwr2R07JdE2X/+yKTu+M1y0H6yxgG3ycLYcgTaqyV+skNYeLP5oXFY+czFFvHojNGrzTXk5nyBwP6R+8cKBwD1fEcTfD1JZw6EOxYCLBwwolZYDNVog8Ff5ci6Q8EJ/QWW1bqPZ0vIiehKXLbb2hKrzpWmrO4uM/1jCJO/Muu1DCm+DKcPkDIofokLLxfGRS6TcuFLkdDGGdbAO2WRoLyrJyD5j9joCiLBfZlaDSRWP378/085TFxw6wSo1sRNhv1LEI6ugndr1kzGgiWGioFnpdi4wieuC4dsrveoIW5a4YtkK1aVTLuCLkdeTLML6/So=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef33731-de4a-473c-d052-08d72cf4c36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 02:50:05.7561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dN7yG6ehuzJE/VUvxXcurrvY6TI+c0zxZkar9tXmMndOY1cUIpbAdeDXMNdHrhUar6mhJUMMURpxB0pz6q8IFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v5 2/2] mailbox: introduce ARM SMC based mailbox
>=20
> On Wed, Aug 28, 2019 at 03:03:02AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This mailbox driver implements a mailbox which signals transmitted
> > data via an ARM smc (secure monitor call) instruction. The mailbox
> > receiver is implemented in firmware and can synchronously return data
> > when it returns execution to the non-secure world again.
> > An asynchronous receive path is not implemented.
> > This allows the usage of a mailbox to trigger firmware actions on SoCs
> > which either don't have a separate management processor or on which
> > such a core is not available. A user of this mailbox could be the SCP
> > interface.
> >
> > Modified from Andre Przywara's v2 patch
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fpatchwork%2Fpatch%2F812999%2F&amp;data=3D02%7C01%7
> Cpeng.fa
> >
> n%40nxp.com%7Ca1e96c6b782d43b2cfb208d72bc05898%7C686ea1d3bc2b
> 4c6fa92cd
> >
> 99c5c301635%7C0%7C0%7C637025977487779923&amp;sdata=3DrzC%2B4Y1c
> q9Y3tSDFR
> > %2Fsvf5ktk7INP2rwXN%2BXdWCVjNs%3D&amp;reserved=3D0
> >
> > Cc: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/mailbox/Kconfig           |   7 ++
> >  drivers/mailbox/Makefile          |   2 +
> >  drivers/mailbox/arm-smc-mailbox.c | 215
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 224 insertions(+)
> >  create mode 100644 drivers/mailbox/arm-smc-mailbox.c
> >
>=20
> [...]
>=20
> > +static int arm_smc_mbox_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct mbox_controller *mbox;
> > +	struct arm_smc_chan_data *chan_data;
> > +	const char *method;
> > +	bool mem_trans =3D false;
> > +	int ret, i;
> > +	u32 val;
> > +
> > +	if (!of_property_read_u32(dev->of_node, "arm,num-chans", &val)) {
> > +		if (!val) {
> > +			dev_err(dev, "invalid arm,num-chans value %u\n", val);
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!of_property_read_string(dev->of_node, "transports", &method)) {
> > +		if (!strcmp("mem", method)) {
> > +			mem_trans =3D true;
> > +		} else if (!strcmp("reg", method)) {
> > +			mem_trans =3D false;
> > +		} else {
> > +			dev_warn(dev, "invalid \"transports\" property: %s\n",
> > +				 method);
> > +
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!of_property_read_string(dev->of_node, "method", &method)) {
> > +		if (!strcmp("hvc", method)) {
> > +			invoke_smc_mbox_fn =3D __invoke_fn_hvc;
> > +		} else if (!strcmp("smc", method)) {
> > +			invoke_smc_mbox_fn =3D __invoke_fn_smc;
> > +		} else {
> > +			dev_warn(dev, "invalid \"method\" property: %s\n",
> > +				 method);
> > +
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	mbox =3D devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> > +	if (!mbox)
> > +		return -ENOMEM;
> > +
> > +	mbox->num_chans =3D val;
> > +	mbox->chans =3D devm_kcalloc(dev, mbox->num_chans,
> sizeof(*mbox->chans),
> > +				   GFP_KERNEL);
> > +	if (!mbox->chans)
> > +		return -ENOMEM;
> > +
> > +	chan_data =3D devm_kcalloc(dev, mbox->num_chans, sizeof(*chan_data),
> > +				 GFP_KERNEL);
> > +	if (!chan_data)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < mbox->num_chans; i++) {
> > +		u32 function_id;
> > +
> > +		ret =3D of_property_read_u32_index(dev->of_node,
> > +						 "arm,func-ids", i,
> > +						 &function_id);
>=20
> I missed it in binding but I thought we agreed to make this "arm,func-ids=
"
> a required property and not optional ?

Not sure Jassi is fine with it being a required property, but I could conve=
rt
it to a required property in V6.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
