Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293CB2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gA9SWoCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfCSWUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6004 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfCSWUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553034040; x=1584570040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k5J6+qgl1gVFESf4xZxUc40mWhR5uxNVP8yAnN65YwE=;
  b=gA9SWoCnmg1BfQO5KmgJF+uTAEG/C83ftXkpqtD1E26IWl7Ir30lQo6y
   7EIaaEMNBMidRoLqaKW7SmlrFJoirg92HKgM8VZSO/iLcLrWuwcLIhoSz
   dFqW8OsvEnWgIkKtAAz7kiJ43DMMta/J9UOa5efsJ2e5HXugt3g5d+4IY
   T8zzA7fORC7teaFezynzFADbj0bIlRpOeecpoFvToFGgkxl65rFwwQly5
   bBV3+32fnSJg4mltBrKEzRwUrJf00xCPPSH3lH5hkVvuSP1TkY1gG6lEH
   769qgpma03htzK2g+gSdYnHXYewD750WBko47oZlSkLD446ffkkvnA4SO
   A==;
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="105523533"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 06:20:40 +0800
IronPort-SDR: dVOIt73Bh6M+HJbhdCtFdPGGA6z5oeGCfKe0v9mI8eWkVwoFPoNjBk5NarktNsFDo3UICFySTy
 BqFMTEC59R7fM/DePLWPleSc4k88jJ07HbgXNc5AyLlGfY3sgExWJiEN4KPGV9d5WB0FV8LxuB
 xoxWdFE7wTngVvwyVq5FvucRfbvhjxkWKOQg9ufHFjxDUaCRtGmmCjBNGJ6u7pFH+NSPdoawmZ
 n5q3ueckyg/2dEwY9ixDWzZR0Dwa58cNmNxB9iSIe38SZR0r1kAi1JIDm4Bv5btNwXiJOobdls
 n1cHPg5y/WTJ7zmj+sky3OMK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Mar 2019 14:58:17 -0700
IronPort-SDR: iJF5s9z2RM1Gs19kaUvUD5unDJN293ZLp/MqfQP3gOIefu9Ty5hAtL7oTZ4jpOqI1rPcrnkscw
 D6Z6Kex/Y8Px1wAl2xc6DRa688BM+FO6ZQL370tlwMjC14HeL8ePhTagAubF2I/GyjgI3EQH0l
 gzpf69KuXQrrgkMu6KhIJobF4JaxTybKdBfK5izQxnQXLqOkP55+CnSv8arb8fxZS42zhY0126
 dUWJLTgESMXUV1AXh3l9AsieAIeuOsEIRE3u+zSkmPqioAiOvU9Jo9znCgZBbpuwpSXr7aEkkT
 VxM=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2019 15:20:40 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [v1 PATCH 1/4] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
Date:   Tue, 19 Mar 2019 15:20:25 -0700
Message-Id: <20190319222028.4293-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OF/DT core has a hook for architecture specific logical cpuid to hartid
mapping. By implementing this, we can pass the logical cpu id to cpu
node parsing functions.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 0c41d07e..94db7266 100644
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

