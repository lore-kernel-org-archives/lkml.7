Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661BBC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0E82133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfFNNVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfFNNVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:21:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3801F308FF32;
        Fri, 14 Jun 2019 13:21:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6F56C5D9C3;
        Fri, 14 Jun 2019 13:21:23 +0000 (UTC)
Date:   Fri, 14 Jun 2019 15:21:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv2 0/8] perf/x86: Rework msr probe interface
Message-ID: <20190614132122.GA3629@krava>
References: <20190531120958.29601-1-jolsa@kernel.org>
 <20190614102046.GB4325@krava>
 <20190614123715.GN3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614123715.GN3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 14 Jun 2019 13:21:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:37:15PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 14, 2019 at 12:20:46PM +0200, Jiri Olsa wrote:
> > On Fri, May 31, 2019 at 02:09:50PM +0200, Jiri Olsa wrote:
> > > hi,
> > > following up on [1], [2] and [3], this patchset adds update
> > > attribute groups to pmu, factors out the MSR probe code and
> > > use it in msr,cstate* and rapl PMUs.
> > > 
> > > The functionality stays the same with one exception:
> > > for msr PMU: the event is not exported if the rdmsr return zero
> > > on event's msr, cstate* and rapl pmu functionality stays.
> > > 
> > > And also: ;-)
> > > > Somewhere along the line you lost the explanation of _why_ we're doing
> > > > this; namely: virt sucks.
> > > 
> > > Also available in:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > >   perf/msr
> > > 
> > > Tested on snb and skylake servers.
> > > 
> > > v2 changes:
> > >   - checking zero rdmsr only for msr PMU events,
> > >     cstate* and rapl pmu functionality stays unchanged
> > 
> > ping
> 
> I was waiting a new post because you mentioned something about some
> people not being happy with this, something about a wonky BIOS failing
> this on native.

ah, nope, that's unrelated.. I sent RFC about that today:
  [RFC] perf/x86/intel: Disable check_msr for real hw

but while checking on this one, I realized I need to send v3 ;-)

jirka
