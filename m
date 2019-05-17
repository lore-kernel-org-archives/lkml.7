Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32B7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B8621744
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121826;
	bh=kTlehXX8MAiTkPefmmBKwq5eqXGB0Wl11V20GjQbXIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ixSiz3c92L4ZbYhBSc0rMiuCnNlsRB2qVuzTzG6dDB7N75spBRKp8voPj4ZGvMTu9
	 ffl3tG5cAhGtR3t39BoinJ8Cx1eSePQm1meyIfJTGPKgoGYFgF09B4N3rKR4cG3Bbm
	 dF8BzDB5GHWl9omSw+SPFJNNkOMnLo3eEwspReGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfEQThF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfEQThC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:02 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3869C21734;
        Fri, 17 May 2019 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121821;
        bh=kTlehXX8MAiTkPefmmBKwq5eqXGB0Wl11V20GjQbXIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rByc4PVh16G3SBwzEKiorDFg27EXZi2N+T1MHX8uYAWX3Z18xesuiCf055OEWtN8K
         gyVu8ht5bYah+D9sYuL+Z4RQpF3KeCBA1WawzRTF0E8Nox+9PyCiFBuEHexi7OCYXI
         m2bmNF7eF7xTOFWqun4c4pVWmpTscotMFFuIUN9A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 08/73] tools x86 uapi asm: Sync the pt_regs.h copy with the kernel sources
Date:   Fri, 17 May 2019 16:35:06 -0300
Message-Id: <20190517193611.4974-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  878068ea270e ("perf/x86: Support outputting XMM registers")

That will be used in a followup patch to allow users to ask for some or
all of those registers to be collected in certain contatexts.

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/x86/include/uapi/asm/perf_regs.h'
  diff -u tools/arch/x86/include/uapi/asm/perf_regs.h arch/x86/include/uapi/asm/perf_regs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-6pjnnrzqt3x3n2cd6br3wk7k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h | 23 ++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index f3329cabce5c..ac67bbea10ca 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,8 +27,29 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
-
+	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+
+	/* These all need two bits set because they are 128bit */
+	PERF_REG_X86_XMM0  = 32,
+	PERF_REG_X86_XMM1  = 34,
+	PERF_REG_X86_XMM2  = 36,
+	PERF_REG_X86_XMM3  = 38,
+	PERF_REG_X86_XMM4  = 40,
+	PERF_REG_X86_XMM5  = 42,
+	PERF_REG_X86_XMM6  = 44,
+	PERF_REG_X86_XMM7  = 46,
+	PERF_REG_X86_XMM8  = 48,
+	PERF_REG_X86_XMM9  = 50,
+	PERF_REG_X86_XMM10 = 52,
+	PERF_REG_X86_XMM11 = 54,
+	PERF_REG_X86_XMM12 = 56,
+	PERF_REG_X86_XMM13 = 58,
+	PERF_REG_X86_XMM14 = 60,
+	PERF_REG_X86_XMM15 = 62,
+
+	/* These include both GPRs and XMMX registers */
+	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
 #endif /* _ASM_X86_PERF_REGS_H */
-- 
2.20.1

