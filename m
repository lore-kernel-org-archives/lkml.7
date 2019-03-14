Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F8721855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578876;
	bh=PncR2uC5rwylKgdBzFv7PQArEYAhdShLI6BL1EZ1RsU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=g1JPai23RjQVcLltYxPGk5iovutublMVvjfQPIJOlGEuLI+MSTps2zHTO1Oc1Py1N
	 0r3dhNSc/0R3mtnGfsOAmgjrYUj54ubGTQeM6vbQWolWfztHf4s74gfnwCt9SoU8+5
	 YAKWDaQwuX8oE6d+wsXKIiShX8YHbza0RIr+zJGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCNPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfCNPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aHpRfMr7WQXjq7PUaew04ukI0mD+0YkzrNCtHE+vJiA=; b=VgoTJxhAfHOL
        ooHdq2A8Lz2XUHTDRwovXKgOGMpcX/UwFUN+4d4aGQjcAmh7FDssIckO9iJT0UjUuj3cFj6bi4rfO
        mX1HZmV8cbHcqwPoQ8sekjRWbBJS1cC+lZRVjzp+0NlRFGijDpklAmpfRC7JRQKR+5hCtFdckDE0h
        z94GM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4Sgf-0002jb-77; Thu, 14 Mar 2019 15:54:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 99F1F1126E64; Thu, 14 Mar 2019 15:54:28 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: gpio: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190314155428.99F1F1126E64@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:28 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: gpio: Constify regulator_ops

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

From 705e2a905a0407c3fffb248b43c8d7d1de6b4e51 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 8 Mar 2019 14:15:29 +0800
Subject: [PATCH] regulator: gpio: Constify regulator_ops

gpio_regulator_voltage_ops and gpio_regulator_current_ops should never
change, make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/gpio-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 967338bf1dc1..f50d86a66138 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -124,7 +124,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 	return 0;
 }
 
-static struct regulator_ops gpio_regulator_voltage_ops = {
+static const struct regulator_ops gpio_regulator_voltage_ops = {
 	.get_voltage = gpio_regulator_get_value,
 	.set_voltage = gpio_regulator_set_voltage,
 	.list_voltage = gpio_regulator_list_voltage,
@@ -220,7 +220,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 	return config;
 }
 
-static struct regulator_ops gpio_regulator_current_ops = {
+static const struct regulator_ops gpio_regulator_current_ops = {
 	.get_current_limit = gpio_regulator_get_value,
 	.set_current_limit = gpio_regulator_set_current_limit,
 };
-- 
2.20.1

