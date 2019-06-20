Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DEDC48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239342084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054070;
	bh=Va/5JEP+tw+rPEBGa39qJIClkCqzSoZXW7PGsjw4NIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ldtHyj0LgNlV5M277i7C1nuJZG0zMQUwzd4JmwL2EpR9LbpQLv5YQhXYL7tKL7k4/
	 TytYtHRRhRxdE5jF8VrMvqhOFHvcX/MqmKmulRy5EP3jUJdeEiowBHIApoCtUUg3wq
	 9K4iu8blJmtL0B1WTCAccHIcXr0RTs9aDuX41FmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfFTSHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfFTSHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:07:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90AD12084E;
        Thu, 20 Jun 2019 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054066;
        bh=Va/5JEP+tw+rPEBGa39qJIClkCqzSoZXW7PGsjw4NIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gu6n/9gPftTfVaD/WFChPiDMvebaDjoYP6xpzJV/KNXiZR9cSqlHJD+u9EovGhv9n
         IPJpaYJbBrUNdx3OdS9z52FoJWJeXce3AbXsFfkutLLbkBHhAcy0GdpwZMORxqarKY
         +aYqyBBvUobj70dsoBWE5bGy1H+/+COPB3CC2FOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amit Cohen <amitc@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 116/117] mlxsw: spectrum: Prevent force of 56G
Date:   Thu, 20 Jun 2019 19:57:30 +0200
Message-Id: <20190620174358.380666634@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 275e928f19117d22f6d26dee94548baf4041b773 ]

Force of 56G is not supported by hardware in Ethernet devices. This
configuration fails with a bad parameter error from firmware.

Add check of this case. Instead of trying to set 56G with autoneg off,
return a meaningful error.

Fixes: 56ade8fe3fe1 ("mlxsw: spectrum: Add initial support for Spectrum ASIC")
Signed-off-by: Amit Cohen <amitc@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index e3ed70a24029..585a40cc6470 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2044,6 +2044,10 @@ mlxsw_sp_port_set_link_ksettings(struct net_device *dev,
 	mlxsw_reg_ptys_unpack(ptys_pl, &eth_proto_cap, NULL, NULL);
 
 	autoneg = cmd->base.autoneg == AUTONEG_ENABLE;
+	if (!autoneg && cmd->base.speed == SPEED_56000) {
+		netdev_err(dev, "56G not supported with autoneg off\n");
+		return -EINVAL;
+	}
 	eth_proto_new = autoneg ?
 		mlxsw_sp_to_ptys_advert_link(cmd) :
 		mlxsw_sp_to_ptys_speed(cmd->base.speed);
-- 
2.20.1



