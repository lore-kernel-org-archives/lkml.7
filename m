Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AB6218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOCRn9zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfCPIHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45506 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPIHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id v21so7896120pfm.12;
        Sat, 16 Mar 2019 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6kM+Os+wJtP1DJ/zgE7532AFUvRcG1Y3Esg+ydUASo=;
        b=LOCRn9zrjNJRcS0KAoxAtB+WPNeCe+4CHTyT6vWhoKQDAwbgtWP/xMCwe5mIZ7NRs8
         rlo74l+zt4Yx3EH1Kj5Iv9seK23IgOjIS6eoTINTHDks5OM1fQ8djDhfP7zKLDxfFK1M
         DTujwhYkXyh2K+BDDJGOQkfkyc03PtGEdRYEJEIExjEurm6mcD5AlmQB77r0YE5JwLw4
         Kb2x01F4DpRAJ2vuMXdEWMxcKfQlV0e0li8/BXqHB6Eddfu/Ngz4aUcwKEPY3KqSCZ50
         8oai9alUcIYMhrp5cJdmQDRgDAIgW7LR6qUH7MbWorzuxzWprZapV7XD+rJM7oE1R+u4
         7oUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6kM+Os+wJtP1DJ/zgE7532AFUvRcG1Y3Esg+ydUASo=;
        b=cKx6LP0j5xmcyLRMjdd+IXvNQtPyzEwHbH6+P6Rb3NYhQ7SWzIGoMPQFw3m3A3arK3
         nrseGE8czsAD9lAIOXFwcMxabIJg86oHKpJTjm1tYGBVD3JGEcaddaXX3amG7yBIVn5m
         Gv/4ClPPll7fCG5mATcZ4pNl8eMH6DEZy7EcNePsiW705CW/uMe5g3s/WzGJOdgy3pno
         gWk1gTQuebEq2wQd1/Lc37reU3kbC6PIES7HV9sM+DhH3GZoH2K1hElb891yDX1h+Hsu
         V4xOinBOAeL99JIRSuszjUcUxEDqIP5Sm1i+yo8H+9USxaQxTH4vFvm7bI49XV8efK0v
         wlNA==
X-Gm-Message-State: APjAAAUfWILYW3eU7J0Cxxm+fkatz42i073lPlxzBeR0NHjGIKy6s6MK
        FRMjugfbtcWsQ4h/yyee7p0=
X-Google-Smtp-Source: APXvYqz4ofDhfvwOHwHwDpG5JK1/H2LO3jl9noDAtvER3jacQN4525MBaQCb3gpNEgzhIMFgr34/8A==
X-Received: by 2002:a62:f201:: with SMTP id m1mr8292435pfh.97.1552723667095;
        Sat, 16 Mar 2019 01:07:47 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:46 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 14/16] perf: fix a memory leak of cpu_map object
Date:   Sat, 16 Mar 2019 16:05:54 +0800
Message-Id: <20190316080556.3075-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=================================================================
==7497==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f0333a88f30 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xedf30)
    #1 0x5625e5326213 in cpu_map__trim_new util/cpumap.c:45
    #2 0x5625e5326703 in cpu_map__read util/cpumap.c:103
    #3 0x5625e53267ef in cpu_map__read_all_cpu_map util/cpumap.c:120
    #4 0x5625e5326915 in cpu_map__new util/cpumap.c:135
    #5 0x5625e517b355 in test__openat_syscall_event_on_all_cpus tests/openat-syscall-all-cpus.c:36
    #6 0x5625e51528e6 in run_test tests/builtin-test.c:358
    #7 0x5625e5152baf in test_and_print tests/builtin-test.c:388
    #8 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
    #9 0x5625e515572f in cmd_test tests/builtin-test.c:722
    #10 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #11 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #12 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #13 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
    #14 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index c531e6deb104..493ecb611540 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -45,7 +45,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 	if (IS_ERR(evsel)) {
 		tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "syscalls", "sys_enter_openat");
 		pr_debug("%s\n", errbuf);
-		goto out_thread_map_delete;
+		goto out_cpu_map_delete;
 	}
 
 	if (perf_evsel__open(evsel, cpus, threads) < 0) {
@@ -119,6 +119,8 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 	perf_evsel__close_fd(evsel);
 out_evsel_delete:
 	perf_evsel__delete(evsel);
+out_cpu_map_delete:
+	cpu_map__put(cpus);
 out_thread_map_delete:
 	thread_map__put(threads);
 	return err;
-- 
2.19.1

