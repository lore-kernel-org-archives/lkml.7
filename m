Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C742064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfCGPfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:35:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCGPfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:35:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECB05821F1;
        Thu,  7 Mar 2019 15:35:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 402D45ED53;
        Thu,  7 Mar 2019 15:35:01 +0000 (UTC)
Date:   Thu, 7 Mar 2019 16:35:00 +0100
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
Subject: [PATCHv2 5/8] perf tools: Get precise_ip from the pmu config
Message-ID: <20190307153500.GC29474@krava>
References: <20190305152536.21035-1-jolsa@kernel.org>
 <20190305152536.21035-6-jolsa@kernel.org>
 <20190305161319.GC17272@tassilo.jf.intel.com>
 <20190305162854.GB4533@krava>
 <20190305164017.GD17272@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305164017.GD17272@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 07 Mar 2019 15:35:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 08:40:17AM -0800, Andi Kleen wrote:
> On Tue, Mar 05, 2019 at 05:28:54PM +0100, Jiri Olsa wrote:
> > On Tue, Mar 05, 2019 at 08:13:19AM -0800, Andi Kleen wrote:
> > > On Tue, Mar 05, 2019 at 04:25:33PM +0100, Jiri Olsa wrote:
> > > > Getting precise_ip field from the perf_pmu::max_precise
> > > > config read from sysfs. If it's not available falling
> > > > back to current detection function.
> > > 
> > > max_precise depends on the event.  This won't work for all
> > > events. For example only instructions and cycles support
> > > ppp
> > 
> > I'm getting  precise_ip=3 on mem-* events as well, that's why I
> > was fixing this.. now it's not working for any event
> 
> I don't think it means anything for mem-*
> 
> There's some support for it on Goldmont plus for other events,
> but it doesn't support mem-*. On big core it's only
> for instructions and cycles, all implemented with the same
> event. All other PEBS events only have two levels
> switching between the two IPs.

ok, so how about this, it's the change I posted merged with the patch

jirka


---
Currently we probe for precise_ip with user specified
perf_event_attr, which might fail because of unsupported
kernel features, which would get disabled during the
open time anyway.

Switching the probe to take place on simple event,
only configured with users type/config, so the
following record sets proper precise_ip:

  # perf record -e cycles:P ls
  # perf evlist -v
  cycles:P: size: 112, ... precise_ip: 3, ...

Link: http://lkml.kernel.org/n/tip-rwncfxifbhnmd89yx0va5zg0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 25 ++++++++++++++++++++-----
 tools/perf/util/evsel.c  |  8 --------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 08cedb643ea6..cee2f83feb89 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -230,18 +230,33 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 	}
 }
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr)
+void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
 {
-	attr->precise_ip = 3;
+	struct perf_event_attr attr = {
+		.type		= pattr->type,
+		.config		= pattr->config,
+		.exclude_kernel	= 1,
+		.precise_ip	= 3,
+	};
 
-	while (attr->precise_ip != 0) {
-		int fd = sys_perf_event_open(attr, 0, -1, -1, 0);
+	event_attr_init(&attr);
+
+	/*
+	 * Unnamed union member, not supported as struct member named
+	 * initializer in older compilers such as gcc 4.4.7
+	 */
+	attr.sample_period = 1;
+
+	while (attr.precise_ip != 0) {
+		int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 		if (fd != -1) {
 			close(fd);
 			break;
 		}
-		--attr->precise_ip;
+		--attr.precise_ip;
 	}
+
+	pattr->precise_ip = attr.precise_ip;
 }
 
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index eec542bab815..2ef229e24b6f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -294,20 +294,12 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 
 	if (!precise)
 		goto new_event;
-	/*
-	 * Unnamed union member, not supported as struct member named
-	 * initializer in older compilers such as gcc 4.4.7
-	 *
-	 * Just for probing the precise_ip:
-	 */
-	attr.sample_period = 1;
 
 	perf_event_attr__set_max_precise_ip(&attr);
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
-	attr.sample_period = 0;
 new_event:
 	evsel = perf_evsel__new(&attr);
 	if (evsel == NULL)
-- 
2.17.2

