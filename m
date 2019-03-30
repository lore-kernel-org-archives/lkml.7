Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55D8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62C4206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907782;
	bh=LLirDe/7dVHKGnJPHFuQs5+t0wYM8N7KnD9UdgI4a2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qFIpJfZ8et5neuiiD3Zqej3iwWziCfU5MXNIW3qKXHHXC6wOa1b6ukP5t6t4JHKiG
	 nlCT+ktTIy8oWzzNtkCXZtyo9XsTKdZQGx02su7UvzYdvH05WpZTFBDTB1296XTRUL
	 /la8GscitKUhkj+ZFiV7OTx/37kofGVNtKNfS63M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfC3BDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731759AbfC3Azd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCFE218D3;
        Sat, 30 Mar 2019 00:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907332;
        bh=LLirDe/7dVHKGnJPHFuQs5+t0wYM8N7KnD9UdgI4a2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j7piR11FQnuPWmtSKIhiPkwDSwaTSBYbaXykopd4G62yUhmDQI+BEcKl3Szp4Sk+m
         e0etQzLGb54dXYUccqeuWgOWvKakFOdQ0BaKC63rlvaE1cKvvX/t405fx0TSuRhY9I
         tm5qCUXLC9sFRwY17bTiFR/g8raPA2Bw+FGNlDoY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 26/37] perf evsel: Free evsel->counts in perf_evsel__exit()
Date:   Fri, 29 Mar 2019 20:54:27 -0400
Message-Id: <20190330005441.27540-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 42dfa451d825a2ad15793c476f73e7bbc0f9d312 ]

Using gcc's ASan, Changbin reports:

  =================================================================
  ==7494==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 48 byte(s) in 1 object(s) allocated from:
      #0 0x7f0333a89138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
      #1 0x5625e5330a5e in zalloc util/util.h:23
      #2 0x5625e5330a9b in perf_counts__new util/counts.c:10
      #3 0x5625e5330ca0 in perf_evsel__alloc_counts util/counts.c:47
      #4 0x5625e520d8e5 in __perf_evsel__read_on_cpu util/evsel.c:1505
      #5 0x5625e517a985 in perf_evsel__read_on_cpu /home/work/linux/tools/perf/util/evsel.h:347
      #6 0x5625e517ad1a in test__openat_syscall_event tests/openat-syscall.c:47
      #7 0x5625e51528e6 in run_test tests/builtin-test.c:358
      #8 0x5625e5152baf in test_and_print tests/builtin-test.c:388
      #9 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
      #10 0x5625e515572f in cmd_test tests/builtin-test.c:722
      #11 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #12 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #13 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #14 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #15 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

  Indirect leak of 72 byte(s) in 1 object(s) allocated from:
      #0 0x7f0333a89138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
      #1 0x5625e532560d in zalloc util/util.h:23
      #2 0x5625e532566b in xyarray__new util/xyarray.c:10
      #3 0x5625e5330aba in perf_counts__new util/counts.c:15
      #4 0x5625e5330ca0 in perf_evsel__alloc_counts util/counts.c:47
      #5 0x5625e520d8e5 in __perf_evsel__read_on_cpu util/evsel.c:1505
      #6 0x5625e517a985 in perf_evsel__read_on_cpu /home/work/linux/tools/perf/util/evsel.h:347
      #7 0x5625e517ad1a in test__openat_syscall_event tests/openat-syscall.c:47
      #8 0x5625e51528e6 in run_test tests/builtin-test.c:358
      #9 0x5625e5152baf in test_and_print tests/builtin-test.c:388
      #10 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
      #11 0x5625e515572f in cmd_test tests/builtin-test.c:722
      #12 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #13 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #14 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #15 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #16 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

His patch took care of evsel->prev_raw_counts, but the above backtraces
are about evsel->counts, so fix that instead.

Reported-by: Changbin Du <changbin.du@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/n/tip-hd1x13g59f0nuhe4anxhsmfp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evsel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 44c2f62b47a3..0cf6f537f980 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1229,6 +1229,7 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 {
 	assert(list_empty(&evsel->node));
 	assert(evsel->evlist == NULL);
+	perf_evsel__free_counts(evsel);
 	perf_evsel__free_fd(evsel);
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
-- 
2.19.1

