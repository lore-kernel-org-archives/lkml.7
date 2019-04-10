Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22B5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1A92075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ElOu+iaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfDJSLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:11:09 -0400
Received: from mail-eopbgr750129.outbound.protection.outlook.com ([40.107.75.129]:15726
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727431AbfDJSLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:11:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=o1MKxrUL9hAS7Ws//LMS/WJREoACt53CgJZhjLG5u7xhdYWuFVEBPqeOcmU09Bc/U2iZNbBxTykkFkIlx2VCGZQOgyyrDi2I5FJRzRBjiagaVxWHBOSxLaCkALmlZN6clBN0mnmplpF18e9ZSYaF6I20SUhTk14fHdE6A3qE93o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYPBuvgpuE2Zds3hBSSmSVuO4K3jFllqn06kjDD1Gzw=;
 b=OAX3VF3Ff2zCow/CrcYjsovEhAftuL1AyOpb6W5rUvRvHEmjWoFrVJ4C1Cs+rttwzzY3Eo2qVfvpZBIgk1LjlPjU5cdt31rhwd5KWfHXE4wYMEkQy+ZP8SmpQ8fs/XRPEQmv55CXjDO2952+SCuiEp0m48uKp3OOXxoDNVFRWmA=
ARC-Authentication-Results: i=1; test.office365.com 1;dmarc=none action=none
 header.from=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYPBuvgpuE2Zds3hBSSmSVuO4K3jFllqn06kjDD1Gzw=;
 b=ElOu+iaItWaPoX9kN6rFbIn1rsyEqm42Jd3HyvBXdBhMPbLiDq+h5gLKYmLJqsG9kTfRmeP2LmflkvJGsmYAAMmw7iXJCl3+kmTlbzUutV+C/QZqlQlTVmemnooPsX7DRTJMe1FpiGgiRjZ0be86dplUB++y+JhdUoLL1aDuQ4w=
Received: from CY4PR21MB0279.namprd21.prod.outlook.com (10.173.193.145) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.4; Wed, 10 Apr 2019 18:11:02 +0000
Received: from CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::f5b8:74a7:6037:4977]) by CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::f5b8:74a7:6037:4977%9]) with mapi id 15.20.1813.000; Wed, 10 Apr 2019
 18:11:02 +0000
From:   Thirupathaiah Annapureddy <thiruan@microsoft.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Sasha Levin <sashal@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>
Subject: RE: [PATCH v2 1/3] ftpm: dt-binding: add dts documentation for fTPM
 driver
Thread-Topic: [PATCH v2 1/3] ftpm: dt-binding: add dts documentation for fTPM
 driver
Thread-Index: AQHU7wUUBWAv80WpfkyhtUpqzqEGmaY0VYOAgAE+44CAAAutgIAAAHYAgAAOLICAAADhAIAAAZjA
Date:   Wed, 10 Apr 2019 18:11:02 +0000
Message-ID: <CY4PR21MB0279CB155BDC824A2E8A055BBC2E0@CY4PR21MB0279.namprd21.prod.outlook.com>
References: <20190409184958.7476-1-sashal@kernel.org>
 <20190409184958.7476-2-sashal@kernel.org>
 <CAL_JsqLXcY9VFuY8xZvek0ybUXetS27jL-PW0XGLSVQR3Nc5aw@mail.gmail.com>
 <20190410161949.GC11568@sasha-vm>
 <CAL_JsqJ0p8MsFe2HnqVHvdGyz=6P7dV++xj1d1TTgcobsFqpjg@mail.gmail.com>
 <20190410170316.GK8997@ziepe.ca> <20190410175359.GE11568@sasha-vm>
 <20190410175708.GM8997@ziepe.ca>
