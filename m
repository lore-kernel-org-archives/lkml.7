Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA16C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6EF218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WbgnNj+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfDXVsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:48:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15282 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfDXVsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556142492; x=1587678492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ptio9EMvYP5f+ORUvvZuKR6bpx8beU1V6Uj718zf84I=;
  b=WbgnNj+7sswrkPVvXzhJr3Bs7sgUedtYzjhjwsNKIINedMN7YPXjtuaF
   6YF64lF2UAJnpHgILNULqDgdxqsAgxn5zHivdjDBpSGa5+dQpxnfDJGSI
   AqO7eQ+BHlpNvgtdxyXX658qkrQ+uthK7ocb2ol81gVmSnpQgNG4m65eH
   Db+5kBlkcVJdMBAnhpa1SrFymfsdoaj+rhYzqFx4VLJJXX1yHyOu7GrpZ
   VIheGgOZV+IltmGiEaxjHB+Nvf/wC2J5d/0KpjAibLGewUBMiUwB6LGmp
   J/rn72LwWIu1SKEPKg3h5C+E9FOq0+KTZ9TSrnkFMeTGKpKlUItlhVwgp
   A==;
X-IronPort-AV: E=Sophos;i="5.60,391,1549900800"; 
   d="scan'208";a="106739583"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 05:48:12 +0800
IronPort-SDR: BPjY0gW5YQuY23KmVCY0BhYMcGH/a7gKlnfctYGjzJ7N2w8Dr+se46BWEV5rNDcCfjFd/HvFcm
 ofPgDbwN+V3l4SAjN4W4nEHp8HE3r4fNhqtjctZHfiNHVBq0XIos/FcNbTRL+LReRnjTIoP6VQ
 GenzQ4uq8Q5MyWr8XWQMqVwbVUWYWtvSZgawX8mO5p0IhwEsl0vNTIoRwTJ0zBzLvMcY76AsVY
 D5hdoW0OSObPcNj0rErAzPgGRbCIOm7niV3bUP5X3u1geUxCCb8+9liCiPmjbX5Nlm+rleg5r7
 oJXt6Xiti1yCTHxazV+P0hlp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Apr 2019 14:26:51 -0700
IronPort-SDR: quCW3b+lX1Ndy1Wt7UxWgfVqe8zOsHY0ctGiHEEhl8VQViFsLHwbAKApNMc4MLDnJ71TfEvJhG
 5fmonddg2oJW1G2U9rn9a7BumtehvKQptK86BofNA8471TxgDQT6rF/2i9WS+QuFMkU9GAFp4o
 2y/UkPjhmrIk5VUtMBi1zS00v9Ohr9fgMct/lsRVpT7EixYquKGXVPDBGRyLy2P1hCDHLp/J7W
 5424QVAXORveZ4zm0dLvUkuzw8uFB6G1HdmrcfKGv0ancXO1BgZz7LAfvAcEfa1WjJDwpUSMj7
 lLc=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2019 14:48:12 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@lst.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 1/4] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
Date:   Wed, 24 Apr 2019 14:47:58 -0700
Message-Id: <20190424214801.18880-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424214801.18880-1-atish.patra@wdc.com>
References: <20190424214801.18880-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OF/DT core has a hook for architecture specific logical cpuid to hartid
mapping. By implementing this, we can pass the logical cpu id to cpu
node parsing functions.

Fix the instances where logical cpuid is expected as an argument in
of_get_cpu_node.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/riscv/kernel/cpu.c | 3 +--
 arch/riscv/kernel/smp.c | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index cf2fca12414a..c8d2a3223099 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -136,8 +136,7 @@ static void c_stop(struct seq_file *m, void *v)
 static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
-	struct device_node *node = of_get_cpu_node(cpuid_to_hartid_map(cpu_id),
-						   NULL);
+	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
 	const char *compat, *isa, *mmu;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 0c41d07ec281..89251f8ab754 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -70,6 +70,12 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
 	for_each_cpu(cpu, in)
 		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
 }
+
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == cpuid_to_hartid_map(cpu);
+}
+
 /* Unsupported */
 int setup_profiling_timer(unsigned int multiplier)
 {
-- 
2.21.0

