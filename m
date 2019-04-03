Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B59CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAA82084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDCSKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCSKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:10:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4545287633;
        Wed,  3 Apr 2019 18:10:51 +0000 (UTC)
Received: from krava (ovpn-204-76.brq.redhat.com [10.40.204.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD1735C6BF;
        Wed,  3 Apr 2019 18:10:48 +0000 (UTC)
Date:   Wed, 3 Apr 2019 20:10:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [BUG] perf: intel_pt won't display kernel function
Message-ID: <20190403181047.GC32001@krava>
References: <20190403143738.GB32001@krava>
 <4EA3EF29-6D79-4F79-B1AD-0B6C12A5FF97@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EA3EF29-6D79-4F79-B1AD-0B6C12A5FF97@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Apr 2019 18:10:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:05:02PM +0000, Song Liu wrote:
> 
> 
> > On Apr 3, 2019, at 7:37 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > hi,
> > perf script --call-trace stop working for me recently,
> > and displays only user space functions
> > 
> > I bisected that to:
> >  7b612e291a5a perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
> > 
> > data from following comands will display user space functions only:
> >  # perf-with-kcore record pt -e intel_pt// -- ls
> >  # perf-with-kcore script pt --call-trace
> 
> Seems the following are ok (upstream as-is)?
> 
> ./perf record -e intel_pt// -- ls
> ./perf script --call-trace

yes, I think it's the --kallsyms otion which is added by
perf-with-kcore that's broken

jirka

> 
> Jiri, could you please verify this? (Sorry I am new to perf-with-kcore). 
> 
> Thanks,
> Song
> 
> > 
> > when I disable the bpf synthesizing (patch below), kernel functions are back
> > 
> > I guess the new events mess up with intel_pt decoder somehow
> > 
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 4e2d953d4bc5..3daa78bc6549 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1114,10 +1114,12 @@ static int record__synthesize(struct record *rec, bool tail)
> > 		return err;
> > 	}
> > 
> > +#if 0
> > 	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
> > 						machine, opts);
> > 	if (err < 0)
> > 		pr_warning("Couldn't synthesize bpf events.\n");
> > +#endif
> > 
> > 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
> > 					    process_synthesized_event, opts->sample_address,
> 
