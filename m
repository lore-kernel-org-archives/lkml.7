Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE41AC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB912218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B1Js9JjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbfJIWBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:01:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58909 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfJIWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570658490; x=1602194490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lbd+AIGQrRoThAxs3oEN+bBjg5z+KPSZ65JKtN5StOg=;
  b=B1Js9JjIXX3891OnbKoTNZDxu/59ux7Yqm5nL0O2OcF7Z7bYdVtQQYig
   F1OPwWWLHOwUn/629HZ/DJxUwO02TSVRKkDiuo1AnJIbLw7MmI94tHipp
   3iZUOdwnFLCa9N4AcXcaT8btVSzIpOQt2H8dEBl774ZQktlqEkpYZJmSR
   nTsAjYqXSUXMZmoqMI+I4XshsQo4Nn03IjYSer96tczQay1/ndH50R4ln
   TMiSOmSAIjCUy8QF1uogKQUIMChr0OZz09VdeRYafYW7qsL3+Dne4QoRF
   5nzCORM3RA8SZ+0pKQAWN0jWG1SRbh4HwsoStCD0bEtsgA+ajZKSnhY2u
   g==;
IronPort-SDR: +3fmK3aVMPG6Hkp4GGHLodzHTmV2nsapiMR/xG5BzrPre+CTtqn48srXc4n/rhhvJkBUL1X8PM
 ALF02qUMBco7yIpC3K4dUdgPeqJPbuajvj2+A9wDhDmMLQhgmdPEeOrF1vFShm9pVEqDaFLeku
 +6IlF6/73SGLRn6MeHg7I6H5/tRMbqQopGGxBPLclYH35Lv6yBK9TL6x8IMLzKt9fIA8k2Be0u
 rllORs73tcl08oXEarM9uHwpoCp+0hUmUJqdOixh+k5KeI/B+nkdAdhZ8Z/7CLFCf8KYHLuMg4
 tlE=
X-IronPort-AV: E=Sophos;i="5.67,277,1566835200"; 
   d="scan'208";a="121776284"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2019 06:01:30 +0800
IronPort-SDR: AohxBxgZJlpUlwMwToqjXjaIDz/wQvJY5MGuVqa7FxDdUSfqwH5S7JHPjpRVnGxy1weiChmH9T
 rDv20BVWFpXtBGJ+JpkeULQPkFNcb3DqreCU5kWy/Qz+LDI209t2Xgxq2ZWD2H8NQFANWAH4E9
 cACuiJriABiFkf46RIvW/cpCYmzZ6hicvNgHxtHejUzq/IZJ2NuQpqCj2kDCcVkQAnxbDyRGNO
 deHc0YqeN3HbDhHTVfZV9Zgs+u2F++ojck83JI/JAbQEQxf/i8GRr+fwlBg1LKt6/vTuv5QIzK
 kOpGekbGjjgowoqH7/VRTsI7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 14:57:28 -0700
IronPort-SDR: OSfHRalZnckQ+CMwFJuI9c2cHFJ5980REgWsO9HlLdWYOA9e/Xnja3lHpA/bBzYMh3y+14r+vX
 jFPL34GtuhDEtYwD4Z1KDUgRqboAKwulDmx7HlJm48/04ZQ7rVb3/T84nTshQt9MrX/KCCgZXQ
 q//5RaXrtYFF9k3Zm4rRjtw3axETY+J2XeAph1wjymWL9mQjmWEJi8crXOVQz6s1S0cNMqZWA2
 ePWMktMmAyTO2iv41PIvKd5EL3O7Mhu3dqC2bWcQkMg3bsRWn2D7H2c8Ui/iq1IzhJ9n8acYgs
 xh4=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Oct 2019 15:01:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2  1/2] RISC-V: Remove unsupported isa string info print
Date:   Wed,  9 Oct 2019 15:00:57 -0700
Message-Id: <20191009220058.24964-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009220058.24964-1-atish.patra@wdc.com>
References: <20191009220058.24964-1-atish.patra@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/cpu.c | 45 +++--------------------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 7da3c6a93abd..40a3c442ac5f 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -46,51 +46,12 @@ int riscv_of_processor_hartid(struct device_node *node)
 
 #ifdef CONFIG_PROC_FS
 
-static void print_isa(struct seq_file *f, const char *orig_isa)
+static void print_isa(struct seq_file *f, const char *isa)
 {
-	static const char *ext = "mafdcsu";
-	const char *isa = orig_isa;
-	const char *e;
-
-	/*
-	 * Linux doesn't support rv32e or rv128i, and we only support booting
-	 * kernels on harts with the same ISA that the kernel is compiled for.
-	 */
-#if defined(CONFIG_32BIT)
-	if (strncmp(isa, "rv32i", 5) != 0)
-		return;
-#elif defined(CONFIG_64BIT)
-	if (strncmp(isa, "rv64i", 5) != 0)
-		return;
-#endif
-
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
+	seq_write(f, isa, strlen(isa));
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

