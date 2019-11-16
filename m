Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7E3C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2613D20700
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 12:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfKPMZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 07:25:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45379 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfKPMZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 07:25:40 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVx8h-0002ok-NH; Sat, 16 Nov 2019 13:25:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 51DB61C1922;
        Sat, 16 Nov 2019 13:25:19 +0100 (CET)
Date:   Sat, 16 Nov 2019 12:25:19 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] x86/speculation: Fix redundant MDS mitigation message
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>, "x86-ml" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191115161445.30809-3-longman@redhat.com>
References: <20191115161445.30809-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <157390711921.12247.3084878540998345444.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     4bef279da30f0766615e680d519909da735758ca
Gitweb:        https://git.kernel.org/tip/4bef279da30f0766615e680d519909da735758ca
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 15 Nov 2019 11:14:45 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 16 Nov 2019 13:19:58 +01:00

x86/speculation: Fix redundant MDS mitigation message

Since MDS and TAA mitigations are inter-related for processors that are
affected by both vulnerabilities, the followiing confusing messages can
be printed in the kernel log:

  MDS: Vulnerable
  MDS: Mitigation: Clear CPU buffers

To avoid the first incorrect message, defer the printing of MDS
mitigation after the TAA mitigation selection has been done. However,
that has the side effect of printing TAA mitigation first before MDS
mitigation.

 [ bp: Massage. ]

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Mark Gross <mgross@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191115161445.30809-3-longman@redhat.com
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cb513ea..cb2fbd9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -39,6 +39,7 @@ static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
+static void __init mds_print_mitigation(void);
 static void __init taa_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
@@ -108,6 +109,12 @@ void __init check_bugs(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 
+	/*
+	 * As MDS and TAA mitigations are inter-related, print MDS
+	 * mitigation until after TAA mitigation selection is done.
+	 */
+	mds_print_mitigation();
+
 	arch_smt_update();
 
 #ifdef CONFIG_X86_32
@@ -245,7 +252,10 @@ static void __init mds_select_mitigation(void)
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
 			cpu_smt_disable(false);
 	}
+}
 
+static void __init mds_print_mitigation(void)
+{
 	pr_info("%s\n", mds_strings[mds_mitigation]);
 }
 
