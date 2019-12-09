Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77176C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D1C206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575918015;
	bh=pXhfBms3bXEO/TcxmF5pei6VfkbtEXzgTDikHYxz8yQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=p2WuUc5jY3KieeNVPL7dSomcel0ZbGzA5J+TjiD2CZf6ePh4lyQ9+1sRG6G8HVAXD
	 oRh6NlCXZo8J1BZ+Nuu6+VJjya783ZiruVowEU99XBh3TopSvQcCepmrji8/W5t9gA
	 Kx8KwIcBBH4uCI18OoqI15Zqq5xq3855zO3XsUvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLITAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:00:13 -0500
Received: from foss.arm.com ([217.140.110.172]:42622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfLITAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:00:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A656C328;
        Mon,  9 Dec 2019 11:00:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F73A3F6CF;
        Mon,  9 Dec 2019 11:00:08 -0800 (PST)
Date:   Mon, 09 Dec 2019 19:00:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: avoid unneeded .list_voltage calls" to the regulator tree
In-Reply-To: <20191209125239.46054-1-cristian.marussi@arm.com>
Message-Id: <applied-20191209125239.46054-1-cristian.marussi@arm.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: avoid unneeded .list_voltage calls

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From 6d30fc511bec82dd8801b9bb8718cbeea1366ad8 Mon Sep 17 00:00:00 2001
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 9 Dec 2019 12:52:39 +0000
Subject: [PATCH] regulator: core: avoid unneeded .list_voltage calls

Inside machine_constraints_voltage() a loop is in charge of verifying that
each of the defined voltages are within the configured constraints and
that those constraints are in fact compatible with the available voltages'
list.

When the registered regulator happens to be defined with a wide range of
possible voltages the above O(n) loop can be costly.
Moreover since this behaviour is triggered during the registration process,
it means also that it can be easily triggered at probe time, slowing down
considerably some module loading.

On the other side if such wide range of voltage values happens to be also
continuous and without discontinuity of any kind, the above potentially
cumbersome operation is also useless.

For these reasons, avoid such .list_voltage poll loop when regulator is
described as 'continuous_voltage_range' as is, indeed, similarly already
done inside regulator_is_supported_voltage().

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20191209125239.46054-1-cristian.marussi@arm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c3a03cfd381..2961ac08d1ae 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1198,6 +1198,10 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
 			return -EINVAL;
 		}
 
+		/* no need to loop voltages if range is continuous */
+		if (rdev->desc->continuous_voltage_range)
+			return 0;
+
 		/* initial: [cmin..cmax] valid, [min_uV..max_uV] not */
 		for (i = 0; i < count; i++) {
 			int	value;
-- 
2.20.1

