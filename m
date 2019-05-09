Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C4C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED5421848
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427544;
	bh=oyTjSecDC36hOUXR6U4y+GsvDs0eI8Nz8IgZeszoFVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B+o2E496JLyt2KkfMyd1mFdlO85pdWImPSZ+KkuJc1+yW1tktVcYQXC077x1C3Dql
	 y+A0BiwNxLwCByZfo3hRLNEHJ0Jjnzkfg4j7LoHwf91cdjlMOaItBwnV+caK57xBz3
	 iIeXxeYyJKFifAz8yVYYlicneKhJ2JMzcFq6ApJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfEISpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfEISpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:45:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A802182B;
        Thu,  9 May 2019 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427541;
        bh=oyTjSecDC36hOUXR6U4y+GsvDs0eI8Nz8IgZeszoFVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQmPgu6iDqi9lI4EUPiJrIkEgyGZf3ahsRf4iXsvJHcl5c7l1wHWyf21y3CQOf5yz
         A9bu0EkUsvtiLKGNFsQMqmq8z/6orkkXerfB6fhBMCHoD3mIlPALnl8mcD0cbmaBCb
         iqU2rewBdURwMPON3mfHVCMTofIhxrviCLKXSvq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sugar Zhang <sugar.zhang@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 20/42] ASoC: rockchip: pdm: fix regmap_ops hang issue
Date:   Thu,  9 May 2019 20:42:09 +0200
Message-Id: <20190509181256.789071130@linuxfoundation.org>
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



