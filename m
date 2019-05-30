Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D217EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B4B25701
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="me7/1+DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfE3IIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:08:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfE3IH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:07:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U87fWN2903615
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:07:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U87fWN2903615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203661;
        bh=QWixjzdmohAYpdAUcNAkd2WSNsK3YJGf6dEXKDiw0T0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=me7/1+DHTRwYHXcZfPHVSCB91Ng1+jUJZ3ShY867l1dqXxumlmlQeCYaoCRVlZfMH
         XwxmkdjB2c8627Q2f3oWN9uYqiE98ngd9Rq4w7OhbDOUdLbSVbLohfJYzlzkhZFDw5
         lnPzv4G/5BOZOsjaXWsjkytdaFTRoRvur+NS3x35OB/9i0VNRaFWxzsg6Hjnvf7TxM
         lwdrKXLzfMSFLBU/e+IBtRNaFkRLzfQKSkwd9KHbxb5aNRKC/oNbwPkzJpWMNELrrR
         G2kF9r9WJHHsZHsIOrsrpNPVwzG1K488Q5Id5/yxI8nedr/FccG5pQflmkkq0iv0TO
         S5qj3T4Cloo+A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U87eUt2903612;
        Thu, 30 May 2019 01:07:40 -0700
Date:   Thu, 30 May 2019 01:07:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Namhyung Kim <tipbot@zytor.com>
Message-ID: <tip-7cb10a08df98e643b87d4bc8422e50e9c43b5c60@git.kernel.org>
Cc:     mingo@kernel.org, hbathini@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, acme@redhat.com,
        jolsa@redhat.com, kjlx@templeofstupid.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, kjlx@templeofstupid.com,
          jolsa@redhat.com, acme@redhat.com, namhyung@kernel.org,
          hbathini@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20190527061149.168640-1-namhyung@kernel.org>
References: <20190527061149.168640-1-namhyung@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Remove const from thread read accessors
Git-Commit-ID: 7cb10a08df98e643b87d4bc8422e50e9c43b5c60
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7cb10a08df98e643b87d4bc8422e50e9c43b5c60
Gitweb:     https://git.kernel.org/tip/7cb10a08df98e643b87d4bc8422e50e9c43b5c60
Author:     Namhyung Kim <namhyung@kernel.org>
AuthorDate: Mon, 27 May 2019 15:11:49 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf tools: Remove const from thread read accessors

The namespaces and comm fields of a thread are protected by rwsem and
require write access for it.  So it ended up using a cast to remove
the const qualifier.  Let's get rid of the const then.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Link: http://lkml.kernel.org/r/20190527061149.168640-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
