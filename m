Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69C9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB74422520
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGdbKr2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfKTM5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:57:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37732 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbfKTM5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:57:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id g50so28792871qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gtYgZsKdjWgKCLPuHgoMJ2eNbNG78NE68Q155qN82Ug=;
        b=jGdbKr2TED35aioqiqlsFcPudOG7cyQVE8+ZKhJapv6KOePem9zkOJoCl1+xmbSFZd
         3Q1WLQAYXerCakAyxDej/i6/C0jfkafUUU9MZzFDq8WYmMQxnZZFjjEzGqnSc+kFxk/r
         Hq04BqVbcW9zp26Jbq1Dr2q9wFOWSlOWbEABb/tNcGOJzbygqL3sWIHAGyYYOwQ+Xi8h
         I/8SL4SnBPPb1Tq7d0A3X4E8ztaLuSp9DHAkEiMWHpT875qrb8xYGi1dGi19gF5T7RwS
         kOo4DPafrI4uFo/yxuFDuq1UvxqfascRNd0eGuLjPW+HU632Nql7sXT+nOq0v/wIQmgu
         UyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gtYgZsKdjWgKCLPuHgoMJ2eNbNG78NE68Q155qN82Ug=;
        b=PDt58dcL6ttlKhX+Crdjq80OV6srrSIkzCbW8zZlHM0vdPJoySHUM8DKdc4c/c0pdr
         mxzif1W0JYMDbw2CsJsWMlud9Hp8fNS9HmxRue6odOJPG85qnRDNFd2MxT4q+hWhgnFJ
         o8PapEQY7uRG5Wh5aNKzW3ypxZW+LLW28man9qU5RNJZun+92YzUdiyO3RFFvwAJbe8h
         QMrmMgPNlVXrgCn3KkI4236cbni6sTq7rGM4JVyDsxEB8NE1EKIrPVz0aGkZFzs0jx1N
         ZncJlwKL80wUJjF7AGly/JzM7BS+e/poxSdqqg+b7xTI8X0NpoJ8Qsyprrg/I16xonWm
         4VCA==
X-Gm-Message-State: APjAAAVjy4185uYqzuyY+CmVFO7UKMLi4+85wc9Geybrv+TKLkR7Z5gn
        6JJuFiSVRg98dmTdhtxx3V3yxNBapTg=
X-Google-Smtp-Source: APXvYqyrW8nUtaIuzKEjvmVZtBqF9yXQRwNnUnQSVpoxtCSbI9LpsbmrAPc1ye5t5YVnlTR8qlWrMw==
X-Received: by 2002:aed:33c2:: with SMTP id v60mr2423209qtd.168.1574254623419;
        Wed, 20 Nov 2019 04:57:03 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:57:01 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 7/7] arm64: dts: qcom: Indicate rpmhpd hosts a power domain that can be used as a warming device.
Date:   Wed, 20 Nov 2019 07:56:33 -0500
Message-Id: <1574254593-16078-8-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMh hosts mx power domain that can be used to warm up the SoC.  Indicate
this by using #cooling-cells property.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v3->v4:
	- Removed subnode to indicate that mx power domain is a warming
	  device. Instead #cooling-cells is used as a power domain
	  provider property to indicate if the provider hosts a power
	  domain that can be used as a warming device.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 23260a0..71d6f91 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3118,6 +3118,7 @@
 			rpmhpd: power-controller {
 				compatible = "qcom,sdm845-rpmhpd";
 				#power-domain-cells = <1>;
+				#cooling-cells = <2>;
 				operating-points-v2 = <&rpmhpd_opp_table>;
 
 				rpmhpd_opp_table: opp-table {
-- 
2.1.4

