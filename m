Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE10C06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BBC2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279917;
	bh=8eLk1T62RvfbkjDTgH2weNUcQeTmuO21UyDdivJsmwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cFpVHm0kVScgtscq10GquVQrdnM5NZsJosdlO15H67ZKGIf8Ero4EQt0BNRoYQq5E
	 nPeEsO7i9ntOz5tURSub39SbEjnmO2jxpT6TRsbx0SkFXlH4uzg8PHH8Rv5smgi3hr
	 MYFMHmdG3JkVNh/yLbPQvkA83f9u8mADwjH1UoZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407433AbfFKTFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405965AbfFKTFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:05:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1915021850;
        Tue, 11 Jun 2019 19:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279912;
        bh=8eLk1T62RvfbkjDTgH2weNUcQeTmuO21UyDdivJsmwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whIz5SzzyYEqDh2zUXwVFVd8PXhSek7aSOpZL57/UiNipcy4XgtctLxtYpdKNdfF5
         vWV2lJglYYNA9CFSaQbgxIcSOJjkhu9D9zRkm3BwWBAdZ+a13X1594bRGY7IIDdnOr
         7rDy6xr3WBzh1y+UuRxW+MBQWuQeCHN/m72Sjj0A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Song Liu <songliubraving@fb.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 85/85] perf trace: Skip unknown syscalls when expanding strace like syscall groups
Date:   Tue, 11 Jun 2019 15:59:11 -0300
Message-Id: <20190611185911.11645-86-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We have $INSTALL_DIR/share/perf-core/strace/groups/string files with
syscalls that should be selected when 'string' is used, meaning, in this
case, syscalls that receive as one of its arguments a string, like a
pathname.

But those were first selected and tested on x86_64, and end up failing
in architectures where some of those syscalls are not available, like
the 'access' syscall on arm64, which makes using 'perf trace -e string'
in such archs to fail.

Since this the routine doing the validation is used only when reading
such files, do not fail when some syscall is not found in the
syscalltbl, instead just use pr_debug() to register that in case people
are suspicious of problems.

Now using 'perf trace -e string' should work on arm64, selecting only
the syscalls that have a string and are available on that architecture.

Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/r/20190610184754.GU21245@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1a2a605cf068..eb70a4b71755 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1529,6 +1529,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0, i;
+	bool printed_invalid_prefix = false;
 	size_t nr_allocated;
 	struct str_node *pos;
 
@@ -1555,14 +1556,15 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			if (id >= 0)
 				goto matches;
 
-			if (err == 0) {
-				fputs("Error:\tInvalid syscall ", trace->output);
-				err = -EINVAL;
+			if (!printed_invalid_prefix) {
+				pr_debug("Skipping unknown syscalls: ");
+				printed_invalid_prefix = true;
 			} else {
-				fputs(", ", trace->output);
+				pr_debug(", ");
 			}
 
-			fputs(sc, trace->output);
+			pr_debug("%s", sc);
+			continue;
 		}
 matches:
 		trace->ev_qualifier_ids.entries[i++] = id;
@@ -1591,15 +1593,14 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 		}
 	}
 
-	if (err < 0) {
-		fputs("\nHint:\ttry 'perf list syscalls:sys_enter_*'"
-		      "\nHint:\tand: 'man syscalls'\n", trace->output);
-out_free:
-		zfree(&trace->ev_qualifier_ids.entries);
-		trace->ev_qualifier_ids.nr = 0;
-	}
 out:
+	if (printed_invalid_prefix)
+		pr_debug("\n");
 	return err;
+out_free:
+	zfree(&trace->ev_qualifier_ids.entries);
+	trace->ev_qualifier_ids.nr = 0;
+	goto out;
 }
 
 /*
-- 
2.20.1

