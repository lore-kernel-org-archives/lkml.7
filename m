Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B37C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B502339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340748;
	bh=1P2TKfh4IN14KWeRnZfqNF5lEsqM69VWL32FdipnHRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y5WegLbR+f/k3DjUzdDz+H8vHir6qXQYnFw/CYNeg03u6xN9v0lgZ5mGNqACoIcSA
	 +XEDjx9Cb4ERtQ9n9HZLtpXhBe6xv2HL96WUrdZ4LZTrT5g5vpl3cT9DLQO1fSVXwa
	 Opjzeje7nRzLN4Q2sR1iwlHNWR9gY3ctB59XSB/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfIAMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbfIAMZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A8321897;
        Sun,  1 Sep 2019 12:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340742;
        bh=1P2TKfh4IN14KWeRnZfqNF5lEsqM69VWL32FdipnHRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsyR9Dwf+xLxGS9dFSh6GmZEUb5GIbfxO29YyBytKYJIYcwdkkxA1x24VVh5QJmOg
         PGjo1RHI7jAIbKfYfOvwS2DWubLm0Dj5EXyQTfsSMIY0o0G/GuQ9gSR1hDLQ0tL335
         mIq7yotDhJe/12iqkLptEJw1m6LEJjGLFPgH8/lE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 43/47] perf intel-pt: Remove inat.c from build dependency list
Date:   Sun,  1 Sep 2019 09:23:22 -0300
Message-Id: <20190901122326.5793-44-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

intel-pt-insn-decoder.c includes inat.c directly, so it already has an
implicit dependency on inat.c.  The Build file dependency is redundant.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/53776d6d29bc9eceb571d52df8fa32250c58a0f3.1567118001.git.jpoimboe@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 23bf788f84b9..acb18a3463c3 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -9,7 +9,7 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
 
 # Busybox's diff doesn't have -I, avoid warning in the case
 
-$(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c util/intel-pt-decoder/inat.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
+$(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
 	@(diff -I 2>&1 | grep -q 'option requires an argument' && \
 	test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
 	((diff -B -I'^#include' util/intel-pt-decoder/insn.c ../../arch/x86/lib/insn.c >/dev/null) || \
-- 
2.21.0

