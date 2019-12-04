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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408D9C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14698206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgK2xpmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfLDJyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:54:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47084 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfLDJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:54:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so2947695pll.13;
        Wed, 04 Dec 2019 01:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Yr7ow8GTmJkAHzIYaMaQkuIE5TitlU69AapCYxHxDps=;
        b=ZgK2xpmmM4E1oWxKp3+/qAKtBGSlbVVCWrUvmWrSxqA8uCqUkHarbkgrW5pREnEz7q
         rt6GcAQ1G93LP6ZCk+9sS0X5Re1mS5EYwZz1fmK638M6EBGMCv9cnDxTc0SKJJ+RU6mU
         ponjciEPdNGyVa5aeUb2RANsByGMFmPefMO4nY2m3g2P3Tw2MuPTVJmK7Qd1gaAr8eij
         UGPdVhbqPGizjDkxglfo66j3Pcwsk2z9WdRG3wanX+H7HOHJghV+bceEKNdKklhSh4pV
         /g1Tzi1WaH29Nzu1nR0XHmxmNPkLV50GAbW4SIq5WbLALNOaWH+30UkbppuSZ46JSzV7
         rbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Yr7ow8GTmJkAHzIYaMaQkuIE5TitlU69AapCYxHxDps=;
        b=A6d1B+fatywD70XfKF/NltqOK0UDXTrW1W5ePL5bxRqyzlk9TJEg8NcJzmmn5xgnOo
         NUIyNMN6Y3MDjxHS7ON/JAAyCpphLhHbwlfqO31MG0WUlQkfqg+zinPma2mjj3vyi95y
         Dz01iA5SsBoJeMiQ5ERtCa0N8Ckl6pYhgrBA6B6Ew185/7bOFHg0Oe1a9X1af5Ii0buG
         jcaD1Bw/AeNOPlRHAisrkTXng8h1mFZ2bG+r9cq9exT95hFGvVMA+FBeslCyfHpQylA0
         /50IvCfWMSkEtwSjq7hz5v0fJ+SNdopad3fvSTyxWCeloVlaY/qDeGdtZfbbqcdat6qK
         MMRw==
X-Gm-Message-State: APjAAAXf/67Rqe+9aFUcx8Z5gSgxfuhQaBswncwXlQWIZWWnS4q8SIiY
        GkLt9mPNeQnt7vQAExVIoiQ=
X-Google-Smtp-Source: APXvYqy3g3wzo53GR/iSw5diEUdMACLnabPEltuTjdGhFohSu+l6XqI9adpeV2ZgFypPKZYZ2aofYg==
X-Received: by 2002:a17:90a:8a8d:: with SMTP id x13mr2323336pjn.97.1575453259348;
        Wed, 04 Dec 2019 01:54:19 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k101sm5941687pjb.5.2019.12.04.01.54.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 01:54:18 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, baohua@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, baolin.wang7@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwspinlock: sirf: Change to use devm_platform_ioremap_resource()
Date:   Wed,  4 Dec 2019 17:53:31 +0800
Message-Id: <812aba62d4f0c1b460a7fb89b165664dde2795a6.1575452516.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1575452516.git.baolin.wang7@gmail.com>
References: <cover.1575452516.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575452516.git.baolin.wang7@gmail.com>
References: <cover.1575452516.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 1f625cd..8cb5fd4 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -69,9 +69,9 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* retrieve io base */
-	hwspin->io_base = of_iomap(pdev->dev.of_node, 0);
-	if (!hwspin->io_base)
-		return -ENOMEM;
+	hwspin->io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hwspin->io_base))
+		return PTR_ERR(hwspin->io_base);
 
 	for (idx = 0; idx < HW_SPINLOCK_NUMBER; idx++) {
 		hwlock = &hwspin->bank.lock[idx];
@@ -92,7 +92,6 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 
 reg_failed:
 	pm_runtime_disable(&pdev->dev);
-	iounmap(hwspin->io_base);
 
 	return ret;
 }
@@ -110,8 +109,6 @@ static int sirf_hwspinlock_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	iounmap(hwspin->io_base);
-
 	return 0;
 }
 
-- 
1.7.9.5

