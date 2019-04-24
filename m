Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE736C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC76E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128991;
	bh=XoFP+4kogK424tY2vshglJa0wPTk4g+k+LJ7SFF1kxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1CF5OJI4DW5YOA3943SOcVkja/8uE8fl6Om0gNrAzPgrHJ0eEUUzD3ASCKDZw+JCp
	 nuN2iY2no6LNutdI57dKgvs2ANxJadBjzEI1katdsxjHLyJYw+ayTWKorFFTIKVtry
	 NUNp0yi3ci6wZMCAeL4ozS7qx0NZBnCVISO8p45E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfDXRUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389205AbfDXRUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:20:43 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BDC2190A;
        Wed, 24 Apr 2019 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126442;
        bh=XoFP+4kogK424tY2vshglJa0wPTk4g+k+LJ7SFF1kxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LadEDx0EVPOAN6capQVW2XbG5tWOL9+avmX2uJ+trCT/sPYf88CZOO3E1yKKSwkPu
         YWgdinVL+l/DcA18zgROpN/Y0JDrov3lrCArVfI8Ian1nHhLthoaFncec3FX9wi85N
         udeGJhsCEEna3bA5nPXPtBuqY/jD42CGLBjzer6I=
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
Subject: [PATCH 4.4 112/168] perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()
Date:   Wed, 24 Apr 2019 19:09:16 +0200
Message-Id: <20190424170930.134805490@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
index da474d743b6a..37529f73833d 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -84,5 +84,6 @@ int test__perf_evsel__tp_sched_test(void)
 	if (perf_evsel__test_field(evsel, "target_cpu", 4, true))
 		ret = -1;
 
+	perf_evsel__delete(evsel);
 	return ret;
 }
-- 
2.19.1



