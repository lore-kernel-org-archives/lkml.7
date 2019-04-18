Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73900C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B1220675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611076;
	bh=vE9BdeZyuJnjXY3pmuxyXYnKQvG+OyWuX7A+e4ijt9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QbdIJgH7F4hRtbf0mz6/LpieMcloOtjFzetoS7E6OVH0l/yMq00c5ktrqPEcrX76T
	 qUK4K89ELln4N5HiJev59vHTH2FHSF/WNAWcn/j2eQAXeHVtxUZhMufle4Qlcc/3Nv
	 mfPWTBmMBSTO/e+lN7ByeqRr7IICNY85zKES4JBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391906AbfDRSLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391893AbfDRSLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:11:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C122C218CD;
        Thu, 18 Apr 2019 18:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611071;
        bh=vE9BdeZyuJnjXY3pmuxyXYnKQvG+OyWuX7A+e4ijt9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfgoo1qKxt2vM0AWzWD/HJ5XG9qYfAaI9FqIxAoaoFrsATTsSIGJ/vTqP4OyJb1FU
         rqFv1EZrMKtlIxqeaS8oVb8MaONFDzWCeDcTV6cacUBC/gXZcjDVTo/8bD1kYQqI7t
         zVjBYK/HMsx55z/d3QAxB2ODiiEkAFqu0kjdZo0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 48/93] perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()
Date:   Thu, 18 Apr 2019 19:57:26 +0200
Message-Id: <20190418160442.507531486@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index ea7acf403727..71f60c0f9faa 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -85,5 +85,6 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (perf_evsel__test_field(evsel, "target_cpu", 4, true))
 		ret = -1;
 
+	perf_evsel__delete(evsel);
 	return ret;
 }
-- 
2.19.1



