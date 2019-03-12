Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B7EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814AA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413864;
	bh=dvRzzKO88JiWpFL+0/zB3U05RtwiGidnzEc20VAic/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wmvdMVuO+5qJRlfhURg67pbrrOVN6xwfl4uYngFjf7slvDDChiEqDIFfDJ4c4qwMb
	 ONKXwys94YAZ7+RrqurA6+mOhTFJF/G0BwNZb5cL+uVpEQ0rfihgmSEAMWAdlzch5p
	 HdqkGOrevQ31ucMBd0E0nF9ZwffVE8iEzeUMTOSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfCLSEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbfCLRMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:49 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9232087C;
        Tue, 12 Mar 2019 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410768;
        bh=dvRzzKO88JiWpFL+0/zB3U05RtwiGidnzEc20VAic/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcRNaDJv+hRcDnZvJ0S7+tdCexJ6kYxH1wQ0ufaTkz08OOS4UR5uK568KORd8jQ8l
         gfS65BJESruKMFP1e6ZxbgHyQxYMPcLy1xnCxFLQf61DghdV9GD5Wxwojw4uONreH/
         0u1ydS1AMHTDQ+a20NAfVgOTP4c8FDMw8wNe/WIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Kridner <jdk@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 083/171] pinctrl: mcp23s08: spi: Fix regmap allocation for mcp23s18
Date:   Tue, 12 Mar 2019 10:07:43 -0700
Message-Id: <20190312170355.183241379@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f165988b77ef849eb0c1aebd94fe778024f88314 ]

Fixes issue created by 9b3e4207661e67f04c72af15e29f74cd944f5964.

It wasn't possible for one_regmap_config to be non-NULL at the point
it was tested for mcp23s18 devices.

Applied the same pattern of allocating one_regmap_config using
devm_kmemdump() and then initializing the local regmap structure
from that.

Signed-off-by: Jason Kridner <jdk@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index b03481ef99a1..98905d4a79ca 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -832,8 +832,13 @@ static int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 		break;
 
 	case MCP_TYPE_S18:
+		one_regmap_config =
+			devm_kmemdup(dev, &mcp23x17_regmap,
+				sizeof(struct regmap_config), GFP_KERNEL);
+		if (!one_regmap_config)
+			return -ENOMEM;
 		mcp->regmap = devm_regmap_init(dev, &mcp23sxx_spi_regmap, mcp,
-					       &mcp23x17_regmap);
+					       one_regmap_config);
 		mcp->reg_shift = 1;
 		mcp->chip.ngpio = 16;
 		mcp->chip.label = "mcp23s18";
-- 
2.19.1



