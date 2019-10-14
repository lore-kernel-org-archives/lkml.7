Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDCAC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A81207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kahd71I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfJNHIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:08:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34634 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfJNHIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:08:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so9872190pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1ydsP1Cp9s0wk741A+j1HGA3H7t+pJBn7+BclAM8H+M=;
        b=kahd71I+jydL8AwtKPA5jqJIFN6xTV+kelQ8RxPi/IoS5FJswOPifHzuka0ajgk84D
         Tu/kAVwgphcFPtLaj+ifYHJt6yGsuDBOZ9YiNQIiRoVQYgrzloEfXdpt7jEJvjvQigkC
         7J224xdekYFogIev6qsKXWkQLj8f+B/jIWJRAeOiE5dmZSmnQyTZ29/sT5qNyrrmNm/X
         MiX7W3pwbwf4mckEbkQBSzTufBV4PzkHHmtN6LMVL223bCC1b5NkoQ2+YKnGWwdggELX
         QQZcbbRER3Lpt9PjdGQPnB6IVsyfV6hpzC/LfZ6670MitRmRNIJPiMNunqSEpw0pdfli
         WneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1ydsP1Cp9s0wk741A+j1HGA3H7t+pJBn7+BclAM8H+M=;
        b=XI9y7tZQtFHmgOcfULDLySAfnBS8ceBsm5CKDuatrS6Leq1x1mIaQpFd8thZTwlpE6
         3m/qjyF2KxCSep8zkJ/AQAFUT8DrABO+qoBG7vof70IBhJ8gQXFFBIsb4Jw5j6kjX980
         ot1cnmq2IbSSpovws1U+fFyoiNbkf1/OmMq3FVZkPzmgjSDnEA7Yu/kFl+7RD51x9HEM
         WJyR3UsIBAu3jHuybdZFFBCLELayceRo6vQJGeIjW0Qz0kYwEuYRkGOQ1rMcvTuur3cy
         AFBcaED3tWhnblM5SZa6qsqT7kce4QhB7ycCFkAEr7P92KLwsmW203k8PCZOyzUG37IX
         qbUA==
X-Gm-Message-State: APjAAAVGfDq2gh7ntRs7+5yiStXFmv4nGgbaIdeUm1io0kpAYs3YbtXH
        3z9lyBm9hBilfPwpLaFK1SrSYw==
X-Google-Smtp-Source: APXvYqxv2BmrjcqFoDObMm2gQRhJZtQRLtBrcLu0vLIyKYJqaaJ45K79YI50OvI+hNc8D356sSDNtw==
X-Received: by 2002:a63:5022:: with SMTP id e34mr15455176pgb.400.1571036898239;
        Mon, 14 Oct 2019 00:08:18 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p190sm20619948pfb.160.2019.10.14.00.08.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Oct 2019 00:08:17 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linus.walleij@linaro.org, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, baolin.wang@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hwspinlock: Remove BUG_ON() from the hwspinlock core
Date:   Mon, 14 Oct 2019 15:07:43 +0800
Message-Id: <cf225e8ead98e04393b1c663d40b6dd868acc54c.1571036463.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1571036463.git.baolin.wang@linaro.org>
References: <cover.1571036463.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1571036463.git.baolin.wang@linaro.org>
References: <cover.1571036463.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code use BUG_ON() to validate the parameters when locking
or unlocking one hardware lock, but we should not crash the whole kernel
though the hwlock parameters are incorrect, instead we can return
the error number for users and give some warning.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 8862445..a22e252c 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -92,8 +92,8 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 {
 	int ret;
 
-	BUG_ON(!hwlock);
-	BUG_ON(!flags && mode == HWLOCK_IRQSTATE);
+	if (WARN_ON(!hwlock || (!flags && mode == HWLOCK_IRQSTATE)))
+		return -EINVAL;
 
 	/*
 	 * This spin_lock{_irq, _irqsave} serves three purposes:
@@ -264,8 +264,8 @@ int __hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int to,
  */
 void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 {
-	BUG_ON(!hwlock);
-	BUG_ON(!flags && mode == HWLOCK_IRQSTATE);
+	if (WARN_ON(!hwlock || (!flags && mode == HWLOCK_IRQSTATE)))
+		return;
 
 	/*
 	 * We must make sure that memory operations (both reads and writes),
-- 
1.7.9.5

