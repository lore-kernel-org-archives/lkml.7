Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55ACFA3736
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F42214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KW3BHAnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501988AbfJQKbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:31:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36510 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408887AbfJQKbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:31:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so1380413pfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Dxo5X+E9Ol1EaiMF1ZycTVksoTfNCn6yYqPoCwK1ut0=;
        b=KW3BHAnA3ZG/qmHR83tqDTQoBB/pASsfBUD3L7y/uxYm+ylMPd0OKaWIpb4n0HzS/E
         EYaeSCe6isd90Rcp58Y07VJDgZuK3eHJKMz7kN0aPgb1CVtG2PUQRnIBtgn9h0C+VMHl
         y6luwu9znrRZkMmbDCVZ4LiOF3bn2MYxrDzO/eTQomXyZUOXguHHFeG6RQFxPgekfZ45
         TGnUosAC0nM0oAlfv7cac1ilKsI3ruMycGhZdpGypWfVrt59uIWbTn+9nQSt4VeMQfvx
         zQy1fJJSGruXYt9u6NOfcFgvkIzkFOHEA2j9rjYMv+gWdaHHOSDufQC2DJfYe4+Cc+va
         WhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Dxo5X+E9Ol1EaiMF1ZycTVksoTfNCn6yYqPoCwK1ut0=;
        b=e4Dh+7YuiwhAhIePLCu7w7zv3QyKXoSZpJDhkrnioQW4XcYJidfg+Vcs9FWk/1E5ND
         9fFd+I6/Jhr30gqv+D3rQ0B/65bmp5oQAEnJpT84lA9/kV77dC+eacnLNA5ohveavI2N
         O3KR/AlDQ8T/1R0k37hg/DBK2ZDR+pPwHCfzu1L5YEpx9I/ZxUAcs2eGehG2oNzM1Vab
         Ph+uqKFCSK6IpaogRtX2yO5Ytx2xokXW9QTQdu7/ck+WatNI7k0Aisr2OJ+mXQFyN36W
         j/LH/JQfrZcWqxJc+jZZq3FZC0ZU567m9wmcmvkQaIiCEQuqOgva5Ys4/tjHG0Xd7lSx
         g3cw==
X-Gm-Message-State: APjAAAWGuFaC3eaj7tR5lwjk+kuC5V07D/k0F7peRw+F2lmli7UMfSNR
        N1Mv1rQFpwmQ+SDZ3Wkgx75KHYo1fVoGHw==
X-Google-Smtp-Source: APXvYqytDxsj5uZXimsuRfWTtmIjj/DZcWCzXQPGXBiYqeQJAKKVZ3aGERc7nPIMqHVILSjuTwRtZQ==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr3416921pgb.416.1571308270667;
        Thu, 17 Oct 2019 03:31:10 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id b18sm2153445pfi.157.2019.10.17.03.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 03:31:09 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 3/5] cpufreq: Initialize cpufreq-dt driver earlier
Date:   Thu, 17 Oct 2019 16:00:52 +0530
Message-Id: <9e2bce44ed6bf3aac2354650fc3bf5c43e2155b0.1571307382.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571307382.git.amit.kucheria@linaro.org>
References: <cover.1571307382.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows HW drivers that depend on cpufreq-dt to initialise earlier.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bca8d1f47fd2..3282defe14d4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -180,4 +180,4 @@ static int __init cpufreq_dt_platdev_init(void)
 			       -1, data,
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
-device_initcall(cpufreq_dt_platdev_init);
+core_initcall(cpufreq_dt_platdev_init);
-- 
2.17.1

