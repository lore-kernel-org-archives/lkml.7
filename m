Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31041206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Ijf9ltaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbfIEOqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:46:20 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:58893 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728918AbfIEOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:46:19 -0400
Received: from mxback16j.mail.yandex.net (mxback16j.mail.yandex.net [IPv6:2a02:6b8:0:1619::92])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 4C4C7598117D;
        Thu,  5 Sep 2019 17:46:16 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback16j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 4wniqpzpPT-kFhWBwmx;
        Thu, 05 Sep 2019 17:46:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1567694776;
        bh=lGWrm07yEb+iDYbXl6MNXFFYrFAuttvAedBfbL1LKfs=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=Ijf9ltaf54iJMiLL1kKYhyq7mf4/CahwjIJMu21eJLhPDIt6ghoal5bVwqqrh7O6d
         GrScwxqWKgtFMSh2w5nXRFL1EwJEQgwsU/xBYOMt+PUkYNlMRYb4VXwQcGAnp9BdOk
         fdJpSyzCL0PbTmZPy/Zc+aRGpCMbcD1VmTBvWGqE=
Authentication-Results: mxback16j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id zkoybIaMjG-k2xW8q8W;
        Thu, 05 Sep 2019 17:46:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     chenhc@lemote.com, paul.burton@mips.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 10/19] irqchip: mips-cpu: Convert to simple domain
Date:   Thu,  5 Sep 2019 22:43:07 +0800
Message-Id: <20190905144316.12527-11-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
References: <20190905144316.12527-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old code is using legacy domain to setup irq_domain for CPU interrupts
which requires irq_desc being preallocated.

However, when MIPS_CPU_IRQ_BASE >= 16, irq_desc for CPU IRQs may end up
unallocated and lead to incorrect behavior.

Thus we convert the legacy domain to simple domain which can allocate irq_desc
during initialization.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/irqchip/irq-mips-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 95d4fd8f7a96..c3cf7fa76424 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -251,7 +251,7 @@ static void __init __mips_cpu_irq_init(struct device_node *of_node)
 	clear_c0_status(ST0_IM);
 	clear_c0_cause(CAUSEF_IP);
 
-	irq_domain = irq_domain_add_legacy(of_node, 8, MIPS_CPU_IRQ_BASE, 0,
+	irq_domain = irq_domain_add_simple(of_node, 8, MIPS_CPU_IRQ_BASE,
 					   &mips_cpu_intc_irq_domain_ops,
 					   NULL);
 	if (!irq_domain)
-- 
2.22.0

