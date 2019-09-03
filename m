Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDC8C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB723431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CDCwMbxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfICJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:33:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbfICJdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ln0X1q7oVfBNkCHTsi3j7qhXlSXtKoLhWmnqO7aWVoo=; b=CDCwMbxe2090UQSANI6SnrCJ5G
        SCkUMY4FFphIlDAo+mv4cC7SLaujcPoOT9cXggplwCYMgvHAy+kTYHkhrkdBT7LLN7m8z1tht+BqT
        8uTb5mBI7yyd1TrMzaCYU6rhX5i4/DuNSocMzD1ogiHCRBMYlPghBwAtMSssyjPy1AfuNSD1avYIZ
        GcTsuITQdqdcZO8BcVgNo0ls9+LugHNIRxY4/haNm+zPdBEinXnZe1qtm9cxut3t3MsdjRW1A15ZM
        PFhVMnGWD2X7eleQFPDEbuKr7d0Sqvb4toDfdARuCaZ+KhPx6pej97NOxsQ/OJQl/VOrsX+9P1TRm
        VXxBlTvQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i55BU-0004fK-0I; Tue, 03 Sep 2019 09:33:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 11/20] riscv: cleanup the default power off implementation
Date:   Tue,  3 Sep 2019 11:32:30 +0200
Message-Id: <20190903093239.21278-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903093239.21278-1-hch@lst.de>
References: <20190903093239.21278-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the sbi poweroff to a separate function and file that is only
compiled if CONFIG_SBI is set.  Provide a new default fallback
power off that just sits in a wfi loop to save some power.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/Makefile |  1 +
 arch/riscv/kernel/reset.c  |  5 ++---
 arch/riscv/kernel/sbi.c    | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 2420d37d96de..21a8d09c298c 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -39,5 +39,6 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_PERF_EVENTS)      += perf_event.o
+obj-$(CONFIG_RISCV_SBI)		+= sbi.o
 
 clean:
diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index d0fe623bfb8f..5e4e69859af1 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -4,12 +4,11 @@
  */
 
 #include <linux/reboot.h>
-#include <asm/sbi.h>
 
 static void default_power_off(void)
 {
-	sbi_shutdown();
-	while (1);
+	while (1)
+		wait_for_interrupt();
 }
 
 void (*pm_power_off)(void) = default_power_off;
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
new file mode 100644
index 000000000000..f6c7c3e82d28
--- /dev/null
+++ b/arch/riscv/kernel/sbi.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <asm/sbi.h>
+
+static void sbi_power_off(void)
+{
+	sbi_shutdown();
+}
+
+static int __init sbi_init(void)
+{
+	pm_power_off = sbi_power_off;
+	return 0;
+}
+early_initcall(sbi_init);
-- 
2.20.1

