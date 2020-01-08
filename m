Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817A0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5400E2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgAHMsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:48:54 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgAHMsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:48:54 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MAfQe-1j0CJU0vU0-00B0YH; Wed, 08 Jan 2020 13:48:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: felix: fix link error
Date:   Wed,  8 Jan 2020 13:48:38 +0100
Message-Id: <20200108124844.1348395-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5e88e3Rt8vGBDypbvNaW0AJB2I5iFs7xvxm/ZKF/cCcj72o/Fjg
 3VEv599loYxX0CiHwDxS5+LymYjOkcjmOuYdXrOM+rDPzBCaSlOxJuwM4GNNL0u17gXMOaq
 Gzn7vK2CLy1uUiZ+5Dlj7p+bwF3YVnPVJK79Of5fsLfCQeXhMOUH7L+ks5RASFt3qhjyfFG
 RLQv0TCPtrzF2Wt7ELbVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aDPWaKRbaz8=:QCKlrKk1mjq3OoRwoniRyM
 PVOQBdaLu9TD8odFYETbf8G8ni5qHvt0YydK6mmjOwRH6LCsmNAQG/wdBVLifJXJctbB0weo6
 9uVANGelk9bBGhQCV3XJSDyc1trB74zbT4Bl54oBQ6rBicjvMJ8qazJURYUxiFKdWsnSEYbNP
 cMccLvF7OrcIhxR6Vpgqn0raIILk8jITKlisjDOhCGqb8x3x22CHEpd2FphSenn/AckaoHZ97
 0B660nnutvo6ZhQ//p5aYLZr902Ob1sLSgDkePDJD6vF80PPWKz8qlvrY3uQd0Io30vap3g71
 JJmaeZN5GXz9yyxZ3rRcERqAYs7X45Ps41Srbj4yPg3m36NYuE/yr3jqmGJdK2wlGZpXGi/QE
 262PHvDb2xdhk87GjoqRULCVVQIiMXmWqaoYyrJxG6p0aQ8q7X/4fnhOwezDHFcAx5UwO8JA8
 fj6SrUohgJRMwpdhjhkZaMhXAiueCw8AhvEU4eKDhs+8DNuQgtZ5PkFruSedmbCD4wwpkijP+
 hQxPSBxOEOCdVfSLbSpP2rHTTV2O3/UjMg0A9W7k81kxdh4NOnExz6PKlM60Uzb+GOtkHc9Fy
 TVLOt3mBXBVzfJFk7CQPVa1NipUApnawoIxP10CjlIaT2CVrOXFFOTTEhd8YU6Lcn6AvhGweS
 14xCgBU6k6fnBIDm00Nn1VBRxNOlB7trzWD3HI+2qRopdqka8TpKafHwcGD7uidjSYZSUG0Gm
 GC1nOumBMwj/LKu4kdL1Xgtq4IfgNS9kkuVfBfEKkyNbVW3KhsCOaHFRD9FQUQkPvn/1Pqbe7
 mfLn+biYD0TQHoY+kwFGB6hBdGdh70laXfGrYagS/JrV3I5pi8Smv7nyM2V+lHFzvhDxrzIYT
 X87x47HifjZ5j4CksWvA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the enetc driver is disabled, the mdio support fails to
get built:

drivers/net/dsa/ocelot/felix_vsc9959.o: In function `vsc9959_mdio_bus_alloc':
felix_vsc9959.c:(.text+0x19c): undefined reference to `enetc_hw_alloc'
felix_vsc9959.c:(.text+0x1d1): undefined reference to `enetc_mdio_read'
felix_vsc9959.c:(.text+0x1d8): undefined reference to `enetc_mdio_write'

Change the Makefile to enter the subdirectory for this as well.

Fixes: bdeced75b13f ("net: dsa: felix: Add PCS operations for PHYLINK")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/freescale/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
index 6a93293d31e0..67c436400352 100644
--- a/drivers/net/ethernet/freescale/Makefile
+++ b/drivers/net/ethernet/freescale/Makefile
@@ -25,4 +25,5 @@ obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
 obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
 
 obj-$(CONFIG_FSL_ENETC) += enetc/
+obj-$(CONFIG_FSL_ENETC_MDIO) += enetc/
 obj-$(CONFIG_FSL_ENETC_VF) += enetc/
-- 
2.20.0

