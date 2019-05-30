Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B16CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D767257B7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LB7XEjAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfE3IJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:09:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfE3IJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:09:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U897Nq2904031
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:09:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U897Nq2904031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203748;
        bh=Alf6jg6h+dfedKR7HcB98amyAjzZPc7CUtF0++zjjws=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LB7XEjAVdz/DqIDbqWnlYE4hYygLF/G5Tx9x3jj9q28DgV6F8ZUDlsuv+l+8nbgQX
         YqPDhgPlwDFVcmQKWwvRCT2b5T9xBXRleuVv04mBmT03KLrkST0Z0CDi9EwBUiuXfH
         6F8X2wjxm9uLyCbsGbCZnpU+p5q61B6XIp4Un5XqC76z7p2cxVeypwm52o3pP3QrSN
         kcXe4lTyJBe3BkZN0aU6ELT9LFbgBBUPMmKLNDyDDG1JTKwfKEIxTXus1wkx/CuPcd
         PB2D/IUF276NrEfj0JtUzc4FpN1a8dEZGftbLAHrsEDOLSirpubp9m3U8jHTuDt2hW
         lMqv/fAZXwZEg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U897AB2904028;
        Thu, 30 May 2019 01:09:07 -0700
Date:   Thu, 30 May 2019 01:09:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ea5db1bd5a04b865bc86bb8e3267c27939dfb5ee@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, acme@redhat.com, songliubraving@fb.com,
        ak@linux.intel.com, sdf@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          peterz@infradead.org, sdf@google.com, adrian.hunter@intel.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          songliubraving@fb.com, ak@linux.intel.com, jolsa@kernel.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190508132010.14512-3-jolsa@kernel.org>
References: <20190508132010.14512-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf dso: Separate generic code in dso_cache__read
Git-Commit-ID: ea5db1bd5a04b865bc86bb8e3267c27939dfb5ee
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

Commit-ID:  ea5db1bd5a04b865bc86bb8e3267c27939dfb5ee
Gitweb:     https://git.kernel.org/tip/ea5db1bd5a04b865bc86bb8e3267c27939dfb5ee
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:00 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf dso: Separate generic code in dso_cache__read

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
 tools/perf/util/dso.c | 48 +++++++++++++++++++++++++++---------------------
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
