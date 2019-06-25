Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFD8C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA1521655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OG2c6NrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfFYIX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:23:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:23:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8Mqcj3527600
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:22:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8Mqcj3527600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561450972;
        bh=rkLmDGsspwhMrV2Zvfiae5ZQA4kN7FkdpszI3veh9I4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OG2c6NrEblTMzaYCEvA2qFzVC8CTIh2Fs7AfIqoe2CEg10bk4QkKND+uJ19bUwrTy
         peB1t7SnbbHX+DWFwtCLJIhFPCh2Q+5yIJVq05T0CxISZlP771WH+Ymy5AZT9hPkcg
         2Kf4NRtv2XFWIhoQzn5pcvZJDjYIB1s/bGumA8yiNV9BGZ+UQ8dOcioToKe8vOcKm4
         2So1rYOK7v5F9cg4c96SW56AX5/ae5ycJuIJ60QRyn8xXxYKewsYJIg9X+NOp6Mu1S
         +YrpJ4aFz14joxxQum/hVgvy4DTPjJ9AOsx7wz+IJ5k16XN6j3/KN4gV3JAqpFa0Ek
         9IP7mS9e8KvjA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8MpAD3527597;
        Tue, 25 Jun 2019 01:22:51 -0700
Date:   Tue, 25 Jun 2019 01:22:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-8b12b812f5367c2469fb937da7e28dd321ad8d7b@git.kernel.org>
Cc:     kan.liang@linux.intel.com, torvalds@linux-foundation.org,
        hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, acme@redhat.com,
        tglx@linutronix.de, eranian@google.com
Reply-To: eranian@google.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com,
          vincent.weaver@maine.edu, tglx@linutronix.de,
          torvalds@linux-foundation.org, kan.liang@linux.intel.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <1559081314-9714-5-git-send-email-kan.liang@linux.intel.com>
References: <1559081314-9714-5-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/regs: Use PERF_REG_EXTENDED_MASK
Git-Commit-ID: 8b12b812f5367c2469fb937da7e28dd321ad8d7b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8b12b812f5367c2469fb937da7e28dd321ad8d7b
Gitweb:     https://git.kernel.org/tip/8b12b812f5367c2469fb937da7e28dd321ad8d7b
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 28 May 2019 15:08:34 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:19:26 +0200

perf/x86/regs: Use PERF_REG_EXTENDED_MASK

Use the macro defined in kernel ABI header to replace the local name.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/1559081314-9714-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h | 3 +++
 tools/perf/arch/x86/include/perf_regs.h     | 1 -
 tools/perf/arch/x86/util/perf_regs.c        | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index ac67bbea10ca..7c9d2bb3833b 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -52,4 +52,7 @@ enum perf_event_x86_regs {
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
+
+#define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index b7cd91a9014f..b7321337d100 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -9,7 +9,6 @@
 void perf_regs_load(u64 *regs);
 
 #define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
-#define PERF_XMM_REGS_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 #ifndef HAVE_ARCH_X86_64_SUPPORT
 #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 7886ca5263e3..3666c0076df9 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -277,7 +277,7 @@ uint64_t arch__intr_reg_mask(void)
 		.type			= PERF_TYPE_HARDWARE,
 		.config			= PERF_COUNT_HW_CPU_CYCLES,
 		.sample_type		= PERF_SAMPLE_REGS_INTR,
-		.sample_regs_intr	= PERF_XMM_REGS_MASK,
+		.sample_regs_intr	= PERF_REG_EXTENDED_MASK,
 		.precise_ip		= 1,
 		.disabled 		= 1,
 		.exclude_kernel		= 1,
@@ -293,7 +293,7 @@ uint64_t arch__intr_reg_mask(void)
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 	if (fd != -1) {
 		close(fd);
-		return (PERF_XMM_REGS_MASK | PERF_REGS_MASK);
+		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
 	}
 
 	return PERF_REGS_MASK;
