Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED07C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6193E215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aDL8j3hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfFYIWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:22:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42505 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfFYIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:22:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8KiIH3527167
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:20:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8KiIH3527167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561450845;
        bh=HmWxbipk7wybSkq5o0iwtqlTHYXcd8O5ZYQUdvJbSZw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aDL8j3hV37i3fqC1pyjBMiiN1n+rhkDwOAohYlFFjkTAKxhl5syn6ipV3qZekJEqI
         qQATfE0/WyrCmh+mLQuUrbRetNI4wvPqBCZPko1JZsEIDRVKUltx7H6JDiv/cBoKTk
         0yVrjUdkRXWvK5erSRqP8gEGrHjP83/vX+KZsaOD2qXrRS2UN13eippxsRWMcIEAHY
         EmJwQSwtASWKkYnQmhBq2FXoPomvPxN50fk4RcdWl+zBl4kRmjI8Tvyqegph92/wP2
         wxptnI8MAXVKzOV6KrINRP1nJoSHeykrdxgyiOiOwM3P+yQYC0D1DlrAc9gVUXZQWT
         xny9wFygtalpw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8Ki5m3527164;
        Tue, 25 Jun 2019 01:20:44 -0700
Date:   Tue, 25 Jun 2019 01:20:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-90d424915ab6550826d297fd62df8ee255345b95@git.kernel.org>
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kan.liang@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        tglx@linutronix.de, vincent.weaver@maine.edu,
        alexander.shishkin@linux.intel.com, torvalds@linux-foundation.org,
        hpa@zytor.com
Reply-To: acme@redhat.com, jolsa@redhat.com, peterz@infradead.org,
          tglx@linutronix.de, vincent.weaver@maine.edu, eranian@google.com,
          hpa@zytor.com, torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com
In-Reply-To: <1559081314-9714-2-git-send-email-kan.liang@linux.intel.com>
References: <1559081314-9714-2-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/regs: Check reserved bits
Git-Commit-ID: 90d424915ab6550826d297fd62df8ee255345b95
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

Commit-ID:  90d424915ab6550826d297fd62df8ee255345b95
Gitweb:     https://git.kernel.org/tip/90d424915ab6550826d297fd62df8ee255345b95
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 28 May 2019 15:08:31 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:19:24 +0200

perf/x86/regs: Check reserved bits

The perf fuzzer triggers a warning which map to:

        if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
                return 0;

The bits between XMM registers and generic registers are reserved.
But perf_reg_validate() doesn't check these bits.

Add PERF_REG_X86_RESERVED for reserved bits on X86.
Check the reserved bits in perf_reg_validate().

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 878068ea270e ("perf/x86: Support outputting XMM registers")
Link: https://lkml.kernel.org/r/1559081314-9714-2-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/perf_regs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 07c30ee17425..bb7e1132290b 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -74,6 +74,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+#define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
+				 ~((1ULL << PERF_REG_X86_MAX) - 1))
+
 #ifdef CONFIG_X86_32
 #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
 		       (1ULL << PERF_REG_X86_R9) | \
@@ -86,7 +89,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & REG_NOSUPPORT))
+	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
 		return -EINVAL;
 
 	return 0;
@@ -112,7 +115,7 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & REG_NOSUPPORT))
+	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
 		return -EINVAL;
 
 	return 0;
