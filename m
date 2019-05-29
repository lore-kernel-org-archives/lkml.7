Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DA3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D58122387
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137094;
	bh=LI+1NE8W6QnWQh+jNaxqjajm5NEEX9BIy8mk3cg+sxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TKH1APWXUiHJ9FDpcn1VjrNRBzZm1TOjIrcl87YYBANV74YbgzQkXdmyrSiXWD0e5
	 lmE2fPYxBtXBqrvfmgtdvvvn6/MoSYEP6XE4yFiCSzDXgt0Sxs7vuCJaqS4Zhwnozh
	 jIzsxzVkl2//jGVkLWpnGUCSl3PoKyVSc6gGJpJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfE2NiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfE2NiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:38:12 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3F622389;
        Wed, 29 May 2019 13:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137092;
        bh=LI+1NE8W6QnWQh+jNaxqjajm5NEEX9BIy8mk3cg+sxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CB+HQ+YQPNVs3dR5q8x1iesKF4+W+tlGP/6Cn6Gma6EZy7Sch47WUwSXWk+bKUB4y
         65PrMjg9jduUZ07WM/Nq9rAnHnQL42aIceVsk0A2nFd8L+FqprJd4S2JjDEO5Ppwx7
         idnTC2kOAP2YmePa5jxSgGuS98dDyOinzD2NFonc=
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
Subject: [PATCH 24/41] perf dso: Simplify dso_cache__read function
Date:   Wed, 29 May 2019 10:35:48 -0300
Message-Id: <20190529133605.21118-25-acme@kernel.org>
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
-- 
2.20.1

