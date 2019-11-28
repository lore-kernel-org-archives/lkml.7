Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7A1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9C2178F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKWoGZnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfK1Nej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:34:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54723 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1Nei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:34:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so10939740wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SDaimtx4qvfQT+a77LcPCR1TXpL+CTCSqALSHB4+Rg=;
        b=fKWoGZnUHc0AEupO0e6BxYnAvJWsF4R3vlQfEGVemUrT1VmzmBVuRcs3pYHh1i022b
         gHmZKlDlHLPDLKLOFB31mC+7L1exI346izL/6cLcwo2keOu59Zw/hKq7Fx1iS2FOTJZD
         mrE7l2joW729IcshdEEbg8w+u5mfrT3HexEs7L86uvd6tZlm29ugtWvQDcHsUeUURYYj
         vsec6EgQjjsV+Rn7koKFXTjcMr42HpbtZsEwcA5vxEIBbyymZfRIf9MWFdoWveRAa2xJ
         y+FhU5PfevlbWXY3k+t9i7MqLgHUKy5Tn5QeNyyX0XO1UTS1j6uaZCNiWEMOzFGkdVX5
         970Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SDaimtx4qvfQT+a77LcPCR1TXpL+CTCSqALSHB4+Rg=;
        b=A9xtlnpkLsxA3FFD05b9mI7p38RRC56oIOx+x0yKJyreJDWo01YDbJdnicPqK5japN
         TPoQ/iAVhGz6Kx8RBXASutJSyb1BY1XbndHZFk/eAjBjEJafP0CLXqssC496xj/xI5q5
         s23IUl51zBYGopXTfWonS9uKbnGeMChNr9Q8MHSXmhU8gyeu3YqvxdGcoqBKkK58QF8x
         3HNjM2OXyaH6J7yBbgGNNbj60x7AkiFVQnE08ELEX1i3n9lQpuJy313g2Up2cEBPA97p
         JbwWvAaYdrEv/9Yc7hiXextWN7QO5Kqjk4jRWjZcMz7QQFjPXwO5NLngq5lYWue13viP
         i3nQ==
X-Gm-Message-State: APjAAAWwBX0Q9AykPzlen1/C71EWI97k6LQc5mf2fSzD842faCGAXvna
        bjTuiFAyRhT++dMQlCEd5oMQ8A==
X-Google-Smtp-Source: APXvYqz50wTmdDHppw64lnOGv4kBmYEywC/jd69HR/l3/KqJ/30thrOsVhsT64GKvxVlxa0p/ykg9w==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr9329041wmj.0.1574948077036;
        Thu, 28 Nov 2019 05:34:37 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y20sm2220451wmi.25.2019.11.28.05.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:34:36 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 1/5] interconnect: qcom: sdm845: Walk the list safely on node removal
Date:   Thu, 28 Nov 2019 15:34:31 +0200
Message-Id: <20191128133435.25667-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we will remove items off the list using list_del(), we need to use the
safe version of list_for_each_entry().

Fixes: b5d2f741077a ("interconnect: qcom: Add sdm845 interconnect provider driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 502a6c22b41e..924c2d056d85 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -870,7 +870,7 @@ static int qnoc_remove(struct platform_device *pdev)
 	struct icc_provider *provider = &qp->provider;
 	struct icc_node *n;
 
-	list_for_each_entry(n, &provider->nodes, node_list) {
+	list_for_each_entry_safe(n, &provider->nodes, node_list) {
 		icc_node_del(n);
 		icc_node_destroy(n->id);
 	}
