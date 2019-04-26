Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404EBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB1120652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="vCKRFrmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfDZHDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:03:09 -0400
Received: from mail-eopbgr1400138.outbound.protection.outlook.com ([40.107.140.138]:8881
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfDZHDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG7N6Jh9B4l5LKlnUjvZtDuc2QWNApI9gZDSp/H33z4=;
 b=vCKRFrmwUqNuEoJYwfCXSDgAUNCd2+wI6poQSwK0U6fFPGOWRsQipdiJsU2g+Y3eRcawxDcmA30+eAUcCJcXBS485IM3KEncPV6KnjkpuZls2uDOuKUV51LJROAr9yowV2CxsCuzwAPui1FUQFo1y4CvYxgYWIZIHjBUI+py6kQ=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB1861.jpnprd01.prod.outlook.com (52.134.226.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 26 Apr 2019 07:02:24 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::6d2c:bd11:88b0:c53a]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::6d2c:bd11:88b0:c53a%3]) with mapi id 15.20.1813.017; Fri, 26 Apr 2019
 07:02:24 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
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
Subject: RE: [PATCH v4 4/6] usb: roles: add API to get usb_role_switch by node
Thread-Topic: [PATCH v4 4/6] usb: roles: add API to get usb_role_switch by
 node
Thread-Index: AQHU+/v2hRuAN8EyF0KCHtKYHfPyNqZN/+Aw
Date:   Fri, 26 Apr 2019 07:02:24 +0000
Message-ID: <OSBPR01MB210350ED8C36423BBF4A8FDFB83E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com>
 <1556261237-13823-5-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1556261237-13823-5-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cfeb751-e449-4cb0-b727-08d6ca1522c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB1861;
x-ms-traffictypediagnostic: OSBPR01MB1861:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSBPR01MB18614F200B06D0D73F25F371B83E0@OSBPR01MB1861.jpnprd01.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(366004)(136003)(51914003)(199004)(189003)(74316002)(7736002)(305945005)(68736007)(97736004)(7416002)(256004)(2906002)(14454004)(6116002)(3846002)(33656002)(478600001)(966005)(8676002)(6506007)(26005)(76176011)(25786009)(44832011)(54906003)(229853002)(102836004)(110136005)(4326008)(6306002)(316002)(52536014)(76116006)(66946007)(6436002)(86362001)(73956011)(66066001)(446003)(8936002)(66476007)(66556008)(71190400001)(186003)(5660300002)(11346002)(81166006)(81156014)(486006)(476003)(9686003)(71200400001)(66446008)(64756008)(6246003)(55016002)(53936002)(99286004)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1861;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nDfkaFBjZ6B66X3YgFiLpoigGpncz5flR2lGE0fUyafKW18Wm/N97wEqd2InWP1d3rdz9g1DkKRS4pfnJYCpJFScvK8rBXMQIrIWx+nXyVbXgRovCfV8uFlG6Ut+1365E9VyUPJozJeghuBazr2dCxRQA1qWnsy5Hz8t1o+2WahEtOVkNXR0mbdspl2/igZzu2Ba9ZL3hn8UdN/LZFdtOalnaLFawj2ACYLOJEpGElAHl5Sz84GQrxenrsQ2mIKkw5h2HTI1Xnkk4out5SCgAy+eMBBjugyzoh6PZc8j3sruI8Q3taWp1N7SJDomFuok8nMSn9LyKcJeWemXXdgjk3rQmeuwjxNmNhxMN4BW6IDLptS9/dmgIry0Iooy3mIuqPuee72kfcQyLwsbrsdt6+D0H7rWe94ArFy2yQ8k8z0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfeb751-e449-4cb0-b727-08d6ca1522c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 07:02:24.4665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng Yun,

Thanks for the patch.

> Subject: [PATCH v4 4/6] usb: roles: add API to get usb_role_switch by nod=
e
>=20
> Add fwnode_usb_role_switch_get() to make easier to get usb_role_switch
> by fwnode which register it.
> It's useful when there is not device_connection registered between two
> drivers and only knows the fwnode which register usb_role_switch.
>=20
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Tested-by: Biju Das <biju.das@bp.renesas.com>
> ---
> v4 changes:
>   1. use switch_fwnode_match() to find fwnode suggested by Heikki
>   2. this patch now depends on [1]
>=20
>  [1] [v6,08/13] usb: roles: Introduce stubs for the exiting functions in =
role.h
>     https://patchwork.kernel.org/patch/10909971/
>=20
> v3 changes:
>   1. use fwnodes instead of node suggested by Andy
>   2. rebuild the API suggested by Heikki
>=20
> v2 no changes
> ---
>  drivers/usb/roles/class.c | 25 +++++++++++++++++++++++++
> include/linux/usb/role.h  |  8 ++++++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c index
> f45d8df5cfb8..994fcb979795 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -12,6 +12,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>

Is it required?

>  #include <linux/slab.h>
>=20
>  static struct class *role_class;
> @@ -135,6 +136,30 @@ struct usb_role_switch *usb_role_switch_get(struct
> device *dev)  }  EXPORT_SYMBOL_GPL(usb_role_switch_get);
>=20
> +/**
> + * fwnode_usb_role_switch_get - Find USB role switch by it's parent
> +fwnode
> + * @fwnode: The fwnode that register USB role switch
> + *
> + * Finds and returns role switch registered by @fwnode. The reference
> +count
> + * for the found switch is incremented.
> + */
> +struct usb_role_switch *
> +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode) {
> +	struct usb_role_switch *sw;
> +	struct device *dev;
> +
> +	dev =3D class_find_device(role_class, NULL, fwnode,
> switch_fwnode_match);
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	sw =3D to_role_switch(dev);
> +	WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
> +
> +	return sw;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_usb_role_switch_get);
> +
>  /**
>   * usb_role_switch_put - Release handle to a switch
>   * @sw: USB Role Switch
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h index
> da2b9641b877..35d460f9ec40 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -48,6 +48,8 @@ int usb_role_switch_set_role(struct usb_role_switch
> *sw, enum usb_role role);  enum usb_role usb_role_switch_get_role(struct
> usb_role_switch *sw);  struct usb_role_switch *c(struct
> device *dev);  void usb_role_switch_put(struct usb_role_switch *sw);
> +struct usb_role_switch *
> +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode);

>  struct usb_role_switch *
>  usb_role_switch_register(struct device *parent, @@ -72,6 +74,12 @@ stati=
c
> inline struct usb_role_switch *usb_role_switch_get(struct device *dev)
>=20
>  static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
>=20
> +static inline struct usb_role_switch *
> +fwnode_usb_role_switch_get(struct fwnode_handle *fwnode) {
> +	return ERR_PTR(-ENODEV);
> +}
> +

>  static inline struct usb_role_switch *
>  usb_role_switch_register(struct device *parent,
>  			 const struct usb_role_switch_desc *desc)
> --
> 2.21.0

