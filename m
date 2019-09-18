Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBC52067B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="K3Y86tc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfIRHt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:49:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:49:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id r195so1293879wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=w49TQ0N35C8+aNkoU7EonuZ+lO88up05Z8pyD5El0SU=;
        b=K3Y86tc+vMZs495HCJBn2XEQR8Wuylyn912jixOZpKwv2couwVctcA686JMFUYlMeA
         OSZaTDidjPgjsRjuaCLj0vSBBFEQNcmJKWQ/ZKCi6y7gY7IdVV7UX1vLB5MEqsedNR7x
         N/ZetH++Ibtfyh9h3F2GRN/8RIecHYrZI9UQ3yagxXGDwFdwWfhnISjNHcZHuEQv99AM
         /6BsPMuP7Fjz/U/YpqcLXlgG6bULz4P7uCDzVIX3yseqgbvx3kKHZBuSks0C+z119UtP
         jxfcIXO1I4utv80dCn3JmsygkZ9YISqOe6I/QHOnqOQBDanjYAsgrYAcqWwoTBRTDbtC
         4wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=w49TQ0N35C8+aNkoU7EonuZ+lO88up05Z8pyD5El0SU=;
        b=Y7p3nRvl+Y6CJLC2R1WY82x5A2btQfGVRvCyR/Qn2e3MEraMpxOOOdM3Drb1elxrSS
         oAdp2X81hwAYFuU4AjAjmQl29VPgxX/SfMyjK1qD08m+xcy7NFQvGFvClLYpIZMUeL8q
         WTSTOB9R/TncErP7nIknvFXmCrRvX5k8IOxljmoHsOts7bU8H9H46Bn/sIFOAY4knM9+
         PWZXq4c/Mx2fUfDfUXw91tv9y4L4aNSvIgknAFfrVpBEgbKXSAPMBIouEAVf3t8O4j9p
         Uoy7x27cfiuMTPEN7CjXEJ5DiEaLGBPY0NgXxMWQT0Suq2vJbok7XvFvdNDuRDlM7hZ+
         raVA==
X-Gm-Message-State: APjAAAVVh2F9pa+wehfLrcb6i/k1iQZVvt5L2hph9Ke2eu/O3JWcUJHU
        fhckNcN7boyODgIxqqTjlAvCpg==
X-Google-Smtp-Source: APXvYqyry7jgQYDPnkcqhewLweiWFp1SLS17tTBz+Lb+VJMFztDFw5YOI0TZmH7qJoVWRrIUynQjzQ==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr1674590wma.129.1568792962061;
        Wed, 18 Sep 2019 00:49:22 -0700 (PDT)
Received: from [74.125.133.109] ([149.199.62.129])
        by smtp.gmail.com with ESMTPSA id c1sm1138665wmk.20.2019.09.18.00.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 00:49:21 -0700 (PDT)
Subject: Re: [PATCH] arch/microblaze: support get_user() of size 8 bytes
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
References: <71b1822c-c63f-4c92-ae4a-5e220714f995@infradead.org>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
Message-ID: <2dd46339-5d69-be42-e41f-510e68503ec9@monstr.eu>
Date:   Wed, 18 Sep 2019 09:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <71b1822c-c63f-4c92-ae4a-5e220714f995@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pUZ0j0XHrWzAHnQaCx7As75FmwcUpCyNw"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pUZ0j0XHrWzAHnQaCx7As75FmwcUpCyNw
Content-Type: multipart/mixed; boundary="S7qvRqb4c1qg4rSx0CT8TAalsMUP6vdFr";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Randy Dunlap <rdunlap@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>, "Steven J. Magnani"
 <steve@digidescorp.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Leon Romanovsky <leonro@mellanox.com>, Doug Ledford <dledford@redhat.com>
Message-ID: <2dd46339-5d69-be42-e41f-510e68503ec9@monstr.eu>
Subject: Re: [PATCH] arch/microblaze: support get_user() of size 8 bytes
References: <71b1822c-c63f-4c92-ae4a-5e220714f995@infradead.org>
In-Reply-To: <71b1822c-c63f-4c92-ae4a-5e220714f995@infradead.org>

