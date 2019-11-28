Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1161C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B9921781
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4dlAYMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfK1Nen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:34:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37999 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1Nel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:34:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so31226569wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0r1Vz9ksKDupLD9OJqzUcDOf67hQCL9kz7e13IH3GE=;
        b=m4dlAYMM/PIeKCsaJqVlO08YbmIhD6RhsLm7nOtLkOytXmO3qq1q/NJvnv0LeaLeXq
         oOxVm1tA7z9hL1eDdcBG3ZUiO1MH5iA1h4sF3xpAlE1lKk6ohD8GACAbkL7U1OghSHi+
         tmZI95GQrE0w++WAg0zQJylT9wyydK5AgU2j0e1JsJ11SuNdMrOSjevlP/Ik/E+liFev
         RBrkrVi/nH5XUspOIPSa7aKqMRRDTzxZY7KpqXEQXr2a5qAohXFKbjJ78CV33+TMQcxj
         UIzA9mthlQkhSlOU/7B04DggmQ2Ez87farNVp7idFzMk/LaeYnLpnkvgL4+KwERgHQjJ
         O16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0r1Vz9ksKDupLD9OJqzUcDOf67hQCL9kz7e13IH3GE=;
        b=TKNgMy+V/Y3NZLXCJfSRfEdCwcFPZL91YCjVPY4Ctkd0HddADsI1sUqbXGNNaVVNSE
         6OUCGeRbxRc42levAz2k9yExCf9NkQgwcJpPP4Kxt1OxZxlNVB4pg+m21yjkPXuejxZ4
         PgjaXRd1L0bPIqsfCIvu310TvQHWmtDQl/H8fYlUwpCq8a+uAdyyx9tyRnl12007Nad9
         j+PmVt5EUH9Wj2FTd+0esJuvRLFq5ZoSGHgdxaiIKq7p5FCNmXbDbFepTvvDW43DWJNk
         3CStmRI83s05bsPa/f2d7G4xJ65kANFE9GBVN2Jz9EAd8iD6t2J10T121pw3mcvyw7oR
         3xbw==
X-Gm-Message-State: APjAAAXzDFLrxpFL0w7/ai3TGxfP/cDloUVSKgLTzJCd6md0GRZF3984
        P+sSZGvuhndvREzXD6Y1cV7srQ==
X-Google-Smtp-Source: APXvYqy1rwDcBh0cI1GWX7oMKqVb5qJCvtu5a2XAY1XhhuLyV/p3LIlUO78MiO0KUCQBqiPRluL1bg==
X-Received: by 2002:adf:f303:: with SMTP id i3mr46618947wro.157.1574948079524;
        Thu, 28 Nov 2019 05:34:39 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y20sm2220451wmi.25.2019.11.28.05.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:34:39 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 3/5] interconnect: qcom: msm8974: Walk the list safely on node removal
Date:   Thu, 28 Nov 2019 15:34:33 +0200
Message-Id: <20191128133435.25667-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128133435.25667-1-georgi.djakov@linaro.org>
References: <20191128133435.25667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we will remove items off the list using list_del(), we need to use the
safe version of list_for_each_entry().

Fixes: 4e60a9568dc6 ("interconnect: qcom: add msm8974 driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index ce599a0c83d9..0a1a8ba6afa7 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -732,7 +732,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	return 0;
 
 err_del_icc:
-	list_for_each_entry(node, &provider->nodes, node_list) {
+	list_for_each_entry_safe(node, &provider->nodes, node_list) {
 		icc_node_del(node);
 		icc_node_destroy(node->id);
 	}
@@ -750,7 +750,7 @@ static int msm8974_icc_remove(struct platform_device *pdev)
 	struct icc_provider *provider = &qp->provider;
 	struct icc_node *n;
 
-	list_for_each_entry(n, &provider->nodes, node_list) {
+	list_for_each_entry_safe(n, &provider->nodes, node_list) {
 		icc_node_del(n);
 		icc_node_destroy(n->id);
 	}
