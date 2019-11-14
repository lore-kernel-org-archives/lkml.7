Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCA1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE99C206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1PBQSWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNCur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 21:50:47 -0500
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:63165
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfKNCur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 21:50:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emjJTmVxUyFW/q+NYcQoT1nM82joSM1EO2GeVraPAytMXlDdAZ/u/jv5Cu1zywPflpLYme91likQUuIkcT9OUrowxsfAj2XqNoGMX7ydrIVgo2MveDoUsgy8tCt1VQtIQGPcTxkL9xv0jR4/ahl7Dj+eqcVJroHGE/puyJGdRFahg3S9xgt4/4asv6hQMJg6EiAos1JYYa57kFZmb0ltVw5mu8RQSpFIKZcXPvmMj3mpGnx3RDvu3m2WyuMLHifShWnl9KJIiaSf0TwnnMXb5eHRf9ZRC1O/H22ME/edbv6c4gtXXMAMUJ47WLAIAT3ljZK2rPGx6WAiU5VUOEH0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46dSJdgSc73LCoiqjYO+oU+Ner1rz/rxk3X6fd5QJtk=;
 b=m0f4IWqvtg07aXO/bzdLrhqUiV2AD1hFS0TU8EhO9WgQIozt7bnamgQdGizak7XdNFBthtMwTKoY5i2k2quQMXg0bNoiKFuOwHYGONCxf3Zp7/b07Bkl34MI4aIwnJUuVngX3v6T4IOHxczlnmJqbT7I4cWu5g4mINbLR8zfN/r+kE0rPieITrtrrcL0B7f4Hgr1i+q2ylAqTdVh0koieaPLsPwa7FkhOlyETapDkZP98XEY36p2cf6iOhR0q2H03/GvsHjHL5p9sJCx6JNu/Ht0ylcib9rtUVaOCOUKJ7ObFVLHQmKgOUBaS/XtH34rd7wuu91GaxlmaQeGPr5bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46dSJdgSc73LCoiqjYO+oU+Ner1rz/rxk3X6fd5QJtk=;
 b=d1PBQSWFOrdFkMSFyVqmo01OGx4J8IX0XV6df08F7QmBINemuwRJ8B2Aq9A6D8wLAm0fNqKo/TR9ZG8Uv+/RoNdkt9ohA7rjZH+A7EpG61bZ6HIJ3IMCrp4uhFMpO0xZpybQrBYYQk0ePHdCYwfU7usvQcPWCnpmJHFu38k9ph8=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB3136.eurprd04.prod.outlook.com (10.170.232.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Thu, 14 Nov 2019 02:50:42 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2451.027; Thu, 14 Nov 2019
 02:50:42 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Jayshri Pawar <jpawar@cadence.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [RFC PATCH] usb: gadget: f_tcm: Added DMA32 flag while allocation
 of command buffer
Thread-Topic: [RFC PATCH] usb: gadget: f_tcm: Added DMA32 flag while
 allocation of command buffer
Thread-Index: AQHVmgy0AO3oXPQWj0iIFuuXV9ypwqeJ+SiA
Date:   Thu, 14 Nov 2019 02:50:42 +0000
Message-ID: <20191114025301.GD30608@b29397-desktop>
References: <1573640672-10344-1-git-send-email-jpawar@cadence.com>
In-Reply-To: <1573640672-10344-1-git-send-email-jpawar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff39c9c4-e41c-42fc-abc8-08d768ad70bc
x-ms-traffictypediagnostic: VI1PR04MB3136:
x-microsoft-antispam-prvs: <VI1PR04MB3136F9095EAB717DEB2ECABE8B710@VI1PR04MB3136.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(54906003)(6512007)(86362001)(81156014)(7416002)(11346002)(14454004)(486006)(9686003)(7736002)(305945005)(44832011)(476003)(99286004)(66446008)(66556008)(6436002)(64756008)(6246003)(66476007)(33716001)(5660300002)(33656002)(229853002)(446003)(6486002)(102836004)(478600001)(186003)(2906002)(26005)(14444005)(256004)(76176011)(8936002)(3846002)(25786009)(53546011)(6506007)(81166006)(1076003)(71190400001)(66946007)(76116006)(91956017)(4326008)(6116002)(66066001)(316002)(8676002)(71200400001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3136;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0tTefQ9Io9HPdu6zNUg10pPkeUpBYU9L6GaQg5Qz7I1QVKGcbWxP96dUcKvYqz0r9alv3TA+VTtc03HX1cIfiOp6/91kSZOykkQDfR0gTHTPhpNaioMIpI+LZeHZT2QR5JQWYJD/DKLKBVEaMpgf98Z9xJRAPbbVpwq5LpYpWqjHzTWnwvpVhPHC7IzOZjSdqXnorWaLAMMTrw2tCyyaly00cGV7JHz6L4ADM73a76utlFTEYEASxNpjPlo8JKDtFZBrGwYr/RNPUYPJC2TFcm4+4xQm6oaNamqKro71HdDfZRrdI8uSatQ5cY0xXs7WdqZ3LyZO5G1KEhFbCd/8MtrjK9SRu15CTXoLmojVBQCXAS8cgJoDYHlvNJx5/ZBWSQ1dWr7FYiIaoN0i98eZCg1tMl+CXsp/KcmtFcL5pgjYOzX0tQLqj75Iw6AeoINH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2847D8F2DDA6614D8543E182FA1CA2D5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff39c9c4-e41c-42fc-abc8-08d768ad70bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 02:50:42.5238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bW5ptDj79JzNEbyBrzjvWnzxUsSxtxudOgHvzaJphLyz/BxKRi16skMjPv1+wqHjSSfy6w0D1mQ6lCa6Br4Tnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-13 10:24:32, Jayshri Pawar wrote:
> There is a problem when function driver allocate memory for buffer
> used by DMA from outside dma_mask space.
> It appears during testing f_tcm driver with cdns3 controller.
> In the result cdns3 driver was not able to map virtual buffer to DMA.
> This fix should be improved depending on dma_mask associated with device.
> Adding GFP_DMA32 flag while allocationg command data buffer only for 32
> bit controllers.

Hi Jayshri,

This issue should be fixed by setting DMA_MASK correctly for controller,
you can't limit user's memory region. At usb_ep_queue, the UDC driver
will call DMA MAP API, for Cadence, it is usb_gadget_map_request_by_dev.=20
For the system without SMMU (IO-MMU), it will use swiotlb to make sure
the data buffer used for DMA transfer is within DMA mask for controller,
There is a reserved low memory region for debounce buffer in swiotlb=20
use case.

Peter

>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> ---
>  drivers/usb/gadget/function/f_tcm.c | 20 ++++++++++++++------
>  include/linux/usb/gadget.h          |  2 ++
>  2 files changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/fun=
ction/f_tcm.c
> index 36504931b2d1..a78d5fad3d84 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -213,7 +213,8 @@ static int bot_send_read_response(struct usbg_cmd *cm=
d)
>  	}
> =20
>  	if (!gadget->sg_supported) {
> -		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_ATOMIC);
> +		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_ATOMIC |
> +					gadget->dma_flag);
>  		if (!cmd->data_buf)
>  			return -ENOMEM;
> =20
> @@ -257,7 +258,8 @@ static int bot_send_write_request(struct usbg_cmd *cm=
d)
>  	}
> =20
>  	if (!gadget->sg_supported) {
> -		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_KERNEL);
> +		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_KERNEL |
> +					gadget->dma_flag);
>  		if (!cmd->data_buf)
>  			return -ENOMEM;
> =20
> @@ -305,6 +307,7 @@ static void bot_cmd_complete(struct usb_ep *ep, struc=
t usb_request *req)
>  static int bot_prepare_reqs(struct f_uas *fu)
>  {
>  	int ret;
> +	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
> =20
>  	fu->bot_req_in =3D usb_ep_alloc_request(fu->ep_in, GFP_KERNEL);
>  	if (!fu->bot_req_in)
> @@ -327,7 +330,8 @@ static int bot_prepare_reqs(struct f_uas *fu)
>  	fu->bot_status.req->complete =3D bot_status_complete;
>  	fu->bot_status.csw.Signature =3D cpu_to_le32(US_BULK_CS_SIGN);
> =20
> -	fu->cmd.buf =3D kmalloc(fu->ep_out->maxpacket, GFP_KERNEL);
> +	fu->cmd.buf =3D kmalloc(fu->ep_out->maxpacket, GFP_KERNEL |
> +				gadget->dma_flag);
>  	if (!fu->cmd.buf)
>  		goto err_buf;
> =20
> @@ -515,7 +519,8 @@ static int uasp_prepare_r_request(struct usbg_cmd *cm=
d)
>  	struct uas_stream *stream =3D cmd->stream;
> =20
>  	if (!gadget->sg_supported) {
> -		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_ATOMIC);
> +		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_ATOMIC |
> +					gadget->dma_flag);
>  		if (!cmd->data_buf)
>  			return -ENOMEM;
> =20
> @@ -763,11 +768,13 @@ static int uasp_alloc_stream_res(struct f_uas *fu, =
struct uas_stream *stream)
> =20
>  static int uasp_alloc_cmd(struct f_uas *fu)
>  {
> +	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
>  	fu->cmd.req =3D usb_ep_alloc_request(fu->ep_cmd, GFP_KERNEL);
>  	if (!fu->cmd.req)
>  		goto err;
> =20
> -	fu->cmd.buf =3D kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL);
> +	fu->cmd.buf =3D kmalloc(fu->ep_cmd->maxpacket, GFP_KERNEL |
> +				gadget->dma_flag);
>  	if (!fu->cmd.buf)
>  		goto err_buf;
> =20
> @@ -980,7 +987,8 @@ static int usbg_prepare_w_request(struct usbg_cmd *cm=
d, struct usb_request *req)
>  	struct usb_gadget *gadget =3D fuas_to_gadget(fu);
> =20
>  	if (!gadget->sg_supported) {
> -		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_ATOMIC);
> +		cmd->data_buf =3D kmalloc(se_cmd->data_length, GFP_ATOMIC |
> +					gadget->dma_flag);
>  		if (!cmd->data_buf)
>  			return -ENOMEM;
> =20
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 124462d65eac..d6c9cd222600 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -373,6 +373,7 @@ struct usb_gadget_ops {
>   * @connected: True if gadget is connected.
>   * @lpm_capable: If the gadget max_speed is FULL or HIGH, this flag
>   *	indicates that it supports LPM as per the LPM ECN & errata.
> + * @dma_flag: dma zone to be used for buffer allocation.
>   *
>   * Gadgets have a mostly-portable "gadget driver" implementing device
>   * functions, handling all usb configurations and interfaces.  Gadget
> @@ -427,6 +428,7 @@ struct usb_gadget {
>  	unsigned			deactivated:1;
>  	unsigned			connected:1;
>  	unsigned			lpm_capable:1;
> +	unsigned int			dma_flag;
>  };
>  #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
> =20
> --=20
> 2.20.1
>=20

--=20

Thanks,
Peter Chen=
