Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CBFC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263052084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889327;
	bh=rLPOByBFsVcARV4dnYz+E3sV/XZFYkXVZtdFF/GHTdc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=eH++SfJ1Q18hJbCaBjHiPalnZu815m/3KPUgm1Wj5AviJ+zhq8y9oYf65T59fcspN
	 h3S+qhMJJdGSgbHZPSDyaR0ID18lDoPl/Ka9JhZpbVya4cEHZh2zZZws37n9GvLZXl
	 PXkojyeUnLiUMaZpIhZx5jxMTTf59UX6cxM04kVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfHORP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:26 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:53894 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbfHORO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:29 -0400
Received: by mail-wm1-f97.google.com with SMTP id 10so1879637wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=ktHQVRXcVTWduz8swL4HEDKPCJFrS626b0N3hJB5CIw=;
        b=nQknsppoLsz0AvKb44kEoo4TwwRBdlCPzB85DRpbSshc1dqNR9oGIBSRauwDzntZ3J
         saxeM0eIRwuTupCmcfCqiorxtVWRfgCwFvJi/isnzjK/b8rrLgfNI5fp7zkGmFNjCmDf
         Z6Q1nBT75ziLusWzM2HpgvE364FnKxPrBAZpFNzxYywufT6BIb6hQz/zV/qJ/3dUUI1D
         mS9rPFVpHd9ndrO9BiMQIAbjjjs/1xXnnHRfB3H+KKTqcs8ND7ErcqK3CDoibWWBjBoe
         lrcuJ6p8UndTlYfLHGHzDgyZaCESbi217MisDhOih3ECPdqcsYKocI5FVi/nDoLmApyb
         9+xg==
X-Gm-Message-State: APjAAAWbcL15XW/gwZG9kh32PcIdu99W5+PNXd8F8wKI7M8MqqkDM7sR
        U5JN45rejSbsuSN1XdHa7IEgfF37Bc5JUaY8hudyhpkMQ7XIRbynoMTy+5XO7sGQww==
X-Google-Smtp-Source: APXvYqz593JC7GQMYbu1GxOUwKcrOXtQYzMmeCdp/fhU+K9XVH/UT4jeR5d4UU5AvxOfFy4M6CfYxZQpDBTP
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr3641291wme.172.1565889267387;
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id h1sm10489wmb.39.2019.08.15.10.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:27 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKU-00052E-V1; Thu, 15 Aug 2019 17:14:27 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 567272742BD6; Thu, 15 Aug 2019 18:14:26 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: soc-core: Fix -Wunused-const-variable warning" to the asoc tree
In-Reply-To: <20190813142501.13080-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171426.567272742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:26 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-core: Fix -Wunused-const-variable warning

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From 0faf1237c60a3791d7ff32035d3097d3e022e68f Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 13 Aug 2019 22:25:01 +0800
Subject: [PATCH] ASoC: soc-core: Fix -Wunused-const-variable warning

If CONFIG_DMI is not set, gcc warns:

sound/soc/soc-core.c:81:27: warning:
 dmi_blacklist defined but not used [-Wunused-const-variable=]

Add #ifdef guard around it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190813142501.13080-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e9f44505cc3e..abe2f47cee6e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -73,6 +73,7 @@ static int pmdown_time = 5000;
 module_param(pmdown_time, int, 0);
 MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
 
+#ifdef CONFIG_DMI
 /*
  * If a DMI filed contain strings in this blacklist (e.g.
  * "Type2 - Board Manufacturer" or "Type1 - TBD by OEM"), it will be taken
@@ -87,6 +88,7 @@ static const char * const dmi_blacklist[] = {
 	"Board Product Name",
 	NULL,	/* terminator */
 };
+#endif
 
 static ssize_t pmdown_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
-- 
2.20.1

