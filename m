Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E0FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423EA218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239216;
	bh=v3Vsq1jWVxR4xtDWLkdlbQS32M/Y8m4OfBUBuowFf88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0bE0xp9FPL/GGNZ+CsnANhf8bL5Ni8Fw+myKOcL02X2U1aUOEHIfx74GSenZ8rqOk
	 JS16aWbMYpo6EhgJuVWzU3GNmh81xL7pI982NX9hv3v+lixPtI4ZZQfylFVI1NfNnV
	 RGYc3z5nhEZF83a701wpRVm3ymaOUttstgg6VIkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfKHSxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732330AbfKHSxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:53:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B675A21D7E;
        Fri,  8 Nov 2019 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239211;
        bh=v3Vsq1jWVxR4xtDWLkdlbQS32M/Y8m4OfBUBuowFf88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I82p5YtCYvUiux2B1qCo801zFqtMQWb/AV+FfQtljZJsDctlbIRNhRNcU/JdTDjgo
         e64k1zsdP1Od7CJPtkeig2eSLGq9xE5VOn8rtx8+P4V6mlsHn7ZFWINHquossIvHzB
         LT8pv1C/HUn0nN6E0m1YCD/3mdgdczqyj3VgBCGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 04/75] ASoc: rockchip: i2s: Fix RPM imbalance
Date:   Fri,  8 Nov 2019 19:49:21 +0100
Message-Id: <20191108174711.263144275@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174708.135680837@linuxfoundation.org>
References: <20191108174708.135680837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit b1e620e7d32f5aad5353cc3cfc13ed99fea65d3a ]

If rockchip_pcm_platform_register() fails, e.g. upon deferring to wait
for an absent DMA channel, we return without disabling RPM, which makes
subsequent re-probe attempts scream with errors about the unbalanced
enable. Don't do that.

Fixes: ebb75c0bdba2 ("ASoC: rockchip: i2s: Adjust devm usage")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/bcb12a849a05437fb18372bc7536c649b94bdf07.1570029862.git.robin.murphy@arm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 58ee64594f075..f583f317644a1 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -530,7 +530,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
-		return ret;
+		goto err_suspend;
 	}
 
 	return 0;
-- 
2.20.1



