Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F482C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C68206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWC+GqB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfDYTyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40538 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbfDYTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so362609pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tPRA4UlOAMNFpacsoz6vhdGt52ZgMz7HCu722PCoiN0=;
        b=mWC+GqB4WCUVhVgkKCa1WVg10E9FnA/lO1+m4s3ll3IemPGb+DaTfhz6B47l3VfFl+
         qT4wJFj0utDvwAV0QlMnGkYDb927oi7iAjZwOp6ysmhuyVF81py15xVQXEuPkZomsvbC
         B3yBpQvbW0FlbtcikHvUbimOL4PSMNVNvdmea6w1smdP/S8KVDE+fJhODXirlDb08zke
         r0jKQ6Y0g9kuqPBm9WWnBHdbRiAwgjRtvaouQ5C1u3z2+Zf5QhnTEA0+pfbNlQC2Qu3O
         w3YNcd4Divzg7AykdQWgragipo9e8ybSVHv5aB6x04CJQVzwuza7wnRIn0zQs4psG2Ms
         yWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tPRA4UlOAMNFpacsoz6vhdGt52ZgMz7HCu722PCoiN0=;
        b=kA/o/+HHyYyupajVwjZMPsJY9cWYBRksZgJDzNYT59e5z+qm6S0Ah+cACHf8mBsfG8
         y0bbL970fsXCUVPseauR4OWy69IDf5g+JO7/oH6k1Rrljo5gqOB8SCvi5aOtNz9yKhha
         UlipUcCDhELSTZ9EAcXML2rkOQ6dZh4LdBcPyf5X1zI7SqXoRaG1b21QRlnOk0FYZl/k
         +nsu9phW1Z+oHkMghP5iLeSckVsST7AYN9MtjU7Ixm70O1vy9Uhc652XJGjZtg9v/ae1
         fN0grQqTWnGqqpBH+m0D/o0eumTBq9j1OFq0sRBt6KSoSclqtVLzZ657mOOsXRVkxsRr
         +yVQ==
X-Gm-Message-State: APjAAAWOTsTn6fRLW9yn7ztjjfZ1h46yaMyOByIDqRR6891T0KvZ5T8+
        ICr7vPVFc9ViiRulXz/42srcLw==
X-Google-Smtp-Source: APXvYqx5cgUVYHkBirEN88lB2BUD4jdSkRhVS3GvOXRr1kFXFyzLtbyxP3Iw1G6gn2m/6SHv3gRGVA==
X-Received: by 2002:a65:430a:: with SMTP id j10mr39734416pgq.143.1556222028371;
        Thu, 25 Apr 2019 12:53:48 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:47 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/32] coresight: tmc-etr: Introduce the notion of IDR to ETR devices
Date:   Thu, 25 Apr 2019 13:53:06 -0600
Message-Id: <20190425195310.31562-29-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In CPU-wide scenarios with an N:1 source/sink topology, sources share
the same sink.  In order to reuse the same sink for all sources an
IDR is needed to archive events that have already been accounted for.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++++
 drivers/hwtracing/coresight/coresight-tmc.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index c6a5462ebf27..9f9b2c514566 100644
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
@@ -450,6 +452,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
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

