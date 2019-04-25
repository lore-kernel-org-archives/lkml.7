Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8FDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F024205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQOTPvY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfDYTzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37857 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387734AbfDYTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id z8so316864pln.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H6VFr4RzKtwO7p6PtWjll/+gKQ4FjiT+Jt5SNVjQDXc=;
        b=pQOTPvY7iJsdq3m0yA7hz/ciyVUbHZbBqH82ibaX/pbODqiHi1xETN0j8l7yIsGuwt
         8fKzS5I06wfx8Dvl9JHN2XX093XtiVaYdcgImAstd6WcygW+fNw3KEbEnwPIeF/Htrnq
         iD51y8FJWfOX5s3dsabRYAaz2OTxSVcDGPFVRE9HbYt0CiqU9+bGLsklrmUYEN1r051s
         O61CDCa9MOCXRYqOU5FBGgGK9w3gauNH/lDRVBM7of+odRP1Q4HTptnPZs7ylIEg8zTj
         8UKC4DNYLmJgxVb4D+SjFz6JB2jJDD8+LJDB7bhug9UTMXRQu4RsnnbeZ1w4i+9ruCPP
         0ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H6VFr4RzKtwO7p6PtWjll/+gKQ4FjiT+Jt5SNVjQDXc=;
        b=P8eAq22FGKPu3LiwzMI6nEeY7yhu8qswLCa3TSib4FXHUV14s7aBWFVbjD26Cm17lY
         vML2ZfM7BfwGifTFsb8XKNIG3kM0n7Zra6O2YksjH53+fOTjsAQojV0FiRLlbNz0OBiX
         so9aT69HVXnmVi/5RTKbFxcj7GFDyyIYkCQrm6iQgIPFFzIjyWFpZ2JoUD/irggKoIm3
         VMLHAMcTIrldVlRJRCraspgjm6TtyiJcCRbwx8TvUPoU58VqFhV/osYbLwIvAbat+YSo
         8nerO+y83CVVJnXT4zfW3N94peioW36X5t/9lm0TFIjTIqr529VY7od3Qy1RydRxZTta
         9ZFQ==
X-Gm-Message-State: APjAAAWQVQI/vCr0e7w219rseyg64HBP7SMg02QVkjby9oxTIPbRZAxO
        FxT8Q/lvmngysNN0NgrTS+pH/pD0PK8=
X-Google-Smtp-Source: APXvYqwNUs7d8UwEMjjddLrpHtJkgRz2zvezaFhozYjBrOQGTItysd+zHyGpYySVqJ+oDDKWbjjS7w==
X-Received: by 2002:a17:902:581:: with SMTP id f1mr41595505plf.304.1556222012967;
        Thu, 25 Apr 2019 12:53:32 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:32 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/32] coresight: etm4x: Configure tracers to emit timestamps
Date:   Thu, 25 Apr 2019 13:52:54 -0600
Message-Id: <20190425195310.31562-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure timestamps to be emitted at regular intervals in the trace
stream to temporally correlate instructions executed on different CPUs.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 102 +++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index d64192c29860..8bb0092c7ec2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -204,6 +204,91 @@ static void etm4_enable_hw_smp_call(void *info)
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
+		pr_debug("%s: no available resource selector found\n",
+			 __func__);
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
@@ -239,9 +324,24 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
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

