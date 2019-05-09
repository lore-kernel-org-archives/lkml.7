Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F78C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4A0217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427492;
	bh=R0xt+Mboz/16FYJp6o4XhcEQyCvEqcf/6RPQv/EjdVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ebOer/AWMtYB0lU8e32Mr85ltfP1UzrAM6memn+SO670+Dw170O1SYiJKVorLQo0N
	 5QQ8cJ/4qw+DP23YCfn1CH7UW3hcvxzSIwnW1nhHUduMAjQ4LiB8a6JXr2eWwuEeZT
	 vSKiK1N+2bAxk0vuVFcgl/LMt0cydGmmej+/5mJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfEISou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfEISot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:44:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAF86217D6;
        Thu,  9 May 2019 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427489;
        bh=R0xt+Mboz/16FYJp6o4XhcEQyCvEqcf/6RPQv/EjdVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqO4aO3vH0ILK/rVsgxtKhO9ZeRi21vXaU+KruIdxO74HVm12oIcrGrtc6uXoIEJY
         9gac5jtf08Q7CH/PtqUdSmH8lzmvGjKiRWdxWkOk3PzV7FgFP2WeHdzpjl1+UKfz/o
         rSl8BKMg9roj1MXIziyIdE2r/aJ/Q9DcWrwMNCwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Annaliese McDermond <nh6z@nh6z.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 08/28] ASoC: tlv320aic32x4: Fix Common Pins
Date:   Thu,  9 May 2019 20:42:00 +0200
Message-Id: <20190509181251.995196533@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181247.647767531@linuxfoundation.org>
References: <20190509181247.647767531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c63adb28f6d913310430f14c69f0a2ea55eed0cc ]

The common pins were mistakenly not added to the DAPM graph.
Adding these pins will allow valid graphs to be created.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 28fdfc5ec5443..c27e3476848a8 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -316,6 +316,8 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("IN2_R"),
 	SND_SOC_DAPM_INPUT("IN3_L"),
 	SND_SOC_DAPM_INPUT("IN3_R"),
+	SND_SOC_DAPM_INPUT("CM_L"),
+	SND_SOC_DAPM_INPUT("CM_R"),
 };
 
 static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
-- 
2.20.1



