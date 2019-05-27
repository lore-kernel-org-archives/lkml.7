Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007BDC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1AB2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558937517;
	bh=3J0DBenHUO8LbPMu9lGf7/VrginphsbeuJReHL9q620=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R2VXtcdW5FKRWEITP9fJVzRGAEZYjVN0B2ezttlcd7avPVhTmmyLLWFgE4sTO4rIG
	 E0hRb8rxFUg98Yhhd47ecMQBa9YGnQqlmTED57Avf47Orn4YmUWWSpaAYRzBT3hJQf
	 41CgBNvFCy5i8GD8Sro/hEVDSObbmWvC+VHkfN+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfE0GL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:11:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37272 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfE0GL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:11:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id n27so8488320pgm.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQ2+MktllV/PJmp9XgPImtaLas1ZY14NynJ10f9PsQw=;
        b=hNaGevuAhMrA6TsN5vI8WMZFOUXHtaiy6Nn3+CCvZN4WYT1GCqIWz1kNkvdn+0NCL3
         5HiiYHGGvDtRKItqANL7F+6bE6WrkYqi2utza91lTXlB0lbmeXMD9R7GA+g6n1rkQ5C9
         FuOkuGD1l5UkoXOIGBmRUX7jMS1pxK4qqAsP/OgK/tDZIKQ3Y1IjFeg0/vV1dGrMJI1z
         pRGBqD5bWDBUo02gcTwjCjHqpi/h8XcONr/K1BKw6ikHRqzVxGkn0G/YxqUtR2fjc5wM
         kEM2RIgDDT0U8b3tGmy1GA4bME/dL/RbZL+y8P4KlCz6v9M8+s8vi85S8kAXXG7aBY/H
         A1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vQ2+MktllV/PJmp9XgPImtaLas1ZY14NynJ10f9PsQw=;
        b=rnXeTH4OTDBwftWWqQXGLbuNyhKJFOTVYibQUUNg9VG4/6p5DASjqyZQohk4IaKyDy
         /XEMJ7QhhKrvSmKlTT+sffmWZcF4qcagWGlsRVQcCvBEnzqorcpfviyjl4u4oJHPn1ft
         789iilnsH2Mvy3mKS0gxEy7YsNuQlWgwqx9kQR8IAYartiHi3WxsQeE/zcAAWYWIxm6D
         BxgwxLypl5hV9YCrRW8rha3Cr7E9oEGekWdTRz8Fnr8JybusFt1BNcMKC2MMycL+fyGU
         YquEIEvAD4IHL2IoYoHSDuHLEiMLmcxERim5620fDn4sds1RvTw9LDtvn//4tZcLg3yo
         r3zQ==
X-Gm-Message-State: APjAAAWfltPg95IRmzmnBcbOtyHE4bxXmhX7fNzpxT/+tTTey9znfWtA
        OW68mFQjTl96iTMr9mdBRHA=
X-Google-Smtp-Source: APXvYqw26954QicuKEyjfm/ff7WOHKQs538wrmzsN/dCfZREo4duQ8+qCHCFVboRDCo/vEncgz4zgA==
X-Received: by 2002:a63:d615:: with SMTP id q21mr120562006pgg.401.1558937515418;
        Sun, 26 May 2019 23:11:55 -0700 (PDT)
Received: from namhyung.seo.corp.google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id a64sm8112933pgc.53.2019.05.26.23.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 23:11:54 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCH 4/3] perf tools: Remove const from thread read accessors
Date:   Mon, 27 May 2019 15:11:49 +0900
Message-Id: <20190527061149.168640-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190523023636.GA196218@google.com>
References: <20190523023636.GA196218@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The namespaces and comm fields of a thread are protected by rwsem and
require write access for it.  So it ended up using a cast to remove
the const qualifier.  Let's get rid of the const then.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c   |  2 +-
 tools/perf/util/thread.c | 12 ++++++------
 tools/perf/util/thread.h |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7ace7a10054d..fb3271fd420c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2561,7 +2561,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	char unit;
 	int printed;
 	const struct dso *dso = hists->dso_filter;
-	const struct thread *thread = hists->thread_filter;
+	struct thread *thread = hists->thread_filter;
 	int socket_id = hists->socket_filter;
 	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
 	u64 nr_events = hists->stats.total_period;
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index b413ba5b9835..aab7807d445f 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -141,13 +141,13 @@ static struct namespaces *__thread__namespaces(const struct thread *thread)
 	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
 }
 
-struct namespaces *thread__namespaces(const struct thread *thread)
+struct namespaces *thread__namespaces(struct thread *thread)
 {
 	struct namespaces *ns;
 
-	down_read((struct rw_semaphore *)&thread->namespaces_lock);
+	down_read(&thread->namespaces_lock);
 	ns = __thread__namespaces(thread);
-	up_read((struct rw_semaphore *)&thread->namespaces_lock);
+	up_read(&thread->namespaces_lock);
 
 	return ns;
 }
@@ -271,13 +271,13 @@ static const char *__thread__comm_str(const struct thread *thread)
 	return comm__str(comm);
 }
 
-const char *thread__comm_str(const struct thread *thread)
+const char *thread__comm_str(struct thread *thread)
 {
 	const char *str;
 
-	down_read((struct rw_semaphore *)&thread->comm_lock);
+	down_read(&thread->comm_lock);
 	str = __thread__comm_str(thread);
-	up_read((struct rw_semaphore *)&thread->comm_lock);
+	up_read(&thread->comm_lock);
 
 	return str;
 }
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index cf8375c017a0..e97ef6977eb9 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -76,7 +76,7 @@ static inline void thread__exited(struct thread *thread)
 	thread->dead = true;
 }
 
-struct namespaces *thread__namespaces(const struct thread *thread);
+struct namespaces *thread__namespaces(struct thread *thread);
 int thread__set_namespaces(struct thread *thread, u64 timestamp,
 			   struct namespaces_event *event);
 
@@ -93,7 +93,7 @@ int thread__set_comm_from_proc(struct thread *thread);
 int thread__comm_len(struct thread *thread);
 struct comm *thread__comm(const struct thread *thread);
 struct comm *thread__exec_comm(const struct thread *thread);
-const char *thread__comm_str(const struct thread *thread);
+const char *thread__comm_str(struct thread *thread);
 int thread__insert_map(struct thread *thread, struct map *map);
 int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bool do_maps_clone);
 size_t thread__fprintf(struct thread *thread, FILE *fp);
-- 
2.22.0.rc1.257.g3120a18244-goog

