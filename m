Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA54320708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452540;
	bh=RMU+j1b3rdYpll2TEz7BS3KRzXTt9ztKT5vT+A53UPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=C3G478GQ+QmOop+Qqjnhv1gDWKtM1LvEp0ALMnG2DxPlPuNFJh6HM0UXEfSf7s3c/
	 SkZV0Thep1/46zzkITctX/7Fb5aAY+xaOB5RKkUfwHSRmiyUMC7lWUCha4mwwci+yO
	 eKNZzsCC10mD8vji1iwtaiK/MPe44IpaTvhoT0H0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfKVTzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:55:38 -0500
Received: from foss.arm.com ([217.140.110.172]:52158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVTzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:55:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 287EB113E;
        Fri, 22 Nov 2019 11:55:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B87E3F6C4;
        Fri, 22 Nov 2019 11:55:35 -0800 (PST)
Date:   Fri, 22 Nov 2019 19:55:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Christian Hemp <c.hemp@phytec.de>,
        Christoph Fritz <chf.fritz@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9062: Return REGULATOR_MODE_INVALID for invalid mode" to the regulator tree
In-Reply-To: <20191122045154.802-1-axel.lin@ingics.com>
Message-Id: <applied-20191122045154.802-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9062: Return REGULATOR_MODE_INVALID for invalid mode

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

From c15d5a645875bc9b89f68f5d3fb608f691ac78d7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 22 Nov 2019 12:51:54 +0800
Subject: [PATCH] regulator: da9062: Return REGULATOR_MODE_INVALID for invalid
 mode

-EINVAL is not a valid return value for .of_map_mode, return
REGULATOR_MODE_INVALID instead.

Fixes: 844e7492ee3d ("regulator: da9062: add of_map_mode support for bucks")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20191122045154.802-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9062-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 29f4a60398a3..d3ce0278bfbe 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -108,7 +108,7 @@ static unsigned int da9062_map_buck_mode(unsigned int mode)
 	case DA9063_BUCK_MODE_AUTO:
 		return REGULATOR_MODE_NORMAL;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
-- 
2.20.1

