Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F2AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0266921900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aaFpN9yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbfDXVsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:48:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15282 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbfDXVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556142496; x=1587678496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fCFVaYWBA6mxTZYwLA4+2kqo2897IxJIIto5p08bMM=;
  b=aaFpN9yta2IA3hAcnAcT2pRPQox8ckV354X+S5s0jXVi+x7YEQbjZiRg
   mJkAbkji+pIBXgVUkxE81aGHhMF9qfYQ8Pn50XZOQBPLwDjzea8gqsIlG
   jFNwrnpOL2trXIM3Dn32/m/oA2mZdBOGQULBmU23ZV4YrhFKrtkJDHWH8
   qZ7caN6q81+uZjBPjV2PiUEcSYpk92TQlJG/W5+/6921FsIo0jNl/OdJD
   SnVqQ6a+zXAViwdT9Eu4kqsd7qG6HMMejj98/p6p1Q9hSg4Wh+BPshVEj
   7zJftVPWCE0P4dya1nYO3vMJEu8jns2tE54wAU/EItAcZbdhUPoVB17Ta
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,391,1549900800"; 
   d="scan'208";a="106739590"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 05:48:16 +0800
IronPort-SDR: 2qZtbfEo+heDcowHj5aAVFUPY28iz4NoCOB5tveK4QCUTwm+66gcA2QNkTIzHuC9uNesNb0YSE
 /jfH/VGvRTpAf1gSQlgaNybDtEncsHFbW9S1jnYeU/vA5yKc8ctODzDlefXiqqe1Ji9FtA9Yy2
 z69SNx9zgZnaP7l9uJsiCSZBPcqEPEyI62W2FAWMfCGIZf+tG/NqpnFwAJT2ZbIW1Rv2Rv+6zk
 Mh/dF3L4QVc3CbnEviJBfvZhb/8mBgEX+G/SXhpxuwKh6nbjciceUVFxJjz788kiE9Ori8ZsPA
 fXgJ2fS02Wy6kLjiudTH2YQ5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Apr 2019 14:26:55 -0700
IronPort-SDR: 1YarVtGkK4lQ7rq37ypwtAajEaQ363xFfuvu4paXwIQHsqZg8cDFm7MI28OzpMvaLF89rTThKU
 4u/I//deqUBS29OkAuke6diSTtNn9/FNOfEY7lGrtUwVW82L0Yr2iY/JAFWPGLGMvbrI8De3X2
 MC9SMOSCDpBRKmphMsSRFOakcI/QcQo7YLPf/EFdbF7jAoGIjMvIdVubAoWigeODdjFc/VZR1J
 bfLbK8WWyccJVyLTiAVVJeI3Hc1Z2apQiTT7vnA+KkzlUypEhOPb8GfSCaaP8HVuheejwPhzXo
 pLU=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2019 14:48:16 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 3/4] RISC-V: Support nr_cpus command line option.
Date:   Wed, 24 Apr 2019 14:48:00 -0700
Message-Id: <20190424214801.18880-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424214801.18880-1-atish.patra@wdc.com>
References: <20190424214801.18880-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If nr_cpus command line option is set, maximum possible cpu should be
set to that value.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

