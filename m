Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475F8C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14424208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5yi/fsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfFNERn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 00:17:43 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42760 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfFNERm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 00:17:42 -0400
Received: by mail-qk1-f201.google.com with SMTP id l16so1002787qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 21:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nT/RN++hgSEY1oFXDZU2+2vA7A3kNiWfnEI7MgbZhNk=;
        b=n5yi/fsSkLPZsXmOhD6VaVWd4K75Sp6QVYZWyYN4AtitTODNfEvka82I6ouh9pIllG
         dByhWETJ+8aEVnytSO/6g5UZ468kBNbvHIY8phwEkAWG2tZrVyIT0IsUTnuJQzR3aN5e
         XLV3Bp8RtbiNIhG4M2j+89d4S8rQhOaXxXhPxrP4R3GuFvA3KrIT2TCwKcbf5jWgDRdY
         hXKGsyRZDlYUqE42uRR1Cxv/vlIoapqsipres07YeHegPtQ6LxBQwOSWtvBOezOpgD3I
         Qu28AYiZTS3TgBTeUizjfUrhu0yM3b2DuiIp11SST0LVUveEP+ZUo3ggXGNYrpastq/N
         2/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nT/RN++hgSEY1oFXDZU2+2vA7A3kNiWfnEI7MgbZhNk=;
        b=Ujt4bRZv7zh70M2vvpNM3n28G1P8235KIMJ9YyKd1e/WRdSRoi1WuppFGd9OWQXM1R
         Np1fcmWTKD8FYCtM/fNV7Dt1x3r9ZNOHN+Hi4Sok7VOlWaMPaq28h1tS10MxGadDJSmh
         GgCHaKVVmWiHYzv2i5sC7Be8o4yyI+kiNzjOzXJUyty4qySv3VHK+HDFaBh+dl8ygudC
         SyOlPkkUeIzXAYtU8wYU9iPjPh5uz5PSffqBOrORdFltpbe7+Z2lDEsNU6w29kCn/Rb9
         7D8XSSISrSpnOo38+JcPE6bq7Vhq9KhTylb2zAJIkqh2aGpBJ9ywn7sDjrOD4fEDUGCF
         xs+g==
X-Gm-Message-State: APjAAAUprFGtKj9JmAzJJS5ZccmhlkPJbhh/RBSF0QDwgF9irwUad57c
        3hawWbxjwB4r/QfDRd4ke47sP5USKWrk+ao=
X-Google-Smtp-Source: APXvYqyNMF63uMGGdRuluuVrT4/Cbxxxf47Mr3fg6agQhouB8jIcIqFEqN0r4I8WQRbVaepWXMQu0HlCnhutkjM=
X-Received: by 2002:ac8:1a9d:: with SMTP id x29mr79446143qtj.128.1560485861512;
 Thu, 13 Jun 2019 21:17:41 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:23 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 01/11] OPP: Allow required-opps even if the device doesn't
 have power-domains
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
2.22.0.rc2.383.gf4fbbf30c2-goog