In-Reply-To: <20190410175708.GM8997@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thiruan@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:1d2a:5ca0:ad29:1539]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bec83de8-cfaa-4aaf-d4d5-08d6bddfe429
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
x-microsoft-antispam-prvs: <CY4PR21MB06313FAFC40536AD49229AE9BC2E0@CY4PR21MB0631.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(13464003)(71190400001)(7416002)(71200400001)(6436002)(68736007)(14454004)(8990500004)(4326008)(74316002)(478600001)(54906003)(86362001)(7696005)(110136005)(14444005)(256004)(305945005)(7736002)(99286004)(10290500003)(76176011)(486006)(46003)(10090500001)(86612001)(11346002)(476003)(52536014)(105586002)(316002)(22452003)(6506007)(53546011)(229853002)(25786009)(446003)(186003)(102836004)(93886005)(6116002)(33656002)(81156014)(81166006)(53936002)(97736004)(55016002)(6246003)(2906002)(8676002)(8936002)(106356001)(107886003)(9686003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0279.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UxNnj+S7hBonGzb6j7jPxqzohyrrCiq7MBxPFtOqgwTuc0aPoR8DLHk+aLyHWY/wk59+TfozVZ31LK+bS3ic+p8y9uKrMZYQ5kHSQAF7tyU3lj+S1ZygqNLuRTUdTtG6EdicCaS5qQBlvO9vWXDEIiCC88vgEto7XeITv3MjGmnZUkfqLzhfYnXuwUGc5F1rMpcqdNJhw24Q3C7RPE48akLmL4tUJqAYkZoHa7o5ckbwz1MqC2IynZe6JhFETHJQdAufOWeDHdEKYR6Eqo9HxccdpDDH0SVv0FwbVyRr6tDkgujuoLCDwHiQY/6qZbQn/MuT/46rrT4xsp2wG5D5o4jRqNssbDIzTqtoCUm8CCbjU7WW1ZsVBJwRxRJEER8i6lRzN/1e9K1Dq3/xKTIbw8oT33awf6acz1jDPuFARA4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec83de8-cfaa-4aaf-d4d5-08d6bddfe429
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 18:11:02.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, April 10, 2019 10:57 AM
> To: Sasha Levin <sashal@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>; Peter Huewe <peterhuewe@gmx.de>;
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Mark Rutland
> <mark.rutland@arm.com>; Jonathan Corbet <corbet@lwn.net>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> kernel@vger.kernel.org; Linux Doc Mailing List <linux-doc@vger.kernel.org=
>;
> linux-integrity@vger.kernel.org; Microsoft Linux Kernel List <linux-
> kernel@microsoft.com>; Thirupathaiah Annapureddy <thiruan@microsoft.com>;
> Bryan Kelly (CSI) <bryankel@microsoft.com>
> Subject: Re: [PATCH v2 1/3] ftpm: dt-binding: add dts documentation for
> fTPM driver
>=20
> On Wed, Apr 10, 2019 at 01:53:59PM -0400, Sasha Levin wrote:
> > On Wed, Apr 10, 2019 at 02:03:16PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 10, 2019 at 12:01:37PM -0500, Rob Herring wrote:
> > > > On Wed, Apr 10, 2019 at 11:19 AM Sasha Levin <sashal@kernel.org>
> wrote:
> > > > >
> > > > > On Tue, Apr 09, 2019 at 04:18:29PM -0500, Rob Herring wrote:
> > > > > >On Tue, Apr 9, 2019 at 1:50 PM Sasha Levin <sashal@kernel.org>
> wrote:
> > > > > >>
> > > > > >> The parameters are similar to the ones used by IBM's vTPM and
> the
> > > > > >> various I2C tpm drivers.
> > > > > >
> > > > > >Bindings describe h/w (or firmware interfaces in this case), not
> drivers.
> > > > > >
> > > > > >>
> > > > > >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > > >>  .../bindings/security/tpm/tpm_ftpm_tee.txt          | 13
> +++++++++++++
> > > > > >>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
> > > > > >>  2 files changed, 14 insertions(+)
> > > > > >>  create mode 100644
> Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > > > > >>
> > > > > >> diff --git
> a/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > > > > >> new file mode 100644
> > > > > >> index 000000000000..20fca67a56c4
> > > > > >> +++
> b/Documentation/devicetree/bindings/security/tpm/tpm_ftpm_tee.txt
> > > > > >> @@ -0,0 +1,13 @@
> > > > > >> +Required properties:
> > > > > >> +- compatible: should be "microsoft,ftpm"
> > > > > >> +- linux,sml-base: 64-bit base address of the reserved memory
> allocated
> > > > > >> +                 for the firmware event log
> > > > > >> +- linux,sml-size: size of the memory allocated for the firmwa=
re
> event log
> > > > > >
> > > > > >Firmware is defining linux specific properties? What if I want t=
o
> run
> > > > > >BSD? We should use 'reg' here instead.
> > > > >
> > > > > This is based on already existing code that defines these names,
> see
> > > > > tpm_read_log_of() in drivers/char/tpm/eventlog/of.c .
> > > >
> > > > BTW, that probably needs updating to handle endianness correctly.
> > >
> > > IIRC this legacy IBM code has broken endianness in the firmware..
> > >
> > > All that stuff in read_log_of, and the related DT stuff, is historica=
l
> > > IBM special case-ness and should not be copied into new things.
> >
> > The fTPM driver does not use it on it's own, so I guess I can just drop
> > this patch then?
>=20
> If your ARM system boots via EFI then it should pass the firmware
> event log through EFI mechanisms, IIRC.
>=20
> Otherwise maybe you could make a case for using this, but only if the
> old IBM stuff is perfectly emulated, bugs and all.
>=20
> Do you even have an event log?
>=20

Our ARM system is booting using U-boot and Device Tree.=20
So the ACPI/EFI table mechanism to pass binary boot measurements won't be a=
pplicable.=20

We have event logs working and we are able to successfully read them using=
=20
/sys/kernel/security/tpm0/binary_bios_measurements and parse them

--Thiru

> Jason
