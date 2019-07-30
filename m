Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A677AC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78463217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455537;
	bh=obuh+S5ThZGyp/Kg6+2CfcwFN4vKVq9X3jhHJzaOZLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sKbLczhKrSYvD0hmuyhLm9NVXh7BOQqB5VUL26TPvkGL+Lbs2wurq/VbH7DhD9rI6
	 MSnvgtuFaGhG35n1polkVasy1HIp2iWWquT472nELlO7y8nKHJSvf5fRsNEb3atcc9
	 3iDNp0CDSd+ax6uM0xcfdMyk2lEaY420lIPMyqDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfG3C64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732091AbfG3C6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D628216C8;
        Tue, 30 Jul 2019 02:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455533;
        bh=obuh+S5ThZGyp/Kg6+2CfcwFN4vKVq9X3jhHJzaOZLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2eIZD/ac1K1IKyYexgevn3R2yKuncfaW+mX4Iqi4wBBpI9bOAWp8P8BnuPApKjWj
         vYp9JMAqqoZeLxxJhVaJwjdBk4zrsU+MH8TtMBEIZcFaAXxvawdVjZNhrG+2MCo63T
         6NyKdFOi9uIdbitAnXWFV7Qe842yno1XbwVCHWn8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 047/107] perf evlist: Rename perf_evlist__close() to evlist__close()
Date:   Mon, 29 Jul 2019 23:55:10 -0300
Message-Id: <20190730025610.22603-48-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evlist__close() to evlist__close(), so we don't have a name
clash when we add perf_evlist__close() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

