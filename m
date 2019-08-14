Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4085EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E01321743
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749440;
	bh=WI/EfAnOncHGpyQuhasDcz8tRW1vgeiQ6AEAx0QGQr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sql4VSXBi8SmYK1gHf6FVSY5BTRh3zsE+MXAn0wW1b+Jxge8jxUKYSNFHYUDW2ymF
	 ZDazLzyTEayq2ltM/jUc9TUJVH8thjwscsgh07sC2ORJqVQGT/dbZiRH6bRYRBhJZy
	 kfT8AiqrcTMfILXzCGbj4CEIC2zWi9msWTV+Vg7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfHNCX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbfHNCXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:23:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5D120842;
        Wed, 14 Aug 2019 02:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749434;
        bh=WI/EfAnOncHGpyQuhasDcz8tRW1vgeiQ6AEAx0QGQr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/xwhon1q84gPYY8ejDwlboraN0LbGbWZmjiYjZrLaTAED89hAEaUVPly/GSxc6zL
         NmZOnLZpk/fnRKQVZ1nBHLhLXtDQiv+zM9lbCUnMnj807MZjmaRyKjRPZ0FS12NpYR
         KLJkmxzZYx7YlR0uFt1jJ7F/zfBCiJ06z9YGppEk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Xiayang <xywang.sjtu@sjtu.edu.cn>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 17/33] can: sja1000: force the string buffer NULL-terminated
Date:   Tue, 13 Aug 2019 22:23:07 -0400
Message-Id: <20190814022323.17111-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022323.17111-1-sashal@kernel.org>
References: <20190814022323.17111-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>

[ Upstream commit cd28aa2e056cd1ea79fc5f24eed0ce868c6cab5c ]

strncpy() does not ensure NULL-termination when the input string size
equals to the destination buffer size IFNAMSIZ. The output string
'name' is passed to dev_info which relies on NULL-termination.

Use strlcpy() instead.

This issue is identified by a Coccinelle script.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/sja1000/peak_pcmcia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index dd56133cc4616..fc9f8b01ecae2 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -487,7 +487,7 @@ static void pcan_free_channels(struct pcan_pccard *card)
 		if (!netdev)
 			continue;
 
-		strncpy(name, netdev->name, IFNAMSIZ);
+		strlcpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_sja1000dev(netdev);
 
-- 
2.20.1

