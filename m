Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C27C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0B620644
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfHMOO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:14:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfHMOO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:14:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 546BC30613CC;
        Tue, 13 Aug 2019 14:14:57 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-35.phx2.redhat.com [10.3.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 133A4804F8;
        Tue, 13 Aug 2019 14:14:55 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 3F77112E; Tue, 13 Aug 2019 11:14:53 -0300 (BRT)
Date:   Tue, 13 Aug 2019 11:14:53 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 7/7] perf intel-pt: Add brief documentation for PEBS
 via Intel PT
Message-ID: <20190813141453.GB3754@redhat.com>
References: <20190806084606.4021-1-alexander.shishkin@linux.intel.com>
 <20190806084606.4021-8-alexander.shishkin@linux.intel.com>
 <20190813135149.GA3754@redhat.com>
 <87imr12m9x.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imr12m9x.fsf@ashishki-desk.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 13 Aug 2019 14:14:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 13, 2019 at 05:05:46PM +0300, Alexander Shishkin escreveu:
> Arnaldo Carvalho de Melo <acme@redhat.com> writes:
> 
> > Em Tue, Aug 06, 2019 at 11:46:06AM +0300, Alexander Shishkin escreveu:
> >> From: Adrian Hunter <adrian.hunter@intel.com>
> >> 
> >> Document how to select PEBS via Intel PT and how to display synthesized
> >> PEBS samples.
> >> 
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> ---
> >>  tools/perf/Documentation/intel-pt.txt | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >> 
> >> diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
> >> index 50c5b60101bd..8dc513b6607b 100644
> >> --- a/tools/perf/Documentation/intel-pt.txt
> >> +++ b/tools/perf/Documentation/intel-pt.txt
> >> @@ -919,3 +919,18 @@ amended to take the number of elements as a parameter.
> >>  
> >>  Note there is currently no advantage to using Intel PT instead of LBR, but
> >>  that may change in the future if greater use is made of the data.
> >> +
> >> +
> >> +PEBS via Intel PT
> >> +=================
> >> +
> >> +Some hardware has the feature to redirect PEBS records to the Intel PT trace.
> >> +Recording is selected by using the aux-output config term e.g.
> >> +
> >> +	perf record  -c 10000 -e cycles/aux-output/ppp -e intel_pt/branch=0/ uname
> >> +
> >> +Note that currently, software only supports redirecting at most one PEBS event.
> >
> > So, with these patches, but not the kernel ones I end up getting:
> >
> > [root@quaco ~]# perf record  -c 10000 -e cycles/aux-output/ppp -e intel_pt/branch=0/ uname
> 
> FWIW, the correct command line for that would have the two events
> grouped and intel_pt be the group leader.

I've just blindly followed the provided documentation :)

So you say I should have tried this instead:

  # perf record -c 10000 -e '{intel_pt/branch=0/,cycles/aux-output/ppp}' uname
  Error:
  The 'aux_output' feature is not supported, update the kernel.
  #

Or with leader sampling?

  # perf record -c 10000 -e '{intel_pt/branch=0/,cycles/aux-output/ppp}:S' uname
  Error:
  The 'aux_output' feature is not supported, update the kernel.
  # 

This is with the patch at the end of this message and without the kernel counterpart.

- Arnaldo

commit 58c5a9772d88f5dead1e561f6323f9f355625caa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Aug 13 11:06:38 2019 -0300

    perf evsel: Provide meaningful warning when trying to use 'aux_output' on older kernels
    
    Just like we do with the 'write_backwards' feature:
    
    Before:
    
      # perf record  -c 10000 -e cycles/aux-output/ppp -e intel_pt/branch=0/ uname
      Error:
      The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles/aux-output/ppp).
      /bin/dmesg | grep -i perf may provide additional information.
    
      #
    
    After:
    
      # perf record  -c 10000 -e cycles/aux-output/ppp -e intel_pt/branch=0/ uname
      Error:
      The 'aux_output' feature is not supported, update the kernel.
      #
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: https://lkml.kernel.org/n/tip-wgjsjroe1e150c0metgwmqwd@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6f08aea4f108..0b3b5af33954 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1738,7 +1738,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int pid = -1, err;
 	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
 
-	if (perf_missing_features.write_backward && evsel->core.attr.write_backward)
+	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
+	    (perf_missing_features.aux_output     && evsel->core.attr.aux_output))
 		return -EINVAL;
 
 	if (cpus == NULL) {
@@ -1912,7 +1913,11 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
+	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+		perf_missing_features.aux_output = true;
+		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
+		goto out_close;
+	} else if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
 		perf_missing_features.bpf_event = true;
 		pr_debug2("switching off bpf_event\n");
 		goto fallback_missing_features;
@@ -2926,6 +2931,8 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_output)
+			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		break;
 	default:
 		break;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8a316dd54cd0..9cd6e3ae479a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -184,6 +184,7 @@ struct perf_missing_features {
 	bool group_read;
 	bool ksymbol;
 	bool bpf_event;
+	bool aux_output;
 };
 
 extern struct perf_missing_features perf_missing_features;
