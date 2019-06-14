Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424F2C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EFB2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrEXlT8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFNESN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 00:18:13 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:44450 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfFNESK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 00:18:10 -0400
Received: by mail-qk1-f202.google.com with SMTP id c207so996057qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VA7s9ly0lqdagUAyh1uYpw4qgEasvgJFlK1lzvkukqY=;
        b=TrEXlT8djNpXPJc0j8YuBg6jTcfItK6GjAaeUSewHjYjftr5gYxyJuqq3MGH1OUe1T
         F3xdsaC3oKrSs+dlLVQW3XrlXYI+1M2VVTmgutAgeR/C8BeBT2yPpIVqmYf0mybVrYxo
         wmtTS/hWV6UkMbpi0KH7Dgq3wWGTIZtkgefl5OGGmwKX/S5v6YwKVnVU3C1gpFDeO+2I
         FBr4uMGQpUMsUfh59BM9jW4yJHzxtr2LArxfDQbupQodPwMohSfxjbPi3RMe0hpBN2iX
         XKBIGUhfIgNitWDR3R/EHS75rmfuv6cnWhkdhva0AOGRbVQuo7nzNskKg+bmAYvCCtN7
         zNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VA7s9ly0lqdagUAyh1uYpw4qgEasvgJFlK1lzvkukqY=;
        b=sJM6m2ANmH+NRRZ6O0M6awQpb9EHcyEC1WXp31xeZUv9jXAom7d2JhWTpht3DrZ8de
         Dr0eW3AMw0utc6G0RqlL9vYuKvWgubqxD53AJJQPxjpt6/rn2dMhtey8MydcuWWEuFJ5
         oLa13Umdfranv32wHDwMGMcR5hRJNphVattQObRKJlY//MRLtLaTtdFrzgc1Xa6Bgx2o
         oI/sz7V58ORjpkqJBxCyyg4PWL4gyRVlJQfmh0sz9SVlCXgB1+cJoDYjYgtWXPl9oWmG
         TXisRw/jHv3Kk+PEoe4SniQmdCc/hJ3LP6htxhlOfHyzqiMIXyCNSW8fjkJI+MizG2JO
         ewCw==
X-Gm-Message-State: APjAAAU8D2p4RJy31dgEeD8lSv7K7MRNJnLa7GrD+ZDjK8ZPKCQYdj8H
        51gXW9AkEUh0XF0LB78WdZBZs8UO/k0dkDM=
X-Google-Smtp-Source: APXvYqzEU9fWluswZw2wyE1N4COxp8I6V3iABbyGVjD++OlIlQ99JPYxbbaQ1U5BqOb5o+DCUfLqGIKFA8Ys39Q=
X-Received: by 2002:ac8:1794:: with SMTP id o20mr80687898qtj.239.1560485889196;
 Thu, 13 Jun 2019 21:18:09 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:32 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-11-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 10/11] OPP: Allow copying OPPs tables between devices
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some hardware devices might create multiple children devices to manage
different components of the hardware. In these cases, it might be necessary
for the original hardware device to copy specific OPP tables to a specific
the new child device. Add dev_pm_opp_add_opp_table() to do that.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c     | 8 ++++++++
 include/linux/pm_opp.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c9914afd508a..668a377f59a5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -943,6 +943,14 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	return opp_dev;
 }
 
+int dev_pm_opp_add_opp_table(struct device *dev, struct opp_table *opp_table)
+{
+	if (!dev || !opp_table)
+		return -EINVAL;
+
+	return _add_opp_dev(dev, opp_table) ? 0 : -ENOMEM;
+}
+
 static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index d9156b62d966..3694d703817f 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -81,6 +81,7 @@ struct dev_pm_set_opp_data {
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
 struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
+int dev_pm_opp_add_opp_table(struct device *dev, struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
@@ -158,6 +159,12 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
+static int dev_pm_opp_add_opp_table(struct device *dev,
+				    struct opp_table *opp_table)
+{
+	return -ENOTSUPP;
+}
+
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

