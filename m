Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958F7C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B082082F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SCdBkO+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfF0Ie6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:34:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33934 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfF0Ie5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:34:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so866925pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pL8dIdDRRR0f0oihVWvRAV0Y3VQl+T0ytK1Ju8LVSAk=;
        b=SCdBkO+jaQI/+32tsem4MYwzEIOMI3hZVuw9WMUP+0FE7yL9ObALw9j28rf2xf1fB2
         0k4ChEaKwpDNuJFt8Tq5B0TyP+w/jxmZzR/6VaJL8AD7ERyFf2whc9aHd04XDY2rhz8l
         gxA+2qt5QwU9jN5yDFUmKfpxF2Umndj7fxKmMiwbrYbRDMgl69fS4aEd1t82BpCpI6Pb
         yVRc92Gs409pSpHO0uM0ChMDieNkSvMPtLCtHXp66jykOqer+Jzrh1XxA7rxTsIEnWHp
         sEQGlVa9v4BcMQmow+58cBwGzSBFsBKfi26+KpJWDyMZ0IKWKcz+JtgDj6di0RtXYPvc
         Q1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pL8dIdDRRR0f0oihVWvRAV0Y3VQl+T0ytK1Ju8LVSAk=;
        b=r2sazLapZ8ndllquAeFYBFJx/ZKa1wHVDKS/69sElmjKifhd6qufB6wi5vcGzF0mH5
         6VWlcdIUCWkImBJeIuqyFMLm0YNhMLtn7EJc2pT83m6iC/zx2C3H5AiZDuUMoi4WpMMi
         j2KoLl6lWqSoEf7APJvTGhVI5D0PV+y4l/js2EPDz5QtOJJiJoEAacCjYO//H0aG5ZFU
         9yXzGaauNMFI7W8fzRGkUzFDB/WxC2M/3o0EwBiV814OQ1803Ci5pIVHuH1SgzICQXT9
         KqAjY/1AshCc4xTPLaPbodlfRXNuyJaweKoaN9ZX3CK8TcFbDgzA9vKhrbSH0YKy4hl8
         wbAQ==
X-Gm-Message-State: APjAAAUAapOlpKjbBqItpHjGnpaMtNhNi/cxYLcBXrteKR1V3YUIub5I
        T4z41nHzN4auBcboL0c1ky6JCg==
X-Google-Smtp-Source: APXvYqxH22kQuUNW79tCt4NQgJA3jxTp6iros6Z7j9hPr0a1EPw4lm+Na1LtfqSElnEUcJXDR9/eAw==
X-Received: by 2002:a65:63c3:: with SMTP id n3mr2571078pgv.139.1561624496816;
        Thu, 27 Jun 2019 01:34:56 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id n19sm4001003pfa.11.2019.06.27.01.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Jun 2019 01:34:55 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH] riscv: ccache: Remove unused variable
Date:   Thu, 27 Jun 2019 14:04:46 +0530
Message-Id: <1561624486-22867-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the count register clears the interrupt signal. Currently, the
count registers are read into 'regval' variable but the variable is
never used. Therefore remove it.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/mm/sifive_l2_cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/sifive_l2_cache.c b/arch/riscv/mm/sifive_l2_cache.c
index 4eb6461..3052a42 100644
--- a/arch/riscv/mm/sifive_l2_cache.c
+++ b/arch/riscv/mm/sifive_l2_cache.c
@@ -109,13 +109,13 @@ int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
 
 static irqreturn_t l2_int_handler(int irq, void *device)
 {
-	unsigned int regval, add_h, add_l;
+	unsigned int add_h, add_l;
 
 	if (irq == g_irq[DIR_CORR]) {
 		add_h = readl(l2_base + SIFIVE_L2_DIRECCFIX_HIGH);
 		add_l = readl(l2_base + SIFIVE_L2_DIRECCFIX_LOW);
 		pr_err("L2CACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
-		regval = readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
+		readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
 		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
 					   "DirECCFix");
 	}
@@ -123,7 +123,7 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 		add_h = readl(l2_base + SIFIVE_L2_DATECCFIX_HIGH);
 		add_l = readl(l2_base + SIFIVE_L2_DATECCFIX_LOW);
 		pr_err("L2CACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
-		regval = readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
+		readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
 		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
 					   "DatECCFix");
 	}
@@ -131,7 +131,7 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 		add_h = readl(l2_base + SIFIVE_L2_DATECCFAIL_HIGH);
 		add_l = readl(l2_base + SIFIVE_L2_DATECCFAIL_LOW);
 		pr_err("L2CACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
-		regval = readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
+		readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
 		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
 					   "DatECCFail");
 	}
-- 
1.9.1

