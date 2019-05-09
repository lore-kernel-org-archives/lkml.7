Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F4C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D2A2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfEIHB0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:01:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:53596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfEIHB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:01:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 00:01:25 -0700
X-ExtLoop1: 1
Received: from irsmsx106.ger.corp.intel.com ([163.33.3.31])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2019 00:01:21 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX106.ger.corp.intel.com ([169.254.8.235]) with mapi id 14.03.0415.000;
 Thu, 9 May 2019 08:01:20 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     David Laight <David.Laight@ACULAB.COM>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrD///dzgIAHjbaA///31ICAAC4VAIABBxmAgAAfuaA=
Date:   Thu, 9 May 2019 07:01:19 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
References: <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
 <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
 <20190502164524.GB115950@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
 <20190508113239.GA33324@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
 <20190509055915.GA58462@gmail.com>
In-Reply-To: <20190509055915.GA58462@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjdhMDJkMGUtYzAwMS00ZTkwLWJiODItNDRiMTgzNzhiMGQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOFMwTGRwXC9OTjY5OVg1WFA2cjFWeUhGcmkwT05Wb0h3WFJlc2M5OGhRM0p0WURZZTFiemVKVHBDS0RRaDV4ODEifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> * Reshetova, Elena <elena.reshetova@intel.com> wrote:
> 
> > > * Reshetova, Elena <elena.reshetova@intel.com> wrote:
> > >
> > > > CONFIG_PAGE_TABLE_ISOLATION=n:
> > > >
> > > > base:                                  Simple syscall: 0.0510 microseconds
> > > > get_random_bytes(4096 bytes buffer):   Simple syscall: 0.0597 microseconds
> > > >
> > > > So, pure speed wise get_random_bytes() with 1 page per-cpu buffer wins.
> > >
> > > It still adds +17% overhead to the system call path, which is sad.
> > > Why is it so expensive?
> >
> > I guess I can experiment further with buffer size increase and/or
> > using HW acceleration (I mostly played around different rdrand paths now).
> >
> > What would be acceptable overheard approximately (so that I know how
> > much I need to squeeze this thing)?
> 
> As much as possible? No idea, I'm sad about anything that is more than
> 0%, and I'd be *really* sad about anything more than say 1-2%.

Ok, understood. 

> 
> I find it ridiculous that even with 4K blocked get_random_bytes(), which
> gives us 32k bits, which with 5 bits should amortize the RNG call to
> something like "once per 6553 calls", we still see 17% overhead? It's
> either a measurement artifact, or something doesn't compute.

If you check what happens underneath of get_random_bytes(), there is
a fair amount of stuff that is going on, including reseeding CRNG if reseeding
interval has passed (see _extract_crng()). It also even attempts to stir in more
entropy from rdrand if avalaible:


I will look into this whole construction
slowly now to investigate. I did't optimize anything yet also (I take 8 bits at
the time for offset), but these small optimization won't make performance 
impact from 17% --> 2%, so pointless for now, need a more radical shift. 

Best Regards,
Elena.
