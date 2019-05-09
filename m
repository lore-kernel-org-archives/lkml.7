Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEF1C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1330520656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428373;
	bh=WJvsFmiNnD3JAu2A7tBGnTicd1a08s3HqNRGliZJWsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuDk7riRA/oZvaUFL8AODf/SYhjAujRhbAoArgPrpPWzLaLCrVY84/Fm05OxD9Zrm
	 R7m3dtjUi1deAyl7dGMS49WyMXga/xVl5cKIJBRKIxbYv4wp4JuSwm+m1SXax08PW1
	 FKuYxd8nh53sl+PP/HGYDGf3M6UoQvHiEEkYGkbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfEIS7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbfEISwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:52:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 189FB204FD;
        Thu,  9 May 2019 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427943;
        bh=WJvsFmiNnD3JAu2A7tBGnTicd1a08s3HqNRGliZJWsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fli8QLd5SWczk4u05rxlrtsskZMb5cjSGB8zFkBD/msOjK1+j9rJM4zQPDa6LLNw2
         gXXgHswfDxHgB8du4pYgRyEagkzDBiYivIlYnZ97t5GYk08RhtRGQkSZl3GZpV8mAt
         kQvyI2uvXA55SoZPfTCNi+SJ10H6m1da5jKY2AIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 61/95] ASoC: Intel: kbl: fix wrong number of channels
Date:   Thu,  9 May 2019 20:42:18 +0200
Message-Id: <20190509181313.748466067@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
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
index 7044d8c2b1873..879f14257a3ea 100644
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



