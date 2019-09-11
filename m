Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C8C49ED9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A4121D82
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SQVIqMHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfIKC1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 22:27:32 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:47333
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbfIKC1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhqllbggRiXkobYYcWTbPMaHv/1xrJruO+MC6He3UvxHAyO/rATRslquNauNhlVY+/DAqAv3QCcezBYE9E3MEDatS4Clcb33OcCnaw4Ms7jlVms+vz7g5J0ReFcRPEDS89HSOW6f2Izw+QA3xU5p9TDJX1EaSnOmppkgfxHBNZ8xxl9lBWDvEwIQnNgbXut84we919qXjWgjqb5kKVdC2rEKo60PeY55lyaIY4NqyirnmgVQ/jaIEMOmzedfcTIJkpyJ/jvc32q/HdHHw0DzMT70OejVdlU5uiZ8q4T4PcbFDYSawem6uy7qgXLWpzx2eO6RSzRYMVWrKf2tFqOD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEOzJb9NEabWvSIS+iOvjxnXMHXkdAWBSsp6eSQwP6o=;
 b=lY64w5BqMZAfGl+Drvzme29pOX/05W8R3K+Z7U0YHc5v4MUo85zH+9mG/knPO0KlRsC8qvpqTDIBJAMVoFDF273T5xY8Yw7k/bLKHUhRONt5tQ775C+qKzKfPPTCIYw4w5lk4awHe3s0vremGjnRgiqtznNfGcwNfCz3FWTtCL6nhs7mI7gJz32jlyFpRQQ4rhtUIosROXTCwSMTw+3Y2pSQ4y/X20gHxq8QbeCH6SZOIDpHlPqzLRwGtoakr/jU7Nj23D5mD4jtkD+aNpMzNa5Ki8XhcOd9vLGxcLHBaIBQhDDlt4hiX9OMohvAL5bktoF7g5o9lZ6TSc5YEnEpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEOzJb9NEabWvSIS+iOvjxnXMHXkdAWBSsp6eSQwP6o=;
 b=SQVIqMHosfVrfyxh8DxX10M/ls9NFfObzvwFD4gWTAIuz5fiyAp0dUABq2n1fLGVP0N990v8XV+L2I2EbnlpZB1vyWKhPYPiEjO4RuSK+I7WdjdkQkOkGHaCFVx9K0m5bV5KbJQWaQSsk5xprEuQvqtUehG9rgxUG1m7v/kVKjA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6467.eurprd04.prod.outlook.com (20.179.252.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Wed, 11 Sep 2019 02:27:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 02:27:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVXU0YJPArUxY1ok6XlIUgkri4VacTNWSAgAAFe+CAABGfAIAAAKjwgAAICwCAAAHRcIAAA7iAgBAQugCAAmo6sA==
Date:   Wed, 11 Sep 2019 02:27:26 +0000
Message-ID: <AM0PR04MB44816D2E34BC89FAE9C4429188B10@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
        <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
        <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
        <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
        <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
        <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
        <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com>
        <AM0PR04MB448133D1F4C887A82C679CEB88BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
        <CABb+yY2t-oz6KqvCTsOJZqcMAUaR9Cbj014m7dCFXSBAMCojww@mail.gmail.com>
 <20190909143230.48b1143f@donnerap.cambridge.arm.com>
In-Reply-To: <20190909143230.48b1143f@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b433e183-1c1b-4a63-8562-08d7365f9670
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6467;
x-ms-traffictypediagnostic: AM0PR04MB6467:|AM0PR04MB6467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB646793BB6138C3373CD8453B88B10@AM0PR04MB6467.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(15650500001)(186003)(8936002)(3846002)(8676002)(25786009)(76116006)(6506007)(6116002)(81166006)(74316002)(81156014)(7696005)(478600001)(52536014)(53546011)(476003)(102836004)(4326008)(64756008)(66066001)(86362001)(26005)(66446008)(446003)(66556008)(66476007)(11346002)(66946007)(54906003)(229853002)(99286004)(55016002)(110136005)(9686003)(53936002)(7736002)(256004)(486006)(44832011)(305945005)(71200400001)(71190400001)(6246003)(2906002)(14454004)(5660300002)(316002)(33656002)(6436002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6467;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BU9Al/L4kY3Sciqu/JpjK+3jmmB6CVrWBBdBbs7X91o60z+2fONS9FEjhycqCCty1nmYCY+AlR70lRm9WCDmdMdqqKpZCAqvP8fqoTODzuGzAtGuH+gZmUFmEP82VI/in7MgrL2StWxwCb1kTPCzU1ABgmesK4MunsscevXkGWLJApgxOFi6tmWqae1dUE9Pu/V0x3w7xeB5cehBrOfMqQgsyHFNdShaWYkk1juvw5kBIc7hh7be7aafVOkjaKM/ImhBmaC5oeUIe8hT0NjXJq8Rf7EvnsDo7wI9WXtOFLQzBuAxQVyUr9Xa5CkVv7KydUCSN85+Dehr+jylawbp9E2wrSfQjA3BI18ZOVVBKy5Ophl5nuoII8LhByJDl2dOxR5jOK8mB+qM5HACrzfCSObduEROl2kIOZ1/hOkig4E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b433e183-1c1b-4a63-8562-08d7365f9670
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 02:27:26.9074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsRRlgWGlkFJOnN7KpgNNkzBDNbeCN/F3geIuzqSoHhAaE+YcghdkGO60BcyBuYzfLjMDHKJgDl/wZTosHhzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the=
 ARM
> SMC/HVC mailbox
>=20
> On Fri, 30 Aug 2019 03:12:29 -0500
> Jassi Brar <jassisinghbrar@gmail.com> wrote:
>=20
> Hi,
>=20
> > On Fri, Aug 30, 2019 at 3:07 AM Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc
> > > > for the ARM SMC/HVC mailbox
> > > >
> > > > On Fri, Aug 30, 2019 at 2:37 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > >
> > > > > Hi Jassi,
> > > > >
> > > > > > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding
> > > > > > doc for the ARM SMC/HVC mailbox
> > > > > >
> > > > > > On Fri, Aug 30, 2019 at 1:28 AM Peng Fan <peng.fan@nxp.com>
> wrote:
> > > > > >
> > > > > > > > > +examples:
> > > > > > > > > +  - |
> > > > > > > > > +    sram@910000 {
> > > > > > > > > +      compatible =3D "mmio-sram";
> > > > > > > > > +      reg =3D <0x0 0x93f000 0x0 0x1000>;
> > > > > > > > > +      #address-cells =3D <1>;
> > > > > > > > > +      #size-cells =3D <1>;
> > > > > > > > > +      ranges =3D <0 0x0 0x93f000 0x1000>;
> > > > > > > > > +
> > > > > > > > > +      cpu_scp_lpri: scp-shmem@0 {
> > > > > > > > > +        compatible =3D "arm,scmi-shmem";
> > > > > > > > > +        reg =3D <0x0 0x200>;
> > > > > > > > > +      };
> > > > > > > > > +
> > > > > > > > > +      cpu_scp_hpri: scp-shmem@200 {
> > > > > > > > > +        compatible =3D "arm,scmi-shmem";
> > > > > > > > > +        reg =3D <0x200 0x200>;
> > > > > > > > > +      };
> > > > > > > > > +    };
> > > > > > > > > +
> > > > > > > > > +    firmware {
> > > > > > > > > +      smc_mbox: mailbox {
> > > > > > > > > +        #mbox-cells =3D <1>;
> > > > > > > > > +        compatible =3D "arm,smc-mbox";
> > > > > > > > > +        method =3D "smc";
> > > > > > > > > +        arm,num-chans =3D <0x2>;
> > > > > > > > > +        transports =3D "mem";
> > > > > > > > > +        /* Optional */
> > > > > > > > > +        arm,func-ids =3D <0xc20000fe>, <0xc20000ff>;
> > > > > > > > >
> > > > > > > > SMC/HVC is synchronously(block) running in "secure mode",
> > > > > > > > i.e, there can only be one instance running platform wide. =
Right?
> > > > > > >
> > > > > > > I think there could be channel for TEE, and channel for Linux=
.
> > > > > > > For virtualization case, there could be dedicated channel for=
 each
> VM.
> > > > > > >
> > > > > > I am talking from Linux pov. Functions 0xfe and 0xff above,
> > > > > > can't both be active at the same time, right?
> > > > >
> > > > > If I get your point correctly,
> > > > > On UP, both could not be active. On SMP, tx/rx could be both
> > > > > active, anyway this depends on secure firmware and Linux firmware
> design.
> > > > >
> > > > > Do you have any suggestions about arm,func-ids here?
> > > > >
> > > > I was thinking if this is just an instruction, why can't each
> > > > channel be represented as a controller, i.e, have exactly one func-=
id per
> controller node.
> > > > Define as many controllers as you need channels ?
> > >
> > > I am ok, this could make driver code simpler. Something as below?
> > >
> > >     smc_tx_mbox: tx_mbox {
> > >       #mbox-cells =3D <0>;
> > >       compatible =3D "arm,smc-mbox";
> > >       method =3D "smc";
> > >       transports =3D "mem";
> > >       arm,func-id =3D <0xc20000fe>;
> > >     };
> > >
> > >     smc_rx_mbox: rx_mbox {
> > >       #mbox-cells =3D <0>;
> > >       compatible =3D "arm,smc-mbox";
> > >       method =3D "smc";
> > >       transports =3D "mem";
> > >       arm,func-id =3D <0xc20000ff>;
> > >     };
> > >
> > >     firmware {
> > >       scmi {
> > >         compatible =3D "arm,scmi";
> > >         mboxes =3D <&smc_tx_mbox>, <&smc_rx_mbox 1>;
> > >         mbox-names =3D "tx", "rx";
> > >         shmem =3D <&cpu_scp_lpri>, <&cpu_scp_hpri>;
> > >       };
> > >     };
> > >
> > Yes, the channel part is good.
> > But I am not convinced by the need to have SCMI specific "transport" mo=
de.
>=20
> Why would this be SCMI specific and what is the problem with having this
> property?
> By the very nature of the SMC/HVC call you would expect to also pass
> parameters in registers. However this limits the amount of data you can p=
ush,
> so the option of reverting to a memory based payload sounds very
> reasonable.
> On the other hand *just* using memory complicates things, in case you hav=
e a
> very simple protocol. You would need a memory region shared between
> firmware and OS, which is not always easily possible on every platform. A=
lso
> this doesn't scale easily with multiple mailboxes and channels. Passing
> parameters via registers is also naturally consistent, as there would be =
no
> races and no need for synchronisation with other cores or other users of =
the
> mailbox.
>=20
> So I clearly see the benefit of specifying *both* ways of payload transpo=
rt.
> Given that this driver should be protocol agnostic, it makes a lot of sen=
se to
> introduce both methods *now*, so in the future users can just use the reg=
ister
> method, without extending the binding in a incompatible way later (earlie=
r
> kernels would have the driver, but wouldn't know how to deal with this
> parameter).

Andre, thanks for your explanation.
Jassi, are you ok that this property "transport" is kept in V6?

Thanks,
Peng.
>=20
> Cheers,
> Andre.
