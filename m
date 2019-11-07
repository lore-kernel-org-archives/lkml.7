Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55437C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4F521D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153450;
	bh=9B54RCbTGbadaV6mb/l4/IyxSDOfSxmvxe6WTitAZb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p0ukwrYmUL4/yAj41VK+anJmosZkWG1kX9ZB3UEcNRU+yCtgvyQzQ1KqKuHM2xBwG
	 aw9npmLK2BHrR6aDRsGxOteM7iosXEOUzFpn98AIBnlQfv4Do+G+aw0XkJdLeZfYlC
	 piy+e1F10ZlyA88wbV0IUZzlHtXmQxB6cBwcCzXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfKGTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfKGTEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:08 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C95E218AE;
        Thu,  7 Nov 2019 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153447;
        bh=9B54RCbTGbadaV6mb/l4/IyxSDOfSxmvxe6WTitAZb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4x3tWwfF4f/fABjkPXw8MBEeY1eywEXuoU3TdXtKb8w3XM+U1Ra5VWAcxa3UBDuw
         CSC0M33s9jgOISLRO9LG8nVE7FYsi3suvwX5CNSQcVHLUB9jMDmfv8VdCExpe5TBCy
         Dru/H4NLIJhvV12jXryC/8r9oF/EXdQQQdwYDUeo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/63] perf dso: Refactor dso_cache__read()
Date:   Thu,  7 Nov 2019 15:59:34 -0300
Message-Id: <20191107190011.23924-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
2.21.0

