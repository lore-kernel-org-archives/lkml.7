Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298BF21741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDDANR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:13:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:56616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfDDANP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:13:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77F9DAD3E;
        Thu,  4 Apr 2019 00:13:12 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu, 04 Apr 2019 11:13:04 +1100
Cc:     "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash bucket.
In-Reply-To: <039555b9db9a410c88c7389708d157f1@AcuMS.aculab.com>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown> <155416006521.9540.5662092375167065834.stgit@noble.brown> <87470518ac3f4ab28918917401b9313b@AcuMS.aculab.com> <87o95o15br.fsf@notabene.neil.brown.name> <039555b9db9a410c88c7389708d157f1@AcuMS.aculab.com>
Message-ID: <87v9zuzkz3.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03 2019, David Laight wrote:

> From: NeilBrown
>> Sent: 02 April 2019 22:11
>>=20
>> On Tue, Apr 02 2019, David Laight wrote:
>>=20
>> > From: NeilBrown
>> >> Sent: 02 April 2019 00:08
>> >>
>> >> This patch changes rhashtables to use a bit_spin_lock on BIT(1) of the
>> >> bucket pointer to lock the hash chain for that bucket.
>> > ...
>> >> To enhance type checking, a new struct is introduced to represent the
>> >>   pointer plus lock-bit
>> >> that is stored in the bucket-table.  This is "struct rhash_lock_head"
>> >> and is empty.  A pointer to this needs to be cast to either an
>> >> unsigned lock, or a "struct rhash_head *" to be useful.
>> >> Variables of this type are most often called "bkt".
>> >
>> > Did you try using a union of the pointer and an 'unsigned long' ?
>> > Should remove a lot of the casts.
>>=20
>> It might, but I'm not sure it is what we want.
>> The value is not an unsigned long OR a pointer, it is both blended
>> together.  So it really isn't a union.
>> We *want* it to require casts to access, so that it is clear that
>> something unusual is happening, and care is needed.
>
> Right, but you also want to make it hard to forget to do it properly.
> Using a union to access the memory as either a pointer or a long
> is perfectly valid (and is valid with 'strict aliasing' enabled).
> (Rather than the other use of a union to just save space.)

Agreed.... I personally think that a union make it easy to forget.

>
> An interesting thought....
> Are the only valid actions 'lock and read, and 'unlock with optional upda=
te' ?

No, there is also "read without locking" - use for lookups with RCU
protection.  But yes: the set of valid actions is quite limited.

> If so there are only 2 bits of code that need to understand the encoding.
> If you make the bit number(s) and polarity properties of the architecture
> you should be able to make the stored value an invalid pointer (locked
> and unlocked) on at least some architectures.

I'd rather avoid writing arch-specific code if I can avoid it.  It isn't
clear that the value of your proposal justifies the cost.
Over-loading the low-order bits of a pointer is (I think) a well
understood pattern.  I'd rather stick with such patterns.

Thanks,
NeilBrown


>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlylTBAACgkQOeye3VZi
gbnGcQ//VYzBnKwzUtMiOQHuHiWA6Jp7nHk8JQqdx8uEmxwy7QnhGYySX9SJPSys
cahPhxKzC+ZgsiSOYQNCdb8UguxNIgNu/TImfQg4i+toC7kbRtTfkJOEY02rtdf3
H6VI6R6MF4CqmNlcXbGpSN+PYfKS17GCIyopGB41Q0D1TqChuIzmivNJPtWtRkQ1
tj1lK6xFsNNSKdOhGL+Q2q+klymfFDtJ91U7atWZ5dty45Jg+I+rRgWIyp9VGwRc
0zx7oLJZlJ2xEJ34eGccPe5KT4Ir+vo7E9ebJshPNRk8PY7efPSSBUyMoc+WahRs
Ouv0GIrmufTcT1Tp53EblDY6s4kPbt0oCZGfDE6hqPNBHcJaDwMv61CTjy/eVr+i
YjvPolJNd/fzFwfb5rbfiZaZMfTzmq/cWVI0m3lyBGh1TNhSQh5XMBNdEnhtlK2v
mivxEhFV5fDFr/UjMbCpTMagWd1x7SlnPh6uQxhzXyP7Llw8CmPpXf7TUKvxXTMf
NBBDxbVrL2P2PQgSewm1QFq1/Hagg5jeCcfgbV0xsBZ8TJafzyKo9aqeJwTl95ez
Fli4rEwLX0ga6RE5ZtYifWh/0KsfV3X0O8HcE9lqm9JPHo8SFv2krHnmEQzrfZ6G
ee0A3Ke2A6fg0F4+P5nsMEh0WIhqiIKvLucz7ijwAuYgmfzC3mQ=
=7USo
-----END PGP SIGNATURE-----
--=-=-=--
