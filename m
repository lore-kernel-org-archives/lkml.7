Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16498C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48C520815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCDMog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:44:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbfCDMog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:44:36 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 78023256B567BF8FCE3C;
        Mon,  4 Mar 2019 20:44:33 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Mon, 4 Mar 2019 20:44:23 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH -next] net: dsa: mv88e6xxx: Fix build warning when CONFIG_NET_DSA_LEGACY is n
Date:   Mon, 4 Mar 2019 20:43:01 +0800
Message-ID: <1551703381-52115-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_NET_DSA_LEGACY is n, there is a GCC bulid warning:
drivers/net/dsa/mv88e6xxx/chip.c:4623:13: warning: ‘mv88e6xxx_ports_cmode_init’ defined but not used [-Wunused-function]
static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
Let's fix it.

Fixes: ed8fe20205ac ("net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@gmail.com> 
Cc: Florian Fainelli <f.fainelli@gmail.com> 
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index e4ad16b2dc38..168d4898c36f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4620,14 +4620,6 @@ static int mv88e6xxx_smi_init(struct mv88e6xxx_chip *chip,
 	return 0;
 }
 
-static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
-{
-	int i;
-
-	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
-		chip->ports[i].cmode = MV88E6XXX_PORT_STS_CMODE_INVALID;
-}
-
 static enum dsa_tag_protocol mv88e6xxx_get_tag_protocol(struct dsa_switch *ds,
 							int port)
 {
@@ -4637,6 +4629,14 @@ static enum dsa_tag_protocol mv88e6xxx_get_tag_protocol(struct dsa_switch *ds,
 }
 
 #if IS_ENABLED(CONFIG_NET_DSA_LEGACY)
+static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
+{
+	int i;
+
+	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
+		chip->ports[i].cmode = MV88E6XXX_PORT_STS_CMODE_INVALID;
+}
+
 static const char *mv88e6xxx_drv_probe(struct device *dsa_dev,
 				       struct device *host_dev, int sw_addr,
 				       void **priv)
-- 
2.7.4

