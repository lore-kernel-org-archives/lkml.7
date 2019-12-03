Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44912C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131EF20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413475;
	bh=2ruCfQM2uGTJfrjE1Ri3MmU/nY3aN8p9UYu2mdRhDEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tt0kS/8c5wUxXK3FesnF7TMq73zp73JJOraG9xHkcCAHIj9iDDJTXsCVQ8nLPdk6K
	 eCEKJQQ3isOBBQ14jg23bwBawNW4i3K283Mc2NXi0Wi2WdbWNK98r2jUFUq6D7Vjoy
	 qIVi0fPNhXmGocFngZ0uMe/yQlJaH8gkNCEVyTAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfLCWvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:51:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729850AbfLCWvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:51:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A43A21772;
        Tue,  3 Dec 2019 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413470;
        bh=2ruCfQM2uGTJfrjE1Ri3MmU/nY3aN8p9UYu2mdRhDEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Xwy9jKtPQjTwFzsUTvuRhJ5dzCgswdFM8sIq2M9FdC7V5pqB6nbYN5Rn7fIX3l1M
         cpjWJYgXAj6ItBcV/tc/VEE/YCUd6mYeHk3idOIO4CczHMhPg6oNpgbRHJTTmdw65X
         wDeNMQfubBmQvAyCFnioX4L7CA4Zto0qHPPE+zrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 141/321] pinctrl: sh-pfc: sh7264: Fix PFCR3 and PFCR0 register configuration
Date:   Tue,  3 Dec 2019 23:33:27 +0100
Message-Id: <20191203223434.495466225@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



