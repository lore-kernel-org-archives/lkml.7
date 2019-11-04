Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ACDCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AFF2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzAlnjmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfKDSN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36714 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbfKDSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:13:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id v19so12848457pfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RUUAX/bpgKOoYdqsMy2RyiY7Jv3TB4H8rCWJgZ2XPlo=;
        b=fzAlnjmVK1lVZ+kMaVRUiNKIXpyjmmer9EJQAHLy3om7kOc//Dw0QjKBlo+Qkuxfz1
         9BlvWNnTl5cGV1eiwV72LMhbuYuCLLzzgeVNOKmiWVl0gXN1kBwWYrm9/H2wzt02CBnj
         FRNHkDp0l/bHlMdgpXySUFc6a/blQzLkpIBsfY9cjfNQm5VrkK4A7yYAzjJj1C4gA0r5
         uvd3lDuSnFmyMCqYgl/SYeySyOusNl616qlz2HV+Vqz+OUbiheNDoA+A6BP4vSQ3Du3N
         +uqK+x6DPCsuU1LcWjmFnSluDXnf3B4n5hecGAXrwJQBepxa4xOqEzrsgs02tmFC/+Nn
         MCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RUUAX/bpgKOoYdqsMy2RyiY7Jv3TB4H8rCWJgZ2XPlo=;
        b=ZftzLcCbUkBDe7sfszAr86jqS1ZxiUC27HSfMqd50XYUxNntZj2YwHjAfx3DjVmi5t
         KoL8OmPoO2nRIxe/7yXnP3OYwwCuw8SjtmTMzo01EbOKs21Ojve4EoNimWAj9k7s/8q4
         sdWdwHfIFJapb31alD0pjt8khMVD0lQ/fDnnG+28DyqUO9ELs8pZ3atsvOq95Qe6bVhL
         no2sbmTJLxxKfWup40kuVTtc69rzxX5X2yegxx+eTHUmVNqHhqHDaLhY81FrahfpwelD
         NTezFEZyJeSziE4tYZ+vEF4O5r8UFvdzP1xi449UiBuNhb5pxopcPVwEHGfHGpK2pNMm
         RAmw==
X-Gm-Message-State: APjAAAUMJ5e6T0AF97mHEDzSOM71ndhxX+lrrIljYY5TshPWz+HThpn+
        3EHH687TroZuulRPXz8GW+ZT3Ke/nJU=
X-Google-Smtp-Source: APXvYqzXrKr8ouhsNu6T2yuCtriF0tQdcHbc4EkyBX+mKYjS9ZZJkwMpWdOhaYp5FV/RpgxsVwSAkQ==
X-Received: by 2002:a63:b909:: with SMTP id z9mr31246808pge.136.1572891185130;
        Mon, 04 Nov 2019 10:13:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:13:04 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] coresight: etm4x: Add missing single-shot control API to sysfs
Date:   Mon,  4 Nov 2019 11:12:48 -0700
Message-Id: <20191104181251.26732-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

