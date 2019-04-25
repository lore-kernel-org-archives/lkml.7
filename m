Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DC8C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0162077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLl1Qh73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfDYTyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38492 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfDYTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so439204pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hCKOOh4hib7nPM65HtU8D/wwQ4e+FlOROgf2ArtIPlk=;
        b=NLl1Qh73x0bruajqwDy06dnBABzmAWNzw/fQwjVFDhO+q7EdS71MBwjXbx0j+siM2N
         nYF4xGB2mOWxEm3CU2B/+ruf9UJX7b4nVeFGVdNVE+4itmPOhktkdL3C/fOO9pA7TTP0
         74WI3W5YES935RHXmLvg34016AovPe1mwqku21t/buu9pSTm2R3fBLvi06J/d4ea+0q9
         4qFTr+hLI/NtawuF6E7Xq+Lo7d2ocdgm/GPJzHwI8+9nGuZ8eXyn7x9+nNJWep2jSuvQ
         jY9vX8RqltoCPs5FdQQjPfyQvErA2W/StfdzAS+GeUVMwBWnJcelbqqsc8/e6s8z/t0/
         4NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hCKOOh4hib7nPM65HtU8D/wwQ4e+FlOROgf2ArtIPlk=;
        b=JbK3b/CDFGO61mNdKXHTocI1dX1pgnxfmwp+SHLmMIpaVW2GY6fxjXMcbatjBEMYt4
         k//dutx0KaOLzvU6R01rWuGAIU/2p0Fu+8q1hczclkzKnKAAeCJt31mBhfO7/99TvzrB
         2XwC3QTjfUoNMF91HPwzxmV/p9nR3ffamAQftZRsLAFPaA8OZcZx+P7fGnWIhOgUpwZK
         R5BlaotVrHvSgcKpNfP0OgaSEfV7BEB9lB2YExpQCyR9TOrvVs+B/SMPzJq8wq2Kez5f
         LHZgGRC5p4848fHVqjXMNRYGrqsoHVeOBg7tG6zS66tb3aVh4D2v9IiPi5konYA31d6d
         RwhA==
X-Gm-Message-State: APjAAAUn8eRC32OlbDumjT/1l+5wtHH9Le6nO2RKvYpr93C7Co/qsQcH
        Jj44pQkk4tqMrByX1X33ATtGig==
X-Google-Smtp-Source: APXvYqyWBGzch/1IvPRMLBbQTeSi4b3nMzAr1C49TIBMXrDtODXyurwD78awOF/ntymlvdO/1CRjWQ==
X-Received: by 2002:a63:cd50:: with SMTP id a16mr20241249pgj.394.1556222024673;
        Thu, 25 Apr 2019 12:53:44 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:44 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/32] coresight: tmc-etr: Create per-thread buffer allocation function
Date:   Thu, 25 Apr 2019 13:53:03 -0600
Message-Id: <20190425195310.31562-26-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer allocation is different when dealing with per-thread and
CPU-wide sessions.  In preparation to support CPU-wide trace scenarios
simplify things by keeping allocation functions for both type separate.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e1d2128ee757..bca1b2d9ef2e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1207,6 +1207,33 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	return etr_buf;
 }
 
+static struct etr_buf *
+get_perf_etr_buf_per_thread(struct tmc_drvdata *drvdata,
+			    struct perf_event *event, int nr_pages,
+			    void **pages, bool snapshot)
+{
+	struct etr_buf *etr_buf;
+
+	/*
+	 * In per-thread mode the etr_buf isn't shared, so just go ahead
+	 * with memory allocation.
+	 */
+	etr_buf = alloc_etr_buf(drvdata, event, nr_pages, pages, snapshot);
+
+	return etr_buf;
+}
+
+static struct etr_buf *
+get_perf_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
+		 int nr_pages, void **pages, bool snapshot)
+{
+	if (event->cpu == -1)
+		return get_perf_etr_buf_per_thread(drvdata, event, nr_pages,
+						   pages, snapshot);
+
+	return ERR_PTR(-ENOENT);
+}
+
 static struct etr_perf_buffer *
 tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 		       int nr_pages, void **pages, bool snapshot)
@@ -1223,7 +1250,7 @@ tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	if (!etr_perf)
 		return ERR_PTR(-ENOMEM);
 
-	etr_buf = alloc_etr_buf(drvdata, event, nr_pages, pages, snapshot);
+	etr_buf = get_perf_etr_buf(drvdata, event, nr_pages, pages, snapshot);
 	if (!IS_ERR(etr_buf))
 		goto done;
 
-- 
2.17.1

