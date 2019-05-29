Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB007C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25F208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qvKYYlpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfE2KM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:12:28 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:56369
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfE2KM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+8+moz8bWfPI+k7LLZ/vsjIzah5sl5AbP0MSwQVDkA=;
 b=qvKYYlpGOteqqM6DICkeEPJ+yyk/Wk7SQMHPbgSJze1EyoEy3pC/ZIro98Ip6jGfMBbC10z8kLX5SlFlRPtGtxGBPfpEpgnVlyNuncAwvxKHUR9VCOKPh0Ab0uqeHWF0poLy3B769v1umvKfGqNtT6husMrMoiZR+dKHSlymIiA=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2737.eurprd04.prod.outlook.com (10.175.39.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 10:12:20 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824%4]) with mapi id 15.20.1943.016; Wed, 29 May 2019
 10:12:20 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Topic: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Index: AQHTXdpMV/QBUrO8J0eNmcCmR0ATg6MVIlkAgAAD6zCAABVWgINueaJwgAAMz4CAAYVcwA==
Date:   Wed, 29 May 2019 10:12:19 +0000
Message-ID: <AM5PR0402MB2865AB6C2A50851B7EA4E653F11F0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com>
 <87ineb9b5v.fsf@linux.intel.com>
 <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com>
 <87shdfet90.fsf@linux.intel.com>
 <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <87k1eaanjw.fsf@linux.intel.com>
In-Reply-To: <87k1eaanjw.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61430f05-36ab-4ebd-1fd6-08d6e41e22a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2737;
x-ms-traffictypediagnostic: AM5PR0402MB2737:
x-microsoft-antispam-prvs: <AM5PR0402MB273741E7F6A50924D90273FDF11F0@AM5PR0402MB2737.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(446003)(256004)(11346002)(14444005)(71200400001)(3846002)(66066001)(66476007)(478600001)(6116002)(66556008)(73956011)(64756008)(66446008)(52536014)(6246003)(14454004)(53936002)(68736007)(186003)(9686003)(86362001)(26005)(76116006)(66946007)(5660300002)(6436002)(33656002)(25786009)(54906003)(305945005)(2906002)(316002)(7736002)(71190400001)(8936002)(74316002)(6506007)(53546011)(486006)(476003)(8676002)(102836004)(55016002)(76176011)(81166006)(229853002)(99286004)(6916009)(7696005)(81156014)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2737;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: quTrDAiWLbW9P/daOBU182J9FeDbdWWGTMFuzT48vz+lDLTkjttibmPZMtH0I3QQwAnG5tvdfBWjKGEJy5mDdWqEjx+MKWTAXW4qTp7gafDVjcUk6rGk38LS8fqbdYxXdj2yhaFejYO3V3OgbrvbFRGx5daurExz/F7jLs8LUwvIt4ITctSGabzOuIvbeEG+FRT8qLqhY/I92tGMHrxvwFvn6EyWttAMCWolE8uYDzWfeAgFFh+ziRYA9NTeMWrYanb3S+6is02RouLe0jM5MQxo2xE+DZytKKgJee3DnFZSBZIIA0lWYNbiIj5plTTMXbPw7BH2pFpjiYgc+LPL7+U3hyQhCAu3e5WWcTUbE2SzZxux+pLBEDvsgKVStuP4eEwMl9o4occ24dE53y6ke7Vt9TwF7RWzsIK1NyZhnLo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61430f05-36ab-4ebd-1fd6-08d6e41e22a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 10:12:19.9230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Felipe,

On Tuesday, May 28, 2019 18:20, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Ran Wang <ran.wang_1@nxp.com> writes:
>=20
> > Hi Felipe,
> >
> >     Sorry for the late reply:
> >
> > On Wednesday, November 15, 2017 18:23, Felipe Balbi wrote:
>=20
> that's 1.5 year ago. I really don't remember the details of this conversa=
tion
>=20
> >> Ran Wang <ran.wang_1@nxp.com> writes:
> >> >> Ran Wang <ran.wang_1@nxp.com> writes:
> >> >> > Add support for USB3 snooping by asserting bits in register
> >> >> > DWC3_GSBUSCFG0 for data and descriptor.
> >> >>
> >> >> we know *how* to enable a feature :-) It's always the same, you
> >> >> fiddle with some registers and it works. What you failed to tell us=
 is:
> >> >>
> >> >> a) WHY do you need this?

I think I have answered this as blow: to fix issue we found.

> >> >> b) WHY do we need another DT property for this?

I agreed with your suggestion of using ' snps,cache-type =3D <foobar "cache=
able">, ...'

> >> >> c) WHAT does this mean for PCI devices?

According to DWC3 data book, I think this (PCI) mean to the case of 'master=
 bus type =3D Native'
