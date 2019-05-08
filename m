Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42673C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C7520850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557321626;
	bh=uTBJCS+7VLrB9E2aBfVd9GVMnyqZvxQ3lIUf6H9D1mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fWZEGiHjC2h1UzVgcSjMTUV/XvbBJeBC3PeI1bpu79zaB6xXQK3WQ3tXmonrACZv8
	 4mb3cz7BVTmvzlpCnYESchb3l/So6/vnyQR/UIFoUrTZNmNh4EcCeswvmukZ7eNldu
	 hFgbfVQ0rGoRNHPv3tp8MV+Hz/SVI9DheA/V9jeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfEHNUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfEHNUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:20:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CAAC88312;
        Wed,  8 May 2019 13:20:23 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADACF10027C9;
        Wed,  8 May 2019 13:20:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 02/12] perf tools: Separate generic code in dso_cache__read
Date:   Wed,  8 May 2019 15:20:00 +0200
Message-Id: <20190508132010.14512-3-jolsa@kernel.org>
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 08 May 2019 13:20:23 +0000 (UTC)
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

