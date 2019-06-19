Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D20C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC142080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hW7YPsFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfFSLgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:36:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33495 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731693AbfFSLf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:35:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so7124124plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUQzhVyRtpgFZ3dw7RfFivV0LNUHPBdYdQyIVdE/RIY=;
        b=hW7YPsFmIXlK9HDgxTOiuPX+zosJRHRsgc+QRGwoFJaBdLDS/iVJg66VZe2k/a0pqO
         1QmfKhYvlh0tt+01cUFwHb7vMdABTqGyxnxGLea9iB0rB7UPyqkCG7QNpmAWWePW4nZ4
         yQX/HVyS9whMijJ97tR/wKPLJbahqV21Cu6g5kaLSZu+dQuqmPLjmNQCifc4YwA9E6Fx
         wUNTYRHB4xwiSOBUhl6Ae5WtWQMAKFjQnoCB5/KIfpb5q54cCnT89YMYMm+jVQiowJcS
         QJx1OcKQyDOWD1rdJ1GvIbvYjz7F9FqpwIOx3q+ZpH8/P8Pgj8oqryzDpbBntQjCqeY2
         hDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUQzhVyRtpgFZ3dw7RfFivV0LNUHPBdYdQyIVdE/RIY=;
        b=hLPmMlXVGPdZ7ujeHCl68ydzYWpM7C48ZhHBZWLAX309GgVoH5J17Uf2Hap5oiHU4I
         y3UT9OQinoTgnNvCwNMWWK+l6G+81JtOW99kFEX4rFE34ZR75N2ddz6WTtDTQHIcYIJy
         BT/FRgbznuMWSrI6ws9Sr1Lu8MQFnQtVGdngRdeKML2UfLBGb4jBdH2DPICPmr3ZWRno
         PLsVpk2xceFsc6hj72ytgKMfRLa7DOUkQ6KPFrIGL+pe9FccFXtc273Kp7Hqy+kzGRyq
         ERGovZbZsAkz3Fv54v5fV/srqn3s7I0TfWyGBku3HcIjMlIerl1JhHLfKNTGbCK4pi8Q
         xBUA==
X-Gm-Message-State: APjAAAX1fjcZ9KxbEWGrrqfj+gVXY12Hn9UfM2kOBzZdiIxdnsdWSmHd
        t3UcWNkCU5wei+yhuEKIjKpK7r4m+Sk=
X-Google-Smtp-Source: APXvYqyDMJptRrnZN7RvnTreAMH752D29+th75+xEu8HIHoScOqpmHLWtxRpCwJYot/QpAFqwGE6Pg==
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr1629125pld.112.1560944156639;
        Wed, 19 Jun 2019 04:35:56 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id i3sm20492174pfo.138.2019.06.19.04.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:35:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] cpufreq: Remove the has_target() check from notifier handler
Date:   Wed, 19 Jun 2019 17:05:39 +0530
Message-Id: <4008d21f166accfb28180eb804cb8ebda6da4f4d.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560944014.git.viresh.kumar@linaro.org>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_notify_transition() is only called for has_target() type driver
and not for set_policy type, and the check is simply redundant. Remove
it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e59194c2c613..41ac701e324f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -359,7 +359,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		 * which is not equal to what the cpufreq core thinks is
 		 * "old frequency".
 		 */
-		if (has_target() && policy->cur && policy->cur != freqs->old) {
+		if (policy->cur && policy->cur != freqs->old) {
 			pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n",
 				 freqs->old, policy->cur);
 			freqs->old = policy->cur;
-- 
2.21.0.rc0.269.g1a574e7a288b

