Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273AC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982A82084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889293;
	bh=viaJ4G/ZvkJmlb44mDSdbu/KszjK5ZzIV+ual+2QNok=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oBu3lNe6YN2wHbZq3pSP+2bWQvzfCJwc+lgDnvkYmZHrEFACMiCaMYgpwW2Qt8RVW
	 xbnFfUvpBe/JEX8409Yuq2dmX+2iDMrVnriItbkc51FNS5MPzIha09fSe5AslKQvDY
	 czt9aYRNxvPrjSOS1Mb6Ty7QZfAj5EOOee5rKXq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfHOROt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:49 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:40326 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbfHOROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:37 -0400
Received: by mail-wm1-f97.google.com with SMTP id v19so1862665wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=JHUIetjIti0pEcfSYiQiE8e28/5D5NNhoAZkL5HFjGI=;
        b=XkzUUTe8MO4xCy1UFFZtR65UJ2iAYCiJ5Im5raueQfVe6+Hc4366Que/25BNvnHxS1
         qrewNoKITKkmW3rSBkCC5foDWR1Hueqhr1x5OLkez7USMnoPhVZdoA0aYHVuT6lYsKAO
         7ZTu8UK7YbM/Fl9i1DB1fp0bNq7TRPVLECgOhcVfZgoxF2Nr+uDCcIEMEE2PkxOkHtf6
         eIWIcPSkAym5iMWjId7QPjx3oOiUZfAvFdMxx7tRJ9mmW3AomI6iZXHEZz8EYfd4bDtJ
         fpzYcWgQmtNS5TZR3VlFoLXCQxwXuJnoECkhvlpmDoVwxH+sKBn19mkNv9S79gVvp7fr
         2Bsw==
X-Gm-Message-State: APjAAAW0fE7nm0KoCbbD4r8Ts5yyLHbEp+c6VAGxKay9q4QPyNI8Q4k1
        xZheaL50clyjwBm6u1+Q/kVXJU+xFRH+/9e2Aj1o13k/c3MMe51ZBi720NbhF+E+dw==
X-Google-Smtp-Source: APXvYqwtsvivErczjYZ8MtHJ8gEom0mS3aCoimQxOdueqzNzCjMGqpxdf4fd3hkQCu+k7Xk4Tx9krBGNnokU
X-Received: by 2002:a05:600c:2487:: with SMTP id 7mr3807673wms.141.1565889276148;
        Thu, 15 Aug 2019 10:14:36 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id c3sm12896wmd.26.2019.08.15.10.14.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:36 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKd-000535-UI; Thu, 15 Aug 2019 17:14:35 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 73AE32742B9E; Thu, 15 Aug 2019 18:14:35 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: act8945a-regulator: fix ldo register addresses in set_mode hook" to the regulator tree
In-Reply-To: <1565635194-5816-1-git-send-email-raagjadav@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171435.73AE32742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:35 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8945a-regulator: fix ldo register addresses in set_mode hook

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From 5d2fc542e8c92130b55ddeb81876ec398adf4d13 Mon Sep 17 00:00:00 2001
From: Raag Jadav <raagjadav@gmail.com>
Date: Tue, 13 Aug 2019 00:09:54 +0530
Subject: [PATCH] regulator: act8945a-regulator: fix ldo register addresses in
 set_mode hook

According to ACT8945A datasheet[1], operating modes for ldos are
controlled by BIT(5) of their respective _CTRL registers.

[1] https://active-semi.com/wp-content/uploads/ACT8945A_Datasheet.pdf

Fixes: 7482d6ecc68e ("regulator: act8945a-regulator: Implement PM functionalities")
Signed-off-by: Raag Jadav <raagjadav@gmail.com>
Link: https://lore.kernel.org/r/1565635194-5816-1-git-send-email-raagjadav@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8945a-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 584284938ac9..d2f804dbc785 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -169,16 +169,16 @@ static int act8945a_set_mode(struct regulator_dev *rdev, unsigned int mode)
 		reg = ACT8945A_DCDC3_CTRL;
 		break;
 	case ACT8945A_ID_LDO1:
-		reg = ACT8945A_LDO1_SUS;
+		reg = ACT8945A_LDO1_CTRL;
 		break;
 	case ACT8945A_ID_LDO2:
-		reg = ACT8945A_LDO2_SUS;
+		reg = ACT8945A_LDO2_CTRL;
 		break;
 	case ACT8945A_ID_LDO3:
-		reg = ACT8945A_LDO3_SUS;
+		reg = ACT8945A_LDO3_CTRL;
 		break;
 	case ACT8945A_ID_LDO4:
-		reg = ACT8945A_LDO4_SUS;
+		reg = ACT8945A_LDO4_CTRL;
 		break;
 	default:
 		return -EINVAL;
-- 
2.20.1

