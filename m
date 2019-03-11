Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4699EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F30B2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334255;
	bh=Xr0qhAI7fHGXlMpXb0ODsW/u9hQRT5Nqovpk7E7rFDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drpmJ1LO3N1LPrPs2lWtRzeUQwknFOt5KmsU27apHoICUKsiDSLxR7deE1zf8TW1U
	 it+8/FduLuVoIaiyOU+4IcCDScON+hk9h3HFMV6gPUonAqaeEUnZLP5s/AuO7M4wQd
	 XUYb9qZ2zEyd/xHkvvIhS/FgXwQl0NBRZdOOEoEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfCKT5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbfCKT5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C5C2084F;
        Mon, 11 Mar 2019 19:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334249;
        bh=Xr0qhAI7fHGXlMpXb0ODsW/u9hQRT5Nqovpk7E7rFDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lt2Zi6p39EA4zg6HwUY7H4sHydPWjNbwnmJuI/EoBm0eceR96iMlADLo0I90xcEhC
         YvdgkBV4lKttxSKWDboJqEY3omtG2ivQ2Eng2V7dr2DfM8VFQTOK2YxDeMy/gOpqqf
         XBfAAEYGucJefBMmNrghjA4vXzRzhSy/PV+VPl2E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 15/44] ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count check
Date:   Mon, 11 Mar 2019 15:56:31 -0400
Message-Id: <20190311195700.138462-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit d9111d36024de07784f2e1ba2ccf70b16035f378 ]

commit 4d230d1271064 ("ASoC: rsnd: fixup not to call clk_get/set
under non-atomic") added new rsnd_ssi_prepare() and moved
rsnd_ssi_master_clk_start() to .prepare.
But, ssi user count (= ssi->usrcnt) is incremented at .init
(= rsnd_ssi_init()).
Because of these timing exchange, ssi->usrcnt check at
rsnd_ssi_master_clk_start() should be adjusted.
Otherwise, 2nd master clock setup will be no check.
This patch fixup this issue.

Fixes: commit 4d230d1271064 ("ASoC: rsnd: fixup not to call clk_get/set under non-atomic")
Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Reported-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index a566dae3ec8a..9410e0a9b14b 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -283,7 +283,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
-	if (ssi->usrcnt > 1) {
+	if (ssi->usrcnt > 0) {
 		if (ssi->rate != rate) {
 			dev_err(dev, "SSI parent/child should use same rate\n");
 			return -EINVAL;
-- 
2.19.1

