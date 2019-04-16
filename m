Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF863C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBF5217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430517;
	bh=2jZ8h0GLGWDPKhQTGsnHswG3zwAQ+AAC0wnRPgyHvIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Re5wbI6RD2Dn5enLDdiTs0i8MSnxrXeKMDnz98n/ot30nPyCRLOYsNNrew+QvPueQ
	 UYlFOdRQWUHVClBuz6LqCypJhXjkd9Ynfs/51fWq4vzRngFpBUg2CHvPmi0a5T62G3
	 Ox2yVGh+hwIj1a279hh+QH3q24eqDA8J2305kf7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfDPQB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfDPQBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AE2830842A0;
        Tue, 16 Apr 2019 16:01:52 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 405005D71B;
        Tue, 16 Apr 2019 16:01:50 +0000 (UTC)
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
Subject: [PATCH 06/12] perf tools: Do not erase uncovered maps by kcore
Date:   Tue, 16 Apr 2019 18:01:21 +0200
Message-Id: <20190416160127.30203-7-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 16 Apr 2019 16:01:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maps in kcore do not cover bpf maps, so we can't just
remove everything. Keeping all kernel maps, which are
not covered by kcore maps.

Link: http://lkml.kernel.org/n/tip-9eytka8wofp0a047ul6lmejk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 5cbad55cd99d..96738a7a8c14 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1166,6 +1166,18 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	return 0;
 }
 
+static bool in_kcore(struct kcore_mapfn_data *md, struct map *map)
+{
+	struct map *iter;
+
+	list_for_each_entry(iter, &md->maps, node) {
+		if ((map->start >= iter->start) && (map->start < iter->end))
+			return true;
+	}
+
+	return false;
+}
+
 static int dso__load_kcore(struct dso *dso, struct map *map,
 			   const char *kallsyms_filename)
 {
@@ -1222,7 +1234,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	while (old_map) {
 		struct map *next = map_groups__next(old_map);
 
-		if (old_map != map)
+		if (old_map != map && !in_kcore(&md, old_map))
 			map_groups__remove(kmaps, old_map);
 		old_map = next;
 	}
-- 
2.17.2

