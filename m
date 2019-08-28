Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E62C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307672064A
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfH1Pxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:53:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:48680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfH1Pxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:53:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F846AD85;
        Wed, 28 Aug 2019 15:53:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 16F82DA809; Wed, 28 Aug 2019 17:53:49 +0200 (CEST)
Date:   Wed, 28 Aug 2019 17:53:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
Message-ID: <20190828155348.GD2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic>
 <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
 <20190825194912.GF20639@zn.tnic>
 <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
 <20190825201723.GG20639@zn.tnic>
 <20190826125342.GC28610@zn.tnic>
 <CAHk-=wj_E58JskechbJyWwpzu5rwKFHEABr4dCZjS+JBvv67Uw@mail.gmail.com>
 <20190827173955.GI29752@zn.tnic>
 <20190828152040.GC2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828152040.GC2752@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:20:41PM +0200, David Sterba wrote:
> On Tue, Aug 27, 2019 at 07:39:55PM +0200, Borislav Petkov wrote:
> > @@ -42,5 +43,24 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
> >  			return;
> >  		}
> >  	}
> > +
> > +	/*
> > +	 * Stupid sanity-check whether RDRAND does *actually* generate
> > +	 * some at least random-looking data.
> > +	 */
> > +	prev = tmp;
> > +	for (i = 0; i < SANITY_CHECK_LOOPS; i++) {
> > +		if (rdrand_long(&tmp)) {
> > +			if (prev != tmp)
> > +				changed++;
> 
> You could do some sort of weak statistical test like
> 
> 		if (popcnt(prev ^ tmp) < BITS_PER_LONG / 3)
> 			bad++;
> 
> 		if (bad > TOO_BAD)
> 			WARN(...);
> 
> this should catch same value, increments you mentioned and possibly
> other trivial classes of not-so-random values.

So the average popcount seems to be a more reliable check as I don't
have a good estimate for TOO_BAD. Ie. calculate average popcount and if
it's less than third of bit width, consider it broken. The script below
can be used to demonstrate the behaviour on a good random generator.

---
#!/usr/bin/python3

import random

popsum = 0
popcount = 0

prev = random.randrange(0, 2**64)
for i in range(16):
    x = return random.randrange(0, 2**64)
    pop = bin(x ^ prev).count("1")
    popsum += pop
    popcount += 1
    print("PREV=%d X=%d popcnt=%d" % (prev, x, pop))
    prev = x

print("Average popcnt: %d" % (1.0 * popsum / popcount))
---
PREV=8900625479737950182 X=12846979731852325434 popcnt=32
PREV=12846979731852325434 X=8887925161619955047 popcnt=35
PREV=8887925161619955047 X=988349339658261072 popcnt=36
PREV=988349339658261072 X=431141664953398919 popcnt=32
PREV=431141664953398919 X=13830962168734488538 popcnt=33
PREV=13830962168734488538 X=16591763919535693884 popcnt=33
PREV=16591763919535693884 X=7388685098481568010 popcnt=22
PREV=7388685098481568010 X=3526579832640281911 popcnt=33
PREV=3526579832640281911 X=2069567414175453497 popcnt=27
PREV=2069567414175453497 X=5562304115464083982 popcnt=28
PREV=5562304115464083982 X=14604545499285704604 popcnt=31
PREV=14604545499285704604 X=10602551277613833090 popcnt=31
PREV=10602551277613833090 X=6431137842853826307 popcnt=32
PREV=6431137842853826307 X=16231642336281616741 popcnt=41
PREV=16231642336281616741 X=520921733225029500 popcnt=38
PREV=520921733225029500 X=12014110422974389822 popcnt=21
Average popcnt: 31
