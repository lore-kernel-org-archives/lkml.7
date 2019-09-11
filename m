Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6785C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB6B2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uAu3IFF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfIKWcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:32:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35646 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbfIKWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:32:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so12288064pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rCgC8Qrm5F0gNSrIs0vFn+72THJYWJ5Zs57TxaytFro=;
        b=uAu3IFF7H4n58zHhmASCIixwb4gEbmqJtpGTmmF7HVJPuloEcVxrhqHsmxgMVu0Xc3
         MR9qPqOcC5Mpz1Kscbp6vse4E4prUvF6A2P2TgBH20yQMocZPth0L35N+4OFswJWTiiS
         aQSGs0wbIg7MU3if4kuGqUq+frQ6peNPr19+hIkBr6vC7XZuz5N8Rx9Eq3lc55a6QKe+
         n2i2q4/inHIe6HrJWm/54cQ7pjHzszN44EL5iuSGKnelBzv0mfiwVPyr4CAYJmj9K9W4
         +6M1RPvmEoMhPqNxEadBR7sSbKhu9ZFSQhD8PfuSbAzehJ3G5I3DWjzDMIS7Erk4C8Uc
         V9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rCgC8Qrm5F0gNSrIs0vFn+72THJYWJ5Zs57TxaytFro=;
        b=pzUD3QhAFnWljAjG6WsnfKKOTgz/j3rJynbMd0piBPZCzkBglGMEQDo7FrC+6Hqut4
         AoA6LArfzW+S8T8Tbb7gE501mwY8kfHK7qlzAFfhl8mnvlPXvyz1+XbzTlmalxwFYjJ/
         5BD9/EZ1XoO/cvh72M3NBEP2kwI3yHDfI3r6iFVplvPbo27otnhYZ+UinH+lfRvhQshW
         OU2vc/GrJ2thETIq57iVWHTwkDOjJXOUzlih5dTNcMymHLt/i8z/k/jZp6asyou99uiW
         5uG+gyl7CXuqY/gCLtogghWc21Q/wbRgQ1rY0WTQDj1YQE3hvdW3OJcbe+ymG/CASVhS
         Fa/A==
X-Gm-Message-State: APjAAAVpJZswBIv4IShXHzs1ro5OPSxq8cFA7PmLaniNS9qXYD7+qmXt
        v/gGJ9vSOHEkb+47M5Zfm5sSIWF2EOZzOQ==
X-Google-Smtp-Source: APXvYqxjHp1AP2HznEflZ+tVWWOn7YNF8jnr1eEJ2vJdV+IzbtqSmn/f2+XvWevzUHetdPPxoCAjEQ==
X-Received: by 2002:a17:90a:ad46:: with SMTP id w6mr8144055pjv.52.1568241170728;
        Wed, 11 Sep 2019 15:32:50 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id p68sm42585690pfp.9.2019.09.11.15.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:32:50 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 3/5] cpufreq: Initialize cpufreq-dt driver earlier
Date:   Thu, 12 Sep 2019 04:02:32 +0530
Message-Id: <23d3ed7edc8b859da8e7640f77cf3028ad5804f3.1568240476.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows HW drivers that depend on cpufreq-dt to initialise earlier.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 03dc4244ab00..12c79c92a2b8 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -175,4 +175,4 @@ static int __init cpufreq_dt_platdev_init(void)
 			       -1, data,
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
-device_initcall(cpufreq_dt_platdev_init);
+core_initcall(cpufreq_dt_platdev_init);
-- 
2.17.1

