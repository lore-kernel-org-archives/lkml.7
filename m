Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0D3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B520422469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfKLLUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:20:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfKLLSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBb-0000Xg-4l; Tue, 12 Nov 2019 12:18:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EAC0C1C04E4;
        Tue, 12 Nov 2019 12:18:06 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:06 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf dso: Add dso__data_write_cache_addr()
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
In-Reply-To: <20191025130000.13032-4-adrian.hunter@intel.com>
References: <20191025130000.13032-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157355748656.29376.15994651353584958098.tip-bot2@tip-bot2>
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

Commit-ID:     b86a9d918a389162803d833d4dc491fde9b62fa2
Gitweb:        https://git.kernel.org/tip/b86a9d918a389162803d833d4dc491fde9b62fa2
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 25 Oct 2019 15:59:57 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf dso: Add dso__data_write_cache_addr()

Add functions to write into the dso file data cache, but not change the
file itself.

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
Link: http://lore.kernel.org/lkml/20191025130000.13032-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 73 +++++++++++++++++++++++++++++++++---------
 tools/perf/util/dso.h |  7 ++++-
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 460330d..0f1b772 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -827,14 +827,16 @@ out:
 	return cache;
 }
 
-static ssize_t
-dso_cache__memcpy(struct dso_cache *cache, u64 offset,
-		  u8 *data, u64 size)
+static ssize_t dso_cache__memcpy(struct dso_cache *cache, u64 offset, u8 *data,
+				 u64 size, bool out)
 {
 	u64 cache_offset = offset - cache->offset;
 	u64 cache_size   = min(cache->size - cache_offset, size);
 
-	memcpy(data, cache->data + cache_offset, cache_size);
+	if (out)
+		memcpy(data, cache->data + cache_offset, cache_size);
+	else
+		memcpy(cache->data + cache_offset, data, cache_size);
 	return cache_size;
 }
 
@@ -910,8 +912,8 @@ static struct dso_cache *dso_cache__find(struct dso *dso,
 	return cache ? cache : dso_cache__populate(dso, machine, offset, ret);
 }
 
-static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
-			      u64 offset, u8 *data, ssize_t size)
+static ssize_t dso_cache_io(struct dso *dso, struct machine *machine,
+			    u64 offset, u8 *data, ssize_t size, bool out)
 {
 	struct dso_cache *cache;
 	ssize_t ret = 0;
@@ -920,16 +922,16 @@ static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
 	if (!cache)
 		return ret;
 
-	return dso_cache__memcpy(cache, offset, data, size);
+	return dso_cache__memcpy(cache, offset, data, size, out);
 }
 
 /*
  * Reads and caches dso data DSO__DATA_CACHE_SIZE size chunks
  * in the rb_tree. Any read to already cached data is served
- * by cached data.
+ * by cached data. Writes update the cache only, not the backing file.
  */
-static ssize_t cached_read(struct dso *dso, struct machine *machine,
-			   u64 offset, u8 *data, ssize_t size)
+static ssize_t cached_io(struct dso *dso, struct machine *machine,
+			 u64 offset, u8 *data, ssize_t size, bool out)
 {
 	ssize_t r = 0;
 	u8 *p = data;
@@ -937,7 +939,7 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
 	do {
 		ssize_t ret;
 
-		ret = dso_cache_read(dso, machine, offset, p, size);
+		ret = dso_cache_io(dso, machine, offset, p, size, out);
 		if (ret < 0)
 			return ret;
 
@@ -1021,8 +1023,9 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
 	return dso->data.file_size;
 }
 
-static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
-				u64 offset, u8 *data, ssize_t size)
+static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
+				      u64 offset, u8 *data, ssize_t size,
+				      bool out)
 {
 	if (dso__data_file_size(dso, machine))
 		return -1;
@@ -1034,7 +1037,7 @@ static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
 	if (offset + size < offset)
 		return -1;
 
-	return cached_read(dso, machine, offset, data, size);
+	return cached_io(dso, machine, offset, data, size, out);
 }
 
 /**
@@ -1054,7 +1057,7 @@ ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 	if (dso->data.status == DSO_DATA_STATUS_ERROR)
 		return -1;
 
-	return data_read_offset(dso, machine, offset, data, size);
+	return data_read_write_offset(dso, machine, offset, data, size, true);
 }
 
 /**
@@ -1075,6 +1078,46 @@ ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 	return dso__data_read_offset(dso, machine, offset, data, size);
 }
 
+/**
+ * dso__data_write_cache_offs - Write data to dso data cache at file offset
+ * @dso: dso object
+ * @machine: machine object
+ * @offset: file offset
+ * @data: buffer to write
+ * @size: size of the @data buffer
+ *
+ * Write into the dso file data cache, but do not change the file itself.
+ */
+ssize_t dso__data_write_cache_offs(struct dso *dso, struct machine *machine,
+				   u64 offset, const u8 *data_in, ssize_t size)
+{
+	u8 *data = (u8 *)data_in; /* cast away const to use same fns for r/w */
+
+	if (dso->data.status == DSO_DATA_STATUS_ERROR)
+		return -1;
+
+	return data_read_write_offset(dso, machine, offset, data, size, false);
+}
+
+/**
+ * dso__data_write_cache_addr - Write data to dso data cache at dso address
+ * @dso: dso object
+ * @machine: machine object
+ * @add: virtual memory address
+ * @data: buffer to write
+ * @size: size of the @data buffer
+ *
+ * External interface to write into the dso file data cache, but do not change
+ * the file itself.
+ */
+ssize_t dso__data_write_cache_addr(struct dso *dso, struct map *map,
+				   struct machine *machine, u64 addr,
+				   const u8 *data, ssize_t size)
+{
+	u64 offset = map->map_ip(map, addr);
+	return dso__data_write_cache_offs(dso, machine, offset, data, size);
+}
+
 struct map *dso__new_map(const char *name)
 {
 	struct map *map = NULL;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e4dddb7..2f1fcbc 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -285,6 +285,8 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
  *   dso__data_size
  *   dso__data_read_offset
  *   dso__data_read_addr
+ *   dso__data_write_cache_offs
+ *   dso__data_write_cache_addr
  *
  * Please refer to the dso.c object code for each function and
  * arguments documentation. Following text tries to explain the
@@ -332,6 +334,11 @@ ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size);
 bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by);
+ssize_t dso__data_write_cache_offs(struct dso *dso, struct machine *machine,
+				   u64 offset, const u8 *data, ssize_t size);
+ssize_t dso__data_write_cache_addr(struct dso *dso, struct map *map,
+				   struct machine *machine, u64 addr,
+				   const u8 *data, ssize_t size);
 
 struct map *dso__new_map(const char *name);
 struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
