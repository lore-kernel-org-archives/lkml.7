Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B91C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C098C20673
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 00:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HaZLz1ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfJAAXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:23:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35659 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfJAAXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 20:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569889426; x=1601425426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j/bjglqWF/oGbWlxsWj+tvbJ6Bessty1AA1xECR1Vog=;
  b=HaZLz1ag6vvs/QqafT253BFnVExYlSPELkZNkuKvQ0M645ZOBO4cSyWZ
   HqXfapkl1IUumuclH/jUibmoFkI/5LokzY1Z/zmeohyH+2zFq0/392WuX
   Y2b0vDhqpw9kzaZtGp/wz9/PnE9uYbqUspkwGUZV9zHIM43d8Bp68TwMt
   XxmFq00UWdkaKMkbDQMNbgRDNIItP3eVx0FLAozmcTDsP/Mop71ORACgo
   HrT6REzmgTsndbB+pRCngQxXEmZRycliekG4EeB6E7Y38CW82mH53A3T1
   VPFKKTP/VNKLXjRjl0uvzNgrFgVi6z24YfbLwIWVpx17XHyCftZXsUWI7
   A==;
IronPort-SDR: kYf20uN/v8FApQddjS4xLV1QwnUF6iympFQG0G/gTacpgDCnJ6N2mehPAA9crrJbE37rGJbqyT
 /mWMgaLPa9Qq+w+iBR0jzJN1170PkLJ0lH67UlrdxmT95OaTIwWbDICqRz5gBvdXgRfj8Whdp0
 j9/XqLPWmNCzVlUgcdXiI2oN3UoENtYMultQ8O9txM5MdZOg6ctSEqgDT7+CbSwVOTG5Eirvp3
 QLfNmyeIP0EWHFjLvLP2GzgNeNP6VSJkFNtW2jrjctt5jIjJT+Ha+7i6aGoPhv+uMax3l2Ap/m
 FcY=
X-IronPort-AV: E=Sophos;i="5.64,569,1559491200"; 
   d="scan'208";a="120256450"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2019 08:23:45 +0800
IronPort-SDR: kO+/oaLgvdvxyHw2ykguk5wmVNR8jXvQ5ih8nPGLQiMs5SkZTOVYIpfvb1HoDrtT+hfn+qIe7G
 uogbOuD5EICPpNh8dk+hTrfHngzJsIS7voG0586ORKs443CRBDzWE1tyLtOvJtp0R3xvHcM7H9
 JGNgIannE8SvD7Pd2CS+ScpRED56mcJRn3jIeHsl9XTrHhlLTYNFjUg1Y6bvvRx0JcaPdhUxPS
 q7AgN0ZqZCyZhvBEvMYa9MoqG2K8WdApTAM64fDZLeLXxKxhfT7IV5vOboCCYZfoKamTTHGQzM
 wbCXlVD17xqV+EVCYLQ4vtT8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 17:19:58 -0700
IronPort-SDR: Enpz6ImGLYlKOaKEwe6Rbmc3lpN5MHdhtg9jzP56tbwwu7o/wCSsI6NznTgoDyXW5JR6DdBbtK
 R6bq130Vc/KfWJvdEGEd98JWn0oidKKoIMOVn5RpLcv9ZqpRTROCFyw6/d81DrnzuP4Dcb9jXB
 IQX8Hhbpk1BM92zQhRP1D9hKEgNxm23tY90YbREGxWOlyORjvfGAdkxrPuqqSXME/PofiaZeK1
 UrcBJkdK+yG9Eb1k1PLq1QGQw8M8SeNs/r9r/dkXETQyYfrcxed4V6oeE2OzbAH9ntc+jHEcV+
 9/4=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Sep 2019 17:23:45 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, hch@infradead.org
Subject: [v6 PATCH] RISC-V: Remove unsupported isa string info print
Date:   Mon, 30 Sep 2019 17:23:18 -0700
Message-Id: <20191001002318.7515-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/cpuinfo should just print all the isa string as an information
instead of determining what is supported or not. ELF hwcap can be
used by the userspace to figure out that.

Simplify the isa string printing by removing the unsupported isa string
print and all related code.

The relevant discussion can be found at
http://lists.infradead.org/pipermail/linux-riscv/2019-September/006702.html

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpu.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 7da3c6a93abd..9486c426af86 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -48,49 +48,22 @@ int riscv_of_processor_hartid(struct device_node *node)
 
 static void print_isa(struct seq_file *f, const char *orig_isa)
 {
-	static const char *ext = "mafdcsu";
-	const char *isa = orig_isa;
-	const char *e;
-
 	/*
 	 * Linux doesn't support rv32e or rv128i, and we only support booting
 	 * kernels on harts with the same ISA that the kernel is compiled for.
 	 */
 #if defined(CONFIG_32BIT)
-	if (strncmp(isa, "rv32i", 5) != 0)
+	if (strncmp(orig_isa, "rv32i", 5) != 0)
 		return;
 #elif defined(CONFIG_64BIT)
-	if (strncmp(isa, "rv64i", 5) != 0)
+	if (strncmp(orig_isa, "rv64i", 5) != 0)
 		return;
 #endif
 
-	/* Print the base ISA, as we already know it's legal. */
+	/* Print the entire ISA as it is */
 	seq_puts(f, "isa\t\t: ");
-	seq_write(f, isa, 5);
-	isa += 5;
-
-	/*
-	 * Check the rest of the ISA string for valid extensions, printing those
-	 * we find.  RISC-V ISA strings define an order, so we only print the
-	 * extension bits when they're in order. Hide the supervisor (S)
-	 * extension from userspace as it's not accessible from there.
-	 */
-	for (e = ext; *e != '\0'; ++e) {
-		if (isa[0] == e[0]) {
-			if (isa[0] != 's')
-				seq_write(f, isa, 1);
-
-			isa++;
-		}
-	}
+	seq_write(f, orig_isa, strlen(orig_isa));
 	seq_puts(f, "\n");
-
-	/*
-	 * If we were given an unsupported ISA in the device tree then print
-	 * a bit of info describing what went wrong.
-	 */
-	if (isa[0] != '\0')
-		pr_info("unsupported ISA \"%s\" in device tree\n", orig_isa);
 }
 
 static void print_mmu(struct seq_file *f, const char *mmu_type)
-- 
2.21.0

