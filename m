Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B64C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A324821473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDCJZV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:25:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:39697 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfDCJZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:25:20 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-7-0nx2Oo_2PHKuF4kxERicLQ-1; Wed, 03 Apr 2019 10:25:13 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 3 Apr 2019 10:26:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 3 Apr 2019 10:26:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'NeilBrown' <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Thread-Topic: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Thread-Index: AQHU6N/+KEMHzUp83kSbBGni6HHGjKYoprDggACnzwCAANcJUA==
Date:   Wed, 3 Apr 2019 09:26:20 +0000
Message-ID: <039555b9db9a410c88c7389708d157f1@AcuMS.aculab.com>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
 <155416006521.9540.5662092375167065834.stgit@noble.brown>
 <87470518ac3f4ab28918917401b9313b@AcuMS.aculab.com>
 <87o95o15br.fsf@notabene.neil.brown.name>
In-Reply-To: <87o95o15br.fsf@notabene.neil.brown.name>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 0nx2Oo_2PHKuF4kxERicLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown
> Sent: 02 April 2019 22:11
> 
> On Tue, Apr 02 2019, David Laight wrote:
> 
> > From: NeilBrown
> >> Sent: 02 April 2019 00:08
> >>
> >> This patch changes rhashtables to use a bit_spin_lock on BIT(1) of the
> >> bucket pointer to lock the hash chain for that bucket.
> > ...
> >> To enhance type checking, a new struct is introduced to represent the
> >>   pointer plus lock-bit
> >> that is stored in the bucket-table.  This is "struct rhash_lock_head"
> >> and is empty.  A pointer to this needs to be cast to either an
> >> unsigned lock, or a "struct rhash_head *" to be useful.
> >> Variables of this type are most often called "bkt".
> >
> > Did you try using a union of the pointer and an 'unsigned long' ?
> > Should remove a lot of the casts.
> 
> It might, but I'm not sure it is what we want.
> The value is not an unsigned long OR a pointer, it is both blended
> together.  So it really isn't a union.
> We *want* it to require casts to access, so that it is clear that
> something unusual is happening, and care is needed.

Right, but you also want to make it hard to forget to do it properly.
Using a union to access the memory as either a pointer or a long
is perfectly valid (and is valid with 'strict aliasing' enabled).
(Rather than the other use of a union to just save space.)

An interesting thought....
Are the only valid actions 'lock and read, and 'unlock with optional update' ?
If so there are only 2 bits of code that need to understand the encoding.
If you make the bit number(s) and polarity properties of the architecture
you should be able to make the stored value an invalid pointer (locked
and unlocked) on at least some architectures.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

