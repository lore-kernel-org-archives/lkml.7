Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF150CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F5D2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVYwJFxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfKDSNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43768 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbfKDSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id 3so12828302pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UoBtG+nF16UHzafLtrzcMC8PlFDrifr/5EvMb5ijQAs=;
        b=jVYwJFxeB6vT5IGMoonP3YF6fOpjwXCdfVOS/7OpSJX4cc4wXAj962jWkdB9GsBCxY
         bjHhNgBeA2Wm7EGhnkcZXmP62Jt4Uo6WmftW4ZmaPG9Xoq3lKYwZwI3+BAKuCuxz1IGu
         B6rbpe7+yCnDIM3QCEx8zpAxF+vB0bURB+tKN4patZAPNoZfFHHvtTZJsMVfcgxjAMq9
         WWCAZGyCSkc0BoG2GUS+qmk7k46nvqAE+KEAydo59RoC8UPRfp4OthjYV+v3tiW4rN4N
         8YQuDnqeOKhMqkwx5pxBv37c6L6CGZUs/tVRDIahaJl5bYHJGjWBGbi7CNKcvFpQqFdW
         SPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UoBtG+nF16UHzafLtrzcMC8PlFDrifr/5EvMb5ijQAs=;
        b=LWzDIhgHq6M7e4RqWSS57Mq1b8EBsK3Anx0yc1juz8sjyA/0RMLAygd7lK+pBub+Z1
         +1HSZTeseNA1MH/CeV8d2V4Huerz0udnGYHYyYp9n1gKYbx7pFa/qFee8qK5P1mTtgXG
         1Z52IiFdqBxe/OW/7MADNu1DNoXZLDd3qxy14IEF5NckqIeARilwU7whrOtSBN+fOOTA
         4a8yXRSbIQ7PgaVqGOSUarMQ1qccMhUIka+oSDfMDhmu4mGfSG3BPK3WjJdctlTdqM3D
         bfhFkoPyqwOVKjnLoNqkwKvuNvWwFtLxK6C9J2V3gwG1f+M81/zhudhGBJOuYV/PtVO4
         7vJg==
X-Gm-Message-State: APjAAAX/xzkEj3HCe+AGU8/lxmoOqMnBHuY4sEzDBhjSi9FEz2F2c+fL
        IgJOOQILLQYXp7GiLS2kpZ9wxdxtcQc=
X-Google-Smtp-Source: APXvYqy2pVmFXOrM1t9jafZsx/NWpJc1y7bO4erNYjx4pj2X6v2ZJU9v9q3SxbR8tGKo6k3FaDZFaw==
X-Received: by 2002:a63:e009:: with SMTP id e9mr24399463pgh.222.1572891180912;
        Mon, 04 Nov 2019 10:13:00 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:13:00 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] coresight: etm4x: Fix issues with start-stop logic.
Date:   Mon,  4 Nov 2019 11:12:44 -0700
Message-Id: <20191104181251.26732-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Fixes the following issues when using the ETMv4 start-stop logic.

1) Setting a start or a stop address should not automatically set the
start-stop status to 'on'. The value set by the user in 'mode' must
be respected or start instances could be missed.
2) Missing API for controlling TRCVIPCSSCTLR - start stop control by
PE comparators.
3) Default ETM configuration sets a trace all range, and correctly sets
the start-stop status bit. This was not being correctly reflected in
the 'mode' parameter.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 39 +++++++++++++++++--
 drivers/hwtracing/coresight/coresight-etm4x.c |  1 +
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 97a33cf98797..ea1e034809a0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -217,6 +217,7 @@ static ssize_t reset_store(struct device *dev,
 
 	/* No start-stop filtering for ViewInst */
 	config->vissctlr = 0x0;
+	config->vipcssctlr = 0x0;
 
 	/* Disable seq events */
 	for (i = 0; i < drvdata->nrseqstate-1; i++)
@@ -1059,8 +1060,6 @@ static ssize_t addr_start_store(struct device *dev,
 	config->addr_val[idx] = (u64)val;
 	config->addr_type[idx] = ETM_ADDR_TYPE_START;
 	config->vissctlr |= BIT(idx);
-	/* SSSTATUS, bit[9] - turn on start/stop logic */
-	config->vinst_ctrl |= BIT(9);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1116,8 +1115,6 @@ static ssize_t addr_stop_store(struct device *dev,
 	config->addr_val[idx] = (u64)val;
 	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
 	config->vissctlr |= BIT(idx + 16);
-	/* SSSTATUS, bit[9] - turn on start/stop logic */
-	config->vinst_ctrl |= BIT(9);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1274,6 +1271,39 @@ static ssize_t addr_exlevel_s_ns_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(addr_exlevel_s_ns);
 
+static ssize_t vinst_pe_cmp_start_stop_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	if (!drvdata->nr_pe_cmp)
+		return -EINVAL;
+	val = config->vipcssctlr;
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t size)
+{
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!drvdata->nr_pe_cmp)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	config->vipcssctlr = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(vinst_pe_cmp_start_stop);
+
 static ssize_t seq_idx_show(struct device *dev,
 			    struct device_attribute *attr,
 			    char *buf)
@@ -2080,6 +2110,7 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_addr_ctxtype.attr,
 	&dev_attr_addr_context.attr,
 	&dev_attr_addr_exlevel_s_ns.attr,
+	&dev_attr_vinst_pe_cmp_start_stop.attr,
 	&dev_attr_seq_idx.attr,
 	&dev_attr_seq_state.attr,
 	&dev_attr_seq_event.attr,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index efe120925f9d..d5148afdbe80 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -887,6 +887,7 @@ static void etm4_set_default_filter(struct etmv4_config *config)
 	 * in the started state
 	 */
 	config->vinst_ctrl |= BIT(9);
+	config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
 
 	/* No start-stop filtering for ViewInst */
 	config->vissctlr = 0x0;
-- 
2.17.1

