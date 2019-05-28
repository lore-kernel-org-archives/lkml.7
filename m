Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D487EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55E208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oj9Sb7lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfE1KCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:02:52 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:40583
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfE1KCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoO5+tbHv6W5nKxCDdtrJif6oIYPQQ2ACJTAbrrPVgo=;
 b=oj9Sb7lobf4mrlt4waPrkr8txJWSetl3dsY7Q98EhS8URkC/+TH05JheKkNqUE/6oG0kW3vrOtLIKDiT2vOPpJ12UcWiIPC7G8eAGTuaGXPeSaygcUOOLNaoB7Cm4PJvdArAMUwHsAX0qkIB7YIi0NXkHiGOU5uy0qi9tgzSfrg=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2788.eurprd04.prod.outlook.com (10.175.45.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 10:02:45 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824%4]) with mapi id 15.20.1943.016; Tue, 28 May 2019
 10:02:45 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Topic: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Index: AQHTXdpMV/QBUrO8J0eNmcCmR0ATg6MVIlkAgAAD6zCAABVWgINueaJw
Date:   Tue, 28 May 2019 10:02:45 +0000
Message-ID: <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com>
 <87ineb9b5v.fsf@linux.intel.com>
 <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com>
 <87shdfet90.fsf@linux.intel.com>
In-Reply-To: <87shdfet90.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8c669a4-6731-4831-e9d1-08d6e353a1c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR0402MB2788;
x-ms-traffictypediagnostic: AM5PR0402MB2788:
x-microsoft-antispam-prvs: <AM5PR0402MB278807F86432774147BEB530F11E0@AM5PR0402MB2788.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(66066001)(7696005)(14454004)(316002)(9686003)(5660300002)(53936002)(54906003)(33656002)(8676002)(8936002)(81166006)(99286004)(81156014)(6916009)(229853002)(256004)(14444005)(476003)(2906002)(66446008)(66946007)(6506007)(446003)(102836004)(7736002)(71190400001)(71200400001)(478600001)(74316002)(6116002)(3846002)(305945005)(55016002)(486006)(64756008)(52536014)(11346002)(76176011)(68736007)(4326008)(66556008)(26005)(86362001)(73956011)(6246003)(186003)(76116006)(25786009)(6436002)(53546011)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2788;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y2x1gSTwIsIHDtAmFAU9siP7TS8aI4pbq5dgoUvwedO5x1pR1dqVsTQfKTN6EZFVXJA3Sm+e9tC1A3/TWvEwgapKZT0XBRJMEfw7rnFznIjhFjtIQHoSyNnB3ZINwK39kQGvvm89H1r1psS7QL237rgg4k5x9XbOHXgXVnV+evskxDfCJJE/F9OdPJDxmZjvtX635F4HJS7YoXI4TBVjesTjrMAVPpBwwieBLpac0IgtPUjkD1hsyM1POct6wq4x2DxA5eyWwnf6fRbJ1RmlSyaP8IRpSjhymxNrJHV7looXvICM98ApHg2P8uefxbSwLrzI55Si3pEgqGrjngiXEASjWiMkzVniFbk+4BTalx6gaTeOHF8uCdER8plfl3bkenbFbACwEGxiIVEH5DGLR+WEtIm8SaUsvcXw+4XTKqc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c669a4-6731-4831-e9d1-08d6e353a1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 10:02:45.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

    Sorry for the late reply:

On Wednesday, November 15, 2017 18:23, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Ran Wang <ran.wang_1@nxp.com> writes:
> >> Ran Wang <ran.wang_1@nxp.com> writes:
> >> > Add support for USB3 snooping by asserting bits in register
> >> > DWC3_GSBUSCFG0 for data and descriptor.
> >>
> >> we know *how* to enable a feature :-) It's always the same, you
> >> fiddle with some registers and it works. What you failed to tell us is=
:
> >>
> >> a) WHY do you need this?
> >> b) WHY do we need another DT property for this?
> >> c) WHAT does this mean for PCI devices?
> >
> > So far I cannot have the answer for you, will get you back after some
> > discussion with my colleagues.
>=20
> IOW, you have no idea why you need this, right? We're not patching things=
 for
