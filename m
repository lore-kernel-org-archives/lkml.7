Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC8C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329382075E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798878;
	bh=EPajVzRP/fKm1hQ+lccDQK8tCINwbvyEqVXzOVKL1pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uf1OMthYuWyCiXgPdCwMZheG8fATH9ehZlX1265QOZpUprXkGumvEkb9JjpHkeqWL
	 rsC2WqD8k9sRKDcix24bYkpuXVPiuyZgVAEvvQsk+/4e34KpzFeqHLtgRGxaE9OOfn
	 HTHb0U4cprIRFMzqkGBgXS0G+KOMzxW+F5QyFClY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKOGVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfKOGVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:21:13 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E43B2073A;
        Fri, 15 Nov 2019 06:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798872;
        bh=EPajVzRP/fKm1hQ+lccDQK8tCINwbvyEqVXzOVKL1pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OXHl6zT6Rcl5ZKzfmZCDcYlq+6+zpJW+2xJrw4POwSSJ4OscE86uQs0VlkIufZfP
         OBVyvgtpGu2oNMoR0n86tVI8mblKnsQySBvHB0YVgICaMlp5hKdweBwl7/WbZ2qcAn
         7XuU1kMq4BsOMXQaDI+r6BwP2GjERDZQ92qfnW2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 11/20] x86/cpu: Add a helper function x86_read_arch_cap_msr()
Date:   Fri, 15 Nov 2019 14:20:40 +0800
Message-Id: <20191115062011.820988502@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062006.854443935@linuxfoundation.org>
References: <20191115062006.854443935@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 286836a70433fb64131d2590f4bf512097c255e1 upstream.

Add a helper function to read the IA32_ARCH_CAPABILITIES MSR.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c |   15 +++++++++++----
 arch/x86/kernel/cpu/cpu.h    |    2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -918,19 +918,26 @@ static bool __init cpu_matches(unsigned
 	return m && !!(m->driver_data & which);
 }
 
-static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
+u64 x86_read_arch_cap_msr(void)
 {
 	u64 ia32_cap = 0;
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+	return ia32_cap;
+}
+
+static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
+{
+	u64 ia32_cap = x86_read_arch_cap_msr();
+
 	if (cpu_matches(NO_SPECULATION))
 		return;
 
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
-	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
-
 	if (!cpu_matches(NO_SSB) && !(ia32_cap & ARCH_CAP_SSB_NO) &&
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -49,4 +49,6 @@ extern void cpu_detect_cache_sizes(struc
 
 extern void x86_spec_ctrl_setup_ap(void);
 
+extern u64 x86_read_arch_cap_msr(void);
+
 #endif /* ARCH_X86_CPU_H */


