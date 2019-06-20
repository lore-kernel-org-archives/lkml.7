Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2794CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AC0214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054164;
	bh=XOsat5H/9JjIfpfM0mPQ8/vDMgKzPKSgWRuivcB5zmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYp4unfFVhqWe872V/pw4CKQES1rxGV4pnz5G8ae64hzn4G2FwhKpZyKupFRE4fGY
	 zr7O/AXYMEuZEj3u57ARrfsoKdMZqdvpg2stIIUT0TeG/92ENfq8rKCl5fWfgz5+Xm
	 tISkKE4Z+lttTKW2budqQzlmHHpuZ2EY3aIX8cA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfFTSJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbfFTSJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:09:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93BFF2082C;
        Thu, 20 Jun 2019 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054159;
        bh=XOsat5H/9JjIfpfM0mPQ8/vDMgKzPKSgWRuivcB5zmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sizbQCa8z/wfcSqHHka3RhTPoJ9YM/AsBH+PHkNQNuch3/NJaG6b/B/AKZkk50+8W
         euH2X57g8tQgkf/HdmpUCqQNIeIxQEVf8viZ/D1eya/qTG6d5+OeniELbQHoKliLwt
         ND4uNsE38rKHGa+exCPE01gQBK/5gpBOOiQBZqmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amit Cohen <amitc@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 39/45] mlxsw: spectrum: Prevent force of 56G
Date:   Thu, 20 Jun 2019 19:57:41 +0200
Message-Id: <20190620174340.345051055@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174328.608036501@linuxfoundation.org>
References: <20190620174328.608036501@linuxfoundation.org>
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
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2505,6 +2505,10 @@ mlxsw_sp_port_set_link_ksettings(struct
 	mlxsw_reg_ptys_eth_unpack(ptys_pl, &eth_proto_cap, NULL, NULL);
 
 	autoneg = cmd->base.autoneg == AUTONEG_ENABLE;
+	if (!autoneg && cmd->base.speed == SPEED_56000) {
+		netdev_err(dev, "56G not supported with autoneg off\n");
+		return -EINVAL;
+	}
 	eth_proto_new = autoneg ?
 		mlxsw_sp_to_ptys_advert_link(cmd) :
 		mlxsw_sp_to_ptys_speed(cmd->base.speed);


