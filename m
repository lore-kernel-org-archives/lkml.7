Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6256C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE642186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555079011;
	bh=xnEjMjAE77qkDL2ln42kN9iMAzB6NGKUsmratGiV78g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4jHN/qFvykvaLPGODkLJIpEk7w26PIs30YUpGYNqzvr5SAHBIpnoNjowzUi+mGdM
	 kLpjTujHcENMTs96gEGXPxtmf2T+xTK+STreUSQ2B1NUu357qZ1kDuo3GgB//k33si
	 Uu+1uhJDWpCxbcVOaXt2zdCD+bkA6vGwDDdAL2DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfDLOXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfDLOX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:23:27 -0400
Received: from quaco.ghostprotocols.net (177-58-174-75.3g.claro.net.br [177.58.174.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CAA420850;
        Fri, 12 Apr 2019 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555079006;
        bh=xnEjMjAE77qkDL2ln42kN9iMAzB6NGKUsmratGiV78g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhWjFSO9xh6oudMLfut/DveZh0m19cMpZwm8+kX6kybf77oFoVWxTxXGRBZDW200Y
         d+k+RzBn1FBULGkoQ7ZtJeCgnZhCZ6NpmDMwxVPyZZWoIb7YKytDkCk1rjzQSL6Zic
         jpBAmpzWjPmY5LbTRyefEy1nV0q/FU7wYFAGNInk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/7] x86/perf/amd: Fix build failure when CONFIG_HAVE_NMI_WATCHDOG is not set
Date:   Fri, 12 Apr 2019 11:22:45 -0300
Message-Id: <20190412142250.20595-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

When CONFIG_HAVE_NMI_WATCHDOG is not set, the asm/nmi.h file is not
included. The asm/nmi.h file contains the definitions for NMI_HANDLED
and NMI_DONE which are used in arch/x86/events/amd/core.c. This causes
the build the fail.

Fix the issue by changing the include in arch/x86/events/amd/core.c from
linux/nmi.h to asm/nmi.h.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 5d423653f744..0ecfac84ba91 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -4,8 +4,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/nmi.h>
 #include <asm/apicdef.h>
+#include <asm/nmi.h>
 
 #include "../perf_event.h"
 
-- 
2.20.1

