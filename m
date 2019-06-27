Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1A5C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0329120665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596623;
	bh=rmZIhleNuh6lMVcv/6wYDZ+Aea04s6m61y6E95rWa/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ULDQyTVJAENowxOM6EKOvJ82a4NtSQob9xwyZTVxRnUPV4QANsvvA5DCSp7l2CvpV
	 i38YUVNVHvAAZz6dYZmcI4GdCVcZ19RKGmdz9KJf5XMFZY7BhkiBs7xMT8NT2nT0Pt
	 3Bt9ynmugmGMCc1tgwTfC9aMQ5S/5FxOytNe+w1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfF0Agc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfF0AgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:36:24 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9599217F4;
        Thu, 27 Jun 2019 00:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595784;
        bh=rmZIhleNuh6lMVcv/6wYDZ+Aea04s6m61y6E95rWa/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnWtKyz2qqLkunsn/XNOYBu7Am4sIu7gLHkpiKeUL3TCe4xwza1N1McqmlwoQWeVS
         os1geH2nVgLlu4fhZoSsJAo0PqJyVKNRhFutZWsJejBt8k5F7XCGSRxL8x3EWtmMiO
         xyS7APJgJINUKXsr3p5bZBZJaESo+4PlNAKX3puo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 02/60] soc: bcm: brcmstb: biuctrl: Register writes require a barrier
Date:   Wed, 26 Jun 2019 20:35:17 -0400
Message-Id: <20190627003616.20767-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003616.20767-1-sashal@kernel.org>
References: <20190627003616.20767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 6b23af0783a54efb348f0bd781b7850636023dbb ]

The BIUCTRL register writes require that a data barrier be inserted
after comitting the write to the register for the block to latch in the
recently written values. Reads have no such requirement and are not
changed.

Fixes: 34642650e5bc ("soc: Move brcmstb to bcm/brcmstb")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index c16273b31b94..20b63bee5b09 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -56,7 +56,7 @@ static inline void cbc_writel(u32 val, int reg)
 	if (offset == -1)
 		return;
 
-	writel_relaxed(val,  cpubiuctrl_base + offset);
+	writel(val, cpubiuctrl_base + offset);
 }
 
 enum cpubiuctrl_regs {
-- 
2.20.1

