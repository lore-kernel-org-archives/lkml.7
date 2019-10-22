Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE200CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F67821783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxMNbwKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfJVKSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:18:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37342 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbfJVKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:18:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so10358667pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpkkrItQ+QjSSXD1R7+2N7PNQALjVcaxdlDmgQHtPgg=;
        b=wxMNbwKNAg8unVy4Cmds8Y8rrdJW1Z1gcgp6tTY6kM95cEY36ArDfsIgK+Y2Jdq59T
         Cng5f1tYOjcoF9LcXV6lZjlbK8jZMEaqxzu8N/7BWcRXrmFyFrbR8+aEIWoHoHmwaB6Y
         bSIvhA6jGg0xOoeOpSZSbenFJRa+6oe+xdWVXY5hq9ohDZFDBHJAIndIax1UKZJ/goh1
         igUNe0mMij128BRtJjS7101BcDstkxo9OZJWIcTBpYr3XOT+le4jUomGT7EWXZuBfvAB
         7g+cWJpwZM70TmEx3crq0dmzvT58vZvbC4R26e3gdKYfQw1vBMw0Ki8LgUTMu/3T3oaG
         WtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpkkrItQ+QjSSXD1R7+2N7PNQALjVcaxdlDmgQHtPgg=;
        b=mIeo8v8CPnFaykKuDm+ILeHkvk5/5MaEUDcA2OF+Z46aRGhW8SUJc4Q187KQH8oJ13
         3Zu50GYyVpKgJNWRuksIl84to59jBZL6v31gpQQfgd6qrSmA1jfB388dLEKh9f1uZH0V
         5X9ZPFCyd2ZOJTzm2mJK4YUx6U4iLBDAKSVVA0xv57hogXjEEIvBYr0AehNTn1yT4E4o
         DZapZ274wDqy7kdVxVtnqp98TcJvfAbT96lgEAXx/OZJTWjRhu9z8LfFJ4d0yr9GkP2w
         vC3IUyUKcIDfM22ATAVrCxgMSx9lQNirsuJaeS7xUO9c88wr7wwuz5hVPxgfRYDHxeMH
         /Isw==
X-Gm-Message-State: APjAAAWK7IsQuwZTAIQlrz/j+h68p5XSTHxMg96ptfcFuh4qoQExepR7
        29MfMk4tqWjDAef4ogjU1Y9A2Q==
X-Google-Smtp-Source: APXvYqxxS7C5M1bbbiLvBiO65w9OYYjtwGCoFToXiUXy0Muvbi4jLCDYUlfsuwKf5/QZLrpWlV3j5g==
X-Received: by 2002:aa7:8ece:: with SMTP id b14mr3399428pfr.205.1571739482892;
        Tue, 22 Oct 2019 03:18:02 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id q143sm19247365pfq.103.2019.10.22.03.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:18:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Clarify the comment in cpufreq_set_policy()
Date:   Tue, 22 Oct 2019 15:47:57 +0530
Message-Id: <ec3e8e001b35c9244f6406932335d7156b611373.1571739473.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the responsibility of the ->verify() callback is to make sure
that the policy's min frequency is <= max frequency as this isn't
guaranteed by the QoS framework which gave us those values.

Update the comment in cpufreq_set_policy() to clarify that.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2e698b5f0f80..b4b5f11c2f1e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2384,7 +2384,10 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 	new_policy->min = freq_qos_read_value(&policy->constraints, FREQ_QOS_MIN);
 	new_policy->max = freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX);
 
-	/* verify the cpu speed can be set within this limit */
+	/*
+	 * Verify that the cpu speed can be set within this limit and make sure
+	 * min <= max.
+	 */
 	ret = cpufreq_driver->verify(new_policy);
 	if (ret)
 		return ret;
-- 
2.21.0.rc0.269.g1a574e7a288b

