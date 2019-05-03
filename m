Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FE7C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087822087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556871590;
	bh=yTguSNGS848RgShsUrhqcxpymd5q08/q3h/xTFi+GBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jFQHvdp5bBE6BON4BAlaT2+4vQNJBOTp9S8D6QvjbqsfdnvTgiXJeqIsWGEvDZjR0
	 tnCLew6qJmskK6FMxJSbdno5Qg95yk1ub9/2NgBWwa8UuVX0t8XwBNj6/pLk0XvemG
	 sWdKXDJRHO590R0lhqYgDcYmHtAfUzp/NjSfCHYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfECIS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:18:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfECIS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:18:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18612307EA92;
        Fri,  3 May 2019 08:18:56 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA2C5F6E6;
        Fri,  3 May 2019 08:18:53 +0000 (UTC)
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
Subject: [PATCH 03/12] perf tools: Simplify dso_cache__read function
Date:   Fri,  3 May 2019 10:18:32 +0200
Message-Id: <20190503081841.1908-4-jolsa@kernel.org>
In-Reply-To: <20190503081841.1908-1-jolsa@kernel.org>
References: <20190503081841.1908-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 03 May 2019 08:18:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for the while loop now, also we can
connect two (ret > 0) condition legs together.

Link: http://lkml.kernel.org/n/tip-2vg28bak8euojuvq33cy2hl5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.20.1

