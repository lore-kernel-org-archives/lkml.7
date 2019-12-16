Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9771C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A5420717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520850;
	bh=tHbKCpPiGecCPTCgk3V5tn9r2fHfaJe0rvIkRctlIjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sCpM8Qrc1Uz7LFY9Q0HgYqePngxBbhCKYnQMXiY9zWm3rfQNuvdGL7+IxfKlE4i7r
	 WdJqRxNxpt+ojgL8dboSYXKqlSzu8OmmnIsnFA7iSMrPZ2C8pH4XUmGz/xOu21Ks/d
	 OjzOQub9dq6MBZOADbmqy4hlG6AsIHPWf4mD0i+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfLPS13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731227AbfLPSPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:15:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB25E21739;
        Mon, 16 Dec 2019 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520147;
        bh=tHbKCpPiGecCPTCgk3V5tn9r2fHfaJe0rvIkRctlIjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgtUP2OYOC6AJcdiuVCAg1NiRGRcvcJw34yQP2Ai3aukBvdeDTS9EhhWxugA9Nq6I
         5YOn4s82p+yUUwJN2Fp6RF/5OBIK4Si6UDYuDfvf1fEaSv/OFBVM2pgKJ/NZUvlOUG
         M9YNHyrcpEDLdldYf02ivVhd0RNWaRtTWndr90iU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 5.4 034/177] interconnect: qcom: qcs404: Walk the list safely on node removal
Date:   Mon, 16 Dec 2019 18:48:10 +0100
Message-Id: <20191216174828.234103663@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georgi Djakov <georgi.djakov@linaro.org>

commit f39488ea2a75c49634c8611090f58734f61eee7c upstream.

As we will remove items off the list using list_del(), we need to use the
safe version of list_for_each_entry().

Fixes: 5e4e6c4d3ae0 ("interconnect: qcom: Add QCS404 interconnect provider driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Cc: <stable@vger.kernel.org> # v5.4
Link: https://lore.kernel.org/r/20191212075332.16202-4-georgi.djakov@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/interconnect/qcom/qcs404.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -414,7 +414,7 @@ static int qnoc_probe(struct platform_de
 	struct icc_provider *provider;
 	struct qcom_icc_node **qnodes;
 	struct qcom_icc_provider *qp;
-	struct icc_node *node;
+	struct icc_node *node, *tmp;
 	size_t num_nodes, i;
 	int ret;
 
@@ -494,7 +494,7 @@ static int qnoc_probe(struct platform_de
 
 	return 0;
 err:
-	list_for_each_entry(node, &provider->nodes, node_list) {
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
 		icc_node_del(node);
 		icc_node_destroy(node->id);
 	}
@@ -508,9 +508,9 @@ static int qnoc_remove(struct platform_d
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


