Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8754EC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99466205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMAP7HcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbfDYTxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33525 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfDYTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so453440pfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=beHUlTV1r7N3uXY3Nh5y6OVMIGz+2muMwcMKI5ehutQ=;
        b=TMAP7HcQM3kb5W+gBxCS9kR+mSZpauCuGsJoRl7IcGegZXd7AnQ4n4RKfbmfvmpVvf
         CMi3nCKPjCi50t8XHwIww/3cA9joj1fXyECB1LqnaVnzikd0Xr3vTrcfCI8IdFAww5OZ
         SXmaeF76uT3ELakS0diC15XfhO6yozwd1rdNnhKrckZO6kpHouymel0r+a95LL3YmZdt
         Gu6q8MM+gGveBbyqgcQPhVlN5QGo55Pj+QdcO8BLJanDj+D84NxuQz4SGkvSfDE630xb
         9KiM0zRDoRLkufKrEDTdFlSxPAU17P/oFlxHapEiu6ol/D+7TA1tWThRRX8LD7pJ5lyt
         IQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=beHUlTV1r7N3uXY3Nh5y6OVMIGz+2muMwcMKI5ehutQ=;
        b=H0nkJGe34QsgQULKT7+Ladh9r3YcGYyvZ2FyTQWmisx/sAYugt3PrnyVxqnSkXHwFt
         al516PSICQ8NLtvodKImzC4czwqqlkO3Cd6Unw6XO2qLFd6xlUniPgpJhplZ/Tx5BUqL
         HJ3X83gXAfxxo0ERiDW57vf7iLZcUCYDuYnCCY4n92irQlxm7knTLkNEAKnkrzzI2wkE
         ENPlHPTnmgotOOZemCaff62zBGWZIPrP48Jb2D2jxAW9/SBzwSoZC1wEwGNX62WoDiVL
         UatiPoAL5gXUfbLFhFRZR/udBjk1ECCynhnK9aoXBsJyEGVjOJL5NrZblZThlZoqdjeZ
         anQg==
X-Gm-Message-State: APjAAAXOZqkTaRWfF1wc5hCC8XUCm9p8Qz0pje9eViWu2/ayHgHlLT9b
        mMaqpBmOMETONCOm6lTaBwbv8g==
X-Google-Smtp-Source: APXvYqzOvuEJWh2JGV9dlry1yCkhitl/qheCqY7eub1Ib4Cu218oRSV63bayQp3C2g2RuPDUeG3XOg==
X-Received: by 2002:a63:115c:: with SMTP id 28mr39368616pgr.270.1556222027096;
        Thu, 25 Apr 2019 12:53:47 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:46 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/32] coresight: tmc-etr: Introduce the notion of reference counting to ETR devices
Date:   Thu, 25 Apr 2019 13:53:05 -0600
Message-Id: <20190425195310.31562-28-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds reference counting to struct etr_buf so that, in CPU-wide
trace scenarios, shared buffers can be disposed of when no longer used.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 5 +++++
 drivers/hwtracing/coresight/coresight-tmc.h     | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 1acad42184e6..de33c0391186 100644
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
@@ -1222,7 +1223,11 @@ get_perf_etr_buf_per_thread(struct tmc_drvdata *drvdata,
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

