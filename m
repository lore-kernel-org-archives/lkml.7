Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C52C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2102190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocTqZMUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCVVP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:15:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35518 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCVVP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:15:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so2350401pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LMA/MzFIwpEF33/5TfoDAP0YF+uL80W5uBYdUOSevvo=;
        b=ocTqZMUEbEIrzUiE91VDfBFds1wglc46t7ym/dzCFh9BvHPGXJQy5/lJydcgEutSAM
         F8NHe29gfIk5fPYFVL7gzenrRKFgm8DRSkxOVSZJzwsJq9cd8WDPQiZF4XY7d2+FlsbS
         lvj4KHe+PsJYv2cr4x7THYLinLqpDuWN4+m0+0Oz9oMuFSIeAW1nFhWaIbYpmHESA+oR
         ZBO7nnMFVHhuvADZbVBKZ90Jg4LjVRLISTEZBPZUIX9kU8zW5CdADSmlbxw0zfyFS0Ch
         ZwLvIkJHXRqzdr/y3ZA2K0VL/TfrB9v+JyFuH62Loq4MSY4auA6wgi3aN3tAaeFiAq9n
         oh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LMA/MzFIwpEF33/5TfoDAP0YF+uL80W5uBYdUOSevvo=;
        b=VYalX4P6h64ktPmJFOcFyyC+JiqUV6BSzEfjmmunarW3zqhqruuecOyfaGzGQrgGl2
         hDnuAa09ZzF6XLSPgUVO6DY+eBfSzMRJNwJ6D22HIW2s4PgSMXqg3B7o+Vil6NOX0Rp1
         IpaFQH6u96dmrYgbBoPwvdIkq0DaRNwKtgWyBA9iP1WKUeCnmsq2SiD9015cQnpUzh5k
         ksqmDCxWBDWERr8ugNgHRSg1Zuf+gbSKgoiYk7buVKpz7woo8cf2DU9W3oaRnmU50DLA
         8vmyCeXiMByqbrjk1yWrkM1GkS8qb2rbs76yDbXrl+SWniMtkBg3WT0BG267NHa3MTuS
         C2mA==
X-Gm-Message-State: APjAAAWAZ1syq1u9Xs6ueXxYcRi5Xd5d65VQiA+WGz5Sm4TM84Gid/ot
        TVt5j1Ob77KHTX0cz10hOmsZ1A==
X-Google-Smtp-Source: APXvYqzGr3ev/t2t2dAIn2O3m7/7+x9/VX8ZLlUnGbdXYyDBVzRNmRDN+hRJuBeCsE9PPSUGbLtwdg==
X-Received: by 2002:aa7:9397:: with SMTP id t23mr11360600pfe.238.1553289357010;
        Fri, 22 Mar 2019 14:15:57 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id 20sm13123136pgr.80.2019.03.22.14.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 14:15:56 -0700 (PDT)
Date:   Fri, 22 Mar 2019 14:15:50 -0700
From:   Benson Leung <bleung@google.com>
To:     egranata@chromium.org
Cc:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, gwendal@google.com, amstan@google.com
Subject: Re: [PATCH] mfd: cros_ec: Only register a positive IRQ number
Message-ID: <20190322211550.GA139120@google.com>
References: <20190321210347.34793-1-egranata@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20190321210347.34793-1-egranata@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On Thu, Mar 21, 2019 at 02:03:47PM -0700, egranata@chromium.org wrote:
> From: Enrico Granata <egranata@chromium.org>
>=20
> Add a layer of sanity checking to cros_ec_register against attempting to
> register IRQ values that are not strictly greater than 0.
>=20
> Signed-off-by: Enrico Granata <egranata@chromium.org>

Acked-By: Benson Leung <bleung@chromium.org>

> ---
>  drivers/mfd/cros_ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 6acfe036d5222..ff8984a2b8c21 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -118,7 +118,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  		return err;
>  	}
> =20
> -	if (ec_dev->irq) {
> +	if (ec_dev->irq > 0) {
>  		err =3D devm_request_threaded_irq(dev, ec_dev->irq, NULL,
>  				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  				"chromeos-ec", ec_dev);
> --=20
> 2.21.0.225.g810b269d1ac-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlyVUIQACgkQHwn1ewov
5ljRIQ//b2ehnCbWJ5gEGNwDk0oqOELUxVUoErK6AnQ3DGWfeUIB4OSHPa1e3mu3
F3vFZyMBgjE1GSN0isadLt5KsR9ctwB7EOOPfpQgftV9sRRPGtDa/2LZyFQoCEUQ
KlfJVF/7QehfSvB/zh5XBR9GeTnx9lnRlU/90rYg6n8lf2KoTX6HZN7c1nBDlOSL
vyJMnfMQsPNUZGOShCqW2pQYtt80/edT5KHoCC/nCzVZMrdY2wlBdjEeYSvS0R7E
rIMqRb06f5Vdqm/w0FSj0/dHopKW267VeCuSiWEldUyJ+hlIaDLrVsxDcqF+YC/P
NlQ0G2M6geAZ+GPGGTEZiTLuKxVDfVrAO9v3bZ+V8TM/UpEZWCWdyydRT6v+q4Tm
2+GUJ8h1l6snPcKisXH7ZfNOqEIspWO8X4ZGsa7gU+Qx6/mtdcuyDKayBfb6FbCx
HS2OMzxJopLSOdAnVzlUVXMaz+mBjMPFx5Lw5fITzeljSfGckGBwmd1PbkjCS9QH
tkB6bm7MSG2aXxZ55HMd+yxH++2MVC9wtOMZaRZLWtoNpxmchxWyxJufVcosMFY3
pI/TAXzZ2AGruk/x5Qx/AYjWd4DXkhyD4TjKbApUJZDLdDvrCLrznOmmY9GSath5
RDi3j+w5YcCIVIUQkc88cKIZetOhF2IGA8uRsjinxd3gTYmo0js=
=8Xpd
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
