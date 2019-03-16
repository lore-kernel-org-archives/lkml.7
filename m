Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2501C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C4A218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP9OP6NB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfCPIHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40438 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfCPIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id y124so7904552pfy.7;
        Sat, 16 Mar 2019 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wK83PHiRqCdqcYHCof/3II1cW6418RAPwXPx4G3aa0E=;
        b=NP9OP6NB15X+S2yCcvFsNB084l62ghJ2EUAiJ91C+BZ1+L64oB6LbBKGDuY4VemvA3
         QKxz1jNbQ6XGrnb/uTOBrEaI5Chkuu3JkdrYVIwsV1GiosKfKX2K4v6PvRXGwvp3gBFg
         XmLw3suwZw++GOefeme2FVB255irphM7OXnh7kWta5MhMtCM0yXBQDN/WuTdZGjk6Oik
         Tvqa15fgsqHAMJ+XSTBRze7e8g3Hu82Ioa2uZMydzPQX8jcn8nEdr+iCSfwGONSHyGkA
         b3VnHo0Y/wqRw5asx+ZhSa+VRqwVUxwuU8C0JplgV1pJCVouLRq4UhYBLzHgxdgZGfIN
         yFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wK83PHiRqCdqcYHCof/3II1cW6418RAPwXPx4G3aa0E=;
        b=UQajnsMGrvmqY7HqdW15K2lWJeh7V1fcWyKvCtSNzAAVtXdeOTx1902SpIp4J7az+0
         NTZmP5nNo7tSbt3GaYfRIO4VsVWPIa7nvYpMWQcvLgBUdvsUANY8TYgHanD7+ecGOieJ
         3Cu80EvbQrsZLFksW2bP/oCzg9DmKOM9ig2B0MuAsBSlJpOxiUmIs3Fj7eHNaYs/w9iU
         Tcb//fXLxRm344nAZOqyY3c0DX50whVzslQ6eAxXfBYOQ0PECt0klV5xgP5eNhxzCAPg
         lTf1tXMLo9/XvCOqdeq6FAjQll7TV5NSwDKEoQzgNqiqYwASY4fXrh29LIxmz5PqrkaT
         hHgg==
X-Gm-Message-State: APjAAAXwyMWlGLvU1gkZysMGnhvkIEzGerM5mdrgZAIyaHUZWihcopce
        tqD1Cwa0geNtiVvzu68iW+s=
X-Google-Smtp-Source: APXvYqxVtVPw40clUtk5SIrhsEksQty61yhFpTfNKDd6BBvCQcQcZG7J6BfVmRSccnaFU68uUg7boA==
X-Received: by 2002:a17:902:7609:: with SMTP id k9mr8814725pll.305.1552723656589;
        Sat, 16 Mar 2019 01:07:36 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:35 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 12/16] perf: top: fix global-buffer-overflow issue
Date:   Sat, 16 Mar 2019 16:05:52 +0800
Message-Id: <20190316080556.3075-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arrary str[] should have six elements.

=================================================================
==4322==ERROR: AddressSanitizer: global-buffer-overflow on address 0x56463844e300 at pc 0x564637e7ad0d bp 0x7f30c8c89d10 sp 0x7f30c8c89d00
READ of size 8 at 0x56463844e300 thread T9
    #0 0x564637e7ad0c in __ordered_events__flush util/ordered-events.c:316
    #1 0x564637e7b0e4 in ordered_events__flush util/ordered-events.c:338
    #2 0x564637c6a57d in process_thread /home/changbin/work/linux/tools/perf/builtin-top.c:1073
    #3 0x7f30d173a163 in start_thread (/lib/x86_64-linux-gnu/libpthread.so.0+0x8163)
    #4 0x7f30cfffbdee in __clone (/lib/x86_64-linux-gnu/libc.so.6+0x11adee)

0x56463844e300 is located 32 bytes to the left of global variable 'flags' defined in 'util/trace-event-parse.c:229:26' (0x56463844e320) of size 192
0x56463844e300 is located 0 bytes to the right of global variable 'str' defined in 'util/ordered-events.c:268:28' (0x56463844e2e0) of size 32
SUMMARY: AddressSanitizer: global-buffer-overflow util/ordered-events.c:316 in __ordered_events__flush
Shadow bytes around the buggy address:
  0x0ac947081c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ac947081c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ac947081c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ac947081c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ac947081c50: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
=>0x0ac947081c60:[f9]f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ac947081c70: 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9
  0x0ac947081c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ac947081c90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ac947081ca0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0ac947081cb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
Thread T9 created by T0 here:
    #0 0x7f30d179de5f in __interceptor_pthread_create (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x4ae5f)
    #1 0x564637c6b954 in __cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1253
    #2 0x564637c7173c in cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1642
    #3 0x564637d85038 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #4 0x564637d85577 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #5 0x564637d8597b in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #6 0x564637d860e9 in main /home/changbin/work/linux/tools/perf/perf.c:520
    #7 0x7f30cff0509a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/ordered-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index ea523d3b248f..989fed6f43b5 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -270,6 +270,8 @@ static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
 		"FINAL",
 		"ROUND",
 		"HALF ",
+		"TOP  ",
+		"TIME ",
 	};
 	int err;
 	bool show_progress = false;
-- 
2.19.1

