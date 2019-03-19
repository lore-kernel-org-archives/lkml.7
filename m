Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD12C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA2A2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LqZkWYWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCSWUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6004 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfCSWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553034044; x=1584570044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zb/1pIZ8wgWkzLDrZtCT/oGYWbugSzEwVSqAOP9Qfzs=;
  b=LqZkWYWa/UNa2t6SWW8mbppZTDdZ3L3NtKLGQvZUuc7qnUu53q5gdJto
   saGO2Rk8/POPZfK6EDtshGWCljtwsqZeX2EqgZfUDcZ4rhQ14mR3oqYrv
   eP4hNKz65y0xwhOM/bCYJArFMnuj9f4A8b+XNTA4fC96XUmA3A+s4i7pa
   WHBf7BE+q8H5ZUZjJaQcdVAOhGG5Ag13W7GugKmvnSVyKFtJQQlHENGqX
   9wt5QAcs+SbF+C0M57J8KpPyk7sN3Bflhzxivz0WFINFfoNR85PdVk2K4
   XisooSxMCOuMg6QjPEILeRBsNaTAZKoQ2ukdGfEmbtKkkbl8zqlfQAzoE
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="105523548"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 06:20:43 +0800
IronPort-SDR: DAo8d9ObkIToaa6xdTT6e09Ysxx3uKWyYCMCwoKLmM3Tr4IlCwI/HN4ulgVmmBQKfuUbZr8oIW
 RhUl0PZurQf2vjosKq3lIO1n8E343KCC33pOK/xUuv0w90/UZb23CvrXT7j3v9SAX+OSDLZUmw
 Ogez1qvApxAY2HNk8/wFmHilfWqEiZfcvbq3/TFEBTOreQi0PlX6tlZWWJORmBzGre1HV1403Z
 1Uer76XhKlqJMCpI2hKPhw5A8lm1BgsS//pz6vUpR/UMBeWtH9uzd5YGQgRWxog8zGALukyFpZ
 I3lyRMOikn6PTQ2BRchpnfY4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Mar 2019 14:58:20 -0700
IronPort-SDR: ZqfseJXtlCgxX/y9yOpnz26+OVA7vw79c8S5Wvk4id9ZnGowhbkrLDNUyeARLOrwKE9xABFfUj
 pMybza0z2dYmwZCVImxV21rq0LoVslWT0Y8pmVyJdqXdA4AJTdnsfvirXteY/M7n3gr0dXR+OQ
 MfC6/JToQILOUi/MuYUu6V0sJzeDB/+uRGS0iavAvtCZbp1seqPk9o/iUR/sBO2jkFgHaTmObK
 UBWS13K/ValG5+qOWcR88c6yjcREHCPc7i+nASzfgg0Rqz4zOsTlsGjeFPoAJ4Z6DefdQ4IIvs
 wuw=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2019 15:20:44 -0700
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
Subject: [v1 PATCH 4/4] RISC-V: Support nr_cpus command line option.
Date:   Tue, 19 Mar 2019 15:20:28 -0700
Message-Id: <20190319222028.4293-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319222028.4293-1-atish.patra@wdc.com>
References: <20190319222028.4293-1-atish.patra@wdc.com>
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
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 609475c5..a8fe590c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -86,11 +86,19 @@ void __init setup_smp(void)
 		}
 
 		cpuid_to_hartid_map(cpuid) = hart;
-		set_cpu_possible(cpuid, true);
 		cpuid++;
 	}
 
 	BUG_ON(!found_boot_cpu);
+
+	if (cpuid > nr_cpu_ids)
+		pr_warn("Total number of cpus [%d] are greater than configured via nr_cpus [%d]\n",
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

