Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F931C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8022075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfC0BKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:10:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731613AbfC0BKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:10:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD271ACA9;
        Wed, 27 Mar 2019 01:10:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed, 27 Mar 2019 09:40:14 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash bucket.
In-Reply-To: <20190326052714.rqxuiqumjnw2qtb6@gondor.apana.org.au>
References: <155349021177.1111.15681654355431465791.stgit@noble.brown> <155349033961.1111.18247269615646768227.stgit@noble.brown> <20190326052714.rqxuiqumjnw2qtb6@gondor.apana.org.au>
Message-ID: <871s2t45v5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Mar 26 2019, Herbert Xu wrote:

> On Mon, Mar 25, 2019 at 04:05:39PM +1100, NeilBrown wrote:
>>
>> +/*
>> + * If 'p' is a bucket head and might be locked:
>> + *   rht_ptr() returns the address without the lock bit.
>> + *   rht_ptr_locked() returns the address WITH the lock bit.
>> + *   rht_is_locked() tests if the lock bit is set.
>> + */
>> +static inline struct rhash_head __rcu *rht_ptr(const struct rhash_head *p)
>> +{
>> +	return (void *)(((unsigned long)p) & ~2UL);
>> +}
>
> My preference would be to turn rhash_head * into an opaque type
> that can only be dereferenced through rht_ptr.

I can try that.
Presumably the 'next' pointer in 'struct rhash_head' can still be a
normal pointer, but the buckets in the bucket_table would need to
opaque pointers.
Maybe pointers to some new undefined struct, which gets cast and masked
as appropriate?

I'll have a go and see how it looks.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyaqk8ACgkQOeye3VZi
gbkErg/+MbqjrBVffvthmuRxdzi0oYvphANBMI2mLi9aGTNEegabeI9MMPlHcvSb
Y3DeKgoZbFeihHVQl3IUXrO3o2mpAv1SEIKs1y2wulLP5gl1PgAO+b0NPhcxg+QU
v65G0Rxzd+enRHz3/FbYzajnEjAGPyi2koSj/8MUOaIQjrPaN8y9qPLu09CPoHg8
UTwwxtdLMyxPfCX0g8KkFhBphYBpZJN/JKJfIeFglIJONQfvtlwEvxt+Xhadwnu9
pfiCH59CmfqX013ZbXbumv1rCwdiBD1nwlZH4SdnHoa0evB3jMQjcM9QiIom0D2g
kOQB+ucwJ53jaRGh02KWCG8YvhQpKy8c/IIwO8QS/Kkdfcazq4SiYj/umx2aKDxQ
ifhlhhfXVuKeZi52to+rSDmuzO8otS3xUKyuYvwFcjxj9ryRyx7KD8k+m9KCgpD3
l35Z7aPIqBGEO4IPlaepg+uk7nVnDPDIF2isXoKmdXj0KZyAUaDHrzfO8K55xa4S
yMqHgvz0CfPYVlzVcFn9P65pzy25tuyQDe0XHe9/9aIXqpjJ0QB2cHQAQd3vXVql
GWtwhq29AOQKijYedPms/mZ92YJ6OIJmxjbbAGTUiZ3tevi7A/pPeZ46Rv84nvLJ
dhtZLZX7WKc6q2qj6meC9u7YmEvbGLNCTvW51o5YF4ga+d9bv4k=
=WHNE
-----END PGP SIGNATURE-----
--=-=-=--
