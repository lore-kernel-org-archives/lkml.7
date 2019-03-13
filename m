Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5506C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD11E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCMQ3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:29:09 -0400
Received: from foss.arm.com ([217.140.101.70]:60238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbfCMQ3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:29:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FEE280D;
        Wed, 13 Mar 2019 09:29:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC8233F71D;
        Wed, 13 Mar 2019 09:29:06 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:29:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
Message-ID: <20190313162903.GB39315@lakrids.cambridge.arm.com>
References: <20190310183051.87303-1-cai@lca.pw>
 <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com>
 <1552312822.7087.11.camel@lca.pw>
 <CAK8P3a0QB7+oPz4sfbW_g2EGZZmC=LMEnkMNLCW_FD=fEZoQPA@mail.gmail.com>
 <20190313091844.GA24390@hirez.programming.kicks-ass.net>
 <20190313143552.GA39315@lakrids.cambridge.arm.com>
 <CAK8P3a3V+1sQJfTAipYyOeV5b379eYZXasRFjWnf9oKPtCTviQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3V+1sQJfTAipYyOeV5b379eYZXasRFjWnf9oKPtCTviQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 03:57:42PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 13, 2019 at 3:36 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Mar 13, 2019 at 10:18:44AM +0100, Peter Zijlstra wrote:
> > > On Mon, Mar 11, 2019 at 03:20:04PM +0100, Arnd Bergmann wrote:
> > > > On Mon, Mar 11, 2019 at 3:00 PM Qian Cai <cai@lca.pw> wrote:
> >
> > I think that using s64 consistently (with any necessary alignment
> > annotation) makes the most sense. That's unambigious, and what the
> > common headers now use.
> >
> > Now that the scripted atomics are merged, I'd like to move arches over
> > to arch_atomic_*(), so the argument and return types will become s64
> > everywhere.
> 
> Yes, that sounds like the easiest way, especially if we don't touch the
> internal implementation but simply rename all the symbols provided
> by the architectures. Is that what you had in mind, or would you go
> beyond the minimum changes here?

I'd expected to convert arches one-by-one, updating the types during
conversion. I guess it's not strictly necessary to change the internal
types, but it would seem nicer to do that.

I don't think it's possible to do that rename right now, unless we do it
treewide. There are a few core things that need to be fixed up first,
e.g. making <asm-generic/atomic{,64}.h> play nicely with
<asm-generic/atomic-instrumented.h>.

In the end, what I'd like to get to is:

* Arch code provids arch_atomic*_*().

* Common code fleshes out the entire API as raw_atomic*_*(), build atop
  of arch_atomic*_*(). All the ifdeffery lives here.

* Common code builds the instrumented atomic*_*() API atop of the
  raw_atomic*_*() API. No ifdeffery necessary here.

Thanks,
Mark.
