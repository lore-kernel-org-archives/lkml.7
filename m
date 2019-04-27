Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D402C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6551215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329394;
	bh=dU91GnZdObkxpX84TDZpbTY6xu180IXb8sa8B2luH+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vvOA8fA/b6d5aWMV6xZurTVXz8gfLrUm/85oTYeb+5sODtYEPFLRVgV0pplbKNbKU
	 purV6Mig7RK/SsWHZTHftTQotzfSQAmMY5OKpBhgFNQTtVS5b6rGizX6VdAwNce2Jd
	 wMkhI3xH5tcB9GNA9v6b7bqfs4rkQlI/f8kthEA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfD0BnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfD0BnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEA8208CB;
        Sat, 27 Apr 2019 01:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329390;
        bh=dU91GnZdObkxpX84TDZpbTY6xu180IXb8sa8B2luH+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXNa7Z3TnzmgpC8+tZPqSzS++XP+EiH4VXE/IyyUETkWjK1II1NyCYlpPYGpcBp50
         Gl1li3BDL4Mp8Pv9bNJNRs8OY0D5zeWpG08lCSfX/sjN7sXHktdIUXsR7yi+eQL9pK
         Z1DJeJWIEjWhdvg/3blmwZyEHdSshE1e0b2WxouM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 25/32] ASoC: Intel: kbl: fix wrong number of channels
Date:   Fri, 26 Apr 2019 21:42:16 -0400
Message-Id: <20190427014224.8274-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
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
index 69ab55956492..41cb1fefbd42 100644
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

