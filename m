Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E73C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AC20645
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aq4uyuIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFVAfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:35:04 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50482 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFVAfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:35:03 -0400
Received: by mail-pf1-f202.google.com with SMTP id h27so5330540pfq.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uZe8xdTxrcmzsMfd5NRi2oKQSnCX2+7hWLlLXSrqI2Y=;
        b=aq4uyuIUPRA/yb4indcQDCGdufn8KJt3WSE7aAZKuzS6jR6P5TG1ngAmI0rfU9wgdw
         CeOtQFCQ/VO0vrbf8UlFR4d/nZxuz2lfrRBhbULK9L+e9fghj3I11XUMJpRSCwdOSNfy
         v802ZgQzhLZWAzudLn2nQ+BmnIO58KCrTQd2mlt7v+AFLTfUTgYZfe4liUgGc11+1dFG
         WLTsiu77o5u26ue0V4JI3mWsfwjbi71ZaRD5BTWmVqyPJQGcV4XVZRH+4JmVjVqAv4kD
         x71+82LVQ9YRwjUt46owDnvB04IHtZ/4CL9CpvwrnXkQHDkNqSgcqQs676M7TDUHkiXW
         65Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uZe8xdTxrcmzsMfd5NRi2oKQSnCX2+7hWLlLXSrqI2Y=;
        b=sdqdUU5ZvelNzmPUVN6YccWegCUdPE73IY4zxH0imJZ1AJjUZByPbgezvD9C7TcX8H
         AgE9WpQJCqaDzJZSLGNZre5eU+P1l+/PTs/9ovyKnhK3nx+OxV8xhArJh3Wo+6+4b+Kg
         pRAq7/ci1wUCxiag3bQO5EuVSOBAr0UBUn7ir3SPnNwrse4Eq5ASSAHlZQyXRYMNgJhp
         iLZ/Ab4VPM0QKwC31uibmgqR/kN/XyPlKvcxF8fNgogoLtrgO2213VbPViTZKmQHhycY
         pmnlrYHSO9eyU/UHuFD6ZLmCe347b5GXHxjPA1EMBmL9Wrcjih1CUpR+YtDJcwN7O46n
         ZH8w==
X-Gm-Message-State: APjAAAWKHD4+wi9wjUwXCVCiWVZ5/chmY1Oedwhj+G03vado9g/Jy2Ii
        RyzmbVyx+mcrhQkljJ7MJxF6GLQKjcf0VRE=
X-Google-Smtp-Source: APXvYqxr2NvKIMGYahmV1qrUTQt9g0D8oa2ojuqqy0qIsl/GrmHv3JOO2xz9uNJA0HtzJ6ACxmZX3GCwLqjgm8Q=
X-Received: by 2002:a63:de50:: with SMTP id y16mr4707161pgi.431.1561163702716;
 Fri, 21 Jun 2019 17:35:02 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:34:48 -0700
In-Reply-To: <20190622003449.33707-1-saravanak@google.com>
Message-Id: <20190622003449.33707-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v1 3/3] PM / devfreq: Add required OPPs support to passive governor
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look at the required OPPs of the "parent" device to determine the OPP that
is required from the slave device managed by the passive governor. This
allows having mappings between a parent device and a slave device even when
they don't have the same number of OPPs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/devfreq/governor_passive.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3bc29acbd54e..bd4a98bb15b1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -21,8 +21,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
+	struct opp_table *opp_table = NULL, *c_opp_table = NULL;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *c_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -65,7 +66,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 		goto out;
 	}
 
-	dev_pm_opp_put(opp);
+	opp_table = dev_pm_opp_get_opp_table(parent_devfreq->dev.parent);
+	if (IS_ERR_OR_NULL(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto out;
+	}
+
+	c_opp_table = dev_pm_opp_get_opp_table(devfreq->dev.parent);
+	if (!IS_ERR_OR_NULL(c_opp_table))
+		c_opp = dev_pm_opp_xlate_opp(opp_table, c_opp_table, opp);
+	if (c_opp) {
+		*freq = dev_pm_opp_get_freq(c_opp);
+		dev_pm_opp_put(c_opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -92,6 +106,13 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp_table))
+		dev_pm_opp_put_opp_table(opp_table);
+	if (!IS_ERR_OR_NULL(c_opp_table))
+		dev_pm_opp_put_opp_table(c_opp_table);
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(opp);
+
 	return ret;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

