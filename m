Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD0C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360322075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfE1KWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfE1KWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:22:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA7FCF4943;
        Tue, 28 May 2019 10:22:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0FE0E2D1BC;
        Tue, 28 May 2019 10:22:20 +0000 (UTC)
Date:   Tue, 28 May 2019 12:22:20 +0200
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
Subject: Re: [PATCH 0/8] perf/x86: Rework msr probe interface
Message-ID: <20190528102220.GA4917@krava>
References: <20190527215129.10000-1-jolsa@kernel.org>
 <20190528100147.GM2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528100147.GM2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 28 May 2019 10:22:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 12:01:47PM +0200, Peter Zijlstra wrote:
> On Mon, May 27, 2019 at 11:51:21PM +0200, Jiri Olsa wrote:
> > hi,
> > following up on [1], [2] and [3], this patchset adds update
> > attribute groups to pmu, factors out the MSR probe code and
> > use it in msr,cstate* and rapl PMUs.
> > 
> > The functionality stays the same with one exception:
> > the event is not exported if the rdmsr return zero
> > on event's msr.
> 
> That seems a wee bit dangerous, are we sure none of these counters are 0
> by 'accident' when we probe them? I'm thinking esp. things like the Cn
> residency stuff could be 0 simply because we've not been into that state
> yet.

ah right, I can disable that check for cstate pmu
and perhaps for msr pmu as well

It's aiming for rapl counters which could return 0
for unsupported counters, agreed by Kan before:

https://lore.kernel.org/lkml/5fcaf3ae-00d3-f635-74bd-8b81a089133f@linux.intel.com/

jirka

> 
> Other than that, this looks good. Kan?
