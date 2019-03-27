Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78002087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MDTtRheU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MDTtRheU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfC0Mix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:38:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbfC0Mix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:38:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F9CC60E3F; Wed, 27 Mar 2019 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690332;
        bh=E+POiZOyClt2s1W2aHnlB+NDTJfZoeaXwad1chvUJnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDTtRheUyWRSjRUKjx4KykgEqvUlWI8M5JQsjj9EvwysutSHwSEFVN7pZfTNCkWkF
         NxT5GP9PDL4W5gbpvIHvRXm5EzvaoQvhU15vgntu1eJp3Q3EEIaEyBFeGqbtBmkOFb
         l4emqL5AlADNza67cy3dMMUoY5QB0ap/1vQebRy4=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38DBB60C72;
        Wed, 27 Mar 2019 12:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553690332;
        bh=E+POiZOyClt2s1W2aHnlB+NDTJfZoeaXwad1chvUJnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDTtRheUyWRSjRUKjx4KykgEqvUlWI8M5JQsjj9EvwysutSHwSEFVN7pZfTNCkWkF
         NxT5GP9PDL4W5gbpvIHvRXm5EzvaoQvhU15vgntu1eJp3Q3EEIaEyBFeGqbtBmkOFb
         l4emqL5AlADNza67cy3dMMUoY5QB0ap/1vQebRy4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38DBB60C72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 1/9] soc: qcom: rpmpd: fixup rpmpd set performance state
Date:   Wed, 27 Mar 2019 18:08:24 +0530
Message-Id: <20190327123832.11566-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327123832.11566-1-sibis@codeaurora.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remoteproc q6v5-mss does set_performace_state with INT_MAX on
rpmpd. This is currently ignored since it is greater than the
max supported state. Fixup rpmpd state to max if the required
state is greater than all the supported states.

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

