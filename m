Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020DC2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slFc+tqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfDDDgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38159 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDDDgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so625638pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3HdOcyQCq9wrU1AdvtM6R2lHiYyKElGkieSf9jn2Q7c=;
        b=slFc+tqcLXHYhCkIxgtfmG/A+C0SXJdQV/GnM6Oqifk9ED1Eb60jGCl5ehaz7kum9f
         /zzsI+zMaS64QEk6OeKJbO9qcb/orb7/xJSHlQTFmSoO32iuFd/gtifKgQiWwjEWAw+6
         pa6GUmvQyLt3tUY8/QjNRxSLmNSas0E/Vo+nPOcrBRcyZs+DpdNZqr8OqkDEwiGMwzfI
         Nt1zrt4RMmEeVYi0JspPGlerBrJ5vgpDHQm5WSpokzXHsTwI0k4oGUWbnJmADATo1Rer
         zBYu9x1qeJzwAjdBEnorMU8S20jXoX2i/GxSjd69q//Voh0psQhboexDaqx5hpCqCiP2
         Hfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3HdOcyQCq9wrU1AdvtM6R2lHiYyKElGkieSf9jn2Q7c=;
        b=nuiKpkIvz6mT6WTvzZcCY+4e1Hmf4SzhBUf9BvIZ4vqc9BnTiZd6cVk2MpG40HZkX/
         Fn3XfjIeyQetEpjWcrocgmG7awlzqp72sybUCFQ31/Jxk0XjXz14Tp0DgKLjthER5ZZm
         yNntY/+09lMvMJN/j1bVn1HnEuiLgQyK6uEw11XVCdZyOWbyax1V8zJQV2HckOnF2btC
         WznIVoKxICMMTpROYJ7ZjgLpN2GNq11BlQIxyxqTBR58+2KGtT7aKUzz2cnt4PzQw24l
         A82roVTrcYMMdfm0SMXdR+sCy5CkPk4lIeOBVgJotBiB0lR/svGLuB25AB276AwnGoiq
         g++w==
X-Gm-Message-State: APjAAAWEGiLSlNNvZDHxeCSAfqYsf+Wo6SHBjApZxVC2MqPJ5i2hvqYH
        PH/YXXEuQKh8qRZulff0ORRvlw==
X-Google-Smtp-Source: APXvYqx2Oo18Jx3VkscEBB1oKY6eJLnvphpNd1a9HsVS6sx8AtGlR9ieNrAJIWpUZ8BERwuqvHA5lg==
X-Received: by 2002:a63:b64:: with SMTP id a36mr3487712pgl.58.1554348996718;
        Wed, 03 Apr 2019 20:36:36 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:36 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/20] coresight: tmc-etr: Create per-thread buffer allocation function
Date:   Wed,  3 Apr 2019 21:35:34 -0600
Message-Id: <20190404033541.14072-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer allocation is different when dealing with per-thread and
CPU-wide sessions.  In preparation to support CPU-wide trace scenarios
simplify things by keeping allocation functions for both type separate.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e9c77009188a..ac1efdfc0d07 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1206,6 +1206,33 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
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
@@ -1222,7 +1249,7 @@ tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	if (!etr_perf)
 		return ERR_PTR(-ENOMEM);
 
-	etr_buf = alloc_etr_buf(drvdata, event, nr_pages, pages, snapshot);
+	etr_buf = get_perf_etr_buf(drvdata, event, nr_pages, pages, snapshot);
 	if (!IS_ERR(etr_buf))
 		goto done;
 
-- 
2.17.1

