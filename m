Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076DC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EA521D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458270;
	bh=bYfnhoHSHJtFHSlZlQg30EsLlcvJOcVH4otXAOlUTqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OdwTi3T7vtsP4m3AIYd242qkljLOqZUMhh90lVhlcFp6x/a6vax4E+5HeKFAC5zce
	 4I7VTiWoVTXfUY7yol7yqDoysHY24NFM0KCLh3gzCIEIj/yp+Oa8ovuNJItB/a3YgJ
	 gLDivJl9NeZFMLFWTXYQNTCabl7kRIXQQv0PL/TE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbfIZAfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389146AbfIZAfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:03 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CFC821D7B;
        Thu, 26 Sep 2019 00:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458102;
        bh=bYfnhoHSHJtFHSlZlQg30EsLlcvJOcVH4otXAOlUTqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2A13pKp6z1oTqjv3NgARmhD+vap/ho8vqHdsuofO+E8UkW6UC9OVaBnsW+r8ksux
         sKhBdZh1c+WeGwCYJbqEI2Xl24uZMRKb8HeXCUnOjiy/em2/NJq0B03j5y8tfI0b+9
         jwWr7muy/eeZv0IHtV3FnANo36VEidkobqNaIz0g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/66] libperf: Move 'mmap_len' from 'struct evlist' to 'struct perf_evlist'
Date:   Wed, 25 Sep 2019 21:32:12 -0300
Message-Id: <20190926003244.13962-35-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Moving 'mmap_len' from 'struct evlist' to 'struct perf_evlist' it will
be used in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c              |  2 +-
 tools/perf/lib/include/internal/evlist.h |  1 +
 tools/perf/util/evlist.c                 | 10 +++++-----
 tools/perf/util/evlist.h                 |  1 -
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8577bf33a556..94997144547d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1412,7 +1412,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = -1;
 		goto out_child;
 	}
-	session->header.env.comp_mmap_len = session->evlist->mmap_len;
+	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
 
 	err = bpf__apply_obj_config();
 	if (err) {
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 035c1e1cc324..01b813616440 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -14,6 +14,7 @@ struct perf_evlist {
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
+	size_t			 mmap_len;
 };
 
 /**
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d147834fbe60..4d8cde099e10 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1012,11 +1012,11 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
-	evlist->mmap_len = evlist__mmap_size(pages);
-	pr_debug("mmap size %zuB\n", evlist->mmap_len);
-	mp.mask = evlist->mmap_len - page_size - 1;
+	evlist->core.mmap_len = evlist__mmap_size(pages);
+	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
+	mp.mask = evlist->core.mmap_len - page_size - 1;
 
-	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->mmap_len,
+	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -1600,7 +1600,7 @@ int perf_evlist__strerror_open(struct evlist *evlist,
 int perf_evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE], *emsg = str_error_r(err, sbuf, sizeof(sbuf));
-	int pages_attempted = evlist->mmap_len / 1024, pages_max_per_user, printed = 0;
+	int pages_attempted = evlist->core.mmap_len / 1024, pages_max_per_user, printed = 0;
 
 	switch (err) {
 	case EPERM:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 816b72a2b1e5..765cee8bced1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -56,7 +56,6 @@ struct evlist {
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_groups;
 	bool		 enabled;
-	size_t		 mmap_len;
 	int		 id_pos;
 	int		 is_pos;
 	u64		 combined_sample_type;
-- 
2.21.0

