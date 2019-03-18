Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE97C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F42B20879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920775;
	bh=npRtBXxki793xgWDkmDNTGGsr3sxcpsqi6FgvOkOFYY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=V5soVUR2f9pDQBetTYHiT2vpNRoekpcOq6WarlzpfCYR0yk5rwDE78EhPQAsS3v0O
	 ebmGe5sOyk0dO4tCLv+iPCkRlb7wlE3V2TiA2m+lL8+yjKcjYc5aPCziS9sAwgMKyt
	 sMty00JErhKcMVDm0KK/p2/sCAmJ0zwdcXAZ+EgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfCROwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:52:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55234 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfCROvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=invzSgSczu4KOJo9bs9/boWtpl/Zl2sNTI22SgRrmSo=; b=mBfyrV4nd9Pb
        LMRtY4JsULmx4qoHUwvxde2oKjKifUZJxaQJeTMOpXGOnyF1tuJPloWRPhqqXZgUdTs6QmbHAV2Rb
        dAgOrEHc+Lciqt5G4NPh7uoSxKfcF4m+KM7jHvjTJHr1ion1rie2nnAUSK2ogaqqu5BYzpPzaE4DI
        Td2A4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tc4-0005oX-F3; Mon, 18 Mar 2019 14:51:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0F0E21128874; Mon, 18 Mar 2019 14:51:40 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mt6380: Use unsigned int for volt_tables" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145140.0F0E21128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:40 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mt6380: Use unsigned int for volt_tables

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

From 1fc26296a26088442fefc489de94d8592e013375 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 6 Mar 2019 09:43:31 +0800
Subject: [PATCH] regulator: mt6380: Use unsigned int for volt_tables

Make it consistent as .volt_table should be const unsigned int *.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mt6380-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mt6380-regulator.c b/drivers/regulator/mt6380-regulator.c
index 127dd720cbcc..86bc332df3f2 100644
--- a/drivers/regulator/mt6380-regulator.c
+++ b/drivers/regulator/mt6380-regulator.c
@@ -173,19 +173,19 @@ static const struct regulator_linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0, 0x3c, 25000),
 };
 
-static const u32 ldo_volt_table1[] = {
+static const unsigned int ldo_volt_table1[] = {
 	1400000, 1350000, 1300000, 1250000, 1200000, 1150000, 1100000, 1050000,
 };
 
-static const u32 ldo_volt_table2[] = {
+static const unsigned int ldo_volt_table2[] = {
 	2200000, 3300000,
 };
 
-static const u32 ldo_volt_table3[] = {
+static const unsigned int ldo_volt_table3[] = {
 	1240000, 1390000, 1540000, 1840000,
 };
 
-static const u32 ldo_volt_table4[] = {
+static const unsigned int ldo_volt_table4[] = {
 	2200000, 3300000,
 };
 
-- 
2.20.1

