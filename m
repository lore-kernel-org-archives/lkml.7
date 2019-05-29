Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BFF2229C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137090;
	bh=VHKZYlYltrWBtqaHB1hbRv+QeXeovC2XnQqU04505R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z69SDMBAkbUehhIAR/8ppc4Iz1BWO7A5DlDL0KLl4wrhMQujHJARzGhpQvteoC0uA
	 5cDcBIuNIADdZILRKexTy6vo3zh3/0alUpK+/ojzzj041X8W7VTbrzanEX+vkC1WdY
	 TBjFRdE+wrH16YnQyIsRBOgNdJTbRi9ZKhdHFxEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfE2NiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfE2NiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:38:08 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CBB122353;
        Wed, 29 May 2019 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137086;
        bh=VHKZYlYltrWBtqaHB1hbRv+QeXeovC2XnQqU04505R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEjCWV/L5WKZZ1GMXelQ3yyEI6n5ymReF2k1O7BNpuT+7yrPKs88BT7tO4FmHkz7R
         LgWXtom9pUVP5vG+bNDVDPnRPE2r/40BNLTla9cFpBRzzQRcC+os/mipQfGvFWgPrU
         dA1ISX+NC5HkObLCQiykUaNgOaduDTf9SPKczwGc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/41] perf dso: Separate generic code in dso_cache__read
Date:   Wed, 29 May 2019 10:35:47 -0300
Message-Id: <20190529133605.21118-24-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the file specific code in the dso_cache__read function to a
separate file_read function. I'll add BPF specific code in the following
patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 48 ++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cb6199c1390a..7734f50a6912 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -794,6 +794,31 @@ dso_cache__memcpy(struct dso_cache *cache, u64 offset,
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
+		ret = -errno;
+		goto out;
+	}
+
+	ret = pread(dso->data.fd, data, DSO__DATA_CACHE_SIZE, offset);
+out:
+	pthread_mutex_unlock(&dso__data_open_lock);
+	return ret;
+}
+
 static ssize_t
 dso_cache__read(struct dso *dso, struct machine *machine,
 		u64 offset, u8 *data, ssize_t size)
@@ -803,37 +828,18 @@ dso_cache__read(struct dso *dso, struct machine *machine,
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
2.20.1

