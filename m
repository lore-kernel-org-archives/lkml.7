Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66DCC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48DC206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkbArDe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbfDYTzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33136 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbfDYTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so381445pgh.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+iu5H/2lxwy+6+UhJlntqHJob3sHa1BeLPUZsfgVglo=;
        b=OkbArDe8GBSK+syoZHtEW2nXOo3TYWnR5IbxVJcqvp+Hu/YpFDAumLmf4Qk//W7DOb
         7Uf2F/QIJTC+nW7UUCl7WES5yrYW42dwVhCLv4B27nhIxpf+RLF9XtgJs2fdC5H1epBt
         mjjHhXmdj3H1Y5RYWEmX/2MDlJJ8rT5L04+CoipKvEOiz94bX8YXRnsTYteG0TTR9gT/
         7NhoKJGE9qZVvjogVrw1qHaufofv1YONl7m4oOrnP8lgWaek5+uzewS5RPWdSS7Gw3Yl
         mdqNhmgREYO5J2OtOOhFngP82YT+1b/WXHk7gQLu84pK0mrhXsHAHFi8uuo5Tl4n0UyZ
         iBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+iu5H/2lxwy+6+UhJlntqHJob3sHa1BeLPUZsfgVglo=;
        b=DT5+o0l62A3r/ghYSKMGvjHw5GxQ1ovq83EL+xPrP8IJYW/dZi/AiiJc2Z5MTodEWN
         6cv9ffAIvSRegKMDrAa9llSqFtmXrD7NLGiNC8FxxU/yTy7CWiqkvfMWvkaam7m79DpP
         4rY7XnP+f/zkL0ykmgty0dWwUR3kbw8fhyagKmTZrhn9kbJRp8Z5u8VoiiQ4bU2rKnAv
         cXAUVEmvXJfy04lwP8uf0ETsBtJgw923TzTOxCvLeGbTivJixqyWbn01pfYViILXRbRg
         DJKoQjZcDJ+dTgzynd+QC2MECclvIgpF56YmaYe3T6JxW0I9+6kKRssGBergf/E/ZS0p
         WnkA==
X-Gm-Message-State: APjAAAVdXFyc7nKMOjwLD/jU5QM4PS4V3hM1C6fyGHylRMckNCOAjZPC
        JfcfMPHJ+TX8HtD95tXcwHKCYQ==
X-Google-Smtp-Source: APXvYqz3wv/IUn+Ukn1XLSgEEA4crX/xBgY9495UOpvfiES9yh+Y+FmYeAXeGXIDhSlFGeXEc6zbNA==
X-Received: by 2002:a62:1d0d:: with SMTP id d13mr42334756pfd.96.1556222002731;
        Thu, 25 Apr 2019 12:53:22 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/32] coresight: Fix freeing up the coresight connections
Date:   Thu, 25 Apr 2019 13:52:46 -0600
Message-Id: <20190425195310.31562-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

With commit c2c729415b2d2132 ("coresight: platform: Cleanup coresight
connection handling"), we switched to re-using coresight_connections
for the coresight_device. However, that introduced a mismatch in the
alloc/free of the connections. The allocation is made using devm_*,
while we use kfree() to release the memory when a device is released
(even though we don't support this at the moment). Fix this by leaving
it to the automatic freeing of the memory.

Fixes: c2c729415b2d2132 ("coresight: platform: Cleanup coresight connection handling")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 29cef898afba..55204dd47479 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -973,7 +973,6 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	kfree(csdev->conns);
 	kfree(csdev->refcnt);
 	kfree(csdev);
 }
-- 
2.17.1

