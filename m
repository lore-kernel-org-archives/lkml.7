Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C459DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A660621D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504662AbfJYNBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:01:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:41239 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504641AbfJYNBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:01:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 06:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="201802287"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.55])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 06:01:11 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/6] perf dso: Refactor dso_cache__read()
Date:   Fri, 25 Oct 2019 15:59:56 +0300
Message-Id: <20191025130000.13032-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025130000.13032-1-adrian.hunter@intel.com>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor dso_cache__read() to separate populating the cache from copying
data from it.  This is preparation for adding a cache "write" that will
update the data in the cache.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/dso.c | 64 +++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e11ddf86f2b3..460330d125b6 100644
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
@@ -863,54 +863,64 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
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
-- 
2.17.1