An API to control single-shot comparator operation was missing from sysfs.
This adds the parameters to sysfs to allow programming of this feature.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 122 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.c |  26 +++-
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 1768e7286a9e..3fc12ac44270 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -239,6 +239,7 @@ static ssize_t reset_store(struct device *dev,
 	for (i = 0; i < drvdata->nr_resource; i++)
 		config->res_ctrl[i] = 0x0;
 
+	config->ss_idx = 0x0;
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		config->ss_ctrl[i] = 0x0;
 		config->ss_pe_cmp[i] = 0x0;
@@ -1717,6 +1718,123 @@ static ssize_t res_ctrl_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(res_ctrl);
 
+static ssize_t sshot_idx_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	val = config->ss_idx;
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t sshot_idx_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (val >= drvdata->nr_ss_cmp)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	config->ss_idx = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(sshot_idx);
+
+static ssize_t sshot_ctrl_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	spin_lock(&drvdata->spinlock);
+	val = config->ss_ctrl[config->ss_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t sshot_ctrl_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	u8 idx;
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	idx = config->ss_idx;
+	config->ss_ctrl[idx] = val & GENMASK(24, 0);
+	/* must clear bit 31 in related status register on programming */
+	config->ss_status[idx] &= ~BIT(31);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(sshot_ctrl);
+
+static ssize_t sshot_status_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	spin_lock(&drvdata->spinlock);
+	val = config->ss_status[config->ss_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+static DEVICE_ATTR_RO(sshot_status);
+
+static ssize_t sshot_pe_ctrl_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	spin_lock(&drvdata->spinlock);
+	val = config->ss_pe_cmp[config->ss_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t sshot_pe_ctrl_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	u8 idx;
+	unsigned long val;
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct etmv4_config *config = &drvdata->config;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	idx = config->ss_idx;
+	config->ss_pe_cmp[idx] = val & GENMASK(7, 0);
+	/* must clear bit 31 in related status register on programming */
+	config->ss_status[idx] &= ~BIT(31);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(sshot_pe_ctrl);
+
 static ssize_t ctxid_idx_show(struct device *dev,
 			      struct device_attribute *attr,
 			      char *buf)
@@ -2173,6 +2291,10 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	&dev_attr_addr_exlevel_s_ns.attr,
 	&dev_attr_addr_cmp_view.attr,
 	&dev_attr_vinst_pe_cmp_start_stop.attr,
+	&dev_attr_sshot_idx.attr,
+	&dev_attr_sshot_ctrl.attr,
+	&dev_attr_sshot_pe_ctrl.attr,
+	&dev_attr_sshot_status.attr,
 	&dev_attr_seq_idx.attr,
 	&dev_attr_seq_state.attr,
 	&dev_attr_seq_event.attr,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index d5148afdbe80..dc3f507e7562 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -168,6 +168,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+		/* always clear status bit on restart if using single-shot */
+		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
+			config->ss_status[i] &= ~BIT(31);
 		writel_relaxed(config->ss_ctrl[i],
 			       drvdata->base + TRCSSCCRn(i));
 		writel_relaxed(config->ss_status[i],
@@ -467,6 +470,9 @@ static void etm4_disable_hw(void *info)
 {
 	u32 control;
 	struct etmv4_drvdata *drvdata = info;
+	struct etmv4_config *config = &drvdata->config;
+	struct device *etm_dev = &drvdata->csdev->dev;
+	int i;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -489,6 +495,18 @@ static void etm4_disable_hw(void *info)
 	isb();
 	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
 
+	/* wait for TRCSTATR.PMSTABLE to go to '1' */
+	if (coresight_timeout(drvdata->base, TRCSTATR,
+			      TRCSTATR_PMSTABLE_BIT, 1))
+		dev_err(etm_dev,
+			"timeout while waiting for PM stable Trace Status\n");
+
+	/* read the status of the single shot comparators */
+	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+		config->ss_status[i] =
+			readl_relaxed(drvdata->base + TRCSSCSRn(i));
+	}
+
 	coresight_disclaim_device_unlocked(drvdata->base);
 
 	CS_LOCK(drvdata->base);
@@ -595,6 +613,7 @@ static void etm4_init_arch_data(void *info)
 	u32 etmidr4;
 	u32 etmidr5;
 	struct etmv4_drvdata *drvdata = info;
+	int i;
 
 	/* Make sure all registers are accessible */
 	etm4_os_unlock(drvdata);
@@ -718,9 +737,14 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nr_resource = BMVAL(etmidr4, 16, 19) + 1;
 	/*
 	 * NUMSSCC, bits[23:20] the number of single-shot
-	 * comparator control for tracing
+	 * comparator control for tracing. Read any status regs as these
+	 * also contain RO capability data.
 	 */
 	drvdata->nr_ss_cmp = BMVAL(etmidr4, 20, 23);
+	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+		drvdata->config.ss_status[i] =
+			readl_relaxed(drvdata->base + TRCSSCSRn(i));
+	}
 	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
 	drvdata->numcidc = BMVAL(etmidr4, 24, 27);
 	/* NUMVMIDC, bits[31:28] number of VMID comparators for tracing */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index b873df38e7d8..4a695bf90582 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -227,6 +227,7 @@
  * @cntr_val:	Sets or returns the value for a counter.
  * @res_idx:	Resource index selector.
  * @res_ctrl:	Controls the selection of the resources in the trace unit.
+ * @ss_idx:	Single-shot index selector.
  * @ss_ctrl:	Controls the corresponding single-shot comparator resource.
  * @ss_status:	The status of the corresponding single-shot comparator.
  * @ss_pe_cmp:	Selects the PE comparator inputs for Single-shot control.
@@ -270,6 +271,7 @@ struct etmv4_config {
 	u32				cntr_val[ETMv4_MAX_CNTR];
 	u8				res_idx;
 	u32				res_ctrl[ETM_MAX_RES_SEL];
+	u8				ss_idx;
 	u32				ss_ctrl[ETM_MAX_SS_CMP];
 	u32				ss_status[ETM_MAX_SS_CMP];
 	u32				ss_pe_cmp[ETM_MAX_SS_CMP];
-- 
2.17.1

