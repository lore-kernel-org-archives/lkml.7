Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC295C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989522075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfECPc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:32:58 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:14127 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfECPc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:32:58 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 4B7154CAC;
        Fri,  3 May 2019 17:32:55 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id 28cde553;
        Fri, 3 May 2019 17:32:53 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] staging: octeon-ethernet: support of_get_mac_address new ERR_PTR error
Date:   Fri,  3 May 2019 17:32:47 +0200
Message-Id: <1556897567-22247-1-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556893635-18549-9-git-send-email-ynezz@true.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was NVMEM support added to of_get_mac_address, so it could now return
ERR_PTR encoded error values, so we need to adjust all current users of
of_get_mac_address to this new fact.

Signed-off-by: Petr Štetiar <ynezz@true.cz>
---

 Changes since v3:

  * IS_ERR_OR_NULL -> IS_ERR

 Changes since v4:

  * I've just blindly replaced IS_ERR_OR_NULL with IS_ERR in v4, but this was
    wrong, as I've just realized, that we still need to check for NULL in this
    particular case as well, so I've added back IS_ERR_OR_NULL check

 drivers/staging/octeon/ethernet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 986db76..8847a11c2 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -421,7 +421,7 @@ int cvm_oct_common_init(struct net_device *dev)
 	if (priv->of_node)
 		mac = of_get_mac_address(priv->of_node);
 
-	if (mac)
+	if (!IS_ERR_OR_NULL(mac))
 		ether_addr_copy(dev->dev_addr, mac);
 	else
 		eth_hw_addr_random(dev);
-- 
1.9.1

