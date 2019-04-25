Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928FDC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63581218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQmk7AwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfDYJEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:04:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44086 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbfDYJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:04:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so6980793ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+54V2h/XgAc13rlQ/SlFnygRmRch2uFRJkG3WKQRigw=;
        b=KQmk7AwUQoPW2mhxbS6TbUc3r7+PGjbj3/fAGNr0k/M5E/bxs6vjesb1EMTfE7qahu
         mjo053Qcdz2MYbIjtNyE7tk3CSwVWY4AmlrbjMN2XtSANsD7HX0Y7TKnR6+OsbtFse5O
         sXUna4rQr9RO0G+sqR3DobsE8n83OOOlNyW5KXVh7DjHRh3P8pUEFJTfACqAyKBwI7TX
         yktVEhPgbp3tH5ruHg2A3odsJAf2+82PNfNTMHdnf/kcNOBJVo1U7s3bMp8koLCvLKHk
         2U+oyKLdPNs9YiCni7hh9xZrSXDJCI96Ma0iVYbbGcQUyP6JBLg4WTbWJOAdQkbS322B
         mX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+54V2h/XgAc13rlQ/SlFnygRmRch2uFRJkG3WKQRigw=;
        b=DLktC4Zqo98heSD91v2nTGnexPChCEJeVF+gjxUSw9Nb4+9IsOMPlQbGH45cS08W3H
         1buoZQp9oNJPcpBeuXVoLax2KenkNBQF3ALV3BtBmbasVuczpdV4R7wC5fl1oPELL3lh
         gsyXL5ig5YeU/d+1uKyEGbpwvoG/9JfvZtEFfBEdvfU/xfA20ko9uOMipf+y+EdurCe+
         GNlNwLjH8Xqmz2aEe5kpn//Z2wznA+kXMmYwJVet2nVMAxIkhS1qlP43EF04nDRFssrL
         t/VJ1eJDnaBu+DQNzbKNr+8rNXGywIT9myVWAVTXjgD6Q02VZmHUWw3HO8FlClFmqg27
         hTKg==
X-Gm-Message-State: APjAAAWkdo16JUYbtmZphkVv0MorOW4h2d2YsXP7B7AA4tEqgYh8cyCn
        wy5KnlHJ4jS2IX5VcXZsx31s0g==
X-Google-Smtp-Source: APXvYqwTUexwmpqjGqL8ndwTScbQ3jA2Gi9wk4uhiTaDz25Zi5/AQ81/TdtnywrUEXCFKwJaXlLlVg==
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr9087891ljk.74.1556183070284;
        Thu, 25 Apr 2019 02:04:30 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v26sm4517353lja.60.2019.04.25.02.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:04:29 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/4] PM / Domains: Use the base device for driver_deferred_probe_check_state()
Date:   Thu, 25 Apr 2019 11:04:10 +0200
Message-Id: <20190425090413.10700-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425090413.10700-1-ulf.hansson@linaro.org>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When genpd fails to attach a device to one of its multiple PM domains, we
end up calling driver_deferred_probe_check_state() for the recently
allocated virtual device. This is wrong, as it's the base device that is
being probed. Fix this, by passing along the base device to
__genpd_dev_pm_attach() and use that instead.

Fixes: e01afc325025 ("PM / Domains: Stop deferring probe at the end of initcall")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8362dfe187f5..8aca1c9b4406 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2405,8 +2405,8 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
-static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
-				 bool power_on)
+static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
+				 unsigned int index, bool power_on)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
@@ -2424,7 +2424,7 @@ static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return driver_deferred_probe_check_state(dev);
+		return driver_deferred_probe_check_state(base_dev);
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
@@ -2480,7 +2480,7 @@ int genpd_dev_pm_attach(struct device *dev)
 				       "#power-domain-cells") != 1)
 		return 0;
 
-	return __genpd_dev_pm_attach(dev, 0, true);
+	return __genpd_dev_pm_attach(dev, dev, 0, true);
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
@@ -2533,7 +2533,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	}
 
 	/* Try to attach the device to the PM domain at the specified index. */
-	ret = __genpd_dev_pm_attach(virt_dev, index, false);
+	ret = __genpd_dev_pm_attach(virt_dev, dev, index, false);
 	if (ret < 1) {
 		device_unregister(virt_dev);
 		return ret ? ERR_PTR(ret) : NULL;
-- 
2.17.1

