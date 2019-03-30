Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26676C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBE5218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907083;
	bh=yJpthZ85x6a92c8Q/F0uxCJ+lRYH7ET8apgUl2rDcfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jkGnJEuqlVJcd1fEJ1vZWz94Wu6jBHKAVcmpMsjtdUf+CwNeVWCgcZjWY7x8/xOP/
	 T1PBAf4cXxjI7qK88+5YkR8VJRVa93i2xndQ5vlOoFyzDdiBYYWU7hngjOlsG47WIr
	 b94YH9beIr44g+q7/jqyo02ps+K17/XTm7f865oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfC3AvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbfC3AvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF52218D0;
        Sat, 30 Mar 2019 00:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907077;
        bh=yJpthZ85x6a92c8Q/F0uxCJ+lRYH7ET8apgUl2rDcfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0W2UQLg+IQzRqeo0DrjD6ACE0avYyiONUHcccld4TgsPkGOac3fRHa7qUINpxU8J8
         NQHlUSsIOEOSxT3/YTuGXLQDduIUBCqBlF0q08yeZ+O1q7fsHItRc5UTvux6y3k5Gl
         eXTpOGKtJa9jgpv8uVx5+AnpLy7SjdPwoqX0C6gA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 21/67] thermal: samsung: Fix incorrect check after code merge
Date:   Fri, 29 Mar 2019 20:50:01 -0400
Message-Id: <20190330005047.25998-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 3b5236cc5d086dd3ddd01113ee9255421aab9fab ]

Merge commit 19785cf93b6c ("Merge branch 'linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal")
broke the code introduced by commit ffe6e16f14fa ("thermal: exynos: Reduce
severity of too early temperature read"). Restore the original code from
the mentioned commit to finally fix the warning message during boot:

thermal thermal_zone0: failed to read out thermal zone (-22)

Reported-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 19785cf93b6c ("Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 48eef552cba4..fc9399d9c082 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -666,7 +666,7 @@ static int exynos_get_temp(void *p, int *temp)
 	struct exynos_tmu_data *data = p;
 	int value, ret = 0;
 
-	if (!data || !data->tmu_read || !data->enabled)
+	if (!data || !data->tmu_read)
 		return -EINVAL;
 	else if (!data->enabled)
 		/*
-- 
2.19.1

