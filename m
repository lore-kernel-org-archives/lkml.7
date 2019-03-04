Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FC520835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfCDUlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:41:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCDUlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:41:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDF35C049E38;
        Mon,  4 Mar 2019 20:41:03 +0000 (UTC)
Received: from krava (ovpn-204-135.brq.redhat.com [10.40.204.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64D6760851;
        Mon,  4 Mar 2019 20:41:01 +0000 (UTC)
Date:   Mon, 4 Mar 2019 21:41:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Message-ID: <20190304204100.GE2563@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-15-songliubraving@fb.com>
 <20190227132105.GC18893@krava>
 <2506D6CF-F0E3-4640-B385-DD0843AD2928@fb.com>
 <20190304135224.GD19809@krava>
 <3B7ECDFA-E6F7-4136-A2E4-6115C5A4791B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B7ECDFA-E6F7-4136-A2E4-6115C5A4791B@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 04 Mar 2019 20:41:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 07:49:06PM +0000, Song Liu wrote:
> 
> 
> > On Mar 4, 2019, at 5:52 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Wed, Feb 27, 2019 at 05:52:52PM +0000, Song Liu wrote:
> >> 
> >> 
> >>> On Feb 27, 2019, at 5:21 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> >>> 
> >>> On Mon, Feb 25, 2019 at 04:20:18PM -0800, Song Liu wrote:
> >>> 
> >>> SNIP
> >>> 
> >>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >>>> index 8c902276d4b4..61b87c8111e6 100644
> >>>> --- a/tools/perf/util/evlist.c
> >>>> +++ b/tools/perf/util/evlist.c
> >>>> @@ -19,6 +19,7 @@
> >>>> #include "debug.h"
> >>>> #include "units.h"
> >>>> #include "asm/bug.h"
> >>>> +#include "bpf-event.h"
> >>>> #include <signal.h>
> >>>> #include <unistd.h>
> >>>> 
> >>>> @@ -1841,3 +1842,102 @@ struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
> >>>> 	}
> >>>> 	return leader;
> >>>> }
> >>>> +
> >>>> +static struct perf_evlist *sb_evlist;
> >>>> +pthread_t poll_thread;
> >>> 
> >>> so some of the things are static and some like poll_args
> >>> you alloced on the stack.. I dont like this interface,
> >>> could we come up with something generic? perhaps
> >>> encapsulated in perf_evlist, like:
> >> 
> >> I picked global sb_evlist and poll_thread because there 
> >> should be only one sb_evlist and one thread polling it. 
> >> There might be multiple evsel on the sb_evlist. 
> >> 
> >> I am not sure I understand your suggestion..
> >> 
> >>> struct perf_evlist {
> >>> 	...
> >>> 	struct {
> >>> 		pthread_t	th;
> >>> 		int		state;
> >>> 	} thread;
> >> 
> >> This will not be used by the main perf_evlist, right?
> > 
> > no, just by the thread interface
> 
> What is "state" here?

it's replacement for the 'done' pointer u had,
which I did not like.. leting each thread having
its own state is better IMO

jirka
