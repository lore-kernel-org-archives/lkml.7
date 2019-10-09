Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147DAECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A8E20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570641941;
	bh=7fAjbK0SIu6mwvNpnw29B0AVcrZ6A43tQQapzgn8thA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zH2AHqBz/WXhwFNMyhxmWCu8+f5f4mT8d/225kpy2f3yaa/pREBj9ookdH4sjeWPa
	 zU1kvnEXJnGv4JEaqEe8+YW5G6iTxwi9cQz3uRcb3Qti+erusAv/Bfa9uINOYFA1aQ
	 CCI4RK8I91wh6nNhKU6fqX/425lp3yYsGMNUv+oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbfJIRZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732521AbfJIRY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:57 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC26521A4A;
        Wed,  9 Oct 2019 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641896;
        bh=7fAjbK0SIu6mwvNpnw29B0AVcrZ6A43tQQapzgn8thA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrBn27MRlShQGzvqaPrxut8VdShtRhH/PNZiayZuiWYsq1AJEuS9yMvhYNIeDMF3c
         9wIuI4QcRfat80WhLOxpIzGu1tXmtydB2n3dcjZbU25czMn8Z/FYpwh3ylGrcs+qv+
         5fRVtoruPbbxvEUcJoe8TJxZYBWESAYZa1Sk3WZw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yizhuo <yzhai003@ucr.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 09/11] net: hisilicon: Fix usage of uninitialized variable in function mdio_sc_cfg_reg_write()
Date:   Wed,  9 Oct 2019 13:06:43 -0400
Message-Id: <20191009170646.696-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170646.696-1-sashal@kernel.org>
References: <20191009170646.696-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yizhuo <yzhai003@ucr.edu>

[ Upstream commit 53de429f4e88f538f7a8ec2b18be8c0cd9b2c8e1 ]

In function mdio_sc_cfg_reg_write(), variable "reg_value" could be
uninitialized if regmap_read() fails. However, "reg_value" is used
to decide the control flow later in the if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns_mdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 6ff13c559e527..09fcc821b7da9 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -156,11 +156,15 @@ static int mdio_sc_cfg_reg_write(struct hns_mdio_device *mdio_dev,
 {
 	u32 time_cnt;
 	u32 reg_value;
+	int ret;
 
 	regmap_write(mdio_dev->subctrl_vbase, cfg_reg, set_val);
 
 	for (time_cnt = MDIO_TIMEOUT; time_cnt; time_cnt--) {
-		regmap_read(mdio_dev->subctrl_vbase, st_reg, &reg_value);
+		ret = regmap_read(mdio_dev->subctrl_vbase, st_reg, &reg_value);
+		if (ret)
+			return ret;
+
 		reg_value &= st_msk;
 		if ((!!check_st) == (!!reg_value))
 			break;
-- 
2.20.1

