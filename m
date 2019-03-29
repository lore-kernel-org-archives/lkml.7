Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7580C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C6E217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XejiKX18";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bBG1jeDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfC2Evm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:51:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48714 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfC2Evl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553835102; x=1585371102;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5tGHt/ZuLYLMb9Shkqa2jlIAogO0xazPLoWwHVxj4Dg=;
  b=XejiKX18buF3IGCe6TVYXb/95NQQDycuzGwmFQ8DTG7QHTeOfe9qys90
   IH0y9t9ol+GTzoaiOJBQlgAsTPipfzKzB4k1zCDaIocTiahEjEdjTFm6f
   wSC+glYR5kstbwZSLTbb//4p6e0jyt/ARv6MM5e6T0zku48/BVMD55cWN
   efLDeXvzPpr4PeuSRRUE0yFkq2Th/eBjGAV8rismeb6jV6WtQpfHiT4ex
   1t7VXv1MnkvnFLl1TzN3FYqh69cmmwxpL1ZAj+XtufkNLGFnBnMhH7nd2
   sY+rO9zt4A5A4+olkFvcFsXtWoZbD3uujNzucV6zYS/jE98FuFombA25m
   w==;
X-IronPort-AV: E=Sophos;i="5.60,283,1549900800"; 
   d="scan'208";a="109588738"
Received: from mail-bn3nam01lp2057.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.57])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2019 12:51:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDs7s8AvUR+L8QYDb5NXHyoWylzPdiWyOTQqifr4Kb4=;
 b=bBG1jeDwliQJ913RiSL0EPSwXF/SIcSaSP/E9UfFmcgneOML+wDuJOzkSeqR1pW2QG9rwb1kK53vmO9HQt5hoFxjs6iSc2JKN5hQBEumATJGV/HYYDC6ckrJ73WcW5X1gl9pVNURonIvnBtzIKYrDHxoTWUquPCKe3s2VpfuTIU=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5968.namprd04.prod.outlook.com (20.178.248.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 04:51:38 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 04:51:38 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Gary Guo <gary@garyguo.net>, Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v3] RISC-V: Implement ASID allocator
