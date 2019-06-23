Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0854DC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC1820663
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QE8WrCXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFWMQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:16:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37867 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFWMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:16:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NCGFds2628585
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 05:16:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NCGFds2628585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561292176;
        bh=W2/TO928gvP0dcSWSbNsBo/E6mSsInsl5Qy9X27bdL4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QE8WrCXTGQYhZMSlpOYvRYd02e//LcbvHYplTgFrTHtHZCTRvkhzE+lu1qpYv4+Bn
         LBWvhA6sQppoT/D3WXcXvc0I0jnmrqL5B2uhnbnMqD7ICh6IsKtMGSZGcV1MCNq4DH
         zm1/Wln7BvgcEJAjIkvNDmlk7c+H1BvXVatJqeKrrG5liEJY8pOX8TJ43OvInzDk/7
         P3aUy6mBAc+t2xLKbtwDFc9U4ttDNe7BbKxqklu4mzIHG8c9NakuZYMlTXc5Zjo6Rv
         m/evqZJwVIQfiEowZ1qMJukwsqcA9jpJ+PauVA0JR1TqGqHnff6i8/t1UmLATgG2QE
         bZN8qIw/Z686w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NCGEQD2628582;
        Sun, 23 Jun 2019 05:16:14 -0700
Date:   Sun, 23 Jun 2019 05:16:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-dde3626f815e38bbf96fddd5185038c4b4d395a8@git.kernel.org>
Cc:     peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com,
        bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, namit@vmware.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, namit@vmware.com, peterz@infradead.org,
          luto@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de
In-Reply-To: <20190613064813.8102-10-namit@vmware.com>
References: <20190613064813.8102-10-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Use non-atomic operations when possible
Git-Commit-ID: dde3626f815e38bbf96fddd5185038c4b4d395a8
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

Commit-ID:  dde3626f815e38bbf96fddd5185038c4b4d395a8
Gitweb:     https://git.kernel.org/tip/dde3626f815e38bbf96fddd5185038c4b4d395a8
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 12 Jun 2019 23:48:13 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 23 Jun 2019 14:07:23 +0200

x86/apic: Use non-atomic operations when possible

Using __clear_bit() and __cpumask_clear_cpu() is more efficient than using
their atomic counterparts.

Use them when atomicity is not needed, such as when manipulating bitmasks
that are on the stack.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20190613064813.8102-10-namit@vmware.com

---
 arch/x86/kernel/apic/apic_flat_64.c   | 4 ++--
 arch/x86/kernel/apic/x2apic_cluster.c | 2 +-
 arch/x86/kernel/smp.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 0005c284a5c5..65072858f553 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -78,7 +78,7 @@ flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
 	int cpu = smp_processor_id();
 
 	if (cpu < BITS_PER_LONG)
-		clear_bit(cpu, &mask);
+		__clear_bit(cpu, &mask);
 
 	_flat_send_IPI_mask(mask, vector);
 }
@@ -92,7 +92,7 @@ static void flat_send_IPI_allbutself(int vector)
 			unsigned long mask = cpumask_bits(cpu_online_mask)[0];
 
 			if (cpu < BITS_PER_LONG)
-				clear_bit(cpu, &mask);
+				__clear_bit(cpu, &mask);
 
 			_flat_send_IPI_mask(mask, vector);
 		}
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 7685444a106b..609e499387a1 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -50,7 +50,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 	cpumask_copy(tmpmsk, mask);
 	/* If IPI should not be sent to self, clear current CPU */
 	if (apic_dest != APIC_DEST_ALLINC)
-		cpumask_clear_cpu(smp_processor_id(), tmpmsk);
+		__cpumask_clear_cpu(smp_processor_id(), tmpmsk);
 
 	/* Collapse cpus in a cluster so a single IPI per cluster is sent */
 	for_each_cpu(cpu, tmpmsk) {
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 04adc8d60aed..acddd988602d 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -146,7 +146,7 @@ void native_send_call_func_ipi(const struct cpumask *mask)
 	}
 
 	cpumask_copy(allbutself, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), allbutself);
+	__cpumask_clear_cpu(smp_processor_id(), allbutself);
 
 	if (cpumask_equal(mask, allbutself) &&
 	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
