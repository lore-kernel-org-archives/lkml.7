Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0233C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F47020835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfCROmr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:42:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:31393 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727368AbfCROmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:42:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-95-H_8JvVFWPVmTL6SCSVCYcg-1; Mon, 18 Mar 2019 14:42:40 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 18 Mar 2019 14:43:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 18 Mar 2019 14:43:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Manoj Gupta" <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        "Stephen Hines" <srhines@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
Thread-Topic: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
Thread-Index: AQHU3WswxUtxiFmvqk+nSxWryUVjeqYRdfkw
Date:   Mon, 18 Mar 2019 14:43:41 +0000
Message-ID: <cccfcd81efcf47a9ad2ddec7219a797d@AcuMS.aculab.com>
References: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
 <CAKwvOdkfb_DT2p2vvxK2ye6JpGYB4qqCc8yECU_JEkrc+6HXDA@mail.gmail.com>
 <20190318091428.GI6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190318091428.GI6058@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: H_8JvVFWPVmTL6SCSVCYcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 18 March 2019 09:14
> On Fri, Mar 15, 2019 at 03:06:37PM -0700, Nick Desaulniers wrote:
> > On Fri, Mar 15, 2019 at 1:54 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > The compiler may emit calls to __lshrti3 from the compiler runtime
> > > library, which results in undefined references:
> > >
> > > arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
> > >   include/linux/math64.h:186: undefined reference to `__lshrti3'
> >
> > Looks like Clang will emit this at -Oz (but not -O2):
> > https://godbolt.org/z/w1_2YC
> 
> *OMG*, what is that compiler smoking and why do we want that?
> 
> It doesn't even do that for "-Os".

I like the way it moves %edx to %ecx, then %cl to %ecx and finally %ecx back to %edx.
I'm guessing this is all made worse by the prototype containing 'char' not 'int'.

I'm sure the register tracking gets worse in every version of gcc.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

