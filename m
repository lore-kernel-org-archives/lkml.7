Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5E0C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3863220665
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfFNKU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:20:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfFNKUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:20:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A38CC057EC6;
        Fri, 14 Jun 2019 10:20:50 +0000 (UTC)
Received: from krava (ovpn-204-154.brq.redhat.com [10.40.204.154])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5B2C860BE2;
        Fri, 14 Jun 2019 10:20:47 +0000 (UTC)
Date:   Fri, 14 Jun 2019 12:20:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
Message-ID: <20190614102046.GB4325@krava>
References: <20190531120958.29601-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531120958.29601-1-jolsa@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 14 Jun 2019 10:20:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:09:50PM +0200, Jiri Olsa wrote:
> hi,
> following up on [1], [2] and [3], this patchset adds update
> attribute groups to pmu, factors out the MSR probe code and
> use it in msr,cstate* and rapl PMUs.
> 
> The functionality stays the same with one exception:
> for msr PMU: the event is not exported if the rdmsr return zero
> on event's msr, cstate* and rapl pmu functionality stays.
> 
> And also: ;-)
> > Somewhere along the line you lost the explanation of _why_ we're doing
> > this; namely: virt sucks.
> 
> Also available in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/msr
> 
> Tested on snb and skylake servers.
> 
> v2 changes:
>   - checking zero rdmsr only for msr PMU events,
>     cstate* and rapl pmu functionality stays unchanged

ping

jirka

> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/lkml/20190301114250.GA23459@krava/
> [2] https://lore.kernel.org/lkml/20190318182116.17388-1-jolsa@kernel.org/
> [3] https://lore.kernel.org/lkml/20190512155518.21468-1-jolsa@kernel.org/
> ---
> Jiri Olsa (8):
>       perf/x86: Add msr probe interface
>       perf/x86/msr: Use new probe function
>       perf/x86/cstate: Use new probe function
>       perf/x86/rapl: Use new msr detection interface
>       perf/x86/rapl: Get rapl_cntr_mask from new probe framework
>       perf/x86/rapl: Get msr values from new probe framework
>       perf/x86/rapl: Get attributes from new probe framework
>       perf/x86/rapl: Get quirk state from new probe framework
> 
>  arch/x86/events/Makefile       |   2 +-
>  arch/x86/events/intel/cstate.c | 152 ++++++++++++++++++++++++++++++++++++++++------------------------------
>  arch/x86/events/intel/rapl.c   | 378 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------------------------------------
>  arch/x86/events/msr.c          | 110 ++++++++++++++++++++++++++++-----------------------
>  arch/x86/events/probe.c        |  45 +++++++++++++++++++++
>  arch/x86/events/probe.h        |  29 ++++++++++++++
>  6 files changed, 391 insertions(+), 325 deletions(-)
>  create mode 100644 arch/x86/events/probe.c
>  create mode 100644 arch/x86/events/probe.h