The data book describes this feature as 'system bus DMA option for the mast=
er bus,
which may be configured as AHB, AXI, or Native.' On Table 6-5, it says when=
 MBUS_TYPE
is Native, the definition of 4 transfer types control bits [3-0] is 'Same a=
s AXI'.

However, as to the code implementation to be generic to both PCI and AXI,
I admit I don't have a perfect solution so far, only 2 proposals with conce=
rns:

a. Create another module driver like dwc3-exynos.c (arch/arm/boot/dts/wxyno=
s54xx.dtsi)
    to contain above programming code. However, it will touch the same reg =
range of DWC3
    I think this is not good.

b. Add #ifdef CONFIG_ARCH_LAYERSCAPE in drivers/usb/dwc3/core.c to constrai=
n hacking code
   can only take effect for Layerscape (AXI case). I know it look ugly.

Do you have any better advice on this (besides changed power on default val=
ue from HW perspective)?

> >> >
> >> > So far I cannot have the answer for you, will get you back after
> >> > some discussion with my colleagues.
> >>
> >> IOW, you have no idea why you need this, right? We're not patching
> >> things for the sake of patching things. We need to understand what
> >> these changes mean to the HW before we send out a patch publicly.
> >>
> >> Remember that the moment a patch like this is accepted, it has the
> >> potential of changing behavior for *ALL* users.
> >>
> >> >> > +	}
> >> >> > +
> >> >> > +	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
> >> >>
> >> >> this will *always* read and write GSBUSCFG0 even for those
> >> >> platforms which don't need to change anything on this register.
> >> >> You should just bail out early if !dwc->dma_coherent

Yes, noted.

> >> >>
> >> >> Also, I think dma_coherent is likely not the best name for this pro=
perty.

OK

> >> >>
> >> >> Another question is: Why wasn't this setup properly during
> >> >> coreConsultant instantiation of the RTL? Do you have devices on
> >> >> the market already that need this or is this some early FPGA model
> >> >> or test-only
> >> ASIC?

Several Layerscape platforms like LS1043ARDB, LS1046ARDB, etc. are already =
on
the market and have this issue. So I have to work out a SW patch to fix the=
m.

> >> >
> >> > Yes, you are right. Actually I thought that all dwc3 IP  will have
> >> > this register, and it can be controlled by DTS property.
> >>
> >> they all *have* the register, however, it's sort of expected that RTL
> >> engineer will setup good defaults when instantiating the RTL using SNP=
S'
> >> coreConsultant tool.
> >>
> >> Does your platform work without this patch?
> >
> > On Layerscape SoC (such as LS1088A, LS1046A, LS1043A) When I add 'dma-
> coherent'
> > to USB nodes without this patch, dwc3 will fail on device enumeration a=
s
> below:
> > [    3.610620] xhci-hcd xhci-hcd.2.auto: WARNING: Host System Error
> > [    3.630609] usb usb2-port1: couldn't allocate usb_device
>=20
> Right, and same as before: are these devices in the market or are you dea=
ling
> with pre-silicon prototypes?

Already in the market, need SW fix.

> >> >> >  /* Global Debug Queue/FIFO Space Available Register */
> >> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
> >> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
> >> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
> >> >> >   * 	3	- Reserved
> >> >> >   * @imod_interval: set the interrupt moderation interval in 250n=
s
> >> >> >   *                 increments or 0 to disable.
> >> >> > + * @dma_coherent: set if enable dma-coherent.
> >> >>
> >> >> you're not enabling dma coherency, you're enabling cache snooping.
> >> >> And this property should describe that. Also, keep in mind that
> >> >> different devices may want different cache types for each of those
> >> >> fields, so your property would have to be a lot more complex. Somet=
hing
> like:
> >> >>
> >> >> 	snps,cache-type =3D <foobar "cacheable">, <baz "cacheable">, ...
> >> >>
> >> >> Then driver would have to parse this properly to setup GSBUSCFG0.
> >
> > According to the DesignWare Cores SuperSpeed USB 3.0 Controller
> > Databook (v2.60a), it has described Type Bit Assignments for all suppor=
ted
> master bus type:
> > AHB, AXI3, AXI4 and Native. I found the bit definition are different am=
ong
> them.
> > So, for the example you gave above, feel a little bit confused.
> > Did you mean:
> >     snps,cache-type =3D <DATA_RD  "write allocate">, <DESC_RD
> > "cacheable">, <DATA_WR  "bufferable">, <DESC_WR  "read allocate">
>=20
> yeah, something like that.
>=20
> >> > Got it, learn a lot, need more time to digest and test, thanks for
> >> > your patiently explanation.
> >>
> >> no problem, please figure out the answers to my previous questions,
> >> without which I can't accept your patch.
>=20
> ^^^
>=20
> I still don't have all the answers

If I still missed any question, please let me know, thanks for your time.

Regards,
Ran
