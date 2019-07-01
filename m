Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA28C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889D82133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Bs9P3wHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfGAKkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:40:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42546 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfGAKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:40:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so6376183pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J9c7HLFHB/6MQXAk9nbKdUnuKhx+YpHKq1KxJgKxyP8=;
        b=Bs9P3wHB2+j7xXbfUlkbZGeesB4uPleYuRpo/LZxWgX7auhEjYET5rsTqxsrsgHDvz
         Ak9ruswEkL+P/ohuhQ6IQrrdeMmgKs38Di6rb7bpxGdg24zaIsayOFSHsx0aP4/HYqua
         +KodY6PunVNqp8+GtnzrqFoc9TXb8Pkw31QPVKcjpcUzt+eqE623oc82A3pWGT7jtuhi
         dlO+aJ8AoTQADZHRmQeX9tNGrn3qB5TMeS1ih4Lf1/CzOR6vtDZ763oRUjvxStmXph7Z
         BT2uXEa9AeDxh7BBebcOV6wDWPWhyttKxVmgPlP0OyyrhwnoDxvh77Gj0rDyUl2zOgtD
         rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J9c7HLFHB/6MQXAk9nbKdUnuKhx+YpHKq1KxJgKxyP8=;
        b=klSfRWNS541tqRdDVYeCVSt7SKEqrkFbgiKGmAd6/TEpouBnBd/iNIx4ZQzOKWOhIS
         CbMP9+STsm+vlvUoNyhJkc82wxlwmL1s5j5rcppEvMVTud4FJOu5tf/2dAw59nPjQ9vE
         YmnGYTEVv3XsN4NOc3yzFJJ63Ko7mSAvlwKHIM8feNRndfNDzpiPujDJavjFvbrT8IUL
         +V1LBy/MIO99QNmLMGweo2DtgAhP0P0KS2r1rRvBM4fnp9MtpskuNVOY5CBscSRKvw2k
         STbJ1bCE1yIejSN2SlOzdWwpTa+YLT+hCzqwCaPYVECwjO9CNL4miKt9T7xeeWVHvRnG
         68XA==
X-Gm-Message-State: APjAAAVL3ssmY0jeanzslyyZynmNBHhaasZjKezjc3hfXQwaWeHRHLmT
        pktwBt4fO4fe7tFd3bFj8smFLw==
X-Google-Smtp-Source: APXvYqxRbbkcM3EC4AAooXtro5KK4p2N7RlMCFLz7OVdz7IN7Z9Yh+tGOL9jDwil84AW7t3NWSN6bA==
X-Received: by 2002:a17:90a:d814:: with SMTP id a20mr30532666pjv.48.1561977652141;
        Mon, 01 Jul 2019 03:40:52 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id g62sm10410755pje.11.2019.07.01.03.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 03:40:51 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2] riscv: ccache: Remove unused variable
Date:   Mon,  1 Jul 2019 16:10:30 +0530
Message-Id: <1561977630-32309-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the count register clears the interrupt signal. Currently, the
count registers are read into 'regval' variable but the variable is
never used. Therefore remove it. V2 of this patch add comments to
justify the readl calls without checking the return value.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/mm/sifive_l2_cache.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/sifive_l2_cache.c b/arch/riscv/mm/sifive_l2_cache.c
index 4eb6461..2e637ad 100644
--- a/arch/riscv/mm/sifive_l2_cache.c
+++ b/arch/riscv/mm/sifive_l2_cache.c
@@ -109,13 +109,14 @@ int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
 
 static irqreturn_t l2_int_handler(int irq, void *device)
 {
-	unsigned int regval, add_h, add_l;
+	unsigned int add_h, add_l;
 
 	if (irq == g_irq[DIR_CORR]) {
 		add_h = readl(l2_base + SIFIVE_L2_DIRECCFIX_HIGH);
 		add_l = readl(l2_base + SIFIVE_L2_DIRECCFIX_LOW);
 		pr_err("L2CACHE: DirError @ 0x%08X.%08X\n", add_h, add_l);
-		regval = readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
+		/* Reading this register clears the DirError interrupt sig */
+		readl(l2_base + SIFIVE_L2_DIRECCFIX_COUNT);
 		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
 					   "DirECCFix");
 	}
@@ -123,7 +124,8 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 		add_h = readl(l2_base + SIFIVE_L2_DATECCFIX_HIGH);
 		add_l = readl(l2_base + SIFIVE_L2_DATECCFIX_LOW);
 		pr_err("L2CACHE: DataError @ 0x%08X.%08X\n", add_h, add_l);
-		regval = readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
+		/* Reading this register clears the DataError interrupt sig */
+		readl(l2_base + SIFIVE_L2_DATECCFIX_COUNT);
 		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_CE,
 					   "DatECCFix");
 	}
@@ -131,7 +133,8 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 		add_h = readl(l2_base + SIFIVE_L2_DATECCFAIL_HIGH);
 		add_l = readl(l2_base + SIFIVE_L2_DATECCFAIL_LOW);
 		pr_err("L2CACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l);
-		regval = readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
+		/* Reading this register clears the DataFail interrupt sig */
+		readl(l2_base + SIFIVE_L2_DATECCFAIL_COUNT);
 		atomic_notifier_call_chain(&l2_err_chain, SIFIVE_L2_ERR_TYPE_UE,
 					   "DatECCFail");
 	}
-- 
1.9.1

