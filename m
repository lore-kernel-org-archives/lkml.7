Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F2EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C60320868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfDPSTL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:19:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:20363 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfDPSTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:19:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 11:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,358,1549958400"; 
   d="scan'208";a="224077766"
Received: from irsmsx153.ger.corp.intel.com ([163.33.192.75])
  by orsmga001.jf.intel.com with ESMTP; 16 Apr 2019 11:19:07 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX153.ger.corp.intel.com ([169.254.9.61]) with mapi id 14.03.0415.000;
 Tue, 16 Apr 2019 19:19:05 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAHU0QA==
Date:   Tue, 16 Apr 2019 18:19:04 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C52659@IRSMSX102.ger.corp.intel.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190416120822.GV11158@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGM1Y2QzMjgtZjk1Ny00NjdhLWE3ZTgtOWM1MjI3MjE3YmY4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK0ltXC9zQjVQZGIzcEFtcnZBSWdKbndsQ3VuSEZBNWptZ3NwNmJyUkZqVkxHSlk5cGlKRDhGSVwvTmRKOEM0WHBzIn0=
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> On Tue, Apr 16, 2019 at 11:10:16AM +0000, Reshetova, Elena wrote:
> > >
> > > The kernel can execute millions of syscalls per second, I'm pretty sure
> > > there's a statistical attack against:
> > >
> > >  * This is a maximally equidistributed combined Tausworthe generator
> > >  * based on code from GNU Scientific Library 1.5 (30 Jun 2004)
> > >  *
> > >  * lfsr113 version:
> > >  *
> > >  * x_n = (s1_n ^ s2_n ^ s3_n ^ s4_n)
> > >  *
> > >  * s1_{n+1} = (((s1_n & 4294967294) << 18) ^ (((s1_n <<  6) ^ s1_n) >> 13))
> > >  * s2_{n+1} = (((s2_n & 4294967288) <<  2) ^ (((s2_n <<  2) ^ s2_n) >> 27))
> > >  * s3_{n+1} = (((s3_n & 4294967280) <<  7) ^ (((s3_n << 13) ^ s3_n) >> 21))
> > >  * s4_{n+1} = (((s4_n & 4294967168) << 13) ^ (((s4_n <<  3) ^ s4_n) >> 12))
> > >  *
> > >  * The period of this generator is about 2^113 (see erratum paper).
> > >
> > > ... which recovers the real PRNG state much faster than the ~60 seconds
> > > seeding interval and allows the prediction of the next stack offset?
> >
> > I hope Theodore can comment on bounds here. How many syscalls we need
> > to issue  assuming that each leaks 5 presudorandom bits out of 32 bit
> > presudorandom number produced by PRGN before we can predict the
> > PRNG output.
> 
> So the argument against using TSC directly was that it might be easy to
> guess most of the TSC bits in timing attack. But IIRC there is fairly
> solid evidence that the lowest TSC bits are very hard to guess and might
> in fact be a very good random source.

It might be the case, especially for this particular use case, but I am not
considering myself to be the right person to judge on the evidence (proper
randomness *is* hard), so I would prefer to have smth stronger, if possible.
 
> 
> So what one could do, is for each invocation mix in the low (2?) bits of
> the TSC into a per-cpu/task PRNG state. By always adding some fresh
> entropy it would become very hard indeed to predict the outcome, even
> for otherwise 'trivial' PRNGs.

Again, with only very limited training in crypto: this might work if our
entropy would be a real entropy, but if we are mixing one preudo-randomness
(potentially predictable) with another, does it really make things much stronger?
Of course, in this case two sources we mix would be independent, so it would
kind of be adding a non-linearness into a PRNG....  Maybe I should sleep over
all these options and think in the morning. 

Best Regards,
Elena.


