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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DD8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A51206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYYWZsJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLDJcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:32:18 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:44425 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLDJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:32:15 -0500
Received: by mail-pj1-f67.google.com with SMTP id w5so2746321pjh.11;
        Wed, 04 Dec 2019 01:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4bkpUfs7eIWG8ngSeP18jBoFZdQNW5P5Kn+adde7u5o=;
        b=aYYWZsJigk7358H8li+5bb4cvWZCvwhyy4sUdYUnIAHpojjw3tNOQ9f5pypQx0brQ4
         rpMwoGcO/53e6RSpPMK1en7HhLg0/tAwYf2MW5zdDfEJbbBrfwrORJmCUWOrwShXNTAG
         cpcQDN4fzFvlRsC67VO1wchoC214EttAXitoEIifRJUAIazP/Ua8EQKy4QaDDfWcdgwC
         QZzrk4RXjMoVXicnO3VqVnjUINB8HTQW8rbTK8kNDOWOfNFb++aBEF63ZmvY8tD82jkt
         CJ2ssKj31iDhPNkSaidt9KIz3UGO/RIhEAmONSo45G2ZPWUUGIiLOXXUHySSi4b/bwYR
         cLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4bkpUfs7eIWG8ngSeP18jBoFZdQNW5P5Kn+adde7u5o=;
        b=NKhZiPiCeABReBQREIDLsa+iNoQG8XTH/t6yj4gTmnV2a7CSft/LEqry8LM2QSlzrq
         zssQ/3jO55e2SJlatFCHISCCZtF9cyDdnFl8ycaYYmKfY+dH8+xKlvJkIMlqwd3mPTua
         Rnpal77JuOwGtHnXCpOou1DEWhpXDdzGctLbQJJraGs4wRiH8Fu2el1e6L45wtFvhnwQ
         bmRkeuYdA4y6qRJws0Jq/bS8oHhd0QaZc4k1IwSv85ee+nfpBroWhxHmT8+c8vXoq2DX
         a/y6yuC8f8B5mKab4t4k6aGgw4YjjSRjkwijaQjYFBJB5RGvwB4FgLw95V8qQBfIqz5P
         PaJg==
X-Gm-Message-State: APjAAAUgCLDQl+hU9MN3lYBq7w0J5P1hS+/OwFuyah3HjjHCvn5sn+B2
        22aXulkHJQew1W8uf+R/1FA=
X-Google-Smtp-Source: APXvYqwT1ol0b99BpJDvAiJGyCk7qvZShzlpOcFA6BtctrrvhieJ4pPjR1v6PMqf3Ibkk+CDNv/wVg==
X-Received: by 2002:a17:90a:77c8:: with SMTP id e8mr2186745pjs.83.1575451934861;
        Wed, 04 Dec 2019 01:32:14 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 91sm2380086pjq.18.2019.12.04.01.32.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 01:32:14 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     baolin.wang7@gmail.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwspinlock: omap: Use devm_kzalloc() to allocate memory
Date:   Wed,  4 Dec 2019 17:31:30 +0800
Message-Id: <a6611d028d9e48a3da967277ace31a5e7676e797.1575451463.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1575451463.git.baolin.wang7@gmail.com>
References: <cover.1575451463.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575451463.git.baolin.wang7@gmail.com>
References: <cover.1575451463.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kzalloc() to allocate memory, which can simplify the error
handling.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/omap_hwspinlock.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index dbb1a4c..3b05560 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -119,7 +119,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 
 	num_locks = i * 32; /* actual number of locks in this device */
 
-	bank = kzalloc(struct_size(bank, lock, num_locks), GFP_KERNEL);
+	bank = devm_kzalloc(&pdev->dev, struct_size(bank, lock, num_locks),
+			    GFP_KERNEL);
 	if (!bank) {
 		ret = -ENOMEM;
 		goto runtime_err;
@@ -133,15 +134,13 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
 						base_id, num_locks);
 	if (ret)
-		goto reg_fail;
+		goto runtime_err;
 
 	dev_dbg(&pdev->dev, "Registered %d locks with HwSpinlock core\n",
 		num_locks);
 
 	return 0;
 
-reg_fail:
-	kfree(bank);
 runtime_err:
 	pm_runtime_disable(&pdev->dev);
 	return ret;
@@ -159,7 +158,6 @@ static int omap_hwspinlock_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
-	kfree(bank);
 
 	return 0;
 }
-- 
1.7.9.5

