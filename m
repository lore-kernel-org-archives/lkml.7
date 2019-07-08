Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12D8C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA67320659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCFcjFeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfGHGAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:00:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfGHGAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:00:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so3991053pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6q22eQDDCUZWlcpujovTPxDLV/PDTFZTJgjMkPGNMDU=;
        b=qCFcjFeCt5a05VcS5Cjwgn22CsE/7DQLunpoWaYJxF06aSHKpcocF0SZYql/0vvOYP
         gPHsR+rNQ8P0MLJcpgJMZv56u/hBqdpZ+4ywoAGXcYG7ooS3XQGOlYkBql1rIr38HYqu
         zXO/ZmzprkLvQ+rKetYp4s1jyIcpCCyb5Yum+pq78zZQC78pLqdUN+WUEssnXexeUcl2
         6r7akeSW1kIBwVhljmpM32CmF2uqDXRZRx1l3pUy2HmHEpgzOjQvbhy6q8r+XK8pAmUJ
         0nOeDi2SQsTmFSpK+2c+gl8zE08CvsvEj+Ys1POjFUK/eul15t4sQnwNGka0hZ+Hicpr
         VmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6q22eQDDCUZWlcpujovTPxDLV/PDTFZTJgjMkPGNMDU=;
        b=ttS+kgxUsmASQfUjaESU7Z3+6nKpCuPfLGdUa7KwfITDTZ3iHgzGdlDV/5eGCNYnC5
         2JcYFv+FVW0TlawJQ0iba0Bf/DncNRWKhqhsOwx+sinnVd3xDSe3hyxQUyVv7DNKXIeO
         JaooGJnv1bdhZP/adr8lZVA/ug3Qtp9kG4JPIEnYRTfny4d2UZcQJlU/PWb2RAuDRuu4
         tnwrPmT3U35W4VNgQbbVpIX7wydW9DunLys6qtRzdy00AfCc9kBQnBEwQTvL4YBKmBcA
         oGQtpzSBSjVeZ9tZ8KTmBqHAE4uHJZmEhfFZz3l8OY9Jq0/oRflqry2mPshBw1CwNpvJ
         qlDg==
X-Gm-Message-State: APjAAAULWVjlfj8LBIGRT7e1noj/orgvSPhunVFeaug7kA9mpSExk/gD
        gkqX77iBWrg4X1e0TuEBM+u94A==
X-Google-Smtp-Source: APXvYqzCH6JkIGIMDnIOEIFv7dTqbgSevQnLuknmocRwHgxJb1MtM345JVgkwrUtGfT2CEe7k8z8kg==
X-Received: by 2002:a17:902:1e7:: with SMTP id b94mr22716751plb.333.1562565619188;
        Sun, 07 Jul 2019 23:00:19 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id f15sm21479445pje.17.2019.07.07.23.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 23:00:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()
Date:   Mon,  8 Jul 2019 11:30:11 +0530
Message-Id: <027985ce35873cd218298302a1408da06d48458b.1562565567.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
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
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
@Rajendra: Can you please test this one ? I have only compile tested it.

 drivers/opp/core.c     | 5 ++++-
 include/linux/pm_opp.h | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2958cc7bbb58..07b6f1187b3b 100644
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
@@ -1789,7 +1790,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * This helper needs to be called once with a list of all genpd to attach.
  * Otherwise the original device structure will be used instead by the OPP core.
  */
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
+		const char **names, struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
@@ -1850,6 +1852,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 		name++;
 	}
 
+	*virt_devs = opp_table->genpd_virt_devs;
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

