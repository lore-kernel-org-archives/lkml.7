Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C508C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D4020854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbfCOMvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:51:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:59988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728143AbfCOMvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:51:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C23FAFBF;
        Fri, 15 Mar 2019 12:51:11 +0000 (UTC)
Message-ID: <31a3530dbd75771c82bfb41a357370b90d7981d2.camel@suse.de>
Subject: Re: [PATCH] usb: xhci: add Immediate Data Transfer support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     felipe.balbi@linux.intel.com, oneukum@suse.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 13:51:09 +0100
In-Reply-To: <20190219162945.22889-1-nsaenzjulienne@suse.de>
References: <20190219162945.22889-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1xg71Xz4cXB4O+O3P5ms"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1xg71Xz4cXB4O+O3P5ms
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-02-19 at 17:29 +0100, Nicolas Saenz Julienne wrote:
> Immediate data transfers (IDT) allow the HCD to copy small chunks of
> data (up to 8bytes) directly into its output transfer TRBs. This avoids
> the somewhat expensive DMA mappings that are performed by default on
> most URBs submissions.
>=20
> In the case an URB was suitable for IDT. The data is directly copied
> into the "Data Buffer Pointer" region of the TRB and the IDT flag is
> set. Instead of triggering memory accesses the HC will use the data
> directly.
>=20
> The implementation could cover all kind of output endpoints. Yet
> Isochronous endpoints are bypassed as I was unable to find one that
> matched IDT's constraints. As we try to bypass the default DMA mappings
> on URB buffers we'd need to find a Isochronous device with an
> urb->transfer_buffer_length <=3D 8 bytes.
>=20
> The implementation takes into account that the 8 byte buffers provided
> by the URB will never cross a 64KB boundary.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


Friendly ping, any more comments on this? :)

> ---
>  drivers/usb/host/xhci-ring.c | 12 ++++++++++++
>  drivers/usb/host/xhci.c      | 16 ++++++++++++++++
>  drivers/usb/host/xhci.h      | 17 +++++++++++++++++
>  3 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 40fa25c4d041..997edc908a0d 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3272,6 +3272,12 @@ int xhci_queue_bulk_tx(struct xhci_hcd *xhci, gfp_=
t
> mem_flags,
>  			field |=3D TRB_IOC;
>  			more_trbs_coming =3D false;
>  			td->last_trb =3D ring->enqueue;
> +
> +			if (xhci_urb_suitable_for_idt(urb)) {
> +				memcpy(&send_addr, urb->transfer_buffer,
> +				       trb_buff_len);
> +				field |=3D TRB_IDT;
> +			}
>  		}
> =20
>  		/* Only set interrupt on short packet for IN endpoints */
> @@ -3411,6 +3417,12 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_=
t
> mem_flags,
>  	if (urb->transfer_buffer_length > 0) {
>  		u32 length_field, remainder;
> =20
> +		if (xhci_urb_suitable_for_idt(urb)) {
> +			memcpy(&urb->transfer_dma, urb->transfer_buffer,
> +			       urb->transfer_buffer_length);
> +			field |=3D TRB_IDT;
> +		}
> +
>  		remainder =3D xhci_td_remainder(xhci, 0,
>  				urb->transfer_buffer_length,
>  				urb->transfer_buffer_length,
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 005e65922608..f04ad2290884 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1238,6 +1238,21 @@ EXPORT_SYMBOL_GPL(xhci_resume);
> =20
>  /*----------------------------------------------------------------------=
---*/
> =20
> +/*
> + * Bypass the DMA mapping if URB is suitable for Immediate Transfer (IDT=
),
> + * we'll copy the actual data into the TRB address register. This is lim=
ited
> to
> + * transfers up to 8 bytes on output endpoints of any kind with
> wMaxPacketSize
> + * >=3D 8 bytes. If suitable for IDT only one Transfer TRB per TD is all=
owed.
> + */
> +static int xhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> +				gfp_t mem_flags)
> +{
> +	if (xhci_urb_suitable_for_idt(urb))
> +		return 0;
> +
> +	return usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
> +}
> +
>  /**
>   * xhci_get_endpoint_index - Used for passing endpoint bitmasks between =
the
> core and
>   * HCDs.  Find the index for an endpoint given its descriptor.  Use the
> return
> @@ -5155,6 +5170,7 @@ static const struct hc_driver xhci_hc_driver =3D {
>  	/*
>  	 * managing i/o requests and associated device resources
>  	 */
> +	.map_urb_for_dma =3D      xhci_map_urb_for_dma,
>  	.urb_enqueue =3D		xhci_urb_enqueue,
>  	.urb_dequeue =3D		xhci_urb_dequeue,
>  	.alloc_dev =3D		xhci_alloc_dev,
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 652dc36e3012..7dc6d2197641 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1295,6 +1295,8 @@ enum xhci_setup_dev {
>  #define TRB_IOC			(1<<5)
>  /* The buffer pointer contains immediate data */
>  #define TRB_IDT			(1<<6)
> +/* TDs smaller than this might use IDT */
> +#define TRB_IDT_MAX_SIZE	8
> =20
>  /* Block Event Interrupt */
>  #define	TRB_BEI			(1<<9)
> @@ -2141,6 +2143,21 @@ static inline struct xhci_ring
> *xhci_urb_to_transfer_ring(struct xhci_hcd *xhci,
>  					urb->stream_id);
>  }
> =20
> +/*
> + * TODO: As per spec Isochronous IDT transmissions are supported. We byp=
ass
> + * them anyways as we where unable to find a device that matches the
> + * constraints.
> + */
> +static inline bool xhci_urb_suitable_for_idt(struct urb *urb)
> +{
> +	if (!usb_endpoint_xfer_isoc(&urb->ep->desc) && usb_urb_dir_out(urb) &&
> +	    usb_endpoint_maxp(&urb->ep->desc) >=3D TRB_IDT_MAX_SIZE &&
> +	    urb->transfer_buffer_length <=3D TRB_IDT_MAX_SIZE)
> +		return true;
> +
> +	return false;
> +}
> +
>  static inline char *xhci_slot_state_string(u32 state)
>  {
>  	switch (state) {


--=-1xg71Xz4cXB4O+O3P5ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlyLn70ACgkQlfZmHno8
x/4L2Qf8C3Ej72EEBELB8CwcnPnw3mVZDCawY4Z3/P6PSqPTbyJe3SJc8/SmL9e6
d/XqRf0sexJGsWKgt5eNF5PTgNK+gyDqk97WcZs/Tj3+VWoKtfy/q3RftSCFcBeb
GIETC8/GNBqGZspc9s/Zir2gRpXoVQAuXqDR5idDS1uZLr+sHfXOgXUrTWE2yG4o
FwWqZaU/NK3M8jQOqfgbgskBtO6X+0PuFuUKlcqf1j9VOHs8ZhGBQD4o4X7eO4aT
ua2LcVgvl9U7UbbQKHfXD+xcuZDY/V804IPEQM9QL1z1RLR/lE5Vfplq9e8GvbQx
bDi2ebqRP8ozkA8eiS8kIsPvTu8Yfg==
=K5x1
-----END PGP SIGNATURE-----

--=-1xg71Xz4cXB4O+O3P5ms--

