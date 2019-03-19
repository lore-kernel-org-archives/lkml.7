Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6EBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1A2217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nE2ueLYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCSWUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6016 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfCSWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553034043; x=1584570043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+ofvLBu3teqXjyuNvizoBfdnh+2OK/Hq+Is5NyQizk=;
  b=nE2ueLYUpkEZFGFCAo1XgT5WbMLAq3JK3eFf+mkdLvPxyH/EJBh0CODZ
   mL4MkbCYD+4TDmCPzAl4R1l9USMjw4yDpdTUaB92nFnNaahc5OLgSCcoD
   7BTyruU6S6gn5taN1WEXe23swArfiqhZwd7atAELU1NOniCO8K1McAqM+
   4wOlS9heNvTQaHVk0JHO8sapfVaNf7p3I3Qts+oGF1PIqi+SFB/jYxbBb
   MSfViUD1kQWF6hy/Ugj8POO1W/mkxM0k7qzzFjFiaY31X7KVBeT6RK76K
   i0DmGzG6IXDma552mD6N56qIeYbK4p6SneHKkpDhfgEnMIGpUcb44KF6/
   w==;
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="105523542"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 06:20:43 +0800
IronPort-SDR: lxPgpNvV+B3gjLQsp6+FmFCUB7cDimAld31ye6EJO3qd5JmCh76p6PBCuO7bZrHllj5w67OyNr
 OSNVWDZ4WE/gkNRmx2Lfdn+M6+15HymJhnG+fUIBpxvrXDNfFQf5bNL1WG2BMySIJ9fssqXHBG
 ptlAgcswllqzQTb39KaixH3O33FrxV0nH00Z8k5XQaaOJsp1D5TfnMngu26rwZBewxncgbYjNO
 dXVrfvCGKvZ++RhMIeOolRURo3piKcSZ4YajwJif/DcpiAqM59Rq3D8hVhtmBxQFLlm5te9334
 N5VCY1/pv42cDx2gJMVDuo48
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Mar 2019 14:58:20 -0700
IronPort-SDR: VcKq2dqPDs/FdGnf+fVnkyRVToeqlLSVJ7/l5js6EPxjNkDWo3KcMkYjyoDiiKm3LHkTogiUMY
 hgdWkDLRevhuHVM/JAMf7UpjznW7YtgYFW+Rctq/nGIdMxFXJbsqJKbYvqAicMDbZeCE2WGyZZ
 pSGv3d3vuGALE0Q1j6Ka21To44+GFz8Y9qb/jRlHbjyNvMhxyNpAmVagm7pHNemcnQFehPk5an
 z/PG4qc1fPR6YWIA8dgIxTHiHQ1YCYdSuPqP2bi+OKDkN4mXXP7mvJV9dJHuHoMUnxj42IyT5s
 EgY=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2019 15:20:43 -0700
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
Subject: [v1 PATCH 3/4] RISC-V: Implement nosmp commandline option.
Date:   Tue, 19 Mar 2019 15:20:27 -0700
Message-Id: <20190319222028.4293-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319222028.4293-1-atish.patra@wdc.com>
References: <20190319222028.4293-1-atish.patra@wdc.com>
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
index df353199..609475c5 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -49,6 +49,17 @@ void __init smp_prepare_boot_cpu(void)
 
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
@@ -76,7 +87,6 @@ void __init setup_smp(void)
 
 		cpuid_to_hartid_map(cpuid) = hart;
 		set_cpu_possible(cpuid, true);
-		set_cpu_present(cpuid, true);
 		cpuid++;
 	}
 
-- 
2.21.0

