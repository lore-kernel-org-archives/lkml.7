Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9BEC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF43257C0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VZxAiSLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfE3IKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:10:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfE3IKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:10:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U89moG2904100
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:09:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U89moG2904100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203789;
        bh=xbzSye5RDmUBGSiyMJs4k4QyVNiNyq46ryzLyHHn7Sg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VZxAiSLIDy25O6HeDQFQUJ3dOIkCcTEi1f1bhl9CxX6zX1D+TjlSf6yx+8C0zn408
         iq4XCeEs+lSl4jadlCcyFg0E41REtsIP6YCld+SxGaXz5z2yQ3Qd6p4hbW7XaKz8rF
         aN+Jru/aHyl4H2g5LtKsbGX+iqdeg0SoVvugYLHe/oY34cT4pRbYKaK2NRWLM3Tfxz
         P6mrklYJwcAS6eok0xdDD43wG/S9i1Y/rFuh4m7MFthfVVpZOMH66dv42IAZ31r2o9
         6AcO5CsHvfjcdK1jJimJOHyHECG3VxrDD1yBBBba49ydqWXnCEIeKujyCAlVnToPG1
         vf084PkXfxbQA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U89mbu2904097;
        Thu, 30 May 2019 01:09:48 -0700
Date:   Thu, 30 May 2019 01:09:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cacddfe7b0804752528e8100461266ec33dc6b64@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, songliubraving@fb.com,
        sdf@google.com, acme@redhat.com, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org
Reply-To: jolsa@kernel.org, ak@linux.intel.com, peterz@infradead.org,
          namhyung@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          songliubraving@fb.com, sdf@google.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190508132010.14512-4-jolsa@kernel.org>
References: <20190508132010.14512-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf dso: Simplify dso_cache__read function
Git-Commit-ID: cacddfe7b0804752528e8100461266ec33dc6b64
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

Commit-ID:  cacddfe7b0804752528e8100461266ec33dc6b64
Gitweb:     https://git.kernel.org/tip/cacddfe7b0804752528e8100461266ec33dc6b64
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:01 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf dso: Simplify dso_cache__read function

There's no need for the while loop now, also we can connect two (ret >
0) condition legs together.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 7734f50a6912..1e6a045adb8c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -823,25 +823,20 @@ static ssize_t
 dso_cache__read(struct dso *dso, struct machine *machine,
 		u64 offset, u8 *data, ssize_t size)
 {
+	u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
 	struct dso_cache *cache;
 	struct dso_cache *old;
 	ssize_t ret;
 
-	do {
-		u64 cache_offset = offset & DSO__DATA_CACHE_MASK;
-
-		cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
-		if (!cache)
-			return -ENOMEM;
-
-		ret = file_read(dso, machine, cache_offset, cache->data);
+	cache = zalloc(sizeof(*cache) + DSO__DATA_CACHE_SIZE);
+	if (!cache)
+		return -ENOMEM;
 
+	ret = file_read(dso, machine, cache_offset, cache->data);
+	if (ret > 0) {
 		cache->offset = cache_offset;
 		cache->size   = ret;
-	} while (0);
-
 
-	if (ret > 0) {
 		old = dso_cache__insert(dso, cache);
 		if (old) {
 			/* we lose the race */
