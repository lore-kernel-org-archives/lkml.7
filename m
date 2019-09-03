Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D545C2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfICIbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:31:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59155 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfICIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Dk-0002eL-W9; Tue, 03 Sep 2019 10:31:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 723F21C0DDE;
        Tue,  3 Sep 2019 10:31:24 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:24 -0000
From:   "tip-bot2 for Matt Fleming" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arch, ia64: Make NUMA select SMP
Cc:     Matt Fleming <matt@codeblueprint.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Suravee.Suthikulpanit@amd.com,
        Thomas Gleixner <tglx@linutronix.de>, Thomas.Lendacky@amd.com,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190808195301.13222-2-matt@codeblueprint.co.uk>
References: <20190808195301.13222-2-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Message-ID: <156749948430.12871.13896634861148973044.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a2cbfd46559e809c8165773b7fe8afa058b35414
Gitweb:        https://git.kernel.org/tip/a2cbfd46559e809c8165773b7fe8afa058b35414
Author:        Matt Fleming <matt@codeblueprint.co.uk>
AuthorDate:    Thu, 08 Aug 2019 20:53:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:17:36 +02:00

arch, ia64: Make NUMA select SMP

While it does make sense to allow CONFIG_NUMA and !CONFIG_SMP in
theory, it doesn't make much sense in practice.

Follow other architectures and make CONFIG_NUMA select CONFIG_SMP.

The motivation for this patch is to allow a new NUMA variable to be
initialised in kernel/sched/topology.c.

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Suravee.Suthikulpanit@amd.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas.Lendacky@amd.com
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20190808195301.13222-2-matt@codeblueprint.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 7468d8e..997baba 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -389,6 +389,7 @@ config NUMA
 	depends on !IA64_HP_SIM && !FLATMEM
 	default y if IA64_SGI_SN2
 	select ACPI_NUMA if ACPI
+	select SMP
 	help
 	  Say Y to compile the kernel to support NUMA (Non-Uniform Memory
 	  Access).  This option is for configuring high-end multiprocessor
