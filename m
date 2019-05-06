Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E98C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093CA20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154110;
	bh=j9uIuOGdPePJDP+T4YPSAsgoFD0uVap6l6TEKzSmE88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hrusYz9+9cfIhwBAo6hYqfxX2PBhXDKSqdcFHp0ecBXVv2dbWhuE4G14NAb0TZnse
	 OrY1kgQX7RsH3fXI/lGn64Xi7gumA/fUEm4kd3oWYQrm1gDNhjP3+SVKI5uP65NBXm
	 M+pNU31nP/m1sv1QVRNo9cdOCsgEG1BZASgChH1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfEFOs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbfEFOs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:48:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF132053B;
        Mon,  6 May 2019 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557154106;
        bh=j9uIuOGdPePJDP+T4YPSAsgoFD0uVap6l6TEKzSmE88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibxoVMNVdhTbNGgWgVt8asm9VQJKbTjyJWAxtU95omlPi1eK+cnGkmjHcBqaF1KCz
         20GdHDKThsM9+hh7gXlyVWG41CrPk9iE7+ttLLq0O33TC2Ng6wuthvLaHd4KwZkaks
         fWbOck8/eqtOwK8rYRvVAA6han2nx7dELp+qIOTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 07/62] net: phy: marvell: Fix buffer overrun with stats counters
Date:   Mon,  6 May 2019 16:32:38 +0200
Message-Id: <20190506143051.730821046@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143051.102535767@linuxfoundation.org>
References: <20190506143051.102535767@linuxfoundation.org>
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
@@ -1429,9 +1429,10 @@ static int marvell_get_sset_count(struct
 
 static void marvell_get_strings(struct phy_device *phydev, u8 *data)
 {
+	int count = marvell_get_sset_count(phydev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(marvell_hw_stats); i++) {
+	for (i = 0; i < count; i++) {
 		memcpy(data + i * ETH_GSTRING_LEN,
 		       marvell_hw_stats[i].string, ETH_GSTRING_LEN);
 	}
@@ -1470,9 +1471,10 @@ static u64 marvell_get_stat(struct phy_d
 static void marvell_get_stats(struct phy_device *phydev,
 			      struct ethtool_stats *stats, u64 *data)
 {
+	int count = marvell_get_sset_count(phydev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(marvell_hw_stats); i++)
+	for (i = 0; i < count; i++)
 		data[i] = marvell_get_stat(phydev, i);
 }
 


