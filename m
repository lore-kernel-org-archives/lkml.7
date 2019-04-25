Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA26C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6635217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vR4XG8B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbfDYHFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:05:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42791 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfDYHFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:05:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3P744UE2994038
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Apr 2019 00:04:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3P744UE2994038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556175845;
        bh=+y5O02seYWvyi7uK3maG/+koBY8R02+qho6c9u3I2vY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vR4XG8B1kySt745GNcWJjzJoR8bzpNJVUeirIGAsBYzL+v4qM69uvwXvgazwtH+RU
         4Py8HvIZOwAJCrOYAJwFJzLTdC8841NDbap74v/LX5giXoJa4g7gEbUyYhZ1gtggYi
         th/NAVzpPvGjLIQrQ45hPPnhr3WhHo93qhlnrY6VmyKqHBFEUiigs5zQE17qe/0bHZ
         TE5mCtb2eyPfnVLlnt2PZ1lZpMaGYAMUhczAOeqX102SC50gnGLoqvd4I1+lBHGARq
         DWEeZ9Q4gO/Bn5lRVpITvGeoDGueoENy+s+HE84pJpmUJCD1/MUTobkrIY3ZVP6OS9
         xQBLZ2OzicQIQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3P7430G2993998;
        Thu, 25 Apr 2019 00:04:03 -0700
Date:   Thu, 25 Apr 2019 00:04:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Harry Pan <tipbot@zytor.com>
Message-ID: <tip-82c99f7a81f28f8c1be5f701c8377d14c4075b10@git.kernel.org>
Cc:     torvalds@linux-foundation.org, eranian@google.com,
        tglx@linutronix.de, vincent.weaver@maine.edu, harry.pan@intel.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, hpa@zytor.com, stable@vger.kernel.org,
        jolsa@redhat.com
Reply-To: eranian@google.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, harry.pan@intel.com,
          vincent.weaver@maine.edu, linux-kernel@vger.kernel.org,
          peterz@infradead.org, bp@alien8.de,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com,
          stable@vger.kernel.org
In-Reply-To: <20190424145033.1924-1-harry.pan@intel.com>
References: <20190424145033.1924-1-harry.pan@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Update KBL Package C-state events
 to also include PC8/PC9/PC10 counters
Git-Commit-ID: 82c99f7a81f28f8c1be5f701c8377d14c4075b10
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

Commit-ID:  82c99f7a81f28f8c1be5f701c8377d14c4075b10
Gitweb:     https://git.kernel.org/tip/82c99f7a81f28f8c1be5f701c8377d14c4075b10
Author:     Harry Pan <harry.pan@intel.com>
AuthorDate: Wed, 24 Apr 2019 22:50:33 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Apr 2019 08:59:31 +0200

perf/x86/intel: Update KBL Package C-state events to also include PC8/PC9/PC10 counters

Kaby Lake (and Coffee Lake) has PC8/PC9/PC10 residency counters.

This patch updates the list of Kaby/Coffee Lake PMU event counters
from the snb_cstates[] list of events to the hswult_cstates[]
list of events, which keeps all previously supported events and
also adds the PKG_C8, PKG_C9 and PKG_C10 residency counters.

This allows user space tools to profile them through the perf interface.

Signed-off-by: Harry Pan <harry.pan@intel.com>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: gs0622@gmail.com
Link: http://lkml.kernel.org/r/20190424145033.1924-1-harry.pan@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/cstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 94a4b7fc75d0..d41de9af7a39 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -76,15 +76,15 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,CNL
+ *			       Available model: HSW ULT,KBL,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,CNL
+ *			       Available model: HSW ULT,KBL,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,GLM,CNL
+ *			       Available model: HSW ULT,KBL,GLM,CNL
  *			       Scope: Package (physical package)
  *
  */
@@ -566,8 +566,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_DESKTOP, snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
 
