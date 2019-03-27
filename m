Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7930C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714855;
	bh=5nUfx0bnsuzCLf6bLSSZYIMw8WIO/ltzMmL0xXxuUGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpAy5LGZYFbeiqga68Nur4hNHtf6PXdOSfh1KLQucpItwiXpiuIkY+Abi4GZDHn90
	 DPG53HX2TLK/hyHZP1ck+1k895F5Ik0Tnmbf2vH3ypnApzfsh8YSgOLO1Q7F5O5ApF
	 bqTrMohj1Yr1htqDSxji2XAy4YSUE5C5kaGUAwts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbfC0T1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387428AbfC0SEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0923521734;
        Wed, 27 Mar 2019 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709882;
        bh=5nUfx0bnsuzCLf6bLSSZYIMw8WIO/ltzMmL0xXxuUGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWt/pVY5ECXeobDzvShfw5UUsRW9199CIdlvxloKyI7Ddw9VEjI42cmAKuppFsByc
         fQV7UXaBiA8Xvul3t6MlCHWkVSxdSR8suKveLQF422N5ehdbo0QP4O2nbEFjOg+Bod
         PjhSrkvgbEX3uYNnmfjn9QBrI9Qqo0MK5Q6Mr91s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 087/262] net: dsa: mv88e6xxx: Default CMODE to 1000BaseX only on 6390X
Date:   Wed, 27 Mar 2019 13:59:02 -0400
Message-Id: <20190327180158.10245-87-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

[ Upstream commit 65b034cf5c1766492aa107958149b440889480be ]

Commit 787799a9d555 sets the SERDES interfaces of 6390 and 6390X to
1000BaseX, but this is only needed on 6390X, since there are SERDES
interfaces which can be used on lower ports on 6390.

This commit fixes this by returning to previous behaviour on 6390.
(Previous behaviour means that CMODE is not set at all if requested mode
is NA).

This is needed on Turris MOX, where the 88e6190 is connected to CPU in
2500BaseX mode.

Fixes: 787799a9d555 ("net: dsa: mv88e6xxx: Default ports 9/10 6390X CMODE to 1000BaseX")
Signed-off-by: Marek Behún <marek.behun@nic.cz>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5e921bb6c214..dce84a2a65c7 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -472,6 +472,8 @@ int mv88e6390_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			     phy_interface_t mode)
 {
 	switch (mode) {
+	case PHY_INTERFACE_MODE_NA:
+		return 0;
 	case PHY_INTERFACE_MODE_XGMII:
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_RXAUI:
-- 
2.19.1

