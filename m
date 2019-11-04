Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63899CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D67F2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncL1xXHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfKDSNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44685 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbfKDSNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so12824108pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y7fhR2xIT71DtVa1uCjsmuyALGEUbfwLZ/uWrAtc5Ds=;
        b=ncL1xXHW8P5PY1KFS4fr2rCjeF2sMk7iCiCvP5ewN58vIqpf6Rk7KIPwWJ4UL8t5YD
         YYnfOLoEGsFqg7qgmY4p8cERoL3Uj+k3kbnmUKhvlr9kQFM3wojFfN3ZM65dBok06MfV
         wSXhWlJmSdmEquXZz/Ly5hdUm4ZKvCxsJrnfuM4hTXRBPA9aMaHGfUG9CCweujtLSB5D
         Z0PyiIe36Z3vKEgKByN+KrWgLj4Fw1J2XjbHNts9//oUwu4rn8VpybUEkPpVVhRSAEsk
         5V9EOoMUphNsDxdm2mQ0yF1JDGS6ULnV94+Qv8m7pCID4hQ9DBBNFeUoG2qB/siHWBdL
         nKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y7fhR2xIT71DtVa1uCjsmuyALGEUbfwLZ/uWrAtc5Ds=;
        b=MCG935es5SkdSatzpNe16/6hGlvxBuDo2TnIgDsA1MvYI2dB3AqHtT5qugFWNQGNOu
         DTGMSt8FM38T4Tdt97HC3LaJ6hAn5BVo+zW6mYBNHUWtH2UZAZ8A6Se7w1oF5xnW/kFK
         4cM5eh9Lv+Z7gBVha3s89riy02LJr9VZX4aQyD0BFhvdDD6Y1frZSIcDKFYxgb+qqmZR
         rC0DBXc6cclR7ojVezKEAsL/B3T1iVqPOu/n8e6L+7AqrQSMwCA8i5WXjicdFCy0qTiV
         Wnoo3j4NhxhL2V5KYjLMD97W9LrIgVW/oyEF5Cu5l5vQKtdpE2zGXrPVm2MOwi53tOuH
         GE/g==
X-Gm-Message-State: APjAAAUxOVvr0UZDFISdk451QdiTCFGkFWfd5Rp/KTlV89sd51CfeHVQ
        64Verw6mKj+Z1nAb7lzTkFgNKl5NpcI=
X-Google-Smtp-Source: APXvYqwcjS8PQWDXoU04+7uYKJgaNIt5TMbPyiNLgdD8R3/8rHEJehtKvK3piISL7+DIS4jVvvUjwA==
X-Received: by 2002:a63:2d81:: with SMTP id t123mr31539251pgt.306.1572891179732;
        Mon, 04 Nov 2019 10:12:59 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:12:59 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] coresight: etm4x: Add missing API to set EL match on address filters
Date:   Mon,  4 Nov 2019 11:12:43 -0700
Message-Id: <20191104181251.26732-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

TRCACATRn registers have match bits for secure and non-secure exception
levels which are not accessible by the sysfs API.
This adds a new sysfs parameter to enable this - addr_exlevel_s_ns.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index cc8156318018..97a33cf98797 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1233,6 +1233,47 @@ static ssize_t addr_context_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(addr_context);
 
+static ssize_t addr_exlevel_s_ns_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	u8 idx;
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	spin_lock(&drvdata->spinlock);
+	idx = config->addr_idx;
+	val = BMVAL(config->addr_acc[idx], 14, 8);
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t addr_exlevel_s_ns_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t size)
+{
+	u8 idx;
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if (val & ~((GENMASK(14, 8) >> 8)))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	idx = config->addr_idx;
+	/* clear Exlevel_ns & Exlevel_s bits[14:12, 11:8], bit[15] is res0 */
+	config->addr_acc[idx] &= ~(GENMASK(14, 8));
+	config->addr_acc[idx] |= (val << 8);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(addr_exlevel_s_ns);
+
 static ssize_t seq_idx_show(struct device *dev,
 			    struct device_attribute *attr,
 			    char *buf)
@@ -2038,6 +2079,7 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_addr_stop.attr,
 	&dev_attr_addr_ctxtype.attr,
 	&dev_attr_addr_context.attr,
+	&dev_attr_addr_exlevel_s_ns.attr,
 	&dev_attr_seq_idx.attr,
 	&dev_attr_seq_state.attr,
 	&dev_attr_seq_event.attr,
-- 
2.17.1

