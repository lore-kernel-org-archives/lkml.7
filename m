Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AB2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B8120879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552920772;
	bh=lote+ZUFMCiqxE79Axmz+we6C9COWfSuCmKoqD84SRk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=xfBgp1LhFMCuBNaV5q0Q0/vwFfwNtosbv9TjxiHa8JMwqTh1j3n54wY6Jkr9gFSrL
	 98SmkQxx87Ht1Cq6KGqAqDeYBLvmVKdvCTDlpQAjyhyBJakC56CDjDwUIO1mhObxmJ
	 6JpHXkUajKCGPqJteM48YuWPTPWum15MPNXgpGUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfCROwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:52:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55240 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfCROvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oBeRtsgoXWn00oJPVjvn5xUjdmzULnjz87IOjhFzsmI=; b=c5wse4eETMzo
        s6jhtJp5Aem8sDC/b6padRlKy+k65ymSMCAAQjLaSobdg9OpyDHwxp26UUOfuhFuvQsnkwiJUZqcJ
        nJdPFZg3wjpgwc4+wIqC42wDV7ikrwhRDZBznJcHYhmF4nl4K8UugInI/Ae1g3TK4Xk+FpvcUXKgL
        +6PLo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h5tc6-0005oc-3K; Mon, 18 Mar 2019 14:51:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A699C1128874; Mon, 18 Mar 2019 14:51:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mt6323: Use unsigned int for volt_tables" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190318145141.A699C1128874@debutante.sirena.org.uk>
Date:   Mon, 18 Mar 2019 14:51:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mt6323: Use unsigned int for volt_tables

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

From dad110a0c5c1a26782af571d49c439d6fd245901 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 6 Mar 2019 09:43:30 +0800
Subject: [PATCH] regulator: mt6323: Use unsigned int for volt_tables

Make it consistent as .volt_table should be const unsigned int *.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mt6323-regulator.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index b7b9670f0979..25b002328910 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -118,43 +118,43 @@ static const struct regulator_linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
 };
 
-static const u32 ldo_volt_table1[] = {
+static const unsigned int ldo_volt_table1[] = {
 	3300000, 3400000, 3500000, 3600000,
 };
 
-static const u32 ldo_volt_table2[] = {
+static const unsigned int ldo_volt_table2[] = {
 	1500000, 1800000, 2500000, 2800000,
 };
 
-static const u32 ldo_volt_table3[] = {
+static const unsigned int ldo_volt_table3[] = {
 	1800000, 3300000,
 };
 
-static const u32 ldo_volt_table4[] = {
+static const unsigned int ldo_volt_table4[] = {
 	3000000, 3300000,
 };
 
-static const u32 ldo_volt_table5[] = {
+static const unsigned int ldo_volt_table5[] = {
 	1200000, 1300000, 1500000, 1800000, 2000000, 2800000, 3000000, 3300000,
 };
 
-static const u32 ldo_volt_table6[] = {
+static const unsigned int ldo_volt_table6[] = {
 	1200000, 1300000, 1500000, 1800000, 2500000, 2800000, 3000000, 2000000,
 };
 
-static const u32 ldo_volt_table7[] = {
+static const unsigned int ldo_volt_table7[] = {
 	1200000, 1300000, 1500000, 1800000,
 };
 
-static const u32 ldo_volt_table8[] = {
+static const unsigned int ldo_volt_table8[] = {
 	1800000, 3000000,
 };
 
-static const u32 ldo_volt_table9[] = {
+static const unsigned int ldo_volt_table9[] = {
 	1200000, 1350000, 1500000, 1800000,
 };
 
-static const u32 ldo_volt_table10[] = {
+static const unsigned int ldo_volt_table10[] = {
 	1200000, 1300000, 1500000, 1800000,
 };
 
-- 
2.20.1

