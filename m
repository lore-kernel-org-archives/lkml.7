Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB11EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EC9214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/JCX4Jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfHIUXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:23:34 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42705 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfHIUXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:23:33 -0400
Received: by mail-pg1-f201.google.com with SMTP id l12so13675769pgt.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kc//5wSK6WFlmTTvjwkok8tpntxs4Pv501PXTXdOfnc=;
        b=p/JCX4JhVEw8kIjVj8ThqkCPM1bt8O7sHsmAgsHuB1eIMXYdn28R//CrTjTd/ikSf4
         qv1AvwyfwMZ8B9jv+EIxv4udxMLY5yxfx3cgCDSozVoNdmU01CwY++sXeEhic+fQW+mB
         eD13JyLXksSENbq7Lc9O2HkyIHs15JzyRV77eG23VPM3j8JRAan2/D15AdHmKUhEwIfh
         jj9IAhXzzBVEqjYdPukdVLXh3RIiTRO9Tz3U8fmpUFG+mQ2pxT3s6OTIGrwFQfUPJEeZ
         CfQdaco/0I1C8clYTr6Ko2xI1WK/GBmbW3VMKyb5eGpU0raw6N99u4AGOWC59yT85XjA
         p9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kc//5wSK6WFlmTTvjwkok8tpntxs4Pv501PXTXdOfnc=;
        b=lUlg5rvjcZbRQHPDlcK9z73QNYIKd3vsj6drCxblWII34rXklvmvGq4GUrPcz8Dmlf
         RSu4a0miqRl3k2e24wHZM5oaEvr8aBJGfLHTSNgLmQWNoYQiXP+0+sx86QIM9yzG9ulr
         C+VouFodTU+GRTq6U2k5udhb01fnyp8xuCMgR8Do4aGz/H7xknd8WPj/KOTd+3zo1voE
         /f0K5Xha2lyda6orHrvsD4frCWl7pCp3p7RGUVnY8byfRMMuJ/tEKND1HVLE1i3lVKFA
         w3k0TdyKnIg6fiOVum89yRTcsewDnZuyHbMaBTA47bdVtZ+tUTxyuoyqX1Uu9wx2ui9O
         BoNA==
X-Gm-Message-State: APjAAAVW7GQM9GnCH9QbpzymPi5EgbDotA0dv+RTFXJIg+Asy4jlx7BU
        3X2c33oQsXrwp2tQ7PQ2Hvrj4SVsMQ==
X-Google-Smtp-Source: APXvYqxLO2V9UFMc9qr25x7OcMR5AOc0D3uL5g1LYV4IcMbzip8K0MF+Fmc0o3cY2cF7wDZOfl0O0wJ4VJo=
X-Received: by 2002:a63:211c:: with SMTP id h28mr18867782pgh.438.1565382212981;
 Fri, 09 Aug 2019 13:23:32 -0700 (PDT)
Date:   Fri,  9 Aug 2019 13:23:30 -0700
Message-Id: <20190809202330.51183-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH] coresight: tmc-etr: Fix perf_data check.
From:   Yabin Cui <yabinc@google.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing etm data of multiple threads on multiple cpus through
perf interface, each cpu has a unique etr_perf_buffer while sharing
the same etr device. There is no guarantee that the last cpu starts
etm tracing also stops last. This makes perf_data check fail.

Fix it by checking etr_buf instead of etr_perf_buffer.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 17006705287a..f466f05afe08 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1484,7 +1484,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 		goto out;
 	}
 
-	if (WARN_ON(drvdata->perf_data != etr_perf)) {
+	if (WARN_ON(drvdata->perf_data != etr_buf)) {
 		lost = true;
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		goto out;
@@ -1556,7 +1556,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	}
 
 	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
-	drvdata->perf_data = etr_perf;
+	drvdata->perf_data = etr_perf->etr_buf;
 
 	/*
 	 * No HW configuration is needed if the sink is already in
-- 
2.23.0.rc1.153.gdeed80330f-goog

