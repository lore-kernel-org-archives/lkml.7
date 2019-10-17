Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED60FA3737
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04132089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egK4qvYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502369AbfJQM2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:28:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45478 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502359AbfJQM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:28:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so1262942pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Dxo5X+E9Ol1EaiMF1ZycTVksoTfNCn6yYqPoCwK1ut0=;
        b=egK4qvYjE7EBixFsyZw/Kr078NfjAaHkhTpbfmT1U8TUKYQS3TWhZar7iJge8A07DK
         sU5cpQuotBcsaO4hCkFmOhPY4FbwLuQQd5m0yXzMcvo+Z69ZOXqN3BdJr2IRKQYu7vCp
         K9ScS/0a9YyM8Tbd2gkLDTPN/49QzDpGta13xl6ZRzPqnGn3vmMwJQHkR4SYu1b198ho
         KdjwHZKZZwzew3KwyZ4tYS3rNUjoJBb7eAcf+PRl70qDYOzmOMpzxBKtUDNX4wnNYRNB
         DmtCOTZLc81gvkP/WIFXEi6syWHVXvfPUG9JjfK3ScoMSMcs3xwFeFyeyUgAULQ653oh
         693Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Dxo5X+E9Ol1EaiMF1ZycTVksoTfNCn6yYqPoCwK1ut0=;
        b=ZBIIjsMYAbNdcRbME1aBwOeRfwr3mSxHBB2Z7gCa+iNZ7+tJIPPA1J3egqQtDDJ4NA
         5fZpMltXcgxYv4dvklW3U28FC17K+9KsUwg2s2r8Bdr0EVcJN47irZl/3/ZPGt27+wx+
         1r6oesK75hZ6QJzQzm0uFnpiFNZ7g+aaad/FGvi3FDAvbtevlP/aPXo5ejP55Qa7/hLM
         R1kM4TmISyajUISKtkfRIIK59bvY2OT1VpAO0JL/2ToOTAISd6JTPf9v6ix3vMQBX9lV
         VNeow9G64Nhi/BNTYUsNPiajXkgLRtTqyA/8zI4TzPBjBhPU8/NfQDQ8RFBchPbthmff
         zC+Q==
X-Gm-Message-State: APjAAAXaJy/pQskOaB+2NeRQDyY4Z4x0Cj2bYfNaVjSFiZcvJlJNl3db
        FXCgy6s15RT9dWvMj/2nlF1yt42QqPYxRg==
X-Google-Smtp-Source: APXvYqzGLzD52zmSKxtJBG7Fgaht2Hci65RkrcVoI3J604NgxX1LNv5xLN76oaaOe048MuUDrfH3EQ==
X-Received: by 2002:a65:689a:: with SMTP id e26mr3852060pgt.346.1571315279010;
        Thu, 17 Oct 2019 05:27:59 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id 207sm2692918pfu.129.2019.10.17.05.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:27:58 -0700 (PDT)
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
Subject: [PATCH v3 4/6] cpufreq: Initialize cpufreq-dt driver earlier
Date:   Thu, 17 Oct 2019 17:57:36 +0530
Message-Id: <9e2bce44ed6bf3aac2354650fc3bf5c43e2155b0.1571314830.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
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

