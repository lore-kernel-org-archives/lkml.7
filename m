Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF18C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A502238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjqB0ijO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfGXBms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 21:42:48 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:48167 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfGXBmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 21:42:43 -0400
Received: by mail-pg1-f201.google.com with SMTP id k20so27194969pgg.15
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tcec6G8mdYvC44AUiiZquxcEHQD3/poU4Cd0DIagRzY=;
        b=OjqB0ijOd5pzNZ1elvcBfW/VYQq9Xyi191z3lVRIEijGecmCpThtCaH7iAEAOQV6tt
         n1Ma7p9sAXcFTkGiDuRpVzqQGS9v541NtuMY6wTBEFaB3+mr4IX8M4w8OiWHQCvmubm8
         Yju7NLSi4U7n/lTTOksPbc2XETeb5BvCiu5vo6wve7xyJW1gy/VAecz2XFeG0rLFAV/G
         zZ+mJdKhPjpQMlhvl95+iF1kVbre+8PnJY5WGzv4zkJmDfzAx29ovEXNLLGStTbDkEc+
         NJ0im1qi8CZTIkUMjx+pxaVVsobC496FzzkLJtNZgBvfbrzOAV7JFut85IszWRP7WF0K
         9S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tcec6G8mdYvC44AUiiZquxcEHQD3/poU4Cd0DIagRzY=;
        b=rh0AdCJ6dPLByfUK2xKZWG3FDFv+RzHSB+N1J0NbnZCsWKsATlK7MXG/IUhgDjeHqw
         dHVwj4iGYY/EA0hu5nclTDCp41mPCNNaCmqTo920c73sxW6Nx8WwIXsUNZ/80+IqYrOi
         UlqGe4hJAIQ5BXo42DjsWECNrxR88MfWrzk9V4hFLOEV3XXJr0QmR9RteNRB5ehnLdMA
         T9Hz/H1Q2ZUIH0025UqNi3f6VjwXmlIJuoKTShuUPsVpB+7YoKQeqeKUcdcXj0xldO51
         H/VRRCWr5CWu5dKJxLsXLPonB69N7KA6DhEOPyNBBOXLTpszFjSy74BksTwdcE4ZzxqV
         4T2g==
X-Gm-Message-State: APjAAAWVy54chRQq21jp1TxMuSvjY93mV2fPrzKO0vsK83W1WV3fp7IJ
        wQ82jNT9dn4nO8eWIhu0fR/3Xlb4NREoWHI=
X-Google-Smtp-Source: APXvYqzFshsuv+IyMmfv+K7ZxtUfZm5PhJHbRo0sv/PZ+9kPjXaRXrDQoTPve3lpQ+P63v+BW0L/MbdyD6oDveA=
X-Received: by 2002:a63:4404:: with SMTP id r4mr77919539pga.245.1563932561833;
 Tue, 23 Jul 2019 18:42:41 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:42:21 -0700
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
Message-Id: <20190724014222.110767-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 5/5] PM / devfreq: Add required OPPs support to passive governor
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
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
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 58308948b863..14dc5bb58733 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *p_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
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
+		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
+						    devfreq->opp_table, p_opp);
+	if (opp) {
+		*freq = dev_pm_opp_get_freq(opp);
+		dev_pm_opp_put(opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -89,6 +96,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(p_opp);
+
 	return ret;
 }
 
-- 
2.22.0.709.g102302147b-goog

