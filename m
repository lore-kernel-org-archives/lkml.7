Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4AEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319AA214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576083317;
	bh=HVBphXmEK1xl6NKbEPhHQJYMjSXqtsrVGSjZSGZpEMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=iEMHsnnypG9AVgRCh70gXN4d5NMVxd5Fv+i5+oGi+Dtkt+vp7dKy0MTPJDlmsPDeG
	 y7CLlgugoGF/riJSA8wdTa4VhjbYchH9TUNhW0HZItOxbZLGs1pNK0F2GQe77J1q0+
	 CxnJbACeT/jCh1xaD1NRrtU9sO9NofbEMvmPJwEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfLKQzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:55:16 -0500
Received: from foss.arm.com ([217.140.110.172]:39450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfLKQzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:55:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AEA930E;
        Wed, 11 Dec 2019 08:55:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF4CF3F52E;
        Wed, 11 Dec 2019 08:55:14 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:55:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        pakki001@umn.edu
Subject: Applied "spi: dw: Avoid BUG_ON() in case of host failure" to the spi tree
In-Reply-To: <20191205231421.9333-1-pakki001@umn.edu>
Message-Id: <applied-20191205231421.9333-1-pakki001@umn.edu>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: Avoid BUG_ON() in case of host failure

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

From 169f9acae08685d4f2a6fd32983958d44e10905d Mon Sep 17 00:00:00 2001
From: Aditya Pakki <pakki001@umn.edu>
Date: Thu, 5 Dec 2019 17:14:21 -0600
Subject: [PATCH] spi: dw: Avoid BUG_ON() in case of host failure

If dws is NULL in dw_spi_host_add(), we return the error to the
upper callers instead of crashing. The patch replaces BUG_ON by
returning -EINVAL to the caller.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Link: https://lore.kernel.org/r/20191205231421.9333-1-pakki001@umn.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5cd4fbe..a160d9a141ea 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -460,7 +460,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	struct spi_controller *master;
 	int ret;
 
-	BUG_ON(dws == NULL);
+	if (!dws)
+		return -EINVAL;
 
 	master = spi_alloc_master(dev, 0);
 	if (!master)
-- 
2.20.1

