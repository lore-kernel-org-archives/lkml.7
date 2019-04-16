Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E71BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B574206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430506;
	bh=JFED6vjl2aRKYyR0CTCueauRV9NwP9QL5kFDFoH2fd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d7BXYRsK/LJ/4ZjHQd2kBHYesMdJ80ete6yGv4uXY8GXxJD0js70z9kwbihKZxXFi
	 KwDesEQRatpEetovWF13vkak8Vs2FxTb6w0zQlwGMkG8Yg0Nr+u9FVGX5IXg1U8BJv
	 SWiK836AoOsc1wnyQOmGy/Ibr6FbQf07NVpysuq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfDPQBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfDPQBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:01:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B6C581106;
        Tue, 16 Apr 2019 16:01:42 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C50905D71A;
        Tue, 16 Apr 2019 16:01:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 02/12] perf tools: Separate generic code in dso_cache__read
Date:   Tue, 16 Apr 2019 18:01:17 +0200
Message-Id: <20190416160127.30203-3-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 16 Apr 2019 16:01:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving file specific code in dso_cache__read function
into separate file_read function. I'll add bpf specific
code in following patches.

Link: http://lkml.kernel.org/n/tip-7f7d717uzrqt5ka2xp29ige3@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c | 47 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cb6199c1390a..6baad22ec8a9 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -794,6 +794,30 @@ dso_cache__memcpy(struct dso_cache *cache, u64 offset,
 	return cache_size;
 }
 
+static ssize_t file_read(struct dso *dso, struct machine *machine,
+			 u64 offset, char *data)
+{
+	ssize_t ret;
+
+	pthread_mutex_lock(&dso__data_open_lock);
+
+	/*
+	 * dso->data.fd might be closed if other thread opened another
+	 * file (dso) due to open file limit (RLIMIT_NOFILE).
+	 */
+	try_to_open_dso(dso, machine);
+
+	if (dso->data.fd < 0) {
+		dso->data.status = DSO_DATA_STATUS_ERROR;
+		return -errno;
+	}
+
+	ret = pread(dso->data.fd, data, DSO__DATA_CACHE_SIZE, offset);
+	pthread_mutex_unlock(&dso__data_open_lock);
+
+	return ret;
+}
+
 static ssize_t
 dso_cache__read(struct dso *dso, struct machine *machine,
 		u64 offset, u8 *data, ssize_t size)
@@ -803,37 +827,18 @@ dso_cache__read(struct dso *dso, struct machine *machine,
 	ssize_t ret;
 
 	do {
-		u64 cache_offset;
+		u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
 
 		cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
 		if (!cache)
 			return -ENOMEM;
 
-		pthread_mutex_lock(&dso__data_open_lock);
-
-		/*
-		 * dso->data.fd might be closed if other thread opened another
-		 * file (dso) due to open file limit (RLIMIT_NOFILE).
-		 */
-		try_to_open_dso(dso, machine);
-
-		if (dso->data.fd < 0) {
-			ret = -errno;
-			dso->data.status = DSO_DATA_STATUS_ERROR;
-			break;
-		}
-
-		cache_offset = offset & DSO__DATA_CACHE_MASK;
-
-		ret = pread(dso->data.fd, cache->data, DSO__DATA_CACHE_SIZE, cache_offset);
-		if (ret <= 0)
-			break;
+		ret = file_read(dso, machine, cache_offset, cache->data);
 
 		cache->offset = cache_offset;
 		cache->size   = ret;
 	} while (0);
 
-	pthread_mutex_unlock(&dso__data_open_lock);
 
 	if (ret > 0) {
 		old = dso_cache__insert(dso, cache);
-- 
2.17.2

