Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D9C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652A920644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lgSODcXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEIKfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:35:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfEIKfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:35:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x49AZREL1505394
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 May 2019 03:35:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x49AZREL1505394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557398128;
        bh=tLbyq6weNGqViJcUtv8zXM6fs0fS0h2cC8ZLK3zNds4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lgSODcXzBEJqvmpxkecFyY9/uvi884nTYFPFOpTdXPHVcjuWte9vsCRkMpROk73fJ
         l74hgh4fiddGBeMDf6zKlKIdfgzkN0WIdoLWXJzuyOqSbbAPCh90/mXX2gJ9odUU5w
         0oUpzdG1Ax1M9HzQGK3JXp+oU2TNuZTiAjAfiwHdgrFVeXoBUJ7EH20fl8rG6BYmfy
         JEFJ+MNsr6mhhc1BjeznjaBCBwZ2OZUYypFMzxdFidJT9SKvl3r3TbL6lcYSAFrD29
         9meqlvT2yVyVHHwb4Adx80ZUjBY8SudT0b25tcARkjq0HomVOLEv0Ce722CIWhWpLP
         H7hjufpCulBig==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x49AZR1w1505391;
        Thu, 9 May 2019 03:35:27 -0700
Date:   Thu, 9 May 2019 03:35:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Drake <tipbot@zytor.com>
Message-ID: <tip-2420a0b1798d7a78d1f9b395f09f3c80d92cc588@git.kernel.org>
Cc:     tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        luto@kernel.org, drake@endlessm.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, bp@alien8.de,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          luto@kernel.org, drake@endlessm.com, mingo@kernel.org,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
References: <20190509055417.13152-3-drake@endlessm.com>
        <20190419083533.32388-1-drake@endlessm.com>
        <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/tsc: Set LAPIC timer period to crystal clock
 frequency
Git-Commit-ID: 2420a0b1798d7a78d1f9b395f09f3c80d92cc588
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

Commit-ID:  2420a0b1798d7a78d1f9b395f09f3c80d92cc588
Gitweb:     https://git.kernel.org/tip/2420a0b1798d7a78d1f9b395f09f3c80d92cc588
Author:     Daniel Drake <drake@endlessm.com>
AuthorDate: Thu, 9 May 2019 13:54:17 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 9 May 2019 11:06:49 +0200

x86/tsc: Set LAPIC timer period to crystal clock frequency

The APIC timer calibration (calibrate_APIC_timer()) can be skipped
in cases where we know the APIC timer frequency. On Intel SoCs,
we believe that the APIC is fed by the crystal clock; this would make
sense, and the crystal clock frequency has been verified against the
APIC timer calibration result on ApolloLake, GeminiLake, Kabylake,
CoffeeLake, WhiskeyLake and AmberLake.

Set lapic_timer_period based on the crystal clock frequency
accordingly.

APIC timer calibration would normally be skipped on modern CPUs
by nature of the TSC deadline timer being used instead,
however this change is still potentially useful, e.g. if the
TSC deadline timer has been disabled with a kernel parameter.
calibrate_APIC_timer() uses the legacy timer, but we are seeing
new platforms that omit such legacy functionality, so avoiding
such codepaths is becoming more important.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: len.brown@intel.com
Cc: linux@endlessm.com
Cc: rafael.j.wysocki@intel.com
Link: http://lkml.kernel.org/r/20190509055417.13152-3-drake@endlessm.com
Link: https://lkml.kernel.org/r/20190419083533.32388-1-drake@endlessm.com
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/tsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6e6d933fb99c..8f47c4862c56 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -671,6 +671,16 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * The local APIC appears to be fed by the core crystal clock
+	 * (which sounds entirely sensible). We can set the global
+	 * lapic_timer_period here to avoid having to calibrate the APIC
+	 * timer later.
+	 */
+	lapic_timer_period = crystal_khz * 1000 / HZ;
+#endif
+
 	return crystal_khz * ebx_numerator / eax_denominator;
 }
 
