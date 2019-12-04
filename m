Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20980C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7955206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqEjAqBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLDJy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:54:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34730 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfLDJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:54:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so3140563pgf.1;
        Wed, 04 Dec 2019 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lK0hzpi7lOKx/+vwwnIUmfL08coFZ79d+GQbKJpzbuw=;
        b=CqEjAqBZI2DYUBa0fTauRtHIY9p7Cyi3RlaTmg430JUBYj9ae2a90oUMiq04AsaKEb
         FJ/CvBZHMW0we9ND+ppTbh7a8jhOz8Ce6oowvzKhqXBTYcof1eDT4TYvV1G14vfnU+oF
         jWagkHpYSNVBn0HFZNE778WdHRIYPIlM+zUQScXvOKqTc0LHMnjd+rP6uT/B5i6b6Rhx
         vMlG2tNtuQ6idKDd4XOKTw2O42qnCff69KiICKuapSSsFi/5VciM+9Q1nVq5ui1yrKUg
         D9hy4Ir9b3g/x/F8rpLcOagASOykjRa8emkQGiy02pA7bc+cTS9mGUHt8pcCXl1ZztgS
         sydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lK0hzpi7lOKx/+vwwnIUmfL08coFZ79d+GQbKJpzbuw=;
        b=Ur8sqivKB/M90qi4hWl7An6s9a+ZJjXsqzTPh4dgyL5jXCrHxnGStG8dK0B9EjdggB
         jUJGE7+bEQjJhDhiyb4WdLMaaYcmvBJIzLX0uQQ86YnWoUmIfrid8mfkN+t7mu1m+Uh6
         mFNhuZfZvDpaVwgiIejWOApDiabhNgwrhiLp33nKSRBUCVhkc98NaKN5FC1N0kAgM2XH
         8j5UzDUIBKIj7aPUxJrCoRaUdvw16NcPquIQlyimQJsUsVmuyk132sIiKwOMx0Yvvt23
         HoB4tMA4qZtbkLlwLcqXrhiLODASZtgOPlFC7WNmmLLvr4TFE6WI/KEngJ0U76aON23t
         NWAw==
X-Gm-Message-State: APjAAAWwWj3TagBi0Oj3sKskmpyxLLk6nnytkfnhgdwfF4vrUDkR6kMQ
        8/OxbRwPleWTtEJ0s6b6BKg=
X-Google-Smtp-Source: APXvYqwj9EAIod5rI0TjevWy7FOFw+DSgYt6tnRhZdS6CK05vlUb7uUJci/Lp8NvAuIprbHSMdUe1Q==
X-Received: by 2002:a63:7d6:: with SMTP id 205mr2613550pgh.131.1575453264820;
        Wed, 04 Dec 2019 01:54:24 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k101sm5941687pjb.5.2019.12.04.01.54.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 01:54:24 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, baohua@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, baolin.wang7@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwspinlock: sirf: Use devm_hwspin_lock_register() to register hwlock controller
Date:   Wed,  4 Dec 2019 17:53:33 +0800
Message-Id: <caedf84ddfe1d552af78ad84c6effc792838b1fa.1575452516.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1575452516.git.baolin.wang7@gmail.com>
References: <cover.1575452516.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575452516.git.baolin.wang7@gmail.com>
References: <cover.1575452516.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_hwspin_lock_register() to register the hwlock controller instead of
unregistering the hwlock controller explicitly when removing the device.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index d62462e..823d3c4 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -79,23 +79,9 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hwspin);
 
-	return hwspin_lock_register(&hwspin->bank, &pdev->dev,
-				    &sirf_hwspinlock_ops, 0,
-				    HW_SPINLOCK_NUMBER);
-}
-
-static int sirf_hwspinlock_remove(struct platform_device *pdev)
-{
-	struct sirf_hwspinlock *hwspin = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = hwspin_lock_unregister(&hwspin->bank);
-	if (ret) {
-		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
-		return ret;
-	}
-
-	return 0;
+	return devm_hwspin_lock_register(&pdev->dev, &hwspin->bank,
+					 &sirf_hwspinlock_ops, 0,
+					 HW_SPINLOCK_NUMBER);
 }
 
 static const struct of_device_id sirf_hwpinlock_ids[] = {
@@ -106,7 +92,6 @@ static int sirf_hwspinlock_remove(struct platform_device *pdev)
 
 static struct platform_driver sirf_hwspinlock_driver = {
 	.probe = sirf_hwspinlock_probe,
-	.remove = sirf_hwspinlock_remove,
 	.driver = {
 		.name = "atlas7_hwspinlock",
 		.of_match_table = of_match_ptr(sirf_hwpinlock_ids),
-- 
1.7.9.5

