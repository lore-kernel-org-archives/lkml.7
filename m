Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2480C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887A420872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYBbB4IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfI0HLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:11:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38380 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfI0HLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:11:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so246085plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 00:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rsM2uCT+H5N8frHAhYZ4xNoIMLY0pUKheXJFFZekhJ0=;
        b=VYBbB4IXZbS8pOxmBk6Ioz1/IWOjHl0aTJCwLhy7YY2HHOvVRG5s4W2aVVxmyEKGfX
         LyxiwbJufXG7RI+4FuFZWzvK5XF6rm9m7oeL04AaxCK21NNiXH0opuZPvcb5XFwiAWmK
         sP6lF52WGe0e4yA3CKvCLEr1edRWQmh6G5HNcjd54Ybe8LkFTluD2Q/f+yN+BBjgCagH
         fANqi+yffexA3CyZIHB3U2vWcaBv6auX4VGErkEpk6i8tpYqwhDTlP7m06erEvBbgiq4
         05La9Vf5EphZxq1KewIV2zUdaK8dJ37ec3+t+tn1fqSM5+IrOsNV8sD8e1zrpTcdacGG
         50PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rsM2uCT+H5N8frHAhYZ4xNoIMLY0pUKheXJFFZekhJ0=;
        b=IymKjfmExOdCazxDxX8Vkbgg+LJjoZI8fezioZqZ9sU6p+lriNwDnrJFIvobPvjXHD
         b865zbwxwRBlyH+RvMhn2kz2GElfksHm0IAzTa3XKY/LhLN9+eVSHhIbihdtMmIGI/f7
         TN8s9DvHoiJiepg6X6PzVOuJpjsialkKCAksuHwPlk0mM8VLr5XEQ43FZCYrAvYoO9R+
         uQt0wvTmUn7N0xJZzjb78qwjZjwHG3HlhvhFIvvbW+4meSyQWLz5bxetyYvd9pUTzpBw
         q4/qUnKAGql9vzO8AhqKBSM0/EJ3ov8W99UP9YpHjhxDWppgkcyRfX/ecTLC93xsgM6I
         6Apw==
X-Gm-Message-State: APjAAAWXt0BEeqhYb97dAMszSQaGewOBH1q3/F1r8/+gzdgO88+sbl94
        XaWRRjel2mfEcJKD4eqrCP4gPQ==
X-Google-Smtp-Source: APXvYqzhHYaiRNX4PqrUbwuBJAKuO6YWZzZccB1OVSU+ypMKAlrqzItHtGxjsUmygED2PC+YfdvsjA==
X-Received: by 2002:a17:902:7886:: with SMTP id q6mr3030571pll.323.1569568281015;
        Fri, 27 Sep 2019 00:11:21 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f74sm1733288pfa.34.2019.09.27.00.11.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 00:11:20 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hwspinlock: sprd: Use devm_add_action_or_reset() for calls to clk_disable_unprepare()
Date:   Fri, 27 Sep 2019 15:10:46 +0800
Message-Id: <03de1c267461a6ac17cf7732404795b2fe735927.1569567749.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569567749.git.baolin.wang@linaro.org>
References: <cover.1569567749.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1569567749.git.baolin.wang@linaro.org>
References: <cover.1569567749.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_add_action_or_reset() for calls to clk_disable_unprepare(),
which can simplify the error handling.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/sprd_hwspinlock.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index d210424..e76c702 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -79,6 +79,13 @@ static void sprd_hwspinlock_relax(struct hwspinlock *lock)
 	.relax = sprd_hwspinlock_relax,
 };
 
+static void sprd_hwspinlock_disable(void *data)
+{
+	struct sprd_hwspinlock_dev *sprd_hwlock = data;
+
+	clk_disable_unprepare(sprd_hwlock->clk);
+}
+
 static int sprd_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct sprd_hwspinlock_dev *sprd_hwlock;
@@ -109,6 +116,14 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&pdev->dev, sprd_hwspinlock_disable,
+				       sprd_hwlock);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to add hwspinlock disable action\n");
+		return ret;
+	}
+
 	/* set the hwspinlock to record user id to identify subsystems */
 	writel(HWSPINLOCK_USER_BITS, sprd_hwlock->base + HWSPINLOCK_RECCTRL);
 
@@ -124,7 +139,6 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 				   &sprd_hwspinlock_ops, 0, SPRD_HWLOCKS_NUM);
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
-		clk_disable_unprepare(sprd_hwlock->clk);
 		return ret;
 	}
 
@@ -137,7 +151,6 @@ static int sprd_hwspinlock_remove(struct platform_device *pdev)
 
 	hwspin_lock_unregister(&sprd_hwlock->bank);
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(sprd_hwlock->clk);
 	return 0;
 }
 
-- 
1.7.9.5

