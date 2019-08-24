Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23662C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 08:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31CB2054F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 08:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Oy8xOXG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfHXIxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 04:53:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44298 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfHXIxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 04:53:05 -0400
Received: from zn.tnic (p200300EC2F1E9400E161D1CD3EE01E5E.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:9400:e161:d1cd:3ee0:1e5e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0C9F1EC0BFD;
        Sat, 24 Aug 2019 10:52:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566636779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZLn+13h2PlKx9iAq7LjCcfAf1Qw6jp25M0fbVgq2xQ0=;
        b=Oy8xOXG6pEBjP35HhL8awxyHPNv+nDKnp+Bo6KtZmpEJ0w+EHLMwoFWV5LQeeDveuq2IP0
        WYmOD0IYUlbWT4Zd+50lVDGPQenloUBw99bQeomuVrqS0eZ47IiGb/ndCDFGiKzrVQb0Gk
        NCBu5wA9haJE+uGsyWbIWV51CheUFTE=
Date:   Sat, 24 Aug 2019 10:53:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
Subject: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190824085300.GB16813@zn.tnic>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190824085156.GA16813@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>
Date: Thu, 22 Aug 2019 23:43:47 +0300

Microcode update was changed to be serialized due to restrictions after
Spectre days. Updating serially on a large multi-socket system can be
painful since it is being done on one CPU at a time.

Cloud customers have expressed discontent as services disappear for a
prolonged time. The restriction is that only one core goes through the
update while other cores are quiesced.

Do the microcode update only on the first thread of each core while
other siblings simply wait for this to complete.

 [ bp: Simplify, massage, cleanup comments. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jon Grimm <Jon.Grimm@amd.com>
Cc: kanth.ghatraju@oracle.com
Cc: konrad.wilk@oracle.com
Cc: patrick.colp@oracle.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1566506627-16536-2-git-send-email-mihai.carabas@oracle.com
---
 arch/x86/kernel/cpu/microcode/core.c | 36 ++++++++++++++++------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index cb0fdcaf1415..7019d4b2df0c 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -63,11 +63,6 @@ LIST_HEAD(microcode_cache);
  */
 static DEFINE_MUTEX(microcode_mutex);
 
-/*
- * Serialize late loading so that CPUs get updated one-by-one.
- */
-static DEFINE_RAW_SPINLOCK(update_lock);
-
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -566,11 +561,18 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
-	raw_spin_lock(&update_lock);
-	apply_microcode_local(&err);
-	raw_spin_unlock(&update_lock);
+	/*
+	 * On an SMT system, it suffices to load the microcode on one sibling of
+	 * the core because the microcode engine is shared between the threads.
+	 * Synchronization still needs to take place so that no concurrent
+	 * loading attempts happen on multiple threads of an SMT core. See
+	 * below.
+	 */
+	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
+		apply_microcode_local(&err);
+	else
+		goto wait_for_siblings;
 
-	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
 		ret = -1;
@@ -578,14 +580,18 @@ static int __reload_late(void *info)
 		ret = 1;
 	}
 
+wait_for_siblings:
+	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
+		panic("Timeout during microcode update!\n");
+
 	/*
-	 * Increase the wait timeout to a safe value here since we're
-	 * serializing the microcode update and that could take a while on a
-	 * large number of CPUs. And that is fine as the *actual* timeout will
-	 * be determined by the last CPU finished updating and thus cut short.
+	 * At least one thread has completed update on each core.
+	 * For others, simply call the update to make sure the
+	 * per-cpu cpuinfo can be updated with right microcode
+	 * revision.
 	 */
-	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC * num_online_cpus()))
-		panic("Timeout during microcode update!\n");
+	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
+		apply_microcode_local(&err);
 
 	return ret;
 }
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
