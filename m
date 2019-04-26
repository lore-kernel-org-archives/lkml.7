Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD744C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F04208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="YkZm4YEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfDZHkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:40:08 -0400
Received: from first.geanix.com ([116.203.34.67]:59630 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDZHkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:40:07 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 02222308E65;
        Fri, 26 Apr 2019 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556263911; bh=kd2ipqB8/xm7EQEe51rjpYqTU0FjBfmCBeJpaPbdh+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YkZm4YEs/yG+Qim9uxCMo9nrIC80UyCMATXxnpfbuwFLgYBUFkL2CgYjzmUdDdsN9
         iiqSCwZ3R75eKAa/hUecDIN7uWM9pzDRfKV8A4YYF7Ov0C9Mnaa+Y+QZPh5q5ZHnBN
         xHQz3tf3o01OuaTRCVQNCEdBEp/0IUcGiXo8Lv5GW9IRSsDom7veTIJVURvAHtuXwX
         REM6VBy/6Hz1raVZEKnuQZx0i2tZWAjJXJunlIw+88l98zsV8+XLmeXc8mwIo/XRy6
         IJYniGp9eHa/O65D1O15FDC9SbtHn50bg+9ihC1u2oa0309DLemCyidP16u65/YA0m
         jhjYDjeAS9yjQ==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] net: ll_temac: Allow use on x86 platforms
Date:   Fri, 26 Apr 2019 09:32:25 +0200
Message-Id: <20190426073231.4008-7-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426073231.4008-1-esben@geanix.com>
References: <20190426073231.4008-1-esben@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With little-endian and 64-bit support in place, the ll_temac driver can
now be used on x86 and x86_64 platforms.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/xilinx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 6d68c8a..6f858f6 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_XILINX
 	bool "Xilinx devices"
 	default y
-	depends on PPC || PPC32 || MICROBLAZE || ARCH_ZYNQ || MIPS
+	depends on PPC || PPC32 || MICROBLAZE || ARCH_ZYNQ || MIPS || X86
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -33,7 +33,7 @@ config XILINX_AXI_EMAC
 
 config XILINX_LL_TEMAC
 	tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC) driver"
-	depends on (PPC || MICROBLAZE)
+	depends on PPC || MICROBLAZE || X86
 	select PHYLIB
 	---help---
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
-- 
2.4.11

