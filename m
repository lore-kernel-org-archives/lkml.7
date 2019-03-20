Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3828C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC9221873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L88Tvj8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCTTjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:39:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32981 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTTjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:39:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so2553759pgk.0;
        Wed, 20 Mar 2019 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rQ7dC83klRmTKhwOjN/IqSQfUwsj7cUPMzmBzxP6UKw=;
        b=L88Tvj8kS8+X0u9EsGn9b/oUBZ6cB/it9A4A6nUzt5o26v+0dnnzJaHEVpdr8qS9yk
         4G1mujFAnT9jLXt1np1ol9mOFYaRCadl3BCcZzcaOYJH6i6iSrXgFmcy0Jkn6yMNCax4
         SWIroqkjJ5/CZUlYCN0L4O5eVXGHD23QL4aY5Ut9GdwOzzQugnDfk2ZI0lu3eFag+iTq
         B9YOn/ieuERTm77c9aS7bGo+ag0QpwxxK1nPgAq5+OfgpYa8cC/KBl7qNJ8DNGYwpzdD
         QCguZ1/D0QTnyT6DnvBGjpRZ7gkypiabqycZfJmM50LaNSq3SU2xGpQAJITKNZprZpLr
         uzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rQ7dC83klRmTKhwOjN/IqSQfUwsj7cUPMzmBzxP6UKw=;
        b=AdgWlxQ1t9viBepDIZQhqAue/DdEedyQfHZ7nB/Bpn6K0iextEasU7p6raeYZCfgH6
         LTsgs/SaaCAGu+FxtHJUrRgzyYA5Nd9Nvu9sj7mH0NCFH4fO6y7NPangDt5tpjYcPVFN
         hXLNTMnITAlJYZWSnp3h5qlfk+9XSTtIurxP4qQ2qLS5LEr9PQXYkmkgz+Bwe8CRCc0e
         gJnbrKXzeA4oMjHJSv7+5/ENv9ANn/RkZDV/59Gf/e/j8uNHwVI6X8nz6dvnDD6d0VPg
         04tMTMy0lwGQu4bUpHwA/o+3qFS0qo1eawxC5Yn/5UVjRMGkGtdaIS8sclwYpPFyqxOl
         ecvA==
X-Gm-Message-State: APjAAAWVvLT3jb/mmEfBOMYWmjyl1/vBlgbejzTtSh0T+KhWYxHlzfPh
        rf2IeMkigM8TpfN+v7MRU7XjBp3n
X-Google-Smtp-Source: APXvYqz2bYPl2mgGU7oQwScwh21p1D/Z6MU4YSULhKrirLo1Y/hcJe9I59upJAVPxJXIvaemgB9g+g==
X-Received: by 2002:a63:c242:: with SMTP id l2mr9044078pgg.138.1553110775181;
        Wed, 20 Mar 2019 12:39:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b85sm5083896pfj.56.2019.03.20.12.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:39:34 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jaedon.shin@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH] irqchip/bcm: Restore registration print with %pOF
Date:   Wed, 20 Mar 2019 12:39:19 -0700
Message-Id: <20190320193920.13164-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to print which interrupt controllers are registered in the
system and which parent IRQ they use, especially given that L2 interrupt
controllers do not call request_irq() on their parent interrupt and do
not appear under /proc/interrupts for that reason.

We used to print the base register address virtual address which had
little value, use %pOF to print the path to the Device Tree node which
maps to the physical address more easily and is what people need to
troubleshoot systems.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 3 +++
 drivers/irqchip/irq-bcm7120-l2.c | 3 +++
 drivers/irqchip/irq-brcmstb-l2.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 0f6e30e9009d..0acebac1920b 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -343,6 +343,9 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
+	pr_info("registered BCM7038 L1 intc (%pOF, IRQs: %d)\n",
+		dn, IRQS_PER_WORD * intc->n_words);
+
 	return 0;
 
 out_unmap:
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 8968e5e93fcb..541bdca9f4af 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -318,6 +318,9 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		}
 	}
 
+	pr_info("registered %s intc (%pOF, parent IRQ(s): %d)\n",
+		intc_name, dn, data->num_parent_irqs);
+
 	return 0;
 
 out_free_domain:
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 83364fedbf0a..77822ad37aad 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -264,6 +264,8 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		ct->chip.irq_set_wake = irq_gc_set_wake;
 	}
 
+	pr_info("registered L2 intc (%pOF, parent irq: %d)\n", np, parent_irq);
+
 	return 0;
 
 out_free_domain:
-- 
2.17.1

