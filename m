Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21090C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC2821670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625087;
	bh=eKieE7if2lMhvvOxMlLJaaNlL71Am5r/lmbiTzC+8zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uBVtWSuNA66MovSMeUNXWHojQ3OzRMC7Zd3Iv07c9c+9YUi9s2b5Or/Wj1Iz4F32K
	 OV+YynwjyOx10GAQK7q/q2BPXJYimR4g0MGIcn4RVimxjTrUKX0QnNanfdtYkrttrf
	 4dyO4TS1roKF6tEqkhRY3orgTD5O8vxDliih/O+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfD3Lv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731377AbfD3LvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD0021670;
        Tue, 30 Apr 2019 11:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625082;
        bh=eKieE7if2lMhvvOxMlLJaaNlL71Am5r/lmbiTzC+8zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4Rj94x8X0Tk80O3Oai1HjyhAjF65KwKeSuC9NZ9jgeBMXqDasz/5JMbbTjkn993B
         6XkTfz8eLllrjNGrEueQO3LgEEXr/RK0ad4qdKMOHR16N0kuWbmABNebI8YZVYfehk
         +9ebfmH1n0685pIGB9bkshx9rE+qY8Tsl//IUGt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tao Ren <taoren@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 83/89] net/ncsi: handle overflow when incrementing mac address
Date:   Tue, 30 Apr 2019 13:39:14 +0200
Message-Id: <20190430113613.686303493@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <taoren@fb.com>

[ Upstream commit 1c5c12ee308aacf635c8819cd4baa3bd58f8a8b7 ]

Previously BMC's MAC address is calculated by simply adding 1 to the
last byte of network controller's MAC address, and it produces incorrect
result when network controller's MAC address ends with 0xFF.

The problem can be fixed by calling eth_addr_inc() function to increment
MAC address; besides, the MAC address is also validated before assigning
to BMC.

Fixes: cb10c7c0dfd9 ("net/ncsi: Add NCSI Broadcom OEM command")
Signed-off-by: Tao Ren <taoren@fb.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/etherdevice.h |   12 ++++++++++++
 net/ncsi/ncsi-rsp.c         |    6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -448,6 +448,18 @@ static inline void eth_addr_dec(u8 *addr
 }
 
 /**
+ * eth_addr_inc() - Increment the given MAC address.
+ * @addr: Pointer to a six-byte array containing Ethernet address to increment.
+ */
+static inline void eth_addr_inc(u8 *addr)
+{
+	u64 u = ether_addr_to_u64(addr);
+
+	u++;
+	u64_to_ether_addr(u, addr);
+}
+
+/**
  * is_etherdev_addr - Tell if given Ethernet address belongs to the device.
  * @dev: Pointer to a device structure
  * @addr: Pointer to a six-byte array containing the Ethernet address
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
 #include <net/ncsi.h>
@@ -667,7 +668,10 @@ static int ncsi_rsp_handler_oem_bcm_gma(
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
 	/* Increase mac address by 1 for BMC's address */
-	saddr.sa_data[ETH_ALEN - 1]++;
+	eth_addr_inc((u8 *)saddr.sa_data);
+	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
+		return -ENXIO;
+
 	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");


