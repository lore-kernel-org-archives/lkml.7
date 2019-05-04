Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BFEC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D4F2084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556965693;
	bh=WFS88EiI+PETvXFOkUQbVWA8h6wva8dWzl4HlfrSz2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4rDyouAIQirp9t3PX/g52+oXZE6VKkM6wwqUig0n1brKjqTpqAfEegowuqIob1jM
	 Exdcp1AiAsUz24+ph+QFevU4zhQLecmhp+3g2LWyEhAHRog6rhgs5hc8rp1XcpoU/P
	 DMQnZ38UOa7IegNbDCoPdsNkI2kYAQZWMpbsLVnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfEDK2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfEDK2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:28:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A6B20862;
        Sat,  4 May 2019 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556965679;
        bh=WFS88EiI+PETvXFOkUQbVWA8h6wva8dWzl4HlfrSz2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fv0gC/+hazwQla6Ahx/vSr+0SIetUsXxDRVUcfULreuDCtg3xdpB0LDtwYWuqIdEb
         2oVtye6gB6ghCoaIQCjRXizNrGFgqMu4xyGZZGgyyRb75fO7A6gdyyw6jTzzfiDNYQ
         iAwuLu3OdEthynYCz6Mqbs44Gx001rPhxIAdYGag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 09/23] net: phy: marvell: Fix buffer overrun with stats counters
Date:   Sat,  4 May 2019 12:25:11 +0200
Message-Id: <20190504102451.858845315@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504102451.512405835@linuxfoundation.org>
References: <20190504102451.512405835@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit fdfdf86720a34527f777cbe0d8599bf0528fa146 ]

marvell_get_sset_count() returns how many statistics counters there
are. If the PHY supports fibre, there are 3, otherwise two.

marvell_get_strings() does not make this distinction, and always
returns 3 strings. This then often results in writing past the end
of the buffer for the strings.

Fixes: 2170fef78a40 ("Marvell phy: add field to get errors from fiber link.")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1513,9 +1513,10 @@ static int marvell_get_sset_count(struct
 
 static void marvell_get_strings(struct phy_device *phydev, u8 *data)
 {
+	int count = marvell_get_sset_count(phydev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(marvell_hw_stats); i++) {
+	for (i = 0; i < count; i++) {
 		strlcpy(data + i * ETH_GSTRING_LEN,
 			marvell_hw_stats[i].string, ETH_GSTRING_LEN);
 	}
@@ -1543,9 +1544,10 @@ static u64 marvell_get_stat(struct phy_d
 static void marvell_get_stats(struct phy_device *phydev,
 			      struct ethtool_stats *stats, u64 *data)
 {
+	int count = marvell_get_sset_count(phydev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(marvell_hw_stats); i++)
+	for (i = 0; i < count; i++)
 		data[i] = marvell_get_stat(phydev, i);
 }
 


