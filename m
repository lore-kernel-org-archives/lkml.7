Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8643EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF7820823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689241;
	bh=RJC+nji1791IRtb4D0zAnyWi/dgqQA9Nvb5BqjxRXu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c9I5MNv1mfh6D61w54z96VRCx10CBvQho0K4NPF1y+Qgxrg/zmHMmJQiv/1EkzIjc
	 44vBFXBwx4CPG30hGhCgwoQKfodp/53Iw3eSG/47IJYueBoGHwoa3J1HzX5EHbqg1r
	 1qYLf4I/ytNtglIADANMV6NDnUh7W3e2V/p6YCFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfCDIrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCDIYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9432D20823;
        Mon,  4 Mar 2019 08:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687862;
        bh=RJC+nji1791IRtb4D0zAnyWi/dgqQA9Nvb5BqjxRXu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SiOFZWO6Zvd5kU0VtX83E1zqWklwnL6V5QR13r2WE2qirrXhXg8Pu7cM8+/7YlAo
         XuVrEyut2iQ7RtUrCXgU3mP+LlZbImhOpnl+QiUeBilQ0xq+290unpp6312sOdDiUJ
         XUlDsAohr7IOtLjENFmA7CosUahtnYqBPpkswfsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH 4.14 04/52] net: stmmac: Fix reception of Broadcom switches tags
Date:   Mon,  4 Mar 2019 09:22:02 +0100
Message-Id: <20190304081617.404086004@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 8cad443eacf661796a740903a75cb8944c675b4e upstream.

Broadcom tags inserted by Broadcom switches put a 4 byte header after
the MAC SA and before the EtherType, which may look like some sort of 0
length LLC/SNAP packet (tcpdump and wireshark do think that way). With
ACS enabled in stmmac the packets were truncated to 8 bytes on
reception, whereas clearing this bit allowed normal reception to occur.

In order to make that possible, we need to pass a net_device argument to
the different core_init() functions and we are dependent on the Broadcom
tagger padding packets correctly (which it now does). To be as little
invasive as possible, this is only done for gmac1000 when the network
device is DSA-enabled (netdev_uses_dsa() returns true).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/common.h         |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c    |    3 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c |   12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c  |   15 +++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    |   12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |    2 +-
 6 files changed, 39 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -475,7 +475,7 @@ struct mac_device_info;
 /* Helpers to program the MAC core */
 struct stmmac_ops {
 	/* MAC core initialization */
-	void (*core_init)(struct mac_device_info *hw, int mtu);
+	void (*core_init)(struct mac_device_info *hw, struct net_device *dev);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -477,7 +477,8 @@ static int sun8i_dwmac_init(struct platf
 	return 0;
 }
 
-static void sun8i_dwmac_core_init(struct mac_device_info *hw, int mtu)
+static void sun8i_dwmac_core_init(struct mac_device_info *hw,
+				  struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 v;
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -25,18 +25,28 @@
 #include <linux/crc32.h>
 #include <linux/slab.h>
 #include <linux/ethtool.h>
+#include <net/dsa.h>
 #include <asm/io.h>
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
 
-static void dwmac1000_core_init(struct mac_device_info *hw, int mtu)
+static void dwmac1000_core_init(struct mac_device_info *hw,
+				struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONTROL);
+	int mtu = dev->mtu;
 
 	/* Configure GMAC core */
 	value |= GMAC_CORE_INIT;
 
+	/* Clear ACS bit because Ethernet switch tagging formats such as
+	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
+	 * hardware to truncate packets on reception.
+	 */
+	if (netdev_uses_dsa(dev))
+		value &= ~GMAC_CONTROL_ACS;
+
 	if (mtu > 1500)
 		value |= GMAC_CONTROL_2K;
 	if (mtu > 2000)
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_core.c
@@ -25,15 +25,26 @@
 *******************************************************************************/
 
 #include <linux/crc32.h>
+#include <net/dsa.h>
 #include <asm/io.h>
 #include "dwmac100.h"
 
-static void dwmac100_core_init(struct mac_device_info *hw, int mtu)
+static void dwmac100_core_init(struct mac_device_info *hw,
+			       struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + MAC_CONTROL);
 
-	writel((value | MAC_CORE_INIT), ioaddr + MAC_CONTROL);
+	value |= MAC_CORE_INIT;
+
+	/* Clear ASTP bit because Ethernet switch tagging formats such as
+	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
+	 * hardware to truncate packets on reception.
+	 */
+	if (netdev_uses_dsa(dev))
+		value &= ~MAC_CONTROL_ASTP;
+
+	writel(value, ioaddr + MAC_CONTROL);
 
 #ifdef STMMAC_VLAN_TAG_USED
 	writel(ETH_P_8021Q, ioaddr + MAC_VLAN1);
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -17,16 +17,26 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <net/dsa.h>
 #include "stmmac_pcs.h"
 #include "dwmac4.h"
 
-static void dwmac4_core_init(struct mac_device_info *hw, int mtu)
+static void dwmac4_core_init(struct mac_device_info *hw,
+			     struct net_device *dev)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	int mtu = dev->mtu;
 
 	value |= GMAC_CORE_INIT;
 
+	/* Clear ACS bit because Ethernet switch tagging formats such as
+	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
+	 * hardware to truncate packets on reception.
+	 */
+	if (netdev_uses_dsa(dev))
+		value &= ~GMAC_CONFIG_ACS;
+
 	if (mtu > 1500)
 		value |= GMAC_CONFIG_2K;
 	if (mtu > 2000)
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2497,7 +2497,7 @@ static int stmmac_hw_setup(struct net_de
 	}
 
 	/* Initialize the MAC Core */
-	priv->hw->mac->core_init(priv->hw, dev->mtu);
+	priv->hw->mac->core_init(priv->hw, dev);
 
 	/* Initialize MTL*/
 	if (priv->synopsys_id >= DWMAC_CORE_4_00)


