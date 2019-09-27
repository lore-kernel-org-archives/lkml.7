Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67B3C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984AF217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S02hsAii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfI0I2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:28:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39831 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfI0I2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:28:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so785645plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vfYzArXzFe1wH00PAKP88fvUR7yXk6kDogWfZQY7lTA=;
        b=S02hsAiiBDCmqzupGtJrjHkn9YV7Qk3fVrnsTFaEf6sC720aQY4Ev4M3phUHhoyUXI
         MhS3KIWNqIFoSEZ9lich9pbh8HtVr4OLUMuElnij8iezvsPEczpf/K0iQkU8Rp0xhYh5
         81WPorMjBDzY30Bgf2aP14iEX6X+yCxfFuQETJoCQMyMEbl4b3XtP3NLTTHhC03+22H4
         NXavZm7TMJ78BSG5rSUAA9EKWUY6hxC9cPrjWoPmOyhYiKrgNYMQlfMV5DdZ9LAXPJvi
         9uuwzaRwlXD7Hc6rxLtLbGrzvMXmk+xrHc2BnfMn4hsODscVzEOaYAN5Q8di/h0WpLop
         LHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vfYzArXzFe1wH00PAKP88fvUR7yXk6kDogWfZQY7lTA=;
        b=akWEQxcnP9STGKVj4pQd2D2FE8VVAQHAg6N+qcFVHzX9vDkSgW4jQlp1QJ9/vRoYSN
         aTk4U1ZfhaVdso56eZY5XusvP44HPyi+mEEAaJ04NPxRYR1sCbooAsZg68CcUn1dMQxr
         x/l3Z01Vi8pr2UBfw2FEagesvZrknWVGzYZOsZ37MVAGFhdtoSjN+70S2Eo+FfHc4fjb
         OdGnvKst6E52gSAQA+uJBFhTswn/I7gLpq6rDhOOpZQnE1GL22K1GRXGyOCpEXYBeIET
         zysNKOUDi2Nzlzdext42srhsjJjuLOzx4gYB04by9IgjeEE0/Xr/Q0l5tMGreBHc0QfH
         7DBg==
X-Gm-Message-State: APjAAAXKv90116Y/7h5k0vq9kum81me4GneiTTo0XuqzM/YfMzK025gB
        eqflG3O/2QJIU/PkZ+Fn7bSkDQ==
X-Google-Smtp-Source: APXvYqzTTbG4XtC1vheXlXVAQTNIpBRl5TtuDzwjqAF7pQc9jQXpsZT8WzIoHznXHiEs80l7njW88w==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr3101252pln.230.1569572892248;
        Fri, 27 Sep 2019 01:28:12 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 6sm2043521pfa.162.2019.09.27.01.28.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 01:28:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     baolin.wang@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwspinlock: u8500_hsem: Use devm_kzalloc() to allocate memory
Date:   Fri, 27 Sep 2019 16:27:42 +0800
Message-Id: <c3070351e137bffd2b4b639fb14b1baa19df5641.1569572448.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569572448.git.baolin.wang@linaro.org>
References: <cover.1569572448.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1569572448.git.baolin.wang@linaro.org>
References: <cover.1569572448.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kzalloc() to allocate memory.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/u8500_hsem.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/hwspinlock/u8500_hsem.c b/drivers/hwspinlock/u8500_hsem.c
index c247a87..0e8d4ff 100644
--- a/drivers/hwspinlock/u8500_hsem.c
+++ b/drivers/hwspinlock/u8500_hsem.c
@@ -106,7 +106,8 @@ static int u8500_hsem_probe(struct platform_device *pdev)
 	/* clear all interrupts */
 	writel(0xFFFF, io_base + HSEM_ICRALL);
 
-	bank = kzalloc(struct_size(bank, lock, num_locks), GFP_KERNEL);
+	bank = devm_kzalloc(&pdev->dev, struct_size(bank, lock, num_locks),
+			    GFP_KERNEL);
 	if (!bank)
 		return -ENOMEM;
 
@@ -120,15 +121,12 @@ static int u8500_hsem_probe(struct platform_device *pdev)
 
 	ret = hwspin_lock_register(bank, &pdev->dev, &u8500_hwspinlock_ops,
 						pdata->base_id, num_locks);
-	if (ret)
-		goto reg_fail;
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
+		return ret;
+	}
 
 	return 0;
-
-reg_fail:
-	pm_runtime_disable(&pdev->dev);
-	kfree(bank);
-	return ret;
 }
 
 static int u8500_hsem_remove(struct platform_device *pdev)
@@ -147,7 +145,6 @@ static int u8500_hsem_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-	kfree(bank);
 
 	return 0;
 }
-- 
1.7.9.5

