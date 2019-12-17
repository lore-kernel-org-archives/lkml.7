Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2452AC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE51421739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfLQLcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:32:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfLQLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:32:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihB50-0007MQ-94; Tue, 17 Dec 2019 12:31:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E51201C2A38;
        Tue, 17 Dec 2019 12:31:53 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:31:53 -0000
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf metricgroup: Fix printing event names of
 metric group with multiple events
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191120084059.24458-1-kjain@linux.ibm.com>
References: <20191120084059.24458-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <157658231382.30329.10419978607313433424.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     eb573e746b9d4f0921dcb2449be3df41dae3caea
Gitweb:        https://git.kernel.org/tip/eb573e746b9d4f0921dcb2449be3df41dae3caea
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Wed, 20 Nov 2019 14:10:59 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Dec 2019 12:28:14 -03:00

perf metricgroup: Fix printing event names of metric group with multiple events

Commit f01642e4912b ("perf metricgroup: Support multiple events for
metricgroup") introduced support for multiple events in a metric group.
But with the current upstream, metric events names are not printed
properly

In power9 platform:

command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
     1.000208486
     2.000368863
     2.001400558

Similarly in skylake platform:

command:./perf stat --metric-only -M Power -I 1000
     1.000579994
     2.002189493

With current upstream version, issue is with event name comparison logic
in find_evsel_group(). Current logic is to compare events belonging to a
metric group to the events in perf_evlist.  Since the break statement is
missing in the loop used for comparison between metric group and
perf_evlist events, the loop continues to execute even after getting a
pattern match, and end up in discarding the matches.

Incase of single metric event belongs to metric group, its working fine,
because in case of single event once it compare all events it reaches to
end of perf_evlist.

Example for single metric event in power9 platform:

command:# ./perf stat --metric-only  -M branches_per_inst -I 1000 sleep 1
     1.000094653                  0.2
     1.001337059                  0.0

This patch fixes the issue by making sure once we found all events
belongs to that metric event matched in find_evsel_group(), we
successfully break from that loop by adding corresponding condition.

With this patch:
In power9 platform:

command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
result:#
            time  derat_4k_miss_rate_percent  derat_4k_miss_ratio derat_miss_ratio derat_64k_miss_rate_percent  derat_64k_miss_ratio dslb_miss_rate_percent islb_miss_rate_percent
     1.000135672                         0.0                  0.3              1.0                         0.0                   0.2                    0.0                    0.0
     2.000380617                         0.0                  0.0              0.0                         0.0                   0.0                    0.0                    0.0

command:# ./perf stat --metric-only -M Power -I 1000

Similarly in skylake platform:
result:#
            time    Turbo_Utilization    C3_Core_Residency  C6_Core_Residency  C7_Core_Residency    C2_Pkg_Residency  C3_Pkg_Residency     C6_Pkg_Residency   C7_Pkg_Residency
     1.000563580                  0.3                  0.0                2.6               44.2                21.9               0.0                  0.0               0.0
     2.002235027                  0.4                  0.0                2.7               43.0                20.7               0.0                  0.0               0.0

Committer testing:

  Before:

  [root@seventh ~]# perf stat --metric-only -M Power -I 1000
  #           time
       1.000383223
       2.001168182
       3.001968545
       4.002741200
       5.003442022
  ^C     5.777687244

  [root@seventh ~]#

  After the patch:

  [root@seventh ~]# perf stat --metric-only -M Power -I 1000
  #           time    Turbo_Utilization    C3_Core_Residency    C6_Core_Residency    C7_Core_Residency     C2_Pkg_Residency     C3_Pkg_Residency     C6_Pkg_Residency     C7_Pkg_Residency
       1.000406577                  0.4                  0.1                  1.4                 97.0                  0.0                  0.0                  0.0                  0.0
       2.001481572                  0.3                  0.0                  0.6                 97.9                  0.0                  0.0                  0.0                  0.0
       3.002332585                  0.2                  0.0                  1.0                 97.5                  0.0                  0.0                  0.0                  0.0
       4.003196624                  0.2                  0.0                  0.3                 98.6                  0.0                  0.0                  0.0                  0.0
       5.004063851                  0.3                  0.0                  0.7                 97.7                  0.0                  0.0                  0.0                  0.0
  ^C     5.471260276                  0.2                  0.0                  0.5                 49.3                  0.0                  0.0                  0.0                  0.0

  [root@seventh ~]#
  [root@seventh ~]# dmesg | grep -i skylake
  [    0.187807] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
  [root@seventh ~]#

Fixes: f01642e4912b ("perf metricgroup: Support multiple events for metricgroup")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191120084059.24458-1-kjain@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6a4d350..02aee94 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -103,8 +103,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		if (!strcmp(ev->name, ids[i])) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
+			i++;
+			if (i == idnum)
+				break;
 		} else {
-			if (++i == idnum) {
+			if (i + 1 == idnum) {
 				/* Discard the whole match and start again */
 				i = 0;
 				memset(metric_events, 0,
@@ -124,7 +127,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		}
 	}
 
-	if (i != idnum - 1) {
+	if (i != idnum) {
 		/* Not whole match */
 		return NULL;
 	}
