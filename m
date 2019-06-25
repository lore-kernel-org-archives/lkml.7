Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA26FC48BD7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAEE2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qt2GyuTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfFYVdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:33:47 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:32982 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFYVdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:33:46 -0400
Received: by mail-pl1-f202.google.com with SMTP id f2so29159plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=diT5j67eq/c/BsDoIxqIkGMzy6KvSDn7bQJLbufPm+c=;
        b=Qt2GyuTO7pTaIYstjFLkJ4UcWzoUKoZj4qXob3li6BuGiuKeH50eLMmsx/LxWdsWLA
         oecwexwecInCXpqVHrwJlB4oAOh+bGLiUQ7Ec4LJU+29OlER1pH1x3YVV0RvrcOgm7KW
         vI2ZTO9GPmN98FDlAFxgVgIwLUitzndyN5zxbeY1PhbYfBoi8r0f8IIAtmRh6ywTaa76
         UpVrAJkLoVqes/Tv9AOUt81P8QMCOlNI3ggTX7v9EgbJIuZiRmlDd1k+MnS3316TxoeS
         gwcZxmG5mkTa+WNatLkSNvEXmvBi5LZgTzem7X7JYmp2q1tpK8W9NiJk7MDucsTcG70S
         3ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=diT5j67eq/c/BsDoIxqIkGMzy6KvSDn7bQJLbufPm+c=;
        b=pQD1qXEmH0nmXR+qpV12GCU6j6XDgPEB9N0LLADxBV0Y3TGq64VvjzRcDpWx/GT18C
         8jIO02Xlpihf98S4xdVLxtDCvwKQT0Nd7AsjwRxJK3byiK2S+Ma1YwaeyJxejkjAzHP5
         LfrJH/QZb8P7KH5eNW/LXp4875+cFklspQfy1DC8kV37tXo+G4afTweHQNUv/ujKrCXQ
         832g+Zs4AjfqTJ5gqdu7WlT14wnmBOfmiKeXBtrbRshZUSUj8gbLNw6CfMMhILpA7gWh
         x42BgmYK1h2b3/nPLN6Mbfu26HDciW+3o2/VsVyT6a1t35p1LiyG1MhSvNXY5wEdZJPs
         W6MA==
X-Gm-Message-State: APjAAAXT2R9tyQouyRYQbB5D4WjZu3uYECJH85n/Yu7mapFQC8BWTJTi
        Iix5RL0+TKUzO0HRoSf/v+n7o9Tk5SL56yI=
X-Google-Smtp-Source: APXvYqzIHSXTSLsgydrPoSZc9EgXx53vFFhsfQ8jj9MTVHjjXWYgkmbSCbVTleIIJbzNNIH7BCg3E5ALTwZptWI=
X-Received: by 2002:a63:231a:: with SMTP id j26mr40088869pgj.389.1561498425029;
 Tue, 25 Jun 2019 14:33:45 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:33:34 -0700
In-Reply-To: <20190625213337.157525-1-saravanak@google.com>
Message-Id: <20190625213337.157525-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 1/4] OPP: Allow required-opps even if the device doesn't
 have power-domains
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

A Device-A can have a (minimum) performance requirement on another
Device-B to be able to function correctly. This performance requirement
on Device-B can also change based on the current performance level of
Device-A.

The existing required-opps feature fits well to describe this need. So,
instead of limiting required-opps to point to only PM-domain devices,
allow it to point to any device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c |  2 +-
 drivers/opp/of.c   | 14 --------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0e7703fe733f..74c7bdc6f463 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -710,7 +710,7 @@ static int _set_required_opps(struct device *dev,
 		return 0;
 
 	/* Single genpd case */
-	if (!genpd_virt_devs) {
+	if (!genpd_virt_devs && required_opp_tables[0]->is_genpd) {
 		pstate = opp->required_opps[0]->pstate;
 		ret = dev_pm_genpd_set_performance_state(dev, pstate);
 		if (ret) {
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c10c782d15aa..7c8336e94aff 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -195,9 +195,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	 */
 	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
 					      "#power-domain-cells");
-	if (!count_pd)
-		goto put_np;
-
 	if (count_pd > 1) {
 		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
 					GFP_KERNEL);
@@ -226,17 +223,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 
 		if (IS_ERR(required_opp_tables[i]))
 			goto free_required_tables;
-
-		/*
-		 * We only support genpd's OPPs in the "required-opps" for now,
-		 * as we don't know how much about other cases. Error out if the
-		 * required OPP doesn't belong to a genpd.
-		 */
-		if (!required_opp_tables[i]->is_genpd) {
-			dev_err(dev, "required-opp doesn't belong to genpd: %pOF\n",
-				required_np);
-			goto free_required_tables;
-		}
 	}
 
 	goto put_np;
-- 
2.22.0.410.gd8fdbe21b5-goog

