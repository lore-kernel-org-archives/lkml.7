Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1D722469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfKLLUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:20:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33799 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfKLLSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBX-0000YG-HP; Tue, 12 Nov 2019 12:18:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7CB1C1C0483;
        Tue, 12 Nov 2019 12:18:07 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:07 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf dso: Refactor dso_cache__read()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191025130000.13032-3-adrian.hunter@intel.com>
References: <20191025130000.13032-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157355748703.29376.7349254792650617038.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     366df72657e0cd6bd072b56a48e63b8d89718f70
Gitweb:        https://git.kernel.org/tip/366df72657e0cd6bd072b56a48e63b8d89718f70
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 25 Oct 2019 15:59:56 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf dso: Refactor dso_cache__read()

Refactor dso_cache__read() to separate populating the cache from copying
data from it.  This is preparation for adding a cache "write" that will
update the data in the cache.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/20191025130000.13032-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 64 ++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e11ddf8..460330d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -768,7 +768,7 @@ dso_cache__free(struct dso *dso)
 	pthread_mutex_unlock(&dso->lock);
 }
 
-static struct dso_cache *dso_cache__find(struct dso *dso, u64 offset)
+static struct dso_cache *__dso_cache__find(struct dso *dso, u64 offset)
 {
 	const struct rb_root *root = &dso->data.cache;
 	struct rb_node * const *p = &root->rb_node;
@@ -863,54 +863,64 @@ out:
 	return ret;
 }
 
-static ssize_t
-dso_cache__read(struct dso *dso, struct machine *machine,
-		u64 offset, u8 *data, ssize_t size)
+static struct dso_cache *dso_cache__populate(struct dso *dso,
+					     struct machine *machine,
+					     u64 offset, ssize_t *ret)
 {
 	u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
 	struct dso_cache *cache;
 	struct dso_cache *old;
-	ssize_t ret;
 
 	cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
-	if (!cache)
-		return -ENOMEM;
+	if (!cache) {
+		*ret = -ENOMEM;
+		return NULL;
+	}
 
 	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		ret = bpf_read(dso, cache_offset, cache->data);
+		*ret = bpf_read(dso, cache_offset, cache->data);
 	else
-		ret = file_read(dso, machine, cache_offset, cache->data);
+		*ret = file_read(dso, machine, cache_offset, cache->data);
 
-	if (ret > 0) {
-		cache->offset = cache_offset;
-		cache->size   = ret;
+	if (*ret <= 0) {
+		free(cache);
+		return NULL;
+	}
 
-		old = dso_cache__insert(dso, cache);
-		if (old) {
-			/* we lose the race */
-			free(cache);
-			cache = old;
-		}
+	cache->offset = cache_offset;
+	cache->size   = *ret;
 
-		ret = dso_cache__memcpy(cache, offset, data, size);
+	old = dso_cache__insert(dso, cache);
+	if (old) {
+		/* we lose the race */
+		free(cache);
+		cache = old;
 	}
 
-	if (ret <= 0)
-		free(cache);
+	return cache;
+}
 
-	return ret;
+static struct dso_cache *dso_cache__find(struct dso *dso,
+					 struct machine *machine,
+					 u64 offset,
+					 ssize_t *ret)
+{
+	struct dso_cache *cache = __dso_cache__find(dso, offset);
+
+	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
 }
 
 static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size)
 {
 	struct dso_cache *cache;
+	ssize_t ret = 0;
 
-	cache = dso_cache__find(dso, offset);
-	if (cache)
-		return dso_cache__memcpy(cache, offset, data, size);
-	else
-		return dso_cache__read(dso, machine, offset, data, size);
+	cache = dso_cache__find(dso, machine, offset, &ret);
+	if (!cache)
+		return ret;
+
+	return dso_cache__memcpy(cache, offset, data, size);
 }
 
 /*
