Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3E7C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D761D2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708477;
	bh=0af7zTDo74vFDup92YjNJxXvyZSCuEV5X7dr0ub9dWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cfn/mJf7/oJoQaw934UPELagbgkVOa2PJcv9IxfC4/T+hNkpR397hWWVNrmo+Opb9
	 i1EXMTEj7Ae6nzsvhmmTJZ004pDqDUTgkfHzVAtIrVSa5sSbJ8MQYwRcfavToYHsuu
	 vJnpZ0JDc4AUSOY6M98b5UNpifwEtyXRfVKgihxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfGUL14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:27:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 526F6308338F;
        Sun, 21 Jul 2019 11:27:55 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 610565D9D3;
        Sun, 21 Jul 2019 11:27:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 20/79] perf tools: Rename perf_evlist__close to evlist__close
Date:   Sun, 21 Jul 2019 13:24:07 +0200
Message-Id: <20190721112506.12306-21-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 21 Jul 2019 11:27:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evlist__close to evlist__close, so we don't
have a name clash when we add perf_evlist__close in libperf.

Link: http://lkml.kernel.org/n/tip-m1udn077bkmjdmaak6qhqyj6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-kvm.c  | 2 +-
 tools/perf/builtin-stat.c | 4 ++--
 tools/perf/util/evlist.c  | 6 +++---
 tools/perf/util/evlist.h  | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 85604d117558..6a0573a9c16b 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1058,7 +1058,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 	if (perf_evlist__mmap(evlist, kvm->opts.mmap_pages) < 0) {
 		ui__error("Failed to mmap the events: %s\n",
 			  str_error_r(errno, sbuf, sizeof(sbuf)));
-		perf_evlist__close(evlist);
+		evlist__close(evlist);
 		goto out;
 	}
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d28d4d71d9b7..bdfe138f7aed 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -613,7 +613,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * later the evsel_list will be closed after.
 	 */
 	if (!STAT_RECORD)
-		perf_evlist__close(evsel_list);
+		evlist__close(evsel_list);
 
 	return WEXITSTATUS(status);
 }
@@ -2003,7 +2003,7 @@ int cmd_stat(int argc, const char **argv)
 			perf_session__write_header(perf_stat.session, evsel_list, fd, true);
 		}
 
-		perf_evlist__close(evsel_list);
+		evlist__close(evsel_list);
 		perf_session__delete(perf_stat.session);
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7d44e05dfaa4..67c288f467f6 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -140,7 +140,7 @@ void evlist__delete(struct evlist *evlist)
 		return;
 
 	perf_evlist__munmap(evlist);
-	perf_evlist__close(evlist);
+	evlist__close(evlist);
 	cpu_map__put(evlist->cpus);
 	thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
@@ -1348,7 +1348,7 @@ void perf_evlist__set_selected(struct evlist *evlist,
 	evlist->selected = evsel;
 }
 
-void perf_evlist__close(struct evlist *evlist)
+void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
@@ -1412,7 +1412,7 @@ int evlist__open(struct evlist *evlist)
 
 	return 0;
 out_err:
-	perf_evlist__close(evlist);
+	evlist__close(evlist);
 	errno = -err;
 	return err;
 }
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f4b3152c879e..47e9d26b6774 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -147,7 +147,7 @@ void perf_evlist__toggle_bkw_mmap(struct evlist *evlist, enum bkw_mmap_state sta
 void perf_evlist__mmap_consume(struct evlist *evlist, int idx);
 
 int evlist__open(struct evlist *evlist);
-void perf_evlist__close(struct evlist *evlist);
+void evlist__close(struct evlist *evlist);
 
 struct callchain_param;
 
-- 
2.21.0

