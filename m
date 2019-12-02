Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3972C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944F62073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIM2E4qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfLBQVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:21:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40935 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfLBQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:21:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so20448278wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMBJAp4LSOF18EKZsarCjIvV97iU3KlOms/xsyIv3iQ=;
        b=bIM2E4qQ6P+LyYmjxXTsCE4nf2gqeqyCpaqijLgjBd5rSLfDIbh7mwl3XW1bBKIca+
         5R4fnwcgNEiKGlQH7I2Gf+t3VDeCoW/eVANZOH5MtgbkCaU8YMQPy8TXK/gsviJ3PPpA
         K64lZKCfBUpvGCWnpeq0d3CnYV1mDd7D8qD37vhIwuY5LgxWRTtR60smA6p5EFYhRrZb
         9mUmPaUs37tYNSOMScuGD7eojrFiwusAvQDYFvbkuS72kXfk5qgVd7kdH/3RVzsoU17L
         Q19VvRjKxnuiwFpBuiIwN8moJtDbTil9Z7YpRp71rpqTGuVLWgxdxQLnM5burmTv7dYy
         20Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMBJAp4LSOF18EKZsarCjIvV97iU3KlOms/xsyIv3iQ=;
        b=uLh92DsCh//TJW5alsjyCd7eoC/ME9sPeLKuD24Dyz/4apfRZ1EtgaAPxUbEWDX3vB
         5xQ52iAeA3GPS72wB7sZrd9TtnlB9MQEK0jBQG59HdUK4dH54ro5cs1XSWg2Tq/C+NW6
         XY6TH65byyF+A2LaIa0tKfq3R1vijEY0djOf+hqD9P2VBdCivMbIomjLaT2NwaPG4HR0
         yw3p/2Q+48gXT+0lLIkaOOPFApSXwa6KIclljJ5jSM23j6s9XdEu6tbBL3VZV572TG2a
         fHuzkZOA7UX0U2sHRHPm4rZ6vczBsh1DYmZYrK/Sa1QF8ecSD8LNSvcO2uTK8GJD1vos
         DqtA==
X-Gm-Message-State: APjAAAXT1vL8MZPiauNN4r8UJMjrux2RrY3iAKW+twqP8Fd8wjSOyA4x
        0ajy075fgDl1VU4qjTvZm4l+pA==
X-Google-Smtp-Source: APXvYqx39MnObvyWdT1npt9UtcGiQgJph3139C2GJsoL7voal1lBRwS03vjO0tJ6oRSzK8TYFGeAHg==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr54752462wrq.134.1575303699158;
        Mon, 02 Dec 2019 08:21:39 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i9sm39204516wrb.2.2019.12.02.08.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 08:21:38 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 3/5] interconnect: qcom: msm8974: Walk the list safely on node removal
Date:   Mon,  2 Dec 2019 18:21:31 +0200
Message-Id: <20191202162133.7089-3-georgi.djakov@linaro.org>
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

Fixes: 4e60a9568dc6 ("interconnect: qcom: add msm8974 driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index f29974ea9671..ca25f31e5f0b 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -643,7 +643,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct icc_node *node;
+	struct icc_node *node, *tmp;
 	size_t num_nodes, i;
 	int ret;
 
@@ -723,7 +723,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	return 0;
 
 err_del_icc:
-	list_for_each_entry(node, &provider->nodes, node_list) {
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
 		icc_node_del(node);
 		icc_node_destroy(node->id);
 	}
@@ -739,9 +739,9 @@ static int msm8974_icc_remove(struct platform_device *pdev)
 {
 	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
 	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
+	struct icc_node *n, *tmp;
 
-	list_for_each_entry(n, &provider->nodes, node_list) {
+	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
 		icc_node_del(n);
 		icc_node_destroy(n->id);
 	}
