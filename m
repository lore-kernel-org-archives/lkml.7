Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4446BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A40F207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989678;
	bh=okFC0iiZWCipruYCiaCmnH0ikCO0F2qOFWpr6H3uIYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y9M+Ripdi7RDd8qALUizA8LSZuXgGbyA+/S0zvsPdbk/9nG5EisvGwXcmE8HxPLNH
	 LaJpRxhsI9ur1YlFVQA/RDrb59jbVERli7jzHMDg9ruNXr2oWt5YGhmb+JHD3qZF9d
	 d552Z4RNZwr0nJeDed2TlLbOltHeygXbDWXQdWIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390041AbfITO15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389778AbfITO1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:27:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2957208C3;
        Fri, 20 Sep 2019 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989643;
        bh=okFC0iiZWCipruYCiaCmnH0ikCO0F2qOFWpr6H3uIYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+K7XXrhWhBDEoVrIPvaB/ucoCDmuxMytCOSgx3PTCXQUhw8jA9rUP5cGVrPPXk7b
         JJE/d/QfZXJKIQ4fI+Rp/K1WDu4BzHF5fuJLDY9a10O6mChZh/RfCiOVwVsm4CGBTc
         mTLB2dzkp7DehpnnAp6CczAvzkz127KxowExeBYo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/31] perf kvm stat: Set 'trace_cycles' as default event for 'perf kvm record' in powerpc
Date:   Fri, 20 Sep 2019 11:25:42 -0300
Message-Id: <20190920142542.12047-32-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Use 'trace_imc/trace_cycles' as the default event for 'perf kvm record'
in powerpc.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lore.kernel.org/lkml/20190718181749.30612-3-anju@linux.vnet.ibm.com
[ Add missing pmu.h header, needed because this patch uses pmu_have_event() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index ec5b771029e4..9cc1c4a9dec4 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -5,6 +5,7 @@
 #include "util/debug.h"
 #include "util/evsel.h"
 #include "util/evlist.h"
+#include "util/pmu.h"
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
@@ -177,8 +178,9 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
 /*
  * Incase of powerpc architecture, pmu registers are programmable
  * by guest kernel. So monitoring guest via host may not provide
- * valid samples. It is better to fail the "perf kvm record"
- * with default "cycles" event to monitor guest in powerpc.
+ * valid samples with default 'cycles' event. It is better to use
+ * 'trace_imc/trace_cycles' event for guest profiling, since it
+ * can track the guest instruction pointer in the trace-record.
  *
  * Function to parse the arguments and return appropriate values.
  */
@@ -202,8 +204,14 @@ int kvm_add_default_arch_event(int *argc, const char **argv)
 
 	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
 	if (!event) {
-		free(tmp);
-		return -EINVAL;
+		if (pmu_have_event("trace_imc", "trace_cycles")) {
+			argv[j++] = strdup("-e");
+			argv[j++] = strdup("trace_imc/trace_cycles/");
+			*argc += 2;
+		} else {
+			free(tmp);
+			return -EINVAL;
+		}
 	}
 
 	free(tmp);
-- 
2.21.0

