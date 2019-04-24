Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ADFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6E221903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116461;
	bh=L50Kr5Utnwybg3XlDiwpvuQhxCAdzQwhVAh+JvLVwQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RQ1JSLlWYeCLyAclc4oXFlmpEKIE/DLTOUxN0+8+5xF5ttbK2KU/bc6ls/ceXYU0C
	 SLl28f+X7rQDWaSWCNPkZRxMHeg9j6vnZer29tEeNa/nq99LWjf4aKC7btyhgDwKSn
	 h7+v3Xejj8Hr6pKf+RGuIex3uIDW6jElA8ZxazBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfDXOeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbfDXOeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2712089F;
        Wed, 24 Apr 2019 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116453;
        bh=L50Kr5Utnwybg3XlDiwpvuQhxCAdzQwhVAh+JvLVwQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDhT2H//Os8kiUbpASAiNc9RfIpai1USRbXYD7mrRyNTD78Kf8G/RdwW3oYYHYHBS
         AngOgxmev6+qbDQ3oxJ62qxVUGOiv3pyNlpiMLWlT1RAxMzhyVAJGy3qdJK+zKOVBV
         biDMsNOnc7/y/xZ8uCD1jIq1n5z32/y5SCsYAOWM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 13/66] reset: meson-audio-arb: Fix missing .owner setting of reset_controller_dev
Date:   Wed, 24 Apr 2019 10:32:47 -0400
Message-Id: <20190424143341.27665-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit 13e8a05b922457761ddef39cfff6231bd4ed9eef ]

Set .owner to prevent module unloading while being used.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Fixes: d903779b58be ("reset: meson: add meson audio arb driver")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/reset/reset-meson-audio-arb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index 91751617b37a..c53a2185a039 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -130,6 +130,7 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 	arb->rstc.nr_resets = ARRAY_SIZE(axg_audio_arb_reset_bits);
 	arb->rstc.ops = &meson_audio_arb_rstc_ops;
 	arb->rstc.of_node = dev->of_node;
+	arb->rstc.owner = THIS_MODULE;
 
 	/*
 	 * Enable general :
-- 
2.19.1

