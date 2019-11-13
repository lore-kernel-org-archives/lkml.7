Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3351C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF232222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 05:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="B0ar6GD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfKMFki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 00:40:38 -0500
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:20288
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfKMFkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 00:40:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCgSHOPygca155AvqVaVrtTqRNkxTdfNncyXlgpYVD/pX2VGuBgoWPXFAdQ2gdcrngLHqOeM9JilzeqkofomAHA3Kt7qlbCCq1FnrA7Q0KmS17AeEgxYBOZ4tRCYWNpPBlj7kQ+JEukZ2b9UEPpHKvOA2c/lHvXRUxYCOrZUx8gr7WTnsgnxEVHF8gfm+wPV3qjsNZxjRuCOsK8XfKWIlC/aycXu79M6HPBud10Vo5kK5ZftftWHwG5g6OFZwqK93QdTGiHhfmSQPVBYM84m+3HWSiQvuwbV9gZ4R8toXONBN7mSlILt2aAu1UxEZ26zd3PEo46qRW4L63cWt6HYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrlU85R+VIaBq1peKHnkxD/zd6+MwmXi28vScWjNKbE=;
 b=dwKFXh3qLfHH+S4zgyHg/NIRDzmQmDhwhK3sEP9gdSRQgJxi1r0eZL78l9uU8pgcc2tU83ztitgWFjZRNUK5utvgiBPbQoBQDyzDx7S3xr+j1EbvXmBBYbF4Lq1UnAqwxfjebpQ8LUnK5bVjDxCzrxibfR9yH7Purwp5udvlWHik6q4GPbacldtAqPcQzQkDdXa2LC7CGWebvd3wFEv4otsWK7ngiQo4jq5CGR2UmzIhPXBB+CeFUr+Sw5Co/NqQikDxlPgGygTTquwj7R1CdgsQP+7RzIFHG8H2d3XOiTmr+KE+axLdnS4fitQtWt9RDYuRse9D2IQ33WPdX4HyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrlU85R+VIaBq1peKHnkxD/zd6+MwmXi28vScWjNKbE=;
 b=B0ar6GD99om1Va0Vc/fKivrV1f34+QySyV6cd41BeOFMFwGtnHYs2V0L0qNktlfdfmy9tnD5KPlixl1inSeHBAPTi3GHX8k3wWWXx9UeTaybTRNc1ksDisYAZn4mHC8b8pTYznSvlHGoCtVniDMccKciS2NNDEewr1rUTA3TBI0=
