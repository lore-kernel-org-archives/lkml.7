Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94701C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B6A206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ajRp/hqn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bPWlLHhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfC1P3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:29:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfC1P3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:29:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E772861F81; Thu, 28 Mar 2019 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786960;
        bh=BVhb2m6ms/9S31/QcRfv2NsjtFeog5ga38D1sOsl8s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajRp/hqnN0P01hUdBqT5KjCdvywBmmpdSuX7hFJxvVkOlgHGbc2j4dZtST3Amg5VC
         bzDGZNg9B4i8LhX2TvM81qeutg4mxyuVqQIsJwGYOQ/d0+MjXyu6i7wYKypITxe0Kk
         Po23jrzVi4bmLgqhtArcM26kknDeunx2wsT86rOM=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F83C614DB;
        Thu, 28 Mar 2019 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786958;
        bh=BVhb2m6ms/9S31/QcRfv2NsjtFeog5ga38D1sOsl8s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPWlLHhGI/cQfhltDx6TqCvNa2NXxl1KGnAJYx0d+8U0z/i+xJf+nyLkpJWjiTTbY
         BsLkwOpSC4W7a6FvQvZ51eJ2zc8bSId8bxJiAbg3oIkmlC3Frt95HdImGXQURS1jV7
         h0wM/A4c7nX/NsbNmAZhED9TdDTdI93PCP6x3stc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F83C614DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 6/9] OPP: Add and export helper to update voltage
Date:   Thu, 28 Mar 2019 20:58:19 +0530
Message-Id: <20190328152822.532-7-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and export 'dev_pm_opp_update_voltage' to find and update voltage
of an opp for a given frequency. This will be useful to update the opps
with voltages read back from firmware.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/core.c     | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 10 +++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index addaf7aae9ae..c066cd120a33 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2090,6 +2090,68 @@ int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_disable);
 
+static int _opp_update_voltage(struct device *dev, unsigned long freq,
+			       unsigned long u_volt)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
+	int r = 0;
+
+	/* Find the opp_table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		r = PTR_ERR(opp_table);
+		dev_warn(dev, "%s: Device OPP not found (%d)\n", __func__, r);
+		return r;
+	}
+
+	mutex_lock(&opp_table->lock);
+
+	/* Do we have the frequency? */
+	list_for_each_entry(tmp_opp, &opp_table->opp_list, node) {
+		if (tmp_opp->rate == freq) {
+			opp = tmp_opp;
+			break;
+		}
+	}
+
+	if (IS_ERR(opp)) {
+		r = PTR_ERR(opp);
+		goto unlock;
+	}
+
+	/* update only if the opp is disabled */
+	if (opp->available)
+		goto unlock;
+
+	opp->supplies[0].u_volt = u_volt;
+
+unlock:
+	mutex_unlock(&opp_table->lock);
+	dev_pm_opp_put_opp_table(opp_table);
+	return r;
+}
+
+/**
+ * dev_pm_opp_update_voltage() - find and update voltage of an opp
+ *				 for a given frequency
+ * @dev:	device for which we do this operation
+ * @freq:	OPP frequency to update voltage
+ * @u_volt:	voltage requested for this opp
+ *
+ * This is useful only for devices with single power supply.
+ *
+ * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
+ * copy operation, returns 0 if no modification was done OR modification was
+ * successful.
+ */
+int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt)
+{
+	return _opp_update_voltage(dev, freq, u_volt);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_update_voltage);
+
 /**
  * dev_pm_opp_register_notifier() - Register OPP notifier for the device
  * @dev:	Device for which notifier needs to be registered
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index d7cb0e65c4f0..58490f6839ce 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -130,6 +130,9 @@ int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
 int dev_pm_opp_disable(struct device *dev, unsigned long freq);
 
+int dev_pm_opp_update_voltage(struct device *dev, unsigned long freq,
+			      unsigned long u_volt);
+
 int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_opp_unregister_notifier(struct device *dev, struct notifier_block *nb);
 
@@ -265,6 +268,13 @@ static inline int dev_pm_opp_disable(struct device *dev, unsigned long freq)
 	return 0;
 }
 
+static inline int dev_pm_opp_update_voltage(struct device *dev,
+					    unsigned long freq,
+					    unsigned long u_volt)
+{
+	return 0;
+}
+
 static inline int dev_pm_opp_register_notifier(struct device *dev, struct notifier_block *nb)
 {
 	return -ENOTSUPP;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

