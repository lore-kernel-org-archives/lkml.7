Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C286C71142
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0101521537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTp8ixgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfGKRV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:21:26 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49511 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:21:26 -0400
Received: by mail-pf1-f201.google.com with SMTP id 145so3815991pfw.16
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gOacuLj0WmQfTM/SGEvRKG9q+2Su5RYWQ+JdbWVt3D8=;
        b=cTp8ixgA+Kq+0b/GvRG1DaYUMqAOi0uzKAp3ZHgjTG+9KeOcBd3L6FCnaC+ciWqBLA
         AO43ikFBO228cCtYMrbmPSDZjvuSAajl5HC1fkquebNOuwy+AoCnK6oPzeNGbHq30as5
         9D0Ts9pef0nwZ4Py8edQHAI+EAnA97rkIEQ7TcU5cqnHVHtKZ8XAmNkoXTGgmfWcboo9
         yeiCTAknlCHZitm544zQ1/sIUDVDEl7TtcfVDLxMj2ynIDMBNUVcjw5gpis+3kNkcHEJ
         THg3gFOAcLLdfBsai3GocaCWIyXF4Uh2yk91iUbMh+36Axne/8HFOe+CNmWjFPvP3yWu
         QNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gOacuLj0WmQfTM/SGEvRKG9q+2Su5RYWQ+JdbWVt3D8=;
        b=cFkZ2/+yyestwGM+k95XxQ2k7febtXwtBHd2aXnHUjvZe5+2SZo9KnJrLqj37ylz4b
         OE2+WAQDnz4xjtqSaP9lVZJ4F1eX6mAmNVKlp+3eagD2Doe4vl5E8hdEHcscmIrLufpP
         wrTsL86SEBIq2MC9KFqgkSycGSwCTYa5w03+TWLMvlwE+WNhAnxhrDCPX92ynuaDL2iV
         CIHhwsXEtPDjbEt+/pOM6b7qKbr4iavGiI1h9m3jdoUyyoG44Q2KvOYsOBYLqJvo8E5n
         PTxPTpdinURo2wLMuME/U5HWnnQTlguhp/TjU8/wtKe+8BLSs2yxBBlvirE1/TMW8vg7
         RiaA==
X-Gm-Message-State: APjAAAVEwaBLpfdi3VGFNRU6KUm6aKQKx2yS52Tv8dlI/SzVy53Xnr+4
        nMxG7/sYETnvpQUK8492AGFe91jQ
X-Google-Smtp-Source: APXvYqySNEvzt3pchVvgZJaCc430HruosxTXOgSSdHRm1JJwIN0uxmQV/e0uSNM6TNTT1KA7dVMAtE7P
X-Received: by 2002:a63:1b07:: with SMTP id b7mr5486155pgb.133.1562865685025;
 Thu, 11 Jul 2019 10:21:25 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:21:19 -0700
Message-Id: <20190711172119.236501-1-nums@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] Fix perf stat repeat segfault
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf stat is called with event groups and the repeat option,
a segfault occurs because the cpu ids are stored on each iteration
of the repeat, when they should only be stored on the first iteration,
which causes a buffer overflow.

This can be replicated by running (from the tip directory):

make -C tools/perf

then running:

tools/perf/perf stat -e '{cycles,instructions}' -r 10 ls

Since run_idx keeps track of the current iteration of the repeat,
only storing the cpu ids on the first iteration (when run_idx < 1)
fixes this issue.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/builtin-stat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc7f32b..00a13ce17fd9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -378,9 +378,10 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static bool perf_evsel__should_store_id(struct perf_evsel *counter)
+static bool perf_evsel__should_store_id(struct perf_evsel *counter, int run_idx)
 {
-	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
+	return (STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID)
+		&& run_idx < 1;
 }
 
 static bool is_target_alive(struct target *_target,
@@ -503,7 +504,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (l > stat_config.unit_width)
 			stat_config.unit_width = l;
 
-		if (perf_evsel__should_store_id(counter) &&
+		if (perf_evsel__should_store_id(counter, run_idx) &&
 		    perf_evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

