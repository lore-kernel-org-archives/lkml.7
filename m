Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902E5C32750
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 21:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6901A21726
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 21:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfHCVte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 17:49:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33183 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfHCVtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 17:49:33 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2F6AC8029D; Sat,  3 Aug 2019 23:49:19 +0200 (CEST)
Date:   Sat, 3 Aug 2019 23:49:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 4.19 21/32] vhost_net: fix possible infinite loop
Message-ID: <20190803214930.GB22416@amd>
References: <20190802092101.913646560@linuxfoundation.org>
 <20190802092108.665019390@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20190802092108.665019390@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This makes it possible to trigger a infinite while..continue loop
> through the co-opreation of two VMs like:
>=20
> 1) Malicious VM1 allocate 1 byte rx buffer and try to slow down the
>    vhost process as much as possible e.g using indirect descriptors or
>    other.
> 2) Malicious VM2 generate packets to VM1 as fast as possible
>=20
> Fixing this by checking against weight at the end of RX and TX
> loop. This also eliminate other similar cases when:
>=20
> - userspace is consuming the packets in the meanwhile
> - theoretical TOCTOU attack if guest moving avail index back and forth
>   to hit the continue after vhost find guest just add new buffers
>=20
> This addresses CVE-2019-3900.
>=20

> @@ -551,7 +551,7 @@ static void handle_tx_copy(struct vhost_
>  	int err;
>  	int sent_pkts =3D 0;
> =20
> -	for (;;) {
> +	do {
>  		bool busyloop_intr =3D false;
> =20
>  		head =3D get_tx_bufs(net, nvq, &msg, &out, &in, &len,
> @@ -592,9 +592,7 @@ static void handle_tx_copy(struct vhost_
>  				 err, len);
>  		if (++nvq->done_idx >=3D VHOST_NET_BATCH)
>  			vhost_net_signal_used(nvq);
> -		if (vhost_exceeds_weight(vq, ++sent_pkts, total_len))
> -			break;
> -	}
> +	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> =20
>  	vhost_net_signal_used(nvq);
>  }

So this part does not really change anything, right?

> @@ -618,7 +616,7 @@ static void handle_tx_zerocopy(struct vh
>  	bool zcopy_used;
>  	int sent_pkts =3D 0;
> =20
> -	for (;;) {
> +	do {
>  		bool busyloop_intr;
> =20
>  		/* Release DMAs done buffers first */
> @@ -693,10 +691,7 @@ static void handle_tx_zerocopy(struct vh
>  		else
>  			vhost_zerocopy_signal_used(net, vq);
>  		vhost_net_tx_packet(net);
> -		if (unlikely(vhost_exceeds_weight(vq, ++sent_pkts,
> -						  total_len)))
> -			break;
> -	}
> +	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  }
> =20
>  /* Expects to be always run from workqueue - which acts as

Neither does this. Equivalent code. Changelog says it fixes something
for the transmit so... is that intentional?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1GAWoACgkQMOfwapXb+vKqLQCeKjbltG2/AnHByP+uOanOB5px
xo0AoJVoT+xb0rMMp+R2JF4xzzBJDI5N
=5tkE
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
