Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98C421924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138382;
	bh=KpmqzIT/vwP6YYVO50fRE8ZBbuorZot0H0YpCqueWrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DwtrlVaORw7gA1V3O5rr6Uzrq0u0ChbNysAOut0X7E74bXWU09uZItsVAcswKp6o6
	 0bXoJY07qwxvaWZ73Zej8Lj0Jk0pQOSizP8Iiy73u4A6UVkGdeLTyEbAUgRBYr+mfc
	 sex0Erzg0hxj6ivegwxI1N1hIQvh+HKc3bbFc/fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDARGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbfDARGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D851721924;
        Mon,  1 Apr 2019 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138377;
        bh=KpmqzIT/vwP6YYVO50fRE8ZBbuorZot0H0YpCqueWrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a66mPSG9rFDWj4IKEn9UBf7ry42JFxOZoZ8Ekn4tumOjR8D1DBklPAeqQK93iupKd
         O9cu1yNT7RkU1grPz+hgYG4C3H9sbTbbj/bbuXeGPPdODbFqwGD+5G7DTUXIlneVZw
         6VoXXWBQXte5Qa4qxkA+SSXiA0cTK46wBfYeip7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 013/146] net: phy: meson-gxl: fix interrupt support
Date:   Mon,  1 Apr 2019 19:00:25 +0200
Message-Id: <20190401170049.548261025@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit daa5c4d0167a308306525fd5ab9a5e18e21f4f74 ]

If an interrupt is already pending when the interrupt is enabled on the
GXL phy, no IRQ will ever be triggered.

The fix is simply to make sure pending IRQs are cleared before setting
up the irq mask.

Fixes: cf127ff20af1 ("net: phy: meson-gxl: add interrupt support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/meson-gxl.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -211,6 +211,7 @@ static int meson_gxl_ack_interrupt(struc
 static int meson_gxl_config_intr(struct phy_device *phydev)
 {
 	u16 val;
+	int ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		val = INTSRC_ANEG_PR
@@ -223,6 +224,11 @@ static int meson_gxl_config_intr(struct
 		val = 0;
 	}
 
+	/* Ack any pending IRQ */
+	ret = meson_gxl_ack_interrupt(phydev);
+	if (ret)
+		return ret;
+
 	return phy_write(phydev, INTSRC_MASK, val);
 }
 


