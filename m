Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C71EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA052133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZFyXX+2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbfEXIG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:06:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:06:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O86BUI118110
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:06:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O86BUI118110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685172;
        bh=S4BweBugsgSce9p9FfndUFzYbpXA6BhoTFnm2ojhg/A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZFyXX+2pVPdqXh7B9v9il1P34Msn3ZSKvMOOPmy7yqSIrrywt247MYNzLa5bfFqwB
         uich72ooBA/MidR87j8LUThcG1HK5coTCuQmJ62VbMfuERZLvy2cmIwWIZltMoS9as
         M9OsIgO9mZdlWgzMUBfR8+roF7y6mOojgW7eaYc9gSKgI4WWfRef8sZ81EVgKLesQs
         WrDGeLMdZKxSUcXJjQzZ5FSPBhnHFnyE71i2sIu15yP2jcP7S/BCRY1G5WEyrfriao
         x3lY7BNSXAVw8bgOb/JkEgprloq/r0eMUmxu+21D6Z8lFmYXmvKN6VOc78Qpg9LLEe
         Dwp0uolcX/YKg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O86BR7118107;
        Fri, 24 May 2019 01:06:11 -0700
Date:   Fri, 24 May 2019 01:06:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frank van der Linden <tipbot@zytor.com>
Message-ID: <tip-2ac44ab608705948564791ce1d15d43ba81a1e38@git.kernel.org>
Cc:     luto@kernel.org, mingo@kernel.org, fllinden@amazon.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, bp@suse.de, peterz@infradead.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          peterz@infradead.org, bp@suse.de, fllinden@amazon.com,
          luto@kernel.org, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190522221745.GA15789@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20190522221745.GA15789@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/CPU/AMD: Don't force the CPB cap when running
 under a hypervisor
Git-Commit-ID: 2ac44ab608705948564791ce1d15d43ba81a1e38
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

Commit-ID:  2ac44ab608705948564791ce1d15d43ba81a1e38
Gitweb:     https://git.kernel.org/tip/2ac44ab608705948564791ce1d15d43ba81a1e38
Author:     Frank van der Linden <fllinden@amazon.com>
AuthorDate: Wed, 22 May 2019 22:17:45 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 08:50:32 +0200

x86/CPU/AMD: Don't force the CPB cap when running under a hypervisor

For F17h AMD CPUs, the CPB capability ('Core Performance Boost') is forcibly set,
because some versions of that chip incorrectly report that they do not have it.

However, a hypervisor may filter out the CPB capability, for good
reasons. For example, KVM currently does not emulate setting the CPB
bit in MSR_K7_HWCR, and unchecked MSR access errors will be thrown
when trying to set it as a guest:

	unchecked MSR access error: WRMSR to 0xc0010015 (tried to write 0x0000000001000011) at rIP: 0xffffffff890638f4 (native_write_msr+0x4/0x20)

	Call Trace:
	boost_set_msr+0x50/0x80 [acpi_cpufreq]
	cpuhp_invoke_callback+0x86/0x560
	sort_range+0x20/0x20
	cpuhp_thread_fun+0xb0/0x110
	smpboot_thread_fn+0xef/0x160
	kthread+0x113/0x130
	kthread_create_worker_on_cpu+0x70/0x70
	ret_from_fork+0x35/0x40

To avoid this issue, don't forcibly set the CPB capability for a CPU
when running under a hypervisor.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
Acked-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: jiaxun.yang@flygoat.com
Fixes: 0237199186e7 ("x86/CPU/AMD: Set the CPB bit unconditionally on F17h")
Link: http://lkml.kernel.org/r/20190522221745.GA15789@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
[ Minor edits to the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 80a405c2048a..8d4e50428b68 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -824,8 +824,11 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 {
 	set_cpu_cap(c, X86_FEATURE_ZEN);
 
-	/* Fix erratum 1076: CPB feature bit not being set in CPUID. */
-	if (!cpu_has(c, X86_FEATURE_CPB))
+	/*
+	 * Fix erratum 1076: CPB feature bit not being set in CPUID.
+	 * Always set it, except when running under a hypervisor.
+	 */
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_CPB))
 		set_cpu_cap(c, X86_FEATURE_CPB);
 }
 
