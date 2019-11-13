Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F4DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C052196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Jr/aWjMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKMHFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:05:18 -0500
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:64078
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfKMHFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:05:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcGdRTUNLmtRrv4D5tqa6oq3fQ2BmG9xce4m1QN+9TB6iSbxhjiVJVkH15am+G0AaVUrJ2m6ECJ7VhhqKneWQPxXwHr6ZiVTo+7b0g6TLsgju3GxHM7HfppYl43CMzhagbY4hW1CjCDwSf737ZzLhbDcI5JPuzBEuafzP+ZuwSGdCE0QAfBIQ3F8MBGLxTODfDThwCtdKBvbc7OIaUXCdQofH12U1cZHpkIRYUIStGQL3rHlcoL5JB1IIjYNA+2O3hD6R3jrwpSGSlpv3mGKaYlhVC02R4/2xvGAd5vNZ2BUv3MXX1fDDFjNJhKomBFKESmq78UUVTPBR4qUmIWMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV9vvHNp5YbuHFF3W4CDy7gmCFfmVxUaAMs8imZvdBQ=;
 b=KrdHR4WHb+GuoCvAMW4c2p4wDE/73wQsHL/++GIIdF1rsby7EQnRv9QaxBaZLb4iZ6T/tjL4KLgxb7MUaqImd/Tp/0mAit59iBuM+tjc1L6HNeLXM1f2f+7ejirvcjjddju3msBCBqvrsPsZ+7eWCkrgR4KLCHXB3kBCPTXto+KRS7rrLxtkSbLUYCGgu+CudKn/U0Y7YrcGRvKbpcyAzm/1thrWMkO7Wp49cGJSnhCHRLaJ/FgxhiZod/8hme1WF5bM8wDfmVLCLPN/tFD5JsWpxNNYmHOJZqOUIxE1C3ZTEEIf6CPnhXgMFtPSuid9jJ/SNLXXa/7heCkUQtutaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV9vvHNp5YbuHFF3W4CDy7gmCFfmVxUaAMs8imZvdBQ=;
 b=Jr/aWjMW6ygJnqiO6DFD0+39hkvO+INmy+ta15ov3VDDrZ7fCeZXlEdjRBEFX5mybloasJbBt4zG5vYE4w3IXYM8ycgrKGgI/GIkGJEHc/7E8/R5l3vblkkI1nEOpp3y8GujBoy23jzIjsETnEfefgz6Gsss07SEKjwztjSgy0Q=
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com (20.177.196.210) by
 AM6PR05MB4997.eurprd05.prod.outlook.com (20.177.36.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 07:05:13 +0000
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::59a9:b6c3:97d8:ff0f]) by AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::59a9:b6c3:97d8:ff0f%3]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 07:05:13 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Shravan Ramani <sramani@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     Liming Sun <lsun@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
Thread-Topic: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
Thread-Index: AQHVmJ1B8i6N8wQYJ0iG7pe+aDUVfKeHm2XwgAD9HICAAAutMA==
Date:   Wed, 13 Nov 2019 07:05:13 +0000
Message-ID: <AM6PR05MB5224957FCA67040E9C60DF17A2760@AM6PR05MB5224.eurprd05.prod.outlook.com>
References: <cover.1573460910.git.sramani@mellanox.com>
 <AM6PR05MB522463C06CB3E7528F18281FA2770@AM6PR05MB5224.eurprd05.prod.outlook.com>
 <AM0PR05MB68202BBD8E817EF7E953D866CE760@AM0PR05MB6820.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB68202BBD8E817EF7E953D866CE760@AM0PR05MB6820.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f30145e-01bd-4611-d1c2-08d76807d489
x-ms-traffictypediagnostic: AM6PR05MB4997:|AM6PR05MB4997:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB4997763515055085761D81BDA2760@AM6PR05MB4997.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(13464003)(189003)(199004)(14444005)(6436002)(256004)(9686003)(110136005)(66066001)(4326008)(8936002)(446003)(55016002)(52536014)(2906002)(81166006)(3846002)(25786009)(8676002)(71190400001)(316002)(6116002)(11346002)(54906003)(229853002)(99286004)(5660300002)(14454004)(81156014)(33656002)(486006)(476003)(71200400001)(7696005)(6506007)(76176011)(66946007)(86362001)(74316002)(186003)(305945005)(478600001)(26005)(6246003)(66446008)(102836004)(7736002)(66476007)(66556008)(64756008)(76116006)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4997;H:AM6PR05MB5224.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sXEFgnHRUZe8j3M56v4G3jYGpOKwNncc6PuBXndw44DG1krMAhmibbHT/zgNiCxW+INsUJk877AgQVTj+/aPmn1hdTTy8p3mU6W45HU7XYZKsvw4pDTCJLMGhPQ75p52SiJOakuv2gK9wjPBpaYGZPsPxCEar+XKhPsOJoMzV/Y+QYFn01z8O0QujdxEFVH6ohZ6v+8HZAu3HjUDqTCd0NyTWTwdySuqo+Bb0V5ZLubNily8ahidIX4vFBtPwyBa5KnTZ40qF9gppIPNvhQI/+tiKvStDZQI74CGyiiSCdbY8KK8bxgI0ecE+pz+DpLXmIa/CrHeITkaClIO/3RwwaZNe3KUinGoIFJ+5S7bLTMZrht/WOENzfI9IreHg+hjvQZP8b+oN8fAuwSNxRdtVnmlDCq82yLtxF/gT6mGwdSpN13A7pvMYOB9vqRWqJrS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f30145e-01bd-4611-d1c2-08d76807d489
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 07:05:13.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enaiyKAR36SmQDm1AqRaI/osXSaW1JIdL2nSHq+juNrO7PQQxX2lysTDAGKwdOjlYxPdnd/7eytjUhOHJAPTkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4997
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shravan Ramani
> Sent: Wednesday, November 13, 2019 7:41 AM
> To: Vadim Pasternak <vadimp@mellanox.com>; Andy Shevchenko
> <andy@infradead.org>; Darren Hart <dvhart@infradead.org>
> Cc: Liming Sun <lsun@mellanox.com>; platform-driver-x86@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
>=20
> Hi Vadim,
> TRIO stands for TRansaction I/O and is an internal code name for our PCIe=
 to
