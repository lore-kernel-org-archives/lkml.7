Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E41CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F75A2342C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340764;
	bh=9HV/on95HpmIwItesTLjB45Z8+DGSGWnM5TZpiLKMcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JVMijpWaCSdzK5fq6wU/O6vC4kNp1EgQgzMpH+IhGFnbOIdNRSSd9o2prcKfENcgx
	 tq6m24FAxlWJ0s4Lro90FxaNQ9P+qHraB+RTNlCI030wnfiSMJ68ipQ+dahs10vDNC
	 QNE49dk7yZGbcYtqCL28BIQI6nRjkuM2mfS93AdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfIAM0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfIAMZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B3732339D;
        Sun,  1 Sep 2019 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340756;
        bh=9HV/on95HpmIwItesTLjB45Z8+DGSGWnM5TZpiLKMcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/sbmOnsyWNbCnUUDQXZIOSmcWG2t0cEkZh2jbvw+9Q+jRl32BkXT81H9qsb6NHRp
         VrwATvFI30F5fSbuGdtfT0NaDCjboNCLHl/9bpbMRU/EcFj9Qb7B/0MEr8s+Pry6eB
         sMNlhurN+ZGLnNlOIt9gbcbkaQ6GL4KrNilCKwAI=
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
Subject: [PATCH 47/47] objtool: Ignore intentional differences for the x86 insn decoder
Date:   Sun,  1 Sep 2019 09:23:26 -0300
Message-Id: <20190901122326.5793-48-acme@kernel.org>
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
Link: http://lore.kernel.org/lkml/20190830193109.p7jagidsrahoa4pn@treble
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-j965m9b7xtdc83em3twfkh9o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/objtool/sync-check.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 6fa87de1c765..0a832e265a50 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -2,12 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 FILES='
-arch/x86/include/asm/inat.h
 arch/x86/include/asm/inat_types.h
-arch/x86/include/asm/insn.h
 arch/x86/include/asm/orc_types.h
-arch/x86/lib/inat.c
-arch/x86/lib/insn.c
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 '
@@ -47,4 +43,9 @@ for i in $FILES; do
   check $i
 done
 
+check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
+check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
+check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
+check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]"'
+
 cd -
-- 
2.21.0

