Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21555C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB43216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oG/h5CSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbfHGWbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:31:23 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38444 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389454AbfHGWbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:31:22 -0400
Received: by mail-qk1-f202.google.com with SMTP id n190so80643153qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f/5iyKYNpppjBF3zdaFLWaB9mtwpqzd2AKaKjPJxAWs=;
        b=oG/h5CSE4Vl8m9nJpZKL2XmKPaShpcaKcKIvjDfvwRS9zUFnoyEJ3iouLQdGeCZq+E
         hf9dKIkpZb9iIuxITVcANYzlRy6K7U+DS0F6TsUJOUjUBN39vlI6rEFj7nwKYnjH1jnX
         6aSKpaBVNOrDAU8lFkxwVB4padlrh79dFWccl81oByzfLMik8LcjrwAAATm0E9k+bbVs
         eKzqRFY+EYl5uV2uMKPbKLCMo93gdvytxJvjedgKr3PGKLN/s5CP10TvgN1jHHWZ58dc
         VFrHN/eoabKXS5bZ03G+2CTZZeJfUJacXEtg2vO+jIsZWRl1Enxs5vUieQ0d0zVf+S+g
         sIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f/5iyKYNpppjBF3zdaFLWaB9mtwpqzd2AKaKjPJxAWs=;
        b=Khw01Lx80diFEU/4dmgbHFLCCBvqSsrvpddjAMofcTIJXiUMAdXdQV6E8F0sfYPvL1
         VTnIgphYXPszH3KVuswv4sWk5yiP54IlKf1bbTHI54xiAtq1z2/vGGLIlmyVacme2jno
         YBnbWoY6JhqxUrEjYx0piqDXTWwaw87ztrgA4MYWECaWBhZorTDd3fF01vveEWvz2Fan
         MY37Xjy/SmZjUVpKy3PIkTMCkMrJGfpsUFh3jgDEjzuhGa4JFLjxarvqEtERehAFpiIr
         JDruGeA7XTv/JaSkMInuOxfk9blDDCd+PmadgOGhiJtF1fM7X8rk2LTdXt99CWFxoTRM
         2iPg==
X-Gm-Message-State: APjAAAW3FOnzmSdbspvihstafRqt+KATa8U8du0N+ZTgcygO6lJ0rDQM
        jMRnBoUk6WX5eTt69B4diEjrAby2IjNnLCQ=
X-Google-Smtp-Source: APXvYqz0a1du6BAb2n9zOY1TKTVI9Gg9OvB/aNzpeonZWxzlN/oxlG5fY68P9FEOHHUsq2e6wy1iV98PD6FTBF8=
X-Received: by 2002:a0c:df12:: with SMTP id g18mr10126912qvl.34.1565217081340;
 Wed, 07 Aug 2019 15:31:21 -0700 (PDT)
Date:   Wed,  7 Aug 2019 15:31:10 -0700
In-Reply-To: <20190807223111.230846-1-saravanak@google.com>
Message-Id: <20190807223111.230846-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all devices quantify their performance points in terms of frequency.
Devices like interconnects quantify their performance points in terms of
bandwidth. We need a way to represent these bandwidth levels in OPP. So,
add support for parsing bandwidth OPPs from DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/of.c  | 41 ++++++++++++++++++++++++++++++++---------
 drivers/opp/opp.h |  4 +++-
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1813f5ad5fa2..e1750033fef9 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -523,6 +523,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
+static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
+{
+	int ret;
+	u64 rate;
+	u32 bw;
+
+	ret = of_property_read_u64(np, "opp-hz", &rate);
+	if (!ret) {
+		/*
+		 * Rate is defined as an unsigned long in clk API, and so
+		 * casting explicitly to its type. Must be fixed once rate is 64
+		 * bit guaranteed in clk API.
+		 */
+		new_opp->rate = (unsigned long)rate;
+		return 0;
+	}
+
+	ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
+	if (ret)
+		return ret;
+	new_opp->rate = (unsigned long) bw;
+
+	ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
+	if (!ret)
+		new_opp->avg_bw = (unsigned long) bw;
+
+	return 0;
+}
+
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -560,22 +589,16 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
 
-	ret = of_property_read_u64(np, "opp-hz", &rate);
+	ret = _read_opp_key(new_opp, np);
 	if (ret < 0) {
 		/* "opp-hz" is optional for devices like power domains. */
 		if (!opp_table->is_genpd) {
-			dev_err(dev, "%s: opp-hz not found\n", __func__);
+			dev_err(dev, "%s: opp-hz or opp-peak-kBps not found\n",
+				__func__);
 			goto free_opp;
 		}
 
 		rate_not_available = true;
-	} else {
-		/*
-		 * Rate is defined as an unsigned long in clk API, and so
-		 * casting explicitly to its type. Must be fixed once rate is 64
-		 * bit guaranteed in clk API.
-		 */
-		new_opp->rate = (unsigned long)rate;
 	}
 
 	of_property_read_u32(np, "opp-level", &new_opp->level);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 01a500e2c40a..6bb238af9cac 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -56,7 +56,8 @@ extern struct list_head opp_tables;
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
  * @pstate: Device's power domain's performance state.
- * @rate:	Frequency in hertz
+ * @rate:	Frequency in hertz OR Peak bandwidth in kilobytes per second
+ * @avg_bw:	Average bandwidth in kilobytes per second
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -78,6 +79,7 @@ struct dev_pm_opp {
 	bool suspend;
 	unsigned int pstate;
 	unsigned long rate;
+	unsigned long avg_bw;
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
-- 
2.23.0.rc1.153.gdeed80330f-goog

