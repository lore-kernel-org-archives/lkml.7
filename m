Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0DEC41517
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DAF2189F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Myyb8LAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfGZTqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:46:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17125 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfGZTqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564170409; x=1595706409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zuljV/XFkkELlNYpQrLLimGaj7xDNrUz/oDJpIkonzM=;
  b=Myyb8LADvrkShiHFTkJu9BTi0McjGUKkl1a9HCB50f3ePIhLZm772RNE
   XYNyHoZrk5KhbfaCwOMH52Vetl6emY3poS/+psauQQFt6wIQJXD/JXs+f
   77Xp0yK/zATNG4PkbEo/Yh9Y+MoYbP86+njc2eEWqz15JssvsB76JrZmU
   FDTnv4DUJ5Bfi0Z3+uN1ogp2jl2mNrS+Q7GzGjvwZJozEpjYjbP5//JI2
   V/i2/hib3eB593otYiRrnh1iVvRmAchozgXGtCuALwE5Nhxvzf84xMP5j
   G1LxUaouahSOD2U9sgYQpKHmx6d2Edt+Jh5P8EmTiL/ACKyiWLqsQD/4D
   g==;
IronPort-SDR: ep3fD+qdH5febwaPD6KRwukJ6RZRWOZ9k0n229xzTUY6pcYhgFmhtJmq+97MU4RDXivVKVQkVe
 Qc7SCVwFAeoIUGeY38UbEmm1V3KpDbPS2+9ddsb3g+Aw70Jg/tRr6NmVty+/Iw+VPqY9oaA76t
 DoYO+kmpwqpny1OwQABwvMi/uPSUZYSakJk75dZeDveA2fb5512JKWxsTIuv45QQV0zfK6pI/M
 3FVEcehczaRw/TbWJ3TBh/6N+VY4C5NUXQiFYFjKZXHzhcGh7eimtGNG3hFmsOWObAAft0cElf
 AmI=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="114239812"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 03:46:48 +0800
IronPort-SDR: ixCC1/VtgmBvREQOX5zigMCb+mBTGF14wbKC32jtURGfaFHsY7QF8Sme56YbdWFgGGbOYtYj/9
 e+1ZS6gnspysCv/0muExZvAkaKdmWGsh7EzTTnZpyIGcnl7dcCWFDKy9hJqkC7MJImITUXjxNc
 BH5XREhbyJ7sf7VyQbmvX/DAWZyZ4pajoO/phlptSO3zZ0lqvYYvE7UFkUow1meaoHEdQsLZBQ
 /jEfgahiutzTn+xGqO2mt9oTYDb7P5GmhUUlDEs+QPv8+H77pBmIs1/UMnqJIrPF0NtZLkkliH
 rRn1wRr8nED4gSZEW69uX+Hu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2019 12:44:57 -0700
IronPort-SDR: wTxhkBHItRBK6MQN42Flf6IDsh0NhG04f+bcBRld7ws7XJL62cnVGK7DynbnmXlEJ2GUnFXWG0
 peU7/eOrwiFPw9pbSRMd1QwreStg8598I0Tm1oqu1ia9hVcU0eFKVL/GxeBBOS++awvjNnrZ4K
 us0zET2Sf80U+I6/KdcnhsS+YOGXYChPOQIGCNhyMeJotR22b/t2IonRa0IKyI8xhU5mKEmJj5
 4rTMHJT0NehUAirTRMneA1RTzOh30uD1OSLu0Q3X8WhW/57CSiAE9dZlVX0cuFIfe29ogq+IrQ
 WoE=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 12:46:48 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
Date:   Fri, 26 Jul 2019 12:46:37 -0700
Message-Id: <20190726194638.8068-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190726194638.8068-1-atish.patra@wdc.com>
References: <20190726194638.8068-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per riscv specification, ISA naming strings are
case insensitive. However, currently only lower case
strings are parsed during cpu procfs.

Support parsing of upper case letters as well.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 7da3c6a93abd..185143478830 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -5,6 +5,7 @@
 
 #include <linux/init.h>
 #include <linux/seq_file.h>
+#include <linux/ctype.h>
 #include <linux/of.h>
 #include <asm/smp.h>
 
@@ -57,10 +58,10 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 	 * kernels on harts with the same ISA that the kernel is compiled for.
 	 */
 #if defined(CONFIG_32BIT)
-	if (strncmp(isa, "rv32i", 5) != 0)
+	if (strncasecmp(isa, "rv32i", 5) != 0)
 		return;
 #elif defined(CONFIG_64BIT)
-	if (strncmp(isa, "rv64i", 5) != 0)
+	if (strncasecmp(isa, "rv64i", 5) != 0)
 		return;
 #endif
 
@@ -76,8 +77,8 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 	 * extension from userspace as it's not accessible from there.
 	 */
 	for (e = ext; *e != '\0'; ++e) {
-		if (isa[0] == e[0]) {
-			if (isa[0] != 's')
+		if (tolower(isa[0]) == e[0]) {
+			if (tolower(isa[0] != 's'))
 				seq_write(f, isa, 1);
 
 			isa++;
-- 
2.21.0

