Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF28C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE51205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfDPMoL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:44:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48399 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbfDPMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:44:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-184-CR6mMZ28OeOFHKCbHPzuOA-1; Tue, 16 Apr 2019 13:44:07 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 16 Apr 2019 13:45:17 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 16 Apr 2019 13:45:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
CC:     Ingo Molnar <mingo@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Index: AQHU9E1UquBTkhVACE2y3BuRFoekIqY+uQlA
Date:   Tue, 16 Apr 2019 12:45:17 +0000
Message-ID: <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190416120822.GV11158@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: CR6mMZ28OeOFHKCbHPzuOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 16 April 2019 13:08
...
> So the argument against using TSC directly was that it might be easy to
> guess most of the TSC bits in timing attack. But IIRC there is fairly
> solid evidence that the lowest TSC bits are very hard to guess and might
> in fact be a very good random source.
> 
> So what one could do, is for each invocation mix in the low (2?) bits of
> the TSC into a per-cpu/task PRNG state. By always adding some fresh
> entropy it would become very hard indeed to predict the outcome, even
> for otherwise 'trivial' PRNGs.

You could just feed 8 bits of TSC into a CRC.
Or even xor the entire TSC over a CRC state and then cycle it at least 6 bits.
Probably doesn't matter which CRC - but you may want one that is
cheap in software.
Even a 16bit CRC might be enough.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

