Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB82C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC0A21841
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OYsAFpLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfEJDKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:10:23 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:24128
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbfEJDKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8Y3QgABfP06p59es7kVtXgn8vBgPaMrJjlSyWV7kRU=;
 b=OYsAFpLyOm+IBBIMynj2dy5OBAL4wipa7nFKJoeaUXomYQke58tT67Aeb380T6rSLIYZfFKVb/J3+U7vZiPjQ1Bzi4LrPVEn0soBV9bjdymqISG0q0mvogeAuKwcUnvBwAbYxL4KmS+gXxxqBVWU1vx3zi32VPNAUHnvYa5gZ7U=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5231.eurprd04.prod.outlook.com (20.177.51.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 10 May 2019 03:10:17 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::4923:8ad8:62c1:3e61]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::4923:8ad8:62c1:3e61%5]) with mapi id 15.20.1878.019; Fri, 10 May 2019
 03:10:17 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: RE: [PATCH v3] usb: core: verify devicetree nodes for USB devices
Thread-Topic: [PATCH v3] usb: core: verify devicetree nodes for USB devices
Thread-Index: AQHVBkP6yfsjDnSxCk69+l82SkgDJqZjJOxsgACHhqA=
Date:   Fri, 10 May 2019 03:10:17 +0000
Message-ID: <VI1PR04MB5327AD56CA772284DFE663D08B0C0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
        <20190509084726.5405-1-m.szyprowski@samsung.com> <yw1xlfzfv4ol.fsf@mansr.com>
