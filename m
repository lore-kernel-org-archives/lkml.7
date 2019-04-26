Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDB3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22913206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271896;
	bh=sK85wNMU/96XkfkAJK+U9WxIqwpDV/OKo2rr3tEfq5k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2OLRC16MGPRYuWjBfL7AH8myoacpOXITnTw1/DCXQjLqtgYHaS53wnSBuNaRSrQD7
	 tEBY0zmZ0pc2pjBbSxTuqFbZVMtpluKQ1TuDbLOu9r0cU2m8qIFSHKYe/qIfJfN9d2
	 YzuEgzKW0Joxzmvo2qtwqGFfUa+oIeVnF/l1JLEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfDZJoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:44:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53298 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfDZJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BVjhokI7gu+paERydgpKZEsS8C/K0/37ZUVB7oGK16Q=; b=TqHi32LXDyfP
        VrsjcSezp4nfIYIqA5L1h7tsYVwgu/5rgtyfcUphaHvfua2nS0gJQomi1KDiFUa+fhvcVIMfduONr
        puA7Z0O95xg/RXHoNysDhQwrtSd3F6cbQuddRq5LX5i+0SLojmtxF9qZvLVXJ4UZVsqxpv/bBBBZ4
        eL6FM=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxPP-0003PW-9j; Fri, 26 Apr 2019 09:44:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4AC89441D3B; Fri, 26 Apr 2019 10:44:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: stm32-pwr: Fix return value check in stm32_pwr_regulator_probe()" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094442.4AC89441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:44:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stm32-pwr: Fix return value check in stm32_pwr_regulator_probe()

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From dc62f951a6a8490bcccc7b6de36cd85bd57be740 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Wed, 17 Apr 2019 02:30:59 +0000
Subject: [PATCH] regulator: stm32-pwr: Fix return value check in
 stm32_pwr_regulator_probe()

In case of error, the function of_iomap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 6cdae8173f67 ("regulator: Add support for stm32 power regulators")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stm32-pwr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 222d593d76a2..7b39a41530d4 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -140,9 +140,9 @@ static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 	int i, ret = 0;
 
 	base = of_iomap(np, 0);
-	if (IS_ERR(base)) {
+	if (!base) {
 		dev_err(&pdev->dev, "Unable to map IO memory\n");
-		return PTR_ERR(base);
+		return -ENOMEM;
 	}
 
 	config.dev = &pdev->dev;
-- 
2.20.1

