Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E038C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019AD2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BppxZiJD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gefzLfon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfCXRu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:50:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfCXRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:50:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8703060ADE; Sun, 24 Mar 2019 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449825;
        bh=tTTvsdRzbOCKqQsdggwTBozQpWtTAASgpTbsvimvJN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BppxZiJDB4Sg+VKwFjmfEfHkunGP3up6y6LVJz6frPwLXZbhgPJs6UeqIxhtKIV5N
         uBr/wAEiP5W1cp1s11j7/a20OFe3t1TdAw6GHKxdnZ04D73wLp3CaEQ1fZnz0qXLz+
         btIfW5RWZEdKoUHvsnXCGAHuV42+pz2Cg3d1R1Gs=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33ECA60A60;
        Sun, 24 Mar 2019 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553449824;
        bh=tTTvsdRzbOCKqQsdggwTBozQpWtTAASgpTbsvimvJN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gefzLfon2Zg5eNk7U3xwOVViU+ACeY0BYFqe1khyL+PqPkfPLzcml7QTb8eXlfmUr
         ctYNe41EAs5LGN8LEM8XX0mGmrzeLUfmpkoeGaSCns4nLzlSq06vX+uvelbFPRa1Lp
         T+G5KmyiYizMKsCs/nAOE8XOJoGYklCFgX4eyL5o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33ECA60A60
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 1/9] soc: qcom: rpmpd: fixup rpmpd set performance state
Date:   Sun, 24 Mar 2019 23:19:59 +0530
Message-Id: <20190324175007.29040-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190324175007.29040-1-sibis@codeaurora.org>
References: <20190324175007.29040-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup rpmpd state to max if the required state is greater than all the
supported states.

Fixes: 075d3db8d10d ("Add support for the .set_performace_state() and
.opp_to_performance_state()")

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/soc/qcom/rpmpd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 005326050c23..235d01870dd8 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -226,7 +226,7 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
 	struct rpmpd *pd = domain_to_rpmpd(domain);
 
 	if (state > MAX_RPMPD_STATE)
-		goto out;
+		state = MAX_RPMPD_STATE;
 
 	mutex_lock(&rpmpd_lock);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

