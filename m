Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD9AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5256F2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BbTOKZII";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Aqd4EHBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbfG2MGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:06:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbfG2MGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:06:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 62DB6607DF; Mon, 29 Jul 2019 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564402011;
        bh=pXD6hCjI7T3VH/lpQFaZgcWecErr6WJ8KUuzIkwObmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BbTOKZIIWl6CqRGT8dk3i6+CZw9OJNERv8frXid2HqchcVuF58y+m2t9rrKlZv4Fs
         FJgYjdzU8jHmkBFRYDs4hee8nsAueep1XCvcJc3jHP0JoOmueMGdBDXAp0c6ZwOE7W
         t/GEpAP6+Ja8uvdnj/8qqvgdIFQFBO9dfGJlbvdY=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A66DB60790;
        Mon, 29 Jul 2019 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564402010;
        bh=pXD6hCjI7T3VH/lpQFaZgcWecErr6WJ8KUuzIkwObmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aqd4EHBF/ZtBQXVut9+e86eS/OucZJKsHGn0gQqmMYMf22K3WmCbUZJaia9qzS+22
         ubXyn6X486XwoSoxoKQ1TSjxXvsgkvZbfvtmG04PCRHm64382PXqMTRBPi5GyWBgC1
         WL6CVfZ0c4xpHIglqWDVs3W+NdwpHg56iIbyECIo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A66DB60790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, vkoul@kernel.org,
        aneela@codeaurora.org
Cc:     mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/6] soc: qcom: smem: Update max processor count
Date:   Mon, 29 Jul 2019 17:36:28 +0530
Message-Id: <20190729120633.20451-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729120633.20451-1-sibis@codeaurora.org>
References: <20190729120633.20451-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update max processor count to reflect the number of
co-processors on SC7180 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index f27c00d82ae49..bef8502625f96 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -84,7 +84,7 @@
 #define SMEM_GLOBAL_HOST	0xfffe
 
 /* Max number of processors/hosts in a system */
-#define SMEM_HOST_COUNT		10
+#define SMEM_HOST_COUNT		11
 
 /**
   * struct smem_proc_comm - proc_comm communication struct (legacy)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

