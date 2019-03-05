Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C6820684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfCELDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:03:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCELDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:03:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA90C8667A;
        Tue,  5 Mar 2019 11:03:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id C083C60261;
        Tue,  5 Mar 2019 11:03:31 +0000 (UTC)
Date:   Tue, 5 Mar 2019 12:03:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Message-ID: <20190305110330.GA16022@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-15-songliubraving@fb.com>
 <20190227132105.GC18893@krava>
 <15CE7BE1-9D48-404D-BF09-847C09C4300E@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15CE7BE1-9D48-404D-BF09-847C09C4300E@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 05 Mar 2019 11:03:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 09:40:07PM +0000, Song Liu wrote:
> 
> 
> > On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Mon, Feb 25, 2019 at 04:20:18PM -0800, Song Liu wrote:
> > 
> > SNIP
> > 
> >> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >> index 8c902276d4b4..61b87c8111e6 100644
> >> --- a/tools/perf/util/evlist.c
> >> +++ b/tools/perf/util/evlist.c
> >> @@ -19,6 +19,7 @@
> >> #include "debug.h"
> >> #include "units.h"
> >> #include "asm/bug.h"
> >> +#include "bpf-event.h"
> >> #include <signal.h>
> >> #include <unistd.h>
> >> 
> >> @@ -1841,3 +1842,102 @@ struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
> >> 	}
> >> 	return leader;
> >> }
> >> +
> >> +static struct perf_evlist *sb_evlist;
> >> +pthread_t poll_thread;
> > 
> > so some of the things are static and some like poll_args
> > you alloced on the stack.. I dont like this interface,
> > could we come up with something generic? perhaps
> > encapsulated in perf_evlist, like:
> > 
> > struct perf_evlist {
> > 	...
> > 	struct {
> > 		pthread_t	th;
> > 		int		state;
> > 	} thread;
> > };
> > 
> > typedef int (perf_evlist__thread_cb_t)(perf_evlist, union perf_event *event,....)
> > 
> > perf_evlist__start_thread(perf_evlist, perf_evlist__thread_cb_t cb);
> > perf_evlist__stop_thread(perf_evlist);
> > 
> > 
> > jirka
> 
> More questions on this proposal: 
> 
> IIUC, this approach creates one perf_evlist and one thread for each side band
> event (only bpf for now, more afterwards). Each of these perf_evlists will 
> create its own ring buffer. 
> 
> On the other hand, current patch allows different events to share the thread, 
> the perf_evlist, and the ring buffer. 

you can have those events in single evlist no?

> 
> If my understanding is correct, current patch would be more efficient down the 
> road? Did I miss some downsides of current patch?

I'd just like something configurable and with single handle
not scattered around the code, so it's easy to add new callback 

jirka
