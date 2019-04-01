Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B26C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3262086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfDAUjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:39:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49934 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDAUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:39:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 91A83808A7; Mon,  1 Apr 2019 22:39:08 +0200 (CEST)
Date:   Mon, 1 Apr 2019 22:39:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 078/131] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
Message-ID: <20190401203918.GA26671@amd>
References: <20190401170051.645954551@linuxfoundation.org>
 <20190401170058.681712612@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20190401170058.681712612@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-01 19:02:28, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> [ Upstream commit f6cf0545ec697ddc278b7457b7d0c0d86a2ea88e ]
>=20
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches before the processor can fetch them as new
> instructions.
>=20
> During resume from hibernate, the snapshot code copies some pages directl=
y,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Modify the read and decompress code to call
> flush_icache_range() on all pages that are restored, so that the restored
> in-place pages are guaranteed to be executable on these architectures.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> [will: make clean_pages_on_* static and remove initialisers]
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't think this is suitable for stable.

Catalin: Are there platforms that a) need this and b) support
hibernation in 4.4.X?

Thanks
								Pavel

> @@ -36,6 +36,14 @@
> =20
>  #define HIBERNATE_SIG	"S1SUSPEND"
> =20
> +/*
> + * When reading an {un,}compressed image, we may restore pages in place,
> + * in which case some architectures need these pages cleaning before they
> + * can be executed. We don't know which pages these may be, so clean the=
 lot.
> + */
> +static bool clean_pages_on_read;
> +static bool clean_pages_on_decompress;
> +
>  /*
>   *	The swap map is a data structure used for keeping track of each page
>   *	written to a swap partition.  It consists of many swap_map_page
> @@ -241,6 +249,9 @@ static void hib_end_io(struct bio *bio)
> =20
>  	if (bio_data_dir(bio) =3D=3D WRITE)
>  		put_page(page);
> +	else if (clean_pages_on_read)
> +		flush_icache_range((unsigned long)page_address(page),
> +				   (unsigned long)page_address(page) + PAGE_SIZE);
> =20
>  	if (bio->bi_error && !hb->error)
>  		hb->error =3D bio->bi_error;
> @@ -1049,6 +1060,7 @@ static int load_image(struct swap_map_handle *handl=
e,
> =20
>  	hib_init_batch(&hb);
> =20
> +	clean_pages_on_read =3D true;
>  	printk(KERN_INFO "PM: Loading image data pages (%u pages)...\n",
>  		nr_to_read);
>  	m =3D nr_to_read / 10;
> @@ -1124,6 +1136,10 @@ static int lzo_decompress_threadfn(void *data)
>  		d->unc_len =3D LZO_UNC_SIZE;
>  		d->ret =3D lzo1x_decompress_safe(d->cmp + LZO_HEADER, d->cmp_len,
>  		                               d->unc, &d->unc_len);
> +		if (clean_pages_on_decompress)
> +			flush_icache_range((unsigned long)d->unc,
> +					   (unsigned long)d->unc + d->unc_len);
> +
>  		atomic_set(&d->stop, 1);
>  		wake_up(&d->done);
>  	}
> @@ -1189,6 +1205,8 @@ static int load_image_lzo(struct swap_map_handle *h=
andle,
>  	}
>  	memset(crc, 0, offsetof(struct crc_data, go));
> =20
> +	clean_pages_on_decompress =3D true;
> +
>  	/*
>  	 * Start the decompression threads.
>  	 */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyidvYACgkQMOfwapXb+vKE7ACfcdklTuz+ZcPICFYEK3GEvntW
RFwAoMRfcRBZtzz1IZM5ob3r9ZjfESip
=yiNi
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
