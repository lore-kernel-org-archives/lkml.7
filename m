Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FEFC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719742075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s+I2dBFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfE0GSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:18:37 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:28390
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfE0GSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7X7v+RtS/SbVEEjw5DxlmYSuKS2YIRWftn6TCROuTO4=;
 b=s+I2dBFUSkMP2AemcyE5xktmm+etzNZDJTz2WGvy/kfDzHJwsuY0C39dTihv1fuz32IWjj2YRhfY+U51uxlEa1Kc9MyiLNmTxfGrGRcclBLHNc0JPk0Ykt8YESoBD+JuSV3W45TD7x9UX+vkfTvY7YNWCH1g6U1yr1YSrDn22BM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6436.eurprd04.prod.outlook.com (20.179.252.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Mon, 27 May 2019 06:18:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 06:18:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVESt7O8zUR8j7k0mzGFqyu7YBg6Z4+DAAgAGZogCAA+OE0A==
Date:   Mon, 27 May 2019 06:18:30 +0000
Message-ID: <AM0PR04MB4481A7076D94A55BD48F8ACC881D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190523060437.11059-1-peng.fan@nxp.com>
 <4ba2b243-5622-bb27-6fc3-cd9457430e54@gmail.com>
 <20190524175658.GA5045@e107155-lin>
In-Reply-To: <20190524175658.GA5045@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 579881cf-ea4f-45c3-1863-08d6e26b240f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB6436;
x-ms-traffictypediagnostic: AM0PR04MB6436:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB64364715FF660DE415640280881D0@AM0PR04MB6436.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(7696005)(71200400001)(6246003)(71190400001)(99286004)(66446008)(53936002)(52536014)(53546011)(86362001)(6506007)(102836004)(316002)(33656002)(5660300002)(6306002)(66066001)(9686003)(26005)(15650500001)(186003)(8676002)(81156014)(76176011)(81166006)(25786009)(55016002)(305945005)(8936002)(4326008)(54906003)(44832011)(68736007)(74316002)(486006)(110136005)(7736002)(476003)(446003)(11346002)(229853002)(14454004)(66476007)(7416002)(6436002)(45080400002)(64756008)(66556008)(2906002)(76116006)(3846002)(6116002)(478600001)(66946007)(73956011)(966005)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6436;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +3Q0dguV4QvkyxujNG/jKeheVdx3VRXzLaYL3X0olcmnBwCGaWqh+VFHUG7j/qqB7RRoixpyzb0hSzGyzuT6PAAfE/z2CC2ReG+6vhsn2Vn7K6SFtdmQZ0yKzmUORklX8Ys7rzbxkBm2fhQjfW31DM2ph4+j99V48H6V9ko4YQAtXurWkTd+nZlckvukkwEaZVHfigh8xodTFvW/vTHBFUQ5FoksXk6Z4htswnXSWLeTWQvuZorg2pDOfiy8DlS/OApdIfTq4hSozD1708FGKSzSjyH3Eo7gX//9EzF8fdGKLvZ7Zc7QdrxJT3YlMUDkQHjlgndxZ+W3meWy1kqn5YQPEvJy97+kADjovRFcuR2sCSJ/KbRON1RFBCTo+iAv71/tDt8O7v9yEisDzELMhFHLraf59FwooPdl/k9Nibw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579881cf-ea4f-45c3-1863-08d6e26b240f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 06:18:31.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> Subject: Re: [PATCH 0/2] mailbox: arm: introduce smc triggered mailbox
>=20
> On Thu, May 23, 2019 at 10:30:50AM -0700, Florian Fainelli wrote:
> > Hi,
> >
> > On 5/22/19 10:50 PM, Peng Fan wrote:
> > > This is a modified version from Andre Przywara's patch series
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Fpatchwork%2Fcover%2F812997%2F&amp;data=3D02%7C01%7Cpe
> ng.fan%40nxp.com%7Cfa2ba15f479b49eb219f08d6e0713ea3%7C686ea1d3b
> c2b4c6fa92cd99c5c301635%7C0%7C0%7C636943174355592142&amp;sdat
> a=3DY94rnxDEoMm9nyRyjJrYBqRduc5XkvvQhno7zfIQ%2B04%3D&amp;reserve
> d=3D0.
> > > [1] is a draft implementation of i.MX8MM SCMI ATF implementation
> > > that use smc as mailbox, power/clk is included, but only part of clk
> > > has been implemented to work with hardware, power domain only
> > > supports get name for now.
> > >
> > > The traditional Linux mailbox mechanism uses some kind of dedicated
> > > hardware IP to signal a condition to some other processing unit,
> > > typically a dedicated management processor.
> > > This mailbox feature is used for instance by the SCMI protocol to
> > > signal a request for some action to be taken by the management
> processor.
> > > However some SoCs does not have a dedicated management core to
> > > provide those services. In order to service TEE and to avoid linux
> > > shutdown power and clock that used by TEE, need let firmware to
> > > handle power and clock, the firmware here is ARM Trusted Firmware
> > > that could also run SCMI service.
> > >
> > > The existing SCMI implementation uses a rather flexible shared
> > > memory region to communicate commands and their parameters, it still
> > > requires a mailbox to actually trigger the action.
> >
> > We have had something similar done internally with a couple of minor
> > differences:
> >
> > - a SGI is used to send SCMI notifications/delayed replies to support
> > asynchronism (patches are in the works to actually add that to the
> > Linux SCMI framework). There is no good support for SGI in the kernel
> > right now so we hacked up something from the existing SMP code and
> > adding the ability to register our own IPI handlers (SHAME!). Using a
> > PPI should work and should allow for using request_irq() AFAICT.
> >
>=20
> We have been thinking this since we were asked if SMC can be transport.
> Generally out of 16 SGIs, 8 are reserved for secure side and non-secure h=
as 8.
> Of these 8, IIUC 7 is already being used by kernel. So unless we manage t=
o get
> the last one reserved exclusive to SCMI, it makes it difficult to add SGI=
 support
> in SCMI.
>=20
> We have been telling partners/vendors about this limitation if they use S=
MC
> as transport and need to have dedicated h/w interrupt for the notificatio=
ns.

This is an option, and we could add optional property.

>=20
> Another issue could be with virtualisation(using HVC) and EL handling so =
called
> SCMI SGI. We need to think about those too.=20

Using dedicated HW for virtualization that support vcpu scheduling might be
not a good choice, do you mean this? Dedicated pin vcpu to pcpu should be f=
ine,
just like jailhouse hypervisor.

I will try to get more info on this
> and come back on this.

Looking forward.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
