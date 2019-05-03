Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515EAC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E9C2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfECOh2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:37:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:40224 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbfECOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:37:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-111-sL2PkElbOGaMQnzoKPsUGw-1; Fri, 03 May 2019 15:37:22 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 3 May 2019 15:37:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 3 May 2019 15:37:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
CC:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: RE: [PATCH-tip v7 08/20] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Thread-Topic: [PATCH-tip v7 08/20] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Thread-Index: AQHVAbGwED1ZCDfWWEWG7oek7uUiCKZZd8Ew
Date:   Fri, 3 May 2019 14:37:21 +0000
Message-ID: <62d8f603dc654d74b98cf2a5d4cf8c61@AcuMS.aculab.com>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-9-longman@redhat.com>
 <20190503131054.GE2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190503131054.GE2623@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: sL2PkElbOGaMQnzoKPsUGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 03 May 2019 14:11
> To: Waiman Long
...
> I've changed that like so.
> 
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -406,19 +406,23 @@ static inline bool rwsem_try_write_lock(
>  	long new;
> 
>  	lockdep_assert_held(&sem->wait_lock);
> +
>  	do {
>  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
> 
>  		if (has_handoff && wstate == WRITER_NOT_FIRST)
>  			return false;
> 
> +		new = count;
> +
>  		if (count & RWSEM_LOCK_MASK) {
>  			if (has_handoff || (wstate != WRITER_HANDOFF))
>  				return false;
> -			new = count | RWSEM_FLAG_HANDOFF;
> +
> +			new |= RWSEM_FLAG_HANDOFF;
>  		} else {
> -			new = (count | RWSEM_WRITER_LOCKED) &
> -				~RWSEM_FLAG_HANDOFF;
> +			new |= RWSEM_WRITER_LOCKED;
> +			new &= ~RWSEM_FLAG_HANDOFF;
> 
>  			if (list_is_singular(&sem->wait_list))
>  				new &= ~RWSEM_FLAG_WAITERS;

The compiler will probably convert it back :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

