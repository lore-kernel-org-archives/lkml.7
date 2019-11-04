Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ACECA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24D02080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1jb8Ocw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfKDSNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42085 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbfKDSNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id s5so4591253pfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+l5F417FgwxWcTtFu32EwI1EYbG0FhwLJDw4Yrt6Kk=;
        b=a1jb8OcwTE5t6kokOfUIYVmLkWL2FZZgFIN/0R5uVkBpmKKDWvJfCvPfJ9u8yB8Kf8
         NTYF3XWmVTiaxaNVI32u9UZmU5S+IS08LieUsFQCNBRqlL9X8OJqF/sARnquhMvO75/Y
         u5RXCedd4ox1Jw6PcwNFBSW6IQXUOSYq/74z0p/hT6/d2jnWw9niOxQVdYx9gHNJ1evp
         U5GRkytFxc9LurRnKgxfZU8Nh1B+6qqbkdCPXF0puBUkhJdlYIWgdJQqoMmIY5O494AJ
         zycuKZEwFVUJwV3QkUlpeRJpzomlzAhsRU5TuINBJeTDcM+2v1UbRJQFYB6bSImL5fH7
         WBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+l5F417FgwxWcTtFu32EwI1EYbG0FhwLJDw4Yrt6Kk=;
        b=FUtJgCiCEQaK+AYq26AlUQOo1xIDi8xQb/scMH/IPS/OfMlnYjM1zQYtphY4kIHnvV
         U6/+AwG6vd1JdyBJ+aqinao0fStfMRE2+lprtvLKTN4FdIHaPyEqMFrRw2cW6kHkhwy4
         TbiB7KVVTYYRLl3jwK0g6M4vRC2QsS2Cbh0ys5lNKSaWoUvQ39QXo4epqMwZ60AiZdJZ
         Ajl96ZtsGcQ0gmqB6uqRa/xX6g6Hy6Wl0SrS3SALgmUyJlW2UGfBuxVMMdQyB7VIZvFI
         E/UkbOxtWnAO3kqjRxYEZ59lo91TVLXCgudMig2WN4ZCuOuWAKtgEheHBYdokixETk89
         j4ww==
X-Gm-Message-State: APjAAAXOeyzhueIJfkx4bkZ1U//CQ+h/dVyKXtwYdQbfcfg11IYISzsr
        GoNuGfONdbvXoUul+gGm3NaQtEUmEcM=
X-Google-Smtp-Source: APXvYqzCIazSOlhg8dtcxCKtg7yczg0yxQQqajiW7v+NNEdksIMYQDL6Q4pZV46stS56NlEV7na6IA==
X-Received: by 2002:a17:90a:7188:: with SMTP id i8mr601428pjk.54.1572891181785;
        Mon, 04 Nov 2019 10:13:01 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:13:01 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] coresight: etm4x: Improve usability of sysfs - include/exclude addr.
Date:   Mon,  4 Nov 2019 11:12:45 -0700
Message-Id: <20191104181251.26732-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Setting include / exclude on a range had to be done by setting
the bit in 'mode' before setting the range. However, setting this
bit also had the effect of altering the current range as well.

Changed to only set include / exclude setting of a range at the point of
setting that range. Either use a 3rd input parameter as the include exclude
value, or if not present use the current value of 'mode'. Do not change
current range when 'mode' changes.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index ea1e034809a0..8c056dd1a55e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -297,8 +297,6 @@ static ssize_t mode_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	config->mode = val & ETMv4_MODE_ALL;
-	etm4_set_mode_exclude(drvdata,
-			      config->mode & ETM_MODE_EXCLUDE ? true : false);
 
 	if (drvdata->instrp0 == true) {
 		/* start by clearing instruction P0 field */
@@ -972,8 +970,12 @@ static ssize_t addr_range_store(struct device *dev,
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
+	int elements, exclude;
 
-	if (sscanf(buf, "%lx %lx", &val1, &val2) != 2)
+	elements = sscanf(buf, "%lx %lx %x", &val1, &val2, &exclude);
+
+	/*  exclude is optional, but need at least two parameter */
+	if (elements < 2)
 		return -EINVAL;
 	/* lower address comparator cannot have a higher address value */
 	if (val1 > val2)
@@ -1001,9 +1003,11 @@ static ssize_t addr_range_store(struct device *dev,
 	/*
 	 * Program include or exclude control bits for vinst or vdata
 	 * whenever we change addr comparators to ETM_ADDR_TYPE_RANGE
+	 * use supplied value, or default to bit set in 'mode'
 	 */
-	etm4_set_mode_exclude(drvdata,
-			      config->mode & ETM_MODE_EXCLUDE ? true : false);
+	if (elements != 3)
+		exclude = config->mode & ETM_MODE_EXCLUDE;
+	etm4_set_mode_exclude(drvdata, exclude ? true : false);
 
 	spin_unlock(&drvdata->spinlock);
 	return size;
-- 
2.17.1

