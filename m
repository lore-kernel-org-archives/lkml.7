Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819AC48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A379920659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595683;
	bh=79Xn3PW+I8deRgiV9VQMSZ4xnqeZqmJBnCnIfu2/UxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=obFU9oF3nZTeq6nh/bdRn2+TOHi38VtOqYqLatkqcoQJcKSatchr+yF6bL+Y9XlbO
	 V7ddnoMGL7FiCUL6Usmt80q2RRMF69w6Oakg5CxvxBc1cBpiFoPBjK67bXDJYRfdav
	 uKEvQMj9cxCTzzB15Debl+4Fia3b5pkHWCpFqufE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfF0Ael (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfF0Aej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:34:39 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ADA820659;
        Thu, 27 Jun 2019 00:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595678;
        bh=79Xn3PW+I8deRgiV9VQMSZ4xnqeZqmJBnCnIfu2/UxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpggHoyECWUKOYw2owiA8Jz0rP9TxLQHv1bvors6grnzRcOyW7RQSJo4+8pC+QpXJ
         u6cl/agkpIxhXYNZqwvLqoe2G3yEBjwZFW/Nf/PmEf3LJ5cINN8kqJwxIu+v02r4Ck
         HI4/YwLvxFuxWIMl2YULtkgpe84rWfHfJkMBM1Ek=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 76/95] mmc: core: complete HS400 before checking status
Date:   Wed, 26 Jun 2019 20:30:01 -0400
Message-Id: <20190627003021.19867-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit b0e370b95a3b231d0fb5d1958cce85ef57196fe6 ]

We don't have a reproducible error case, yet our BSP team suggested that
the mmc_switch_status() command in mmc_select_hs400() should come after
the callback into the driver completing HS400 setup. It makes sense to
me because we want the status of a fully setup HS400, so it will
increase the reliability of the mmc_switch_status() command.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: ba6c7ac3a2f4 ("mmc: core: more fine-grained hooks for HS400 tuning")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3e786ba204c3..671bfcceea6a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1212,13 +1212,13 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
 
+	if (host->ops->hs400_complete)
+		host->ops->hs400_complete(host);
+
 	err = mmc_switch_status(card);
 	if (err)
 		goto out_err;
 
-	if (host->ops->hs400_complete)
-		host->ops->hs400_complete(host);
-
 	return 0;
 
 out_err:
-- 
2.20.1

