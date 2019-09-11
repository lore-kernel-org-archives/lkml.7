Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C142C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604B3208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIqmRKYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfIKWdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:33:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42833 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfIKWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:32:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so709061pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eHfwVmwRPrvBBQCHCMtELR2XIT6WK3JZDo6MrEMP+JI=;
        b=iIqmRKYbvavAa/xuuU8kPkn7fxW5tBdl+m37NywaOZtqPeAc9v+0vQMv1An+TbS/lq
         h2h/lvNN7VuQCP5dJHAqjPqeE84W7DrbhAXAPa7fOnwH4R9zJCBhJcpU2a7J9weR7se0
         hEZVIg+idKp6P3t3UXVpLxNPkhdMK61ihXOBWZUTZew9Bbo4OYl6lYRkaVfAPVTutAxH
         eQZS0sGdSY+f2lYxtZWKCQt0ptOk112EhKPbLjHY0UUgyM4Dab/lcE2Ye51VrQVmmeUv
         ehGxPIHQpkPl2H0jFp3cQpp0pCy3SJodRf64SQUKKyI6xZ8y/JLjVXSIV7XDFh9HHj2Y
         QQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eHfwVmwRPrvBBQCHCMtELR2XIT6WK3JZDo6MrEMP+JI=;
        b=CcNv0AuGPBC26e7sUYFqn4pz1EulAACb1HgNd46LMs+WeQkZ2YGB9+ZJsnSn8xGOdb
         XZHZgOsEcl96B3i7E6kYCJFmAODEcnHA+/uO21D9AYPCfrIL0+sIEY01ma51ctm5KMTn
         j2nwrwXj11NEahMJZUdB71hD6bhtHKeQF37DznmzB7JRwBVWmu+9OriYuvGuG/z1PV0D
         uum4HK4IRukQBLYfCK6GQJrwV1wf2UD0Ug723MtSK7+PtKLgxXHPFSsW+uJxOshxCbCc
         t+ZY1uXMGbh1OlRKBjt1bbXU+zpDBOQLUbj8Gl6wB85X81e4sT3SGyDWRdQwKeN8vtAB
         vZQQ==
X-Gm-Message-State: APjAAAXy6MwQeMS/39FnN/SolhC2tLRKkWThrXtF7QOx7aLdFbv5QT7O
        l1BQVvDpVP+L23gVh66HlnVVhxJfuG1kKA==
X-Google-Smtp-Source: APXvYqwXpm2pHm8jH8I/tTmio2/EH4EjPAWMxPZdHsmxvodKvWV4WrJTmQONqaYs2sPtqqMgcPT8dw==
X-Received: by 2002:a17:90a:af8d:: with SMTP id w13mr5333319pjq.141.1568241178117;
        Wed, 11 Sep 2019 15:32:58 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id t8sm3431343pjq.30.2019.09.11.15.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:32:57 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
Date:   Thu, 12 Sep 2019 04:02:34 +0530
Message-Id: <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568240476.git.amit.kucheria@linaro.org>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow qcom-hw driver to initialise right after the cpufreq and thermal
subsystems are initialised in core_initcall so we get earlier access to
thermal mitigation.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 4b0b50403901..04676cc82ba6 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -327,7 +327,7 @@ static int __init qcom_cpufreq_hw_init(void)
 {
 	return platform_driver_register(&qcom_cpufreq_hw_driver);
 }
-device_initcall(qcom_cpufreq_hw_init);
+postcore_initcall(qcom_cpufreq_hw_init);
 
 static void __exit qcom_cpufreq_hw_exit(void)
 {
-- 
2.17.1

