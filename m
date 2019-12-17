Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D884FC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE76A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576586378;
	bh=vvz7gRRGOLVgJN2hy14P3yRZf+0s4neZD7mnv0tCiOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=2Z6cqRyqCpbq6Rso2PqHZGnjAzVyHshtWyFAv2uWAQNl4xbocpKKYxU1F7zy+t+DJ
	 M2U3R04xwFgBZ/A+pJgIFCLLsBmBxwPHLC6aHUb9hEd6ZumS2TGpIUQCFKzRLkryw/
	 JWg4G8AaVE08aebK2C45rlZsjHwMvqTvJagyU3uY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfLQMjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:39:37 -0500
Received: from foss.arm.com ([217.140.110.172]:35672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbfLQMjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:39:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9169431B;
        Tue, 17 Dec 2019 04:39:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11FBF3F718;
        Tue, 17 Dec 2019 04:39:34 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:39:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Applied "spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER" to the spi tree
In-Reply-To: <20191216230802.45715-2-jquinlan@broadcom.com>
Message-Id: <applied-20191216230802.45715-2-jquinlan@broadcom.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From f4dc4abdce4cc290555604107c04854a911b9441 Mon Sep 17 00:00:00 2001
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Mon, 16 Dec 2019 18:08:02 -0500
Subject: [PATCH] spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER

Use dev_dbg() on -EPROBE_DEFER and dev_err() on all
other errors.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Link: https://lore.kernel.org/r/20191216230802.45715-2-jquinlan@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 69df79914504..b784c9fdf9ec 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1317,7 +1317,10 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
-		dev_err(&pdev->dev, "could not get clk: %d\n", err);
+		if (err == -EPROBE_DEFER)
+			dev_dbg(&pdev->dev, "could not get clk: %d\n", err);
+		else
+			dev_err(&pdev->dev, "could not get clk: %d\n", err);
 		goto out_controller_put;
 	}
 
-- 
2.20.1

