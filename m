Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0226C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B049620656
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2KTRy+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfDYJEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:04:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38531 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfDYJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:04:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id v1so4456022lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wzmNVY0MlNQoNKUiuFMitPMY1YZ/UR3X4yK7u+qVxVk=;
        b=A2KTRy+UTjfFd6veJikGx+mAUNWRwrabYPXJSq0/v4iJK3R2oiqxGAkZNOydnxTg9w
         tw1lnJBBGtW5bXKza56jkpnosPgGqY0VRU7lYp+Gm7PWF0gkJ3s//k5r+seLl9U3FOp7
         W4n3veKjXDH+OwuSS8DNc41UC42eOdfT2EoWJA39ky+yMOe1atsVWy+yT6Nx5fC3ZcbM
         RZNY7K2SSnY8kzITh0pniHbFQvxp5wYL6xcds5xDhQtAol+LWvaRW3RNcx2lIkpNdY6K
         IwWLXk+4yIBe4yKQmqGbrYq962cxUxnYSUNbkoGY9kOcyMPqnlUTVQwCSQkPDF6+KYYf
         c2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wzmNVY0MlNQoNKUiuFMitPMY1YZ/UR3X4yK7u+qVxVk=;
        b=L1CVUnNVKtIS/nl4V1CUP0UZ0Jnoq9pPT+GNvwBZAq8SvQWinW5pJAEKez/ah6RTTo
         lmrCAP/4fQG1MziZXw/Nberq/ANBbwDOv34203KFfJD6ZhbevOcrrV0nNyYzHqN37vC3
         JR9TAZoH4LmtYo/3HBpHo1KcVJcLiTrxDABKdYCaUvN+3jjWmfCnSQkMcULBkIWxDCly
         kp3R6Or8Ogi2I51osVyzFTPmqoY/T73DJzkN1MMkrlq21ggCC/jXAA1/GH+6L0zzZ78q
         ts9ZbNBof8f09CaG8LDTUyCsp/C1ocvJPf6MaOthDJiYSqV1YDbTybjp2wPZlQ5Kxa22
         8uPw==
X-Gm-Message-State: APjAAAUkebJIe22iIqbQcCvksxi7RR4QCxmmdoE+JjknFcJ0OEVpHUA6
        PgDVoK9mhNjILHbYmrIBF2HcqA==
X-Google-Smtp-Source: APXvYqxOExGs7TchsFt3Iosql2c44CBBoUo1AKafGwYXzlB0y9Oui8WYRfkMv0ESWoUQPAPCVag72A==
X-Received: by 2002:a19:f50e:: with SMTP id j14mr19043514lfb.11.1556183072109;
        Thu, 25 Apr 2019 02:04:32 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v26sm4517353lja.60.2019.04.25.02.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:04:31 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] PM / Domains: Drop unused in-parameter to some genpd functions
Date:   Thu, 25 Apr 2019 11:04:11 +0200
Message-Id: <20190425090413.10700-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425090413.10700-1-ulf.hansson@linaro.org>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both genpd_alloc_dev_data() and genpd_add_device(), whom are internal genpd
functions, allows a struct gpd_timing_data *td to be passed as an
in-parameter. However, as NULL is always passed, let's just drop the
in-parameter altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8aca1c9b4406..93298b7db408 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1396,8 +1396,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #endif /* CONFIG_PM_SLEEP */
 
-static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
-					struct gpd_timing_data *td)
+static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
 	int ret;
@@ -1412,9 +1411,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 		goto err_put;
 	}
 
-	if (td)
-		gpd_data->td = *td;
-
 	gpd_data->base.dev = dev;
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
@@ -1504,8 +1500,7 @@ static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
 	genpd_update_cpumask(genpd, dev, false);
 }
 
-static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
-			    struct gpd_timing_data *td)
+static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
 	int ret;
@@ -1515,7 +1510,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data = genpd_alloc_dev_data(dev, td);
+	gpd_data = genpd_alloc_dev_data(dev);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
@@ -1553,7 +1548,7 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 	int ret;
 
 	mutex_lock(&gpd_list_lock);
-	ret = genpd_add_device(genpd, dev, NULL);
+	ret = genpd_add_device(genpd, dev);
 	mutex_unlock(&gpd_list_lock);
 
 	return ret;
@@ -2259,7 +2254,7 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
 		goto out;
 	}
 
-	ret = genpd_add_device(genpd, dev, NULL);
+	ret = genpd_add_device(genpd, dev);
 
 out:
 	mutex_unlock(&gpd_list_lock);
@@ -2429,7 +2424,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
-	ret = genpd_add_device(pd, dev, NULL);
+	ret = genpd_add_device(pd, dev);
 	mutex_unlock(&gpd_list_lock);
 
 	if (ret < 0) {
-- 
2.17.1

