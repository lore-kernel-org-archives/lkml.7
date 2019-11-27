Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8FC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E11217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887470;
	bh=4kLkPTDozBU9jBadLPT6uyejq690n6YJyBSH7qhOiAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vVJptZhPNuDyzgjhKcHSBMK5/HLb0+Vx4KdJmAT0ceVnXC6WPzz8oz158KPa8xbTs
	 ZLWLYqIstYUzaeHWDRGxYsbyFaZWLC1IfF7t0sj5MZuz83a97rRQxh/sMUwmDPpx7F
	 JDb/uayVc5OLft44ixWPC5f2BSGlw0WVLndkegVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfK0Uo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbfK0UoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:44:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D71321843;
        Wed, 27 Nov 2019 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887461;
        bh=4kLkPTDozBU9jBadLPT6uyejq690n6YJyBSH7qhOiAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzuXjwPjx/5RCMJgqRU9h0wLMOzbvf4nE82GF0DVw3oxbd4wg+7Hy04sLlTcK7mlA
         UOM+dvVbXRwJ0f0dUzX+t4p8kvemnavRF2vyg8uBYjwiHA+K85pDZR7BNW7rBKnTk3
         gLpPj81SCcu6L7fDa3gDIelTH+je1KyrVPc3qUSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>, x86-ml <x86@kernel.org>
Subject: [PATCH 4.9 121/151] x86/speculation: Fix redundant MDS mitigation message
Date:   Wed, 27 Nov 2019 21:31:44 +0100
Message-Id: <20191127203045.051203091@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waiman Long <longman@redhat.com>

commit cd5a2aa89e847bdda7b62029d94e95488d73f6b2 upstream.

Since MDS and TAA mitigations are inter-related for processors that are
affected by both vulnerabilities, the followiing confusing messages can
be printed in the kernel log:

  MDS: Vulnerable
  MDS: Mitigation: Clear CPU buffers

To avoid the first incorrect message, defer the printing of MDS
mitigation after the TAA mitigation selection has been done. However,
that has the side effect of printing TAA mitigation first before MDS
mitigation.

 [ bp: Check box is affected/mitigations are disabled first before
   printing and massage. ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -38,6 +38,7 @@ static void __init spectre_v2_select_mit
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
+static void __init mds_print_mitigation(void);
 static void __init taa_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
@@ -107,6 +108,12 @@ void __init check_bugs(void)
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
@@ -244,6 +251,12 @@ static void __init mds_select_mitigation
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
 			cpu_smt_disable(false);
 	}
+}
+
+static void __init mds_print_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
+		return;
 
 	pr_info("%s\n", mds_strings[mds_mitigation]);
 }


