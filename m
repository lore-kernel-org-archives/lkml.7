Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E51C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE434206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfDQGvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfDQGvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:51:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C11233092647;
        Wed, 17 Apr 2019 06:51:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 231465D9C8;
        Wed, 17 Apr 2019 06:51:27 +0000 (UTC)
Date:   Wed, 17 Apr 2019 08:51:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 11/12] perf tools: Reuse shared eBPF dso objects
Message-ID: <20190417065127.GA17024@krava>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-12-jolsa@kernel.org>
 <746f02e3-a509-5081-8427-b610e52c1fb0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <746f02e3-a509-5081-8427-b610e52c1fb0@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 17 Apr 2019 06:51:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:35:32AM +0300, Adrian Hunter wrote:
> On 16/04/19 7:01 PM, Jiri Olsa wrote:
> > The eBPF program can be loaded multiple times
> > with the same name (tag). We can share dso
> > objects for those programs.
> 
> Doesn't a eBPF program get recompiled differently every time it is loaded?

yes, but those with same tag are identical

jirka

> 
> > 
> > Link: http://lkml.kernel.org/n/tip-3damf8vq1dryhtpbk5b06jpt@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/machine.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index d4aa44489011..a60653827891 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -23,6 +23,7 @@
> >  #include "linux/hash.h"
> >  #include "asm/bug.h"
> >  #include "bpf-event.h"
> > +#include "dso.h"
> >  
> >  #include "sane_ctype.h"
> >  #include <symbol/kallsyms.h>
> > @@ -699,11 +700,18 @@ static int machine__process_ksymbol_register(struct machine *machine,
> >  
> >  	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
> >  	if (!map) {
> > -		map = dso__new_map(event->ksymbol_event.name);
> > -		if (!map)
> > +		struct dso *dso;
> > +
> > +		dso = dsos__findnew(&machine->dsos, event->ksymbol_event.name);
> > +		if (!dso)
> >  			return -ENOMEM;
> >  
> > -		map->start = event->ksymbol_event.addr;
> > +		map = map__new2(event->ksymbol_event.addr, dso);
> > +		if (!map) {
> > +			dso__put(dso);
> > +			return -ENOMEM;
> > +		}
> > +
> >  		map->end = map->start + event->ksymbol_event.len;
> >  		map_groups__insert(&machine->kmaps, map);
> >  	}
> > 
> 
