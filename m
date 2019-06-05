Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB22C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00E2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFEUVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:21:41 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.164]:20754 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbfFEUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:21:40 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id ABDD9C7B01
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2019 15:00:08 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yc4uh2vtu90onYc4uh4cOL; Wed, 05 Jun 2019 15:00:08 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=32980 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYc4t-003gcA-Jz; Wed, 05 Jun 2019 15:00:07 -0500
Date:   Wed, 5 Jun 2019 15:00:02 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] phy: samsung: Use struct_size() in devm_kzalloc()
Message-ID: <20190605200002.GA18640@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYc4t-003gcA-Jz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:32980
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct samsung_usb2_phy_driver {
	...
        struct samsung_usb2_phy_instance instances[0];
};

instance = devm_kzalloc(dev, sizeof(struct samsung_usb2_phy_driver) + count *
			sizeof(struct samsung_usb2_phy_instance), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, instances, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/phy/samsung/phy-samsung-usb2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/samsung/phy-samsung-usb2.c b/drivers/phy/samsung/phy-samsung-usb2.c
index ea818866985a..4616ec829900 100644
--- a/drivers/phy/samsung/phy-samsung-usb2.c
+++ b/drivers/phy/samsung/phy-samsung-usb2.c
@@ -159,9 +159,8 @@ static int samsung_usb2_phy_probe(struct platform_device *pdev)
 	if (!cfg)
 		return -EINVAL;
 
-	drv = devm_kzalloc(dev, sizeof(struct samsung_usb2_phy_driver) +
-		cfg->num_phys * sizeof(struct samsung_usb2_phy_instance),
-								GFP_KERNEL);
+	drv = devm_kzalloc(dev, struct_size(drv, instances, cfg->num_phys),
+			   GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
-- 
2.21.0

