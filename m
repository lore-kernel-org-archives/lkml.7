Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD99BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69E32071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403219;
	bh=2ruCfQM2uGTJfrjE1Ri3MmU/nY3aN8p9UYu2mdRhDEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PTE8R1bXNnI1oimSybKhUNUZ7THOROpVN+Ix7ynQv2dewOe/30gYaT6zNi2nKN5N2
	 l3DHh4Kp6/x6f5QUHybTJ3jshQR05PttUJCsWA4P+Z0sT2GFa8SkWhVjZnGyMZ8Plm
	 bQ9EnpzCMjpG6f9lyOFPSyTa8bYHEdsiPaSV7fHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfKVGNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbfKVGN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4965120717;
        Fri, 22 Nov 2019 06:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403209;
        bh=2ruCfQM2uGTJfrjE1Ri3MmU/nY3aN8p9UYu2mdRhDEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTeCl7qqXYlufENNnS2Lnc9aobQr252ZcKWaQzMn+EZFKjijGqkr7UuZ12kMhLBry
         1vwLbVKC1cmlpNzsIFEFt8W4SfAwqAvPRNfRBF/Y6OC4/gCGt784glBpREy5wchJyo
         Ok3mcCNOZchm7Un6oDlTCLm9Z8yrBdSMiNYo1wbk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 24/68] pinctrl: sh-pfc: sh7264: Fix PFCR3 and PFCR0 register configuration
Date:   Fri, 22 Nov 2019 01:12:17 -0500
Message-Id: <20191122061301.4947-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1b99d0c80bbe1810572c2cb77b90f67886adfa8d ]

The Port F Control Register 3 (PFCR3) contains only a single field.
However, counting from left to right, it is the fourth field, not the
first field.
Insert the missing dummy configuration values (3 fields of 16 values) to
fix this.

The descriptor for the Port F Control Register 0 (PFCR0) lacks the
description for the 4th field (PF0 Mode, PF0MD[2:0]).
Add the missing configuration values to fix this.

Fixes: a8d42fc4217b1ea1 ("sh-pfc: Add sh7264 pinmux support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh7264.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index 8070765311dbf..e1c34e19222ee 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -1716,6 +1716,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	},
 
 	{ PINMUX_CFG_REG("PFCR3", 0xfffe38a8, 16, 4) {
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		PF12MD_000, PF12MD_001, 0, PF12MD_011,
 		PF12MD_100, PF12MD_101, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0 }
@@ -1759,8 +1762,10 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		PF1MD_000, PF1MD_001, PF1MD_010, PF1MD_011,
 		PF1MD_100, PF1MD_101, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0
-	 }
+		0, 0, 0, 0, 0, 0, 0, 0,
+		PF0MD_000, PF0MD_001, PF0MD_010, PF0MD_011,
+		PF0MD_100, PF0MD_101, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0 }
 	},
 
 	{ PINMUX_CFG_REG("PFIOR0", 0xfffe38b2, 16, 1) {
-- 
2.20.1

