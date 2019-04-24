Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106FFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D0720811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kueSs2qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfDXVsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:48:17 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15282 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfDXVsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556142495; x=1587678495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HLJmdPo2DIDSxK8iquvXyeVmtyscqRTd/8goqoSULLM=;
  b=kueSs2qPbwaUOXHeQHa9N0O/HcNYoxYYwGBYKvgkU0lVfFp/0J442OWt
   806wWTI2ZsqK3PTbBRenq1eBTBHqifh1HvBAe7H/oDHZPMGNyacr3ALX4
   rTMSNAJQ2W7mRx1mRZ/TW75Sf90S/EYR8d+ksnKMJeGKDiqS2fnboWdko
   /AmNEylHbkbqDYRkCpZ4SCWN0+OL7a256P3KMrpOSdYl44mdBgJyrUk88
   LcPs3twy+DgdkXp02hSjaY1SM/sco06zofqsSn9cfBvit3KXrPGDKQ+cH
   KdIttJQVVzCmnkKYdBrq1bDUrzKPLldGHpBtfrY8SKwwTpDz0F9LSNXqG
   g==;
X-IronPort-AV: E=Sophos;i="5.60,391,1549900800"; 
   d="scan'208";a="106739588"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2019 05:48:15 +0800
IronPort-SDR: 7jX78I1sE7zi9L3H5svR0ptkTqV0byMdJ4PM3h3nqOB9KPA+CG3XFXwaYGnyCfg4ExKW3Asc4j
 giLlh6DgkX+2PiI6+Tr91Hs6uuTlxXUMdZn+2ePW3i+NzCh3cOf84xFyYDIUe/5QVpxa2B3XAG
 dk6fSSRNIyejd4rwSen0abo1vjPzb0Lc+awLdSnHmVNdRODZ8kpAS08c8uMlGf/Cpm6YgW3j9q
 zpxgPAFc8ITMi/jemOG6rL+zr93Il3KJn0VpItH6feWn7uVrufIc9kvPhnhe/wCS1AGbLb/BuP
 w3L+/QOo6+VbswW9TAhX/Tmy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Apr 2019 14:26:54 -0700
IronPort-SDR: jlBo3KgjjCtfbZ0C2//CHKveriNkLa5ePBIwBiiz2JWS4EEMAwAa6wBKMMCcn5W3PQiQnO0oug
 qmSDOSi3AE1owkEmlOwzrBqH9elQKwPCqBhB3pjdxc8htom8fSSvoo3fNHZyzZ1GirqPmjBSul
 QeFlIQ2sZFSSbZ71SvqCn/m64Z4C39umiG7jv4VwJNWv4mhk3K+I8rBp7cf2eTnkhMuGiJHt07
 dsiJNgj+HO2VeYO677yy/xVmHT/gmMZFsZ6Q25AmJ3uRbeA4BFKaYBuNH8ryQxBtX7dwVToil2
 4WQ=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2019 14:48:14 -0700
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
Subject: [PATCH 2/4] RISC-V: Implement nosmp commandline option.
Date:   Wed, 24 Apr 2019 14:47:59 -0700
Message-Id: <20190424214801.18880-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424214801.18880-1-atish.patra@wdc.com>
References: <20190424214801.18880-1-atish.patra@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

