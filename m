Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF3ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7077205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sS7o7iqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfJUMPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:15:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33383 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfJUMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:15:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so8352820pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FyfRV5Js9+leUaktEVHjzJNcbnyCVZmNmn0rQoEZsq8=;
        b=sS7o7iqs+RScyt6BaNZLIHcYIvEhJBzm7BJzVTX38JcWinbzToZ3aJ5g9oqzVF6+LA
         pQKXXkGuulQiZqNUINoLALWG17assWoUELh6fWzIh/rgY8oufCDbqAqSPPFYuaMrRoCJ
         zMf8Rf2YFIkiY3PAL4K1+UaQ1lOxuO39kCeF6/eV9yyNt1zvc+ElEWiQT9jhtWtWm8+f
         ittQeVB8GHx5bZtd372Di6jzjY/sBJQB5v1gBtU8T0phCcDpGFasEJ7mtIjf33oQV84m
         ijB5jkjTmzw4ey3nhVsYg200l/pNeOnk9DIUPSf2yrkqE4Nn1EXptze6w7LvBo1+xQPc
         frow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FyfRV5Js9+leUaktEVHjzJNcbnyCVZmNmn0rQoEZsq8=;
        b=qjY64gHp1IWtl1RAHdxqwiznTZDiIXlyJyhMLh0mAD052ToQMa4vIeP0VTKTBTw4fz
         15utMc4rvhZ39zKa3pIuWkZLGP5EaYxS6WWn/EIxLwYM5t5PQZtLLLj5Y4TsRgcxyaRc
         yU28H5YJlWVYeFmTyfKpcorO4g1nyvYdMYyKuQm/kVYAeCRoi3/2UMstgW+Zl6bB3pjq
         DW8c2sroPYj88+O9+7m8UaO6g9oVnontk0OdVG6Ka4yUo4BPAGld6JHMvYHfmom37V/k
         XbqzKhMVAEbGwvDhGpdWM/o2ptProVlhjVQUGrQu7/RqjRpz9FO1BiPnM1OUk6j/nydn
         ot8w==
X-Gm-Message-State: APjAAAUSLfu3A6TRdew5I99mTRqKGP+GGJ4OfYbhKOtFQLmHrWRGN8m+
        QXPjtGbuI6kQkVQNhdhRnF/dygsjzeLhHQ==
X-Google-Smtp-Source: APXvYqw5PBkD1utYutUy6zvkffZmPfQ/KetF+YXD6Io7HIuCYrta9vEtYPa8mkg2wYcbkc+A22Qy0A==
X-Received: by 2002:a65:68c3:: with SMTP id k3mr5280332pgt.247.1571660139404;
        Mon, 21 Oct 2019 05:15:39 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id 127sm15132523pfy.56.2019.10.21.05.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 05:15:38 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-clk@vger.kernel.org
Subject: [PATCH v5 5/6] clk: qcom: Initialize clock drivers earlier
Date:   Mon, 21 Oct 2019 17:45:14 +0530
Message-Id: <75ae9c3a1c0e69b95818c6ffe7181fdeaaf2d70e.1571656015.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the clock drivers on sdm845 and qcs404 in core_initcall so we
can have earlier access to cpufreq during booting.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c   | 2 +-
 drivers/clk/qcom/gcc-qcs404.c | 2 +-
 drivers/clk/qcom/gcc-sdm845.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 96a36f6ff667d..20d4258f125b9 100644
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
index bd32212f37e64..9b0c4ce2ef4ec 100644
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
index 95be125c3bddf..49dcff1af2db1 100644
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

