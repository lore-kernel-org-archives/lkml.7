Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65605CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD8D2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="AN3oWa+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405092AbfJYGfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:35:23 -0400
Received: from mail-eopbgr750075.outbound.protection.outlook.com ([40.107.75.75]:18997
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388289AbfJYGfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:35:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwULGt8yzox8x6smak/BTkuC0nnMQokKqvzdNc7QKXxGsJv6VeWP4ydOzICGW0sAEc8Hht4llfcan9n0zs665JAqk9c826TTqXVEJWY+DS5r33OE03Ee039NI6yrqqQHoiS20jGjZYLueLG+Hev3J0ZEZmnEbvQiWiV73Pm9fYbApAHzmYzgljjRC3FNQAoI/oL13BI6un1y9gmC0JeiQszjK+F6WE7nTl0QA1HWyK0kfS4nmukOZaClirN6yG0oGdwayAWE4utvUDRmKz3i46d3tNLy0cGbtOtZoeN0cTx4f/cmviVNrhrIrQ90l9EDGuK6N663mBMAwDlDPTMxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHIrccKEXZx35zwSdcmAV39WgHHzjbRrlQskAEkWEPY=;
 b=gA5zKjQ2AzxjcSlrLMKf5Zu+EfAjK1a85G34qP4DT3e4kqVnb17VFcYve4ZETtI2hB66A+U8tMMve9C+3qNClijecPtIkQ7qPJ1tTPc71KbITEP5A54yvIDAvJcwkRY1i8zw3zX+asmSoVo6yGRAGKGpelcKox70+N9Pnq2bXEyqYasxJn4kBUz5WjauduAcNj4F/RRtk6wIWiJFtI9lxAHYF7ZMaDcFIRJ1w3OUzxyrcPndYXaLXR0r7S2mAlahG7Kn4vphkPwfWHfRnT+6pJNmhmAHuMI8P3ljVTMHZ8SG8Q3INwXsod/p2LezDD05o5DiU98CCwfGa8LH81QDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHIrccKEXZx35zwSdcmAV39WgHHzjbRrlQskAEkWEPY=;
 b=AN3oWa+iHaV1DZrDP2O18IyzBq9IhWirmVMQifEK9q6ToaKgrX28wL03mJ+GxZ/raA54DeZ/vjK9s0ttTlreQDqJpibJ6xCYa2dfaP7ot7m1/1ix8OqD6BrCfAOsSfnzF9kXeliawvJAe2tULINuHTCxN5Fs2Q/GRr2zt9bAhAc=
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3798.namprd13.prod.outlook.com (20.180.12.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.17; Fri, 25 Oct 2019 06:35:16 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::c069:f0c7:760b:faba]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::c069:f0c7:760b:faba%3]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 06:35:16 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     "Paul Walmsley ( Sifive)" <paul.walmsley@g.sifive.com>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     "Paul Walmsley ( Sifive)" <paul.walmsley@g.sifive.com>,
        "Palmer Dabbelt ( Sifive)" <palmer@g.sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sorear2@gmail.com" <sorear2@gmail.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Greentime Hu <greentime.hu@g.sifive.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "will@kernel.org" <will@kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: RE: [PATCH] RISC-V: Add PCIe I/O BAR memory mapping
