Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE722C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7042190A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126879;
	bh=b2T+MsHUqRAUyKaneiAyIQhxaSF3flRKNMfg5lzb7wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hBCEvJSINrN5XXuupLeJWez3d5DDCnHzMT0rjp0obYTKti+s1WtqRUacZFXRo5B/w
	 rXIPsrgrQPxSyWVgi/b6dVbVr191jgPBfr7N5aSJdM/pEJqhmdd+D7X4nMX1uA3Izl
	 cBzlyDLhlUnSFQ6CT9+TcuUIOOqesM3CDwA7AEEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390567AbfDXR15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390530AbfDXR1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:51 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F9F2077C;
        Wed, 24 Apr 2019 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126870;
        bh=b2T+MsHUqRAUyKaneiAyIQhxaSF3flRKNMfg5lzb7wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmzAAL12DnO5rz6Ki0gsDHN4kApiXfifgA8G88JwoVLOIf6eTu5e47pCxF6K2YHl1
         p6vJsLHb9RPguSHABY4fW7MYfTxEkMJj8wWH2HpZha/euyKin7uEP6rPsNeYWQymrf
         JaUXmpa4jOg8Ysrp0tXv5QNiece1MJzfw/mqskws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        jolsa@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 46/70] perf/x86: Fix incorrect PEBS_REGS
Date:   Wed, 24 Apr 2019 19:10:06 +0200
Message-Id: <20190424170915.118390582@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

commit 9d5dcc93a6ddfc78124f006ccd3637ce070ef2fc upstream.

PEBS_REGS used as mask for the supported registers for large PEBS.
However, the mask cannot filter the sample_regs_user/sample_regs_intr
correctly.

(1ULL << PERF_REG_X86_*) should be used to replace PERF_REG_X86_*, which
is only the index.

Rename PEBS_REGS to PEBS_GP_REGS, because the mask is only for general
purpose registers.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Fixes: 2fe1bc1f501d ("perf/x86: Enable free running PEBS for REGS_USER/INTR")
Link: https://lkml.kernel.org/r/20190402194509.2832-2-kan.liang@linux.intel.com
[ Renamed it to PEBS_GP_REGS - as 'GPRS' is used elsewhere ;-) ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |    2 +-
 arch/x86/events/perf_event.h |   38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3001,7 +3001,7 @@ static unsigned long intel_pmu_free_runn
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_REGS)
+	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
 		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
 	return flags;
 }
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -95,25 +95,25 @@ struct amd_nb {
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)
 
-#define PEBS_REGS \
-	(PERF_REG_X86_AX | \
-	 PERF_REG_X86_BX | \
-	 PERF_REG_X86_CX | \
-	 PERF_REG_X86_DX | \
-	 PERF_REG_X86_DI | \
-	 PERF_REG_X86_SI | \
-	 PERF_REG_X86_SP | \
-	 PERF_REG_X86_BP | \
-	 PERF_REG_X86_IP | \
-	 PERF_REG_X86_FLAGS | \
-	 PERF_REG_X86_R8 | \
-	 PERF_REG_X86_R9 | \
-	 PERF_REG_X86_R10 | \
-	 PERF_REG_X86_R11 | \
-	 PERF_REG_X86_R12 | \
-	 PERF_REG_X86_R13 | \
-	 PERF_REG_X86_R14 | \
-	 PERF_REG_X86_R15)
+#define PEBS_GP_REGS			\
+	((1ULL << PERF_REG_X86_AX)    | \
+	 (1ULL << PERF_REG_X86_BX)    | \
+	 (1ULL << PERF_REG_X86_CX)    | \
+	 (1ULL << PERF_REG_X86_DX)    | \
+	 (1ULL << PERF_REG_X86_DI)    | \
+	 (1ULL << PERF_REG_X86_SI)    | \
+	 (1ULL << PERF_REG_X86_SP)    | \
+	 (1ULL << PERF_REG_X86_BP)    | \
+	 (1ULL << PERF_REG_X86_IP)    | \
+	 (1ULL << PERF_REG_X86_FLAGS) | \
+	 (1ULL << PERF_REG_X86_R8)    | \
+	 (1ULL << PERF_REG_X86_R9)    | \
+	 (1ULL << PERF_REG_X86_R10)   | \
+	 (1ULL << PERF_REG_X86_R11)   | \
+	 (1ULL << PERF_REG_X86_R12)   | \
+	 (1ULL << PERF_REG_X86_R13)   | \
+	 (1ULL << PERF_REG_X86_R14)   | \
+	 (1ULL << PERF_REG_X86_R15))
 
 /*
  * Per register state.


