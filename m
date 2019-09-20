Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A606DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C067208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408281AbfITGIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:08:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2743 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408261AbfITGIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:08:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 890BEAEF140909DD15E4;
        Fri, 20 Sep 2019 14:08:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:45 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 02/32] arm64: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:14 +0800
Message-ID: <20190920062544.180997-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/kernel/hw_breakpoint.c |  8 ++++----
 arch/arm64/kernel/smp.c           | 11 +++++------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 38ee1514cd9c..0b727edf4104 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -51,7 +51,7 @@ int hw_breakpoint_slots(int type)
 	case TYPE_DATA:
 		return get_num_wrps();
 	default:
-		pr_warning("unknown slot type: %d\n", type);
+		pr_warn("unknown slot type: %d\n", type);
 		return 0;
 	}
 }
@@ -112,7 +112,7 @@ static u64 read_wb_reg(int reg, int n)
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, val);
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, val);
 	default:
-		pr_warning("attempt to read from unknown breakpoint register %d\n", n);
+		pr_warn("attempt to read from unknown breakpoint register %d\n", n);
 	}
 
 	return val;
@@ -127,7 +127,7 @@ static void write_wb_reg(int reg, int n, u64 val)
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, val);
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, val);
 	default:
-		pr_warning("attempt to write to unknown breakpoint register %d\n", n);
+		pr_warn("attempt to write to unknown breakpoint register %d\n", n);
 	}
 	isb();
 }
@@ -145,7 +145,7 @@ static enum dbg_active_el debug_exception_level(int privilege)
 	case AARCH64_BREAKPOINT_EL1:
 		return DBG_ACTIVE_EL1;
 	default:
-		pr_warning("invalid breakpoint privilege level %d\n", privilege);
+		pr_warn("invalid breakpoint privilege level %d\n", privilege);
 		return -EINVAL;
 	}
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dc9fe879c279..ab149bcc3dc7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -345,8 +345,7 @@ void __cpu_die(unsigned int cpu)
 	 */
 	err = op_cpu_kill(cpu);
 	if (err)
-		pr_warn("CPU%d may not have shut down cleanly: %d\n",
-			cpu, err);
+		pr_warn("CPU%d may not have shut down cleanly: %d\n", cpu, err);
 }
 
 /*
@@ -976,8 +975,8 @@ void smp_send_stop(void)
 		udelay(1);
 
 	if (num_online_cpus() > 1)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
-			   cpumask_pr_args(cpu_online_mask));
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
+			cpumask_pr_args(cpu_online_mask));
 
 	sdei_mask_local_cpu();
 }
@@ -1017,8 +1016,8 @@ void crash_smp_send_stop(void)
 		udelay(1);
 
 	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
-			   cpumask_pr_args(&mask));
+		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
+			cpumask_pr_args(&mask));
 
 	sdei_mask_local_cpu();
 }
-- 
2.20.1

