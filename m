Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D2DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E892246B5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012232;
	bh=+mYYtCrQuz5xL26HF/OI5A2kAJzDXj0Jmz2H3hixYGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VpF1Z6yz22X8nAB7mvSSisr5y5/s3lK+GhjGmaU5IzTPwN5C4TI2Es3Brrq/NaJu1
	 4+rA7Yi0rCGIeZfrgu6AiMf7iuwZ4mI973N4GiSWIzC6v8qltW0ZNCv+TQo9L1unf2
	 gCf3HFcuNfPLLrG0crBRL7TxoJd9cuLabYNZDHkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfLJVKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfLJVK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE47246AF;
        Tue, 10 Dec 2019 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012227;
        bh=+mYYtCrQuz5xL26HF/OI5A2kAJzDXj0Jmz2H3hixYGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyj1w8NPakhctp/OiVS3ixNt6e8soscNjSt1mdkfZzxJkP3V1sJEq8cGtPvp4FNgd
         XGPb40Mv0kVcwyr3I4kqhwGDr0eBAC3scvUo6N4ZGJwszC02JWhP/xLKY4TQ3LFBkl
         Ts/KsHg9axAA5+Jcdtr3uSYbV2VKAgtxUM5H2n18=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 177/350] regulator: fixed: add off-on-delay
Date:   Tue, 10 Dec 2019 16:04:42 -0500
Message-Id: <20191210210735.9077-138-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit f7907e57aea2adcd0b57ebcca410e125412ab680 ]

Depends on board design, the gpio controlling regulator may
connects with a big capacitance. When need off, it takes some time
to let the regulator to be truly off. If not add enough delay, the
regulator might have always been on, so introduce off-on-delay to
handle such case.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/1572311875-22880-3-git-send-email-peng.fan@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/fixed.c       | 2 ++
 include/linux/regulator/fixed.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index f81533070058e..bc0bbd99e98d0 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -123,6 +123,7 @@ of_get_fixed_voltage_config(struct device *dev,
 		config->enabled_at_boot = true;
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
+	of_property_read_u32(np, "off-on-delay-us", &config->off_on_delay);
 
 	if (of_find_property(np, "vin-supply", NULL))
 		config->input_supply = "vin";
@@ -189,6 +190,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	}
 
 	drvdata->desc.enable_time = config->startup_delay;
+	drvdata->desc.off_on_delay = config->off_on_delay;
 
 	if (config->input_supply) {
 		drvdata->desc.supply_name = devm_kstrdup(&pdev->dev,
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index d44ce5f18a568..55319943fcc58 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -36,6 +36,7 @@ struct fixed_voltage_config {
 	const char *input_supply;
 	int microvolts;
 	unsigned startup_delay;
+	unsigned int off_on_delay;
 	unsigned enabled_at_boot:1;
 	struct regulator_init_data *init_data;
 };
-- 
2.20.1

