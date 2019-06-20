Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE661C48BE0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C813F21537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlHwhEeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfFTDGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:06:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33213 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbfFTDGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:06:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so162199pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 20:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V98tUwwV6g6TL0oXF4qejJSzRWuC3JVirQic0+jf+LQ=;
        b=mlHwhEeSUqJF17X4t3Ni9g83PNe8Y5jIUjeDUaIW+0wc1+yy+t6cg8koZ2zwd8tSlT
         V3vDuVK0+Rn83OifBrN6paB0Z4AurjNPXWFMaYP+FfqotIVynyr6uy6p0HEUMOcB9cyq
         K/4geXzoVLMdjzwsCaiAngcZZ/71nwDJSpVMmWqYFS5Bd+B69GlNrYkn+zjR4WJ+2n9R
         l3k8DvZTKsdTL6fjpLP8Vvr2XLwVNr8oaL8KwqeAl8miWVfiMD/YclntsbDo7Cu4A3J0
         jQ5y+QTSTjL/RI5SCRBfBj6U6+lNxH2l9kOXB2eSw4SCkIYrnQdMH2hQh/y9bomIaTZ6
         sQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V98tUwwV6g6TL0oXF4qejJSzRWuC3JVirQic0+jf+LQ=;
        b=VuodrIFfpSXOk4sabUSIpJ63EG0wHzv80LiyAmwHshDgsB69OPBl/fqIUPYwvatDUj
         eHEwFZ/ntp/Gbw6uUE+iydsyS2Aa9JqZdhq2ffn8gikPvA2CBMsCKYtU0Iu5Crdipt9O
         3dAlfCl0/A629z50bh+owqZDgPeTDcfGYaX9dmiubuzjkJs2Z/B44U5L1EccHss6Gutz
         0NQTbmT8vpInVwke8S0Trfs9K7/kgL/lB1pI2l2LnGvkjMJjk+Jqi+EhVrduKwNo5aRp
         NWGmzRuW6ZGjTf06wemaniXwo97wxLEeTb5eVrkseHGTeonT11pNHhNvAEvqkd4ioumP
         BmaA==
X-Gm-Message-State: APjAAAXZ0Zc2TCntSJiVMT5EA8pdXHgW+A69aUoPnoC4MlQe5FP+eO/Y
        iDpNlcXhqEuYUmku6AXbiimk+BY1+PI=
X-Google-Smtp-Source: APXvYqyFe2XxI+QiBEDINmZXWdMAk2I0sa9y7G/GFHsXNqjmdZo6NTSGyBO8qHHU6VvwmqkIisH2KA==
X-Received: by 2002:a17:90a:3210:: with SMTP id k16mr593435pjb.13.1560999989797;
        Wed, 19 Jun 2019 20:06:29 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id d6sm18066742pgv.4.2019.06.19.20.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 20:06:29 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] cpufreq: Use has_target() instead of !setpolicy
Date:   Thu, 20 Jun 2019 08:35:48 +0530
Message-Id: <56d8e01d8febb81917aded319249145fdc73daec.1560999838.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For code consistency, use has_target() instead of !setpolicy everywhere,
as it is already done at several places. Maybe we should also use
"!has_target()" instead of "cpufreq_driver->setpolicy" where we need to
check if the driver supports setpolicy, so to use only one expression
for this kind of differentiation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 41ac701e324f..5f5c7a516c74 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -632,7 +632,7 @@ static int cpufreq_parse_policy(char *str_governor,
 }
 
 /**
- * cpufreq_parse_governor - parse a governor string only for !setpolicy
+ * cpufreq_parse_governor - parse a governor string only for has_target()
  */
 static int cpufreq_parse_governor(char *str_governor,
 				  struct cpufreq_policy *policy)
@@ -1301,7 +1301,7 @@ static int cpufreq_online(unsigned int cpu)
 		policy->max = policy->user_policy.max;
 	}
 
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
+	if (cpufreq_driver->get && has_target()) {
 		policy->cur = cpufreq_driver->get(policy->cpu);
 		if (!policy->cur) {
 			pr_err("%s: ->get() failed\n", __func__);
@@ -2401,7 +2401,7 @@ void cpufreq_update_policy(unsigned int cpu)
 	 * BIOS might change freq behind our back
 	 * -> ask driver for current freq and notify governors about a change
 	 */
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy &&
+	if (cpufreq_driver->get && has_target() &&
 	    (cpufreq_suspended || WARN_ON(!cpufreq_update_current_freq(policy))))
 		goto unlock;
 
-- 
2.21.0.rc0.269.g1a574e7a288b

