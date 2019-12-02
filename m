Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E914D20722
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE1Rz6vN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfLBQVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:21:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36590 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBQVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:21:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so45034282wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3hce8rncscuvP/l1ZHZTtieB5MS4JyYpc/T2PE+Kxk=;
        b=BE1Rz6vNXRg7sd9D4JsqoBEe+a6i+xNVBv+xt5suxCeM/F5EH1GxIAP5zZ8GnNiX8e
         SDyYr7SH0N/I5WLB8b3Z0n7DI7l62lJN3psAJGsLawlizXLVRQjLEYAVuI/uA/eGwosu
         4Y+oO0D1Ymr8GhkMET7OvboWgv9L7A+MWQEgSKOTv9OLFNNBX1DlgunxhAowoP1gbAhO
         OIQ9RJ+oaW67J5IzFVih/bd/+X8h2yJx/5lQFKxzOC4OVLi8NomZj03ZFGq9ob8p82Rt
         D8aa46nTbH5GZszd7+KPwWdSSS3jgclFK55df+IYNRP3jzdd8HAz7vfUGHRh7Ag/2wb0
         wFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3hce8rncscuvP/l1ZHZTtieB5MS4JyYpc/T2PE+Kxk=;
        b=Vd1jz/M6xqy60LBQqDRQZspklEXvMp6RWm4ujODoHDVH5Ifjqa9af+c7KW74ydeX/e
         7H/kat/Jn1+5P4p8v3DUaUlmqAVPtVIDfb0uty6cDUAbzxrbgfdLHWNRJr+J7iZYgut4
         4QpK5IDbxTF5JZwD3w3mgoK4hlXchEcgeOMlPVhr9GAY0vPz+p5pyX7Hhuaw8DiPmHqy
         pQOy20LKF2T8KZ42ZAgxJG7XUkBZW9+qKvgfWzb+CDdpiB/y68I37Y1bUEPbCjwQTl4P
         Ohad7on8/zQHExoWAtO4d61b4dm5hEWoXcqKnIQOTxOUu9iy/7y2M7t0xr/XYeuQXQX7
         6rdw==
X-Gm-Message-State: APjAAAW87qRjw+YA0RNSJqBnvqxKhjlsp0ODXhtF14Yli5cMQTNFN4qH
        TBYI/UGAbSjPGgpw2z1V9fQXBQ==
X-Google-Smtp-Source: APXvYqwca+igLoFKmAl2TQAB5hPhndZpQ1iKhmD5Qq2qjfwBwaXa2POHL77PR9uX+Zd/EezhjWLc5Q==
X-Received: by 2002:adf:b19a:: with SMTP id q26mr25103318wra.79.1575303696450;
        Mon, 02 Dec 2019 08:21:36 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i9sm39204516wrb.2.2019.12.02.08.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 08:21:35 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 1/5] interconnect: qcom: sdm845: Walk the list safely on node removal
Date:   Mon,  2 Dec 2019 18:21:29 +0200
Message-Id: <20191202162133.7089-1-georgi.djakov@linaro.org>
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
v2:
- Fix the number of parameters that got messed up. (Bjorn)

 drivers/interconnect/qcom/sdm845.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 502a6c22b41e..387267ee9648 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -868,9 +868,9 @@ static int qnoc_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
+	struct icc_node *n, *tmp;
 
-	list_for_each_entry(n, &provider->nodes, node_list) {
+	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
 		icc_node_del(n);
 		icc_node_destroy(n->id);
 	}
