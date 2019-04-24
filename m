Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05410C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7497218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hcmVvLXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfDXAC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:02:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53963 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDXACY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556064144; x=1587600144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TsI1Vv+BQuc7zHn+F6+ygwuhtzAPsWvsEfC04f75S54=;
  b=hcmVvLXzmR6/KC91OqV4N5a0ojf09mjIXH4OZVvZjaRkaWSFvU/0W3Vr
   mK1tHo2bskjB//pnl4Vv5e0eS7D3OSnQqe2wUBo/mhnODchzz/34i6Fw0
   p8ueP5Wx1nQnWYBKf+P4VPyApCzQk9mTGqKaA5j/viSNp5jgWGTUYjnEX
   mrFE272/EiIjJZUQ/YGSfu2RMXK1Hyzkit+9fSLeKxuL5CLpshrEuIc9u
   m2AGGEvLbgc4LnvHirZoZm5d/haU6NkSeBXJyJ+folJsVe0StTr5oRvA6
   bZsuMNdfTSAF3sa/su9l/cIYDBcrUZIGqJNNkmyctciZU+HgnAngw8UT6
   w==;
X-IronPort-AV: E=Sophos;i="5.60,387,1549900800"; 
   d="scan'208";a="106649531"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2019 08:02:23 +0800
IronPort-SDR: g053JX2sCYNsumIA9nDPNaBqWwsYAhjOWcrIWbma3vlaxY0frpZ3DbpMS4L0HDSLW1uybrPVi7
 wDChiAOwM/Yx6oaHLyF9GQ1h8tMZHr7wS/0f52bnE3Zx3Q4TOngHUITvQOuB6r3BMPeWEOlsS5
 a5oF6HROgjiFuNu1HG+8gnvLzTvwbqefoDSMsid78IFbszYnM9Cgnopy8+DRoNtmScUQFCky5D
 PQV7GNNUmOB1/HMgn+pOYETF6ub4jzMDz5HQD+8E96OIZ6OHo8lqpwQLO3+MITucS9LIy0zCzs
 HYgKoR36rLLJ5cT75UzfEyh3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 Apr 2019 16:41:03 -0700
IronPort-SDR: 8ArrhRcNMCh7vFl00ASwZSp12erSVVdrGP6n/aHcpXoKHZtU/T5W2OuihEo8qL7IL/sR7DAv+m
 MYNs19kwKsXUGXf9q/W+N+aKrK+nWIDLWENFZiX2A6jCUDCwzqnPoC7QD4w3WLbM04CEzl16mh
 Q2EzSHZoikUIXA4VjiBbCp7SIh5I5Ssh0/XLZrmvXFrrvP3pi/X8NuTjjVO0WH7dBNV/5ZkGUv
 oyAU4MrGda9tYZ1yrmHAq/cqy8rFt8k0Z0jlMqbMaGn8UiDY7T2+l8Gm0PtWa8ErXb5mJDKYQY
 0hc=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Apr 2019 17:02:23 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 1/3] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
Date:   Tue, 23 Apr 2019 17:02:25 -0700
Message-Id: <20190424000227.3085-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424000227.3085-1-atish.patra@wdc.com>
References: <20190424000227.3085-1-atish.patra@wdc.com>
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
---
 arch/riscv/kernel/cpu.c | 3 +--
 arch/riscv/kernel/smp.c | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

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
index 0c41d07ec281..94db72662f60 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -70,6 +70,11 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
 	for_each_cpu(cpu, in)
 		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
 }
+
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == cpuid_to_hartid_map(cpu);
+}
 /* Unsupported */
 int setup_profiling_timer(unsigned int multiplier)
 {
-- 
2.21.0

