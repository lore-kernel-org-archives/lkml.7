Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40488C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168DE206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519690;
	bh=zlK8phi/sh4xEBUruI/ErgInYWuipq1OWubLY7IOSrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c/rsX4S+KFzkcGwUjvhmK0bvPSSIQ/RSm0l+hlsihR7m1w7dwJXmLcL3M87uXuhMQ
	 2aDW5u6mR/8xj8eugd35HLQy1DYKYHrumk+IdEaONUZwyEgnwoPJb4l7JFLkaUOCO4
	 cJ0LBBWpjf9FgJP/HAdLhJim6zeu5U2wAxoGrYTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfLPSIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbfLPSIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:08:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 998A6206E0;
        Mon, 16 Dec 2019 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519684;
        bh=zlK8phi/sh4xEBUruI/ErgInYWuipq1OWubLY7IOSrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3LoYbvuzQQx2huoThAwzmBK0rx+aFEElIO5OFy7ybvKYECwJeyl+k+kYVbgsolO6
         LctwF3PpmQSzIw/Fr7m/y096Xra+JUK7wK61XyWk9dzxZ4vWq7uNRx96UTmsmVoLXA
         aFyhlBnb1vk+B9ZqKebw3Oizr6qVl9Cs+LpCMp84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 5.3 026/180] interconnect: qcom: sdm845: Walk the list safely on node removal
Date:   Mon, 16 Dec 2019 18:47:46 +0100
Message-Id: <20191216174811.685771041@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georgi Djakov <georgi.djakov@linaro.org>

commit b29b8113bb41285eb7ed55ce0c65017b5c0240f7 upstream.

As we will remove items off the list using list_del(), we need to use the
safe version of list_for_each_entry().

Fixes: b5d2f741077a ("interconnect: qcom: Add sdm845 interconnect provider driver")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Cc: <stable@vger.kernel.org> # v5.3+
Link: https://lore.kernel.org/r/20191212075332.16202-3-georgi.djakov@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/interconnect/qcom/sdm845.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -807,9 +807,9 @@ static int qnoc_remove(struct platform_d
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