Thread-Topic: [PATCH v3] RISC-V: Implement ASID allocator
Thread-Index: AQHU5esYcKUYlrhYQE6qB9Kl4zyh4Q==
Date:   Fri, 29 Mar 2019 04:51:38 +0000
Message-ID: <20190329045111.14040-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbe24031-2c77-481a-a45a-08d6b4023a2b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB5968;
x-ms-traffictypediagnostic: MN2PR04MB5968:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5968ABC18C75E85E40DF29B28D5A0@MN2PR04MB5968.namprd04.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(55674003)(189003)(199004)(5660300002)(186003)(99286004)(106356001)(1076003)(81156014)(81166006)(2171002)(6436002)(14454004)(52116002)(7736002)(26005)(36756003)(6486002)(2616005)(44832011)(386003)(30864003)(6116002)(6506007)(476003)(966005)(25786009)(14444005)(3846002)(256004)(316002)(102836004)(305945005)(54906003)(71190400001)(110136005)(71200400001)(97736004)(68736007)(6512007)(478600001)(105586002)(53936002)(486006)(6306002)(4326008)(86362001)(50226002)(2906002)(8676002)(72206003)(8936002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5968;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2/HxcNXZXh5W33NJNZBtt+fzWdyk6PemUrcpHCPZkTA9CBnKhAg3GYUcZTOFdIJENXj90r+bS992wN69WuNNjifXDpXSvOKG+zeRaSE7LJqb/fhHnwSj2oLfD8k816FhMtcgLxbJEcNZS0idyM7xOQutBXUQap6KfijZ5hSaKCdBqNwgPASD3z/vBUPu/L53MeLJfPDNf1rxo+zogg0j1Q1e2eoaVKqlmyFKXH4iNMBajIZKnbNUknmjw2MtLqaYC8zgW7Clgwrhj9J6KNKLpNPZDlJAZ8aV2sdhs2lURy6i1X2MZcwpMOcT8LX+E9DvuC6B/HKMtCQ6xTmsCZkWfbB7KX5oqg2s8gS1BwVlk00yxl4tVU0TEaQSI47eA+d0s5t3JofnYYKftF6B4d9+zQCWnrgbkkOSNXpMPNumTq4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe24031-2c77-481a-a45a-08d6b4023a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 04:51:38.4190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we do local TLB flush on every MM switch. This is very harsh on
performance because we are forcing page table walks after every MM switch.

This patch implements ASID allocator for assigning an ASID to a MM context.
The number of ASIDs are limited in HW so we create a logical entity named
CONTEXTID for assigning to MM context. The lower bits of CONTEXTID are ASID
and upper bits are VERSION number. The number of usable ASID bits supported
by HW are detected at boot-time by writing 1s to ASID bits in SATP CSR.

We allocate new CONTEXTID on first MM switch for a MM context where the
ASID is allocated from an ASID bitmap and VERSION is provide by an atomic
counter. At time of allocating new CONTEXTID, if we run out of available
ASIDs then:
1. We flush the ASID bitmap
2. Increment current VERSION atomic counter
3. Re-allocate ASID from ASID bitmap
4. Flush TLB on all CPUs
5. Try CONTEXTID re-assignment on all CPUs

Please note that we don't use ASID #0 because it is used at boot-time by
all CPUs for initial MM context. Also, newly created context is always
assigned CONTEXTID #0 (i.e. VERSION #0 and ASID #0) which is an invalid
context in our implementation.

Using above approach, we have virtually infinite CONTEXTIDs on-top-of
limited number of HW ASIDs. This approach is inspired from ASID allocator
used for Linux ARM/ARM64 but we have adapted it for RISC-V. Overall, this
ASID allocator helps us reduce rate of local TLB flushes on every CPU
thereby increasing performance.

This patch is tested on QEMU/virt machine and SiFive Unleashed board. On
QEMU/virt machine, we see 10% (approx) performance improvement with SW
emulated TLBs provided by QEMU. Unfortunately, ASID bits of SATP CSR are
not implemented on SiFive Unleashed board so we don't see any change in
performance.

Co-developed-by:: Gary Guo <gary@garyguo.net>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
Changes since v2:
- Move to lazy TLB flushing because we get slow path warnings if we
  use flush_tlb_all()
- Don't set ASID bits to all 1s in head.s. Instead just do it on
  boot CPU calling asids_init() for determining number of HW ASID bits
- Make CONTEXT version comparison more readable in set_mm_asid()
- Fix typo in __flush_context()

Changes since v1:
- We adapt good aspects from Gary Guo's ASID allocator implementation
  and provide due credit to him by adding his SoB.
- Track ASIDs active during context flush and mark them as reserved
- Set ASID bits to all 1s to simplify number of ASID bit detection
- Use atomic_long_t instead of atomic64_t for being 32bit friendly
- Use unsigned long instead of u64 for being 32bit friendly
- Use flush_tlb_all() instead of lazy local_tlb_flush_all() at time
  of context flush

This patch is based on Linux-5.1-rc2 and TLB flush cleanup patches v4
from Gary Guo. It can be also found in riscv_asid_allocator_v3 branch
of https://github.com/avpatel/linux.git
---
 arch/riscv/include/asm/csr.h         |   6 +
 arch/riscv/include/asm/mmu.h         |   1 +
 arch/riscv/include/asm/mmu_context.h |   1 +
 arch/riscv/mm/context.c              | 261 ++++++++++++++++++++++++++-
 4 files changed, 259 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 28a0d1cb374c..ce18ab8f53ed 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -45,10 +45,16 @@
 #define SATP_PPN     _AC(0x003FFFFF, UL)
 #define SATP_MODE_32 _AC(0x80000000, UL)
 #define SATP_MODE    SATP_MODE_32
+#define SATP_ASID_BITS	9
+#define SATP_ASID_SHIFT	22
+#define SATP_ASID_MASK	_AC(0x1FF, UL)
 #else
 #define SATP_PPN     _AC(0x00000FFFFFFFFFFF, UL)
 #define SATP_MODE_39 _AC(0x8000000000000000, UL)
 #define SATP_MODE    SATP_MODE_39
+#define SATP_ASID_BITS	16
+#define SATP_ASID_SHIFT	44
+#define SATP_ASID_MASK	_AC(0xFFFF, UL)
 #endif

 /* Interrupt Enable and Interrupt Pending flags */
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 5df2dccdba12..42a9ca0fe1fb 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -18,6 +18,7 @@
 #ifndef __ASSEMBLY__

 typedef struct {
+	atomic_long_t id;
 	void *vdso;
 #ifdef CONFIG_SMP
 	/* A local icache flush is needed before user execution can resume. */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/=
mmu_context.h
index bf4f097a9051..bd271c6b0e5e 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -30,6 +30,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 static inline int init_new_context(struct task_struct *task,
 	struct mm_struct *mm)
 {
+	atomic_long_set(&mm->context.id, 0);
 	return 0;
 }

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 0f787bcd3a7a..863b6926d6d9 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -2,13 +2,213 @@
 /*
  * Copyright (C) 2012 Regents of the University of California
  * Copyright (C) 2017 SiFive
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
  */

+#include <linux/bitops.h>
 #include <linux/mm.h>
+#include <linux/slab.h>

 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>

+static bool use_asid_allocator;
+static unsigned long asid_bits;
+static unsigned long num_asids;
+static unsigned long asid_mask;
+
+static atomic_long_t current_version;
+
+static DEFINE_RAW_SPINLOCK(context_lock);
+static cpumask_t context_tlb_flush_pending;
+static unsigned long *context_asid_map;
+
+static DEFINE_PER_CPU(atomic_long_t, active_context);
+static DEFINE_PER_CPU(unsigned long, reserved_context);
+
+static bool check_update_reserved_context(unsigned long cntx,
+					  unsigned long newcntx)
+{
+	int cpu;
+	bool hit =3D false;
+
+	/*
+	 * Iterate over the set of reserved CONTEXT looking for a match.
+	 * If we find one, then we can update our mm to use new CONTEXT
+	 * (i.e. the same CONTEXT in the current_version) but we can't
+	 * exit the loop early, since we need to ensure that all copies
+	 * of the old CONTEXT are updated to reflect the mm. Failure to do
+	 * so could result in us missing the reserved CONTEXT in a future
+	 * version.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(reserved_context, cpu) =3D=3D cntx) {
+			hit =3D true;
+			per_cpu(reserved_context, cpu) =3D newcntx;
+		}
+	}
+
+	return hit;
+}
+
+/* Note: must be called with context_lock held */
+static void __flush_context(void)
+{
+	int i;
+	unsigned long cntx;
+
+	/* Update the list of reserved ASIDs and the ASID bitmap. */
+	bitmap_clear(context_asid_map, 0, num_asids);
+
+	/* Mark already acitve ASIDs as used */
+	for_each_possible_cpu(i) {
+		cntx =3D atomic_long_xchg_relaxed(&per_cpu(active_context, i), 0);
+		/*
+		 * If this CPU has already been through a rollover, but
+		 * hasn't run another task in the meantime, we must preserve
+		 * its reserved CONTEXT, as this is the only trace we have of
+		 * the process it is still running.
+		 */
+		if (cntx =3D=3D 0)
+			cntx =3D per_cpu(reserved_context, i);
+
+		__set_bit(cntx & asid_mask, context_asid_map);
+		per_cpu(reserved_context, i) =3D cntx;
+	}
+
+	/* Mark ASID #0 as used because it is used at boot-time */
+	__set_bit(0, context_asid_map);
+
+	/* Queue a TLB invalidation for each CPU on next context-switch */
+	cpumask_setall(&context_tlb_flush_pending);
+}
+
+/* Note: must be called with context_lock held */
+static unsigned long __new_context(struct mm_struct *mm)
+{
+	static u32 cur_idx =3D 1;
+	unsigned long cntx =3D atomic_long_read(&mm->context.id);
+	unsigned long asid, ver =3D atomic_long_read(&current_version);
+
+	if (cntx !=3D 0) {
+		unsigned long newcntx =3D ver | (cntx & asid_mask);
+
+		/*
+		 * If our current CONTEXT was active during a rollover, we
+		 * can continue to use it and this was just a false alarm.
+		 */
+		if (check_update_reserved_context(cntx, newcntx))
+			return newcntx;
+
+		/*
+		 * We had a valid CONTEXT in a previous life, so try to
+		 * re-use it if possible.
+		 */
+		if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
+			return newcntx;
+	}
+
+	/*
+	 * Allocate a free ASID. If we can't find one then increment
+	 * current_version and flush all ASIDs.
+	 */
+	asid =3D find_next_zero_bit(context_asid_map, num_asids, cur_idx);
+	if (asid !=3D num_asids)
+		goto set_asid;
+
+	/* We're out of ASIDs, so increment current_version */
+	ver =3D atomic_long_add_return_relaxed(num_asids, &current_version);
+
+	/* Flush everything  */
+	__flush_context();
+
+	/* We have more ASIDs than CPUs, so this will always succeed */
+	asid =3D find_next_zero_bit(context_asid_map, num_asids, 1);
+
+set_asid:
+	__set_bit(asid, context_asid_map);
+	cur_idx =3D asid;
+	return asid | ver;
+}
+
+static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
+{
+	unsigned long flags;
+	bool need_flush_tlb =3D false;
+	unsigned long cntx, old_active_cntx;
+
+	cntx =3D atomic_long_read(&mm->context.id);
+
+	/*
+	 * If our active_context is non-zero and the context matches the
+	 * current_version, then we update the active_context entry with a
+	 * relaxed cmpxchg.
+	 *
+	 * Following is how we handle racing with a concurrent rollover:
+	 *
+	 * - We get a zero back from the cmpxchg and end up waiting on the
+	 *   lock. Taking the lock synchronises with the rollover and so
+	 *   we are forced to see the updated verion.
+	 *
+	 * - We get a valid context back from the cmpxchg then we continue
+	 *   using old ASID because __flush_context() would have marked ASID
+	 *   of active_context as used and next context switch we will allocate
+	 *   new context.
+	 */
+	old_active_cntx =3D atomic_long_read(&per_cpu(active_context, cpu));
+	if (old_active_cntx &&
+	    ((cntx & ~asid_mask) =3D=3D atomic_long_read(&current_version)) &&
+	    atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
+					old_active_cntx, cntx))
+		goto switch_mm_fast;
+
+	raw_spin_lock_irqsave(&context_lock, flags);
+
+	/* Check that our ASID belongs to the current_version. */
+	cntx =3D atomic_long_read(&mm->context.id);
+	if ((cntx & ~asid_mask) !=3D atomic_long_read(&current_version)) {
+		cntx =3D __new_context(mm);
+		atomic_long_set(&mm->context.id, cntx);
+	}
+
+	if (cpumask_test_and_clear_cpu(cpu, &context_tlb_flush_pending))
+		need_flush_tlb =3D true;
+
+	atomic_long_set(&per_cpu(active_context, cpu), cntx);
+
+	raw_spin_unlock_irqrestore(&context_lock, flags);
+
+switch_mm_fast:
+	/*
+	 * Use the old spbtr name instead of using the current satp
+	 * name to support binutils 2.29 which doesn't know about the
+	 * privileged ISA 1.10 yet.
+	 */
+	csr_write(sptbr, virt_to_pfn(mm->pgd) |
+		  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
+		  SATP_MODE);
+
+	if (need_flush_tlb)
+		local_flush_tlb_all();
+}
+
+static void set_mm_noasid(struct mm_struct *mm)
+{
+	/*
+	 * Use the old spbtr name instead of using the current satp
+	 * name to support binutils 2.29 which doesn't know about the
+	 * privileged ISA 1.10 yet.
+	 */
+	csr_write(sptbr, virt_to_pfn(mm->pgd) | SATP_MODE);
+
+	/*
+	 * sfence.vma after SATP write. We call it on MM context instead of
+	 * calling local_flush_tlb_all to prevent global mappings from being
+	 * affected.
+	 */
+	local_flush_tlb_mm(mm);
+}
+
 /*
  * When necessary, performs a deferred icache flush for the given MM conte=
xt,
  * on the local CPU.  RISC-V has no direct mechanism for instruction cache
@@ -58,20 +258,61 @@ void switch_mm(struct mm_struct *prev, struct mm_struc=
t *next,
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));

+	if (use_asid_allocator)
+		set_mm_asid(next, cpu);
+	else
+		set_mm_noasid(next);
+
+	flush_icache_deferred(next);
+}
+
+static int asids_init(void)
+{
+	unsigned long old;
+
+	/* Figure-out number of ASID bits in HW */
+	old =3D csr_read(sptbr);
+	asid_bits =3D old | (SATP_ASID_MASK << SATP_ASID_SHIFT);
+	csr_write(sptbr, asid_bits);
+	asid_bits =3D (csr_read(sptbr) >> SATP_ASID_SHIFT)  & SATP_ASID_MASK;
+	asid_bits =3D fls_long(asid_bits);
+	csr_write(sptbr, old);
+
 	/*
-	 * Use the old spbtr name instead of using the current satp
-	 * name to support binutils 2.29 which doesn't know about the
-	 * privileged ISA 1.10 yet.
+	 * In the process of determining number of ASID bits (above)
+	 * we polluted the TLB of current HART so let's do TLB flushed
+	 * to remove unwanted TLB enteries.
 	 */
-	csr_write(sptbr, virt_to_pfn(next->pgd) | SATP_MODE);
+	local_flush_tlb_all();
+
+	/* Pre-compute ASID details */
+	num_asids =3D 1 << asid_bits;
+	asid_mask =3D num_asids - 1;

 	/*
-	 * sfence.vma after SATP write. We call it on MM context instead of
-	 * calling local_flush_tlb_all to prevent global mappings from being
-	 * affected.
+	 * Use ASID allocator only if number of HW ASIDs are
+	 * at-least twice more than CPUs
 	 */
-	local_flush_tlb_mm(next);
+	use_asid_allocator =3D
+		(num_asids <=3D (2 * num_possible_cpus())) ? false : true;

-	flush_icache_deferred(next);
-}
+	/* Setup ASID allocator if available */
+	if (use_asid_allocator) {
+		atomic_long_set(&current_version, num_asids);
+
+		context_asid_map =3D kcalloc(BITS_TO_LONGS(num_asids),
+				   sizeof(*context_asid_map), GFP_KERNEL);
+		if (!context_asid_map)
+			panic("Failed to allocate bitmap for %lu ASIDs\n",
+			      num_asids);
+
+		__set_bit(0, context_asid_map);

+		pr_info("ASID allocator using %lu entries\n", num_asids);
+	} else {
+		pr_info("ASID allocator disabled\n");
+	}
+
+	return 0;
+}
+early_initcall(asids_init);
--
2.17.1
