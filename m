Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB75C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872D622DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612813;
	bh=vaGfJQtgEX20SkVdECVKbd9a+wVF0Ps8/spkJNFEFtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MDiCTqzKiqC/Zn8MVa0F2Z8hX7isYaEqWmAEezb+njiKCT1KKo9jSxIWa4+SpXti1
	 RUAVbHIBlkdmc+Qhywo/ypWNlqDV3Vd0MUBBD+IpHd8Tu3vUDLFgHrua98AqNmkTfl
	 snG1e9yDBowlGcj/Avg08GJYW7jEDOzYARQNOYUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfIDQAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732504AbfIDP74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C2F2070C;
        Wed,  4 Sep 2019 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612795;
        bh=vaGfJQtgEX20SkVdECVKbd9a+wVF0Ps8/spkJNFEFtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkX8FB6lRnyP6Dph4R8dDIHulbtw1vj9/d9AdLYC9zRwv9YGOF99nTuSggw6UTDtx
         FHoGqgeASOdESd+tTXnYclMsMoAHmtq5ZRlpJdZOg0tj0vXR9J4r+EFCJXUlr9Td72
         7RlT4LY7kXtC9AXIjGE++z9te57hu3Kx6gckYwdo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 89/94] net: aquantia: reapply vlan filters on up
Date:   Wed,  4 Sep 2019 11:57:34 -0400
Message-Id: <20190904155739.2816-89-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

[ Upstream commit c2ef057ee775e229d3138add59f937d93a3a59d8 ]

In case of device reconfiguration the driver may reset the device invisible
for other modules, vlan module in particular. So vlans will not be
removed&created and vlan filters will not be configured in the device.
The patch reapplies the vlan filters at device start.

Fixes: 7975d2aff5afb ("net: aquantia: add support of rx-vlan-filter offload")
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index 5315df5ff6f83..4ebf083c51c5f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -61,6 +61,10 @@ static int aq_ndev_open(struct net_device *ndev)
 	if (err < 0)
 		goto err_exit;
 
+	err = aq_filters_vlans_update(aq_nic);
+	if (err < 0)
+		goto err_exit;
+
 	err = aq_nic_start(aq_nic);
 	if (err < 0)
 		goto err_exit;
-- 
2.20.1

