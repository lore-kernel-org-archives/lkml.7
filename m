Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E2A2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639205;
	bh=erWqDX8SpUwJR1ygf9C0eCHvcngG2wRO1gFt5XSuHpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FM8X4pVbR0p5+dmqKodYXLPjTJu8wSHU8vCXZ3RSyVndHCbY34ns357w+sQ1tyJSe
	 BjvsQaCvcM2P8ckwzC7UIiPltb4LH8mAJ2fMmGbdNquVy1EiwMn82oK6qiBxETir7n
	 kIV3150D5CewlJp32zBLXpeZ6iKTl5Fli2bbH6TU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbfEWTUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388953AbfEWTT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554F6217D7;
        Thu, 23 May 2019 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639196;
        bh=erWqDX8SpUwJR1ygf9C0eCHvcngG2wRO1gFt5XSuHpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFmenR3B9GL+xK7gUIzGDLr6iaKFfblsJAbD+LnSwHDrD/Z4ozmDqgba5OgKmXiEY
         43NQyUpZZRwpknSC+XWQNCJ0qzx/pS/BMCv82/L+Q9cC1V8/ORjh/KPiXXB31wUpUd
         AwVpk129g62M1jz06ihiOX2xHtuoWXQeniC49tAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 003/139] net: Always descend into dsa/
Date:   Thu, 23 May 2019 21:04:51 +0200
Message-Id: <20190523181720.667996943@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 0fe9f173d6cda95874edeb413b1fa9907b5ae830 ]

Jiri reported that with a kernel built with CONFIG_FIXED_PHY=y,
CONFIG_NET_DSA=m and CONFIG_NET_DSA_LOOP=m, we would not get to a
functional state where the mock-up driver is registered. Turns out that
we are not descending into drivers/net/dsa/ unconditionally, and we
won't be able to link-in dsa_loop_bdinfo.o which does the actual mock-up
mdio device registration.

Reported-by: Jiri Pirko <jiri@resnulli.us>
Fixes: 40013ff20b1b ("net: dsa: Fix functional dsa-loop dependency on FIXED_PHY")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Tested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_ARCNET) += arcnet/
 obj-$(CONFIG_DEV_APPLETALK) += appletalk/
 obj-$(CONFIG_CAIF) += caif/
 obj-$(CONFIG_CAN) += can/
-obj-$(CONFIG_NET_DSA) += dsa/
+obj-y += dsa/
 obj-$(CONFIG_ETHERNET) += ethernet/
 obj-$(CONFIG_FDDI) += fddi/
 obj-$(CONFIG_HIPPI) += hippi/