> CHI bus interface.
> In Mellanox BlueField SoC, the configuration is as follows: there are 3 T=
RIO
> blocks where TRIO2 is connected to a Mellanox ConnectX-5  while TRIO0 and
> TRIO1 can be configured to behave either as a PCIe Root Complex to
> downstream ports (8 ports or 16 lanes each) connecting to storage devices=
, or
> as an end-point when plugged into an external x86 host (SmartNIC form fac=
tor).
> Each TRIO block has a separate ACPI table entry which invokes this driver
> thereby creating a total of 3 instances.
> The purpose of this driver is to be able to read/set the L3 cache profile=
 from a
> list of available profiles for transactions coming in to each TRIO block =
and is
> meant to run on the ARM cores powering the BlueField SoC.

OK.
It was necessary to have such sort of explanation in the description.

I am also not sure you choose correct location for this driver.
Why it should be in drivers/platform/mellanox/ and not in for example
drivers/acpi/?

Regarding the patch content.
(1)
Please, follow naming convention which we have in folder:
drivers/platform/mellanox/, like in module mlxbf-tmfifo.c
mlxbf_trio
MLXBF_TRIO
for all routine names, defines, types.
(2)
Fix includes order ("io" before "irq").
(3)
Don't use magic numbers like '3'.
(4)
Why in 'probe' routine failure of symlink creation treated as
warning?=20
(5)
Remove stuff like
'dev_warn(dev, "%s: failed to find reg resource 0\n", __func__);'
'dev_warn(dev, "Error probing trio\n");'
(6)
I suggest to make all the above comments and send the updated
patch for internal review to myself cced to linux-internal@mellanox.com,
before sending it to linux-internal@mellanox.com.

Thanks,
Vadim.

>=20
> Regards,
> Shravan
>=20
> -----Original Message-----
> From: Vadim Pasternak <vadimp@mellanox.com>
> Sent: Tuesday, November 12, 2019 8:15 PM
> To: Shravan Ramani <sramani@mellanox.com>; Andy Shevchenko
> <andy@infradead.org>; Darren Hart <dvhart@infradead.org>
> Cc: Liming Sun <lsun@mellanox.com>; Shravan Ramani
> <sramani@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
>=20
>=20
>=20
> > -----Original Message-----
> > From: Shravan Kumar Ramani <sramani@mellanox.com>
> > Sent: Monday, November 11, 2019 4:35 PM
> > To: Andy Shevchenko <andy@infradead.org>; Darren Hart
> > <dvhart@infradead.org>; Vadim Pasternak <vadimp@mellanox.com>
> > Cc: Liming Sun <lsun@mellanox.com>; Shravan Ramani
> > <sramani@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
> >
> > This patch adds support for Mellanox BlueField TRIO PCIe host controlle=
r.
> > The driver supports multiple TRIO instances and provides a sysfs
> > interface to allow the user to read/set the L3 cache profile for
> > transactions going through the TRIO. It also provides an interrupt hand=
ler for
> the TRIO blocks.
>=20
> Hi Shravan,
>=20
> Could you, please, explain what TRIO PCIe host controller?
> What is TRIO, is it some internal name or it's some standard terminology?
> If it's internal, please, explain for what it stands for.
>=20
> Same for TRIO instances. Are there some host side PCI instances?
> What are the purpose of them?
>=20
> Could you, please, also explain the system configuration?
>=20
>=20
> >
> > Shravan Kumar Ramani (1):
> >   platform/mellanox: Add Mellanox TRIO driver
> >
> >  MAINTAINERS                            |   5 +
> >  drivers/platform/mellanox/Kconfig      |   8 +
> >  drivers/platform/mellanox/Makefile     |   1 +
> >  drivers/platform/mellanox/mlxbf-trio.c | 624
> > +++++++++++++++++++++++++++++++++
> >  4 files changed, 638 insertions(+)
> >  create mode 100644 drivers/platform/mellanox/mlxbf-trio.c
> >
> > --
> > 2.1.2

