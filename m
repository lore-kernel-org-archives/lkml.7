Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA43C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC6E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889297;
	bh=7sre6MIPLWwd1jobG44tQtVEBwrUoAgbLSZMDPj/dY8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qEajlUfX98B+6CM9DZAVju7AFpRCDQHJOQ3y1WdpDVgQwjAndrEhcsUwU315l96gP
	 vU7bLvO7qpCyjNpqsCmUHsoB2YYNDtSm81Sdbh/cldBPp0lgcDyUbLttp8LFGuZfHP
	 kEBLsYydLei/LuZjZdEOrZjeyzo5ta5xCza57fY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfHORO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:14:56 -0400
Received: from mail-ed1-f100.google.com ([209.85.208.100]:40228 "EHLO
        mail-ed1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbfHOROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:37 -0400
Received: by mail-ed1-f100.google.com with SMTP id h8so2704199edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=2tOdgRw7bHfBUMRr5A78wZooift8kR44FLxZ2fHFoq4=;
        b=f+CEoFEFFQLZf2i3OABqsLhhctYgsQFlMIgu30gsZqbDs8VpIFhtUdPpDM5Z52bm0M
         DcDatQRPqvVdi0XNjlYnCpQsOXi403zAvtV2BTHKBF0uk8aKlWFtrnY4rAYVzYo3YARn
         YyjvRjcxJMnt7bFXicSJAd8oVRssefKZo5nDjw2i/+2SB+XCZAxBoAgJNZh8OcyoBQEV
         oOMCFi9wcCxiWP+zlAf6M1jmSqOAAF2ZP912rTgqCr6ACzLQKCFirZkvVCKYn+wo9b+8
         fTcfDwCMW3HXu1GmuvzOgV5Xxck48Ggi7UqqKRge1h1dbvUTSEUDCQTEIJLFPgVLPnyz
         ghTQ==
X-Gm-Message-State: APjAAAVArbf+h5du73stKTox6sy8NB8oiwAF/Vf6EsSioBITZqfNAQbV
        cZ5O4LYwv3+/2EoGY3fbrw94JiaB+7IWo+meB5MoUYgAkfpy4hXPZx8eFxglFXv2hQ==
X-Google-Smtp-Source: APXvYqxFD14tT+W/wcwosNR4mJq7LHL6hBkxp8vUHcz2et2BdUwg/HEyBFE8UDSLNuhEWf01rrv+4zglTLjl
X-Received: by 2002:aa7:dc5a:: with SMTP id g26mr6664165edu.62.1565889275802;
        Thu, 15 Aug 2019 10:14:35 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id u22sm54883edi.2.2019.08.15.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:35 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKd-00052v-CB; Thu, 15 Aug 2019 17:14:35 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id DD14E2742BD6; Thu, 15 Aug 2019 18:14:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max8660: remove redundant assignment of variable ret" to the regulator tree
In-Reply-To: <20190813133114.14931-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171434.DD14E2742BD6@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8660: remove redundant assignment of variable ret

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 9e127fab67e3ec4451696da0c7872fd291b9372b Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 13 Aug 2019 14:31:14 +0100
Subject: [PATCH] regulator: max8660: remove redundant assignment of variable
 ret

Variable ret is initialized to a value that is never read before
a return statement and hence can be removed. Remove it.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190813133114.14931-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8660.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/max8660.c b/drivers/regulator/max8660.c
index 4bca54446287..347043a5a9a7 100644
--- a/drivers/regulator/max8660.c
+++ b/drivers/regulator/max8660.c
@@ -485,7 +485,6 @@ static int max8660_probe(struct i2c_client *client,
 		rdev = devm_regulator_register(&client->dev,
 						  &max8660_reg[id], &config);
 		if (IS_ERR(rdev)) {
-			ret = PTR_ERR(rdev);
 			dev_err(&client->dev, "failed to register %s\n",
 				max8660_reg[id].name);
 			return PTR_ERR(rdev);
-- 
2.20.1

