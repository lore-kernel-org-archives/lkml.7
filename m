Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB819C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8914A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfLJNYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:24:33 -0500
Received: from foss.arm.com ([217.140.110.172]:44290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbfLJNY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:24:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18F2113E;
        Tue, 10 Dec 2019 05:24:28 -0800 (PST)
Received: from DESKTOP-VLO843J.cambridge.arm.com (DESKTOP-VLO843J.cambridge.arm.com [10.1.26.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E38343F52E;
        Tue, 10 Dec 2019 05:24:27 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de, smoch@web.de,
        linux.amoon@gmail.com, linux-rockchip@lists.infradead.org
Subject: [PATCH 2/4] mfd: rk808: Always register syscore ops
Date:   Tue, 10 Dec 2019 13:24:31 +0000
Message-Id: <b59f9861afd658008fbc4f58b75a995bfe00d6ae.1575932654.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575932654.git.robin.murphy@arm.com>
References: <cover.1575932654.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registering the syscore shutdown notifier even when it's a
no-op for the given RK8xx variant should be harmless, and
saves a lot of bother in handling unregistering on probe
failure or module removal, which has been woefully lacking.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/rk808.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index f2f2f98552a0..387105830736 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -623,7 +623,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
 		cells = rk817s;
 		nr_cells = ARRAY_SIZE(rk817s);
-		register_syscore_ops(&rk808_syscore_ops);
 		break;
 	default:
 		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
@@ -667,6 +666,7 @@ static int rk808_probe(struct i2c_client *client,
 	}
 
 	rk808_i2c_client = client;
+	register_syscore_ops(&rk808_syscore_ops);
 
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
 			      cells, nr_cells, NULL, 0,
@@ -684,6 +684,7 @@ static int rk808_probe(struct i2c_client *client,
 	return 0;
 
 err_irq:
+	unregister_syscore_ops(&rk808_syscore_ops);
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 	return ret;
 }
@@ -694,6 +695,8 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 
+	unregister_syscore_ops(&rk808_syscore_ops);
+
 	/**
 	 * pm_power_off may points to a function from another module.
 	 * Check if the pointer is set by us and only then overwrite it.
-- 
2.17.1

