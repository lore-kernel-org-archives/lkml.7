Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C266C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 02:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59462054F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 02:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdzZbjEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404947AbfHICb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 22:31:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37610 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbfHICb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 22:31:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so12247335pgp.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMNqVTC61ypu+88qN0eTI1f8hSP5KZE17a9B+Qs+PMw=;
        b=jdzZbjEv1HGQgbPwhfoUEelLmCwVNm7oKg2xTku+3T3d2C+1HpkjpkWFpnrxfeR4N2
         W40UXxyZU0p2lcv1zz2jELuqIZaerygCoJguuwQu0dMEDLsesCRYW3BmBtKrdS9e1mYY
         IVhYzaUvLfXa/KgFxh8bMqIxG5X+Y8QByVIrizejtiFYxqU065gs08u93Z1HpR285MGh
         /6PQMs5j1M0QB6IepHTLIH7JA1Hc0S3Lr2HOXvzbA8fR4lHmU1P2HLMu3+sdXmX+rgKt
         UwQf4bO1S5s9Hxatos5UqPtGR85Wf6BYZqyKn1C1w1//21TrBoD9hBlJx0Nx7fCcUdZg
         gL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bMNqVTC61ypu+88qN0eTI1f8hSP5KZE17a9B+Qs+PMw=;
        b=ORNNOcjAs/wu9+fM5r0HqweNGCftYQJEYB8L9gaNCeZOY7/FOocZ1Y08WRlmb1nHJs
         dP5K+d4KE+Lgz2bEfna9zJOoeglaI9lBQnwBIYx67ypETzRzpHL3zr5fi4YRURsKtoop
         cPw3bAbuCt1mC+ATCAv7/u7Pd5c7Aw7PX543ccYo30bnByF+fMAaUfxRgiynrU6adQUf
         lXQcYrCPZzVmC9wkwVIXDt0Gdt3UDQk4z560Dwheblv/T8ckDaJlnA2f+TZvBkuMpEg7
         Uta4XOlpeVxUWAHI+Iop9KuBWzADdQ7ZWdHhoSaYZJNJgr+cVP22GVpoJzX/nz2sKF10
         jRyw==
X-Gm-Message-State: APjAAAVoc8O1GUU3zyJZ1Tlzt8mBtkF7l8UC2mwMABObggfQJAchO4Fg
        /tQCyOcuUU3uvyj/9ZTh+sIWCA==
X-Google-Smtp-Source: APXvYqxGPCk+7L2t3wh1awq3+I2SX3k9faPUfe81sclEk52lCogdeJYv3C7RfxYp6PJpFiv2mtp3Yw==
X-Received: by 2002:a65:6891:: with SMTP id e17mr15715871pgt.305.1565317885649;
        Thu, 08 Aug 2019 19:31:25 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id l31sm140038368pgm.63.2019.08.08.19.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 19:31:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: dev_pm_qos_update_request() can return 1 on success
Date:   Fri,  9 Aug 2019 08:01:17 +0530
Message-Id: <2b17498122cc3509db4e410cbf6f1d9605f2c70b.1565317865.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_qos_update_request() can return 1 on success, don't treat it as
error.

Fixes: 18c49926c4bf ("cpufreq: Add QoS requests for userspace constraints")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e0ee23895497..2e5ab042abe1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2519,7 +2519,7 @@ static int cpufreq_boost_set_sw(int state)
 		}
 
 		ret = dev_pm_qos_update_request(policy->max_freq_req, policy->max);
-		if (ret)
+		if (ret < 0)
 			break;
 	}
 
-- 
2.21.0.rc0.269.g1a574e7a288b

