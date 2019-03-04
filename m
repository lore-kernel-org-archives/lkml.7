Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAF5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F2E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687870;
	bh=HXfJDM6bLVf6Ky/wtwmLkX6D7xOH2laj1vthbitp+gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YG2wVdXbOFqyLxA/nzdEuwGYhYmqAbTlnBMpr83+UzNDIbSGEcl4XYoS6WnVae2pk
	 bAkZRm1ZND6tygCnr79iPmwM2+1axRdc9QFllWKzHTHKa1HUeuQlJr2yqa1so+PN+b
	 s/7QLEVKu7OG+SNA1pPpmK0dTb7C4QBLCUG88nm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCDIY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:24:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfCDIYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E92D20863;
        Mon,  4 Mar 2019 08:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687864;
        bh=HXfJDM6bLVf6Ky/wtwmLkX6D7xOH2laj1vthbitp+gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBA11VDksFXEgNYQ0e+uTnSGxlM6tqzipNsfw+78czxRJkZW4/5USWSDXJL0d8ypD
         mX64/MM1SCjPV/MUPlJHIq+5pWFz1UcVYLnMN5ay4Lp7+EdMWLdgwPGl/QlHeWx0KR
         B38wWsfRUuEqo3wcmNlv+GQjKS26lBsIHzokoK2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <jpinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 4.14 05/52] net: stmmac: Disable ACS Feature for GMAC >= 4
Date:   Mon,  4 Mar 2019 09:22:03 +0100
Message-Id: <20190304081617.458905055@linuxfoundation.org>
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

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit 565020aaeebfa7c8b3ec077bee38f4c15acc9905 upstream.

ACS Feature is currently enabled for GMAC >= 4 but the llc_snap status
is never checked in descriptor rx_status callback. This will cause
stmmac to always strip packets even that ACS feature is already
stripping them.

Lets be safe and disable the ACS feature for GMAC >= 4 and always strip
the packets for this GMAC version.

Fixes: 477286b53f55 ("stmmac: add GMAC4 core support")
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      |    2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c |    7 -------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    7 ++++++-
 3 files changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -336,7 +336,7 @@ enum power_event {
 #define MTL_RX_OVERFLOW_INT		BIT(16)
 
 /* Default operating mode of the MAC */
-#define GMAC_CORE_INIT (GMAC_CONFIG_JD | GMAC_CONFIG_PS | GMAC_CONFIG_ACS | \
+#define GMAC_CORE_INIT (GMAC_CONFIG_JD | GMAC_CONFIG_PS | \
 			GMAC_CONFIG_BE | GMAC_CONFIG_DCRS)
 
 /* To dump the core regs excluding  the Address Registers */
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -30,13 +30,6 @@ static void dwmac4_core_init(struct mac_
 
 	value |= GMAC_CORE_INIT;
 
-	/* Clear ACS bit because Ethernet switch tagging formats such as
-	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
-	 * hardware to truncate packets on reception.
-	 */
-	if (netdev_uses_dsa(dev))
-		value &= ~GMAC_CONFIG_ACS;
-
 	if (mtu > 1500)
 		value |= GMAC_CONFIG_2K;
 	if (mtu > 2000)
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3415,8 +3415,13 @@ static int stmmac_rx(struct stmmac_priv
 
 			/* ACS is set; GMAC core strips PAD/FCS for IEEE 802.3
 			 * Type frames (LLC/LLC-SNAP)
+			 *
+			 * llc_snap is never checked in GMAC >= 4, so this ACS
+			 * feature is always disabled and packets need to be
+			 * stripped manually.
 			 */
-			if (unlikely(status != llc_snap))
+			if (unlikely(priv->synopsys_id >= DWMAC_CORE_4_00) ||
+			    unlikely(status != llc_snap))
 				frame_len -= ETH_FCS_LEN;
 
 			if (netif_msg_rx_status(priv)) {


