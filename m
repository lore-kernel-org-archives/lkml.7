Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3323FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A4E21872
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127329;
	bh=DQdXSQ4X7DbgcH47Q4hpV8D3kwoEFSWaAT50oKzYm0g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AlaNrrYNgrW/DMnGGLZOr7MUt10rSBRhBJ6mvG38W79pkCEHIqkz7vbq3rgdgz+Ik
	 c3xTOUDDKMVF8TuJiCue6T1kIfPtEXbxebVrygcSIl+uzpefKzDvUiNdlHZxjjhsBi
	 ysGeh/xQ5E1LInz/uSgmHAHtm8Ilt7r/Vu2wTxZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfHFVf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfHFVfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:35:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E002089E;
        Tue,  6 Aug 2019 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127324;
        bh=DQdXSQ4X7DbgcH47Q4hpV8D3kwoEFSWaAT50oKzYm0g=;
        h=From:To:Cc:Subject:Date:From;
        b=ROeYcGBEApysa4cK44kwK/wrda/Hg2GjSHI7CYrMChFerlmbYcHWEtfs6Lztq4t0o
         9iEcfe6n0Cx7+/iQZCkEBLQZl5vrMtrjMmYP4c19mtpyU02jqkKMOT04SKyHFQrSlJ
         0658CgBXsB/nFOwfySs9CeEZ3JbTB49F5Jm6zvYA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/32] clk: at91: generated: Truncate divisor to GENERATED_MAX_DIV + 1
Date:   Tue,  6 Aug 2019 17:34:49 -0400
Message-Id: <20190806213522.19859-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

[ Upstream commit 1573eebeaa8055777eb753f9b4d1cbe653380c38 ]

In clk_generated_determine_rate(), if the divisor is greater than
GENERATED_MAX_DIV + 1, then the wrong best_rate will be returned.
If clk_generated_set_rate() will be called later with this wrong
rate, it will return -EINVAL, so the generated clock won't change
its value. Do no let the divisor be greater than GENERATED_MAX_DIV + 1.

Fixes: 8c7aa6328947 ("clk: at91: clk-generated: remove useless divisor loop")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/at91/clk-generated.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 33481368740e7..113152425a95d 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -153,6 +153,8 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 			continue;
 
 		div = DIV_ROUND_CLOSEST(parent_rate, req->rate);
+		if (div > GENERATED_MAX_DIV + 1)
+			div = GENERATED_MAX_DIV + 1;
 
 		clk_generated_best_diff(req, parent, parent_rate, div,
 					&best_diff, &best_rate);
-- 
2.20.1

