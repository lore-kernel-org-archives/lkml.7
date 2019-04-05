Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C67C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5579621855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="emPT1DI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDEWP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:15:27 -0400
Received: from mail-eopbgr720081.outbound.protection.outlook.com ([40.107.72.81]:9809
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbfDEWP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQzrRNR9WFIPyqKEYWbKyY7kEJawWQdBKWlqpSWamH8=;
 b=emPT1DI98ZfIKGzGZIjOPYS6HJiXU2R0pNEjlu990WQsQ9LrXXdNx1HZs4IPKzZEM3fohOqJUh787D5pSHuSHW5j0YtJLHxVjZfoPSLnYIk9zaZ4hSvdBgWLlPwgZU6idobIvYEpGIVfD51szRw0DaiO/EGxEH6FEYoCYNMwlKE=
Received: from BYAPR02MB5160.namprd02.prod.outlook.com (20.176.254.33) by
 BYAPR02MB5797.namprd02.prod.outlook.com (20.179.62.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Fri, 5 Apr 2019 22:15:21 +0000
Received: from BYAPR02MB5160.namprd02.prod.outlook.com
 ([fe80::21a0:9cd3:90cb:7d7b]) by BYAPR02MB5160.namprd02.prod.outlook.com
 ([fe80::21a0:9cd3:90cb:7d7b%5]) with mapi id 15.20.1771.016; Fri, 5 Apr 2019
 22:15:21 +0000
From:   Sonal Santan <sonals@xilinx.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ronan KERYELL <ronan@keryell.fr>
CC:     Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Cyril Chemparathy <cyrilc@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lizhi Hou <lizhih@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Ralph Wittig <wittig@xilinx.com>,
        Ronan Keryell <rkeryell@xilinx.com>
Subject: RE: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
Thread-Topic: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
Thread-Index: AQHU3p5QKbxkgyec50+i8ouG/VB2wqYc1UkAgAHB29CAAJggAIAAPv4AgAAifICAAJorkIAB71aAgAFS/HWABz6mAIADj/FQ
Date:   Fri, 5 Apr 2019 22:15:21 +0000
Message-ID: <BYAPR02MB5160C131CE3ED1E77E56947BBB510@BYAPR02MB5160.namprd02.prod.outlook.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
 <20190325202810.GG2665@phenom.ffwll.local>
 <BYAPR02MB51608FDF39B39898FAAEBFEEBB5F0@BYAPR02MB5160.namprd02.prod.outlook.com>
 <CAKMK7uHh5KNaTO+a4ZA+vPQcPKUBwODsx+pPCWNp3sxe9TFP0Q@mail.gmail.com>
 <BYAPR02MB51603A1AD72F704112B55B90BB580@BYAPR02MB5160.namprd02.prod.outlook.com>
 <20190327141137.GK2665@phenom.ffwll.local>
 <BYAPR02MB5160162639C2EAC6B19901B7BB590@BYAPR02MB5160.namprd02.prod.outlook.com>
 <CAPM=9tyLNOXCaKGQkCCmo4tt=Dny0j984-=q8utjwv-aX-Y6BQ@mail.gmail.com>
 <871s2pw4ld.fsf@fisel.enstb.org> <20190403154734.GA12818@redhat.com>
In-Reply-To: <20190403154734.GA12818@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sonals@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e8387bb-5345-4d24-af1a-08d6ba1431e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB5797;
x-ms-traffictypediagnostic: BYAPR02MB5797:
x-microsoft-antispam-prvs: <BYAPR02MB57979C392806B41D6DFF4C47BB510@BYAPR02MB5797.namprd02.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(13464003)(51744003)(189003)(199004)(5660300002)(8936002)(86362001)(107886003)(81156014)(53936002)(81166006)(71200400001)(71190400001)(3846002)(6116002)(478600001)(14454004)(6436002)(55016002)(68736007)(6506007)(7696005)(305945005)(7736002)(26005)(66574012)(99286004)(74316002)(102836004)(9686003)(14444005)(256004)(76176011)(2906002)(8676002)(186003)(6246003)(229853002)(53546011)(105586002)(4326008)(97736004)(106356001)(446003)(11346002)(476003)(486006)(33656002)(93886005)(54906003)(110136005)(52536014)(316002)(66066001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5797;H:BYAPR02MB5160.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bo3qWuhze6HU3M0qYoYNUu+1NZwqLa0xw9ul4YAMHzrooltsJBYNZ8tJ7o6qHGzkKsPeMJeOgOXYANSnwv0K1MXh3Q7stlYdEo1fMKHp5zlENK59Qeq9kz5Uk4a9b9aL6F6dUIs+1pfB89p7PtoVK/v2SZC3d+i5BB95nq/z21cv0wYz4/A6K9wranPSPG6n5HnQobHfvHXlM/Usmhk4HfVv5jDz+XtTCX1bYwAecyXFB0YxoYOJVB2fqxSDGCcv7l8o8CxvhwYbScpja8oPiccVqpeGvgyJlzroImMdX9ug6haqMjF+PKFiSGY2EOKsqriiMZmeWKwvBkruWc35kgTYyQKlpoo0o7SfFZgAb0893IPqkN//QzKXKTWXzp3zYOa5tT0zbz8oIEHNzaUGsNgmCQTxAVmnVRLswPnJp2A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8387bb-5345-4d24-af1a-08d6ba1431e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 22:15:21.6891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jerome Glisse [mailto:jglisse@redhat.com]
> Sent: Wednesday, April 03, 2019 8:48 AM
> To: Ronan KERYELL <ronan@keryell.fr>
> Cc: Dave Airlie <airlied@gmail.com>; Sonal Santan <sonals@xilinx.com>;
> Daniel Vetter <daniel@ffwll.ch>; dri-devel@lists.freedesktop.org;
> gregkh@linuxfoundation.org; Cyril Chemparathy <cyrilc@xilinx.com>; linux-
> kernel@vger.kernel.org; Lizhi Hou <lizhih@xilinx.com>; Michal Simek
> <michals@xilinx.com>; airlied@redhat.com; linux-fpga@vger.kernel.org; Ral=
ph
> Wittig <wittig@xilinx.com>; Ronan Keryell <rkeryell@xilinx.com>
> Subject: Re: [RFC PATCH Xilinx Alveo 0/6] Xilinx PCIe accelerator driver
>=20
> On Fri, Mar 29, 2019 at 06:09:18PM -0700, Ronan KERYELL wrote:
> > I am adding linux-fpga@vger.kernel.org, since this is why I missed
> > this thread in the first place...
> > >>>>> On Fri, 29 Mar 2019 14:56:17 +1000, Dave Airlie <airlied@gmail.co=
m>
> said:
> >     Dave> On Thu, 28 Mar 2019 at 10:14, Sonal Santan <sonals@xilinx.com=
>
> wrote:
> >     >>> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]
>=20
> [...]
>=20
> > Long answer:
> >
> > - processors, GPU and other digital circuits are designed from a lot of
> >   elementary transistors, wires, capacitors, resistors... using some
> >   very complex (and expensive) tools from some EDA companies but at the
> >   end, after months of work, they come often with a "simple" public
> >   interface, the... instruction set! So it is rather "easy" at the end
> >   to generate some instructions with a compiler such as LLVM from a
> >   description of this ISA or some reverse engineering. Note that even i=
f
> >   the ISA is public, it is very difficult to make another efficient
> >   processor from scratch just from this ISA, so there is often no
> >   concern about making this ISA public to develop the ecosystem ;
> >
> > - FPGA are field-programmable gate arrays, made also from a lot of
> >   elementary transistors, wires, capacitors, resistors... but organized
> >   in billions of very low-level elementary gates, memory elements, DSP
> >   blocks, I/O blocks, clock generators, specific
> >   accelerators... directly exposed to the user and that can be
> >   programmed according to a configuration memory (the bitstream) that
> >   details how to connect each part, routing element, configuring each
> >   elemental piece of hardware.  So instead of just writing instructions
> >   like on a CPU or a GPU, you need to configure each bit of the
> >   architecture in such a way it does something interesting for
> >   you. Concretely, you write some programs in RTL languages (Verilog,
> >   VHDL) or higher-level (C/C++, OpenCL, SYCL...)  and you use some very
> >   complex (and expensive) tools from some EDA companies to generate the
> >   bitstream implementing an equivalent circuit with the same
> >   semantics. Since the architecture is so low level, there is a direct
> >   mapping between the configuration memory (bitstream) and the hardware
> >   architecture itself, so if it is public then it is easy to duplicate
> >   the FPGA itself and to start a new FPGA company. That is unfortunatel=
y
> >   something the existing FPGA companies do not want... ;-)
>=20
> This is completely bogus argument, all FPGA documentation i have seen so =
far
> _extensively_ describe _each_ basic blocks within the FGPA, this does inc=
lude
> the excelent documentation Xilinx provide on the inner working and layout=
 of
> Xilinx FPGA. Same apply to Altera, Atmel, Latice, ...
>=20
> The extensive public documentation is enough for anyone with the money
> and with half decent engineers to produce an FPGA.
>=20
> The real know how of FPGA vendor is how to produce big chips on small
> process capable to sustain high clock with the best power consumption
> possible. This is the part where the years of experiences of each company=
 pay
> off. The cost for anyone to come to the market is in the hundred of milli=
ons
> just in setup cost and to catch with established vendor on the hardware s=
ide.
> This without any garanty of revenue at the end.
>=20
> The bitstream is only giving away which bits correspond to which wire whe=
re
> the LUT boolean table is store  ... Bitstream that have been reverse engi=
neer
> never revealed anything of value that was not already publicly documented=
.
>=20
>=20
> So no the bitstream has _no_ value, please prove me wrong with Latice
> bitstream for instance. If anything the fact that Latice has a reverse en=
gineer
> bitstream has made that FPGA popular with the maker community as it allow=
s
> people to do experiment for which the closed source tools are an
> impediment. So i would argue that open bitstream is actualy beneficial.
>=20
>=20
> The only valid reason i have ever seen for hidding the bitstream is to pr=
otect
> the IP of the customer ie those customer that can pour quite a lot of mon=
ey
> on designing something with an FPGA and then wants to keep the
> VHDL/Verilog protected and "safe" from reverse engineering.
>=20
> But this is security by obscurity and FPGA company would be better off
> providing strong bitstream encryption (and most already do but i have see=
n
> some paper on how to break them).
>=20
>=20
> I rather not see any bogus argument to try to justify something that is n=
ot
> justifiable.
>=20
>=20
> Daniel already stressed that we need to know what the bitstream can do an=
d
> it is even more important with FPGA where on some FPGA AFAICT the
> bitstream can have total control over the PCIE BUS and thus can be use to
> attack either main memory or other PCIE devices.
>=20
> For instance with ATS/PASID you can have the device send pre-translated
> request to the IOMMU and access any memory despite the IOMMU.
>=20
> So without total confidence of what the bitstream can and can not do, and
> thus without knowledge of the bitstream format and how it maps to LUT,
> switch, cross- bar, clock, fix block (PCIE, DSP, DAC, ADC, ...) there is =
no way for
> someone independant to check anything.
>=20
>=20

Thank you for your time and valuable feedback. I will work on addressing th=
ese=20
and get back.=20

-Sonal
> Cheers,
> J=E9r=F4me Glisse
