Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A84DC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3162230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UVUMYESr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfKRW5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:57:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53677 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfKRW5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574117827; x=1605653827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZ2JqN/3j29BS4ImRKlwmi0ywl5knXuSWD10el98EP0=;
  b=UVUMYESrEprexnq+GSR2CEiIJLOhEpg8Ts97Mjyj1A69cfnmE5cp6dKX
   zLT9kjmAGh8pEyi1/fJjmuiW+wwvYLxvpp6zd7l2wngPgIE83Su5M+yKt
   UIBicZSqakkjA84L1H1dHsFrj/Fhxc9ds+rlqU2Upq7kRES7W/hArxfd0
   fEKGZHfRrr3Qela8ycypZliVmo7JCEK4fcUJtMTCGJ5szfqPYD9XahvSw
   XzWcqjRgQG9pHcXx0P3WmzFX7+fuR2zLy7RAXecS4mgqyWUxtPPznygXS
   rdEvlS2sWaETWNt/szDlprkUFuiIgEbXoQOeULY4sQPyJ/TzmSiXYTgnP
   A==;
IronPort-SDR: sQ4MFzudiFGztUrCHxwLrtWGmhD07YG44GZs4ejgNxmtOF2YJGKvE10TMMC1qrxau3DSr5uAjn
 XEtBgj3QobddmQZ15eUuOETOlETg/6UCsPGtdmkWNrbDOeFUR3vSKbJhNcZDDW99AuxpNj1bun
 zaRAPadME/tgkCAl/KWQdSmmpK9DyKujLFtctP8760R5WqzoVPBuMLB8by/aWHOpPodIssSigx
 kKHdDdKdk3aVPyJSrBX78hsZaOJfQzQXglBUcKLrUFrLvP5W/2Px7mH3tPQWx16OmviciCRi8K
 jKo=
X-IronPort-AV: E=Sophos;i="5.68,321,1569254400"; 
   d="scan'208";a="230735389"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2019 06:57:06 +0800
IronPort-SDR: xVSUesAbIN0naH2swjTZtNdGkse3TU5YmI/JvA1S6OWPwh9aCD1EIZvQtuWlVbqv9c2ghM4cjI
 fsD5oJT7F5X4qN0QV/FeTg1e68e9SfWUQ4bLghFFm8d8m0sp5g6No0kl6p9pBQwlnnX4z1DVCg
 qEKf9Ypyv2JohZi63NSfb+XsapY4mj60z4XJHhIfWwhj3Pn6M4RLCxONolFbGSHNL/45NTY7wi
 ZpgYZdv2IQk/98+a3ZVtQKTJQTjOqqhT+ere+FA3fUKjxWLxf5LDwB0GlQH4NJa0cNCzFn6Qpn
 jXfWNhE8fJdwVm5RVFAK1WLq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 14:52:19 -0800
IronPort-SDR: ORHKxrkZNmOAAk3pK3OLRdWFogOk5FChZF2KqD1suGAmeo6KkAAxmcain2T9LpS+qzh7Lt3Bww
 wblaxNVjpdEYDaZpWBLXidK6W8o+GdlbF3xXCmZ3AJw4ONHgBurYnUQwQszRVzaRSNokzwadtg
 RNTKaB4zSqL57k9FgYVtbieyr0ixbcjv0hRuEvrTfR+YmfHJZI9YVeOFvAAu9Qh3KW5RQM959K
 sWu+n9H6Cim/nmmvCi4CsABsUsIe0faHBK0PFz/6/1Kepjx7wjU/tU2EySX/uHNDK8P82N7T+N
 IvY=
WDCIronportException: Internal
Received: from yoda.sdcorp.global.sandisk.com (HELO yoda.int.fusionio.com) ([10.196.158.237])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2019 14:57:07 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Gary Guo <gary@garyguo.net>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Behrens <behrensj@mit.edu>
Subject: [PATCH v3 3/4] RISC-V: Introduce a new config for SBI v0.1
Date:   Mon, 18 Nov 2019 14:45:38 -0800
Message-Id: <20191118224539.2171-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118224539.2171-1-atish.patra@wdc.com>
References: <20191118224539.2171-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have SBI v0.2 which is more scalable and extendable to handle
future needs for RISC-V supervisor interfaces.

