Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C06820881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="DRAfirgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfEVO5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:57:40 -0400
Received: from mail-eopbgr1410121.outbound.protection.outlook.com ([40.107.141.121]:20657
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728450AbfEVO5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c21XBv9LT0YRMXNDNGRXwiDLTzkVDNF/OjbkwEjNRGg=;
 b=DRAfirghmuzumw/U0XvFo3Lc/FfpHwTXGawP51vVxES0+tyIPIgM5vfrIPUqW96MzLGcDgQgeyeJDZyBo8DO2HX6inIG2+q/1H3DoBE8OWWfYu19cSpLdpz3zp2s8RjOMayeIEzZN1lCcyPaCIj0AHoLUcdn/Hyqf7ayLhMbj2g=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB3368.jpnprd01.prod.outlook.com (20.178.5.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 22 May 2019 14:57:33 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::a146:39f0:5df9:11bc]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::a146:39f0:5df9:11bc%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 14:57:33 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by node
Thread-Topic: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
 node
Thread-Index: AQHVCjGxbEdsIx4ReU+jIZIOb3TooaZvJLIAgAApPICABAgXgIAAWsCAgAAANlCAAAi9gIAADx0AgAGaToCAAW2SoIAAHO0AgAAPKZCAAEOPAIAAB1yw
Date:   Wed, 22 May 2019 14:57:33 +0000
Message-ID: <OSBPR01MB2103B669C24E9E261B4AFA73B8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <20190517130511.GA1887@kuha.fi.intel.com>
 <1558319951.10179.352.camel@mhfsdcap03>
 <20190520080359.GC1887@kuha.fi.intel.com>
 <OSBPR01MB2103385D996762FA54F8E437B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20190520083601.GE1887@kuha.fi.intel.com>
 <OSBPR01MB2103C4C8920C40E42BC1B2A9B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20190521095839.GI1887@kuha.fi.intel.com>
 <OSBPR01MB21032206146152983C8F4E8EB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <1558517436.10179.388.camel@mhfsdcap03>
 <OSBPR01MB21038F2B99EF74831A22727BB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20190522142640.GN1887@kuha.fi.intel.com>
In-Reply-To: <20190522142640.GN1887@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88c3acd7-5ea7-4f5c-63d4-08d6dec5d223
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB3368;
x-ms-traffictypediagnostic: OSBPR01MB3368:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <OSBPR01MB3368B9DB4A7B534BE6782041B8000@OSBPR01MB3368.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(376002)(346002)(366004)(51914003)(199004)(189003)(6246003)(26005)(55016002)(6306002)(5660300002)(8936002)(6506007)(14454004)(25786009)(66446008)(64756008)(66476007)(66556008)(53936002)(9686003)(186003)(966005)(5024004)(8676002)(478600001)(6916009)(256004)(81156014)(6436002)(81166006)(102836004)(52536014)(7696005)(7416002)(11346002)(68736007)(6116002)(3846002)(33656002)(74316002)(229853002)(76176011)(86362001)(476003)(66066001)(316002)(44832011)(7736002)(2906002)(66946007)(76116006)(305945005)(73956011)(99286004)(446003)(486006)(54906003)(71200400001)(71190400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3368;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UeO5B6JDXDJFBxY7z97qQKJWTPQxZjhizmoAfiFp1rEyzUr89cXbS+fYb3oY6JpK0riMhAYN02z0Adwx9QOlsOjgPZIRwQYAoCKnQWjBgBOEz8UqNs6nj1WglwdjiIyIxYEvVfSuyAXPrmjCnleyfWgCfjBJY0gDyALA1JZnVWspvDrnS2XpI0P4L+mBWIN1in2UUoGoPR+x34IsYo9A6TvS3/bBuKX+J9XOEqZFCVNKlFUjO5OQOarHH+z+KaM3Z4I1ezV/ePtU2DlvIVvMRMSTKaKqm9aoouCNsXFerhJYhjO298z7fgy+NPn3G/zXmxYWMmiAQufURrgCFWXDjsaxFHebl+U0KDxYThPK2IhGcUDTZOUrSLjJAhstRCk+veAG4TE3zqfKo6L9nUlC6BrcaJ5XyW6VoQZlIyxbOoI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c3acd7-5ea7-4f5c-63d4-08d6dec5d223
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 14:57:33.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thanks for the patch

> Subject: Re: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
> node
>=20
> On Wed, May 22, 2019 at 10:55:17AM +0000, Biju Das wrote:
> > Hi Chunfeng Yun,
> >
> > Thanks for the feedback.
> >
> > > Subject: RE: [PATCH v5 4/6] usb: roles: add API to get
> > > usb_role_switch by node
> > >
> > > Hi Biju,
> > > On Wed, 2019-05-22 at 08:05 +0000, Biju Das wrote:
> > > > Hi Heikki,
> > > >
> > > > Thanks for the feedback.
> > > >
> > > > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get
> > > > > usb_role_switch by node
> > > > >
> > > > > On Mon, May 20, 2019 at 09:45:46AM +0000, Biju Das wrote:
> > > > > >
> > > > > >
> > > > > > Hi Heikki,
> > > > > >
> > > > > > Thanks for the feedback.
> > > > > >
> > > > > > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get
> > > > > > > usb_role_switch by node
> > > > > > >
> > > > > > > On Mon, May 20, 2019 at 08:06:41AM +0000, Biju Das wrote:
> > > > > > > > Hi Heikki,
> > > > > > > >
> > > > > > > > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get
> > > > > > > > > usb_role_switch by node
> > > > > > > > >
> > > > > > > > > On Mon, May 20, 2019 at 10:39:11AM +0800, Chunfeng Yun
> wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > On Fri, 2019-05-17 at 16:05 +0300, Heikki Krogerus wrot=
e:
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, May 17, 2019 at 01:37:36PM +0300, Heikki
> > > > > > > > > > > Krogerus
> > > wrote:
> > > > > > > > > > > > On Tue, May 14, 2019 at 04:47:21PM +0800, Chunfeng
> > > > > > > > > > > > Yun
> > > > > wrote:
> > > > > > > > > > > > > Add fwnode_usb_role_switch_get() to make easier
> > > > > > > > > > > > > to get usb_role_switch by fwnode which register i=
t.
> > > > > > > > > > > > > It's useful when there is not device_connection
> > > > > > > > > > > > > registered between two drivers and only knows
> > > > > > > > > > > > > the fwnode which register usb_role_switch.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Chunfeng Yun
> > > > > > > > > > > > > <chunfeng.yun@mediatek.com>
> > > > > > > > > > > > > Tested-by: Biju Das <biju.das@bp.renesas.com>
> > > > > > > > > > > >
> > > > > > > > > > > > Acked-by: Heikki Krogerus
> > > > > > > > > > > > <heikki.krogerus@linux.intel.com>
> > > > > > > > > > >
> > > > > > > > > > > Hold on. I just noticed Rob's comment on patch 2/6,
> > > > > > > > > > > where he points out that you don't need to use
> > > > > > > > > > > device graph since the controller is the parent of
> > > > > > > > > > > the connector. Doesn't that mean you don't really nee=
d
> this API?
> > > > > > > > > > No, I still need it.
> > > > > > > > > > The change is about the way how to get fwnode; when
> > > > > > > > > > use device graph, get fwnode by
> > > > > > > > > > of_graph_get_remote_node(); but now will get fwnode by
> > > > > > > > > > of_get_parent();
> > > > > > > > >
> > > > > > > > > OK, I get that, but I'm still not convinced about if
> > > > > > > > > something like this function is needed at all. I also
> > > > > > > > > have concerns regarding how you are using the function.
> > > > > > > > > I'll explain in comment to the patch 5/6 in this
> > > > > > > series...
> > > > > > > >
> > > > > > > > FYI, Currently  I am also using this api in my patch series=
.
> > > > > > > > https://patchwork.kernel.org/patch/10944637/
> > > > > > >
> > > > > > > Yes, and I have the same question for you I jusb asked in
> > > > > > > comment I added to the patch 5/6 of this series. Why isn't
> > > > > > > usb_role_switch_get()
> > > > > enough?
> > > > > >
> > > > > > Currently no issue. It will work with this api as well, since
> > > > > > the port node is
> > > > > part of controller node.
> > > > > > For eg:-
> > > > > > https://patchwork.kernel.org/patch/10944627/
> > > > > >
> > > > > > However if any one adds port node inside the connector node,
> > > > > > then this
> > > > > api may won't work as expected.
> > > > > > Currently I get below error
> > > > > >
> > > > > > [    2.299703] OF: graph: no port node found in
> > > > > /soc/i2c@e6500000/hd3ss3220@47
> > > > >
> > > > > We need to understand why is that happening?
> > > > >
> > > >
> > > > Form the stack trace  the parent node is
> > > > "parent_node=3Dhd3ss3220@47" ,
> > > instead of the "connector" node.
> > > > That is the reason for the above error.
> > > >
> > > > [    2.442429]  of_graph_get_next_endpoint.part.0+0x28/0x168
> > > > [    2.447889]  of_fwnode_graph_get_next_endpoint+0x5c/0xb0
> > > > [    2.453267]  fwnode_graph_get_next_endpoint+0x20/0x30
> > > > [    2.458374]  device_connection_find_match+0x74/0x1a0
> > > > [    2.463399]  usb_role_switch_get+0x20/0x28
> > > > [    2.467542]  hd3ss3220_probe+0xc4/0x218
> > > >
> > > > The use case is
> > > >
> > > > &i2c0 {
> > > > 	hd3ss3220@47 {
> > > >                  	compatible =3D "ti,hd3ss3220";
> > > >
> > > >                  	usb_con: connector {
> > > >                           		compatible =3D "usb-c-connector";
> > > >                          		port {
> > > >                                 		 hd3ss3220_ep: endpoint {
> > > >                                         			remote-endpoint =3D
> > > <&usb3_role_switch>;
> > > >                                 		};
> > > >                          		};
> > > >                 	 };
> > > > 	 };
> > > > };
> > > >
> > > > &usb3_peri0 {
> > > >          companion =3D <&xhci0>;
> > > >          usb-role-switch;
> > > >
> > > >          port {
> > > >                 usb3_role_switch: endpoint {
> > > >                         remote-endpoint =3D <&hd3ss3220_ep>;
> > > >                  };
> > > >          };
> > > > };
> > > >
> > > > Q1) How do we modify the usb_role_switch_get() function to search
> > > > Child(connector) and child's endpoint?
> > > How about firstly finding connector node in
> > > fwnode_graph_devcon_match(), then search each endpoint?
> >
> >  I have done a quick prototyping with the changes you suggested and it
> works.
> >
> > -       struct fwnode_handle *ep;
> > +       struct fwnode_handle *ep,*child,*tmp =3D fwnode;
> >
> > -       fwnode_graph_for_each_endpoint(fwnode, ep) {
> > +       child =3D fwnode_get_named_child_node(fwnode, "connector");
> > +       if (child)
> > +               tmp =3D child;
> > +
> > +       fwnode_graph_for_each_endpoint(tmp, ep) {
> >
> > Form the stack trace  the parent node is "parent_node=3D connector" .
> >
> > [    2.440922]  of_graph_get_next_endpoint.part.0+0x28/0x168
> > [    2.446381]  of_fwnode_graph_get_next_endpoint+0x5c/0xb0
> > [    2.451758]  fwnode_graph_get_next_endpoint+0x20/0x30
> > [    2.456866]  device_connection_find_match+0x84/0x1c0
> > [    2.461888]  usb_role_switch_get+0x20/0x28
> >
> > Heikki,
> > Are you ok  with the above changes?
>=20
> Doesn't that mean that if we made fwnode_usb_role_switch_get() the way I
> proposed, there is no problem? You just find the "connector" child node i=
n
> your driver, and pass that to fwnode_usb_role_switch_get():

Yes, That is correct.

>         struct fwnode_handle *connector;
>         ...
>         connector =3D device_get_named_child_node(&client->dev, "connecto=
r");
>         if (IS_ERR(connector))
>                 <do something>
>=20
>         hd3ss3220->role_sw =3D fwnode_usb_role_switch_get(connector);
>         ...
>=20
> The difference is that instead of just converting a device node of an usb=
 role
> switch to the usb role switch, it works just like usb_role_switch_get(), =
just
> taking fwnode instead of device entry as parameter.
>=20
> I prepared the patches implementing fwnode_usb_role_switch_get() the
> way I though it needs to work for my own tests. Please find the patches
> attached.

I have tested  this patches and conform it works.=20
Do you plan to post this patches to ML?=20

Regards,
Biju
