Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B70ACA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3950920B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210844;
	bh=rGny4XQJJmR/FcSrQJVmBrytLBojLgJUKL71KbpCzCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=saDgbH1CHAdRQ3Vt/88GnCX9Kr5GIVkR4TXld1sHQvLj75YAXmycht4/RY3bv8KMu
	 2cPppc4gxRsiCiGnrPzekvKgR0hwD3UkcT2jBAYxmV1qPLlr11g3u0cp7PPklAPblr
	 qBTccP1gOUEWFbg5xwzZABM0Tay3033Px4FspUac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfJ0VOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbfJ0VN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:13:58 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E662064A;
        Sun, 27 Oct 2019 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210837;
        bh=rGny4XQJJmR/FcSrQJVmBrytLBojLgJUKL71KbpCzCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yu3SJiw8g/3ARO8muhj21JYdd+JQvIdH7LzSm5VwM5QQhOmzCvJr95wfgrI/3SFKx
         74FjJlcMirs3jc650XsLDpZUWmzor97Gr3jNi82ZqqFOSGIg03fiCgqCd5koR5b/Oa
         nfRb7Oad9uT3aOZseAYT2qPXRpL7zFNxsG9eSMgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 09/93] net: dsa: qca8k: Use up to 7 ports for all operations
Date:   Sun, 27 Oct 2019 22:00:21 +0100
Message-Id: <20191027203253.898074305@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
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
index bdd8f2df66303..33232cc9fb04d 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -543,7 +543,7 @@ qca8k_setup(struct dsa_switch *ds)
 		    BIT(0) << QCA8K_GLOBAL_FW_CTRL1_UC_DP_S);
 
 	/* Setup connection between CPU port & user ports */
-	for (i = 0; i < DSA_MAX_PORTS; i++) {
+	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
 		/* CPU port gets connected to all user ports of the switch */
 		if (dsa_is_cpu_port(ds, i)) {
 			qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(QCA8K_CPU_PORT),
@@ -897,7 +897,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	if (id != QCA8K_ID_QCA8337)
 		return -ENODEV;
 
-	priv->ds = dsa_switch_alloc(&mdiodev->dev, DSA_MAX_PORTS);
+	priv->ds = dsa_switch_alloc(&mdiodev->dev, QCA8K_NUM_PORTS);
 	if (!priv->ds)
 		return -ENOMEM;
 
-- 
2.20.1



