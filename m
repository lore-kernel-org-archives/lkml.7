Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75334C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A512083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfB1Nwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:52:39 -0500
Received: from smtp.asem.it ([151.1.184.197]:49741 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfB1Nwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:52:38 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003723177.MSG 
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:52:33 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Thu, 28
 Feb 2019 14:52:32 +0100
Received: from flavio-x.asem.intra (172.16.17.161) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Thu, 28 Feb 2019 14:52:32 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v3] net: e1000e: add MAC address kernel cmd line parameter
Date:   Thu, 28 Feb 2019 14:52:31 +0100
Message-ID: <1551361951-1595-1-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
References: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0208.5C77E7A1.0031,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, in some embedded systems boards (i.e. ARM boards),
the NVM eeprom is not mounted, to save cost and space.

In this case it is necessary to bypass the NVM management
and directly force the MAC address using a kernel command-line
parameter (macaddr).

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v3: - move patch changelog in the right place
v2: - e1000_probe: remove wrong newline in the middle of the local variable list
v1: - written

 drivers/net/ethernet/intel/e1000e/netdev.c | 49 +++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 189f231..34ab560 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -39,6 +39,10 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+static unsigned char macaddr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+module_param_array(macaddr, byte, NULL, 0);
+MODULE_PARM_DESC(macaddr, "e1000e Ethernet MAC address");
+
 static const struct e1000_info *e1000_info_tbl[] = {
 	[board_82571]		= &e1000_82571_info,
 	[board_82572]		= &e1000_82572_info,
@@ -7232,27 +7236,38 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	adapter->hw.mac.ops.reset_hw(&adapter->hw);
 
-	/* systems with ASPM and others may see the checksum fail on the first
-	 * attempt. Let's give it a few tries
-	 */
-	for (i = 0;; i++) {
-		if (e1000_validate_nvm_checksum(&adapter->hw) >= 0)
-			break;
-		if (i == 2) {
-			dev_err(&pdev->dev, "The NVM Checksum Is Not Valid\n");
-			err = -EIO;
-			goto err_eeprom;
+	/* If the MAC address is supplied by the bootloader, use it! */
+	if (!is_multicast_ether_addr(macaddr)) {
+		dev_info(&pdev->dev,
+			 "MAC address from kernel command line argument\n");
+		memcpy(adapter->hw.mac.addr, macaddr, netdev->addr_len);
+		memcpy(netdev->dev_addr,     macaddr, netdev->addr_len);
+	} else {
+		/* systems with ASPM and others may see the checksum fail on
+		 * the first attempt. Let's give it a few tries
+		 */
+		dev_info(&pdev->dev, "MAC address from NVM\n");
+		for (i = 0;; i++) {
+			if (e1000_validate_nvm_checksum(&adapter->hw) >= 0)
+				break;
+			if (i == 2) {
+				dev_err(&pdev->dev,
+					"The NVM Checksum Is Not Valid\n");
+				err = -EIO;
+				goto err_eeprom;
+			}
 		}
-	}
 
-	e1000_eeprom_checks(adapter);
+		e1000_eeprom_checks(adapter);
 
-	/* copy the MAC address */
-	if (e1000e_read_mac_addr(&adapter->hw))
-		dev_err(&pdev->dev,
-			"NVM Read Error while reading MAC address\n");
+		/* copy the MAC address */
+		if (e1000e_read_mac_addr(&adapter->hw))
+			dev_err(&pdev->dev,
+				"NVM Read Error while reading MAC address\n");
 
-	memcpy(netdev->dev_addr, adapter->hw.mac.addr, netdev->addr_len);
+		memcpy(netdev->dev_addr, adapter->hw.mac.addr,
+		       netdev->addr_len);
+	}
 
 	if (!is_valid_ether_addr(netdev->dev_addr)) {
 		dev_err(&pdev->dev, "Invalid MAC Address: %pM\n",
-- 
2.7.4