> the sake of patching things. We need to understand what these changes mea=
n
> to the HW before we send out a patch publicly.
>=20
> Remember that the moment a patch like this is accepted, it has the potent=
ial of
> changing behavior for *ALL* users.
>=20
> >> > +	}
> >> > +
> >> > +	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
> >>
> >> this will *always* read and write GSBUSCFG0 even for those platforms
> >> which don't need to change anything on this register. You should just
> >> bail out early if !dwc->dma_coherent
> >>
> >> Also, I think dma_coherent is likely not the best name for this proper=
ty.
> >>
> >> Another question is: Why wasn't this setup properly during
> >> coreConsultant instantiation of the RTL? Do you have devices on the
> >> market already that need this or is this some early FPGA model or test=
-only
> ASIC?
> >
> > Yes, you are right. Actually I thought that all dwc3 IP  will have
> > this register, and it can be controlled by DTS property.
>=20
> they all *have* the register, however, it's sort of expected that RTL eng=
ineer will
> setup good defaults when instantiating the RTL using SNPS'
> coreConsultant tool.
>=20
> Does your platform work without this patch?

On Layerscape SoC (such as LS1088A, LS1046A, LS1043A) When I add 'dma-coher=
ent'
to USB nodes without this patch, dwc3 will fail on device enumeration as be=
low:
[    3.610620] xhci-hcd xhci-hcd.2.auto: WARNING: Host System Error
[    3.630609] usb usb2-port1: couldn't allocate usb_device

> >> > +
> >> >  /* Global Debug Queue/FIFO Space Available Register */
> >> >  #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
> >> >  #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
> >> > @@ -859,6 +867,7 @@ struct dwc3_scratchpad_array {
> >> >   * 	3	- Reserved
> >> >   * @imod_interval: set the interrupt moderation interval in 250ns
> >> >   *                 increments or 0 to disable.
> >> > + * @dma_coherent: set if enable dma-coherent.
> >>
> >> you're not enabling dma coherency, you're enabling cache snooping.
> >> And this property should describe that. Also, keep in mind that
> >> different devices may want different cache types for each of those
> >> fields, so your property would have to be a lot more complex. Somethin=
g like:
> >>
> >> 	snps,cache-type =3D <foobar "cacheable">, <baz "cacheable">, ...
> >>
> >> Then driver would have to parse this properly to setup GSBUSCFG0.

According to the DesignWare Cores SuperSpeed USB 3.0 Controller Databook (v=
2.60a),
it has described Type Bit Assignments for all supported master bus type:
AHB, AXI3, AXI4 and Native. I found the bit definition are different among =
them.
So, for the example you gave above, feel a little bit confused.=20
Did you mean:
    snps,cache-type =3D <DATA_RD  "write allocate">, <DESC_RD "cacheable">,=
 <DATA_WR  "bufferable">, <DESC_WR  "read allocate">

> > Got it, learn a lot, need more time to digest and test, thanks for
> > your patiently explanation.
>=20
> no problem, please figure out the answers to my previous questions, witho=
ut
> which I can't accept your patch.
>=20
> >> In any
> >> case, I still want to know why do you really need this? What's the rea=
son?
> >> What happens if you don't fix GSBUSCFG0? What's the value you have
> >> there by default? Why isn't that default good enough?
> >
> > So far the Layerscape SoC (such as LS1088A) has enabled this feature
> > and I have tested it. Once we add dma-coherent on DTS without this
> > Patch, dwc3 will fail on device enumeration as below:
> > [   15.124031] xhci-hcd xhci-hcd.0.auto: Error while assigning device s=
lot ID
> > [   15.130912] xhci-hcd xhci-hcd.0.auto: Max number of devices this xHC=
I host
> supports is 127.
> > [   15.139268] usb usb1-port1: couldn't allocate usb_device
>=20
> okay, so without these changes, your host doesn't work. What is the defau=
lt
> value on your platform without these changes? (revert patch, boot platfor=
m, let
> it fail, get register output from our regdump in debugfs)

The register I dumped is as below (partial register):
root@ls1046ardb:/sys/kernel/debug/2f00000.usb# cat regdump    =20
GSBUSCFG0 =3D 0x00100080
GSBUSCFG1 =3D 0x00000700
GTXTHRCFG =3D 0x00000000
GRXTHRCFG =3D 0x00000000
GCTL =3D 0x30c11004
GEVTEN =3D 0x00000000
GSTS =3D 0x3e800001
GUCTL1 =3D 0x0000018a
GSNPSID =3D 0x5533280a
GGPIO =3D 0x00000000
GUID =3D 0x00050100
 GUCTL =3D 0x0200c010
GBUSERRADDR0 =3D 0x00000000
GBUSERRADDR1 =3D 0x00000000
GPRTBIMAP0 =3D 0x00000000
GPRTBIMAP1 =3D 0x00000000
...

The value of GSBUSCFG0 is the same to what I dump in bootloader(U-boot)
Which mean that's the default value.

Regards,
Ran
