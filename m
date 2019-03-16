Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DBFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21090218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWAQwMC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfCPIHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41106 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so8000302pgb.8;
        Sat, 16 Mar 2019 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vtohn/46nQHw9sQoNVQFkQ9h5NPZSJ75DEIaxOp29FE=;
        b=iWAQwMC3Fqa2BrnrYORcgjdyr03m+WxVz5Qb18fDBN5E6PRNwjfUXMsRJH0FSZ2Qof
         WXxp3Yaht6ZCgUWa4zJhfutGxvcd4z77tntdUMemrnXIEPW/OvdW+cScPf2VQ3+qXF7r
         6MIQtxI7tEmvYDn6UphmLehwacOjLbxhv3yLOXMUtTEZG5iR9HLkO1bzaneSz4sDweab
         tB3V+uP7GRHBb2lKXh7sKs+7EG2WG1Y7icpXfXtUd4R/5DO09EKnXD8bDO9+y/7FrFsc
         Z7K3rJ4L8yVAkRtaRDAo+XdJLfQoMbxXthDFrgCw4sLYKecIymzQEENdfY9zvfsefMJx
         Bm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vtohn/46nQHw9sQoNVQFkQ9h5NPZSJ75DEIaxOp29FE=;
        b=NbiuLWK15bZVTPJDMwCq6YXSX/7UCHAh5hPsjGLDJTXqpOnVW8KZKaK16+meG5JJly
         YtPXwr00OTZBMAyDRnmbsNX/bappQzzJUs+y/2cXtqtQpt41RrK5MNaon4QleO2T8isr
         nJ+8Jl2rffjILREgQfezsZZAzGELCFOXmvQxV9AQ0u+3/iXE7ME0/BpgwfwNdst4Ut5L
         PlTn2SQmP0DEmHx5AMXZfYkQ197VGh00rgwnKG6CnPJxGHNGlDz8CYJZFgnA6KsPGdgR
         dtmFEyRz9VzrvwDVumTHQpQYSoDcwb5zDsgZCma+XQv8FxIZZ7ZXnwA6jahjkYL61qNN
         vPrA==
X-Gm-Message-State: APjAAAXmB7HGJMvv5bin5nzEiyfi3xuk45noJg6+M8nRwARzUfZLgPnO
        qF95l7Zd4YdAVdgc/woRsS4=
X-Google-Smtp-Source: APXvYqzax8GEFrPC20FpUmxvCjN1HosZg5fxVKJVh6RGyABcrMO3QoGHKPNQosvZcOteTBFXR5xXKQ==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15mr8271131plm.124.1552723672029;
        Sat, 16 Mar 2019 01:07:52 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 15/16] perf: fix memory leak by expr__find_other
Date:   Sat, 16 Mar 2019 16:05:55 +0800
Message-Id: <20190316080556.3075-16-changbin.du@gmail.com>
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
==7506==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 13 byte(s) in 3 object(s) allocated from:
    #0 0x7f03339d6070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
    #1 0x5625e53aaef0 in expr__find_other util/expr.y:221
    #2 0x5625e51bcd3f in test__expr tests/expr.c:52
    #3 0x5625e51528e6 in run_test tests/builtin-test.c:358
    #4 0x5625e5152baf in test_and_print tests/builtin-test.c:388
    #5 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
    #6 0x5625e515572f in cmd_test tests/builtin-test.c:722
    #7 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #8 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #9 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #10 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
    #11 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/tests/expr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 01f0706995a9..9acc1e80b936 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -19,7 +19,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	const char *p;
 	const char **other;
 	double val;
-	int ret;
+	int i, ret;
 	struct parse_ctx ctx;
 	int num_other;
 
@@ -56,6 +56,9 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", !strcmp(other[1], "BAZ"));
 	TEST_ASSERT_VAL("find other", !strcmp(other[2], "BOZO"));
 	TEST_ASSERT_VAL("find other", other[3] == NULL);
+
+	for (i = 0; i < num_other; i++)
+		free((void *)other[i]);
 	free((void *)other);
 
 	return 0;
-- 
2.19.1

