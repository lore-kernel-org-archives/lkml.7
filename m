Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3216C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B7A20679
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329992;
	bh=av5DY9yfYHRV/Nzv7wZ5qTSZxOSs9MtLx6qJ7zBXU6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w7uIdGrtYLGmxjOaPlMyIY09bxu+myU85CZliU56xhwPrzEWml94JvNJMw5pKXFIc
	 6C5MkcwAu4cq8HY3dvqlzZrLJvI1We8pEBrI4gzr1eCBAyVnyEUFXxppWI3x/rtyO6
	 CUdofSTmD20JYr1edyQ+V7bdCe8mnJKkTEpFUBQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfD0BxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbfD0BkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D1520C01;
        Sat, 27 Apr 2019 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329211;
        bh=av5DY9yfYHRV/Nzv7wZ5qTSZxOSs9MtLx6qJ7zBXU6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NCF+b97s5FAZtav8Huxn5iT1LOKz+WDeOFqCW1frEHnBu60o9SCW4hpR70FStBJrD
         ICgzCrb6pAcJmgNmHQDxqyW4D80Gyij7cdAPhuZPu8n1JjeP+s+Lv3Q4rPRMTtAmqu
         rKn02usemwhUb/1A0iNQPzC/+9beHbNmDMtoiPtw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 61/79] ASoC: Intel: kbl: fix wrong number of channels
Date:   Fri, 26 Apr 2019 21:38:20 -0400
Message-Id: <20190427013838.6596-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzung-Bi Shih <tzungbi@google.com>

[ Upstream commit d6ba3f815bc5f3c4249d15c8bc5fbb012651b4a4 ]

Fix wrong setting on number of channels.  The context wants to set
constraint to 2 channels instead of 4.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 7044d8c2b187..879f14257a3e 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -405,7 +405,7 @@ static const struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
 };
 
 static const unsigned int dmic_2ch[] = {
-	4,
+	2,
 };
 
 static const struct snd_pcm_hw_constraint_list constraints_dmic_2ch = {
-- 
2.19.1

