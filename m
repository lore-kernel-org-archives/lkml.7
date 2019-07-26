Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0894CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5DE22CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148395;
	bh=+gfJVkpJS/vtb+jxiW5lbIi3FK/ZDmUKp2Z1JV4ZXZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TIojwns3wBPANkgZ2lH/YeuXgP32htVamYILNBj0K7nisd15oIqMgtjII6DcyJtaQ
	 fRqyKuksQkQypOwcmgtluepTtoM45iKQ9lRkdumFgi8Kwj6TLPAs5oCUncBsP3NUIs
	 kXZ0W1leCq/tY1RCLJ/cgVoRqOTtRJLehwWwzEDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfGZNjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfGZNjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:39:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AABF02238C;
        Fri, 26 Jul 2019 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148385;
        bh=+gfJVkpJS/vtb+jxiW5lbIi3FK/ZDmUKp2Z1JV4ZXZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOUxWQzK24Wd+8j0SYcRMLiJvEfqSRDwOVcFjnahyJ1purZueB6xO3qRwTzokzB5C
         uJhkFYsKHlvluj+1f/cz8SoIdct/5W3lVggoaxy1Un4TejDF7gFvxoisn6geLKd3lb
         W/VNKGkGP8+005TrAcriki31TvdmCgKimyx3A1Lg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Vinod Koul <vkoul@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 08/85] soc: qcom: rpmpd: fixup rpmpd set performance state
Date:   Fri, 26 Jul 2019 09:38:18 -0400
Message-Id: <20190726133936.11177-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

[ Upstream commit 8b3344422f097debe52296b87a39707d56ca3abe ]

Remoteproc q6v5-mss calls set_performance_state with INT_MAX on
rpmpd. This is currently ignored since it is greater than the
max supported state. Fixup rpmpd state to max if the required
state is greater than all the supported states.

Fixes: 075d3db8d10d ("soc: qcom: rpmpd: Add support for get/set performance state")
Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <agross@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.20.1

