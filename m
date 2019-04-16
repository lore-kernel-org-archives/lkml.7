Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B0DC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E682F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfDPEsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:48:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfDPEsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:48:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A3DCAF40;
        Tue, 16 Apr 2019 04:48:17 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Tue, 16 Apr 2019 14:47:29 +1000
Subject: [PATCH 2/5] mmc: mtk-sd: don't hard-code interrupt trigger type
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155539004923.25108.12499096383277776864.stgit@noble.brown>
In-Reply-To: <155538933003.25108.3338569916935462285.stgit@noble.brown>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using devicetree for configuration, interrupt trigger type
should be described in the dts file, not hard-coded in the C code.

The mtk-sd silicon in the mt7621 soc uses an active-high interrupt
and so cannot be used with the current code.

So remove the trigger and leave it to be set from devicetree.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/mtk-sd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4492a4465c0e..14e048239143 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2243,7 +2243,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_init_hw(host);
 
 	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
-		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
+			       0, pdev->name, host);
 	if (ret)
 		goto release;
 


