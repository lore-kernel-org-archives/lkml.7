Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98743C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9A6217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427562;
	bh=DlwqHKX9HesHpaoi5gq2+Nbnpb6Iun8ERTUB5rF1+IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q/EoRofBGR5j5FZQdhFbNBVE0C2caXybDmd1ZWA8eTHaxKWAykT5jYkYUIICPqKWc
	 x1QcWu7WZoeiGun5EBq/umQjvitIQW7uChekIHMwvn0nxHZlp/uxcYNuCMRn/s4K5v
	 t7SJbUGuKASDnTPw0e1FzPAapYdx2x9NiaoWh6Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfEISqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfEISp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:45:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A01217F9;
        Thu,  9 May 2019 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427557;
        bh=DlwqHKX9HesHpaoi5gq2+Nbnpb6Iun8ERTUB5rF1+IA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDBw+xJ3oNeo7uZrrk7PXAZcOLahEmjyGaePRX0NaWpOUx20crJX6R0MWE8sBq9IC
         AsRWjNumm21+oXpmezQBgNuYhIoTUSuzSoWxuk85BUA4WSVHfOGTki5h37lbmRDbIt
         w70NUOear30yfpPJJ8RCEl9Ws0/8N0BvkqijbddY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 26/42] ASoC: Intel: kbl: fix wrong number of channels
Date:   Thu,  9 May 2019 20:42:15 +0200
Message-Id: <20190509181257.909030705@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 69ab559564921..41cb1fefbd427 100644
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
2.20.1



