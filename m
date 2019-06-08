Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE3C468C5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06C621473
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3N7H7bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfFHEnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 00:43:55 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:43892 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfFHEnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 00:43:53 -0400
Received: by mail-qt1-f202.google.com with SMTP id z16so3693406qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 21:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VsGMjkGOZPFGkhCwCfPMuPNJvsOcLeFFhKH7B9SWhJo=;
        b=p3N7H7bH0nuAEuJTu/oq9x4clbJ/yyYk/4oia3UFTq0FSnZKiXsRnP55OG528RX6ae
         3btwG3ecPZludSJG38saLdVAO3lzqWB4ZMTBoZdb8NFnD90Evo0eKLGU7qi+DS4a3Uy9
         GNg7bYSnq0mhVOfnvqloXrHxZY+0wtD5Xv1JE4+mNM9gBtN2YSrULrqdad4VvML8YGfq
         Rnb3KzQlsTkYhJ+UWqrPVviuA2wMotbsq4hTaUP2yGRisweIID2Qmvcge8SYAskIgr54
         sVgQrmYeDXzRM6YS+03hZQsEIm2eAWCKQ0gVQsGk586guRd+ud8wsc1H6y/nVEQ9eFiC
         IKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VsGMjkGOZPFGkhCwCfPMuPNJvsOcLeFFhKH7B9SWhJo=;
        b=Fj3M5VcESErnXDW+EkfyPfe1ZgbRcyNlQ59R2BGNL9OpQHlD/LCVB7PwchjIFEhgWr
         FpVrwwtamQU3IScmvVwwns7D7PD6Vkmu9YxCxkW3NGI5uZn8oNuoQJyORargfcaKz9Pj
         uegHIK0ZemUz3GNCo4llMU5+1jlEmv+L0I8YPL503JlUa3dXmcOETVBMfOWtV0r5clzW
         pE228RowmHaeGVJureAAIUugcUaZ8zbuPX6XNig2rgoEEupoIn+3+bRwT5p6GAqJ7URu
         y3uEbmaTnry8X222dKzM2vM1m6iE6ZGT1n1F2tgH0LSJ489B7jpwaFs/2HFwIlv/gt/S
         paDg==
X-Gm-Message-State: APjAAAUMxbzTKmWMRDhlai8YyP27wxxS/ULvjZMpIDoxPbJjUeRWXEUA
        qXYH6Mf7ctrBwDQIBY64REUGpK+RDM/ophg=
X-Google-Smtp-Source: APXvYqxowEVj/16yFHu5u5M+Hh+OsPObpHW4eaANvRfQI2X4XmPpgTOnRXKsjSiYUE5FMSOmVTkt55wGBlGC8bE=
X-Received: by 2002:ac8:2c17:: with SMTP id d23mr17659580qta.385.1559969032137;
 Fri, 07 Jun 2019 21:43:52 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:32 -0700
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
Message-Id: <20190608044339.115026-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 2/9] OPP: Add support for bandwidth OPP tables
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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

Not all devices quantify their performance points in terms of frequency.
Devices like interconnects quantify their performance points in terms of
bandwidth. We need a way to represent these bandwidth levels in OPP. So,
add support for parsing bandwidth OPPs from DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/of.c  | 34 ++++++++++++++++++++++++++++++++--
 drivers/opp/opp.h |  4 +++-
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c10c782d15aa..54fa70ed2adc 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -552,6 +552,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
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
+	ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
+	if (ret)
+		return ret;
+	new_opp->rate = (unsigned long) &bw;
+
+	ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
+	if (!ret)
+		new_opp->avg_bw = (unsigned long) &bw;
+
+	return 0;
+}
+
 /**
  * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
  * @opp_table:	OPP table
@@ -589,11 +618,12 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (!new_opp)
 		return ERR_PTR(-ENOMEM);
 
-	ret = of_property_read_u64(np, "opp-hz", &rate);
+	ret = _read_opp_key(new_opp, np);
 	if (ret < 0) {
 		/* "opp-hz" is optional for devices like power domains. */
 		if (!opp_table->is_genpd) {
-			dev_err(dev, "%s: opp-hz not found\n", __func__);
+			dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",
+				__func__);
 			goto free_opp;
 		}
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 569b3525aa67..ead2cdafe957 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -59,7 +59,8 @@ extern struct list_head opp_tables;
  * @turbo:	true if turbo (boost) OPP
  * @suspend:	true if suspend OPP
  * @pstate: Device's power domain's performance state.
- * @rate:	Frequency in hertz
+ * @rate:	Frequency in hertz OR Peak bandwidth in kilobytes per second
+ * @avg_bw:	Average bandwidth in kilobytes per second
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
@@ -81,6 +82,7 @@ struct dev_pm_opp {
 	bool suspend;
 	unsigned int pstate;
 	unsigned long rate;
+	unsigned long avg_bw;
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

