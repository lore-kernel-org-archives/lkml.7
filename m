Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB397C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFC220820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="MlyV5Bcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfDJJxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:53:46 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:22339
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729024AbfDJJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqKDdSpxXrG3Q0raLcuSlYfZ085ntoKGhIHQR77bk7I=;
 b=MlyV5Bcfw1st2nJfhcofmwnYAHGwYwRt0oj+BaZvfW6kmcS1vwVZnV0WnokY1j+k1mVIlVjBg6cEPWwVnQQvYnefpqDP7HXP/DUwsrX9YeYlJQrTMwKMcj6kEHmhHlHmQwjIDDms1X56sC/70bhuoUWYwOJDwYfthuzmT+IcfzM=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3880.namprd03.prod.outlook.com (20.177.124.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 10 Apr 2019 09:53:40 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 09:53:40 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "RaghuramChary.Jallipalli@microchip.com" 
        <RaghuramChary.Jallipalli@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Topic: [PATCH] net: lan78xx: fix "enabled interrupts" warninig
Thread-Index: AQHU7dHNU1pmmx19ukWi008Ht4Z+BqYx4peAgACJ84D//6iSAIABfFmAgAGQOQCAAAb8AA==
Date:   Wed, 10 Apr 2019 09:53:40 +0000
Message-ID: <20190410174538.5ebe1787@xhacker.debian>
References: <20190408140301.3dcbccdd@xhacker.debian>
        <BL0PR11MB33292EC33542F7D4FE5208469F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
        <20190408155947.3efcb1eb@xhacker.debian>
        <BL0PR11MB3329824981AAA87127C157C69F2C0@BL0PR11MB3329.namprd11.prod.outlook.com>
        <20190409092753.39961390@xhacker.debian>
        <BL0PR11MB3329C59EEA6073D8073D23ED9F2E0@BL0PR11MB3329.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB3329C59EEA6073D8073D23ED9F2E0@BL0PR11MB3329.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::34) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dad3aadb-567f-4c3f-8f1e-08d6bd9a68ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR03MB3880;
x-ms-traffictypediagnostic: BYAPR03MB3880:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR03MB3880701166A0E6F017A11E57ED2E0@BYAPR03MB3880.namprd03.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(386003)(99286004)(316002)(6436002)(4326008)(186003)(93886005)(52116002)(26005)(68736007)(54906003)(6506007)(25786009)(53936002)(11346002)(6246003)(486006)(50226002)(76176011)(5660300002)(1076003)(2501003)(102836004)(110136005)(446003)(7416002)(305945005)(97736004)(229853002)(14454004)(2906002)(6116002)(72206003)(476003)(8936002)(7736002)(71200400001)(105586002)(966005)(66066001)(81166006)(478600001)(6486002)(106356001)(14444005)(81156014)(3846002)(256004)(8676002)(86362001)(9686003)(6512007)(71190400001)(6306002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3880;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RZWairOrWye5e2Kr/Gs8FTLmO9fHL11VxAJhxM4RsKVOOJIal2876a2VcQsjmBq4nSU3H1AsJqvWDE6QtdmTtT6vExmKHOa9sZ+5Rr8KI26LIGnA5iWBdcQBgrH90a/vwzJNXgLgb1er4M5LBwCaSXsBkxnTloNlZNpDxjLx2hQ1cZbpJZcnJm9Sw8Y0aZt+FDIUjAKrMqJla4l4wTAxKzh/aYcedcmb5nsLmGq0OWO7WAVE81ZHgXgBYD2McQ0xF9eKzQmMWPhH93Vd6QG+8sPMv8LNDYDrKl70T8n7aIC2xj9VDGKVft+ZNOeZU7Rc9CgokGxKQ+FGAtmm/Zy8yn6iGNmOykRgbaVzzi26NtidslXdXCIQCiisrzPfbx8Kj9/HFWEAr3+wYcJ5O1IKVAZ0ibpNZH98fmpD7TiPb54=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02C17BC8AC08E84D878D863630B10416@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad3aadb-567f-4c3f-8f1e-08d6bd9a68ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 09:53:40.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Apr 2019 09:20:38 +0000 wrote:

>=20
> > > >
> > > > The warning comes from calling generic_handle_irq() in usb tasklet =
=20
> > context. =20
> > > > This is not correct.
> > > >
> > > > Per my understanding, if there's chained irq, we could introduce
> > > > extra irqdomain. E.g
> > > >
> > > > GIC <--> another irqchip controller <--> HW device
> > > > =20
> > > Correct, IRQ domain is generally used in chained irq controllers.
> > > Yes, We need to check why irq domain is used in the current driver.
> > > =20
> >
> > It's introduced in the commit cc89c323a30e
> > =20
> Hi Jisheng,

Hi,

> I had spent some time to look into the history of commit. The reason for =
having irq domain in driver is because of the unavailability of real hardwa=
re interrupt, here we have USB interrupt pipe which is not actual interrupt=
.
> So changes were proposed to have pseudo phy interrupt and handlers in phy=
 lib. But later it was suggested to implement linux interrupt controller in=
 driver itself.

+ Andrew, Florian

USB net is different with Andrew's case.

there's no irq at all in usb net

but in Andrew's case, interrupt is connected to a GPIO line. As is known
GPIO can behave as irq chip.

> You can see the archive here https://patchwork.ozlabs.org/patch/564511/

Per my understanding, the purpose is to avoid phy_state_machine() poll
phy_read_status() to monitor phy link. But as pointed out by Florian,
phy_mac_interrupt() is intended for that purpose. And the poll should be
fixed in phy. Since the email was sent in 2016, maybe the bug has been fixe=
d.

> I want to understand if there is any functionality impact with this warni=
ng? Because I'm afraid if the current changes are removed we might hit some=
 other issues (or older ones). We have to go through rigorous testing befor=
e going ahead.

Warning indicates there's something wrong in the code.

IMHO phy_mac_interrupt() and PHY_IGNORE_INTERRUPT is the correct
solution. If the phy_mac_interrupt() poll is fixed, I think maybe
old issue which commit cc89c323a30e want to fix won't exist.

Thanks
