Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5FBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45ADD2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbfDELLA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:11:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:44482 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730596AbfDELK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:10:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-21-ei3ZT4hrNcSfinsZJ8tdxw-1; Fri, 05 Apr 2019 12:10:56 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 5 Apr 2019 12:12:03 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Apr 2019 12:12:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ingo Molnar' <mingo@kernel.org>,
        Alexander Potapenko <glider@google.com>
CC:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "jyknight@google.com" <jyknight@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH v2] x86/asm: fix assembly constraints in bitops
Thread-Topic: [PATCH v2] x86/asm: fix assembly constraints in bitops
Thread-Index: AQHU65N45ims1sqDDECRt8+l+UbnY6YtaHaA
Date:   Fri, 5 Apr 2019 11:12:03 +0000
Message-ID: <00ac2060e69c4e06915ca51c1308a73e@AcuMS.aculab.com>
References: <20190402112813.193378-1-glider@google.com>
 <20190405093931.GA28890@gmail.com>
In-Reply-To: <20190405093931.GA28890@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ei3ZT4hrNcSfinsZJ8tdxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar
> Sent: 05 April 2019 10:40
> 
> * Alexander Potapenko <glider@google.com> wrote:
> 
> > 1. Use memory clobber in bitops that touch arbitrary memory
> >
> > Certain bit operations that read/write bits take a base pointer and an
> > arbitrarily large offset to address the bit relative to that base.
> > Inline assembly constraints aren't expressive enough to tell the
> > compiler that the assembly directive is going to touch a specific memory
> > location of unknown size, therefore we have to use the "memory" clobber
> > to indicate that the assembly is going to access memory locations other
> > than those listed in the inputs/outputs.
> > To indicate that BTR/BTS instructions don't necessarily touch the first
> > sizeof(long) bytes of the argument, we also move the address to assembly
> > inputs.
> >
> > This particular change leads to size increase of 124 kernel functions in
> > a defconfig build. For some of them the diff is in NOP operations, other
> > end up re-reading values from memory and may potentially slow down the
> > execution. But without these clobbers the compiler is free to cache
> > the contents of the bitmaps and use them as if they weren't changed by
> > the inline assembly.
> >
> > 2. Use byte-sized arguments for operations touching single bytes.
> >
> > Passing a long value to ANDB/ORB/XORB instructions makes the compiler
> > treat sizeof(long) bytes as being clobbered, which isn't the case. This
> > may theoretically lead to worse code in the case of heavy optimization.
> >
...
> 
> I'm wondering what the primary motivation for the patch is:
> 
>  - Does it fix an actual miscompilation, or only a theoretical miscompilation?
> 
>  - If it fixes an existing miscompilation:
> 
>    - Does it fix a miscompilation triggered by current/future versions of GCC?
>    - Does it fix a miscompilation triggered by current/future versions of Clang?
> 
>  - Also, is the miscompilation triggered by 'usual' kernel configs, or
>    does it require exotics such as weird debug options or GCC plugins,
>    etc?
> 
> I.e. a bit more context would be useful.

The missing memory clobber (change 1) can cause very difficult to debug bugs.
Simple things like gcc deciding to inline a function can change the order
of memory accesses.
Having the wrong just isn't worth the trouble it can cause.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

