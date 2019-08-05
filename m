Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06E9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A904D20644
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011789;
	bh=Wq0On0sVRwS3b6yIGDzoh0IPuVEOA26q+6ww1ezcPzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=izf7WM96MoyalUKc0C3qSd3hMGiOPm9hTXTlYYH4aIw3lOeO8sSdDitUREAscNUYS
	 NA+6bBaj/BYqypWwfM2L7d+Ypexi/bpc3RCi2GHORyNrE6qz9zJGE7Ctll5ROe2MXi
	 D3oVo84Z7f8X0apJjLQ44AHLcIIRe74GQwqjyOzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfHEN3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbfHENV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:21:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3747620644;
        Mon,  5 Aug 2019 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011287;
        bh=Wq0On0sVRwS3b6yIGDzoh0IPuVEOA26q+6ww1ezcPzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgzZVCObE0tNqraEpuBDnz07L8iuXP1p4NBAZa5pzJ7ZmWwdeYcskv9KweSRs2QoG
         Sg+C33pp2XYIa63/lHgyP7rYhhOeW3lLShlgN7yIxueVDVUy47mTW7SOMtS+dBtlZ9
         BfjKwmoh+jqnbZnpcC9+DocXjUMfewwlh3NU8ryk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Vinod Koul <vkoul@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 008/131] soc: qcom: rpmpd: fixup rpmpd set performance state
Date:   Mon,  5 Aug 2019 15:01:35 +0200
Message-Id: <20190805124951.986015582@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 005326050c236..235d01870dd8c 100644
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



