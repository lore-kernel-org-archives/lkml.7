Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D03C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584E02084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573134428;
	bh=Q6KHGU5bsf22wTrrcbLMln/lRcIUK5B+v5B5dccjmzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xZhFkD//NWCoqPD9N98rRMjXrPdarrIbLkxwdm7XVwWc5na6VcJpT+hfV+iOFPRO2
	 gNSqzBct1t2Vz9y74n43XtyqzFRg4IKI6jpqYuI2eobJ3aeBzSXYWi+xWGeCj0gB/v
	 rMDGQxsUHcTvRDVX3F6+TfpJF7Mm+TTSi0MOiIIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbfKGNrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbfKGNrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:47:06 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82638207FA;
        Thu,  7 Nov 2019 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573134425;
        bh=Q6KHGU5bsf22wTrrcbLMln/lRcIUK5B+v5B5dccjmzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ByF1vHMRo+QMkC8PTOlX/0d8q9mQp56cKFMOLvJQZlelvwo6OZ8RtKPA+bOO0pm4O
         bIjdqcQOdkQASNU7iQG7S64ZRdksV8wsA9t0V6OTn165U4cTQZNG8QIhQl6PB+rqXW
         cnNDAkRPBeGsptjK32/XFX6Iyv8JzVxicHTktvKw=
Date:   Thu, 7 Nov 2019 22:47:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 3/5] perf probe: Support multiprobe event
Message-Id: <20191107224701.c1b0bd3332e16bbd48a4815f@kernel.org>
In-Reply-To: <20191106195630.GC11935@kernel.org>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
        <157291302895.19771.12251353345858434064.stgit@devnote2>
        <20191106195630.GC11935@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 16:56:30 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Tue, Nov 05, 2019 at 09:17:09AM +0900, Masami Hiramatsu escreveu:
> > Support multiprobe event if the event is based on function
> > and lines and kernel supports it. In this case, perf probe
> > creates the first probe with an event, and tries to append
> > following probes on that event, since those probes must be
> > on the same source code line.
> > 
> > Before this patch;
> >   # perf probe -a vfs_read:18
> >   Added new events:
> >     probe:vfs_read_L18   (on vfs_read:18)
> >     probe:vfs_read_L18_1 (on vfs_read:18)
> 
> So this seems to depend on the previous one, I'll leave it for later,
> till we figure that one out,

Yes, multiprobe can append several different probe points
to one probe-event. User can operate those probes in
one action. (sorry, not "atomically" controlled. that requires
a stop_machine...)

Thank you,

> 
> - Arnaldo
>  
> >   You can now use it in all perf tools, such as:
> > 
> >   	perf record -e probe:vfs_read_L18_1 -aR sleep 1
> > 
> >   #
> > 
> > After this patch (on multiprobe supported kernel)
> >   # perf probe -a vfs_read:18
> >   Added new events:
> >     probe:vfs_read_L18   (on vfs_read:18)
> >     probe:vfs_read_L18   (on vfs_read:18)
> > 
> >   You can now use it in all perf tools, such as:
> > 
> >   	perf record -e probe:vfs_read_L18 -aR sleep 1
> > 
> >   #
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-event.c |    9 +++++++--
> >  tools/perf/util/probe-file.c  |    7 +++++++
> >  tools/perf/util/probe-file.h  |    1 +
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index d14b970a6461..23db6786c3ea 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2738,8 +2738,13 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
> >  	if (tev->event == NULL || tev->group == NULL)
> >  		return -ENOMEM;
> >  
> > -	/* Add added event name to namelist */
> > -	strlist__add(namelist, event);
> > +	/*
> > +	 * Add new event name to namelist if multiprobe event is NOT
> > +	 * supported, since we have to use new event name for following
> > +	 * probes in that case.
> > +	 */
> > +	if (!multiprobe_event_is_supported())
> > +		strlist__add(namelist, event);
> >  	return 0;
> >  }
> >  
> > diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> > index b659466ea498..a63f1a19b0e8 100644
> > --- a/tools/perf/util/probe-file.c
> > +++ b/tools/perf/util/probe-file.c
> > @@ -1007,6 +1007,7 @@ enum ftrace_readme {
> >  	FTRACE_README_KRETPROBE_OFFSET,
> >  	FTRACE_README_UPROBE_REF_CTR,
> >  	FTRACE_README_USER_ACCESS,
> > +	FTRACE_README_MULTIPROBE_EVENT,
> >  	FTRACE_README_END,
> >  };
> >  
> > @@ -1020,6 +1021,7 @@ static struct {
> >  	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
> >  	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
> >  	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
> > +	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
> >  };
> >  
> >  static bool scan_ftrace_readme(enum ftrace_readme type)
> > @@ -1085,3 +1087,8 @@ bool user_access_is_supported(void)
> >  {
> >  	return scan_ftrace_readme(FTRACE_README_USER_ACCESS);
> >  }
> > +
> > +bool multiprobe_event_is_supported(void)
> > +{
> > +	return scan_ftrace_readme(FTRACE_README_MULTIPROBE_EVENT);
> > +}
> > diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
> > index 986c1c94f64f..850d1b52d60a 100644
> > --- a/tools/perf/util/probe-file.h
> > +++ b/tools/perf/util/probe-file.h
> > @@ -71,6 +71,7 @@ bool probe_type_is_available(enum probe_type type);
> >  bool kretprobe_offset_is_supported(void);
> >  bool uprobe_ref_ctr_is_supported(void);
> >  bool user_access_is_supported(void);
> > +bool multiprobe_event_is_supported(void);
> >  #else	/* ! HAVE_LIBELF_SUPPORT */
> >  static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
> >  {
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
