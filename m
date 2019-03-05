Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0914C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884842082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCEQ26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:28:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfCEQ26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:28:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7C1B30EBE90;
        Tue,  5 Mar 2019 16:28:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0EB22610FF;
        Tue,  5 Mar 2019 16:28:54 +0000 (UTC)
Date:   Tue, 5 Mar 2019 17:28:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 5/8] perf tools: Get precise_ip from the pmu config
Message-ID: <20190305162854.GB4533@krava>
References: <20190305152536.21035-1-jolsa@kernel.org>
 <20190305152536.21035-6-jolsa@kernel.org>
 <20190305161319.GC17272@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305161319.GC17272@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 05 Mar 2019 16:28:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 08:13:19AM -0800, Andi Kleen wrote:
> On Tue, Mar 05, 2019 at 04:25:33PM +0100, Jiri Olsa wrote:
> > Getting precise_ip field from the perf_pmu::max_precise
> > config read from sysfs. If it's not available falling
> > back to current detection function.
> 
> max_precise depends on the event.  This won't work for all
> events. For example only instructions and cycles support
> ppp

I'm getting  precise_ip=3 on mem-* events as well, that's why I
was fixing this.. now it's not working for any event

> 
> The previous method handled it by event.

how about we use empty template with just type/config
of the original event, like in the change below,
that way we eliminate unsupported features failing
the probing.. maybe we could use oldest attr version

also if precise_ip is event based, we shouldn't use the
caps/max_precise then

jirka


---
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ed20f4379956..cee2f83feb89 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -233,8 +233,8 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
 {
 	struct perf_event_attr attr = {
-		.type		= PERF_TYPE_HARDWARE,
-		.config		= PERF_COUNT_HW_CPU_CYCLES,
+		.type		= pattr->type,
+		.config		= pattr->config,
 		.exclude_kernel	= 1,
 		.precise_ip	= 3,
 	};
