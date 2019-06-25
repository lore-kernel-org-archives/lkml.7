Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA64AC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9003F2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nac5aiSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfFYVeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:34:01 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52682 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFYVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:33:55 -0400
Received: by mail-pg1-f201.google.com with SMTP id a13so140724pgw.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pSd2SEQBNKQJHNErQavWSNgkmJEBQdH7SImGVZiADmI=;
        b=Nac5aiSPpKXkEoBjULWPNAHKlYVVswo8Sv+aG4Nke8sMPOVW/szdI6v3v2LjD3wyEj
         dSxGFXMq4R6/VUvASlerc0YHjxEciGlmfpvUQaqcj9qMSwHIIRpqZIrWJldrniWDW9Hg
         CyVQmYNhxjtZcDOdChKUCwLkP9gicQce4SEip766nU7aK7h7m17qe6A1M/GXpqAaVYZu
         xCtO7hBsnvfCOL+wvWBKWthJhv9Yi76HPcJxAiR7XIIb7WmR4GVwX5BVQP558AWcJlB6
         LcSUR0W4OQfEKF47DlvQQlgePqeSjxEA9B7/QWoIUYLIMXjc+UQDI6N9vFjDEnXMypku
         M9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pSd2SEQBNKQJHNErQavWSNgkmJEBQdH7SImGVZiADmI=;
        b=dC4poGuxaoQEGdzKrZ3jCJkq3unYo0N8VzUroMw7qixE9wfJX3NGouZQm8DEy1OSbi
         gwKhUcD35dn9ZT0aHTox/eoAOKRUW/V3Hs1sFijf897dsiFGMXtLiOe61k8C40YtJ0h6
         5MM6BUXlQwhy4GbmVWS01AoXrW3jKb9cLqX2QjP9CHzYrdOTse4bXvlQptfu7OFfYp4x
         zqzDir036s+L05EaN9Ap7YP9WfiQHQ6Ul49SHTJ8Sk8MyCIvf1bBLHfKIe0T5XcZK81i
         pMcEqWea1Hv/3TbabnyQB8amhaoYXjfXy0nD/4k4Lllq/NfD52Z7xyowIXBU/ArhP9Uj
         gdVw==
X-Gm-Message-State: APjAAAX6x+YOKv4NvDEhToUeBBujweCo+4uaeyNeBAN+vGRa5ocWePRe
        n5AohCMQGzM6/ek1Hq9j21C4HG7nYx3q27g=
X-Google-Smtp-Source: APXvYqxiaI1A+FOWzhGL3gXUXbGdGJVhVOkRbDCDZJ1LQ4tDeB1cBg4isNNSqYgykqDQ7wiPiLWYdl6pW7jSYMI=
X-Received: by 2002:a63:34c3:: with SMTP id b186mr507704pga.294.1561498434498;
 Tue, 25 Jun 2019 14:33:54 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:33:37 -0700
In-Reply-To: <20190625213337.157525-1-saravanak@google.com>
Message-Id: <20190625213337.157525-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190625213337.157525-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 4/4] PM / devfreq: Add required OPPs support to passive governor
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
 drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3bc29acbd54e..f6de03de7a64 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -22,7 +22,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -59,13 +59,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 * list of parent device. Because in this case, *freq is temporary
 	 * value which is decided by ondemand governor.
 	 */
-	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
-	if (IS_ERR(opp)) {
-		ret = PTR_ERR(opp);
+	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
+	if (IS_ERR(p_opp)) {
+		ret = PTR_ERR(p_opp);
 		goto out;
 	}
 
-	dev_pm_opp_put(opp);
+	if (devfreq->opp_table && parent_devfreq->opp_table)
+		opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
+					   devfreq->opp_table, p_opp);
+	if (opp) {
+		*freq = dev_pm_opp_get_freq(opp);
+		dev_pm_opp_put(opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -92,6 +99,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(p_opp);
+
 	return ret;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

