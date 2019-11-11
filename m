Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0197FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA99B222C5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKKQ43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:56:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:10981 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbfKKQ43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:56:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 08:56:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="378540975"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 11 Nov 2019 08:56:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 25C57301376; Mon, 11 Nov 2019 08:56:28 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:56:28 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/13] perf stat: Use affinity for closing file
 descriptors
Message-ID: <20191111165628.GE573472@tassilo.jf.intel.com>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-8-andi@firstfloor.org>
 <20191111133052.GE12923@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111133052.GE12923@krava>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 02:30:52PM +0100, Jiri Olsa wrote:
> On Thu, Nov 07, 2019 at 10:16:40AM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Closing a perf fd can also trigger an IPI to the target CPU.
> > Use the same affinity technique as we use for reading/enabling events
> > to closing to optimize the CPU transitions.
> > 
> > Before on a large test case with 94 CPUs:
> > 
> > % time     seconds  usecs/call     calls    errors syscall
> > ------ ----------- ----------- --------- --------- ----------------
> >  32.56    3.085463          50     61483           close
> > 
> > After:
> > 
> >  10.54    0.735704          11     61485           close
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > 
> > ---
> > 
> > v2: Use new iterator macros
> > v3: Use new iterator macros
> > Add missing affinity__cleanup
> > v4:
> > Update iterators again
> > ---
> >  tools/perf/util/evlist.c | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index dae6e846b2f8..0dcea66329e2 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -18,6 +18,7 @@
> >  #include "debug.h"
> >  #include "units.h"
> >  #include <internal/lib.h> // page_size
> > +#include "affinity.h"
> >  #include "../perf.h"
> >  #include "asm/bug.h"
> >  #include "bpf-event.h"
> > @@ -1169,9 +1170,31 @@ void perf_evlist__set_selected(struct evlist *evlist,
> >  void evlist__close(struct evlist *evlist)
> >  {
> >  	struct evsel *evsel;
> > +	struct affinity affinity;
> > +	int cpu, i;
> >  
> > -	evlist__for_each_entry_reverse(evlist, evsel)
> > -		evsel__close(evsel);
> > +	if (!evlist->core.cpus) {
> 
> should this be evlist->all_cpus?

This detects perf record essentially. I had some problems with perf record
in early testing, so I just disabled it, since I was just focussing
on stat. all_cpus would be set for perf record too.

-Andi
