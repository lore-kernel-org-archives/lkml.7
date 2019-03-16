Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6194DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3184A218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8UfYnxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfCPIHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38534 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id v1so3300604pgi.5;
        Sat, 16 Mar 2019 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCZjpID9xjv4D6CAOc6jRaR7J2FLx5TBiszJf1ttI7o=;
        b=n8UfYnxhGWyxnpFCfuA5/m8i9H6q8eENB6Wv41l1U7by9W0trzwJI2sLomJRFre5um
         1RmR05aJZF/s1MdlEv75TqJg8zKWZa1rmOcJHKeIQ5t6uN/KoEFscS3Z6FUB1+e7C4R7
         M5hqUsynchcJfIRI7g9ndRR3iZ1jXIxP+l2HOjMJdIuU8HK/KJP0ZCOHNCYQ5fj42gQ9
         q7anQABOe6Hwu8aPdmCfbGLJNgYdGpbFGLZF3haRK/mJQFKWqI4whsoDKzhnRUYynS5f
         RZNjZQgKohzpwzFRy1NHU1lDHaA33Hg7BsH8WT/BqkNRFuqd9tWIE3bSqVWoiqmgYAQ4
         W1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCZjpID9xjv4D6CAOc6jRaR7J2FLx5TBiszJf1ttI7o=;
        b=hGEtMJmF6m4LhWTZYRKN7/Qf4PWN94AeEPPK9RTIeDgsOjMMdK+/6hh3WWXgd/A8oA
         srJET8zsc1Mf+6txM50qSLdpsWABFPuwX32C2XHG/yliKxehqOn6cghXO5WuWczqg50L
         GKJFWGggGZGRXqTnp3ndQWZsE0OaNCOK5zoxhjZOon/TH9rhJcg7OSGUKotZPcDb5gOp
         VbniugEc1ezCIPfVF58NLhJ3UWGI4H6quqOcH6CEIuNkKZru0G48YE2HZWYOOm1hH1wO
         5AnD9F08XqxhOpOubzYhcWo3jrFxwNM76TCQJt8FV33cNWk6Ojs7Hr19SGn3TvsRpjlb
         hagw==
X-Gm-Message-State: APjAAAXh4OeH9zuH6wRfNq+gxIXSkbgJ9/foDgjaBQpfOsDrOgoVTCA3
        asp5JDldbGWN2Gr6Rb3sIx4=
X-Google-Smtp-Source: APXvYqzMpE2maRWdi2dyA8KanZWvQJCvJt7yYqMYwYi8jafTZPgTBRn0HRIrSsjjZ4rGviNr9hMBwg==
X-Received: by 2002:a63:2146:: with SMTP id s6mr6576153pgm.192.1552723623449;
        Sat, 16 Mar 2019 01:07:03 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:02 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 06/16] perf: fix memory leak in print_sdt_events()
Date:   Sat, 16 Mar 2019 16:05:46 +0800
Message-Id: <20190316080556.3075-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct leak of 4356 byte(s) in 120 object(s) allocated from:
    #0 0x7ff1a2b5a070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
    #1 0x55719aef4814 in build_id_cache__origname util/build-id.c:215
    #2 0x55719af649b6 in print_sdt_events util/parse-events.c:2339
    #3 0x55719af66272 in print_events util/parse-events.c:2542
    #4 0x55719ad1ecaa in cmd_list /home/changbin/work/linux/tools/perf/builtin-list.c:58
    #5 0x55719aec745d in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #6 0x55719aec7d1a in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #7 0x55719aec8184 in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #8 0x55719aeca41a in main /home/changbin/work/linux/tools/perf/perf.c:520
    #9 0x7ff1a07ae09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/build-id.c     | 1 +
 tools/perf/util/parse-events.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index bff0d17920ed..0c5517a8d0b7 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -185,6 +185,7 @@ char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size)
 	return bf;
 }
 
+/* The caller is responsible to free the returned buffer. */
 char *build_id_cache__origname(const char *sbuild_id)
 {
 	char *linkname;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2e9035c4c252..5ef4939408f2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2342,6 +2342,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 				printf("  %-50s [%s]\n", buf, "SDT event");
 				free(buf);
 			}
+			free(path);
 		} else
 			printf("  %-50s [%s]\n", nd->s, "SDT event");
 		if (nd2) {
-- 
2.19.1

