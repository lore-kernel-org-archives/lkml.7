Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BFCC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 23:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3CB216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 23:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LNss/Saq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfEQXjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 19:39:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42244 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfEQXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 19:39:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so4393045pfw.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 16:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FB9+ZeIs7u0h7ohxBYUtuZDUDJZtp9kucwEKAmls48s=;
        b=LNss/SaqshaaNsFNCClCxWl2TznHGB9yXArqGD6pKCgMNGiaedx0lGdyUcKul/OcMn
         z5Q+fxQfM3OZ3btfbrfB+fClA+xxX6KXeijJcpFEZUjfQnL6GTesx9mW1lDOaxfkWSIQ
         WQOnB/CzMD611ZDSPKKWEMPwZzH8Ol2qFk1Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FB9+ZeIs7u0h7ohxBYUtuZDUDJZtp9kucwEKAmls48s=;
        b=G1pfl6GlLepgrbYGPmBH1UZDQN8tWVwE9GRGHZszSQyV98IHNIGV1m2KHbGyBSO8EO
         DzSiatBYy1N6EOdmHNH4f4ptRyUAVWVq4NTtaaaDn9XHh2sELjDF2rtebf90Uxq/BSwR
         1M0gxYWio26f3cXPs4h4MznW+oLXDOLKEg3WeC43I8/bM1u/I1cwfyl/Jy94hXKl/u0q
         VIeO57R7DGwjUn49xld8FA5WdV5SqqT8dnc5EWJQPsVBBnD6hEdtZVuudsHbigJXkLPC
         v3G1Clzd7zYE8Gza6C10n5pYRse/mSvBCj23bERrFfMCW1BfJhm6G3/sTITuiRMNFA+1
         QbmA==
X-Gm-Message-State: APjAAAW8/3qAnJPvjet2/vsYZ7kMqrXmvcEdkQ1Ub/EEavMrCryq/eRz
        sXT/HU911botv3emeYO8pobVzg==
X-Google-Smtp-Source: APXvYqz36vT7rRSakd+rAKr68wnyAr1KKufkyiB6WmC1pIdfThuX84MlueZ+rFRhob79yUKzlj5L8w==
X-Received: by 2002:a63:78cf:: with SMTP id t198mr22782668pgc.82.1558136344159;
        Fri, 17 May 2019 16:39:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id f4sm11447716pfn.118.2019.05.17.16.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 16:39:03 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 1/2] mfd: cros_ec: Register cros_ec_lid_angle driver when presented
Date:   Fri, 17 May 2019 16:38:55 -0700
Message-Id: <20190517233856.155793-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190517233856.155793-1-gwendal@chromium.org>
References: <20190517233856.155793-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register driver when EC indicates has precise lid angle calculation code
running.
Fix incorrect extra resource allocation in cros_ec_sensors_register().

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v7:
- Split patch in two: This is the MFD section.

 drivers/mfd/cros_ec_dev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 54a58df571b6..d992365472b8 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -297,13 +297,15 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 
 	resp = (struct ec_response_motion_sense *)msg->data;
 	sensor_num = resp->dump.sensor_count;
-	/* Allocate 1 extra sensors in FIFO are needed */
-	sensor_cells = kcalloc(sensor_num + 1, sizeof(struct mfd_cell),
+	/*
+	 * Allocate 2 extra sensors if lid angle sensor and/or FIFO are needed.
+	 */
+	sensor_cells = kcalloc(sensor_num + 2, sizeof(struct mfd_cell),
 			       GFP_KERNEL);
 	if (sensor_cells == NULL)
 		goto error;
 
-	sensor_platforms = kcalloc(sensor_num + 1,
+	sensor_platforms = kcalloc(sensor_num,
 				   sizeof(struct cros_ec_sensor_platform),
 				   GFP_KERNEL);
 	if (sensor_platforms == NULL)
@@ -363,6 +365,11 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 		sensor_cells[id].name = "cros-ec-ring";
 		id++;
 	}
+	if (cros_ec_check_features(ec,
+				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
+		sensor_cells[id].name = "cros-ec-lid-angle";
+		id++;
+	}
 
 	ret = mfd_add_devices(ec->dev, 0, sensor_cells, id,
 			      NULL, 0, NULL);
-- 
2.21.0.1020.gf2820cf01a-goog