In-Reply-To: <yw1xlfzfv4ol.fsf@mansr.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fa2cdba-fce1-431d-491e-08d6d4f5077c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5231;
x-ms-traffictypediagnostic: VI1PR04MB5231:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB52317E11BFCBF16C7430F5018B0C0@VI1PR04MB5231.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(45080400002)(8936002)(15650500001)(2906002)(86362001)(5024004)(4326008)(99286004)(74316002)(33656002)(14444005)(76176011)(110136005)(7696005)(102836004)(6436002)(81166006)(8676002)(54906003)(81156014)(478600001)(7736002)(14454004)(305945005)(966005)(6506007)(186003)(9686003)(26005)(316002)(11346002)(446003)(53936002)(229853002)(476003)(6306002)(486006)(44832011)(3846002)(6116002)(66066001)(25786009)(5660300002)(6246003)(68736007)(256004)(55016002)(73956011)(76116006)(66946007)(66574012)(52536014)(66446008)(64756008)(66476007)(66556008)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5231;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lsud/UgQxOvJJwo4ryfDwTnwtD3FmmBrduNtGj79LQqEdWAitNcEnTI3UAIpv2N1C1/5Haf/vn23I6iEfA30e/7co4cFgk4NMpNrTyiwwEdmgEP7vDNbnPHUrmODPwbHlDgJNPkwzcMo9dt7rnaUJexfGtUo5CHv2APQW0jxsEnO8keyl1vrFyChC97We2oqDuUDm7ofuRGhgR8ulig+G5pyUpvuxEEqnT0kHOn7tD8O/svbF0XSAi0OzkGrRQFCt/7KK2Ri+8RNxP3vtA6BMEba9GQ+ceBIZ3kg+jIoi3moMLt1S5J2y6LhwqL4SDxr/qIG3S00EKWDO4HcnN8rf033WYzY0qKU6athk6lFq84g1BSZ5iCv0JC/Rfijn02l4bRjV4w+r6R6tTmGKKJFofUQzb6jCWLmBhU7NiU+arM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa2cdba-fce1-431d-491e-08d6d4f5077c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 03:10:17.6114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>=20
> > Commit 69bec7259853 ("USB: core: let USB device know device node")
> > added support for attaching devicetree node for USB devices. The
> > mentioned commit however identifies the given USB device node only by t=
he 'reg'
> > property in the host controller children nodes. The USB device node
> > however also has to have a 'compatible' property as described in
> > Documentation/devicetree/bindings/usb/usb-device.txt. Lack for the
> > 'compatible' property check might result in assigning a devicetree
> > node, which is not intended to be the proper node for the given USB dev=
ice.
> >
> > This is important especially when USB host controller has child-nodes
> > for other purposes. For example, Exynos EHCI and OHCI drivers already
> > define child-nodes for each physical root hub port and assigns
> > respective PHY controller and parameters for them. Those binding
> > predates support for USB devicetree nodes.
> >
> > Checking for the proper compatibility string allows to mitigate the
> > conflict between USB device devicetree nodes and the bindings for USB
> > controllers with child nodes. It also fixes the side-effect of the
> > other commits, like 01fdf179f4b0 ("usb: core: skip interfaces disabled
> > in devicetree"), which incorrectly disables some devices on Exynos
> > based boards.
> >

Hi Marek,

The purpose of your patch is do not set of_node for device under USB contro=
ller, right?
I do not understand how 01fdf179f4b0 affect your boards, some nodes under
the USB controller with status is not "okay", but still want to be enumerat=
ed?

Peter

> > Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> > v3:
> > - replaced ad hoc checks by proper test for proper value of the
> >   compatible string in drivers/usb/core/of.c
> > v2:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l
> > .org%2Flkml%2F2019%2F5%2F8%2F321&amp;data=3D02%7C01%7Cpeter.chen%
> 40nxp.c
> >
> om%7Cd9336abb14a745fb152508d6d4afdbb5%7C686ea1d3bc2b4c6fa92cd99c5c3
> 016
> >
> 35%7C0%7C0%7C636930249105615889&amp;sdata=3DCIC09rcvf%2FFp5y6oRQtJ
> Hk%2Bb
> > k7QjvJHECpK36LT8ocU%3D&amp;reserved=3D0
> > v1:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l
> > .org%2Flkml%2F2019%2F5%2F7%2F715&amp;data=3D02%7C01%7Cpeter.chen%
> 40nxp.c
> >
> om%7Cd9336abb14a745fb152508d6d4afdbb5%7C686ea1d3bc2b4c6fa92cd99c5c3
> 016
> >
> 35%7C0%7C0%7C636930249105625893&amp;sdata=3DRbbKufAqSKRZpY726zWne
> 9cDhlK0
> > mlkBghhOmkqelY8%3D&amp;reserved=3D0
> > ---
> >  drivers/usb/core/hub.c |  3 +++
> >  drivers/usb/core/of.c  | 31 +++++++++++++++++++++++++++++++
> > include/linux/usb/of.h |  2 ++
> >  3 files changed, 36 insertions(+)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index
> > 2f94568ba385..6f2438522d09 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/usb.h>
> >  #include <linux/usbdevice_fs.h>
> >  #include <linux/usb/hcd.h>
> > +#include <linux/usb/of.h>
> >  #include <linux/usb/otg.h>
> >  #include <linux/usb/quirks.h>
> >  #include <linux/workqueue.h>
> > @@ -5023,6 +5024,8 @@ static void hub_port_connect(struct usb_hub *hub,=
 int
> port1, u16 portstatus,
> >  		if (status < 0)
> >  			goto loop;
> >
> > +		usb_of_validate_device_node(udev);
> > +
> >  		if (udev->quirks & USB_QUIRK_DELAY_INIT)
> >  			msleep(2000);
> >
> > diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c index
> > 651708d8c908..2b6f16753edc 100644
> > --- a/drivers/usb/core/of.c
> > +++ b/drivers/usb/core/of.c
> > @@ -30,6 +30,12 @@ struct device_node *usb_of_get_device_node(struct
> usb_device *hub, int port1)
> >  	for_each_child_of_node(hub->dev.of_node, node) {
> >  		if (of_property_read_u32(node, "reg", &reg))
> >  			continue;
> > +		/*
> > +		 * idVendor and idProduct are not yet known, so check only
> > +		 * a presence of the compatible property.
> > +		 */
>=20
> This function could be called from anywhere, so that comment seems a bit
> misplaced.
>=20
> > +		if (!of_find_property(node, "compatible", NULL))
> > +			continue;
>=20
> What if there is a node with a "compatible" property for some entirely di=
fferent
> purpose?  Since that won't be caught, why bother with this test at all?
>=20
> >  		if (reg =3D=3D port1)
> >  			return node;
> > @@ -39,6 +45,31 @@ struct device_node *usb_of_get_device_node(struct
> > usb_device *hub, int port1)  }
> > EXPORT_SYMBOL_GPL(usb_of_get_device_node);
> >
> > +/**
> > + * usb_of_validate_device_node() - validate dt node of the probed USB
> > +device
> > + * @udev: USB device
> > + *
> > + * Validate devicetree node for the USB device. Compatible string
> > +must match
> > + * device's idVendor and idProduct, otherwise the of_node will be put
> > +and set
> > + * to NULL.
> > + */
> > +void usb_of_validate_device_node(struct usb_device *udev) {
> > +	char compatible[13];
> > +
> > +	if (!udev->dev.of_node)
> > +		return;
> > +
> > +	snprintf(compatible, sizeof(compatible), "usb%x,%x",
> > +		 le16_to_cpu(udev->descriptor.idVendor),
> > +		 le16_to_cpu(udev->descriptor.idProduct));
> > +
> > +	if (of_device_is_compatible(udev->dev.of_node, compatible) =3D=3D 0) =
{
> > +		of_node_put(udev->dev.of_node);
> > +		udev->dev.of_node =3D NULL;
> > +	}
> > +}
> > +
> >  /**
> >   * usb_of_has_combined_node() - determine whether a device has a combi=
ned
> node
> >   * @udev: USB device
> > diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h index
> > dba55ccb9b53..9969efda03ad 100644
> > --- a/include/linux/usb/of.h
> > +++ b/include/linux/usb/of.h
> > @@ -24,6 +24,7 @@ bool usb_of_has_combined_node(struct usb_device
> > *udev);  struct device_node *usb_of_get_interface_node(struct usb_devic=
e *udev,
> >  		u8 config, u8 ifnum);
> >  struct device *usb_of_get_companion_dev(struct device *dev);
> > +void usb_of_validate_device_node(struct usb_device *udev);
> >  #else
> >  static inline enum usb_dr_mode
> >  of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0) @@ -57,6
> > +58,7 @@ static inline struct device *usb_of_get_companion_dev(struct
> > device *dev)  {
> >  	return NULL;
> >  }
> > +static inline void usb_of_validate_device_node(struct usb_device
> > +*udev) { }
> >  #endif
> >
> >  #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)
> > --
> > 2.17.1
> >
>=20
> --
> M=E5ns Rullg=E5rd
