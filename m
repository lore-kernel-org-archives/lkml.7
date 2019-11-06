Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03951C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEFA217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfKFNET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:04:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729430AbfKFNET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:04:19 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C32D1F37FB2D9B81F177;
        Wed,  6 Nov 2019 21:04:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 6 Nov 2019 21:04:07 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH] perf tools: Fix cross compile for ARM64
Date:   Wed, 6 Nov 2019 21:00:54 +0800
Message-ID: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when cross compiling perf tool for ARM64 on my x86 machine I get
this error:
arch/arm64/util/sym-handling.c:9:10: fatal error: gelf.h: No such file or directory
 #include <gelf.h>

For the build, libelf is reported off:
Auto-detecting system features:
...
...                        libelf: [ OFF ]

Indeed, test-libelf is not built successfully:
more ./build/feature/test-libelf.make.output
test-libelf.c:2:10: fatal error: libelf.h: No such file or directory
 #include <libelf.h>
          ^~~~~~~~~~
compilation terminated.

I have no such problems natively compiling on ARM64, and I did not
previously have this issue for cross compiling. Fix by relocating
the gelf.h include.

Signed-off-by: John Garry <john.garry@huawei.com>
---

I marked this as RFC as I am suspicious that I have seen no other
reports, and whether fixing up the libelf.h include issue is the proper
approach.

diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
index 5df788985130..8dfa3e5229f1 100644
--- a/tools/perf/arch/arm64/util/sym-handling.c
+++ b/tools/perf/arch/arm64/util/sym-handling.c
@@ -6,9 +6,10 @@
 
 #include "symbol.h" // for the elf__needs_adjust_symbols() prototype
 #include <stdbool.h>
-#include <gelf.h>
 
 #ifdef HAVE_LIBELF_SUPPORT
+#include <gelf.h>
+
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 {
 	return ehdr.e_type == ET_EXEC ||
-- 
2.17.1

