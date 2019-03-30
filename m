Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D051BC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFE1218EA
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907143;
	bh=JhgusnpHFf22KNxynJydwhlx9pnGIWt2wRHN4R3+vik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LGRhZ0KWdwRsWJPZsTVdTSOtrkGS+x3r4LbcTfN8Q1yHAAfx42TLA5nhHnkHLmpHc
	 cms9HSEJ7A4fh9oWTy7YSzfjhVSCJZbJlmdjBA0ppQsMPPEluW2NZuMBMueSLOBbKG
	 ZeRhTOY/v6G4q79n3nXWLJ6e+aEV5oOfG+/UJjDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfC3AwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730968AbfC3AwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0AD1218D0;
        Sat, 30 Mar 2019 00:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907138;
        bh=JhgusnpHFf22KNxynJydwhlx9pnGIWt2wRHN4R3+vik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvdvHJIWNMlJJq5lS6Nf9FRBiprnErcKnkFuEqik/3Nzl7z8QcFMDr3jgyH1GAdzr
         uOVSKyyXht6+rhcW2i0PAzAaHJA8Nex43qb28g8OoZ6u/Aq8qaLatuTCP6EbVhMj4+
         PJJoVDby5tTK6B22+qVM38sCSGRu1593FMYcxCn4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 44/67] perf top: Fix global-buffer-overflow issue
Date:   Fri, 29 Mar 2019 20:50:24 -0400
Message-Id: <20190330005047.25998-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

[ Upstream commit 1e5b0cf8672e622257df024074e6e09bfbcb7750 ]

The array str[] should have six elements.

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
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Fixes: 16c66bc167cc ("perf top: Add processing thread")
Fixes: 68ca5d07de20 ("perf ordered_events: Add ordered_events__flush_time interface")
Link: http://lkml.kernel.org/r/20190316080556.3075-13-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

