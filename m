Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DFFCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0C0208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jFkAPuVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfJaX4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:56:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44507 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJaX4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:56:34 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so8930765iol.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 16:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/fnQra9d+cV+1M9gZD3yWkRXYXxESEWySrRcy1ZQ884=;
        b=jFkAPuVVbTiZQwRT+6JgakTwHUqWbofDYBVITUw8pN08LshcDUd/oVj2dI7th601+8
         TTqVgro+D1ceDEO9npCbqiYcbeAWQcVvgs0AJKGgBPsenS/zBdBsV/YUDDNcRW6fy+Zy
         r3CX1h0iNWq0Z4jRyr+u43bA1NCTAqjlbeaoe5wLvdbvjZOOKRSu5VZipIB5RDrAD92X
         Za8OPIV/kkts6gTvUcSIjrkr5O77cnHjbWvbvrDW+UcEEbhBi4W+iv2puGFM7iMT1k0J
         QIjdg5rZMtq82oiUlsA1XmU+pn7qAc5UD1iQkIxeO/m2mRI0i/P7j8l3PZBa0h2wNghl
         Jwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/fnQra9d+cV+1M9gZD3yWkRXYXxESEWySrRcy1ZQ884=;
        b=QPlsBbTtThAk2UiHetZhrGZD2xfcQRhTkmLMCwqBm2KmUhInR3cjGltxBcVqT4jofG
         3PDxdjjwUtDJe+3Aztp4s5OJC8MuG80JDg1LDU7P+769Q0io9pbIg8D/AqKXaLBfOeaE
         sQ0ihqrMIThDdYe02z9ZxVJ22M1XFzq2nZZD9Q5TIEJ+BKyKEH3F5hmQEMVwnbmO58pS
         zjEZiKxTNT3OKuBkpgB4FOQzqnEzoFtNnYUOC2QCU/fjUl/rzkjcdaWSs5wRz+iSH7Ka
         Pnb20EfUCu6pXeTAchLgKB+/HgdQPRWk6jaJYWe+TO2VHEM4SeWq7GS9qQmNX/PB17ak
         68Og==
X-Gm-Message-State: APjAAAUFmzmKq8sjgZOynQR7X7D2vq0ohE3Xe3+iT5y+fr3Sma4V3Qum
        c9w2bN20OHezWejmr8c9QSihkQ==
X-Google-Smtp-Source: APXvYqyieA3Tp6DtjKlQJqY+H7eiSAZWJm9Zhno/zJ+6iwEp6L11GD81J3wKgOoDEpx0lICfPhEy2g==
X-Received: by 2002:a5d:9741:: with SMTP id c1mr7181277ioo.25.1572566193714;
        Thu, 31 Oct 2019 16:56:33 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id 9sm658009ilv.57.2019.10.31.16.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 16:56:33 -0700 (PDT)
Date:   Thu, 31 Oct 2019 16:56:31 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 04/12] riscv: cleanup the default power off
 implementation
In-Reply-To: <20191028121043.22934-5-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1910311655320.25874@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-5-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> Move the sbi poweroff to a separate function and file that is only
> compiled if CONFIG_SBI is set.  Provide a new default fallback
> power off that just sits in a wfi loop to save some power.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

And here's the other part of this patch, queued for v5.5-rc1.


- Paul


From: Christoph Hellwig <hch@lst.de>
Date: Mon, 28 Oct 2019 13:10:35 +0100
Subject: [PATCH] riscv: cleanup the default power off implementation

Move the sbi poweroff to a separate function and file that is only
compiled if CONFIG_SBI is set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
[paul.walmsley@sifive.com: split the WFI fix into a separate patch]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/Makefile |  1 +
 arch/riscv/kernel/reset.c  |  2 --
 arch/riscv/kernel/sbi.c    | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 696020ff72db..d8c35fa93cc6 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -41,5 +41,6 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
+obj-$(CONFIG_RISCV_SBI)		+= sbi.o
 
 clean:
diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index 485be426d9b1..ee5878d968cc 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -5,11 +5,9 @@
 
 #include <linux/reboot.h>
 #include <linux/pm.h>
-#include <asm/sbi.h>
 
 static void default_power_off(void)
 {
-	sbi_shutdown();
 	while (1)
 		wait_for_interrupt();
 }
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
2.24.0.rc0

