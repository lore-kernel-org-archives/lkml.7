Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9F421A4A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665206;
	bh=RJ2JKF7aHbIXXe6fl+8TR4g4jjPM+fC+GP7eMON11ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gwHWbtFrDoqM3Yo0h6WNTUcf8aZV+V3lOUW5keM/2yln+kTSxyo/SXDLiG+rZkjzO
	 Dg565ABqkr7KP1Eo6SoQKEmv8fQn+bCTAi/rE5+Ti7APEJosGYSc+8mE4w6+pYyW4B
	 pb/pMMZivlO3MJ6baxjEG/9iQOrhCtJntVRW0OT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfJUNkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbfJUNkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176F221783;
        Mon, 21 Oct 2019 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665201;
        bh=RJ2JKF7aHbIXXe6fl+8TR4g4jjPM+fC+GP7eMON11ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbX23Qj2fXZirrFAhYEv3m/Uz6PlPSyVaO4qH2swy/MGOqL1Yy5DW3zAsxkHA47C/
         shhhv0KKHY8CKYoIQm90U2F4fNN8pq5kP/xQzAKaSBBYdPd5dsXpyW/22SuuBWjj4/
         U4vOVnNySJX64juDx7ZmNC9/YSJTN0LOz0xvOWC8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 24/57] libbeauty: Add a generator for x86's IRQ vectors -> strings
Date:   Mon, 21 Oct 2019 10:38:01 -0300
Message-Id: <20191021133834.25998-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll wire this up with the 'vector' arg in irq_vectors:*, etc:

Just run it straight away and check what it produces:

  $ tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
  static const char *x86_irq_vectors[] = {
  	[0x02] = "NMI",
  	[0x12] = "MCE",
  	[0x20] = "IRQ_MOVE_CLEANUP",
  	[0x80] = "IA32_SYSCALL",
  	[0xec] = "LOCAL_TIMER",
  	[0xed] = "HYPERV_STIMER0",
  	[0xee] = "HYPERV_REENLIGHTENMENT",
  	[0xef] = "MANAGED_IRQ_SHUTDOWN",
  	[0xf0] = "POSTED_INTR_NESTED",
  	[0xf1] = "POSTED_INTR_WAKEUP",
  	[0xf2] = "POSTED_INTR",
  	[0xf3] = "HYPERVISOR_CALLBACK",
  	[0xf4] = "DEFERRED_ERROR",
  	[0xf6] = "IRQ_WORK",
  	[0xf7] = "X86_PLATFORM_IPI",
  	[0xf8] = "REBOOT",
  	[0xf9] = "THRESHOLD_APIC",
  	[0xfa] = "THERMAL_APIC",
  	[0xfb] = "CALL_FUNCTION_SINGLE",
  	[0xfc] = "CALL_FUNCTION",
  	[0xfd] = "RESCHEDULE",
  	[0xfe] = "ERROR_APIC",
  	[0xff] = "SPURIOUS_APIC",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cpl1pa7kkwn0llufi5qw4li8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../beauty/tracepoints/x86_irq_vectors.sh     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh

diff --git a/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
new file mode 100755
index 000000000000..f920003723b3
--- /dev/null
+++ b/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+# (C) 2019, Arnaldo Carvalho de Melo <acme@redhat.com>
+
+if [ $# -ne 1 ] ; then
+	arch_x86_header_dir=tools/arch/x86/include/asm/
+else
+	arch_x86_header_dir=$1
+fi
+
+x86_irq_vectors=${arch_x86_header_dir}/irq_vectors.h
+
+# FIRST_EXTERNAL_VECTOR is not that useful, find what is its number
+# and then replace whatever is using it and that is useful, which at
+# the time of writing of this script was: IRQ_MOVE_CLEANUP_VECTOR.
+
+first_external_regex='^#define[[:space:]]+FIRST_EXTERNAL_VECTOR[[:space:]]+(0x[[:xdigit:]]+)$'
+first_external_vector=$(egrep ${first_external_regex} ${x86_irq_vectors} | sed -r "s/${first_external_regex}/\1/g")
+
+printf "static const char *x86_irq_vectors[] = {\n"
+regex='^#define[[:space:]]+([[:alnum:]_]+)_VECTOR[[:space:]]+(0x[[:xdigit:]]+)$'
+sed -r "s/FIRST_EXTERNAL_VECTOR/${first_external_vector}/g" ${x86_irq_vectors} | \
+egrep ${regex} | \
+	sed -r "s/${regex}/\2 \1/g" | sort -n | \
+	xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n\n"
+
-- 
2.21.0

