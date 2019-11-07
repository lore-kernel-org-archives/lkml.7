Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D0EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8791021D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153462;
	bh=hScVJfrrvdqn7xc3bPbRnKpIFspvEOtwqRvnaJa9O/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LkhKGNhhKxW2Iqx+mN6PuakSVgEWUK9vKiRbNB9/ANhIEFe7Td08z0ts/POx1lnFk
	 8AjX71/h9WbqolEbK17OzbWATEVfye3oRCTtgHwfKIxzeIQ80WfK+KX/oLxed+wcgZ
	 3FHaJEjGZ4io7+r7Hd+vvjkmICTFCsFZiHzOnPyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfKGTEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfKGTEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:21 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FAFD2085B;
        Thu,  7 Nov 2019 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153459;
        bh=hScVJfrrvdqn7xc3bPbRnKpIFspvEOtwqRvnaJa9O/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueo0AqAJ0LSrtwADl4yTZ5NJdkhmyym3QLLgXw+l0o1urLuKeKr8zS7ebvjybLX1g
         wxQyI4ddLOUWOiYJBWolU2sp61O+dG++ize2tgOMmwHquXm/7/T25QIjYqkZt32ozH
         fFFNJMDVFPkPTK7CdZyNMmECTQqjnVQp+hnb+NIM=
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
Subject: [PATCH 27/63] perf dso: Add dso__data_write_cache_addr()
Date:   Thu,  7 Nov 2019 15:59:35 -0300
Message-Id: <20191107190011.23924-28-acme@kernel.org>
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
 tools/perf/util/dso.c | 73 ++++++++++++++++++++++++++++++++++---------
 tools/perf/util/dso.h |  7 +++++
 2 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 460330d125b6..0f1b77275a86 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -827,14 +827,16 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
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
index e4dddb76770d..2f1fcbc6fead 100644
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
-- 
2.21.0

