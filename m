Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17A4218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907477;
	bh=GwdED3wv1u5x3pTRf54FEw5wQlX1jB977zMuBd2FGzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ACnBJ4OuEG2IuTh+W4OeZC+8VtBu2h7SyuSnsO5PrTnySgwX+Fr2zr7ug2REqFJC9
	 IKSTwTHqVMVQA31bFPZ0w2zaA6vs4brsju3gD2611q+jczxtnelPMPcdTmYt4NwZHA
	 x9k1uFC4L5GOM27eiM8Oe9R3I2GgtuPntrpN9f1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfC3A54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731529AbfC3A5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:57:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6876206DD;
        Sat, 30 Mar 2019 00:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907472;
        bh=GwdED3wv1u5x3pTRf54FEw5wQlX1jB977zMuBd2FGzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+JodCLqdjGPueZ+UoPRxjpKEshTNL9WO6VNBMhqgM8cTfC7jOG7AQAlv6XxPjQWj
         7BiFkq5go0kcArZHlmA3aEV8CqQ+OZTUd/Spfyqbmf81z0qk0vhDrDwAsOzbItT6JH
         tUgIh2O65WFhecqJiu5YNfDCXRGi6Y5EzUEH9r38=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 11/15] perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()
Date:   Fri, 29 Mar 2019 20:57:26 -0400
Message-Id: <20190330005730.28777-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005730.28777-1-sashal@kernel.org>
References: <20190330005730.28777-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

[ Upstream commit d982b33133284fa7efa0e52ae06b88f9be3ea764 ]

  =================================================================
  ==20875==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 1160 byte(s) in 1 object(s) allocated from:
      #0 0x7f1b6fc84138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
      #1 0x55bd50005599 in zalloc util/util.h:23
      #2 0x55bd500068f5 in perf_evsel__newtp_idx util/evsel.c:327
      #3 0x55bd4ff810fc in perf_evsel__newtp /home/work/linux/tools/perf/util/evsel.h:216
      #4 0x55bd4ff81608 in test__perf_evsel__tp_sched_test tests/evsel-tp-sched.c:69
      #5 0x55bd4ff528e6 in run_test tests/builtin-test.c:358
      #6 0x55bd4ff52baf in test_and_print tests/builtin-test.c:388
      #7 0x55bd4ff543fe in __cmd_test tests/builtin-test.c:583
      #8 0x55bd4ff5572f in cmd_test tests/builtin-test.c:722
      #9 0x55bd4ffc4087 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #10 0x55bd4ffc45c6 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #11 0x55bd4ffc49ca in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #12 0x55bd4ffc5138 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #13 0x7f1b6e34809a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

  Indirect leak of 19 byte(s) in 1 object(s) allocated from:
      #0 0x7f1b6fc83f30 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xedf30)
      #1 0x7f1b6e3ac30f in vasprintf (/lib/x86_64-linux-gnu/libc.so.6+0x8830f)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 6a6cd11d4e57 ("perf test: Add test for the sched tracepoint format fields")
Link: http://lkml.kernel.org/r/20190316080556.3075-17-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/evsel-tp-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 5ce11eac4dd3..959bdb4a79ad 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -78,5 +78,6 @@ int test__perf_evsel__tp_sched_test(void)
 	if (perf_evsel__test_field(evsel, "target_cpu", 4, true))
 		ret = -1;
 
+	perf_evsel__delete(evsel);
 	return ret;
 }
-- 
2.19.1

