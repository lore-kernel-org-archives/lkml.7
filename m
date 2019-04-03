Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD197C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8544120882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554266522;
	bh=HgbqjqGeFQ/gNPi/Zda3m6PlMNR5IaA+D73gNCZNaFA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Tbf5mstcwph6k5cYN2HVspZeifyG91Q9VaCEGeewZoTa7C1WXwSEqmCCvKgWN1995
	 qmIYAjXY4/W60VoU7NRq5SvaO3yKplSh3ODk94kwqSs/q9HxcfF4QDF6DTBV19pr+m
	 myHusBoXl1rQGbElttb6GUkbKbBQ/nVeU8jHnPuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfDCEmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:42:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39716 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCEl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=48lfx6JNrwWs2NWzduRfqdDtkiIqAvOHTd1MVl/LbAY=; b=mADK6azMrBqF
        UeXrtbObx8lrQmU8DaWaKs1o7Qdt/ekeM3X0+VLOk1fCEhQ6p+Vl8xnVctA3+d42XST/I722eTzFw
        p3fXWKD1vQIvLonZty8JcKeMcGACG38Zk9ZwAEWdRd8eoNDDOkMBHYo5FQ6HHZSwqm0ywgENI+Sr5
        h/dqk=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBXig-0003zg-1U; Wed, 03 Apr 2019 04:41:50 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BD773440082; Wed,  3 Apr 2019 05:41:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Han Nandor <nandor.han@vaisala.com>
Cc:     Nandor Han <nandor.han@vaisala.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: verify if register is writeable before writing operations" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190403044146.BD773440082@finisterre.ee.mobilebroadband>
Date:   Wed,  3 Apr 2019 05:41:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: verify if register is writeable before writing operations

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From 8b9f9d4dc511309918c4f6793bae7387c0c638af Mon Sep 17 00:00:00 2001
From: Han Nandor <nandor.han@vaisala.com>
Date: Tue, 2 Apr 2019 08:01:22 +0000
Subject: [PATCH] regmap: verify if register is writeable before writing
 operations

regmap provides a couple of ways to validate the register range used.
a) maxim allowed register, b) writable/readable register tables,
c) callback function that can be provided by the driver to validate
a register. regmap framework should verify if registers
are writeable before every write operation. However this doesn't
seems to happen in every situation.

The method `_regmap_raw_write_impl` is only using the `writeable_reg`
callback to verify if register is writeable, ignoring the other two.
This can lead to undefined behaviour since this allows to write to
registers that could be declared un-writeable by using any other
option.

Change `_regmap_raw_write_impl` to use the `regmap_writeable` method
to verify if registers are writable before the write operation.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4f822e087def..42d8404bc8cc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1493,11 +1493,10 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	WARN_ON(!map->bus);
 
 	/* Check for unwritable registers before we start */
-	if (map->writeable_reg)
-		for (i = 0; i < val_len / map->format.val_bytes; i++)
-			if (!map->writeable_reg(map->dev,
-					       reg + regmap_get_offset(map, i)))
-				return -EINVAL;
+	for (i = 0; i < val_len / map->format.val_bytes; i++)
+		if (!regmap_writeable(map,
+				     reg + regmap_get_offset(map, i)))
+			return -EINVAL;
 
 	if (!map->cache_bypass && map->format.parse_val) {
 		unsigned int ival;
-- 
2.20.1

