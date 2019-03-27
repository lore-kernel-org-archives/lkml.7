Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8274C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEFB206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714006;
	bh=Qo/XY82dJ38ib4a5ddTgj7iA5hrEwWBGqg9lQEzDH5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QCJ527hEKlfEurykSHLO2otHypcc/iWFXIYo3yy0FfOMt8iFoHLs+r+ObcQaNpXee
	 Eb/epz8uTGKsmTwDb7/4UEKm+fFQ2Yrh1I2mzHNqMdHrWHHlWXo5HUpeCqpLj//iKN
	 Vk4ZU+3uCCM7jY8/kj4eomXyBfPteumSDw93nWrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbfC0SKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388726AbfC0SKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C317F217F9;
        Wed, 27 Mar 2019 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710205;
        bh=Qo/XY82dJ38ib4a5ddTgj7iA5hrEwWBGqg9lQEzDH5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6BAGjw0zjtrN9/7YMay7SVtlaBWO7rqsIa0halpdcNL6gGaIY9yVXxGOuprX/Hou
         c0M9NrV0SnQJ0HOVvXIl/qCszQaXBR324HgVpSiQnQRDoWh+ldPaSYVEh3lxeplOm4
         +HsSdWgjZ33EoknfW+dk82UgH0qOuutwdkIqw4r4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 250/262] ARM: shmobile: Fix R-Car Gen2 regulator quirk
Date:   Wed, 27 Mar 2019 14:01:45 -0400
Message-Id: <20190327180158.10245-250-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marek.vasut@gmail.com>

[ Upstream commit 5347a0203709d5039a74d7c94e23519eee478094 ]

The quirk code currently detects all compatible I2C chips with a shared
IRQ line on all I2C busses, adds them into a list, and registers a bus
notifier. For every chip for which the bus notifier triggers, the quirk
code performs I2C transfer on that I2C bus for all addresses in the list.
The problem is that this may generate transfers to non-existing chips on
systems with multiple I2C busses.

This patch adds a check to verify that the I2C bus to which the chip with
shared IRQ is attached to matches the I2C bus of the chip which triggered
the bus notifier and only starts the I2C transfer if they match.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 8e50daa99151..dc526ef2e9b3 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -40,6 +40,7 @@
 struct regulator_quirk {
 	struct list_head		list;
 	const struct of_device_id	*id;
+	struct device_node		*np;
 	struct of_phandle_args		irq_args;
 	struct i2c_msg			i2c_msg;
 	bool				shared;	/* IRQ line is shared */
@@ -101,6 +102,9 @@ static int regulator_quirk_notify(struct notifier_block *nb,
 		if (!pos->shared)
 			continue;
 
+		if (pos->np->parent != client->dev.parent->of_node)
+			continue;
+
 		dev_info(&client->dev, "clearing %s@0x%02x interrupts\n",
 			 pos->id->compatible, pos->i2c_msg.addr);
 
@@ -165,6 +169,7 @@ static int __init rcar_gen2_regulator_quirk(void)
 		memcpy(&quirk->i2c_msg, id->data, sizeof(quirk->i2c_msg));
 
 		quirk->id = id;
+		quirk->np = np;
 		quirk->i2c_msg.addr = addr;
 
 		ret = of_irq_parse_one(np, 0, argsa);
-- 
2.19.1

