Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC3FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0145C21897
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 17:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfJTRwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 13:52:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:24807 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfJTRwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 13:52:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 10:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="371971239"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 20 Oct 2019 10:52:30 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 056033002A2; Sun, 20 Oct 2019 10:52:30 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, peterz@infradead.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/9] perf evsel: Always preserve errno while cleaning up perf_event_open failures
Date:   Sun, 20 Oct 2019 10:51:54 -0700
Message-Id: <20191020175202.32456-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020175202.32456-1-andi@firstfloor.org>
References: <20191020175202.32456-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In some cases when perf_event_open fails, it may do some closes to clean
up. In special cases these closes can fail too, which overwrites the
errno of the perf_event_open, which is then incorrectly reported.

Save/restore errno around closes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index abc7fda4a0fe..d831038b55f2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1574,7 +1574,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
-	int pid = -1, err;
+	int pid = -1, err, old_errno;
 	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
 
 	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
@@ -1727,8 +1727,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 */
 	if (err == -EMFILE && set_rlimit < INCREASED_MAX) {
 		struct rlimit l;
-		int old_errno = errno;
 
+		old_errno = errno;
 		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
 			if (set_rlimit == NO_CHANGE)
 				l.rlim_cur = l.rlim_max;
@@ -1812,6 +1812,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err)
 		threads->err_thread = thread;
 
+	old_errno = errno;
 	do {
 		while (--thread >= 0) {
 			close(FD(evsel, cpu, thread));
@@ -1819,6 +1820,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		}
 		thread = nthreads;
 	} while (--cpu >= 0);
+	errno = old_errno;
 	return err;
 }
 
-- 
2.21.0

