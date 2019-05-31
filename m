Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A82C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B686B26515
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="UuI8pqta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfEaHlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:41:03 -0400
Received: from mail-eopbgr1410120.outbound.protection.outlook.com ([40.107.141.120]:43006
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbfEaHlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JJfhjlChlsZblk494lEolIoahzYewRVgkt13gf0nWw=;
 b=UuI8pqtaJug4kV9Uu/Oe/3rLCLNq7eiMY4k8vSVqL0yp2kn34OWbUyLri+F2I67YD2C4f6rdN6cRVi8PV4IZYEmMEzal8QtuafREC+3xfKedXeVm8UctCJCkwGFCbMP7wyNhtsYCeJXNji0p1CpPACp6jokK826sebNkCYGVx9w=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
 OSBPR01MB3159.jpnprd01.prod.outlook.com (52.134.253.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Fri, 31 May 2019 07:40:52 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::a146:39f0:5df9:11bc]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::a146:39f0:5df9:11bc%7]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 07:40:52 +0000
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
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Subject: RE: [PATCH v6 06/10] device connection: Add
 fwnode_connection_find_match()
Thread-Topic: [PATCH v6 06/10] device connection: Add
 fwnode_connection_find_match()
Thread-Index: AQHVFfJUqUbU7Icg8UiVJq3QJgY4TaaE3Adg
Date:   Fri, 31 May 2019 07:40:52 +0000
Message-ID: <OSBPR01MB2103EAE24D36E23BFE8A76A5B8190@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
 <1559115828-19146-7-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1559115828-19146-7-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e226b5ac-0d7b-4e75-1332-08d6e59b4f1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB3159;
x-ms-traffictypediagnostic: OSBPR01MB3159:
x-microsoft-antispam-prvs: <OSBPR01MB31591D0E63212706D3957FACB8190@OSBPR01MB3159.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(51914003)(305945005)(53936002)(33656002)(110136005)(99286004)(5660300002)(256004)(14444005)(76176011)(4326008)(25786009)(68736007)(6116002)(2906002)(7736002)(6246003)(86362001)(7696005)(74316002)(71200400001)(11346002)(71190400001)(7416002)(476003)(3846002)(54906003)(52536014)(9686003)(66066001)(55016002)(186003)(76116006)(26005)(14454004)(102836004)(64756008)(66946007)(44832011)(229853002)(81156014)(73956011)(6436002)(478600001)(6506007)(316002)(446003)(66556008)(8936002)(66476007)(66446008)(486006)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3159;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9ve87iDhwS2Bv2t20CDXq8Lmym3IMLYLmUYuFGiVVhZDrG3GENrS7SgY7pnqrMT3/ZjRVbEDCvmoBaeUENs63lIDw7TKlli4dQ7R8gQO93Q6o1BwEbKkPZM4h+oLnAMB82hoB/8raodlNKKedS6veSvDqegQgbePg6vWFbZXkXSa9O8BxoX3oXr1s+DRjOdGTqj8Y7VW4xCSR2W022adb0g3eFiekoRIPHBAPCc0C92EpbxZgaO2qCnAO559QZESckJFltNM0dkP7Q9tY30XufQO5DiPAvOmuKCf+sCgSKbgMmx36D2CGLm+dKZ6ci/wfdOZa0PUuN3dIMhDzXmpwikBSw1No7LOGoAWbuMpfryrYXjOJdV1NKNRw0bK2z3zK8+jJuKVgqutNW0ICFaVTvV5+LLsk73NkjCaiMEtB9k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e226b5ac-0d7b-4e75-1332-08d6e59b4f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 07:40:52.6808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biju.das@bp.renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch

> Subject: [PATCH v6 06/10] device connection: Add
> fwnode_connection_find_match()
>=20
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>=20
> The fwnode_connection_find_match() function is exactly the same as
> device_connection_find_match(), except it takes struct fwnode_handle as
> parameter instead of struct device.
> That allows locating device connections before the device entries have be=
en
> created.
>=20
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Biju Das <biju.das@bp.renesas.com>
> ---
> v6:
>   new patch
> ---
>  drivers/base/devcon.c  | 33 +++++++++++++++++++++++++--------
> include/linux/device.h | 10 +++++++---
>  2 files changed, 32 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c index
> 04db9ae235e4..8311b70bbca2 100644
> --- a/drivers/base/devcon.c
> +++ b/drivers/base/devcon.c
> @@ -12,9 +12,6 @@
>  static DEFINE_MUTEX(devcon_lock);
>  static LIST_HEAD(devcon_list);
>=20
> -typedef void *(*devcon_match_fn_t)(struct device_connection *con, int
> ep,
> -				   void *data);
> -
>  static void *
>  fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char
> *con_id,
>  			  void *data, devcon_match_fn_t match) @@ -38,6
> +35,28 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode,
> const char *con_id,
>  	return NULL;
>  }
>=20
> +/**
> + * fwnode_connection_find_match - Find connection from a device node
> + * @fwnode: Device node with the connection
> + * @con_id: Identifier for the connection
> + * @data: Data for the match function
> + * @match: Function to check and convert the connection description
> + *
> + * Find a connection with unique identifier @con_id between @fwnode and
> +another
> + * device node. @match will be used to convert the connection
> +description to
> + * data the caller is expecting to be returned.
> + */
> +void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
> +				   const char *con_id, void *data,
> +				   devcon_match_fn_t match)
> +{
> +	if (!fwnode || !match)
> +		return NULL;
> +
> +	return fwnode_graph_devcon_match(fwnode, con_id, data, match);
> }
> +EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
> +
>  /**
>   * device_connection_find_match - Find physical connection to a device
>   * @dev: Device with the connection
> @@ -61,11 +80,9 @@ void *device_connection_find_match(struct device
> *dev, const char *con_id,
>  	if (!match)
>  		return NULL;
>=20
> -	if (fwnode) {
> -		ret =3D fwnode_graph_devcon_match(fwnode, con_id, data,
> match);
> -		if (ret)
> -			return ret;
> -	}
> +	ret =3D fwnode_connection_find_match(fwnode, con_id, data,
> match);
> +	if (ret)
> +		return ret;
>=20
>  	mutex_lock(&devcon_lock);
>=20
> diff --git a/include/linux/device.h b/include/linux/device.h index
> e85264fb6616..9445f068602f 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -772,10 +772,14 @@ struct device_connection {
>  	struct list_head	list;
>  };
>=20
> +typedef void *(*devcon_match_fn_t)(struct device_connection *con, int
> ep,
> +				   void *data);
> +
> +void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
> +				   const char *con_id, void *data,
> +				   devcon_match_fn_t match);
>  void *device_connection_find_match(struct device *dev, const char
> *con_id,
> -				void *data,
> -				void *(*match)(struct device_connection
> *con,
> -					       int ep, void *data));
> +				   void *data, devcon_match_fn_t match);
>=20
>  struct device *device_connection_find(struct device *dev, const char
> *con_id);
>=20
> --
> 2.21.0

