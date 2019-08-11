Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410ABC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1929F2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOY3VzXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfHKSdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:33:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHKSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:33:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so9865482wmc.4;
        Sun, 11 Aug 2019 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FOh3HP7shWLzeniqP1aypDXeCQyKvXxAbR2O18zZaM=;
        b=eOY3VzXADfTLo/eG8DBsl8a/U4xgurPylkOx3UmChVv+9NLjq0HxTt61HhuzavxLB5
         e/89Uy/dCtxYcaPyBErCf2Z9RvAjGSOvEnf68WOUkUSS554wmQk9HPXWFkjs5RtUKiwU
         ZPvzLoOWQLPEKjoV6PohL8l3/jM37VKcHD2q4BBfRlc1LtQDDeFP5asj3/Ghmt7Hq0ma
         nUd9P57bYOon5mSRp7Ov8usWMl3XeWk4VxaOH/YgkgbbRz4qVurbIh8FujYMhQWXR5gZ
         1c3aFdXcrTlDvyVA60e7cZiqNQhr1WgcwgAxnzvRPANp17ClDUHEId788yuxsaqbI65z
         UFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FOh3HP7shWLzeniqP1aypDXeCQyKvXxAbR2O18zZaM=;
        b=HtrujEPZ2VfkNdomIlLuLNbQSAr83KhstMXbuzKzxe4oix0jVVlE1PUdUVnIWlb/Ku
         YBTqgAJ6HB3vE+gMjVXzqx4Kkphg8XeOzLNEgzX+T9vrEvW2BVMH0H7CCStUdSzvKt1z
         UmHlRZA4TwaDluSzui6rDEbEaZBzhb/XBeyhHbtq13zksRhMuSVLhGbu0NIN817r9yJx
         Uxm4d++JBmmY6iyOu2QqS9HgZ5YalUnSJhXN47zQUQLeghjqxtrarlN8jiRO4I4gK0/U
         Y84PFfJhKPW/GFDV+gZPkop8euKfDR3WY1oelj2fGDmYc6div94CMdvdPw5acVeG0xMr
         9tvw==
X-Gm-Message-State: APjAAAW/1NiF8Voqp3paE/xFNNC6VfTsMqns4FH66O+KjfecrR2d75Fd
        CVCA9YiDZVRzwrPgXngekTg=
X-Google-Smtp-Source: APXvYqy9wy2MvxkO/h/qLbFmcjDGAPdY8z62l4SD8FqhyUagBvgOyIxQvSiD78Cj8gvYMdqCSdvaKQ==
X-Received: by 2002:a05:600c:144:: with SMTP id w4mr9691692wmm.94.1565548395516;
        Sun, 11 Aug 2019 11:33:15 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id c19sm6824340wml.13.2019.08.11.11.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 11:33:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] irqchip/tegra: Clean up coding style
Date:   Sun, 11 Aug 2019 21:30:44 +0300
Message-Id: <20190811183044.13925-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811183044.13925-1-digetx@gmail.com>
References: <20190811183044.13925-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make coding style to conform to the kernel's standard by fixing checkpatch
warnings about "line over 80 characters".

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/irqchip/irq-tegra.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index 14dcacc2ad38..f829a5990dae 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -74,7 +74,7 @@ static struct tegra_ictlr_info *lic;
 
 static inline void tegra_ictlr_write_mask(struct irq_data *d, unsigned long reg)
 {
-	void __iomem *base = (void __iomem __force *)d->chip_data;
+	void __iomem *base = lic->base[d->hwirq / 32];
 	u32 mask;
 
 	mask = BIT(d->hwirq % 32);
@@ -142,7 +142,8 @@ static int tegra_ictlr_suspend(void)
 		writel_relaxed(~0ul, ictlr + ICTLR_CPU_IER_CLR);
 
 		/* Enable the wakeup sources of ictlr */
-		writel_relaxed(lic->ictlr_wake_mask[i], ictlr + ICTLR_CPU_IER_SET);
+		writel_relaxed(lic->ictlr_wake_mask[i],
+			       ictlr + ICTLR_CPU_IER_SET);
 	}
 	local_irq_restore(flags);
 
@@ -222,7 +223,6 @@ static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
 {
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec parent_fwspec;
-	struct tegra_ictlr_info *info = domain->host_data;
 	irq_hw_number_t hwirq;
 	unsigned int i;
 
@@ -235,13 +235,9 @@ static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
 	if (hwirq >= (num_ictlrs * 32))
 		return -EINVAL;
 
-	for (i = 0; i < nr_irqs; i++) {
-		int ictlr = (hwirq + i) / 32;
-
+	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &tegra_ictlr_chip,
-					      (void __force *)info->base[ictlr]);
-	}
+					      &tegra_ictlr_chip, NULL);
 
 	parent_fwspec = *fwspec;
 	parent_fwspec.fwnode = domain->parent->fwnode;
@@ -312,7 +308,6 @@ static int __init tegra_ictlr_init(struct device_node *node,
 	     "%pOF: Found %u interrupt controllers in DT; expected %u.\n",
 	     node, num_ictlrs, soc->num_ictlrs);
 
-
 	domain = irq_domain_add_hierarchy(parent_domain, 0, num_ictlrs * 32,
 					  node, &tegra_ictlr_domain_ops,
 					  lic);
-- 
2.22.0

