Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34463C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089C82230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YBBz29VT";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hmkjx50T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKRVnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:43:33 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:43230
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfKRVnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574113411;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=LOcIEgFqJ7FSolHVIhJJKos2/bSzzq4MMvWv30/55Rs=;
        b=YBBz29VT8NJ94feyBa3cYn95kiwzQ4A/BQV4jH1PijgPKxFm5Rut52CV/RkFvi9v
        Jm6GXV7MRT1b6AeASEgdRTGPmw4qyKyeT+nWo8Nya5gRsj575dQ6it2516kQWHFHCI5
        FksB42P9P/Pl3I5zhj3UVKjNha1+5baH6695dkVc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574113411;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=LOcIEgFqJ7FSolHVIhJJKos2/bSzzq4MMvWv30/55Rs=;
        b=hmkjx50TaajXWJwW8XXFG+ahyv1JV27d9A+VMgOZtFAuSUr5nOHkhSGrjr9BepuD
        sbs8xQz7yBzmemYzZACJBzsKGwhqnrkMvyw1NzxsiHz4DcG8FjLUvOEQJ5C3TGhsn+k
        Q8RjXanuIbTJNOc7CctxwOLaBoBrzCgq4yZ+lJ90=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5804C58C1E
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, jhugo@codeaurora.org,
        robh+dt@kernel.org, jonathan@marek.ca
Cc:     ohad@wizery.com, mark.rutland@arm.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 05/16] remoteproc: qcom: pas: Disable interrupt on clock enable failure
Date:   Mon, 18 Nov 2019 21:43:30 +0000
Message-ID: <0101016e80787f5e-e7b2e8af-a398-4fb4-ae27-a5f251d1f9cc-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191118214250.14002-1-sibis@codeaurora.org>
References: <20191118214250.14002-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.18-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable handover smp2p interrupt on "xo" clock prepare enable failure.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index db4b3c4bacd77..0fdd3748398aa 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -86,7 +86,7 @@ static int adsp_start(struct rproc *rproc)
 
 	ret = clk_prepare_enable(adsp->xo);
 	if (ret)
-		return ret;
+		goto disable_irqs;
 
 	ret = clk_prepare_enable(adsp->aggre2_clk);
 	if (ret)
@@ -124,6 +124,8 @@ static int adsp_start(struct rproc *rproc)
 	clk_disable_unprepare(adsp->aggre2_clk);
 disable_xo_clk:
 	clk_disable_unprepare(adsp->xo);
+disable_irqs:
+	qcom_q6v5_unprepare(&adsp->q6v5);
 
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

