Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A30C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC0E206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TbcXk2fi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IfA3yBor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfC1P3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:29:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfC1P25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:28:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5559E6194E; Thu, 28 Mar 2019 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786935;
        bh=B9hm3m4js6tRmQZKwTll7Uw3VE0CDlgLZj4xvLuVkYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbcXk2fi2es4Ppg/D3jo8oLFvVguHs4EvouYX9fX5mZ7IrRvCFodQekhyhB1Icn3f
         o6QFgPlNLYMkBX7VVYiL/sL77BOBsu7MjAVe4IWbZ449jOLbC4p0yzQVN03YgnmHxR
         Hkzy9cam/CPd8sHxOxfFea0u0m3EXiEjOdSWooXQ=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31B2F618DC;
        Thu, 28 Mar 2019 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786931;
        bh=B9hm3m4js6tRmQZKwTll7Uw3VE0CDlgLZj4xvLuVkYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfA3yBor9su7O5UZqeivHo5AA2L9zSjoElFd/FXy9TimegOQjkhUute2Qx+mqM5md
         leHKmX8KSaehjADvplyAy97rloNdg+xfGbdjsOYKlBwlvGrYBTcZ3miYqF2m/AAzfO
         b3G6oA1VtRbBzK5fEGJ8RiJr/O29QAhCje6hNW5I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31B2F618DC
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
Subject: [PATCH RFC 2/9] OPP: Export a number of helpers to prevent code duplication
Date:   Thu, 28 Mar 2019 20:58:15 +0530
Message-Id: <20190328152822.532-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export 'dev_pm_opp_find_opp_of_np' and 'of_parse_required_nodes'
as it will be used by passive governor to parse and auto-populate
mapping specified using the required-opps property.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/of.c       | 13 +++++++++++--
 include/linux/pm_opp.h | 13 +++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 539f3d013a59..d9d8875eca05 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -98,8 +98,8 @@ static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
 	return NULL;
 }
 
-static struct device_node *of_parse_required_opp(struct device_node *np,
-						 int index)
+struct device_node *of_parse_required_opp(struct device_node *np,
+					  int index)
 {
 	struct device_node *required_np;
 
@@ -111,6 +111,15 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
 
 	return required_np;
 }
+EXPORT_SYMBOL_GPL(of_parse_required_opp);
+
+/* The caller must call dev_pm_opp_put() after the OPP is used */
+struct dev_pm_opp *dev_pm_opp_find_opp_of_np(struct opp_table *opp_table,
+					     struct device_node *opp_np)
+{
+	return _find_opp_of_np(opp_table, opp_np);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_opp_of_np);
 
 /* The caller must call dev_pm_opp_put_opp_table() after the table is used */
 static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 82ff8e2e1ff7..d7cb0e65c4f0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -359,8 +359,11 @@ void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
+struct device_node *of_parse_required_opp(struct device_node *np, int index);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 void dev_pm_opp_of_register_em(struct cpumask *cpus);
+struct dev_pm_opp *dev_pm_opp_find_opp_of_np(struct opp_table *opp_table,
+					     struct device_node *opp_np);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -390,6 +393,11 @@ static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct
 	return -ENOTSUPP;
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_opp_of_np(struct opp_table *opp_table, struct device_node *opp_np)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 {
 	return NULL;
@@ -408,6 +416,11 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
 {
 	return -ENOTSUPP;
 }
+
+static inline struct device_node *of_parse_required_opp(struct device_node *np, int index)
+{
+	return NULL;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

