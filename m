Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9F0C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CCE218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h58Odmd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfDXAC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:02:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53970 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfDXACY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556064144; x=1587600144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2/5jwhYTGQ1JCFD91I9OK6vJ4c5B03XruX+Wm8H9FA=;
  b=h58Odmd8t8oUq5asA9yKnYIEi8y9CYoAMl3f6ZiKhP9xqEexCV+OUO9M
   FpqC2X1Ad4vV1nNKsloC0yWGIe6zFbc072+T/aA4jpxoZZebChMxyluSQ
   L26yRTlMIX7xxvqY4rAjFQ76oyxzp8pjnvcw2m0Zi77DoVbkPx2NUTucp
   c7IS8RkFKO5oZxkLbGEH5vsMaG1/Z06k/AZ7f4BBTtBriniTIJZ4UP/PL
   O/YCSxG5Jdco/0EsoRYd+zIrT29wTK8jGlWDctzm6KAxGBLNmtbc9thXC
   CR+TBV/1fp1m9v/VMWjqP3bBJjeikHDt6ZRAsJ2Vito1d712JXXJjFazu
   g==;
X-IronPort-AV: E=Sophos;i="5.60,387,1549900800"; 
   d="scan'208";a="106649532"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2019 08:02:23 +0800
IronPort-SDR: JMMEMpW4f7Rezcvekk3nqIoG2R3h+0vMWSWdfIhV10zDJI4vA3qlV4De6bVeTOILrcL0F787hs
 FbeTXSxU1FBYwt0Cmda5tH0clljNF+k7nmcAyCNo1k6L0DuVq8Wopsfmc+lCvKPjEoCMwKNl97
 jnuYV3jTSqSuLCkPJ+jOTimxodj2jaI6pFdR1NjxaFYhlVKbAkw1GavWL7w22PapDJuMIRUd7z
 5Lfuk55BIWs/WmZaGaUkVJp4czp5HPfLir+E3E6qw+B0/dH4gCiactzeRDm43bWxjyFFFP1qJ4
 rTQLy2XRCC0gbt3Mbj2YR/tV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 23 Apr 2019 16:41:04 -0700
IronPort-SDR: NOADQjAz6eLB2ulCCRn0+vCTxLNg3viC5jnh/ICSir8Y7r7k2imFel2bN3hhmoRp27+eU3dYJf
 dczho/LE9GN07SkGgbRHzTsVH8kpxmDjIc59M4xPaySkAJz0YlHVzrkM+bNB9ZrRyHPU+jmjOY
 48qdQD3mtEx/LVDzKuxulu/oo9wUD1rI24jeT5GHLO4zUussvi67gVyUoIzqdIfQB7D1Ppmd2W
 UHd+PMB8bnry9ucwR4iUGlShBY87JUyTKqpTp1EtRzNQmrgDp17hFl1oQG0sd0iKfwEOW01eqC
 YHE=
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
Subject: [PATCH v3 2/3] RISC-V: Implement nosmp commandline option.
Date:   Tue, 23 Apr 2019 17:02:26 -0700
Message-Id: <20190424000227.3085-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424000227.3085-1-atish.patra@wdc.com>
References: <20190424000227.3085-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nosmp command line option sets max_cpus to zero. No secondary harts
will boot if this is enabled. But present cpu mask will still point to
all possible masks.

Fix present cpu mask for nosmp usecase.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smpboot.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index eb533b5c2c8c..a8ad200581aa 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -47,6 +47,17 @@ void __init smp_prepare_boot_cpu(void)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	int cpuid;
+
+	/* This covers non-smp usecase mandated by "nosmp" option */
+	if (max_cpus == 0)
+		return;
+
+	for_each_possible_cpu(cpuid) {
+		if (cpuid == smp_processor_id())
+			continue;
+		set_cpu_present(cpuid, true);
+	}
 }
 
 void __init setup_smp(void)
@@ -74,7 +85,6 @@ void __init setup_smp(void)
 
 		cpuid_to_hartid_map(cpuid) = hart;
 		set_cpu_possible(cpuid, true);
-		set_cpu_present(cpuid, true);
 		cpuid++;
 	}
 
-- 
2.21.0

