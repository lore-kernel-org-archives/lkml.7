Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5E6C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94FB217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427695;
	bh=oyTjSecDC36hOUXR6U4y+GsvDs0eI8Nz8IgZeszoFVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=glsTnZJwEM+KDCgxzZk0P0SnAXBqXPdpedlKYcVJ5kRue5SBrg1pP96lH7dm26h8W
	 y4GunxMPbAVhYhnOHsHRLWk76NoNanPqocpRuvZzQY6EPbNHK7N4sse3kk+GZYjfhb
	 rptk7AQnOrTBmunfZqrpEArMTOjm37YKVtT2xDEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfEISsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfEISsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:48:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B5220578;
        Thu,  9 May 2019 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427690;
        bh=oyTjSecDC36hOUXR6U4y+GsvDs0eI8Nz8IgZeszoFVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDZ7mWgVROzL6aWPt2il9XufgdH4U2efOli5mrdgMHG8iT14O7SrLCzWqVh9PIRO5
         4WVf4X7Jb5KuAcQcmqw3sCGbmNbj3R7hL99+1CvcolH8HsE3WJNSv81/QraPvkEVr3
         1GwkReVT8GGvBrZJppY1FqxlSCbVoLvAr4krJAHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/66] ASoC: rockchip: pdm: fix regmap_ops hang issue
Date:   Thu,  9 May 2019 20:42:08 +0200
Message-Id: <20190509181305.487739394@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c85064435fe7a216ec0f0238ef2b8f7cd850a450 ]

This is because set_fmt ops maybe called when PD is off,
and in such case, regmap_ops will lead system hang.
enale PD before doing regmap_ops.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/rockchip/rockchip_pdm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 400e29edb1c9c..8a2e3bbce3a16 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -208,7 +208,9 @@ static int rockchip_pdm_set_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
+	pm_runtime_get_sync(cpu_dai->dev);
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, mask, val);
+	pm_runtime_put(cpu_dai->dev);
 
 	return 0;
 }
-- 
2.20.1



