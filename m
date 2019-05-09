Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C9EC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6B020656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428348;
	bh=2PFsMYG+mKXHwmubDCUGEfYhxQOXD3Jk4Q8q1MGnEJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eGznmHJ9KtFoJoodOY15WvD2EzW9d8piWkgc+fZGUvnwd1qHYqHqlGh/Zf+PYfcCL
	 iZcblKPjnE3GRMjgHS/DWPdoG4V9ne6s0Rn2wWVY8gwmJ54w7h/BDEJn6ogcHZx63p
	 ZJrPC5y5jeghmG5R1/eIBv5/e9H6MCoDjTX71KeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfEIS7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbfEISwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:52:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4556A217F9;
        Thu,  9 May 2019 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427963;
        bh=2PFsMYG+mKXHwmubDCUGEfYhxQOXD3Jk4Q8q1MGnEJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBXidvFAadDinu2YNdprahZCf8IvJco/s+39RZ217IkyBgTY1xahc3l5P+qvkImNn
         /11Hn0o2GbKynjxwR7o9cf+YRwWq6HMjf6jthI7b+u3bUVRzAV//KycwmZeteaG5/f
         szBi7y0RMrrD5/b3sgK7ydu3aq5tBXrTu+frcXXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Annaliese McDermond <nh6z@nh6z.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 34/95] ASoC: tlv320aic32x4: Fix Common Pins
Date:   Thu,  9 May 2019 20:41:51 +0200
Message-Id: <20190509181311.689517422@linuxfoundation.org>
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
index f03195d2ab2ea..45d9f4a090441 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -462,6 +462,8 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("IN2_R"),
 	SND_SOC_DAPM_INPUT("IN3_L"),
 	SND_SOC_DAPM_INPUT("IN3_R"),
+	SND_SOC_DAPM_INPUT("CM_L"),
+	SND_SOC_DAPM_INPUT("CM_R"),
 };
 
 static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
-- 
2.20.1



