Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D8C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7944F208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20150623.gappssmtp.com header.i=@bluespec-com.20150623.gappssmtp.com header.b="ZxNG3UE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfILVkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:40:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39541 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfILVkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:40:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so26049304qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=M1tKgm33LQ2be99LOvEnyaL0zINjClpzlgxw1sHb68o=;
        b=ZxNG3UE1rPZ298v67rwH4cEBUwN6g6l5LUfSoK6xdTWlsQHAshELJUyZ+ZM/m73bVI
         lZbEaGM1brG04j26Obxm+6oMiUK/KXMQJKBdMjnkQiNLPzgij79ha3R/+DI53hKrkXr4
         /2oG6HgUrtunDlhQXW0tsxyGn5+qMiF3Hj+9editGB9EiFvDnNjlDlaYT+IyTEu8lItm
         05kn50MDOXeM6JxGXkJLac8N60aQVx4mKjfkKECO5AR6MB9gHLxSUWI7HOCpr1aplnBA
         zc81mu57IhERYA6TFbsTqNfTQVYe1vmhhO6TE8GnUaliEUAD3OBs3pH74Unuz3BRp2pj
         x0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=M1tKgm33LQ2be99LOvEnyaL0zINjClpzlgxw1sHb68o=;
        b=Hb6kWq5GFUi/DYRGCpjRa6NMvBTugeIxlgyFR1EsI5mmaDbOVLCbvqOdtwd7F60Dpi
         WgCYZp9M3XOxuvWrHK3ETypSuPA9kvpFORKCrG/m/+qRX6I+q3Nl8KiCdLQaTVcXNI2v
         1qf6BtYzEfTcsuVpFAISlfx9Qe6Oli+4nTkCR58LKEhdf8b+BF4ZkfQT2bOpedFa3eDW
         CrNbj1CK1da4PNAcboaEeQtSNVMA5r7yIZA0tjl75qTbinSVDgnGV9DuWc3OrpHXA7qL
         TWtqc5+pLdbGNEp5CtYAcwVtEOCIwhKDwndTShsGBoSrmJjPfozKN7XF++FdOQ7mLnwi
         Gwzg==
X-Gm-Message-State: APjAAAWffpFcfvi6V7uh+bFa0bw8aSE8HFLyrSAN2AcQ1VDfqMCbn7u3
        hgccr/NG+fP1Thbcno3+F36K
X-Google-Smtp-Source: APXvYqwCxVxaVQ2wC/qHP+3PK9ORcfnFnL1tEBD9Lg+B0hzh0k1IoAQzkkDGB3YEqlF0BY4Ddj7F/w==
X-Received: by 2002:ae9:e817:: with SMTP id a23mr12658660qkg.294.1568324436863;
        Thu, 12 Sep 2019 14:40:36 -0700 (PDT)
Received: from [10.31.10.6] ([194.59.251.62])
        by smtp.gmail.com with ESMTPSA id t25sm10460807qtp.29.2019.09.12.14.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 14:40:36 -0700 (PDT)
To:     linux-riscv@lists.infradead.org
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
From:   Darius Rad <darius@bluespec.com>
Subject: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
Message-ID: <529ec882-734f-17ae-e4cb-3aeb563ad1d5@bluespec.com>
Date:   Thu, 12 Sep 2019 17:40:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the existing comment, irq_mask and irq_unmask do not need
to do anything for the PLIC.  However, the functions must exist
(the pointers cannot be NULL) as they are not optional, based on
the documentation (Documentation/core-api/genericirq.rst) as well
as existing usage (e.g., include/linux/irqchip/chained_irq.h).

Signed-off-by: Darius Rad <darius@bluespec.com>
---
 drivers/irqchip/irq-sifive-plic.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cf755964f2f8..52d5169f924f 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -111,6 +111,13 @@ static void plic_irq_disable(struct irq_data *d)
 	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
 }
 
+/*
+ * There is no need to mask/unmask PLIC interrupts.  They are "masked"
+ * by reading claim and "unmasked" when writing it back.
+ */
+static void plic_irq_mask(struct irq_data *d) { }
+static void plic_irq_unmask(struct irq_data *d) { }
+
 #ifdef CONFIG_SMP
 static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
@@ -138,12 +145,10 @@ static int plic_set_affinity(struct irq_data *d,
 
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
-	/*
-	 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
-	 * by reading claim and "unmasked" when writing it back.
-	 */
 	.irq_enable	= plic_irq_enable,
 	.irq_disable	= plic_irq_disable,
+	.irq_mask	= plic_irq_mask,
+	.irq_unmask	= plic_irq_unmask,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = plic_set_affinity,
 #endif
-- 
2.20.1

