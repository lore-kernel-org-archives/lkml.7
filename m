Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FD6C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FF1208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfFNL25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:28:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfFNL25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:28:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3AB3356C4;
        Fri, 14 Jun 2019 11:28:56 +0000 (UTC)
Received: from krava (ovpn-204-154.brq.redhat.com [10.40.204.154])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F0EC6103B;
        Fri, 14 Jun 2019 11:28:54 +0000 (UTC)
Date:   Fri, 14 Jun 2019 13:28:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Tom Vaden <tom.vaden@hpe.com>
Subject: [RFC] perf/x86/intel: Disable check_msr for real hw
Message-ID: <20190614112853.GC4325@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 14 Jun 2019 11:28:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
the HPE server can do POST tracing and have enabled LBR
tracing during the boot, which makes check_msr fail falsly.

It looks like check_msr code was added only to check on guests
MSR access, would it be then ok to disable check_msr for real
hardware? (as in patch below)

We could also check if LBR tracing is enabled and make
appropriate checks, but this change is simpler ;-)

ideas? thanks,
jirka


---
 arch/x86/events/intel/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 71001f005bfe..1194ae7e1992 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -20,6 +20,7 @@
 #include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
+#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -4050,6 +4051,13 @@ static bool check_msr(unsigned long msr, u64 mask)
 {
 	u64 val_old, val_new, val_tmp;
 
+	/*
+	 * Disable the check for real HW, so we don't
+	 * mess up with potentionaly enabled regs.
+	 */
+	if (hypervisor_is_type(X86_HYPER_NATIVE))
+		return true;
+
 	/*
 	 * Read the current value, change it and read it back to see if it
 	 * matches, this is needed to detect certain hardware emulators
-- 
2.21.0

