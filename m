Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A8EC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BD021743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJQ2aUxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfGQKT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:19:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41017 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfGQKT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:19:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so592529pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VK4VAAKwmD6vCOcxsuweQdA7aImoD6BI1bwtOEYy7Ec=;
        b=AJQ2aUxdLzlHM27/CtHDPhhfUR2r74bNE+Fqr8namI4DMjtm0Ji7+gNHpxvvqiRDFx
         bS/TqlbQ6J90Uxwy03MVOU1uUp0BxIa1DOVdxUbaoshON5cRSy5QWQOcrDfOaIEIPcdP
         Gj2ufs3wvpr0tw0Iq50TgspWBICEBWEol53OGPNkl8cZtKwGcqeS38ztPFf5v/Wd+nLa
         kX3Mi6+0hE6FPSjCsz+vronqX1BzubKEO3WPstJw0glwlOgwWZqVOv/G7bW0m2LHVVGK
         zPjPsD7GYAXYfav8ZhSf5kMBqYM5zQNLyMN2FfN9Agg5SVevn8e/U2FH1BycN/4I9raM
         ejMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VK4VAAKwmD6vCOcxsuweQdA7aImoD6BI1bwtOEYy7Ec=;
        b=KF9AX0e1LQuCmXG/OsxZW6mZvsnTkl5Q+t2c8ZnxjCdjRO+5qEEKlFgnVXh+XBp0BD
         M2P4WMRjT8nPJKOYJN+p1dUnkXALTybnXy2PlKXs6GIhLWfYO0bnmeXn9DVnJ4Xzi/wg
         5iZe+TAXBlpCC0i9ruStigM2jmDXGz7cQJ5Nr4pg3rmYCJRNdLn/M6j+yaelvmEClCxW
         1iAbVqZWW9iaciXdhpiyFwqoF0Y98aiCUefHzeG8fZYpu09decjxybVbH+driwXrLV4C
         zPsB+OJBB2unuFlEDrUQ6nxQEIt9wfci+NSVsKhIYLlNAkOS/5vEcYU1HuK/I9pBudWH
         OiOA==
X-Gm-Message-State: APjAAAW7r60A4g2OBjauyx//rn8oG1IvdpkrjZTssmV+nW5E0aVjG8K6
        tyUJIRSWAkTBCqYwi+vHL2eP1A==
X-Google-Smtp-Source: APXvYqyHlVMuMahTL4YiiobGoIz/ikKUUA807jg2o7LAg2+WQ8WsgPVx+k4SS6QyIEowyz5oHtjfGA==
X-Received: by 2002:a63:9318:: with SMTP id b24mr30127568pge.31.1563358796826;
        Wed, 17 Jul 2019 03:19:56 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r1sm27721976pfq.100.2019.07.17.03.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:19:56 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()
Date:   Wed, 17 Jul 2019 15:49:47 +0530
Message-Id: <aaf5648b925aed79ffdd416be44a05ab3c8d2058.1563358721.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <90ba3941b56e50ea5548dd1e90bf3bcd8c9da4fe.1563358721.git.viresh.kumar@linaro.org>
References: <90ba3941b56e50ea5548dd1e90bf3bcd8c9da4fe.1563358721.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq drivers don't need to do runtime PM operations on the
virtual devices returned by dev_pm_domain_attach_by_name() and so the
virtual devices weren't shared with the callers of
dev_pm_opp_attach_genpd() earlier.

But the IO device drivers would want to do that. This patch updates the
prototype of dev_pm_opp_attach_genpd() to accept another argument to
return the pointer to the array of genpd virtual devices.

Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Check virt_devs pointer before assigning.

 drivers/opp/core.c     | 6 +++++-
 include/linux/pm_opp.h | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4e2a81698cd2..1f11f8c92337 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1775,6 +1775,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
  * @dev: Consumer device for which the genpd is getting attached.
  * @names: Null terminated array of pointers containing names of genpd to attach.
+ * @virt_devs: Pointer to return the array of virtual devices.
  *
  * Multiple generic power domains for a device are supported with the help of
  * virtual genpd devices, which are created for each consumer device - genpd
@@ -1792,7 +1793,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * The order of entries in the names array must match the order in which
  * "required-opps" are added in DT.
  */
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
+		const char **names, struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
@@ -1846,6 +1848,8 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 		name++;
 	}
 
+	if (virt_devs)
+		*virt_devs = opp_table->genpd_virt_devs;
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
 	return opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index be570761b77a..7c2fe2952f40 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -131,7 +131,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -295,7 +295,7 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
 
 static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
+static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

