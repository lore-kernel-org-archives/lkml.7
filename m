Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA388C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B304921734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369471;
	bh=/W/BJ1FRw1RBiBKdLMEJ+AWZtR455YD30xWV+T+3sHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VsZbCiJuz/sfM9sEAVp+RM0xfhfPHG25lSVIyBjPvTrsIxRsMmH8l1OzeYvHP+hkD
	 YvdnhpCTXJgMw31l0b1bktBNO8rSY64Nn42s+VOVaJyoB2vl1FQiTmNOMWG3r6dZdk
	 cAgIj/87cIZ3iXqm/bE8KEnv9B5MPjvHr08Fwsh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbfDDJRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbfDDJRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B1421734;
        Thu,  4 Apr 2019 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369464;
        bh=/W/BJ1FRw1RBiBKdLMEJ+AWZtR455YD30xWV+T+3sHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEG2kE2mWzuN4zrUen4kONCKeqbnvt2IXtPDe9z5NUhWigh9n3IArzmwdzQ70WgDL
         7TlzL0y1Ika/PlgN366d29ec8Wvpliug5DfRSZfCYoHtY675VSXTAjYoNFanprjLq8
         vROUBfTRpzys7aJqidgBqogxHOBEePqMond4X4ac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Nguyen Viet Dung <dung.nguyen.aj@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 234/246] ARM: shmobile: Fix R-Car Gen2 regulator quirk
Date:   Thu,  4 Apr 2019 10:48:54 +0200
Message-Id: <20190404084627.476051398@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



