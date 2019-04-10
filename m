Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09122C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFF120850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mPWF3++I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDJXFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:05:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61696 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfDJXFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554937502; x=1586473502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjopVQqYQkhD6l4s3VEoAfhP+7o2iPgtr6wnHHzUroc=;
  b=mPWF3++ItqgJNt2a/2UMHglzAfQF5ILlMaZ/aQDNix6mZVAydesM0KHN
   uvaJ0duan/uhG7p/5Y9qOJK9jbScJlzDXLHto8oYQL8xq5rxDdEZSje7m
   JH++mXyGknHA026zoWR/PQOdcZU3JNEUrbTPJFDSriM67/EOYEev/wVen
   eobf2PiULOqLkEsrr+xrXx22qTWymvkkpa29Fh2HfFcE3BxJBnq9/ZYem
   jDSCU4eLM6C0RUi4bOsi9Czzl7j5WaX+6wGdncXW/tMrdxIwbN9LZ0EPf
   I7V68CSau2lJwbNzjZh75/S6Tl60LmhR+ShUwSvzN7HIJWx9OK9Z4Rd92
   A==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="110531214"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:05:01 +0800
IronPort-SDR: 27aSVQWSWns360uOjp19tNIcBoZWsevpjFaMYUaNyYdwivWxNW/ksxvQN5zOBRJW6gmeZEZmWV
 1ONeoBYHKyRFn6bWgNUD1o3+wvK1uQtvaQnZtKAe2/ZiQOrerpjSt0bT6po1m+yrmcvKUJe458
 XdlzF0OLfpailwI3cfH3bbAo+3byHlOazqh0hRJ83hTbD/5gHOb7cqb8IFbVoqVFmcjjy13EMR
 /iCX6eJPMB7Ey5GSZ8LFfYb4Z/YxesMpujGYZMtsQt4Dvy4DvxdXZqi4Lkz3nyzLeHyLBCiDcL
 4bNZ7OhfGCJgqsozythpIqrQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:41:53 -0700
IronPort-SDR: 1rhuCQOXGyrTbb0RHFHg7EKFscG147dVhrFBG9rilY0kCpsui/ZWQxzgO8c8Jl6MdofD6mrrax
 f3wOq8hA7zaAnrPLK5D0oLbZM1v7s7twoqcePEr52xfKBKwI/7Naa/k1VoCFmFcv7wHPY5unvF
 lgq/WyLEtGXeGfXr/nSEFr249Fi+cFsIxHgyu6ZEaBMsPH4geSAdaR4xcu1i8k02HUZfPEu6s2
 LpJt5Kw/LGzHseboHMUGGByu6apGavWdMjVAN3qVteTzTf7GxySd4U+YVlbS8ddxCXOWgrHbBr
 p3M=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Apr 2019 16:04:59 -0700
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
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 4/4] RISC-V: Support nr_cpus command line option.
Date:   Wed, 10 Apr 2019 16:04:43 -0700
Message-Id: <20190410230443.15729-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410230443.15729-1-atish.patra@wdc.com>
References: <20190410230443.15729-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If nr_cpus command line option is set, maximum possible cpu should be
set to that value.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smpboot.  |  0
 arch/riscv/kernel/smpboot.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/smpboot.

diff --git a/arch/riscv/kernel/smpboot. b/arch/riscv/kernel/smpboot.
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index a8ad200581aa..7a0b62252524 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -84,11 +84,19 @@ void __init setup_smp(void)
 		}
 
 		cpuid_to_hartid_map(cpuid) = hart;
-		set_cpu_possible(cpuid, true);
 		cpuid++;
 	}
 
 	BUG_ON(!found_boot_cpu);
+
+	if (cpuid > nr_cpu_ids)
+		pr_warn("Total number of cpus [%d] is greater than nr_cpus option value [%d]\n",
+			cpuid, nr_cpu_ids);
+
+	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
+		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID)
+			set_cpu_possible(cpuid, true);
+	}
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-- 
2.21.0

