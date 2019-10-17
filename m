Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEC1ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C444E2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9hgU7NH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393680AbfJQM2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:28:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40238 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406227AbfJQM2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:28:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id e13so1275126pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yAYxsDoF1xODxjQtRc8reB4aVCGjGyEgdApmFBnl6Wc=;
        b=k9hgU7NHph1qugDb4UYF1VcEpVVzTOUeZX+19VID6ZcwkAdvKbRfvm/jXaLFkFtFL7
         Z5LgfHWmMv+oA1SvgK8tZ095jKiFqZ63kU8dXbAXxEaplEIGfTO5Ef6VNW+jWzD+D4O2
         q1BqPUK3KoV2Sp87Ha4ePXWPvRky1jMljuordFeWKJagkqzLLWMf/85OmP7OVbG7mC/y
         bbL9jJj3+IUrcBN/OVP167HGInDbjXqZfoSqzXYiBn8OzM7aYgjriAkydjZ5xLGuHfCK
         T+mHRMhSUS98vkShSgrwXfs8KuSG4OzIiVLft2C9h+z6aqoWYko65JWjC4rvpjM6SJO4
         KIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yAYxsDoF1xODxjQtRc8reB4aVCGjGyEgdApmFBnl6Wc=;
        b=f+NQoIbQ9NVKpF2wB/J8am9ctKfFw4pY4kKx6cS8Kr4U4e7ahTgfkzf91CK/UAE/GM
         w5H0cwcHYO1GKvMSdLMr3Xj9j473VoNMaRm3bPjSSiJC4EhPW0/4GipBg2xX7VzPUxgM
         ajKh+w36+SeOgQemyfENP31KN0FJ//5oLjifSq0xSMH5wLGtI8ytnJ8W0RajQvt//8UZ
         CghPQgG2H+YRF6nVaNZq9quJPqcp8jmOO6BiaL26D99xs3HEkAsOJTtEXajdEzGZEGmr
         Fa9gslcJ4P/eAuEZEzXzG7Kgx6k/jGjOoUHo75lAj6xqagoDzGRzb7pAruSVzhec6Tzi
         qMig==
X-Gm-Message-State: APjAAAWEDJFnfkp9d4eEwI1GkC6n8k5QI8RK7iLJkPf7eTATAwFSCzPM
        z7Y2S5FrMrvkjwOq/ZHXycCYShLKltg74w==
X-Google-Smtp-Source: APXvYqxaZh8/ei0rPhsoRdu1VBjPfaM2CXh2uqx/mMhcODGqPoZ2pD9tiWHEa37Y2f+Z63fPGhU8rw==
X-Received: by 2002:a63:2dc1:: with SMTP id t184mr3823889pgt.196.1571315282768;
        Thu, 17 Oct 2019 05:28:02 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id y7sm3033120pfn.142.2019.10.17.05.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:28:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-clk@vger.kernel.org
Subject: [PATCH v3 5/6] clk: qcom: Initialise clock drivers earlier
Date:   Thu, 17 Oct 2019 17:57:37 +0530
Message-Id: <5f1ca3bfc45e268f7f9f6e091ba13b8103fb4304.1571314830.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the clock drivers on sdm845 and qcs404 in core_initcall so we
can have earlier access to cpufreq during booting.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c   | 2 +-
 drivers/clk/qcom/gcc-qcs404.c | 2 +-
 drivers/clk/qcom/gcc-sdm845.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 96a36f6ff667..20d4258f125b 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -487,7 +487,7 @@ static int __init clk_rpmh_init(void)
 {
 	return platform_driver_register(&clk_rpmh_driver);
 }
-subsys_initcall(clk_rpmh_init);
+core_initcall(clk_rpmh_init);
 
 static void __exit clk_rpmh_exit(void)
 {
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index bd32212f37e6..9b0c4ce2ef4e 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2855,7 +2855,7 @@ static int __init gcc_qcs404_init(void)
 {
 	return platform_driver_register(&gcc_qcs404_driver);
 }
-subsys_initcall(gcc_qcs404_init);
+core_initcall(gcc_qcs404_init);
 
 static void __exit gcc_qcs404_exit(void)
 {
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 95be125c3bdd..49dcff1af2db 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3628,7 +3628,7 @@ static int __init gcc_sdm845_init(void)
 {
 	return platform_driver_register(&gcc_sdm845_driver);
 }
-subsys_initcall(gcc_sdm845_init);
+core_initcall(gcc_sdm845_init);
 
 static void __exit gcc_sdm845_exit(void)
 {
-- 
2.17.1

