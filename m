Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5766F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K68wBhJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfDDDgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36615 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfDDDgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck15so445031plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H9+OTr1OpfrOYtthYPTeqD/UZckEAYj6DoPWjl6ycEY=;
        b=K68wBhJEME7fnO0jZ2eonmNB3GuHTmOF7iCsl8xEsvaPBFjiqFF+5Nx8BZrytnDPl4
         3ozNLTYUVmxGm8C7sKWtJhEIGbZhe66ILZqt6EtA7ZjECx29SvjbtRXGGqJ442bA5G1w
         BwhJWUbLlnX6r0ICNZfbFN2SPI2NnE78gkpzd1kUmAMVCzEynsjygMDbu3t32CV0Yl2H
         bTtaXq5um59sufHwsYirJ5SP4nC6Nsmgm5IgRzCjRTgVy3dQiF1qWGETfMRMC27MqUmr
         2Xfz3DXGVArX2qERcU4h3xJCG9AmO1yGqUOAqw+rkQLkVf7xlMbf2lP2pMlBrUIjk2tK
         izsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H9+OTr1OpfrOYtthYPTeqD/UZckEAYj6DoPWjl6ycEY=;
        b=I3pxA0U7Cf2jlbfN9ykQUiwxZvLDJS9JFJMeebHzSgRvG0NzSeNy4c+/41KwTiCsiH
         Ll08ihj6h8kY+mROnKzm9iQFJtMlrII0WhnTXWef9xqNAlGiWiXdCQ8q8jI+2xiXnKhP
         QR+6p+wOWx0Dh8QN4FRTeVa4Z36RKysOmNtbfOoffvoWvwJg+sHNouOytS0+DhgntRkS
         MlqvxLKImj9vq5uRz7TqB52M6pZ7YGbBfFfxofo6Y10nYFTg4KWOtEOFjzrATpoXs80d
         Yv1v6qNM3+mlR1wNj+e8pbfJJNvgJVzTDRI7ywRrb4f4nJw7wWb6v8B66yoaeuUGzMgt
         gdDQ==
X-Gm-Message-State: APjAAAX54eWntwVQy7xBykH0aMyJlz81g7VoDAdiFtZpk0B6nVYnhHUX
        SgWFQPrggfsD0/T3weNGdxqToA==
X-Google-Smtp-Source: APXvYqw3tJWWYHJETjByD6pMXcwDX2pb9RX8aFl/XUsX9IvhUHKsvCTjv8Wh/Gx8hl45MnhwXmIS4Q==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr3762736plb.236.1554349003815;
        Wed, 03 Apr 2019 20:36:43 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:43 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/20] coresight: tmc-etr: Introduce the notion of reference counting to ETR devices
Date:   Wed,  3 Apr 2019 21:35:36 -0600
Message-Id: <20190404033541.14072-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds reference counting to struct etr_buf so that, in CPU-wide
trace scenarios, shared buffers can be disposed of when no longer used.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++++
 drivers/hwtracing/coresight/coresight-tmc.h     | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index e1774d4bb5f3..1346474ac019 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -8,6 +8,7 @@
 #include <linux/coresight.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
@@ -1221,7 +1222,11 @@ get_perf_etr_buf_per_thread(struct tmc_drvdata *drvdata,
 	 * with memory allocation.
 	 */
 	etr_buf = alloc_etr_buf(drvdata, event, nr_pages, pages, snapshot);
+	if (IS_ERR(etr_buf))
+		goto out;
 
+	refcount_set(&etr_buf->refcount, 1);
+out:
 	return etr_buf;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 487c53701e9c..ee44906dffe8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -9,6 +9,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/miscdevice.h>
+#include <linux/refcount.h>
 
 #define TMC_RSZ			0x004
 #define TMC_STS			0x00c
@@ -133,6 +134,7 @@ struct etr_buf_operations;
 
 /**
  * struct etr_buf - Details of the buffer used by ETR
+ * refcount	; Number of sources currently using this etr_buf.
  * @mode	: Mode of the ETR buffer, contiguous, Scatter Gather etc.
  * @full	: Trace data overflow
  * @size	: Size of the buffer.
@@ -143,6 +145,7 @@ struct etr_buf_operations;
  * @private	: Backend specific information for the buf
  */
 struct etr_buf {
+	refcount_t			refcount;
 	enum etr_mode			mode;
 	bool				full;
 	ssize_t				size;
-- 
2.17.1

