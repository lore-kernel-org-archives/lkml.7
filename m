Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6216C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF67E218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmvLdUy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfCPIG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:06:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41652 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfCPIG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:06:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so7898001pfn.8;
        Sat, 16 Mar 2019 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rgJvab5dyDapGAETbOTEIoe8FesICc8Vhk23q4gefms=;
        b=mmvLdUy2qsqJ4XMo0WVmM1TOp8bw5EBunUpFacihGneJwN5mNhve4vMMiMFC2frYsQ
         HHD9zcK/3hBvnvLqCq61d4zLlYQVeL6o8XT8PzdP3+E30srN86g+3DSI5t7JGjtxq6PX
         AOuKOYcuWnQZ1UyBOnLcp5oeQZ/xEwj3zgaVA9RXZECe4Hs9wZ7Lvt9GCQI9s0s8/hr3
         HsfLNDVQtCKXRgb1VvNIjq6CFTP8krRMghbIF9NhH5iiJjY1MRye+VEB88JUq4or/pag
         x0zfC23CHeHIbYu4Sh2N6j5c4HhMRG8ESsfF48yj4wJn9240uIiVL/OqLb3fsMml9gFv
         zoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rgJvab5dyDapGAETbOTEIoe8FesICc8Vhk23q4gefms=;
        b=JUuRy2/k1K3+cUMdBgolyJPUM0FmmYTQou3PHmVqqwG7ykKY7jSlBp2CC3TAlKTF/9
         +yOhoFamVIclg/ClSEkMNzWpWLMzinC/bpV6Z3/jbyevuRc57siI93l574+OMBMLGaJs
         FndyQ3n0FKc7KrnxNq3n36nrH7+OQzz3TDXfU76ASu0RdV688DFOZlqjROeLcgLVotCu
         fycxPx/aJattwn4Bi/zhuuAZtEJr1HJdXMDqgl24W3+VSl7KDQfHGkTjbCLxFJfXIZeA
         3L0JYn3y6CFo2znXb8Vt+GR5SrcZUgf3tJ0zoWUm0dOUrgZKV9q37Aqsd23R7kAg7d0e
         fGSA==
X-Gm-Message-State: APjAAAU8ZNVorKipWc6/ylc5yAW1F9x6IBo3uFcwidqz5xnww9svBq3l
        l6bYZA7KeVOOAT1Gp1xNS/o=
X-Google-Smtp-Source: APXvYqxPhVgAhJFiXql8hCgtfIqgc5iViYw+aq96d8MJ1uVyRuWNuxfg8vzGc6hCA9ghb3B+UpX/vQ==
X-Received: by 2002:a63:6a48:: with SMTP id f69mr7360261pgc.7.1552723587295;
        Sat, 16 Mar 2019 01:06:27 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:06:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 01/16] perf: add doc for how to build perf with Asan and UBSan
Date:   Sat, 16 Mar 2019 16:05:41 +0800
Message-Id: <20190316080556.3075-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
very useful tools to detect program bugs.
 o AddressSanitizer (or ASan) is a GCC feature that detects memory
   corruption bugs such as buffer overflows or memory leaks.
 o UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior
   detector supprted by GCC. UBSan detect undefined behavior of programs
   at runtime.

This patch adds doc for how to use them on perf. Later patches will fix
some of the issues disclosed by them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/Build.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index f6fc6507ba55..cae6e1d9b901 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -47,3 +47,23 @@ Those objects are then used in final linking:
 
 NOTE this description is omitting other libraries involved, only
      focusing on build framework outcomes
+
+3) buld and install perf
+  $ cd tools/perf
+  $ make DESTDIR=/usr
+  $ make DESTDIR=/usr install
+
+4) build with ASan or UBSan
+AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
+such as buffer overflows or memory leaks.
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
+  $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
+ASan outputs all detected issues into log file 'asan.log.<pid>'.
+
+UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior detector
+supprted by GCC. UBSan detect undefined behavior of programs at runtime.
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=undefined'
+  $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
+If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
\ No newline at end of file
-- 
2.19.1

