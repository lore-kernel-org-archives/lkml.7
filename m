Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4276C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78912206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430556;
	bh=waChlQWVC7Sjzre03+E1jPi0BdA48ZE8hdQMEn/6jCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0A41Jmw+KmNt1pYRhRwf4MOQ5bcSOZhkFtnyvvo5GuY4e6YmNalKHBA4zOhFytwca
	 3nyJjtMOGR9TKF1zX/1BfqxvCB5jB9LehXKmMxeV7zWB+Wi084ePUJg5BXuKTEJF+3
	 60FfeuMmzg0agxONO6dJPwTSSh4f2eamgnDr6S9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfDPQBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:01:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbfDPQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:01:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B553E7FDE9;
        Tue, 16 Apr 2019 16:01:44 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 698675D71A;
        Tue, 16 Apr 2019 16:01:42 +0000 (UTC)
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
Subject: [PATCH 03/12] perf tools: Simplify dso_cache__read function
Date:   Tue, 16 Apr 2019 18:01:18 +0200
Message-Id: <20190416160127.30203-4-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 16 Apr 2019 16:01:45 +0000 (UTC)
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
index 6baad22ec8a9..6fdff723e55a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -822,25 +822,20 @@ static ssize_t
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
2.17.2

