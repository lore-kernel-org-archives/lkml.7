Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225B9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB192084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDBVKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:10:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725822AbfDBVKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:10:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BADAEAFF1;
        Tue,  2 Apr 2019 21:10:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed, 03 Apr 2019 08:10:32 +1100
Cc:     "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash bucket.
In-Reply-To: <87470518ac3f4ab28918917401b9313b@AcuMS.aculab.com>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown> <155416006521.9540.5662092375167065834.stgit@noble.brown> <87470518ac3f4ab28918917401b9313b@AcuMS.aculab.com>
Message-ID: <87o95o15br.fsf@notabene.neil.brown.name>
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

On Tue, Apr 02 2019, David Laight wrote:

> From: NeilBrown
>> Sent: 02 April 2019 00:08
>>=20
>> This patch changes rhashtables to use a bit_spin_lock on BIT(1) of the
>> bucket pointer to lock the hash chain for that bucket.
> ...
>> To enhance type checking, a new struct is introduced to represent the
>>   pointer plus lock-bit
>> that is stored in the bucket-table.  This is "struct rhash_lock_head"
>> and is empty.  A pointer to this needs to be cast to either an
>> unsigned lock, or a "struct rhash_head *" to be useful.
>> Variables of this type are most often called "bkt".
>
> Did you try using a union of the pointer and an 'unsigned long' ?
> Should remove a lot of the casts.

It might, but I'm not sure it is what we want.
The value is not an unsigned long OR a pointer, it is both blended
together.  So it really isn't a union.
We *want* it to require casts to access, so that it is clear that
something unusual is happening, and care is needed.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyjz8gACgkQOeye3VZi
gbkAlQ//eaU5fojN0BZ6unudrklu89WQ6d4MmfliwLbZpahNujvHkwAJHO/6y20R
zVWJbijnfv3XO1GSax1ACanUCEo6kePhmaKCX11hCnrRf74tWUakBKMBj0+67xQJ
TPJAaGrv1s7Ul6gnhI76clDiwzkBfA4AKbY/k2NyRfeNWksHbBHdX//Wl8JkjHms
HtmuZcLxSo/UPgcZBldMyT05FTm1axOvlzWU9d0HveXtImcN3tP3WZoq0TS69iIw
Z4QRRhEFReTJIQftJisL4lM8cu7PANE1VEHIjZctizzNb2Unxl/2jypaOhRMpVsu
peZ89Nk7ZHd57Jz7aKyQoiA6rieESUWVbF5VtrppqbkJFIzF8n7bu0Rk0WisE5Co
Y+GihfSrpXQn6csKIjATP296nyji51tjzVMHIZZNJ3preTXAFCNAIC9GM3FGTKvL
9rpbBm1dWqfXwRWp7ur7rTE959cQg1YVKQjiGn/1AtlVORVe55UwRkJcL4bkU6R/
t9kb12KI7sgIYZbTdtXD6LOakXMV9q4XxPWN9uBw9YOW8J4aYnZC0/eQdmHayLWS
Cnrwl1wUeB9b5fZuNIRwxoSOtzpK9XD/d2qPRc1EShxnUKgoY84X8tnvWrvQVsZ0
cY40Lk/vLflIyPvmSSmwnxMgPh3IN6U/OQtg3bYPjiaDcUio/Ig=
=PXwp
-----END PGP SIGNATURE-----
--=-=-=--
