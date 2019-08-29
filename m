Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94BDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C020521874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfH2Wln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:41:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbfH2Wl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB98E301D67F;
        Thu, 29 Aug 2019 22:41:27 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C05E0608A5;
        Thu, 29 Aug 2019 22:41:26 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] perf intel-pt: Remove inat.c from build dependency list
Date:   Thu, 29 Aug 2019 17:41:20 -0500
Message-Id: <53776d6d29bc9eceb571d52df8fa32250c58a0f3.1567118001.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1567118001.git.jpoimboe@redhat.com>
References: <cover.1567118001.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 29 Aug 2019 22:41:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel-pt-insn-decoder.c includes inat.c directly, so it already has an
implicit dependency on inat.c.  The Build file dependency is redundant.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
2.20.1

