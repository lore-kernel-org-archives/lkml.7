Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5AEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF362147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIHCnaFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfDDDgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40485 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfDDDgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so498995pgo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G1pTCL1CVW1J8+zqGHl3aMQK3cea75KFYLLVGa3aTuo=;
        b=KIHCnaFtf0a36bnPS1J+zRFSumqsRdPPbVoWXwkeL1HXNwKWYsPasnJusJSH03de+g
         YrYEb2wJ/Xo+H/vWqEJdTjnFc4lejO+cXoI+Ur4SJwyNlqjDUm26N/hW4Lc7A7IRI8XE
         lHKqxmC/Fw69ZTS80V/oH5wYXxLlRR0MPw/3FbSQ9ivbTy8Z4M8ymHbgmxsEl+IAQ1Si
         DMF/oFhJMU8DXvkAC6SIB3Or8Rn+q4B0tTvNwmHYpT9Mx2TGfPWV5EUCbVNwyMyoWydI
         +XOQuiUO6i0q0zajwu3HaZNsiGLbgW9TWBgLUVMYb6u2i8Su233iQdtMSbCoZOVjHzgL
         hA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G1pTCL1CVW1J8+zqGHl3aMQK3cea75KFYLLVGa3aTuo=;
        b=K5I1D0owCinwDeKj0PbsLxMh6tAuKiO6ckDGCzvDpQdcVRGqpC9D3TI+FjaP01Jd9H
         0YaNsOe6jt9P+m9wmcC33sZjeeFcanb8k02NWkDB+dgSh3Vv3qUrhFcbxcrqgKI5OZxp
         V5mrn8+dRz+xJAKX3JUssfkjFpIXfy3D83lGRxO9sjkmIJhE4FFA5d40hllBA9OBwsUA
         98lX7GQMQ1PUHH1RgkRXm4Rg5ZPgnjy3asayEiOOIvyGDy2dcORlFejPZk5Kn7K6qp59
         k0bC98e7HJTDCzwwIUCKU6MA1BunFinQIU1E7ILM/jLNrgSZgXF0nOzT/IG7okV0fU4y
         VXTA==
X-Gm-Message-State: APjAAAWZVRunQ2yHGQuemktnsT27nPCA60L95Rt+hYPBFZnLitnAhxFb
        PdHs7ZG23I/qk2Nsvxe3DDlF4g==
X-Google-Smtp-Source: APXvYqzFdxJ3xAwPfEUpTkK2TeH/4oVjymWP8in/V/cF7jFJ/BFx5E59J7JTl/z8GIOprFgiE01Rig==
X-Received: by 2002:a63:c204:: with SMTP id b4mr3346998pgd.335.1554349007439;
        Wed, 03 Apr 2019 20:36:47 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:46 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/20] coresight: tmc-etr: Introduce the notion of IDR to ETR devices
Date:   Wed,  3 Apr 2019 21:35:37 -0600
Message-Id: <20190404033541.14072-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In CPU-wide scenarios with an N:1 source/sink topology, sources share
the same sink.  In order to reuse the same sink for all sources an
IDR is needed to archive events that have already been accounted for.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++++
 drivers/hwtracing/coresight/coresight-tmc.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 2a02da3d630f..71c86cffc021 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -8,10 +8,12 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
@@ -447,6 +449,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 					 coresight_get_uci_data(id));
 		if (ret)
 			goto out;
+		idr_init(&drvdata->idr);
+		mutex_init(&drvdata->idr_mutex);
 		break;
 	case TMC_CONFIG_TYPE_ETF:
 		desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index ee44906dffe8..c1b1700b2df7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -8,7 +8,9 @@
 #define _CORESIGHT_TMC_H
 
 #include <linux/dma-mapping.h>
+#include <linux/idr.h>
 #include <linux/miscdevice.h>
+#include <linux/mutex.h>
 #include <linux/refcount.h>
 
 #define TMC_RSZ			0x004
@@ -173,6 +175,8 @@ struct etr_buf {
  * @trigger_cntr: amount of words to store after a trigger.
  * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
  *		device configuration register (DEVID)
+ * @idr:	Holds etr_bufs allocated for this ETR.
+ * @idr_mutex:	Access serialisation for idr.
  * @perf_data:	PERF buffer for ETR.
  * @sysfs_data:	SYSFS buffer for ETR.
  */
@@ -194,6 +198,8 @@ struct tmc_drvdata {
 	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
 	u32			etr_caps;
+	struct idr		idr;
+	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
 	void			*perf_data;
 };
-- 
2.17.1

