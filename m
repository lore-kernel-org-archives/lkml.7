Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A884DC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E34214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XhtqQP9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGIHzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:55:40 -0400
Received: from mail-eopbgr50079.outbound.protection.outlook.com ([40.107.5.79]:42887
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbfGIHzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7JOqoZNLF1ch2AXaETC6HGqHaRuhuy6+juS3/DgGdc=;
 b=XhtqQP9aiQyyWmUlJ2fsn6lQ9DnHBOi9cR0RE8+Ur4APKHlRTp4wQrmsXq+pqUslTWWmWwKmKpvzRSnjUMha01K+66Wixt0NejRapsc9M8iTwJvdRQ0XHPXhJ/iscCK8OUA846b6M/Jt+js67ZvZalaNhjZySGaGmk+k6Ge6y74=
Received: from VE1PR04MB6655.eurprd04.prod.outlook.com (20.179.235.94) by
 VE1PR04MB6735.eurprd04.prod.outlook.com (20.179.235.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 07:55:31 +0000
Received: from VE1PR04MB6655.eurprd04.prod.outlook.com
 ([fe80::846e:134d:2731:fcd]) by VE1PR04MB6655.eurprd04.prod.outlook.com
 ([fe80::846e:134d:2731:fcd%7]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 07:55:31 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Topic: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Index: AQHTXdpMV/QBUrO8J0eNmcCmR0ATg6MVIlkAgAAD6zCAABVWgINueaJwgAAMz4CAAwpoAIAF38DwgBavPgCACkIu0IAASk0AgBejzDA=
Date:   Tue, 9 Jul 2019 07:55:30 +0000
Message-ID: <VE1PR04MB6655D052B076C52F7F24A387F1F10@VE1PR04MB6655.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com>
 <87ineb9b5v.fsf@linux.intel.com>
 <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com>
 <87shdfet90.fsf@linux.intel.com>
 <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <87k1eaanjw.fsf@linux.intel.com>
 <AM5PR0402MB2865F3735D808E1BC9F67968F1180@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <AM5PR0402MB2865D0F0E2B4F65C86D051F8F1140@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <87o92wgyqj.fsf@linux.intel.com>
 <VE1PR04MB66557834D3588FC8B558950AF1E00@VE1PR04MB6655.eurprd04.prod.outlook.com>
 <87v9wvsex3.fsf@linux.intel.com>
In-Reply-To: <87v9wvsex3.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9c4a4c7-3feb-476e-7082-08d70442d097
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6735;
x-ms-traffictypediagnostic: VE1PR04MB6735:
x-microsoft-antispam-prvs: <VE1PR04MB6735CFA97D7A01FA7A5ADF27F1F10@VE1PR04MB6735.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(504964003)(3846002)(7696005)(186003)(6116002)(74316002)(6246003)(102836004)(6506007)(26005)(53546011)(76176011)(52536014)(86362001)(229853002)(33656002)(486006)(8676002)(81166006)(81156014)(5660300002)(2906002)(446003)(8936002)(316002)(9686003)(25786009)(14454004)(76116006)(73956011)(55016002)(478600001)(4326008)(476003)(71190400001)(54906003)(99286004)(71200400001)(110136005)(305945005)(68736007)(66446008)(64756008)(66556008)(66946007)(66476007)(7736002)(53936002)(256004)(14444005)(66066001)(6436002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6735;H:VE1PR04MB6655.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /LBlbvyE4InEq3vOIdp05vwA/+sTkagOMRYEP8wQNKiN0N8MN6MBVh0DM2P2AJ+Me5NKpXA7HLzfc3/a0HCjuErNQiYpz/mf4TW3UCLOsrRzd41lctK+GvJu+KattMuWG+mPbXs8jrCUseoi/g/S3f66jc1VBLoDVmjnN2NsESakVXl8w+ZgQOqt8XlMdXILEFVGwvYNRKU0neyjOLCztSr8bBxgw1Oa2kpSDzFZMf3WK9O9FsW5KayQJeSTTKYTT62TPPXzVFvO0OEYRZMrViVbJ9CWD+ANSmTeE4cIRnH22H68/3Ae9ueaFxRNO+12o9LJztw/SrrglINeKz7cEgmel7U4VrUsDVoJOdoV5PNvCfo5OiayI878z0COKmw+ySduzWQngKuZnghEr9celEtSepvQpORfMdZg8CBb5SE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c4a4c7-3feb-476e-7082-08d70442d097
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 07:55:30.8443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Monday, June 24, 2019 13:58, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Ran Wang <ran.wang_1@nxp.com> writes:
> >> >> > >> >> >  /* Global Debug Queue/FIFO Space Available Register */
> >> >> > >> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
> >> >> > >> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
> >> >> > >> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
> >> >> > >> >> >   * 	3	- Reserved
> >> >> > >> >> >   * @imod_interval: set the interrupt moderation interval=
 in
> 250ns
> >> >> > >> >> >   *                 increments or 0 to disable.
> >> >> > >> >> > + * @dma_coherent: set if enable dma-coherent.
> >> >> > >> >>
> >> >> > >> >> you're not enabling dma coherency, you're enabling cache
> snooping.
> >> >> > >> >> And this property should describe that. Also, keep in mind
> >> >> > >> >> that different devices may want different cache types for
> >> >> > >> >> each of those fields, so your property would have to be a
> >> >> > >> >> lot more complex. Something
> >> >> > like:
> >> >> > >> >>
> >> >> > >> >> 	snps,cache-type =3D <foobar "cacheable">, <baz "cacheable"=
>, ...
> >> >> > >> >>
> >> >> > >> >> Then driver would have to parse this properly to setup GSBU=
SCFG0.
> >> >> > >
> >> >> > > According to the DesignWare Cores SuperSpeed USB 3.0
> >> >> > > Controller Databook (v2.60a), it has described Type Bit
> >> >> > > Assignments for all supported
> >> >> > master bus type:
> >> >> > > AHB, AXI3, AXI4 and Native. I found the bit definition are
> >> >> > > different among
> >> >> > them.
> >> >> > > So, for the example you gave above, feel a little bit confused.
> >> >> > > Did you mean:
> >> >> > >     snps,cache-type =3D <DATA_RD  "write allocate">, <DESC_RD
> >> >> > > "cacheable">, <DATA_WR  "bufferable">, <DESC_WR  "read
> >> >> > > allocate">
> >> >> >
> >> >> > yeah, something like that.
> >> >>
> >> >> I think DATA_RD  should be a macro, right? So, where I can put its =
define?
> >> >> Create a dwc3.h in include/dt-bindings/usb/ ?
> >> >
> >> > Could you please give me some advice here? I'd like to prepare next
> >> > version patch after getting this settled.
> >> >
> >> >> Another question about this remain open is: DWC3 data book's Table
> >> >> 6-5 Cache Type Bit Assignments show that bits definition will
> >> >> differ per MBUS_TYPEs as
> >> >> below:
> >> >> ----------------------------------------------------------------
> >> >>  MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> >> >>  ----------------------------------------------------------------
> >> >>  AHB      |Cacheable     |Bufferable   |Privilegge |Data
> >> >>  AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> >> >>  AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> >> >>  AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> >> >>  Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> >> >>  ----------------------------------------------------------------
> >> >>  Note: The AHB, AXI3, AXI4, and PCIe busses use different names
> >> >> for certain  signals, which have the same meaning:
> >> >>    Bufferable =3D Posted
> >> >>    Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
> >> >>
> >> >> For Layerscape SoCs, MBUS_TYPE is AXI3. So I am not sure how to
> >> >> use snps,cache-type =3D <DATA_RD  "write allocate">, to cover all
> MBUS_TYPE?
> >> >> (you can notice that AHB and AXI3's cacheable are on different
> >> >> bit) Or I just need to handle AXI3 case?
> >> >
> >> > Also on this open. Thank you in advance.
> >>
> >> You could pass two strings and let the driver process them. Something
> >> like:
> >>
> >> 	snps,cache_type =3D <"data_wr" "write allocate">, <"desc_rd"
> >> "cacheable">...
> >>
> >> And so on. The only thing missing is for the mbus_type to be known by =
the
> driver.
> >> Is that something we can figure out on any of the HWPARAMS registers
> >> or does it have to be told explicitly?
> >
> > I have checked Layerscape Reference manual, HWPARAMS0~8 doesn't
> > contain mbus_type Info, and I didn't know where have declared it explic=
itly.
> >
> >> Another option would be to pass a string followed by one hex digit for=
 the
> bits:
> >>
> >> 	snps,cache_type =3D <"data_wr" 0x8>, <"desc_rd" 0x2>...;
> >>
> >> Then we don't need to describe mbus_type since the bits are what matte=
rs.

For this option, looks like DTC doesn't allow form of <"data_wr" 0x8>, <"de=
sc_rd" 0x2>...=20
It will report error when compiling:

DTC     arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dtb
Error: arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi:383.23-24 syntax erro=
r
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:294: recipe for target 'arch/arm64/boot/dts/freescale/=
fsl-ls1088a-qds.dtb' failed
make[2]: *** [arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
Error: arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi:383.23-24 syntax erro=
r
FATAL ERROR: Unable to parse input tree

One of the solution I can figure out is to use macro to replace "data_wr", =
like below:
<DATA_WR 0x8>, <DESC_RD 0x2>...

However, it will require creating file in include/dt-bindings/usb/dwc3.h to
place macro definitions.

Or may I use:  "data_wr", <0x8>,  "desc_rd",  <0x2>... ?

Thanks & Regards,
Ran

> > Yes, it's also what we prefer to use, it will be more flexible, I can
> > add above Table
> > 6-5 Cache Type Bit Assignments in binding to help user decide which
> > value they would use.
> >
> > I would submit another version of patch for further review, thank you v=
ery
> much.
>=20
> cool, thanks
>=20
> --
> balbi
