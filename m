Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3865BC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2DF208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B0mJ/UHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfJDBUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33208 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbfJDBUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570152003; x=1601688003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lvQhkdg9mYtc/RKe847gIG8//uYicCwg807haVRxHDE=;
  b=B0mJ/UHZKIv3aoW4hIE2lhxjBveSMVZvhWus3sxH2LhWCHAURlmfVdGD
   Y45c1ZN2tNBLXPeiUHDoUO2yHXayod/o3wd+INSGUpZZRDz1KROV1YL/1
   tDHRus19xoCjlK6l0JV3frmTvciOvByD/QV6Y6zplBerV9trVr+w37aMo
   QCKzTiwIx0XtPCd38KvZJeaOQwPXI9RCc+aMzcM3dHRBn/HLL2Xr/W6VN
   Hj6qr6g3tj4Jzdc6DM07QZBybnhDhKzPYe2p1bqgqH+Ty6+8hINumttzn
   BKPkYIm3/s+nRixqCNioUOMjdcz+hCrA66sIwB7sboCzhSWCJ0PaLoHMX
   Q==;
IronPort-SDR: cafncHLmRgpJ9NW6BDrsAUzAthIzrL4jzxctKQZTtPxjWnYnVyUIqd0YVDibhtpDanygwf7oCP
 aLiPY/or2FjTg7qAFE/OaMT5C3NXHv3oySSjhJ9lNspVcjYxqrWQ8Pttcrkqp86KAPlsayDg/d
 qnI8SESsD3jEFaweqfhBBQ1XPcVIdbLAe6iLSV8QXMT9k4QYZet8OneOzCXRwr47Y4kB0ZwIbY
 nH/xeWbjcc8nQ+kVn+xvhDs/uWTelKslHn2b+pXFFySbozrujhOorbhHvvuO/cdKw6BFB136vl
 yGc=
X-IronPort-AV: E=Sophos;i="5.67,254,1566835200"; 
   d="scan'208";a="119765640"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2019 09:20:02 +0800
IronPort-SDR: BRQGfsMNCWVM9RCkiB6lyp90itPcttBRJgWs61J7RlS6VSFggJpE/rSHC2Rzimpi/wCZyZpU+7
 YnS5uQVehJBwneTTuqsRUGeM9AiBn2PMq54XJ3ZjhMilr7m6yDo2T05XQde8ph1uOqzUJwh+RN
 HAYcaERlsEnN3idt/HJeYa17ILnhcm7eJg50+hGeGN9etqDtHPXi8k6zx1EKPUo/wjCN2Ay/re
 Hxi3GFy0qtBQ+AML4xQqt9DWmgOWhJhOH6iguTV+SuYe/ztkJ2DrXcooateYHhhDCV67iWWPL6
 f+dmbOFzWljVay9L0d5Flx7l
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 18:16:11 -0700
IronPort-SDR: qKeZmEpKTEzSQldkunuCDSObARUFEHemYXMJy0fLs8vX3FTw8wVQI9evPWDF+kEbIkPFPamW/U
 //+xq2haZX6adORa+igaX42fIvmmBOu79Mj3i2nAZrAYMvkuE3VFBoRbAHwV58FzvEXmWf+JIt
 fb94+Pq0OFFedR10EnzbhjzwcPtGu61jyeQdMJ6AK5qOXaqcEjPLZyAJSWjC1RyXkXIjMLJsbx
 mBy84UX7KzP0GpO5Cb4SNIlZRpRN7w7Q46xegvYi9NaPV736UHyL8f4dJnQaq6NYVo5fTvHcKA
 G+I=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Oct 2019 18:20:02 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <aghiti@upmem.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v1 PATCH  1/2] RISC-V: Remove unsupported isa string info print
Date:   Thu,  3 Oct 2019 18:19:59 -0700
Message-Id: <20191004012000.2661-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004012000.2661-1-atish.patra@wdc.com>
References: <20191004012000.2661-1-atish.patra@wdc.com>
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

