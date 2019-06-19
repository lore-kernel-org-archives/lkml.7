Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B4AC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792EE2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560930577;
	bh=K7C+XbzsaxR4wOymDxOJZZi8hO/ysQEL/vXyWuxa2u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdPju0xaoFIi3S5mBp2YbGBv5OJCEbwYF6IrMgwescnpbq/ebQEEYQh2mUjcUQnI1
	 aNQv6JKePf4Gtnb/0WiP4460Seoa1rnTA9JHz4LLDgVqhJvv7jpwRgMhUWCZ/3KR8i
	 IJb0kpl7+uSW6EEs9BrzKvxQ7MuRKyEwValYNzss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfFSHtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731253AbfFSHtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:49:33 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0B72147A;
        Wed, 19 Jun 2019 07:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560930572;
        bh=K7C+XbzsaxR4wOymDxOJZZi8hO/ysQEL/vXyWuxa2u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0OllnGuIl/hx6pUqoVUIbKHBBiMAKBQIaD/jrzYiRybVAIz7op0HFFHeKJ9n6Glj
         nt+/pvjhBO/QaHfjGw4ReEOx8nMO0PvnYYDZ/+d5TvUFv2t1DqpjwSPj+8imW9LLKE
         IlX9ULWRh4+pplxFNMwfMhp7D4jU2zLxgC16MSr0=
From:   guoren@kernel.org
To:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 2/4] arch: Add generic asid implement from arm
Date:   Wed, 19 Jun 2019 15:49:11 +0800
Message-Id: <1560930553-26502-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560930553-26502-1-git-send-email-guoren@kernel.org>
References: <1560930553-26502-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The asid code is from arm64 and here is the ref link:
https://lore.kernel.org/linux-arm-kernel/20190321163623.20219-12-julien.grall@arm.com/

Seems it's good for other arch to implement asid.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/asid.h |  77 ++++++++++++++++++
 arch/csky/mm/Makefile        |   1 +
 arch/csky/mm/asid.c          | 185 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 arch/csky/include/asm/asid.h
 create mode 100644 arch/csky/mm/asid.c

diff --git a/arch/csky/include/asm/asid.h b/arch/csky/include/asm/asid.h
new file mode 100644
index 0000000..bb62b58
--- /dev/null
+++ b/arch/csky/include/asm/asid.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ASM_ASID_H
+#define __ASM_ASM_ASID_H
+
+#include <linux/atomic.h>
+#include <linux/compiler.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+
+struct asid_info
+{
+	atomic64_t	generation;
+	unsigned long	*map;
+	atomic64_t __percpu	*active;
+	u64 __percpu		*reserved;
+	u32			bits;
+	/* Lock protecting the structure */
+	raw_spinlock_t		lock;
+	/* Which CPU requires context flush on next call */
+	cpumask_t		flush_pending;
+	/* Number of ASID allocated by context (shift value) */
+	unsigned int		ctxt_shift;
+	/* Callback to locally flush the context. */
+	void			(*flush_cpu_ctxt_cb)(void);
+};
+
+#define NUM_ASIDS(info)			(1UL << ((info)->bits))
+#define NUM_CTXT_ASIDS(info)		(NUM_ASIDS(info) >> (info)->ctxt_shift)
+
+#define active_asid(info, cpu)	*per_cpu_ptr((info)->active, cpu)
+
+void asid_new_context(struct asid_info *info, atomic64_t *pasid,
+		      unsigned int cpu);
+
+/*
+ * Check the ASID is still valid for the context. If not generate a new ASID.
+ *
+ * @pasid: Pointer to the current ASID batch
+ * @cpu: current CPU ID. Must have been acquired throught get_cpu()
+ */
+static inline void asid_check_context(struct asid_info *info,
+				      atomic64_t *pasid, unsigned int cpu)
+{
+	u64 asid, old_active_asid;
+
+	asid = atomic64_read(pasid);
+
+	/*
+	 * The memory ordering here is subtle.
+	 * If our active_asid is non-zero and the ASID matches the current
+	 * generation, then we update the active_asid entry with a relaxed
+	 * cmpxchg. Racing with a concurrent rollover means that either:
+	 *
+	 * - We get a zero back from the cmpxchg and end up waiting on the
+	 *   lock. Taking the lock synchronises with the rollover and so
+	 *   we are forced to see the updated generation.
+	 *
+	 * - We get a valid ASID back from the cmpxchg, which means the
+	 *   relaxed xchg in flush_context will treat us as reserved
+	 *   because atomic RmWs are totally ordered for a given location.
+	 */
+	old_active_asid = atomic64_read(&active_asid(info, cpu));
+	if (old_active_asid &&
+	    !((asid ^ atomic64_read(&info->generation)) >> info->bits) &&
+	    atomic64_cmpxchg_relaxed(&active_asid(info, cpu),
+				     old_active_asid, asid))
+		return;
+
+	asid_new_context(info, pasid, cpu);
+}
+
+int asid_allocator_init(struct asid_info *info,
+			u32 bits, unsigned int asid_per_ctxt,
+			void (*flush_cpu_ctxt_cb)(void));
+
+#endif
diff --git a/arch/csky/mm/Makefile b/arch/csky/mm/Makefile
index c870eb3..897368f 100644
--- a/arch/csky/mm/Makefile
+++ b/arch/csky/mm/Makefile
@@ -11,3 +11,4 @@ obj-y +=			init.o
 obj-y +=			ioremap.o
 obj-y +=			syscache.o
 obj-y +=			tlb.o
