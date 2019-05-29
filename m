Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8985FC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D07722CD8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfE2Nvb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:51:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:50105 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727086AbfE2Nv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:51:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-141-3F-5HhagN6e9tnQVnk1CeQ-1; Wed, 29 May 2019 14:51:25 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 29 May 2019 14:51:24 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 29 May 2019 14:51:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Neil Horman' <nhorman@tuxdriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] Fix xoring of arch_get_random_long into crng->state array
Thread-Topic: [PATCH] Fix xoring of arch_get_random_long into crng->state
 array
Thread-Index: AQHVFiSGW6uE5jAIekyknyRep1UK46aCHqcQ
Date:   Wed, 29 May 2019 13:51:24 +0000
Message-ID: <f13de0f3159a478796a8fe6c34dc00ce@AcuMS.aculab.com>
References: <20190402220025.14499-1-nhorman@tuxdriver.com>
 <20190529134200.GA31099@hmswarspite.think-freely.org>
In-Reply-To: <20190529134200.GA31099@hmswarspite.think-freely.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 3F-5HhagN6e9tnQVnk1CeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Horman
> Sent: 29 May 2019 14:42
> On Tue, Apr 02, 2019 at 06:00:25PM -0400, Neil Horman wrote:
> > When _crng_extract is called, any arch that has a registered
> > arch_get_random_long method, attempts to mix an unsigned long value into
> > the crng->state buffer, it only mixes in 32 of the 64 bits available,
> > because the state buffer is an array of u32 values, even though 2 u32
> > are expected to be filled (owing to the fact that it expects indexes 14
> > and 15 to be filled).
> >
> > Bring the expected behavior into alignment by casting index 14 to an
> > unsignled long pointer, and xoring that in instead.
...
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 38c6d1af6d1c..8178618458ac 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -975,14 +975,16 @@ static void _extract_crng(struct crng_state *crng,
> >  			  __u8 out[CHACHA_BLOCK_SIZE])
> >  {
> >  	unsigned long v, flags;
> > -
> > +	unsigned long *archrnd;
> >  	if (crng_ready() &&
> >  	    (time_after(crng_global_init_time, crng->init_time) ||
> >  	     time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
> >  		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
> >  	spin_lock_irqsave(&crng->lock, flags);
> > -	if (arch_get_random_long(&v))
> > -		crng->state[14] ^= v;
> > +	if (arch_get_random_long(&v)) {
> > +		archrnd = (unsigned long *)&crng->state[14];
> > +		*archrnd ^= v;
> > +	}

Isn't that likely to generate a misaligned memory access?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

