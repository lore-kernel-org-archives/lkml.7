Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3657AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A4D205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nHOI4kCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFXBpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:45:18 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:6158
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfFXBpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02TUb5UvSb7NyRKSN+sjLaSwTbBBu4pwjMUSxS/HBwU=;
 b=nHOI4kCloZfZWNWzyYBTyJzLxDNc1KeSlbB4eGB8DJJ5lDHdvtdATm3FxIunskFQYikA3GN+MEDR8o2L6uBcb5FZyqYmzASLP4cz5T5oQiLbkE1W9LcdYRIQq8Z26n3kVpjTTClVPfmav+qcRreMj/pc3jO74Ys6aLdOrjsfK3E=
Received: from VE1PR04MB6655.eurprd04.prod.outlook.com (20.179.235.94) by
 VE1PR04MB6735.eurprd04.prod.outlook.com (20.179.235.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Mon, 24 Jun 2019 01:45:13 +0000
Received: from VE1PR04MB6655.eurprd04.prod.outlook.com
 ([fe80::846e:134d:2731:fcd]) by VE1PR04MB6655.eurprd04.prod.outlook.com
 ([fe80::846e:134d:2731:fcd%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 01:45:13 +0000
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
Thread-Index: AQHTXdpMV/QBUrO8J0eNmcCmR0ATg6MVIlkAgAAD6zCAABVWgINueaJwgAAMz4CAAwpoAIAF38DwgBavPgCACkIu0A==
Date:   Mon, 24 Jun 2019 01:45:13 +0000
Message-ID: <VE1PR04MB66557834D3588FC8B558950AF1E00@VE1PR04MB6655.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com>
 <87ineb9b5v.fsf@linux.intel.com>
 <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com>
 <87shdfet90.fsf@linux.intel.com>
 <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <87k1eaanjw.fsf@linux.intel.com>
 <AM5PR0402MB2865F3735D808E1BC9F67968F1180@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <AM5PR0402MB2865D0F0E2B4F65C86D051F8F1140@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <87o92wgyqj.fsf@linux.intel.com>
In-Reply-To: <87o92wgyqj.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28c91b37-afd8-4a10-104c-08d6f845999c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6735;
x-ms-traffictypediagnostic: VE1PR04MB6735:
x-microsoft-antispam-prvs: <VE1PR04MB67353FF63948D7F61C0CD4B2F1E00@VE1PR04MB6735.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(504964003)(4326008)(110136005)(102836004)(8936002)(7696005)(33656002)(54906003)(6506007)(14454004)(66446008)(53546011)(2906002)(71190400001)(66946007)(64756008)(73956011)(66556008)(256004)(71200400001)(3846002)(6116002)(66066001)(6436002)(14444005)(25786009)(5660300002)(478600001)(486006)(68736007)(229853002)(476003)(81166006)(55016002)(53936002)(99286004)(52536014)(186003)(76116006)(76176011)(316002)(66476007)(11346002)(6246003)(8676002)(446003)(86362001)(305945005)(9686003)(7736002)(74316002)(26005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6735;H:VE1PR04MB6655.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KKitJ8ZyXASCt9+NKwlwQkXfaSN7RrxJ14D7dyHdvjcEYR6gluxZV3wyPWSE0Z6ZtqirTu3pKj9HuVzcc880nKOGXiMJHo5yAgm6DR2rv/hbaPyxknlGFL7nPlOX/CMYwXvzFmecFuGH5rhlSOQRi2m8tExh8xacOtG8Vs9RyXGV4ryLWNoHakeXT6u24983y5UNUtVBvzRgxECj73lUcOM2pj/UqfUQL+46BDjAsN6kSTSSsGhSihJWE1R45qL+G/b9GPY7HFCpMfJvDfbW/lda8PeG3ePEedC3m4arPSMtZfYebMDfuT00yjtp9dikBAIvrXqrujY8ivLv37lpclaRhpWpMIUEt2WUN7EmcFOu4kvA5pkkXu5tdTq6+lGaauFn6dmyZ5OqBsE4nYdZi9YyuW0XAH2o85ODoeIvqns=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c91b37-afd8-4a10-104c-08d6f845999c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 01:45:13.1508
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

On Monday, June 17, 2019 20:53, Felipe Balbi wrote:
> Hi,
>=20
> Ran Wang <ran.wang_1@nxp.com> writes:
> > Hi Felipe,
> >
> > On Thursday, May 30, 2019 17:09, Ran Wang wrote:
> >>
> >> <snip>
> >> > >> >> >  /* Global Debug Queue/FIFO Space Available Register */
> >> > >> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
> >> > >> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
> >> > >> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
> >> > >> >> >   * 	3	- Reserved
> >> > >> >> >   * @imod_interval: set the interrupt moderation interval in=
 250ns
> >> > >> >> >   *                 increments or 0 to disable.
> >> > >> >> > + * @dma_coherent: set if enable dma-coherent.
> >> > >> >>
> >> > >> >> you're not enabling dma coherency, you're enabling cache snoop=
ing.
> >> > >> >> And this property should describe that. Also, keep in mind
> >> > >> >> that different devices may want different cache types for
> >> > >> >> each of those fields, so your property would have to be a lot
> >> > >> >> more complex. Something
> >> > like:
> >> > >> >>
> >> > >> >> 	snps,cache-type =3D <foobar "cacheable">, <baz "cacheable">, =
...
> >> > >> >>
> >> > >> >> Then driver would have to parse this properly to setup GSBUSCF=
G0.
> >> > >
> >> > > According to the DesignWare Cores SuperSpeed USB 3.0 Controller
> >> > > Databook (v2.60a), it has described Type Bit Assignments for all
> >> > > supported
> >> > master bus type:
> >> > > AHB, AXI3, AXI4 and Native. I found the bit definition are
> >> > > different among
> >> > them.
> >> > > So, for the example you gave above, feel a little bit confused.
> >> > > Did you mean:
> >> > >     snps,cache-type =3D <DATA_RD  "write allocate">, <DESC_RD
> >> > > "cacheable">, <DATA_WR  "bufferable">, <DESC_WR  "read allocate">
> >> >
> >> > yeah, something like that.
> >>
> >> I think DATA_RD  should be a macro, right? So, where I can put its def=
ine?
> >> Create a dwc3.h in include/dt-bindings/usb/ ?
> >
> > Could you please give me some advice here? I'd like to prepare next
> > version patch after getting this settled.
> >
> >> Another question about this remain open is: DWC3 data book's Table
> >> 6-5 Cache Type Bit Assignments show that bits definition will differ
> >> per MBUS_TYPEs as
> >> below:
> >> ----------------------------------------------------------------
> >>  MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> >>  ----------------------------------------------------------------
> >>  AHB      |Cacheable     |Bufferable   |Privilegge |Data
> >>  AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> >>  AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> >>  AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> >>  Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> >>  ----------------------------------------------------------------
> >>  Note: The AHB, AXI3, AXI4, and PCIe busses use different names for
> >> certain  signals, which have the same meaning:
> >>    Bufferable =3D Posted
> >>    Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
> >>
> >> For Layerscape SoCs, MBUS_TYPE is AXI3. So I am not sure how to use
> >> snps,cache-type =3D <DATA_RD  "write allocate">, to cover all MBUS_TYP=
E?
> >> (you can notice that AHB and AXI3's cacheable are on different bit)
> >> Or I just need to handle AXI3 case?
> >
> > Also on this open. Thank you in advance.
>=20
> You could pass two strings and let the driver process them. Something
> like:
>=20
> 	snps,cache_type =3D <"data_wr" "write allocate">, <"desc_rd"
> "cacheable">...
>=20
> And so on. The only thing missing is for the mbus_type to be known by the=
 driver.
> Is that something we can figure out on any of the HWPARAMS registers or d=
oes
> it have to be told explicitly?

I have checked Layerscape Reference manual, HWPARAMS0~8 doesn't contain mbu=
s_type
Info, and I didn't know where have declared it explicitly.

> Another option would be to pass a string followed by one hex digit for th=
e bits:
>=20
> 	snps,cache_type =3D <"data_wr" 0x8>, <"desc_rd" 0x2>...;
>=20
> Then we don't need to describe mbus_type since the bits are what matters.

Yes, it's also what we prefer to use, it will be more flexible, I can add a=
bove Table
6-5 Cache Type Bit Assignments in binding to help user decide which value t=
hey
would use.

I would submit another version of patch for further review, thank you very =
much.

Regards,
Ran

> Rob, any comments?
>=20
> --
> balbi
