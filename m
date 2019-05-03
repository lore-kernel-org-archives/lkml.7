Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957A6C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6815D205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfECOfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:35:41 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:17189 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbfECOfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:35:19 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id BBF064ADA;
        Fri,  3 May 2019 16:27:51 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id a47c137c;
        Fri, 3 May 2019 16:27:50 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/10] powerpc: tsi108: support of_get_mac_address new ERR_PTR error
Date:   Fri,  3 May 2019 16:27:15 +0200
Message-Id: <1556893635-18549-11-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556893635-18549-1-git-send-email-ynezz@true.cz>
References: <1556893635-18549-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

 arch/powerpc/sysdev/tsi108_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 1f1af12..c92dcac 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -105,7 +105,7 @@ static int __init tsi108_eth_of_init(void)
 		}
 
 		mac_addr = of_get_mac_address(np);
-		if (mac_addr)
+		if (!IS_ERR(mac_addr))
 			memcpy(tsi_eth_data.mac_addr, mac_addr, 6);
 
 		ph = of_get_property(np, "mdio-handle", NULL);
-- 
1.9.1