Thread-Topic: [PATCH] RISC-V: Add PCIe I/O BAR memory mapping
Thread-Index: AQHViktonODm2JDbF0ujvmchxtIALKdp+k0AgAAHp4CAAOTMQA==
Date:   Fri, 25 Oct 2019 06:35:16 +0000
Message-ID: <CH2PR13MB336820C83536BF58C6EDDA688C650@CH2PR13MB3368.namprd13.prod.outlook.com>
References: <1571908438-4802-1-git-send-email-yash.shah@sifive.com>
 <c4817ec1-4e50-5646-68f0-caeb0ab6f0bf@deltatee.com>
 <alpine.DEB.2.21.9999.1910240937350.20010@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910240937350.20010@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-originating-ip: [114.143.65.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14e6593d-8c96-4156-f35c-08d759157fa9
x-ms-traffictypediagnostic: CH2PR13MB3798:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR13MB3798824F196E356F7BDC67218C650@CH2PR13MB3798.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39850400004)(346002)(136003)(396003)(199004)(189003)(8676002)(305945005)(8936002)(81166006)(446003)(11346002)(14444005)(7696005)(476003)(6246003)(66556008)(81156014)(66946007)(7416002)(64756008)(66446008)(76116006)(66476007)(6506007)(53546011)(26005)(76176011)(186003)(66066001)(86362001)(99286004)(71200400001)(486006)(25786009)(102836004)(71190400001)(44832011)(478600001)(4326008)(3846002)(6116002)(14454004)(229853002)(52536014)(7736002)(9686003)(33656002)(2906002)(256004)(110136005)(54906003)(55016002)(4001150100001)(74316002)(316002)(5660300002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3798;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjmcaU0Lot10SoUatcJ2lfNZLIO5AQsdgpBkXrDjCumogdfR8MxIqlXAJP8awfYPMCv8twSHL/2PvYH7u0SE59boWh/K+U/zuLKDK9flmMV1WNMvv9594/4Glg5LALG5T9k4OQAqR6rAGNzMuD8wOsv5GF/l4uJXwiJxn94plqqP7zzzkCYGKEBzukw3m8GtV6DtbwsNmpSeiZ+BKj9xrCUD0rYLX3fVxyM5B6KIj3Y1Y+eLwXEGi8M3C8Ki/V1D+0R1MXE+TJH+XZHHlq8DS/HGv9ktKgRfNGpksaCG5p8Jflhmq+GcTK7Q/ak9+FUcknXZpmKyO6TJ90pnSrkpg9e2iEGEi+Eq85jeYt2MqrBGjv72zj1qbWX2ueBUN7sFbYg/AZrIUNUVl7pXHx3jW0gb7geU6SaMeGs7NuwNVN+SYp932M9IPnaigC34CS3M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e6593d-8c96-4156-f35c-08d759157fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 06:35:16.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tp7XZ96WdrU1ampxmcqzLYin5BxPUY8abvs0oN8kxQ7VyPYlZzwTNnYZbTZPOE4ICD3dCQEJghAL9S4AYAgSnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 24 Oct 2019, Logan Gunthorpe wrote:
>=20
> > On 2019-10-24 3:14 a.m., Yash Shah wrote:
> > > For I/O BARs to work correctly on RISC-V Linux, we need to establish
> > > a reserved memory region for them, so that drivers that wish to use
> > > I/O BARs can issue reads and writes against a memory region that is
> > > mapped to the host PCIe controller's I/O BAR MMIO mapping.
> >
> > I don't think other arches do this.
>=20
> $ git grep 'define PCI_IOBASE' arch/
> arch/arm/include/asm/io.h:#define PCI_IOBASE            ((void __iomem
> *)PCI_IO_VIRT_BASE)
> arch/arm64/include/asm/io.h:#define PCI_IOBASE          ((void __iomem
> *)PCI_IO_START)
> arch/m68k/include/asm/io_no.h:#define PCI_IOBASE        ((void __iomem *)
> PCI_IO_PA)
> arch/microblaze/include/asm/io.h:#define PCI_IOBASE     ((void __iomem
> *)_IO_BASE)
> arch/unicore32/include/asm/io.h:#define PCI_IOBASE
> PKUNITY_PCILIO_BASE
> arch/xtensa/include/asm/io.h:#define PCI_IOBASE         ((void __iomem
> *)XCHAL_KIO_BYPASS_VADDR)
> $
>=20
> This is for the old x86-style, non-memory mapped I/O address space the
> legacy PCI stuff that one would use in{b,w,l}()/out{b,w,l}() for.
>=20
> Yash, you might consider updating your patch description to note that thi=
s is
> for "legacy I/O BARs (i.e., non-MMIO BARs)" or something similar.  That
> might make things clearer.

Sure, will update the description and send v2.

- Yash

>=20
> > ioremap() typically just uses virtual address space in the VMALLOC
> > region, PCI doesn't need it's own range. As far as I know the
> > ioremap() implementation in riscv already does this.
> >
> > In any case, 16MB for PCI bar space seems woefully inadequate.
>=20
> The modern MMIO PCI resources wind up in jost controller apertures, which
> as you note, are usually much larger.  They don't go in this legacy space=
.
>=20
> Regarding sizing - I haven't seen any PCIe cards with more than 64KiB of
> legacy I/O resources.  (16MiB / 64KiB) =3D 256, so 16MiB sounds reasonabl=
e
> from that point of view?  ARM64 is using that.
>=20
>=20
> - Paul
