Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97E7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B202A2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfD2Htl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:49:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:24807 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfD2Htl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:49:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 00:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="341727417"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
  by fmsmga006.fm.intel.com with ESMTP; 29 Apr 2019 00:49:37 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX103.ger.corp.intel.com ([169.254.3.30]) with mapi id 14.03.0415.000;
 Mon, 29 Apr 2019 08:49:36 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        David Laight <David.Laight@ACULAB.COM>,
        "Ingo Molnar" <mingo@kernel.org>,
        'Peter Zijlstra' <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCABF9DMA==
Date:   Mon, 29 Apr 2019 07:49:36 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C66AA0@IRSMSX102.ger.corp.intel.com>
References: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
 <20190417151555.GG4686@mit.edu>
 <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu>
In-Reply-To: <20190426140102.GA4922@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjk1M2FlY2UtNGNjNi00NGE3LTkyOGMtYWI0NjUxYWVmZmY1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicXh0RVBVY2VhQittUTM2UUNyblVEa1JtT2lFa0NaMzRmRExPMnRDOU05N0Fpc0NIVGEzTGkzQzVTSUpNRzlaYyJ9
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Apr 26, 2019 at 11:33:09AM +0000, Reshetova, Elena wrote:
> > Adding Eric and Herbert to continue discussion for the chacha part.
> > So, as a short summary I am trying to find out a fast (fast enough to be used per
> syscall
> > invocation) source of random bits with good enough security properties.
> > I started to look into chacha kernel implementation and while it seems that it is
> designed to
> > work with any number of rounds, it does not expose less than 12 rounds primitive.
> > I guess this is done for security sake, since 12 is probably the lowest bound we
> want people
> > to use for the purpose of encryption/decryption, but if we are to build an efficient
> RNG,
> > chacha8 probably is a good tradeoff between security and speed.
> >
> > What are people's opinions/perceptions on this? Has it been considered before to
> create a
> > kernel RNG based on chacha?
> 
> Well, sure.  The get_random_bytes() kernel interface and the
> getrandom(2) system call uses a CRNG based on chacha20.  See
> extract_crng() and crng_reseed() in drivers/char/random.c.

Oh, indeed, I missed this link fully when was trying to trace chacha
usages in kernel. I am not familiar with crypto kernel API and looks like
my source code cross referencing failed here miserably. 

Only question left is how fast/slow is this... 

Best Regards,
Elena.
