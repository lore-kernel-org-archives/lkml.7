Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998EFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B10E2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKmCBzs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDDDgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43870 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDDDgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so612709pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ATVaL0BIcRrddkftI6sh9Xp4gw4NfYBuCJEK93HbLeU=;
        b=rKmCBzs52IVhUtfKRiHeIOvrwSN/b443hb4GxVRQmBQdIEDSczP2Q8i/Z9UqKG63eq
         f+AkUX1JO8wwwWmjefJYVhXCBvxle2SUKDNug3pAFoidc0zqfArwoVjeoWo1uYvxAvxK
         s0zLSmMsqbWESGD0qMDHAk3DcIU1epl4Ba+XlTdpTptsCjHKmZ5vpoioQfRkZDjKPG7S
         RqyRrExG2rD1XB4ysQj495mB9zV2EuopEO0SAEKw2W8CWDu6nuK3HTGZuiqksGR2phNg
         QbwwJ5lFEZshA2G/fpvnIxrsScEjvxhUkMnnqoZkMngkCsPvcYS6U8eO5b4g2Vrn9cMW
         nTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ATVaL0BIcRrddkftI6sh9Xp4gw4NfYBuCJEK93HbLeU=;
        b=ugs5CL6c5asUkjgB1LnQe+rCqZYS+U+d1kYUXRMUtSMns2qm5dEvnREg0vyhDaSngo
         7L7R4uBJh4/wn7DKL2cgCg+XMLfvMOp591NMwmGRXrKTnzY4lb/woYeS+rdAtIOai0XA
         ed+9MWg0883GnIcd1E9Nq9kcg/KGcXgQoP3Exhe7/BLocXpla69T37MnQEPK6l3midGi
         ei/g+xL9UqlEyQEwHcS2DRWOw6c+klV5r4b6o46kpLcM6BrOVB/GPPZ70Vak2Ut9Pi2j
         gsNodj52ix96SB8MUJbL7inJ/740uJyen8TVV6/bzZGTTPGdzJUFm4E4EYKHQg22u7RY
         JDqQ==
X-Gm-Message-State: APjAAAUnAUWWpLV1P0ySqARQ8IP+enY6uKLbkSWuAlfmdal9pq0S2GkA
        jIY+Tii2QyeZdS1jICAxLQpHyGHdBp4=
X-Google-Smtp-Source: APXvYqzN68UBaaXaeIDhdKpX8QN0NoYx34/CT1JjgNLimmnfq7ag2NudengqscJS7/SVhAEwmwrtfQ==
X-Received: by 2002:a62:ab14:: with SMTP id p20mr3334379pff.23.1554348964007;
        Wed, 03 Apr 2019 20:36:04 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:03 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/20] coresight: etm4x: Configure tracers to emit timestamps
Date:   Wed,  3 Apr 2019 21:35:25 -0600
Message-Id: <20190404033541.14072-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure timestamps to be emitted at regular intervals in the trace
stream to temporally correlate instructions executed on different CPUs.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 101 +++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index d64192c29860..46d337fd8442 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -204,6 +204,90 @@ static void etm4_enable_hw_smp_call(void *info)
 	arg->rc = etm4_enable_hw(arg->drvdata);
 }
 
+/*
+ * The goal of function etm4_config_timestamp_event() is to configure a
+ * counter that will tell the tracer to emit a timestamp packet when it
+ * reaches zero.  This is done in order to get a more fine grained idea
+ * of when instructions are executed so that they can be correlated
+ * with execution on other CPUs.
+ *
+ * To do this the counter itself is configured to self reload and
+ * TRCRSCTLR1 (always true) used to get the counter to decrement.  From
+ * there a resource selector is configured with the counter and the
+ * timestamp control register to use the resource selector to trigger the
+ * event that will insert a timestamp packet in the stream.
+ */
+static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
+{
+	int ctridx, ret = -EINVAL;
+	int counter, rselector;
+	u32 val = 0;
+	struct etmv4_config *config = &drvdata->config;
+
+	/* No point in trying if we don't have at least one counter */
+	if (!drvdata->nr_cntr)
+		goto out;
+
+	/* Find a counter that hasn't been initialised */
+	for (ctridx = 0; ctridx < drvdata->nr_cntr; ctridx++)
+		if (config->cntr_val[ctridx] == 0)
+			break;
+
+	/* All the counters have been configured already, bail out */
+	if (ctridx == drvdata->nr_cntr) {
+		pr_debug("%s: no available counter found\n", __func__);
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	/*
+	 * Searching for an available resource selector to use, starting at
+	 * '2' since every implementation has at least 2 resource selector.
+	 * ETMIDR4 gives the number of resource selector _pairs_,
+	 * hence multiply by 2.
+	 */
+	for (rselector = 2; rselector < drvdata->nr_resource * 2; rselector++)
+		if (!config->res_ctrl[rselector])
+			break;
+
+	if (rselector == drvdata->nr_resource * 2) {
+		pr_debug("%s: no available resource selector found\n", __func__);
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	/* Remember what counter we used */
+	counter = 1 << ctridx;
+
+	/*
+	 * Initialise original and reload counter value to the smallest
+	 * possible value in order to get as much precision as we can.
+	 */
+	config->cntr_val[ctridx] = 1;
+	config->cntrldvr[ctridx] = 1;
+
+	/* Set the trace counter control register */
+	val =  0x1 << 16	|  /* Bit 16, reload counter automatically */
+	       0x0 << 7		|  /* Select single resource selector */
+	       0x1;		   /* Resource selector 1, i.e always true */
+
+	config->cntr_ctrl[ctridx] = val;
+
+	val = 0x2 << 16		| /* Group 0b0010 - Counter and sequencers */
+	      counter << 0;	  /* Counter to use */
+
+	config->res_ctrl[rselector] = val;
+
+	val = 0x0 << 7		| /* Select single resource selector */
+	      rselector;	  /* Resource selector */
+
+	config->ts_ctrl = val;
+
+	ret = 0;
+out:
+	return ret;
+}
+
 static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 				   struct perf_event *event)
 {
@@ -239,9 +323,24 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 		/* TRM: Must program this for cycacc to work */
 		config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
 	}
-	if (attr->config & BIT(ETM_OPT_TS))
+	if (attr->config & BIT(ETM_OPT_TS)) {
+		/*
+		 * Configure timestamps to be emitted at regular intervals in
+		 * order to correlate instructions executed on different CPUs
+		 * (CPU-wide trace scenarios).
+		 */
+		ret = etm4_config_timestamp_event(drvdata);
+
+		/*
+		 * No need to go further if timestamp intervals can't
+		 * be configured.
+		 */
+		if (ret)
+			goto out;
+
 		/* bit[11], Global timestamp tracing bit */
 		config->cfg |= BIT(11);
+	}
 
 	if (attr->config & BIT(ETM_OPT_CTXTID))
 		/* bit[6], Context ID tracing bit */
-- 
2.17.1

