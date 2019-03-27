Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907722070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712184;
	bh=yndFG5TDCiBAyRfMNpx2aFT8XMkFs6scNwzQFgVIs1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZYbrbrrlCs6E5w7ibneIobWT9DdHn+4ph3C5Fkihdk3+L0Z4ijNNPGz4iF9bwY9gI
	 Dq6X/LUra5wf1M9yZ9v4CNR49CxWOtILGRksWm2eiLe1AUAif7/27RP9Vl/ywDbBB9
	 5YdnLySNUhPJJnoaBXe3WZLUSgS4lXmtUv/jaEds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391835AbfC0SnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390658AbfC0SVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:21:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44AF2082F;
        Wed, 27 Mar 2019 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710903;
        bh=yndFG5TDCiBAyRfMNpx2aFT8XMkFs6scNwzQFgVIs1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLPBikNZ9r7QzAsMT3sSf/wUrp1D5rG7fiCVSpq+2rVJCcP1ZIhiq4KQWSE+/Q65o
         +xppZ/bFUVfzll6r4gdZcw/z1dW2uDe7YUKXzAnUXtZgzQiM3ioi+tk86AJMadpP1W
         9z1WNgwJ2L3R8B6OJiz3i0qHpz/xRzmza27qB3Ng=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <yellowriver2010@hotmail.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 38/87] SoC: imx-sgtl5000: add missing put_device()
Date:   Wed, 27 Mar 2019 14:19:51 -0400
Message-Id: <20190327182040.17444-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <yellowriver2010@hotmail.com>

[ Upstream commit 8fa857da9744f513036df1c43ab57f338941ae7d ]

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Detected by coccinelle with the following warnings:
./sound/soc/fsl/imx-sgtl5000.c:169:1-7: ERROR: missing put_device;
call of_find_device_by_node on line 105, but without a corresponding
object release within this function.
./sound/soc/fsl/imx-sgtl5000.c:177:1-7: ERROR: missing put_device;
call of_find_device_by_node on line 105, but without a corresponding
object release within this function.

Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index b99e0b5e00e9..8e525f7ac08d 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -115,6 +115,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		ret = -EPROBE_DEFER;
 		goto fail;
 	}
+	put_device(&ssi_pdev->dev);
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
 		dev_err(&pdev->dev, "failed to find codec platform device\n");
-- 
2.19.1