--S7qvRqb4c1qg4rSx0CT8TAalsMUP6vdFr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17. 09. 19 3:39, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> arch/microblaze/ is missing support for get_user() of size 8 bytes,
> so add it by using __copy_from_user().
>=20
> While there, also drop a lot of the code duplication.
>=20
> Fixes these build errors:
>    drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write'=
:
>    drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefi=
ned reference to `__user_bad'
>    drivers/android/binder.o: In function `binder_thread_write':
>    drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference=
 to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference=
 to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference=
 to `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference=
 to `__user_bad'
>    drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xe=
a78): more undefined references to `__user_bad' follow
>=20
> 'make allmodconfig' now builds successfully for arch/microblaze/.
>=20
> Fixes: 538722ca3b76 ("microblaze: fix get_user/put_user side-effects")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Steven J. Magnani <steve@digidescorp.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Doug Ledford <dledford@redhat.com>
> ---
> v4: drop code duplication (Linus).
>=20
>=20
>  arch/microblaze/include/asm/uaccess.h |   42 +++++-------------------
>  1 file changed, 9 insertions(+), 33 deletions(-)
>=20
> --- lnx-53.orig/arch/microblaze/include/asm/uaccess.h
> +++ lnx-53/arch/microblaze/include/asm/uaccess.h
> @@ -163,44 +163,15 @@ extern long __user_bad(void);
>   * Returns zero on success, or -EFAULT on error.
>   * On error, the variable @x is set to zero.
>   */
> -#define get_user(x, ptr)						\
> -	__get_user_check((x), (ptr), sizeof(*(ptr)))
> -
> -#define __get_user_check(x, ptr, size)					\
> -({									\
> -	unsigned long __gu_val =3D 0;					\
> -	const typeof(*(ptr)) __user *__gu_addr =3D (ptr);			\
> -	int __gu_err =3D 0;						\
> -									\
> -	if (access_ok(__gu_addr, size)) {			\
> -		switch (size) {						\
> -		case 1:							\
> -			__get_user_asm("lbu", __gu_addr, __gu_val,	\
> -				       __gu_err);			\
> -			break;						\
> -		case 2:							\
> -			__get_user_asm("lhu", __gu_addr, __gu_val,	\
> -				       __gu_err);			\
> -			break;						\
> -		case 4:							\
> -			__get_user_asm("lw", __gu_addr, __gu_val,	\
> -				       __gu_err);			\
> -			break;						\
> -		default:						\
> -			__gu_err =3D __user_bad();			\
> -			break;						\
> -		}							\
> -	} else {							\
> -		__gu_err =3D -EFAULT;					\
> -	}								\
> -	x =3D (__force typeof(*(ptr)))__gu_val;				\
> -	__gu_err;							\
> +#define get_user(x, ptr) ({				\
> +	const typeof(*(ptr)) __user *__gu_ptr =3D (ptr);	\
> +	access_ok(__gu_ptr, sizeof(*__gu_ptr)) ?	\
> +		__get_user(x, __gu_ptr) : -EFAULT;	\
>  })
> =20
>  #define __get_user(x, ptr)						\
>  ({									\
>  	unsigned long __gu_val =3D 0;					\
> -	/*unsigned long __gu_ptr =3D (unsigned long)(ptr);*/		\
>  	long __gu_err;							\
>  	switch (sizeof(*(ptr))) {					\
>  	case 1:								\
> @@ -212,6 +183,11 @@ extern long __user_bad(void);
>  	case 4:								\
>  		__get_user_asm("lw", (ptr), __gu_val, __gu_err);	\
>  		break;							\
> +	case 8:								\
> +		__gu_err =3D __copy_from_user(&__gu_val, ptr, 8);		\
> +		if (__gu_err)						\
> +			__gu_err =3D -EFAULT;				\
> +		break;							\
>  	default:							\
>  		/* __gu_val =3D 0; __gu_err =3D -EINVAL;*/ __gu_err =3D __user_bad()=
;\
>  	}								\
>=20
>=20

Applied.

Thanks,
Michal




--S7qvRqb4c1qg4rSx0CT8TAalsMUP6vdFr--

--pUZ0j0XHrWzAHnQaCx7As75FmwcUpCyNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXYHhegAKCRDKSWXLKUoM
IUiDAJ4jX4u6BFZxvKNyATSZwuHuYD2RtwCglPzoSNMYB+5MONDDoBjr/tr9Nkg=
=zsmP
-----END PGP SIGNATURE-----

--pUZ0j0XHrWzAHnQaCx7As75FmwcUpCyNw--