Received: from AM0PR05MB6820.eurprd05.prod.outlook.com (10.186.175.11) by
 AM0PR05MB5764.eurprd05.prod.outlook.com (20.178.115.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 05:40:33 +0000
Received: from AM0PR05MB6820.eurprd05.prod.outlook.com
 ([fe80::cc6b:fdda:4f2f:d018]) by AM0PR05MB6820.eurprd05.prod.outlook.com
 ([fe80::cc6b:fdda:4f2f:d018%7]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 05:40:33 +0000
From:   Shravan Ramani <sramani@mellanox.com>
To:     Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     Liming Sun <lsun@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
Thread-Topic: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
Thread-Index: AQHVmJ1lQrUy8w6HD0KGMSjlY6V9BqeHnigAgAD4RBA=
Date:   Wed, 13 Nov 2019 05:40:33 +0000
Message-ID: <AM0PR05MB68202BBD8E817EF7E953D866CE760@AM0PR05MB6820.eurprd05.prod.outlook.com>
References: <cover.1573460910.git.sramani@mellanox.com>
 <AM6PR05MB522463C06CB3E7528F18281FA2770@AM6PR05MB5224.eurprd05.prod.outlook.com>
In-Reply-To: <AM6PR05MB522463C06CB3E7528F18281FA2770@AM6PR05MB5224.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sramani@mellanox.com; 
x-originating-ip: [27.5.62.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63eb3816-1660-4451-2ea4-08d767fc0072
x-ms-traffictypediagnostic: AM0PR05MB5764:|AM0PR05MB5764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB57641CA7D8C3E57F4640C7B3CE760@AM0PR05MB5764.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(13464003)(189003)(199004)(81166006)(5660300002)(102836004)(8676002)(81156014)(74316002)(52536014)(33656002)(478600001)(4326008)(6246003)(66066001)(3846002)(6116002)(316002)(229853002)(6436002)(186003)(55016002)(2906002)(9686003)(76116006)(8936002)(11346002)(25786009)(256004)(64756008)(66476007)(446003)(54906003)(14444005)(7696005)(110136005)(476003)(14454004)(26005)(66946007)(71190400001)(486006)(66556008)(71200400001)(66446008)(53546011)(6506007)(99286004)(76176011)(86362001)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5764;H:AM0PR05MB6820.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWPnms66fpyenLwUzyN2vl1EV/yYibuwn8dX8ocX56Yue3lxPhEcfwVKP2DRNeIvWPrt0TTrAFHEHYpSh5I1WYP6IUeLYPGLns2rV6hitUuy3RFXO/0Hkqzewmb5L8pC6++fJCdSxPoPpPo8TrA/5kx8tfhBkg70cmVdRORHoUNO1+uReRYypoEbfZYH/qruu8wdoF/bklY5y/aZ7GK9WlM22PtnDnEEjKBWymLecarRobqpY1+dJiCmFMtyKXR+y/FSuDQtEg57mRJQ4/SAJcXb6o4Ax4WumCpOgWjsD+SYReABp+mrA9bN7EsO+mIjI2rj8WrmxHd+m+pNuAfr4LpdI8T9hgBymdbVLKr/DZkONCnMjgzcHmXpPUJWB7+T68IHtBQC8024+qlUevPIojCNT9tLBrZWyOPXaX1eVtquBWmh57ARAXzTU2mlUvJG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eb3816-1660-4451-2ea4-08d767fc0072
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 05:40:33.1553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAxLg0S91YiKDijGeczIAxFP3jqKGFriYP7Ahhz9ia6GjksJpc3fCAWL/+XG4idrWxJJ+CV4pkqrbwsA31hdgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadim,
TRIO stands for TRansaction I/O and is an internal code name for our PCIe t=
o CHI bus interface.
In Mellanox BlueField SoC, the configuration is as follows: there are 3 TRI=
O blocks where TRIO2 is connected to a Mellanox ConnectX-5  while TRIO0 and=
 TRIO1 can be configured to behave either as a PCIe Root Complex to downstr=
eam ports (8 ports or 16 lanes each) connecting to storage devices, or as a=
n end-point when plugged into an external x86 host (SmartNIC form factor). =
Each TRIO block has a separate ACPI table entry which invokes this driver t=
hereby creating a total of 3 instances.
The purpose of this driver is to be able to read/set the L3 cache profile f=
rom a list of available profiles for transactions coming in to each TRIO bl=
ock and is meant to run on the ARM cores powering the BlueField SoC.

Regards,
Shravan

-----Original Message-----
From: Vadim Pasternak <vadimp@mellanox.com>=20
Sent: Tuesday, November 12, 2019 8:15 PM
To: Shravan Ramani <sramani@mellanox.com>; Andy Shevchenko <andy@infradead.=
org>; Darren Hart <dvhart@infradead.org>
Cc: Liming Sun <lsun@mellanox.com>; Shravan Ramani <sramani@mellanox.com>; =
platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: RE: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver



> -----Original Message-----
> From: Shravan Kumar Ramani <sramani@mellanox.com>
> Sent: Monday, November 11, 2019 4:35 PM
> To: Andy Shevchenko <andy@infradead.org>; Darren Hart=20
> <dvhart@infradead.org>; Vadim Pasternak <vadimp@mellanox.com>
> Cc: Liming Sun <lsun@mellanox.com>; Shravan Ramani=20
> <sramani@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-=20
> kernel@vger.kernel.org
> Subject: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
>=20
> This patch adds support for Mellanox BlueField TRIO PCIe host controller.
> The driver supports multiple TRIO instances and provides a sysfs=20
> interface to allow the user to read/set the L3 cache profile for=20
> transactions going through the TRIO. It also provides an interrupt handle=
r for the TRIO blocks.

Hi Shravan,

Could you, please, explain what TRIO PCIe host controller?
What is TRIO, is it some internal name or it's some standard terminology?
If it's internal, please, explain for what it stands for.

Same for TRIO instances. Are there some host side PCI instances?
What are the purpose of them?

Could you, please, also explain the system configuration?


>=20
> Shravan Kumar Ramani (1):
>   platform/mellanox: Add Mellanox TRIO driver
>=20
>  MAINTAINERS                            |   5 +
>  drivers/platform/mellanox/Kconfig      |   8 +
>  drivers/platform/mellanox/Makefile     |   1 +
>  drivers/platform/mellanox/mlxbf-trio.c | 624
> +++++++++++++++++++++++++++++++++
>  4 files changed, 638 insertions(+)
>  create mode 100644 drivers/platform/mellanox/mlxbf-trio.c
>=20
> --
> 2.1.2

