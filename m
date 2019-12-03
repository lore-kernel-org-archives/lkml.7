Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17302C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8002073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412823;
	bh=Y1eV9BGmJlwzfgq2f4elwfN8nxcAwz5R2WINNQ6BsAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AKMr4uMQyZli+XaUtIRfcJTe/23+0Fqe84ayq+CFCy9EmKhbjJLODSZ/zPd7I2v7m
	 rAKShcvQ59poCNFfPmzUWBPyfMmOsc7l05hY0Df/3aAZ43r6S52hmYLpwhJSIqaHNL
	 86F8JLncbZZPhPBEiRBbo9LEbE9OpfK85GB3CA/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfLCWkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbfLCWkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A1FE20684;
        Tue,  3 Dec 2019 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412813;
        bh=Y1eV9BGmJlwzfgq2f4elwfN8nxcAwz5R2WINNQ6BsAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9nGsemOrYd1/VsW2+wQp4yiMzV7ibbFKZqSZZK3cDzdtB/QWLnkHifWuNdqj0FxK
         8Toestr1/1vPnqpQaqa0uYqvermI9r70LW6bRX1HArb+gt8MCjYYkAsD6ppcawaBBi
         EXCFqrGcBMObQ2uTzu60OUBwg1ecXS6v4L87j2M4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 026/135] ASoC: ti: sdma-pcm: Add back the flags parameter for non standard dma names
Date:   Tue,  3 Dec 2019 23:34:26 +0100
Message-Id: <20191203213010.769114594@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit dd7e8d903e1eef5a9234a2d69663dcbfeab79571 ]

When non standard names are used it is possible that one of the directions
are not provided, thus the flags needs to be present to tell the core that
we have half duplex setup.

Fixes: 642aafea8889 ("ASoC: ti: remove compat dma probing")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191028115207.5142-1-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/sdma-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/sdma-pcm.c b/sound/soc/ti/sdma-pcm.c
index a236350beb102..2b0bc234e1b69 100644
--- a/sound/soc/ti/sdma-pcm.c
+++ b/sound/soc/ti/sdma-pcm.c
@@ -62,7 +62,7 @@ int sdma_pcm_platform_register(struct device *dev,
 	config->chan_names[0] = txdmachan;
 	config->chan_names[1] = rxdmachan;
 
-	return devm_snd_dmaengine_pcm_register(dev, config, 0);
+	return devm_snd_dmaengine_pcm_register(dev, config, flags);
 }
 EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
 
-- 
2.20.1



