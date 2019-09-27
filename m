Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D06BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D342146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9A2VhoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfI0I2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:28:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45156 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfI0I2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:28:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so779222pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nZvAywOUGdc+nGEJgKwNfZF/qVh73K5ZWBaGt6yR3wY=;
        b=g9A2VhoKoQRJQ8A/yxKiLRnba6H4pummdVWULOO9J5NHWXt5KisX96YWWyo1QvzxPp
         UpeqQbf4GpP1ehd/+rQcixZniIXYm0qCyx8tAhvNGMt0HWYdpt458yK1U/fA4F/3DGHM
         MK7AS60vGn54vJKXzjidUoX6MaIA/acYx5Ya8Z92bH0isTldnqytXSrSDm9imHmGX8jh
         L3tAvsTKvYHO8gQ6Zz3FnkS5FHWMEDWed+eScwvqYi6KPhlzIpSrcK1RumZRNOyPp9FY
         TyCty9tp9SwH+sJMcYKdKFs67f6yoEWcBjY7w0R4WgDjpkljQ801OL58ghqXXr2jcebj
         mOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nZvAywOUGdc+nGEJgKwNfZF/qVh73K5ZWBaGt6yR3wY=;
        b=XDDTuQyMIhB/QnBcE7UVHK9EL0+Tn15H+xiaHJsewRFZutSNlIwYne92Som0dr8u2a
         VslafjR+g7G9evet1GkGRqKbiaeu0cLNp2e1V2aWqy23+nRKPhDtVSiu+HgNmRvElwCW
         3OXjDIIAvYCTPTX/lzaTzOgTNyQK9bHAPmoW4NV8DQc7a88UbQyfqp3i+vbrg523Sz/u
         gPBO3tAPtMTsoYplfnfVnd6SP40iO5HKLyIF5pj5aTq4/7sUGzLSA/jC+0Db4ABknDzl
         VbZ/ppItaaAOerIjkpXfKolhjvVHg+8h9Sd/XsKfKLZpV3ZOZO4k7FxrEV5o4F1uUncA
         agZA==
X-Gm-Message-State: APjAAAXdg9xN4NcPTk4qM7blzVDrapsbKhu+NA/RBHUw+QrlKLfIqdUJ
        j9oK/GutcZhO+RXJgKz0yFn3cw==
X-Google-Smtp-Source: APXvYqxYsH15T/gDxZi0i3gJliAlf/e2oUvzKKDi12hmwme2MB2Wn3J+nY/EfRcajagLVlzVyg9RuQ==
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr3218500plr.277.1569572895591;
        Fri, 27 Sep 2019 01:28:15 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 6sm2043521pfa.162.2019.09.27.01.28.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 01:28:14 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     baolin.wang@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwspinlock: u8500_hsem: Use devm_hwspin_lock_register() to register hwlock controller
Date:   Fri, 27 Sep 2019 16:27:43 +0800
Message-Id: <a6b18f17b995bceaf2fc0129866301dd8f46bee4.1569572448.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569572448.git.baolin.wang@linaro.org>
References: <cover.1569572448.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1569572448.git.baolin.wang@linaro.org>
References: <cover.1569572448.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_hwspin_lock_register() to register the hwlock controller instead of
unregistering the hwlock controller explicitly when removing the device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/u8500_hsem.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/hwspinlock/u8500_hsem.c b/drivers/hwspinlock/u8500_hsem.c
index 0e8d4ff..b31141a 100644
--- a/drivers/hwspinlock/u8500_hsem.c
+++ b/drivers/hwspinlock/u8500_hsem.c
@@ -119,8 +119,8 @@ static int u8500_hsem_probe(struct platform_device *pdev)
 	/* no pm needed for HSem but required to comply with hwspilock core */
 	pm_runtime_enable(&pdev->dev);
 
-	ret = hwspin_lock_register(bank, &pdev->dev, &u8500_hwspinlock_ops,
-						pdata->base_id, num_locks);
+	ret = devm_hwspin_lock_register(&pdev->dev, bank, &u8500_hwspinlock_ops,
+					pdata->base_id, num_locks);
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
 		return ret;
@@ -133,17 +133,10 @@ static int u8500_hsem_remove(struct platform_device *pdev)
 {
 	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
 	void __iomem *io_base = bank->lock[0].priv - HSEM_REGISTER_OFFSET;
-	int ret;
 
 	/* clear all interrupts */
 	writel(0xFFFF, io_base + HSEM_ICRALL);
 
-	ret = hwspin_lock_unregister(bank);
-	if (ret) {
-		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
-		return ret;
-	}
-
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
1.7.9.5

