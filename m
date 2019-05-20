Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4127C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD7F20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="VQUBEhXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbfETJpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:45:53 -0400
Received: from mail-eopbgr1400102.outbound.protection.outlook.com ([40.107.140.102]:15937
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729835AbfETJpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urpvzzQMwcJiy4pS6sbeUbf3IXmOHrotPzfsSLOu+jQ=;
 b=VQUBEhXCljvfslhV9g2Q453aZBsEEDY4u85rcnbg85FkxRFbU7ixwB+r7uDcmdLf5BSgp+7OA8U286ofQtID0uOVs6H4R+MMMRQjVSjao/3FV8YDaZjme91fSqrpcCetrRe7zG6V5yb8+St29HJzh2COUr0EX+oSCZKkHVcsTpI=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB1832.jpnprd01.prod.outlook.com (52.134.227.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 09:45:46 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::a146:39f0:5df9:11bc]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::a146:39f0:5df9:11bc%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 09:45:46 +0000
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
Thread-Index: AQHVCjGxbEdsIx4ReU+jIZIOb3TooaZvJLIAgAApPICABAgXgIAAWsCAgAAANlCAAAi9gIAADx0A
Date:   Mon, 20 May 2019 09:45:46 +0000
Message-ID: <OSBPR01MB2103C4C8920C40E42BC1B2A9B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1557823643-8616-5-git-send-email-chunfeng.yun@mediatek.com>
 <20190517103736.GA1490@kuha.fi.intel.com>
 <20190517130511.GA1887@kuha.fi.intel.com>
 <1558319951.10179.352.camel@mhfsdcap03>
 <20190520080359.GC1887@kuha.fi.intel.com>
 <OSBPR01MB2103385D996762FA54F8E437B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20190520083601.GE1887@kuha.fi.intel.com>
In-Reply-To: <20190520083601.GE1887@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7de330c8-b2f9-4f0c-566a-08d6dd07eeee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB1832;
x-ms-traffictypediagnostic: OSBPR01MB1832:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <OSBPR01MB1832F11D57BD6861C5A6E689B8060@OSBPR01MB1832.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(396003)(136003)(376002)(51914003)(199004)(189003)(53936002)(2906002)(66066001)(7736002)(86362001)(305945005)(256004)(3846002)(186003)(26005)(6916009)(25786009)(6116002)(4326008)(74316002)(7416002)(66946007)(6246003)(66476007)(66556008)(76116006)(66446008)(64756008)(73956011)(81166006)(8676002)(81156014)(229853002)(33656002)(8936002)(316002)(6506007)(6436002)(966005)(71190400001)(76176011)(71200400001)(478600001)(6306002)(9686003)(54906003)(486006)(44832011)(102836004)(55016002)(68736007)(7696005)(99286004)(14454004)(52536014)(5660300002)(446003)(476003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1832;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M2DfjJcjOvAj1G2bcfYc5O71X9OD6RTGyNzrf5DRGPHrh/WjVADLv5os5ugnuNb6lZCm1uRBVnIVTCcopdEnnIUyq8dJceis681i4g4GekgANxHW7Rf/W3seLugTY436DVC0tq4ZUl2psPVoyGSdedb6nfVzKaUC4NOHdqYvL44sWR+JyHmmY053FJM9HcKnsfkEVEmSjf2OwLmjf0u0/I/F3l7i8q0jasgvU1naSzfm+YGJDdxMzCxGCg6ckkZ9h2J+//zcktGu/x2E9Ch7+PdW0BeWtb8G/Pf7kOZte13XRbq5lM3WqCBN8Viw4ZSBLER8eAsRrbWoSwc2Fn6dCeReYGHaqGPXoY5BZglmGPHKgCqw4OUrfJr5xFtclkdHjwGXG7q5Fm2lieRvuKie4nvTjKc4M4p8d4H2geaktyQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de330c8-b2f9-4f0c-566a-08d6dd07eeee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 09:45:46.1271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Heikki,

Thanks for the feedback.

> Subject: Re: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
> node
>=20
> On Mon, May 20, 2019 at 08:06:41AM +0000, Biju Das wrote:
> > Hi Heikki,
> >
> > > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get
> > > usb_role_switch by node
> > >
> > > On Mon, May 20, 2019 at 10:39:11AM +0800, Chunfeng Yun wrote:
> > > > Hi,
> > > > On Fri, 2019-05-17 at 16:05 +0300, Heikki Krogerus wrote:
> > > > > Hi,
> > > > >
> > > > > On Fri, May 17, 2019 at 01:37:36PM +0300, Heikki Krogerus wrote:
> > > > > > On Tue, May 14, 2019 at 04:47:21PM +0800, Chunfeng Yun wrote:
> > > > > > > Add fwnode_usb_role_switch_get() to make easier to get
> > > > > > > usb_role_switch by fwnode which register it.
> > > > > > > It's useful when there is not device_connection registered
> > > > > > > between two drivers and only knows the fwnode which register
> > > > > > > usb_role_switch.
> > > > > > >
> > > > > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > > > Tested-by: Biju Das <biju.das@bp.renesas.com>
> > > > > >
> > > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > >
> > > > > Hold on. I just noticed Rob's comment on patch 2/6, where he
> > > > > points out that you don't need to use device graph since the
> > > > > controller is the parent of the connector. Doesn't that mean you
> > > > > don't really need this API?
> > > > No, I still need it.
> > > > The change is about the way how to get fwnode; when use device
> > > > graph, get fwnode by of_graph_get_remote_node(); but now will get
> > > > fwnode by of_get_parent();
> > >
> > > OK, I get that, but I'm still not convinced about if something like
> > > this function is needed at all. I also have concerns regarding how
> > > you are using the function. I'll explain in comment to the patch 5/6 =
in this
> series...
> >
> > FYI, Currently  I am also using this api in my patch series.
> > https://patchwork.kernel.org/patch/10944637/
>=20
> Yes, and I have the same question for you I jusb asked in comment I added
> to the patch 5/6 of this series. Why isn't usb_role_switch_get() enough?

Currently no issue. It will work with this api as well, since the port node=
 is part of controller node.
For eg:-
https://patchwork.kernel.org/patch/10944627/

However if any one adds port node inside the connector node, then this api =
may won't work as expected.
Currently I get below error

[    2.299703] OF: graph: no port node found in /soc/i2c@e6500000/hd3ss3220=
@47

For eg:-

	hd3ss3220@47 {
		compatible =3D "ti,hd3ss3220";
		...
		....
		usb_con: connector {
                                     ....
                                     ....
			port {
				hd3ss3220_ep: endpoint@0 {
					reg =3D <0>;
					remote-endpoint =3D <&usb3peri_role_switch>;
				};
			};
		};
	};

Regards,
Biju
