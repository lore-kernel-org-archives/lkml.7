Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB5E2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVXnHtLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfB1N75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:59:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43534 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732502AbfB1N7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id z20so17191981ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hYUbL8LbBo82QhtQinEvxE8lGJZ9H5Ith2yhnCB+jfs=;
        b=FVXnHtLFTrcIsi6QjOHvDk72G+oUmcjjHSBm6gOpkR8yahj/V1QIS1G5ehizJn1wuA
         6WDxEgGJRdSbqz4DDEbcVpENyPnwXeqdMWWNAFf9lN+6qzc9QRoeSDhIWF+icNXyz6fW
         UQYxOWQ4ENTXypM11P/07ftev62Jo66OAGARyGbzZPAlGiLw1OnYzQa9rghzecD48VB6
         cBpxHW47WDo70pErlO17ptrY7aJUSIdPaZ0DoE7aUGropbrhf5DwN3jkIUXNm1Aj6hXX
         xnXciiS5mAPAWRrtfhwI6rkU1IsSbT5aiYPp1XShUC+jNSV0amTsj6e+DCLyveFBNam8
         2A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hYUbL8LbBo82QhtQinEvxE8lGJZ9H5Ith2yhnCB+jfs=;
        b=IMZu7KZMpKdMbVZap3R3X+L5rJNZT07cWk0su1/W/CmD7w92heJxNNUCNnnpTob4S4
         3GnJBkqqzGLHa7mHU8YuKqDGpKO3rALUGvvY2xI66gfQTcH3I/yXCY4JTmQCMLu2n5ON
         U2hcAucIB0zS9S1TswyN4aB1XIm00iVd9qsAu6Tq8EKt10WShrqWo+VmF49EROH+OhzY
         3HSVUeB96RNBT86yDUjQE/ahLXmqJvJ07AtELndO0rG/tH0YbT7YDsY90lBFibGee1Qe
         +ZYKME+ob3klJ5Ez+W95KbTkswHoVkgIC2Mr0CzjXEZH8CezQtgkwoFqracUbN0M4BOG
         L50g==
X-Gm-Message-State: AHQUAuaSHBvY44dGodsMl6o7EHrkKHnEOFrlFfdudkRjm35wS71YnmwT
        8naEK/CtVhLT41c0IulH/UBOiQ==
X-Google-Smtp-Source: AHgI3IZO2Wq9Mtzo7x2cc9k3I15Qn/9ArqedLsbZ57QDgmSES47es6+2O5q3dGm9ObdOHf0PNMrJ8w==
X-Received: by 2002:a2e:2202:: with SMTP id i2mr5173940lji.170.1551362374036;
        Thu, 28 Feb 2019 05:59:34 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v20sm4090265ljv.83.2019.02.28.05.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:59:33 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] drivers: firmware: psci: Simplify error path of psci_dt_init()
Date:   Thu, 28 Feb 2019 14:59:18 +0100
Message-Id: <20190228135919.3747-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228135919.3747-1-ulf.hansson@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having each psci init function taking care of the of_node_put(),
let's deal with that from psci_dt_init(), as this enables a bit simpler
error path for each psci init function.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cbfc936d251c..14d25b54b9f2 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -609,9 +609,9 @@ static int __init psci_0_2_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
+
 	/*
 	 * Starting with v0.2, the PSCI specification introduced a call
 	 * (PSCI_VERSION) that allows probing the firmware version, so
@@ -619,11 +619,7 @@ static int __init psci_0_2_init(struct device_node *np)
 	 * can be carried out according to the specific version reported
 	 * by firmware
 	 */
-	err = psci_probe();
-
-out_put_node:
-	of_node_put(np);
-	return err;
+	return psci_probe();
 }
 
 /*
@@ -635,9 +631,8 @@ static int __init psci_0_1_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
@@ -661,9 +656,7 @@ static int __init psci_0_1_init(struct device_node *np)
 		psci_ops.migrate = psci_migrate;
 	}
 
-out_put_node:
-	of_node_put(np);
-	return err;
+	return 0;
 }
 
 static const struct of_device_id psci_of_match[] __initconst = {
@@ -678,6 +671,7 @@ int __init psci_dt_init(void)
 	struct device_node *np;
 	const struct of_device_id *matched_np;
 	psci_initcall_t init_fn;
+	int ret;
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
@@ -685,7 +679,10 @@ int __init psci_dt_init(void)
 		return -ENODEV;
 
 	init_fn = (psci_initcall_t)matched_np->data;
-	return init_fn(np);
+	ret = init_fn(np);
+
+	of_node_put(np);
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.17.1

