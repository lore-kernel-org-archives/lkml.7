Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468DF2251D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3yYTK2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfKTM4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:56:49 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34172 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbfKTM4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:56:47 -0500
Received: by mail-qv1-f68.google.com with SMTP id n12so9644706qvt.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bjn8ReEOuhGj9F9W8fuw8HgClV07G2HHM36EtHpy9gw=;
        b=V3yYTK2+0pBvo3Fs29fkJr+7+mmKEYMjFkE7Ka3SjI9crrpN1l2CayK3y0m4ygetZ3
         nlTP0SZkttXLJbDk5AOuS6mH+hTEpZkfTBcG+NUhtj2fwrBaoGZCtzSWrQysLdKVzK6G
         82BJ8fTCqtLxFEutXC0gQzqzT+b5UJC7ur3ECvk4P6L6747BLjqdVCcBzBeh0GFR44xO
         TI/nl70KdWfEcZ2jjkTNH1sWgohGuRtMyxavuy530AY0D8o3H4iRL+3+s1mBeoMlYguD
         CRTIxUPLmNgN3NAZR8vYGqsc8gqU5PIQyqE51k+aXurXAhWBYR/jx70NiwU8ZN6stAVZ
         Dg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bjn8ReEOuhGj9F9W8fuw8HgClV07G2HHM36EtHpy9gw=;
        b=SOXtxCJCRHOxSdFY2Q+v7iAkfiRF53d2PBC5Lr/7yYLOyDterfx7WBfNpo3mKD3Eat
         V3iDRCA+wysB2G2F3dS4TsAFPZmbqC/tXrbYXB01D4Djd2dHk4ngd90D8P/hKWr6a0eN
         ezhjJIRqLT3nEPgJQKqvLyInIGONz+cNFWsYeD7nTKFGOP8FYMDN2MMf6ma95QGAf1v3
         jaINJVWN0yfUDSZbEka+NUPhQwfZYo7+hTFCU0f9jttuVZMXOJu5g1R/npcX/3KSL4wc
         Yc8tJrcpw3PJRlyPqF7bFUE4RQMBQYYquEHS0X0QDixn+5DvN07GOkrZ9ijj1LPBfu/n
         YjBg==
X-Gm-Message-State: APjAAAWQ5JcnLGYEO2bjKG3iv6cHmDA0NO6qeUNB3eRMy78zchrdqZqF
        7eRNlIDbTcFqGn1GiH/4wNf6IQ==
X-Google-Smtp-Source: APXvYqxf+sKw7EwManApOCl7KSNRE1MiRk/sThSYeiR8bBGoNF0Mhv4ABmcOFKGpvjkgYskeZk0h+w==
X-Received: by 2002:a0c:e947:: with SMTP id n7mr1303514qvo.103.1574254606578;
        Wed, 20 Nov 2019 04:56:46 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:44 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 2/7] soc: qcom: rpmhpd: Introduce function to retrieve power domain performance state count
Date:   Wed, 20 Nov 2019 07:56:28 -0500
Message-Id: <1574254593-16078-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate .get_performace_state_count in genpd ops to retrieve the count of
performance states supported by a rpmh power domain.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 5741ec3..9d37534 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -285,6 +285,13 @@ static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd
 	return dev_pm_opp_get_level(opp);
 }
 
+static int rpmhpd_performance_states_count(struct generic_pm_domain *domain)
+{
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+
+	return pd->level_count;
+}
+
 static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 {
 	int i;
@@ -373,6 +380,8 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
 		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
 		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
+		rpmhpds[i]->pd.get_performance_state_count =
+					rpmhpd_performance_states_count;
 		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmhpds[i]->pd;
-- 
2.1.4

