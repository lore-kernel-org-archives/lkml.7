Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF58C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DEE2339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340752;
	bh=8fB1xklesLswwgbZwyxVAcXZsMxs5asDnSf2rrT4Kew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a2+VOH7Z7x4W+hd6HY3RvWkv7p/ijVyrPnqMBPC9v4inFo8UcJF4QZnnbq8TOwjaZ
	 1F1iv1NnDVoeUgEvFCZI3h5McwdV5JRgdqAwBG1wIexdPX9Xh1EDVhugH7RzqEFSNW
	 Hdxk8ZknOxeGIwjFpRdno85//UkteCpUjb8rcXuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfIAMZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbfIAMZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD19F2377D;
        Sun,  1 Sep 2019 12:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340749;
        bh=8fB1xklesLswwgbZwyxVAcXZsMxs5asDnSf2rrT4Kew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJdWar5hwDoTui+yUHA/i0QvprcnsSLbA63xz5G+nUY2kqlkXjjes/lczGCEQTKS2
         1KNeWsxEgFvkSfSZDsVFdDc0uDmDJbaQUmD7oEX+85bEYLs+LzJCEn8rQp/SSqmPT+
         y6oWoI0vTUdQVcHD+VHaACxu/Gn0X580kuve2zjA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 45/47] perf build: Ignore intentional differences for the x86 insn decoder
Date:   Sun,  1 Sep 2019 09:23:24 -0300
Message-Id: <20190901122326.5793-46-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we need to build this in !x86, we need to explicitely use the x86
files, not things like asm/insn.h, so we intentionally differ from the
master copy in the kernel sources, add -I diff directives to ignore just
these differences when checking for drift.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-9qziqjjt120mmz6kyepka9p7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index cbcc3590098c..e2e0f06c97d0 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -26,12 +26,8 @@ include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
 arch/x86/include/asm/required-features.h
 arch/x86/include/asm/cpufeatures.h
-arch/x86/include/asm/inat.h
 arch/x86/include/asm/inat_types.h
-arch/x86/include/asm/insn.h
 arch/x86/include/uapi/asm/prctl.h
-arch/x86/lib/inat.c
-arch/x86/lib/insn.c
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 arch/arm/include/uapi/asm/perf_regs.h
@@ -116,6 +112,10 @@ check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/ctype.h	      '-I "isdigit("'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
+check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
+check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
+check arch/x86/lib/inat.c	      '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
+check arch/x86/lib/insn.c	      '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
-- 
2.21.0

