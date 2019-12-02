Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1FEC43141
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042C02073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AP6DiGL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfLBQVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:21:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41715 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfLBQVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:21:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id b18so45062175wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RcVG/qj8yyYNSIPEYKFW4bW3tWMavwQ5W53FJik00WM=;
        b=AP6DiGL/aQDTxsAfZ1x0QW+Tv8Bg7T5RqQnXQmNd2D7OmhJ/YbRW1pmAjuDOkM2Y2F
         0xGdykT8B6nyEKr9akZYeTPLwCSAridNAkPznb19AHx3u9eVgUQpuDRnw5U2avBiQfG/
         PnsAwETCY+nidrFK0fkulfX1bd87h+6Gsw8LOAoJjGAarWiauj0mDJq/n7ub4OV/lUPh
         /Ud4d9x5Siix/pN7AZQHNsAWTmwUmH0JHHp3tnAEOtg4ZeeLd+OpAB3eKgZLLRWtGIh9
         KiCfqvewrsnuUXm/K+lkeJe6tEL/9+PU77gfs6Nxmtsi0y97vQHDhZPYnH4kMNgKSYiL
         48KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RcVG/qj8yyYNSIPEYKFW4bW3tWMavwQ5W53FJik00WM=;
        b=QZkkhcpW92T+OLHBPQXzm8Cr3tA/NEZQhJnCw9J/EPQvKXKdQWAcCrRdzOEunRv7n9
         8BUAjLkITkvOAAmqRHys0+gi4IGG7vRXYYmA/k4YWa8e1m/WDzVoeBYMwZNVoTkLV3e3
         J8d30tssEPNp7bruSFDe/5olCWLPegnAPNXZgGxLn1QoMencaX7HCGyOQFVwb12R9GOc
         rw66uDl21ICGQNWc9seF/EAEDZ1k0tA3MOkPtzbV/1104D5jAmTTq3890pBOaFTIuhFx
         lZoxtOn6TLNrr3ivKZksRBRXVeDQ9Qlu1o9LyqwR3smjY1l2DH8snvOJnRN/CUMuKzRS
         7Glg==
X-Gm-Message-State: APjAAAV9r8YJKDVK31FgSeYcq582G6Z+W+dvqnAthf3ngsupmtFCCFYM
        vvEM5uRDg/kzquiAqu7xD1Iu8js1xgs=
X-Google-Smtp-Source: APXvYqzf7GMDnP1dmGoh6t8wKOB1vcicGtxIHotMg3u8fNgCyOCxS5AqgiMbo72c0hzwkLeTx1NJ+w==
X-Received: by 2002:adf:a746:: with SMTP id e6mr15118778wrd.329.1575303697776;
        Mon, 02 Dec 2019 08:21:37 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i9sm39204516wrb.2.2019.12.02.08.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 08:21:37 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 2/5] interconnect: qcom: qcs404: Walk the list safely on node removal
Date:   Mon,  2 Dec 2019 18:21:30 +0200
Message-Id: <20191202162133.7089-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202162133.7089-1-georgi.djakov@linaro.org>
References: <20191202162133.7089-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we will remove items off the list using list_del(), we need to use the
safe version of list_for_each_entry().

Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/qcs404.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 5e5843e6bd06..9064f6bdaa69 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -405,7 +405,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	struct icc_provider *provider;
 	struct qcom_icc_node **qnodes;
 	struct qcom_icc_provider *qp;
-	struct icc_node *node;
+	struct icc_node *node, *tmp;
 	size_t num_nodes, i;
 	int ret;
 
@@ -485,7 +485,7 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	list_for_each_entry(node, &provider->nodes, node_list) {
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
 		icc_node_del(node);
 		icc_node_destroy(node->id);
 	}
@@ -499,9 +499,9 @@ static int qnoc_remove(struct platform_device *pdev)
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
