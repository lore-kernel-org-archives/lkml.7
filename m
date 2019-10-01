Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B13ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA520679
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfJARnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:43:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56058 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJARnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:43:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFMBF-0000rE-0M; Tue, 01 Oct 2019 19:43:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A9BCD1C070D;
        Tue,  1 Oct 2019 19:43:20 +0200 (CEST)
Date:   Tue, 01 Oct 2019 17:43:20 -0000
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Update late microcode in parallel
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
References: <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Message-ID: <156995180065.9978.1515455093579209484.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     93946a33b5693a6bbcf917a170198ff4afaa7a31
Gitweb:        https://git.kernel.org/tip/93946a33b5693a6bbcf917a170198ff4afaa7a31
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Thu, 22 Aug 2019 23:43:47 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 15:58:54 +02:00

x86/microcode: Update late microcode in parallel

Microcode update was changed to be serialized due to restrictions after
Spectre days. Updating serially on a large multi-socket system can be
painful since it is being done on one CPU at a time.

Cloud customers have expressed discontent as services disappear for
a prolonged time. The restriction is that only one core (or only one
thread of a core in the case of an SMT system) goes through the update
while other cores (or respectively, SMT threads) are quiesced.

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
 arch/x86/kernel/cpu/microcode/core.c | 36 +++++++++++++++------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index cb0fdca..7019d4b 100644
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
