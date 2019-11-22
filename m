Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4F4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE6E2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="pf9FVhFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKVJXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:23:02 -0500
Received: from mail.intenta.de ([178.249.25.132]:44047 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfKVJXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:23:01 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 04:23:01 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date; bh=QoGoLrw+yd0OesTC5GBNZu06g/ri4zVDSm36TdL3rLw=;
        b=pf9FVhFny2MItH0BpjPM3KHNDrj3+KoU8YnLyDf/BZbFHVL44u8PH71CyGKmF62VDWnMW4/gf94nqkcz55EGUR6/35F61VxsDi3p1BRjvX5k+geqswdyyF+Be00azFCuN1bIf4eFRlLUnaQ7bLMVqBxRI2/5DbTGsqJ+1kdlqFBAshqSMho7SA9x002Gek4PsLmLORCf20gIzAMRyUoPfWhljhlzDIHXC1lQng8f8+k8G4HjrWRCH1Qw3z07Osr6zHuVFYKLlyzMrsotNQRkjI7P731fuiDg7yGEC8qfmuNIi/ruvqc4YIdMwpyWAasObQJ47qF9FJ6uG+uwga04jQ==;
Date:   Fri, 22 Nov 2019 10:17:13 +0100
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     YueHaibing <yuehaibing@huawei.com>, <davem@davemloft.net>,
        <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH] mdio_bus: revert inadvertent error code change
Message-ID: <20191122091711.GA31495@laureti-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed commit inadvertently changes the error code from ENOTSUPP to
ENOSYS. Doing so breaks (among other things) probing of macb, which
returns -ENOTSUPP as it is now returned from mdiobus_register_reset.

Fixes: 1d4639567d97 ("mdio_bus: Fix PTR_ERR applied after initialization to constant")
Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
---
 drivers/net/phy/mdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 35876562e32a..dbacb0031877 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -65,7 +65,7 @@ static int mdiobus_register_reset(struct mdio_device *mdiodev)
 		reset = devm_reset_control_get_exclusive(&mdiodev->dev,
 							 "phy");
 	if (IS_ERR(reset)) {
-		if (PTR_ERR(reset) == -ENOENT || PTR_ERR(reset) == -ENOSYS)
+		if (PTR_ERR(reset) == -ENOENT || PTR_ERR(reset) == -ENOTSUPP)
 			reset = NULL;
 		else
 			return PTR_ERR(reset);
-- 
2.20.1

