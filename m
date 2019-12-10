Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DABC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F41B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013352;
	bh=iF4QBEo7qnUq2F6us/aEuX1brSj7S0sEsb1PTU6Oa80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z7CpxPcD1BPqbDhwJb7M9exHcl2AP9Ep2Yam7GSYdqRg/ExcTvcneJovwlCByP1I/
	 kKWomspbjHolDCny3G1JHjR46PReStetMnVcSyRZf2rrfTFN6Odv8N73hRzZVsiqHS
	 k4LieBjmGndDrtOJ9i2nBolyFZj6To1Q39AwBjPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfLJV3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbfLJVKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85A3F246B4;
        Tue, 10 Dec 2019 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012215;
        bh=iF4QBEo7qnUq2F6us/aEuX1brSj7S0sEsb1PTU6Oa80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0ek4H3N0hYk8FfCLV4jr5WE6WiPQFk6D+hiP4brUqEmN6cl/BEm7LLOf9AyS4MNb
         AiK0M2jetJGaXdb3KbKSDYkBaCZ1LypGADf2AFRpLE7sHSwpms2DFJ9icsWm9M8blW
         22JH6hWZKRl10KdyOB1BHDDDa/ln18+BuBHi+DNM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 166/350] regulator: core: Release coupled_rdevs on regulator_init_coupling() error
Date:   Tue, 10 Dec 2019 16:04:31 -0500
Message-Id: <20191210210735.9077-127-sashal@kernel.org>
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

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 26c2c997aa1a6c5522f6619910ba025e53e69763 ]

This patch fixes memory leak which should happen if regulator's coupling
fails to initialize.

Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20191025002240.25288-1-digetx@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a46be221dbdcb..51ce280c1ce13 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5198,6 +5198,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	regulator_remove_coupling(rdev);
 	mutex_unlock(&regulator_list_mutex);
 wash:
+	kfree(rdev->coupling_desc.coupled_rdevs);
 	kfree(rdev->constraints);
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
-- 
2.20.1

