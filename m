Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E511FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A462184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWjsHT1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfDRK2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:28:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42704 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbfDRK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:28:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id v22so1452174lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 03:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BLvAgBQDq6vF0i+wC/iY8ot3SYyciBGpMv8ybloeX/8=;
        b=UWjsHT1soOCJol5kUrl4LvjOrmosF6Qvw1AlY4/rgZDKzdy0IOQ02rKUvJz1QU8gNS
         auSsccy7TFGnzKgKOC1bfnesKoR5bh0WoCMoy08Rq41b0kX1EP2CTMImfnNm59uHJLoE
         IZjc9ctIk/jINg1QD2Rf1VzNaJSDu5nibKxED3wklqMYDgxyAEjyzoqKJi0zikzveq+R
         X58rwBvNBMFh5psCB8ctl8jFZ7i6IkWgd+Hz9ktJ5yIBkuV+BdJFQ01a+bCearHLoCE4
         LUcJXp8cIkbUXX2k6QObhuUjUaYTEJjlu/YKbBTRe6e7owNpatgqbz6seu+kgy5pi87T
         h45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BLvAgBQDq6vF0i+wC/iY8ot3SYyciBGpMv8ybloeX/8=;
        b=B+XBvNi9Q3gfzz0Lw8walLjX63qM5eRTKABo/PgLkzg+8MppGN8VYKTQTJYHW0tI7X
         viGv7LhIsxOg8+gH5wurBa1xrG2bqsOtN4oz68FE2jYQsnbzne5kTwFv5YIATX2sX0ih
         zBBR4PiX8o1lYXsklpUkX0Nzd8IueOZ+ajMLYzpLVMD5X5a8NGwOcMyjzbBBKG+UOQOm
         3GhuaW86PbAbJKVTPw1GXfbvq9mNeLzqKgAC6YPktS2oojpIBcPo752xJquPgeFBzTxV
         aOufoT6wTkQN1E/zDQbpnjcYkWxymNchXfmpGcjiYblo1tBEa5ICo2e47NaAccQNG6C6
         UKew==
X-Gm-Message-State: APjAAAV1wBYUBWALSGfH2VsK3dmbxPkcEMb9JtkiYlAvFESiauFt+rq6
        no5eFCtsRWABTkm4Om7Xk06jmA==
X-Google-Smtp-Source: APXvYqxP+kiPYsKyAHgOMKr4NxfGd1gczUvjp0zvE12QTUzn6AhXfh0nI+0yjdus7Gtj4hdq5UvIVA==
X-Received: by 2002:a2e:711a:: with SMTP id m26mr50832819ljc.40.1555583285587;
        Thu, 18 Apr 2019 03:28:05 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id l13sm320409ljj.96.2019.04.18.03.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 03:28:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] PM / Domains: Allow OF lookup for multi PM domain case from ->attach_dev()
Date:   Thu, 18 Apr 2019 12:27:56 +0200
Message-Id: <20190418102757.1246-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190418102757.1246-1-ulf.hansson@linaro.org>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A genpd provider that uses the ->attach_dev() callback to lookup resources
for a device, fails to do so when the device has multiple PM domains. This
is because when genpd invokes the ->attach_dev() callback, it passes the
allocated virtual device as the in-parameter.

To address this problem, let's simply assign the dev->of_node for the
virtual device, based upon the original device's OF node.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7fec69aebf46..801f31c87d16 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2345,6 +2345,7 @@ EXPORT_SYMBOL_GPL(of_genpd_remove_last);
 
 static void genpd_release_dev(struct device *dev)
 {
+	of_node_put(dev->of_node);
 	kfree(dev);
 }
 
@@ -2406,14 +2407,14 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
-static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
-				 unsigned int index, bool power_on)
+static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
+				 bool power_on)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
 	int ret;
 
-	ret = of_parse_phandle_with_args(np, "power-domains",
+	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 				"#power-domain-cells", index, &pd_args);
 	if (ret < 0)
 		return ret;
@@ -2481,7 +2482,7 @@ int genpd_dev_pm_attach(struct device *dev)
 				       "#power-domain-cells") != 1)
 		return 0;
 
-	return __genpd_dev_pm_attach(dev, dev->of_node, 0, true);
+	return __genpd_dev_pm_attach(dev, 0, true);
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
@@ -2525,6 +2526,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
 	virt_dev->bus = &genpd_bus_type;
 	virt_dev->release = genpd_release_dev;
+	virt_dev->of_node = of_node_get(dev->of_node);
 
 	ret = device_register(virt_dev);
 	if (ret) {
@@ -2533,7 +2535,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	}
 
 	/* Try to attach the device to the PM domain at the specified index. */
-	ret = __genpd_dev_pm_attach(virt_dev, dev->of_node, index, false);
+	ret = __genpd_dev_pm_attach(virt_dev, index, false);
 	if (ret < 1) {
 		device_unregister(virt_dev);
 		return ret ? ERR_PTR(ret) : NULL;
-- 
2.17.1

