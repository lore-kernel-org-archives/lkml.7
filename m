Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5924214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210527;
	bh=8aKOuuqY5V4XqPQXlPH6ZYhPGkDDwBA5ONjdJGBW6rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oy8XT01QdUcYR4ATttxKInSXzTliBmSBumGb63IyjPAYRlLh2EaTZzBUnt3xxT4Ii
	 CHk6NSmk6hmHRxaYhZ2eRoJJUK+OZIj2puFlWNTMx6bQTZ6s1PnPOktK9wBhg/f/EP
	 vXGZoFE+hlR/H+x6r3UTPILT7U9Nq/G9s9uPf7f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfJ0VIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfJ0VIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:08:43 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F27A20B7C;
        Sun, 27 Oct 2019 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210522;
        bh=8aKOuuqY5V4XqPQXlPH6ZYhPGkDDwBA5ONjdJGBW6rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKtDbg1a6Qz0/4PZBzMPg36VoHjXw4PzKFLtAhz+dxD95Su7CDuk/9Ccr+dih0FG/
         g/UmVCQD7RtY1BgLBK2ZWRjwoqReSujxIYNSrSbDJLRJoko6xB4+u4/HadpWgDFdu8
         O+IMjlnrWJqa+9H8WW3tsqWuY2o7FwRoe3ST4BDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 007/119] net: dsa: qca8k: Use up to 7 ports for all operations
Date:   Sun, 27 Oct 2019 21:59:44 +0100
Message-Id: <20191027203301.305547161@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 7ae6d93c8f052b7a77ba56ed0f654e22a2876739 ]

The QCA8K family supports up to 7 ports. So use the existing
QCA8K_NUM_PORTS define to allocate the switch structure and limit all
operations with the switch ports.

This was not an issue until commit 0394a63acfe2 ("net: dsa: enable and
disable all ports") disabled all unused ports. Since the unused ports 7-11
are outside of the correct register range on this switch some registers
were rewritten with invalid content.

Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")
Fixes: a0c02161ecfc ("net: dsa: variable number of ports")
Fixes: 0394a63acfe2 ("net: dsa: enable and disable all ports")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/qca8k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index c3c9d7e33bd6c..8e49974ffa0ed 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -551,7 +551,7 @@ qca8k_setup(struct dsa_switch *ds)
 		    BIT(0) << QCA8K_GLOBAL_FW_CTRL1_UC_DP_S);
 
 	/* Setup connection between CPU port & user ports */
-	for (i = 0; i < DSA_MAX_PORTS; i++) {
+	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
 		/* CPU port gets connected to all user ports of the switch */
 		if (dsa_is_cpu_port(ds, i)) {
 			qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(QCA8K_CPU_PORT),
@@ -900,7 +900,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	if (id != QCA8K_ID_QCA8337)
 		return -ENODEV;
 
-	priv->ds = dsa_switch_alloc(&mdiodev->dev, DSA_MAX_PORTS);
+	priv->ds = dsa_switch_alloc(&mdiodev->dev, QCA8K_NUM_PORTS);
 	if (!priv->ds)
 		return -ENOMEM;
 
-- 
2.20.1



