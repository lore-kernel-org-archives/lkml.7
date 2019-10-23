Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799A5CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438402084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UMt5+eks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407081AbfJWQWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:22:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46586 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404850AbfJWQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:22:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so12414639pgu.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ilmfO6H+RDidCkh9jA09636tYNrmUwzLUqDZtBlewQA=;
        b=UMt5+eksXZx6l05Nk14XEFLxERC+9XYYma9NsObhXUcOtuU29glnUumKRZB3n1JbWD
         rQmD4+TgqM0a5pLy1PPi/8bUkHy0AcUq02FwWZs0Hzv6Ng5+iPkfo/vqRUCdvSQXWWeI
         D8ohT2TauGtBE0RdT9pufYzcJMvOm38NUqT7nOtsrlHumhobyZyYaANeBxXHu0a1maX4
         oK1VMFe5fDGTDhV1GQEw4qYjzj5kOEQ9mphrSTtuFvgr0kjx/0PDHTn4PGnfCVHVddBf
         ROKFcfWqqNBQGdDH6UnJb6tmkKVfxT5YLYSNNm7EcG3EQ2DvH/jlqyIMjzwhX5K3igSN
         d7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ilmfO6H+RDidCkh9jA09636tYNrmUwzLUqDZtBlewQA=;
        b=MRqgwywY4owfGO2iRNNNPMozV6Digp4frlCnZdQoX1kNclLR9WeIWKerqvyG1ah0lC
         Tqk1yuQcfh03q21X5Qk1dkkk1bAVr9UR+1upR8pv4koTHlrLkwL02U9fuExqBNixJc8K
         F81xMxqGrZbJTFFV1YVwSI+J25R/5K80NH3omZq5gzB7ahGcXa6JFkx6B6Th5NYdcIX2
         FxRA7aVTwd5B7DFIk2oDEII7j4dYWTyEjg7GSzLk9itdyaEo4boCElIUiSyO/MiBb4HP
         yYnHseO9ImERXLjUqK/YEtvydFAUA/oowW229HBx6mIk0kNz/54urh/fVw5dYl6tWc1A
         /qWQ==
X-Gm-Message-State: APjAAAXjo49+EkPxkkrVhKO+XeTivoEpUUv130isCY4JNGAqp/ncOKor
        xjME0yf8Z7YNCZqdFiL6hsfxT+sOqMw=
X-Google-Smtp-Source: APXvYqxmDgsKwhLzcdRg8Xt24WJjbRby8byrWsA3Dv6X4xlq5cd64AnwiNsYkBsi6F6m6BBs2x5Afg==
X-Received: by 2002:a65:689a:: with SMTP id e26mr10944113pgt.346.1571847760808;
        Wed, 23 Oct 2019 09:22:40 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u11sm33434233pgo.65.2019.10.23.09.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 09:22:40 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] irqchip: Skip contexts other supervisor in plic_init()
Date:   Wed, 23 Oct 2019 09:22:35 -0700
Message-Id: <1571847755-20388-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify plic_init() to skip .dts interrupt contexts other
than supervisor external interrupt.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c72c036aea76..5f2a773d5669 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -251,8 +251,8 @@ static int __init plic_init(struct device_node *node,
 			continue;
 		}
 
-		/* skip context holes */
-		if (parent.args[0] == -1)
+		/* skip contexts other than supervisor external interrupt */
+		if (parent.args[0] != IRQ_S_EXT)
 			continue;
 
 		hartid = plic_find_hart_id(parent.np);
-- 
2.7.4

