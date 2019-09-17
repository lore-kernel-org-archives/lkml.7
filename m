Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C58C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1110820644
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404424AbfIQHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:12:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44521 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391409AbfIQHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:12:27 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1iA7ez-0008Hp-M4
        for linux-kernel@vger.kernel.org; Tue, 17 Sep 2019 07:12:25 +0000
Received: by mail-wm1-f71.google.com with SMTP id d10so471206wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mJ7H9Vd/KYYHK2hKEza3o32eBLR4dUC6S3+MRraUY0=;
        b=BEaWSSMxD7rlmTgrBHkGiHSafUri3s7KNXXHmlGb5aRDIwWRSc5u32nX3FNH5lTb4V
         G99eSuq6BRU5DMfH+PT0h3C4eF7n4yTty/Oxc717OXn/FxAKpzwlszZ9kufE7pOLvyTg
         2b0DzyOeMfLcIK+F1rPxXU9dqLCWy6KFUpazJ+kPeROdqSbLS5/LBRM2j+QzICs2oTFZ
         qH4r15AwH2PAanev6JxXnkdqiJiaygeJHgDeYHYuEUa82fl5dwGUeIhv1GCBFY0UgWkm
         DdOpX2nIy2rVV5g0UYlX9yueKsG4v9GRJDBF9HlQqdE3k7ntdJE9C2+XuV4bvRChev5h
         eG/Q==
X-Gm-Message-State: APjAAAWHtHiLjz3nZ6CpFvjWLBe2qVGg7TwaSEw/CxkOROqj6iaPpBEu
        TsFMFkBhIllXeU4vBedTMZcJn+BzEf8feZt0PPQWbvy9l8KY/87WiSWmCoqV9phn5lGxDrMVRbS
        8QWBlPOTRVTmLzWsMUkWHib8CdviBcyU066od56yb
X-Received: by 2002:a05:6000:110f:: with SMTP id z15mr1536459wrw.328.1568704345356;
        Tue, 17 Sep 2019 00:12:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNNylg8z2QXdHZ6GX64UAW0YItRdOYiMPBiABGeWFNQO1sX9E5y78KYLlTPB8RardpZerdyQ==
X-Received: by 2002:a05:6000:110f:: with SMTP id z15mr1536441wrw.328.1568704345031;
        Tue, 17 Sep 2019 00:12:25 -0700 (PDT)
Received: from gallifrey (static-dcd-cqq-121001.business.bouyguestelecom.com. [212.194.121.1])
        by smtp.gmail.com with ESMTPSA id l13sm1267363wmj.25.2019.09.17.00.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 00:12:23 -0700 (PDT)
Date:   Tue, 17 Sep 2019 04:12:22 -0300
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     shuah <shuah@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: replace AF_MAX with INT_MAX in socket.c
Message-ID: <20190917071222.6nfzmcxt4kxzgpki@gallifrey>
References: <20190916150337.18049-1-marcelo.cerri@canonical.com>
 <212adcf8-566e-e06d-529f-f0ac18bd6a35@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sjt5zxil7puotrgx"
Content-Disposition: inline
In-Reply-To: <212adcf8-566e-e06d-529f-f0ac18bd6a35@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sjt5zxil7puotrgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So the problem arises because the headers we have in userspace might
be older and not match what we have in the kernel. In that case, the
actual value of AF_MAX in the userspace headers might be a valid
protocol family in the new kernel.

That happens relatively often for us because we support different
kernel versions at the same time in a given Ubuntu series.

An alternative is to use the headers we have in the kernel tree, but I
believe that might cause other issues.

On Mon, Sep 16, 2019 at 10:09:13AM -0600, shuah wrote:
> On 9/16/19 9:03 AM, Marcelo Henrique Cerri wrote:
> > Use INT_MAX instead of AF_MAX, since libc might have a smaller value
> > of AF_MAX than the kernel, what causes the test to fail.
> >=20
> > Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > ---
> >   tools/testing/selftests/net/socket.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selft=
ests/net/socket.c
> > index afca1ead677f..10e75ba90124 100644
> > --- a/tools/testing/selftests/net/socket.c
> > +++ b/tools/testing/selftests/net/socket.c
> > @@ -6,6 +6,7 @@
> >   #include <sys/types.h>
> >   #include <sys/socket.h>
> >   #include <netinet/in.h>
> > +#include <limits.h>
> >   struct socket_testcase {
> >   	int	domain;
> > @@ -24,7 +25,10 @@ struct socket_testcase {
> >   };
> >   static struct socket_testcase tests[] =3D {
> > -	{ AF_MAX,  0,           0,           -EAFNOSUPPORT,    0 },
> > +	/* libc might have a smaller value of AF_MAX than the kernel
> > +	 * actually supports, so use INT_MAX instead.
> > +	 */
> > +	{ INT_MAX, 0,           0,           -EAFNOSUPPORT,    0  },
> >   	{ AF_INET, SOCK_STREAM, IPPROTO_TCP, 0,                1  },
> >   	{ AF_INET, SOCK_DGRAM,  IPPROTO_TCP, -EPROTONOSUPPORT, 1  },
> >   	{ AF_INET, SOCK_DGRAM,  IPPROTO_UDP, 0,                1  },
> >=20
>=20
> What failure are you seeing? It sounds arbitrary to use INT_MAX
> instead of AF_MAX. I think it is important to understand the
> failure first.
>=20
> Please note that AF_MAX is widely used in the kernel.
>=20
> thanks,
> -- Shuah

--=20
Regards,
Marcelo


--sjt5zxil7puotrgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDWI6S4SUeUOX/xHQzxpLxzTV7UcFAl2Ah1YACgkQzxpLxzTV
7Ufo+gf8DIFj52cwhgSs/1wvN9sW40b15Wsaj2kzqF0UVueUb5nzGg5z8CYnW1wX
z+GLzbXJrts8i4PLO1UTcgPPTUXb3CJOyT5jZRehx1fN0fmMHr3DLmHhbRtz+m4G
IIHrcJxCk5vrH9LmXMFSUK42C7olzihTBDATk9sQ0drHvf7LV0cpRtqlY0i4tEwm
KnMVdTfjQLjCYcaAmvXr5X5EcdY9C1JsFnTjlrHbGSEiSp3Wrvxlal2FdMHRFXfe
sbYKKu2CCfob6EIFMyX6v6+DGdghrhNcx65DYgzPCXWX4TmPANGDqiPrEl/1sQow
nwCqqWSH0dNbaJyyAGtmfgZOLPGzyw==
=ikQl
-----END PGP SIGNATURE-----

--sjt5zxil7puotrgx--
