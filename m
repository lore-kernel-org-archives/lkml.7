Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758EEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454AD2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554432233;
	bh=Q6KYgaJWUfltBlEH43MxZxIxSO1KhtI0EBZcoDQ3QE4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=clzgEuJdC/RatowFYuKg1vH1jd0qoW6zdEZj77TH9bWfg3YIZUXhJejUy9ltUA7/w
	 1qv+2Ec6hcMECdEXQ/I93UeeQky1JW1pElXFXYnMjwCtdeEeLFdB4gl/i7jWnC/TH1
	 asZ/jtCY85W7ZLwe/+43mELlImv+ciJ01KZpMEhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfDECnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:43:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46150 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfDECnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YWN5kl2aehB7aELXTYMvmKujXiQtY12lPlQ3d8lxx+k=; b=NNWa9fg5/6dR
        zjd/Jsfj4cmkXVcHsgmLoEe3l0c81FO050tYN7XTpUvIpMXlaJDSr+qqnBSMJNxbVMOyBEDb9ojps
        9OT8stEsQjJVtjfT4ZAUyhNuS4MOxWrWVh2gkriM4A+GLMFFtkNa18+G8IIT4vO4sZ6wJhEgUFyNb
        orbtI=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCEpV-0005Fg-MV; Fri, 05 Apr 2019 02:43:45 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7F755441D3B; Fri,  5 Apr 2019 09:43:42 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Avoid potential deadlock on regulator_unregister" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190405024342.7F755441D3B@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 09:43:42 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Avoid potential deadlock on regulator_unregister

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

From 063773011d33bb36588a90385aa9eb75d13c6d80 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 4 Apr 2019 16:32:18 +0100
Subject: [PATCH] regulator: core: Avoid potential deadlock on
 regulator_unregister

Lockdep reports the following issue on my setup:

Possible unsafe locking scenario:

CPU0                    CPU1
----                    ----
lock((work_completion)(&(&rdev->disable_work)->work));
                        lock(regulator_list_mutex);
                        lock((work_completion)(&(&rdev->disable_work)->work));
lock(regulator_list_mutex);

The problem is that regulator_unregister takes the
regulator_list_mutex and then calls flush_work on disable_work. But
regulator_disable_work calls regulator_lock_dependent which will
also take the regulator_list_mutex. Resulting in a deadlock if the
flush_work call actually needs to flush the work.

Fix this issue by moving the flush_work outside of the
regulator_list_mutex. The list mutex is not used to guard the point at
which the delayed work is queued, so its use adds no additional safety.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 968dcd9d7a07..8573dd0871fd 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5061,10 +5061,11 @@ void regulator_unregister(struct regulator_dev *rdev)
 		regulator_put(rdev->supply);
 	}
 
+	flush_work(&rdev->disable_work.work);
+
 	mutex_lock(&regulator_list_mutex);
 
 	debugfs_remove_recursive(rdev->debugfs);
-	flush_work(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
 	regulator_remove_coupling(rdev);
 	unset_regulator_supplies(rdev);
-- 
2.20.1

