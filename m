Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C01CC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE99B218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qoYes3MD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfDXACf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:02:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53963 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDXACY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556064144; x=1587600144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0mjdmCfdkrn3w/zT4aJMYOdZrUml3L58iZRwDuQ/Lw=;
  b=qoYes3MDCcBL86j+090gF/Dukiu7wvAH3tvcq4jYAtbYUoFSRMM5pv76
   MJah2xrkFREb+lKMwiikZjsOrsMt4EAH1JENNLtPPenlRhAzCYjr83M/X
   DoTIFyxVcgdvHpeyChD9dCqNVYbzGJKgdLsLMm2P2JcmolZJ4u0igFUI0
   eHZNkaw9T74hL4N+dox7BJb2ENy0Ys+iCGf4/+twpXxPggq/UDbHKF8oe
   SLQrO5uz2G5yPdW7RW1Di15eyg/6ADlzgMjTi67+IdpgnvdOQI1sdouBG
   uWjb4Zczej7zHRoMXN1xVdGygtoaxfxbaGreXLd6j9s2+HCIU6bEuhTu7
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,387,1549900800"; 
   d="scan'208";a="106649535"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2019 08:02:24 +0800
IronPort-SDR: 4aZ5Fwwe9CEy90fFpkWNfR/gq/Y7iQUdOnzKK1vVw90UUkcsfby2aE0PxOCBQy+IMAz8WLdECA
 LNVUDskRSCXwmhT2wUY7YZr9O04wGIEXwrz3qoWa2SUP1b0V/hCoyJd6jkkSwAQAtjKeaOLEO+
 5M/ESp7th6SxHn/TJ6Eid09Fe6IBcUvkJx88aPWLH31SnUSBxe3Bs3NXMSxx4i0dzbfIvkVOm+
 oaNqeoXO2h/BK3A+m3GflMlnIZFNvXihjTXXqK8he7dGf3uLuhaN1C5pPIou9cvlTDYOcBExYW
 P2BO56xgr4vq4W8AOV8uZV0p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 Apr 2019 16:41:04 -0700
IronPort-SDR: vLxFqYKRUEO2Hyzjha/t/tSa7wtu+8Bjtkknn7qkd7Pfg7hK26rXSp/pUuMj332f7QCLldAZCL
 bMZ+M8zqf/osPxKB2CaFEk+UaU5/QIBrQet2r8+IxGXh4f4xRcfJ1EOfwo+Vn1u7/tYcnKK/PH
 OQ9fU/MA3ldp175wqdWGT3ZxJFPMrCo+1loyho64iijURyU37AcvZnG3DzK3LBuswcgQnPfvp2
 cY6d17rnQqtblP0Od3oiZRatNJynbfa9EG/sIg3MzedQxPgvtiFmOJA3rb2JpTD9yg0wylIJ2P
 yd0=
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
Subject: [PATCH v3 3/3] RISC-V: Support nr_cpus command line option.
Date:   Tue, 23 Apr 2019 17:02:27 -0700
Message-Id: <20190424000227.3085-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424000227.3085-1-atish.patra@wdc.com>
References: <20190424000227.3085-1-atish.patra@wdc.com>
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
 arch/riscv/kernel/smpboot.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/smpboot.

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

