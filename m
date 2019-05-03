Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52330C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204D620651
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfECQRe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:17:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:14340 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbfECQRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:17:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 09:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,426,1549958400"; 
   d="scan'208";a="154484372"
Received: from irsmsx106.ger.corp.intel.com ([163.33.3.31])
  by FMSMGA003.fm.intel.com with ESMTP; 03 May 2019 09:17:29 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX106.ger.corp.intel.com ([169.254.8.235]) with mapi id 14.03.0415.000;
 Fri, 3 May 2019 17:17:28 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
CC:     Andy Lutomirski <luto@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "Eric Biggers" <ebiggers3@gmail.com>,
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrA=
Date:   Fri, 3 May 2019 16:17:28 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
References: <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
 <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
 <20190502164524.GB115950@gmail.com>
In-Reply-To: <20190502164524.GB115950@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGFlNGZlY2EtYjdhNi00OTZhLWI0Y2UtNWQxZWY2OWNhYmJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ1VTTmFFSVlLYnl1dVFnOTZwRUM0eXN2c2RpcWVXanpCZ0Nwc0MrWUxmSGtsMlVcL1ZKaFZSTTloSUxRWm9UMEgifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > It has already been measured - it is far too slow.
> 
> I don't think proper buffering was tested, was it? Only a per syscall
> RDRAND overhead which I can imagine being not too good.
> 

Well, I have some numbers, but I am struggling to understand one
aspect there. 

So, this is how it looks when PAGE_TABLE_ISOLATION is off:

base:     Simple syscall: 0.0516 microseconds
rdrand (calling every 8 syscalls): Simple syscall: 0.0795 microseconds
get_random_bytes (4096 bytes buffer):  Simple syscall: 0.0597 microseconds

But then it looks like this with PAGE_TABLE_ISOLATION is on:

base:                                                               Simple syscall: 0.1761 microseconds
get_random_bytes (4096 bytes buffer): Simple syscall: 0.1793 microseconds
get_random_bytes (64 bytes buffer):     Simple syscall: 0.1866 microseconds
rdrand (calling every 8 syscalls):   Simple syscall: 0.3131 microseconds

So, suddenly calling rdrand is much more pricey... 
Either smth is really weird going on when PAGE_TABLE is enabled, or
I managed to do smth wrongly (no idea what although). I will continue 
Investigating. 

Best Regards,
Elena.
