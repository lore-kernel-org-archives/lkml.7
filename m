Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B03C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0104D218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhMucaCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCPIIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:08:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so5151647pfn.9;
        Sat, 16 Mar 2019 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+aIoGpXNXhUuHuJTYweNlKodTEQmo6PQ3ULkzpNA1B0=;
        b=bhMucaCck1o075yE4rPNS5sHik+KzYKcOOFmAo7MewyZfnn6bdxYCEhscIu+Gp4TOs
         FntvMZo4HWKbKtWXEYIajS6yTFeIYrNTz9V4c5hBoZfPz9LFNy1kpgEF9tO0QyBIi5A8
         7S6JaZ2rtx0I+jEoCtQOi7wsGScyfq+iQyvye+pXM53Lecg1HnP/9S+WEBO8OFc64Hh3
         Wkzk+bai6JMyo8Yjcr84WUWAEy9zYsrOAnOYgo1yDQX9bzhlS2a454exKixKYZuUdMkR
         sczY5mRaI/VyGWDrWX/Lllqsw85zUeSYliV8MdVHs/Lw2EK2PYKy3C1x1jmy4MEyJsS2
         4ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+aIoGpXNXhUuHuJTYweNlKodTEQmo6PQ3ULkzpNA1B0=;
        b=k5t0dqWuyyJQdoWsNa6O4E72kPKTLxMr3f4pQcpKpE9hhxangaiHLbSww1cCpWMznn
         y6sRBC/DuS0g1zJIS3utbEbSjY3FpPnMystjkn2PslNQphLmL5RecS+XeQVwut+oxkPz
         T/PHxfN7/Nn/T3aUfpArbpKQe2iQnhCvHzU6mymo538jpg4P0pbkAi0hr8aBXON0Advz
         cWeSEi3PHtBAGSfus6q+4K1gMl7pLGJMHUdkZolIj7RYX47eSDIjZBlNvbC1tjXkTctt
         LFFlxXGmYG9YzcxPrHUmSuLwocrdDFAvjeIPmCPQB2I19vOnoxKolf27Vu8vo+++CcxL
         sd5w==
X-Gm-Message-State: APjAAAVaaHnFkam/xxa+E7yYuQn7N/Ypk+/KacJgaoAA8t2g9GX3kgwT
        jazFElEo40j3DI64z+fL4wU=
X-Google-Smtp-Source: APXvYqw7BK+t/C1cjbXIe9BDSQKOQxeoZKrUFlRPJrSFpLfgQqzr73WrK0klQCAMwLp9WhBnIgqjSg==
X-Received: by 2002:a63:e416:: with SMTP id a22mr7375996pgi.338.1552723677851;
        Sat, 16 Mar 2019 01:07:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 16/16] perf: fix a memory leak in test__perf_evsel__tp_sched_test
Date:   Sat, 16 Mar 2019 16:05:56 +0800
Message-Id: <20190316080556.3075-17-changbin.du@gmail.com>
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

