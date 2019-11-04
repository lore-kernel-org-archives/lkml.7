Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5054CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9BD2184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMQbpOtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfKDSNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34649 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfKDSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id e4so11880994pgs.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7stn5BvcqloAoNFXBRjk24YnQtbNG8jrtuNQJLNGPFg=;
        b=EMQbpOtI2YNym5gI75LlpBcBp14xUt5R7POgwM7ZPd9UULrfsWzvLsBIy0RkRVMprw
         vLnspaQOxFB1BYjNjYrhC6eSCyqdMOlvaosK530wtsApKQVKpRieKHKJFahv6E9avbXD
         vtAFBxBriElcz+PI689voveZ014HXJbT74mdK6zrubEhk3UJjIKRT9AyKaHGiJhXn13x
         c2k/omTkcmBzJsJMLJhM+28dBfx7G0QAwbI6KY1N2Ml536/XZ3pRUDLnnhuZld/KO/zB
         xGyEFN+3GcnMsF6BWXu3wNquc5Tkj7h47UE2r+t1roOHuxrUVdTzVy+OWQmbUubOXvtT
         iqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7stn5BvcqloAoNFXBRjk24YnQtbNG8jrtuNQJLNGPFg=;
        b=R7gEY84Fn1UprcMDA3XQzKqCz8W09eR6AQUEty3j/rt/2NJsAtSyl6zgP1xEByIvfA
         U2MOA17IFByCXLb6CXwQD4uJow6vPaPYpzn3KjFgvGsjr2WlUWWRkPbQ2+NBKSmh9A6V
         LvX3OnMni5iPLOEfBinszc6QbuT+REWm93soHcKc5w98xAmKiWzYIRFiFux9m0VK74Bh
         IbolwlvUZEjizsT5HvDBI6qGuvpk+Y751n+jaV2/fyAMcvjxgHzxeusGGivjaO8OBvPh
         nuRrq1gk6aznfiHtSDzXXNGf1vt/HxGPlcWgiuOVX7H4w8ybB2zJHXf0KD8iTtyCN1kC
         Cvxg==
X-Gm-Message-State: APjAAAU76+7RNYdRi3u7Bvq5osdkkQqwx00UNa0TsLNZqjECZA4imlEK
        +s5KDtH0nT2Ib1UbcGPdC0kouQ==
X-Google-Smtp-Source: APXvYqzkQy2pzCtrTxcMra33CDej6fLIaKuyqjk5BkOvfXv7zUxPzz3Io93GJfRoooqN07tfN+gfrQ==
X-Received: by 2002:a63:1c03:: with SMTP id c3mr30491255pgc.198.1572891182711;
        Mon, 04 Nov 2019 10:13:02 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:13:02 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] coresight: etm4x: Improve usability of sysfs - CID and VMID masks.
Date:   Mon,  4 Nov 2019 11:12:46 -0700
Message-Id: <20191104181251.26732-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Context ID and VM ID masks required 2 value inputs, even when the
second value is ignored as insufficient CID / VMID comparators are
implemented.

Permit a single value to be used if that is sufficient to cover all
implemented comparators.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 8c056dd1a55e..1cfbddda0b4d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1794,6 +1794,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	unsigned long val1, val2, mask;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
+	int nr_inputs;
 
 	/*
 	 * Don't use contextID tracing if coming from a PID namespace.  See
@@ -1809,7 +1810,9 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	 */
 	if (!drvdata->ctxid_size || !drvdata->numcidc)
 		return -EINVAL;
-	if (sscanf(buf, "%lx %lx", &val1, &val2) != 2)
+	/* one mask if <= 4 comparators, two for up to 8 */
+	nr_inputs = sscanf(buf, "%lx %lx", &val1, &val2);
+	if ((drvdata->numcidc > 4) && (nr_inputs != 2))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
@@ -1983,6 +1986,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 	unsigned long val1, val2, mask;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
+	int nr_inputs;
 
 	/*
 	 * only implemented when vmid tracing is enabled, i.e. at least one
@@ -1990,7 +1994,9 @@ static ssize_t vmid_masks_store(struct device *dev,
 	 */
 	if (!drvdata->vmid_size || !drvdata->numvmidc)
 		return -EINVAL;
-	if (sscanf(buf, "%lx %lx", &val1, &val2) != 2)
+	/* one mask if <= 4 comparators, two for up to 8 */
+	nr_inputs = sscanf(buf, "%lx %lx", &val1, &val2);
+	if ((drvdata->numvmidc > 4) && (nr_inputs != 2))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-- 
2.17.1

