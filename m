Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE277C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC31218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180851;
	bh=ioNYyv1eY5IG0c0SVnHPkaMTiSqmaG8ex4utjJO0m0U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=a/5QuFuIpRHahw+9hY53SGItlZCxwtNwlcrViYNE+BQZbn9YeC7BjEYyT5kl0BGTU
	 7LK0EUcOzGkRYpwYEb5J1Njo3jcOrTOevcXhzYWxNfnaULyt4m11UtAZiJg/V+UcO5
	 RyfM/c9LnlQJnxkj6eHGu7xGMnmM8gvPe3Zq1MtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfCUPH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:07:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Qki20OJR+3zDqpq0x4Ah1tUxx6kMg81+X8n+ksX95Zg=; b=gIOiJKp5Fn6M
        sbbtWIc91SgauSh8e5ltRj7WknSuFQmr+Ds+Q6vt4mHy4+1qVVmZQwzI+QUarbfWKxMiABfcT9b6m
        MXIGcF8J5QLpSmvqvVaKAIf1Wf727GZCHVnqk8944G3ONwdo9WIyW1iXaHtVCnegptx/MTpjd8j6H
        8wIN8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zHw-0005dR-Oc; Thu, 21 Mar 2019 15:07:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4EC0F11288EC; Thu, 21 Mar 2019 15:07:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: add regulator_get_linear_step() stub helper" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190321150724.4EC0F11288EC@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:07:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: add regulator_get_linear_step() stub helper

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

From 7287275b4301e230be9e4569431c7dacb67ebc13 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Mar 2019 20:38:29 +0100
Subject: [PATCH] regulator: add regulator_get_linear_step() stub helper

The regulator header has empty inline functions for most interfaces,
but not regulator_get_linear_step(), which has just grown a user
that does not depend on regulators otherwise:

drivers/clk/tegra/clk-tegra124-dfll-fcpu.c: In function 'get_alignment_from_regulator':
drivers/clk/tegra/clk-tegra124-dfll-fcpu.c:555:19: error: implicit declaration of function 'regulator_get_linear_step'; did you mean 'regulator_get_drvdata'? [-Werror=implicit-function-declaration]
  align->step_uv = regulator_get_linear_step(reg);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
                   regulator_get_drvdata
cc1: all warnings being treated as errors
scripts/Makefile.build:278: recipe for target 'drivers/clk/tegra/clk-tegra124-dfll-fcpu.o' failed

Add the missing stub along the others.

Fixes: b3cf8d069505 ("clk: tegra: dfll: CVB calculation alignment with the regulator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/consumer.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index f3f76051e8b0..aaf3cee70439 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -478,6 +478,11 @@ static inline int regulator_is_supported_voltage(struct regulator *regulator,
 	return 0;
 }
 
+static inline unsigned int regulator_get_linear_step(struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_set_current_limit(struct regulator *regulator,
 					     int min_uA, int max_uA)
 {
-- 
2.20.1

