Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357A9C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B30214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6yFsd+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfDDDgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39398 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDDDgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so624193pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SAt54gusO22M7wlCjXKs+Y6DbEbN3JCXkJVbAiVcyrQ=;
        b=U6yFsd+67XoVyLCNbk7v3WHsEiS/WHY2Q0QAP3eQw5q4Nj1vDydwghcUdnSXcFKD38
         RxggYHts98UHlCL10HksqlqXIe4c+8+z7B0glU+3RBErEWNesyGDn+fa1v78XXxJ2iZ3
         dstj56EHjyn/OSD5i0ukwabyuzCQi2FQQpz7D/kll5ppAGZip54/6D6u1Vcj+sqs7oyG
         uvezNlgJB1C3X0FT1DD4b6LNI3o+ucEOPhJuPPby42/DCou0ei6L0l3IJFe7Suzut1vh
         wOXiJgQiDrlHVLH/iFfoqYKeEJChV1bygMSWqLaGLOz6IXrUFX1+8ZQ9XhAnus1KHA8P
         Wglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SAt54gusO22M7wlCjXKs+Y6DbEbN3JCXkJVbAiVcyrQ=;
        b=fB3cpJ6mQulRr03/GcMwL9rITiNzLNaplO6OJIouxvujhCPomb/yr8hUSDTgPfEOJ0
         jE/iySlfqBWCqiVJpqraa+Xh6XgzVnAplQ/x84MvRTAsQcgVekbDJLRhv31q3NL39+6K
         0TlegYfmrORzb+vZveQztbw565s9e28q5+xSj0tVRpychMzLUUhjahw0pRL6/bnx/YtU
         AmVru70gR0CFo1w1gy+lxq20fX6wJIemTxh3WjNX4I9l2oui9MbDiyE7BYzpjsMBgnAQ
         QovPNktDI2BmOFDNPORCH96J0T4UV4Zo9qCPxMy/6YLVGrlSqMghaP1dBaoylYDoKWnb
         0YVg==
X-Gm-Message-State: APjAAAXNFn2cDLJAunuEJ0IrNl35++IWSe3J6yO/+qfCwk3RN/wO2C/x
        NxxMr/ra+pAaEGvYYGH36NBIJA==
X-Google-Smtp-Source: APXvYqyqLPVOgsJdntpitDgkDe8xtxV8hGaTgnlPVyq9j2/fptKaLJIl4ucuD98Wnki638HBqz6BjA==
X-Received: by 2002:a62:ab14:: with SMTP id p20mr3336646pff.23.1554349000298;
        Wed, 03 Apr 2019 20:36:40 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:36:39 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/20] coresight: tmc-etr: Introduce the notion of process ID to ETR devices
Date:   Wed,  3 Apr 2019 21:35:35 -0600
Message-Id: <20190404033541.14072-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support CPU-wide trace scenarios, introduce the notion
of process ID to ETR devices.  That way events monitoring the same process
can use the same etr_buf, allowing multiple CPUs to use the same sink.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index ac1efdfc0d07..e1774d4bb5f3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 #include <linux/vmalloc.h>
 #include "coresight-catu.h"
 #include "coresight-etm-perf.h"
@@ -25,6 +26,7 @@ struct etr_flat_buf {
 /*
  * etr_perf_buffer - Perf buffer used for ETR
  * @etr_buf		- Actual buffer used by the ETR
+ * @pid			- The PID this etr_perf_buffer belongs to.
  * @snaphost		- Perf session mode
  * @head		- handle->head at the beginning of the session.
  * @nr_pages		- Number of pages in the ring buffer.
@@ -32,6 +34,7 @@ struct etr_flat_buf {
  */
 struct etr_perf_buffer {
 	struct etr_buf		*etr_buf;
+	pid_t			pid;
 	bool			snapshot;
 	unsigned long		head;
 	int			nr_pages;
@@ -1276,6 +1279,7 @@ static void *tmc_alloc_etr_buffer(struct coresight_device *csdev,
 		return NULL;
 	}
 
+	etr_perf->pid = task_pid_nr(event->owner);
 	etr_perf->snapshot = snapshot;
 	etr_perf->nr_pages = nr_pages;
 	etr_perf->pages = pages;
-- 
2.17.1

