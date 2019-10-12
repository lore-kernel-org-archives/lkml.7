Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79354C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 13:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534A62087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 13:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfJLNTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 09:19:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34801 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfJLNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 09:19:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iJHIl-0000aS-Dc; Sat, 12 Oct 2019 15:19:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CD59D1C0450;
        Sat, 12 Oct 2019 15:19:18 +0200 (CEST)
Date:   Sat, 12 Oct 2019 13:19:18 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/msr: Add Comet Lake CPU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1570549810-25049-4-git-send-email-kan.liang@linux.intel.com>
References: <1570549810-25049-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157088635878.9978.15832003993247143361.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9674b1cc0f94c34f76e58c102623a866836f269e
Gitweb:        https://git.kernel.org/tip/9674b1cc0f94c34f76e58c102623a866836f269e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 08 Oct 2019 08:50:04 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Oct 2019 15:13:08 +02:00

perf/x86/msr: Add Comet Lake CPU support

Comet Lake is the new 10th Gen Intel processor. PPERF and SMI_COUNT MSRs
are also supported.

The External Design Specification (EDS) is not published yet. It comes
from an authoritative internal source.

The patch has been tested on real hardware.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1570549810-25049-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index b1afc77..c177bbe 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -89,6 +89,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
+	case INTEL_FAM6_COMETLAKE_L:
+	case INTEL_FAM6_COMETLAKE:
 	case INTEL_FAM6_ICELAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
