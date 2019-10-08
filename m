Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3401CC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F108C206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aEOIG6hX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfJHHe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:34:26 -0400
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:26757
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730144AbfJHHe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:34:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMdkyG43X1zOwJMZ+W4nn4+I0yK6SqF50MKcRSNIhHVATFBQn3TgdrGo8HJplvcEvAgo0znbrN+JuZIYLHGFaXcCxlRRnspV9z4slUtbov5ZMbJ5+JLG03eo8FAUisAluBkEHkaUZhfYL3Mmh+VoYr8eZ2b0FrWSuJDgRiMm5PYxjyl79sFvX75UucOMuHDpOzlH4w1ORFrGv2tLCf8+wDu7s/wprXTgssr9HlGdIWj1rEfaRrmR48rbIh9+NwuuNAQIavCM2Yi5XDocChiIpQSbklCz8wOGoMvFTJtx9j0VOOpY44oiLb5LMzLTtg4mB10SFKVVf0/EZo70ZF2Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uISVueN6vEZaFAyJdDBF+bDXKB9YMlzVsN8FK+6nbw=;
 b=ZFVDUyrX0QxSY3BxQQWZWYKPAulbHod1L2pTCkm4Hsc8+XsYj51A/B0kCqvO1tSDBCjU/23o0td2CJHBBKVXFkU4W6Fmonj5QVyIlAKhzmNyRVePqvlNCvmQOR7evGJJPNeeSMYqeHK8D4baYy5ZeYN8JgnFVfwRvjJIYZejsAnto3iBswm3cFF99j1d75QMPE3zVl05Sf46+Lh9LeoJU3IUjqRCU58CHaYXb4LX0v774Zt+BHIHuilXoXZdkSyAU3zTZwpZxEw/Z6HMNvsZuWGqdDJeaIw4aHBdeZIb1W+QDrOGP59yZ9r5DeAI8n0qyhrs7BrrxMaM+zbeKv13Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uISVueN6vEZaFAyJdDBF+bDXKB9YMlzVsN8FK+6nbw=;
 b=aEOIG6hXx8Bv2uTX75IMa+LQfLdeSC9fNB2KLHnYccEycD8c0n6YMVqkYghlNGNA3qPnjFu+X5sP6Eh4i9X/tRrs/wgkcTRmyVpQeS/pYSowXqpuJvwzenquKvWFFw6BdA3sGQl+HCSDjmcYGpkeN8UO4maX1DFeQltMjT4Dzvg=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5374.eurprd04.prod.outlook.com (20.178.120.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 07:34:21 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0%3]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 07:34:21 +0000
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
Subject: Re: [PATCH] usb: cdns3: Fix dequeue implementation.
Thread-Topic: [PATCH] usb: cdns3: Fix dequeue implementation.
Thread-Index: AQHVfQepqrRDdKh5qUCiZNqhRPzBa6dQW3eA
Date:   Tue, 8 Oct 2019 07:34:21 +0000
Message-ID: <20191008073405.GF5670@b29397-desktop>
References: <1570449978-19145-1-git-send-email-pawell@cadence.com>
In-Reply-To: <1570449978-19145-1-git-send-email-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61c58794-1754-4397-97e0-08d74bc1ef7f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5374:
x-microsoft-antispam-prvs: <VI1PR04MB5374FC9078F309EA4FCAC58F8B9A0@VI1PR04MB5374.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(189003)(199004)(33716001)(6436002)(71200400001)(71190400001)(66066001)(66476007)(66556008)(64756008)(66446008)(91956017)(66946007)(478600001)(76116006)(2906002)(33656002)(6512007)(6916009)(486006)(86362001)(6486002)(476003)(44832011)(7416002)(229853002)(9686003)(11346002)(6116002)(3846002)(305945005)(14444005)(256004)(25786009)(76176011)(186003)(316002)(26005)(7736002)(446003)(81166006)(6246003)(14454004)(81156014)(99286004)(1076003)(6506007)(4326008)(54906003)(53546011)(8676002)(5660300002)(8936002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5374;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wp75NdhNc+jY7x5bS8fv/g+J+ckyry6fbRnz3autmMMIH1nzzweIYCQPTVkrJ/bKI3aW+kWFLQNDjEeWuBOGjIqQe7WdOtrSKmDksBkDfbSXFFfl3kywrUOuYXo3QkcdvIpWAdpqNeWgCR1PZwKKOh2LIiqT884KWOkB2nLKXU3ePyR1oZr88kEZfyzwuq09uUY5Ofi8YZtADErK7ib/96z/0pRKVeC/EWC6ChR/pVHn2ay+VgBfbsdqp5tJCGBlRAPgbIA1qmyjY9hHXtOtNqU6WGENI04hqvaOCHoOvKaqNUW+iUcZsiTDom6hGjuNa1HWzlw17xaEwTSG0LQckyIR6jGOT90O5OrbXk1NwwvhXPacmUq4aBd+Ce+r824Wz3jxdTUi03lmdV1oNSoNMp0v8MN10uJEpW041ZKHZdc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7D888988DD18440B60A93D08C607F49@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c58794-1754-4397-97e0-08d74bc1ef7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 07:34:21.4612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jB6VAWTv7hZhlS2QdJl6/6Gh018TURgcdGUHpubTVsYfXsRu8yoL+j7i0++ZTUXc09afBWAY4ts30Ey2h1esBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-07 13:06:18, Pawel Laszczak wrote:
> Dequeuing implementation in cdns3_gadget_ep_dequeu gets first request fro=
m

%s/cdns3_gadget_ep_dequeu/cdns3_gadget_ep_dequeue

> deferred_req_list and changed TRB associated with it to LINK TRB.
> This approach is incorrect because deferred_req_list contains requests
> that have not been placed on hardware RING.  In this case driver should
> just giveback this request to gadget driver.
>=20
> The patch implements new approach that first checks where dequeuing
> request is located and only when it's on Transfer Ring then changes TRB
> associated with it to LINK TRB.
> During processing completed transfers such LINK TRB will be ignored.
>=20
> Reported-by: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> ---
>  drivers/usb/cdns3/gadget.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 2ca280f4c054..9050b380ab83 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -1145,6 +1145,14 @@ static void cdns3_transfer_completed(struct cdns3_=
device *priv_dev,
>  		request =3D cdns3_next_request(&priv_ep->pending_req_list);
>  		priv_req =3D to_cdns3_request(request);
> =20
> +		trb =3D priv_ep->trb_pool + priv_ep->dequeue;
> +
> +		/* Request was dequeued and TRB was changed to TRB_LINK. */
> +		if (TRB_FIELD_TO_TYPE(trb->control) =3D=3D TRB_LINK) {
> +			trace_cdns3_complete_trb(priv_ep, trb);
> +			cdns3_move_deq_to_next_trb(priv_req);
> +		}

If the request was dequeued, it should not be at request list, isn't it?

Peter
> +
>  		/* Re-select endpoint. It could be changed by other CPU during
>  		 * handling usb_gadget_giveback_request.
>  		 */
> @@ -2067,6 +2075,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>  	struct usb_request *req, *req_temp;
>  	struct cdns3_request *priv_req;
>  	struct cdns3_trb *link_trb;
> +	u8 req_on_hw_ring =3D 0;
>  	unsigned long flags;
>  	int ret =3D 0;
> =20
> @@ -2083,8 +2092,10 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
> =20
>  	list_for_each_entry_safe(req, req_temp, &priv_ep->pending_req_list,
>  				 list) {
> -		if (request =3D=3D req)
> +		if (request =3D=3D req) {
> +			req_on_hw_ring =3D 1;
>  			goto found;
> +		}
>  	}
> =20
>  	list_for_each_entry_safe(req, req_temp, &priv_ep->deferred_req_list,
> @@ -2096,27 +2107,21 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
>  	goto not_found;
> =20
>  found:
> -
> -	if (priv_ep->wa1_trb =3D=3D priv_req->trb)
> -		cdns3_wa1_restore_cycle_bit(priv_ep);
> -
>  	link_trb =3D priv_req->trb;
> -	cdns3_move_deq_to_next_trb(priv_req);
> -	cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
> -
> -	/* Update ring */
> -	request =3D cdns3_next_request(&priv_ep->deferred_req_list);
> -	if (request) {
> -		priv_req =3D to_cdns3_request(request);
> =20
> +	/* Update ring only if removed request is on pending_req_list list */
> +	if (req_on_hw_ring) {
>  		link_trb->buffer =3D TRB_BUFFER(priv_ep->trb_pool_dma +
>  					      (priv_req->start_trb * TRB_SIZE));
>  		link_trb->control =3D (link_trb->control & TRB_CYCLE) |
> -				    TRB_TYPE(TRB_LINK) | TRB_CHAIN | TRB_TOGGLE;
> -	} else {
> -		priv_ep->flags |=3D EP_UPDATE_EP_TRBADDR;
> +				    TRB_TYPE(TRB_LINK) | TRB_CHAIN;
> +
> +		if (priv_ep->wa1_trb =3D=3D priv_req->trb)
> +			cdns3_wa1_restore_cycle_bit(priv_ep);
>  	}
> =20
> +	cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
> +
>  not_found:
>  	spin_unlock_irqrestore(&priv_dev->lock, flags);
>  	return ret;

--=20

Thanks,
Peter Chen=
