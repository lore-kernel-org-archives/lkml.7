Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9924C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A9120679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Kaa+jI1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKLOoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:44:37 -0500
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:23809
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbfKLOoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:44:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0PPZVOSMGyZwrz/7CVGjtFQeVPfyLcSqB/85XfVNz/QFz31yTwoGFcnfHDYhOdons26MEkUsenE5UxUxVB79da9gTwbZ2WGlPUKfUuEmws9olOqIXujo/6BYxUsU4KlBB2fgaQyV/IfCIZ00qwRpxkx+SBgcPBiYUT044Vzm6VPlMUl0XKK5UkgeWvf9kB9Sr3gwL1PFWKlZUP2mV+0zqwAHBpmI9XqKwoIZE7eE9+vr6+jXI5DeRnSsZ99RO67kms1GshZal8pzNjyIzuQqh/GqxGkmvrYN1DMZTBTCLCKZm4q+kn2pYaFcwYwtKEEiDSdxeUVRQA8Thev40y3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJBCRhGgD2SeQzGj6Xc8Qs8GSBb0ySVBmMtwAF7LFRA=;
 b=W137Kmd2Sww/c9s1AYk7Uh1h+GFLvHLXC+avibJXQMIEzyBzaK3TK9b4pvhuDZKMo5sesep9uuw91DeQq3oxvYhA2g/e5tDxQK6n/g/97A3y6HqxVPug5uba1vNtAKYNd2g8VkNYnjmQsEqHjifh6CDKshTh+kkraNXDymPClD3XxrGtcwCysfrHE1o0XrsdikX6zxbizFq/r0UWRuXvgTyerAZmjJKy+HSClgIpVqWJOunsFsNsRjmJje/o2UKcVc+Yq7tOl0BioATrkRIHHoq/MkzI1nUPBWoCLj/oSI+GUEfJdEp7vkcv/v8bmAfvGgm4bJFpZJ/F6u+jqbZhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJBCRhGgD2SeQzGj6Xc8Qs8GSBb0ySVBmMtwAF7LFRA=;
 b=Kaa+jI1rDLhwGTGuH9/5Zpw1DKiup/eguTpsluZ32WHL+qAdz6byMiXCT5LXqjICAkD0h/M1kUx3x1GIDgVwGP5JxgC9OSsuthoKv5QKx4Pymk5D4TAWK5F8+olUcuOGvDjBCNGwW7TH6FLRwVVCoj6sYBr1s0HujBeg/reM/0c=
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com (20.177.196.210) by
 AM6PR05MB4231.eurprd05.prod.outlook.com (52.135.161.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 14:44:32 +0000
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::59a9:b6c3:97d8:ff0f]) by AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::59a9:b6c3:97d8:ff0f%3]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 14:44:32 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Shravan Ramani <sramani@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     Liming Sun <lsun@mellanox.com>,
        Shravan Ramani <sramani@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
Thread-Topic: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
Thread-Index: AQHVmJ1B8i6N8wQYJ0iG7pe+aDUVfKeHm2Xw
Date:   Tue, 12 Nov 2019 14:44:32 +0000
Message-ID: <AM6PR05MB522463C06CB3E7528F18281FA2770@AM6PR05MB5224.eurprd05.prod.outlook.com>
References: <cover.1573460910.git.sramani@mellanox.com>
In-Reply-To: <cover.1573460910.git.sramani@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d3bf689-86b2-4daa-b4e9-08d7677ed4ba
x-ms-traffictypediagnostic: AM6PR05MB4231:|AM6PR05MB4231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB4231E6953C117CDD9E603317A2770@AM6PR05MB4231.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(13464003)(6116002)(476003)(6436002)(11346002)(66476007)(66556008)(66946007)(64756008)(66446008)(71190400001)(446003)(229853002)(71200400001)(55016002)(256004)(478600001)(3846002)(4326008)(52536014)(76116006)(9686003)(86362001)(8936002)(186003)(74316002)(81166006)(76176011)(7736002)(486006)(14454004)(81156014)(5660300002)(33656002)(2906002)(8676002)(54906003)(99286004)(102836004)(53546011)(6506007)(316002)(110136005)(6246003)(66066001)(26005)(305945005)(25786009)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4231;H:AM6PR05MB5224.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TOq/zN6wrK018YCYGq9OjuxUT06xk/f1ilYFzYrbjcbtDzIAQe+gs75TVzNWU0vuqaY7DenCSDFTVHDjs0Z2AFjOKQpWpW3EGBLIdiHJu3yZ01Na3Y93e4wAE0dqTUXlBO8S506Cob9um9sM8Bf34RljmfNczJTTbsgW+GIUkns48UFeG+tnpT6O00cBMLIW+6df8tdf1o2kh9XeljkdRFVaSS8CeqRlsJmz/40b/iISdHktKfS+yWjhcVyd5OC5nOM8GYMsxWCKf92iTFXnGIrs8adoKK9GPhcKym18fxRrlp6E3/3nw6dwbiA5kqGI1BClSEcbhLncIRaF2oteYsCfB1sgF1uesvaCZnvLnaYt8cneqPkoqlvkfcnpgb2yUksYe13yn8dK1JfKBPiHP8KjruyGpIQBjUm5Qh0ZJK9r6axRfwt3szQrcNgRNZgt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3bf689-86b2-4daa-b4e9-08d7677ed4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 14:44:32.7071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWyL6WuJOB0Alu72Hzxz3BTktiKdsgxjts3CsMqaM1N/a45J5RIUC4/J1QEUnor2sSt5Qa92qnskN68wzBztSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shravan Kumar Ramani <sramani@mellanox.com>
> Sent: Monday, November 11, 2019 4:35 PM
> To: Andy Shevchenko <andy@infradead.org>; Darren Hart
> <dvhart@infradead.org>; Vadim Pasternak <vadimp@mellanox.com>
> Cc: Liming Sun <lsun@mellanox.com>; Shravan Ramani
> <sramani@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v1] platform/mellanox: Add Mellanox TRIO driver
>=20
> This patch adds support for Mellanox BlueField TRIO PCIe host controller.
> The driver supports multiple TRIO instances and provides a sysfs interfac=
e to
> allow the user to read/set the L3 cache profile for transactions going th=
rough
> the TRIO. It also provides an interrupt handler for the TRIO blocks.

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