Introduce a new config and move all SBI v0.1 code under that config.
This allows to implement the new replacement SBI extensions cleanly
and remove v0.1 extensions easily in future. Currently, the config
is enabled by default. Once all M-mode software with v0.1 are no
longer in use, this config option and all relevant code can be easily
removed.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig      |  6 ++++
 arch/riscv/kernel/sbi.c | 69 +++++++++++++++++++++++++++++------------
 2 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8eebbc8860bb..4881b87d0d14 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -272,6 +272,12 @@ menu "Kernel features"
 
 source "kernel/Kconfig.hz"
 
+config RISCV_SBI_V01
+	bool "SBI v0.1 support"
+	default y
+	help
+	  This config allows kernel to use SBI v0.1 APIs. This will be
+	  deprecated in future once legacy M-mode software are no longer in use.
 endmenu
 
 menu "Boot options"
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1cee3ef009bb..6c864fd7fb95 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -52,6 +52,7 @@ int sbi_err_map_linux_errno(int err)
 	};
 }
 
+#ifdef CONFIG_RISCV_SBI_V01
 /**
  * sbi_console_putchar() - Writes given character to the console device.
  * @ch: The data to be written to the console.
@@ -78,39 +79,47 @@ int sbi_console_getchar(void)
 }
 
 /**
- * sbi_set_timer() - Program the timer for next timer event.
- * @stime_value: The value after which next timer event should fire.
+ * sbi_shutdown() - Remove all the harts from executing supervisor code.
  *
  * Return: None
  */
-void sbi_set_timer(uint64_t stime_value)
+void sbi_shutdown(void)
 {
-#if __riscv_xlen == 32
-	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
-			  stime_value >> 32, 0, 0, 0, 0);
-#else
-	sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
-#endif
+	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
 }
 
 /**
- * sbi_shutdown() - Remove all the harts from executing supervisor code.
+ * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
  *
  * Return: None
  */
-void sbi_shutdown(void)
+void sbi_clear_ipi(void)
 {
-	sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
+	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
 }
 
+#endif
+
 /**
- * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
+ * sbi_set_timer() - Program the timer for next timer event.
+ * @stime_value: The value after which next timer event should fire.
  *
  * Return: None
  */
-void sbi_clear_ipi(void)
+void sbi_set_timer(uint64_t stime_value)
 {
-	sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
+#ifdef CONFIG_RISCV_SBI_V01
+	if (sbi_spec_is_0_1()) {
+#if __riscv_xlen == 32
+		sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
+			  stime_value >> 32, 0, 0, 0, 0);
+#else
+		sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
+#endif
+		return;
+	}
+#endif
+
 }
 
 /**
@@ -121,8 +130,13 @@ void sbi_clear_ipi(void)
  */
 void sbi_send_ipi(const unsigned long *hart_mask)
 {
-	sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
+#ifdef CONFIG_RISCV_SBI_V01
+	if (sbi_spec_is_0_1()) {
+		sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
 			0, 0, 0, 0, 0);
+		return;
+	}
+#endif
 }
 
 /**
@@ -133,8 +147,13 @@ void sbi_send_ipi(const unsigned long *hart_mask)
  */
 void sbi_remote_fence_i(const unsigned long *hart_mask)
 {
-	sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0, (unsigned long)hart_mask,
-			0, 0, 0, 0, 0);
+#ifdef CONFIG_RISCV_SBI_V01
+	if (sbi_spec_is_0_1()) {
+		sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0,
+			 (unsigned long)hart_mask, 0, 0, 0, 0, 0);
+		return;
+	}
+#endif
 }
 
 /**
@@ -150,8 +169,13 @@ void sbi_remote_sfence_vma(const unsigned long *hart_mask,
 					 unsigned long start,
 					 unsigned long size)
 {
-	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
+#ifdef CONFIG_RISCV_SBI_V01
+	if (sbi_spec_is_0_1()) {
+		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
 			(unsigned long)hart_mask, start, size, 0, 0, 0);
+		return;
+	}
+#endif
 }
 
 /**
@@ -170,8 +194,13 @@ void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
 					      unsigned long size,
 					      unsigned long asid)
 {
-	sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
+#ifdef CONFIG_RISCV_SBI_V01
+	if (sbi_spec_is_0_1()) {
+		sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
 			(unsigned long)hart_mask, start, size, asid, 0, 0);
+		return;
+	}
+#endif
 }
 
 /**
-- 
2.23.0

