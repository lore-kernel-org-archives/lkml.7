Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F3FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0974206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBVsMat1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfJHG5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:57:22 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:49797
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730054AbfJHG5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:57:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/Qo6rYhvYxRItP2LV9UZoe8ulMpg5paK39ITeewmLqmApCajtrwyxHGTIz4BtauqsPyWJrgLA/QqRGmKGrOIn6DWil+/BJY2YclK74rbEEr8nC8ND3w5eSmEuVwzAa/StYYRxnd4xpsDtCz6YuhtObY9GwGD2n6d8Olo1jlfmmm1l8/hDXao2raVWpmTX5i3WU7qh7U6A4vhXfpjPvHE6Cy0JGS9ls3P9naDC4ACNGvkNpC1UyR62xSPdDg9RXMwIQ0Cc+cMmcHYgE7HuAnCBfW7Q7aG8JFTIMs0A3sRXtMuemLluAV8Ne2SNjvUuC8lyl59plWC7/W9M1T5k4yJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq+pEZGTYmVcSuP7ZPH4f6e7WCPtfkRQq8jmGk6zyao=;
 b=i4j9ESFzMXdc82SagB3J3MFic2B1NRCkI00wt3rXYZChVHqkf9HWh/kKyq+jqoMSwlrwlnOsNNSbfz6yXoaPABjFbXAkpfjgxtBnb8MzvyA7s1HzHyfYpnrCSGOsv9f/FFrC50WWS9AB0gE7HCWmBb2YsxRYJCPve61/XyrX2ilUPQI+dhwz/u079t5bUnrQtnfFZURC1EYc7g/ZorABi0xrrtG5eXjNmpfj3prPm4s9iM46eTpL32xEvk68+alZG8hABhjKsooAZX6gSgip86j5K9Ho/X3KGaqurjSOzY7SvPhjUIAtGbrje3bTaU7ESSsS+ffZkxNIAyEhl72FYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq+pEZGTYmVcSuP7ZPH4f6e7WCPtfkRQq8jmGk6zyao=;
 b=CBVsMat1l60KLZ1msCCrysA/s8ZsFaSks8mVukVOfChWFfqIPNR9SvCtRy2nQ1uHbZ16awNb0I/glaRmUy4kKiwE4Ki0IvTNpj4xC7W0bl8xaj9UMTwZHBOccr6PKlG+G3mif8FaJalkrI3kng7cdZF0HVPxBRxFQ39bfGERbR8=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB6111.eurprd04.prod.outlook.com (20.179.26.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Tue, 8 Oct 2019 06:56:35 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0%3]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 06:56:35 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "sureshp@cadence.com" <sureshp@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: Re: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Topic: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Index: AQHVfNoJ++ECtmBATUSOETiOVkdrz6dQUUWA
Date:   Tue, 8 Oct 2019 06:56:35 +0000
Message-ID: <20191008065619.GE5670@b29397-desktop>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com>
In-Reply-To: <1570430355-26118-1-git-send-email-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 426f1bf0-91f7-44d1-8172-08d74bbca8d0
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB6111:
x-microsoft-antispam-prvs: <VI1PR04MB6111DDEB595C99D52DF376338B9A0@VI1PR04MB6111.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(66446008)(66556008)(64756008)(66946007)(9686003)(66476007)(7416002)(6486002)(71200400001)(71190400001)(229853002)(256004)(14444005)(6436002)(3846002)(6116002)(14454004)(66066001)(33716001)(1076003)(2906002)(4326008)(76116006)(91956017)(6512007)(6246003)(25786009)(86362001)(8676002)(476003)(8936002)(7736002)(486006)(5660300002)(478600001)(81166006)(305945005)(81156014)(53546011)(26005)(54906003)(102836004)(76176011)(316002)(44832011)(33656002)(99286004)(6916009)(11346002)(6506007)(446003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6111;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPAchDMx6+YAJ2TAYESvrrCV2Vr83NRWBn91O5bct3gHDU8SBtLAMmEpKmuibQpgyWEHMEl8g1pKosk+ToT4NIFReY/kBMPnjnW5aQmy2YXY6CjYB36GPUC6M4QiPwd0J3H927BYh15oWFlqEF2gWUpE+Ojg2s0TKodwS5nyxBboNctxzgqbg1ppk4u6X5CharzNHgulha/JQSRm7ajtxg9Nm/SmnQ0O5fm5pxH0EgaTDZQZVlHZmMc6Y7NvZzZ1U0T6Tdtm0fh9CX1BNojzVzB5VO26eNfhVU+Dmzxo1Iu9t9MGdE5DLzU6biqiHEymF1ZfG76wG3RSB9ExDKBsYj55JWM7DL8FmToNc0SHf8I+SJTDWFymhcTRisfhI0w7+Sl33N4jm2Nu9ayzc2m4vC17djec8Yf5FVmcvqxqBW0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <043D2AB33E221341AD0E955B526A6868@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426f1bf0-91f7-44d1-8172-08d74bbca8d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 06:56:35.3296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8MX272n752cX4k51dpi755l9rfVdCFFKZHJePgPKokAkoy5GXjLTIWvAdik6hJ2Htp++XMFYKkYEftn28EeoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-07 07:39:11, Pawel Laszczak wrote:
> Patch fixes issue with Halt Endnpoint Test observed

%s/Endnpoint/Endpoint

>
> during using g_zero
> driver as DUT. Bug occurred only on some testing board.

g_zero is legacy, please use configfs function source_sink or loopback
instead.

>=20
> Endpoint can defer transition to Halted state if endpoint has pending
> requests.

The implementation of halt handling is a little complicated, you may
consider return -EAGAIN for functional stall through usb_ep_set_halt
from function driver if the requests are pending, it doesn't need to
defer such kinds of functional stall.

Peter
> Patch add additional condition that allows to return correct endpoint
> status during Get Endpoint Status request even if the halting endpoint
> is in progress.
>=20
> Reported-by: Rahul Kumar <kurahul@cadence.com>
> Signed-off-by: Rahul Kumar <kurahul@cadence.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> ---
>  drivers/usb/cdns3/ep0.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> index 44f652e8b5a2..10ae03430f34 100644
> --- a/drivers/usb/cdns3/ep0.c
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -234,9 +234,11 @@ static int cdns3_req_ep0_set_address(struct cdns3_de=
vice *priv_dev,
>  static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
>  				    struct usb_ctrlrequest *ctrl)
>  {
> +	struct cdns3_endpoint *priv_ep;
>  	__le16 *response_pkt;
>  	u16 usb_status =3D 0;
>  	u32 recip;
> +	u8 index;
> =20
>  	recip =3D ctrl->bRequestType & USB_RECIP_MASK;
> =20
> @@ -262,9 +264,13 @@ static int cdns3_req_ep0_get_status(struct cdns3_dev=
ice *priv_dev,
>  	case USB_RECIP_INTERFACE:
>  		return cdns3_ep0_delegate_req(priv_dev, ctrl);
>  	case USB_RECIP_ENDPOINT:
> -		/* check if endpoint is stalled */
> +		index =3D cdns3_ep_addr_to_index(ctrl->wIndex);
> +		priv_ep =3D priv_dev->eps[index];
> +
> +		/* check if endpoint is stalled or stall is pending */
>  		cdns3_select_ep(priv_dev, ctrl->wIndex);
> -		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
> +		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)) ||
> +		    (priv_ep->flags & EP_STALL_PENDING))
>  			usb_status =3D  BIT(USB_ENDPOINT_HALT);
>  		break;
>  	default:
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