+obj-y +=			asid.o
diff --git a/arch/csky/mm/asid.c b/arch/csky/mm/asid.c
new file mode 100644
index 0000000..72b71bf
--- /dev/null
+++ b/arch/csky/mm/asid.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic ASID allocator.
+ *
+ * Based on arch/arm/mm/context.c
+ *
+ * Copyright (C) 2002-2003 Deep Blue Solutions Ltd, all rights reserved.
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#include <linux/slab.h>
+
+#include <asm/asid.h>
+
+#define reserved_asid(info, cpu) *per_cpu_ptr((info)->reserved, cpu)
+
+#define ASID_MASK(info)			(~GENMASK((info)->bits - 1, 0))
+#define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))
+
+#define asid2idx(info, asid)		(((asid) & ~ASID_MASK(info)) >> (info)->ctxt_shift)
+#define idx2asid(info, idx)		(((idx) << (info)->ctxt_shift) & ~ASID_MASK(info))
+
+static void flush_context(struct asid_info *info)
+{
+	int i;
+	u64 asid;
+
+	/* Update the list of reserved ASIDs and the ASID bitmap. */
+	bitmap_clear(info->map, 0, NUM_CTXT_ASIDS(info));
+
+	for_each_possible_cpu(i) {
+		asid = atomic64_xchg_relaxed(&active_asid(info, i), 0);
+		/*
+		 * If this CPU has already been through a
+		 * rollover, but hasn't run another task in
+		 * the meantime, we must preserve its reserved
+		 * ASID, as this is the only trace we have of
+		 * the process it is still running.
+		 */
+		if (asid == 0)
+			asid = reserved_asid(info, i);
+		__set_bit(asid2idx(info, asid), info->map);
+		reserved_asid(info, i) = asid;
+	}
+
+	/*
+	 * Queue a TLB invalidation for each CPU to perform on next
+	 * context-switch
+	 */
+	cpumask_setall(&info->flush_pending);
+}
+
+static bool check_update_reserved_asid(struct asid_info *info, u64 asid,
+				       u64 newasid)
+{
+	int cpu;
+	bool hit = false;
+
+	/*
+	 * Iterate over the set of reserved ASIDs looking for a match.
+	 * If we find one, then we can update our mm to use newasid
+	 * (i.e. the same ASID in the current generation) but we can't
+	 * exit the loop early, since we need to ensure that all copies
+	 * of the old ASID are updated to reflect the mm. Failure to do
+	 * so could result in us missing the reserved ASID in a future
+	 * generation.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (reserved_asid(info, cpu) == asid) {
+			hit = true;
+			reserved_asid(info, cpu) = newasid;
+		}
+	}
+
+	return hit;
+}
+
+static u64 new_context(struct asid_info *info, atomic64_t *pasid)
+{
+	static u32 cur_idx = 1;
+	u64 asid = atomic64_read(pasid);
+	u64 generation = atomic64_read(&info->generation);
+
+	if (asid != 0) {
+		u64 newasid = generation | (asid & ~ASID_MASK(info));
+
+		/*
+		 * If our current ASID was active during a rollover, we
+		 * can continue to use it and this was just a false alarm.
+		 */
+		if (check_update_reserved_asid(info, asid, newasid))
+			return newasid;
+
+		/*
+		 * We had a valid ASID in a previous life, so try to re-use
+		 * it if possible.
+		 */
+		if (!__test_and_set_bit(asid2idx(info, asid), info->map))
+			return newasid;
+	}
+
+	/*
+	 * Allocate a free ASID. If we can't find one, take a note of the
+	 * currently active ASIDs and mark the TLBs as requiring flushes.  We
+	 * always count from ASID #2 (index 1), as we use ASID #0 when setting
+	 * a reserved TTBR0 for the init_mm and we allocate ASIDs in even/odd
+	 * pairs.
+	 */
+	asid = find_next_zero_bit(info->map, NUM_CTXT_ASIDS(info), cur_idx);
+	if (asid != NUM_CTXT_ASIDS(info))
+		goto set_asid;
+
+	/* We're out of ASIDs, so increment the global generation count */
+	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION(info),
+						 &info->generation);
+	flush_context(info);
+
+	/* We have more ASIDs than CPUs, so this will always succeed */
+	asid = find_next_zero_bit(info->map, NUM_CTXT_ASIDS(info), 1);
+
+set_asid:
+	__set_bit(asid, info->map);
+	cur_idx = asid;
+	return idx2asid(info, asid) | generation;
+}
+
+/*
+ * Generate a new ASID for the context.
+ *
+ * @pasid: Pointer to the current ASID batch allocated. It will be updated
+ * with the new ASID batch.
+ * @cpu: current CPU ID. Must have been acquired through get_cpu()
+ */
+void asid_new_context(struct asid_info *info, atomic64_t *pasid,
+		      unsigned int cpu)
+{
+	unsigned long flags;
+	u64 asid;
+
+	raw_spin_lock_irqsave(&info->lock, flags);
+	/* Check that our ASID belongs to the current generation. */
+	asid = atomic64_read(pasid);
+	if ((asid ^ atomic64_read(&info->generation)) >> info->bits) {
+		asid = new_context(info, pasid);
+		atomic64_set(pasid, asid);
+	}
+
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
+		info->flush_cpu_ctxt_cb();
+
+	atomic64_set(&active_asid(info, cpu), asid);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
+}
+
+/*
+ * Initialize the ASID allocator
+ *
+ * @info: Pointer to the asid allocator structure
+ * @bits: Number of ASIDs available
+ * @asid_per_ctxt: Number of ASIDs to allocate per-context. ASIDs are
+ * allocated contiguously for a given context. This value should be a power of
+ * 2.
+ */
+int asid_allocator_init(struct asid_info *info,
+			u32 bits, unsigned int asid_per_ctxt,
+			void (*flush_cpu_ctxt_cb)(void))
+{
+	info->bits = bits;
+	info->ctxt_shift = ilog2(asid_per_ctxt);
+	info->flush_cpu_ctxt_cb = flush_cpu_ctxt_cb;
+	/*
+	 * Expect allocation after rollover to fail if we don't have at least
+	 * one more ASID than CPUs. ASID #0 is always reserved.
+	 */
+	WARN_ON(NUM_CTXT_ASIDS(info) - 1 <= num_possible_cpus());
+	atomic64_set(&info->generation, ASID_FIRST_VERSION(info));
+	info->map = kcalloc(BITS_TO_LONGS(NUM_CTXT_ASIDS(info)),
+			    sizeof(*info->map), GFP_KERNEL);
+	if (!info->map)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&info->lock);
+
+	return 0;
+}
-- 
2.7.4

