Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B40C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29103214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuBwZF3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfLLHxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:53:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34692 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfLLHxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:53:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so1630057wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ok0nQnxyVp+hWourd2iRYkQMDbNDd797Oi+3MDLgvE=;
        b=kuBwZF3aTUHamxKahISgDPfpkTVxpBWPErTUxDu8tvilS/xaRc3rm9NfU4I6x4KXsZ
         ZstbdCSaaVFHD07vHcFFvZRa6afY74PXr4bIkBz7g3Tlel5xeUfBh1nGCq4vaGK1US5W
         EPmSF9L41f5LHog3fQib1Q3H4aTGpyh1uQn5pLKvx5bday1E3nvG8tXShjGW507ItW4X
         dHMRdOEhHXXNCmKe8jA6j4ZxIec/a2dDFUPoLSeCc/kcwNXRlE3cmUXidsrOcFLm3Wss
         0Vfrm+hMFh/WZF3hckaFO9jIIEklzubZWt7sSLrhO8VjiS9j/gPtkwA2/cWqiJhfs32i
         NoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ok0nQnxyVp+hWourd2iRYkQMDbNDd797Oi+3MDLgvE=;
        b=WQdCZZg7fC2zngd546ulaA/FCIUo6x2T6u8bqIjOzv3jnJAErmO3zQ4+sLqDDQgIo3
         eDDD6FdoSd95CKkdnPBQBqRf+qy/6y2+d0zgTOKIrV0EigGGTih7n22iWTLQWBpl7Tul
         GpvOf9Nk5i82rJd1ri7Q5CFtXBUIv2MfaN6earnMTS9AeLkpuVDyiuOzcIqck6NZ1K4L
         TaEtGpScq6+kfmh0xTRD+A+jNn3VfgOYL0mfmCyVkfbEaL8zT1aOSXFTWO0AbCk9Coe6
         eC54DIDh/QIyRnoEZhSqkqUuOpEw0um7W+mr9+yueBxdAw1O30Njcj+ohHtGmUdMApN2
         Xjwg==
X-Gm-Message-State: APjAAAW0Gvse6rymQWwF2OLLb8KoiaGt4mvGj+ZCRfD6uvtZa9yweO+B
        WHsQEjhirVMZXO8z+16dJ+qTWQ==
X-Google-Smtp-Source: APXvYqzPziPpJRFVzoBFwbFJvLDT14cwri/geZerVfDTVoysW08yVdQwFE9ukJgLmSRP+uRdNA+GFA==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr4623170wro.202.1576137216719;
        Wed, 11 Dec 2019 23:53:36 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x6sm5636742wmi.44.2019.12.11.23.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 23:53:36 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 3/4] interconnect: qcom: qcs404: Walk the list safely on node removal
Date:   Thu, 12 Dec 2019 09:53:31 +0200
Message-Id: <20191212075332.16202-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212075332.16202-1-georgi.djakov@linaro.org>
References: <20191212075332.16202-1-georgi.djakov@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Cc: <stable@vger.kernel.org> # v5.4
---
 drivers/interconnect/qcom/qcs404.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index b4966d8f3348..8e0735a87040 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -414,7 +414,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	struct icc_provider *provider;
 	struct qcom_icc_node **qnodes;
 	struct qcom_icc_provider *qp;
-	struct icc_node *node;
+	struct icc_node *node, *tmp;
 	size_t num_nodes, i;
 	int ret;
 
@@ -494,7 +494,7 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	list_for_each_entry(node, &provider->nodes, node_list) {
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
 		icc_node_del(node);
 		icc_node_destroy(node->id);
 	}
@@ -508,9 +508,9 @@ static int qnoc_remove(struct platform_device *pdev)
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
