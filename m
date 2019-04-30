Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98167C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686A220835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625992;
	bh=2fVrfKPRJDmpuIYu/AVPqgHqNSEtakCjOlU/kwx6aWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpnW0i+vWCIdwnEVZNx4AOBElC1dqQqr5Z5QnGPf5rqzuYHgU9DRzQommtG7zY8Y2
	 9VCcaGZD9vsPa28ejb1JWU1VbJPr2wcyO6SftATLo/zCW7vVVk66Qu1eWE+d2m0iBo
	 Ucf/2yAfkppKeKaAJL3o9PJQPU5veglLoZtDjwmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfD3MGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfD3LlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:41:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7353D21670;
        Tue, 30 Apr 2019 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624470;
        bh=2fVrfKPRJDmpuIYu/AVPqgHqNSEtakCjOlU/kwx6aWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xI0S1j8CbQfwUQYWj7V4TPCr5nr1xMsN4+rvN2SuS+wtjxypMwjLAvHUZzjrB1B5K
         LEeKfeX4WJXw2gPQt+dvlbEU7ktF277GkjWj6f6VlQ5Nwz95wkqYBBTGl+S6ktlOzl
         soTjsOzrDy1/wmlLuiKQaOJ22i6v4MD77RsaOZgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amit Cohen <amitc@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 31/41] mlxsw: spectrum: Fix autoneg status in ethtool
Date:   Tue, 30 Apr 2019 13:38:42 +0200
Message-Id: <20190430113531.907091349@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113524.451237916@linuxfoundation.org>
References: <20190430113524.451237916@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Cohen <amitc@mellanox.com>

[ Upstream commit 151f0dddbbfe4c35c9c5b64873115aafd436af9d ]

If link is down and autoneg is set to on/off, the status in ethtool does
not change.

The reason is when the link is down the function returns with zero
before changing autoneg value.

Move the checking of link state (up/down) to be performed after setting
autoneg value, in order to be sure that autoneg will change in any case.

Fixes: 56ade8fe3fe1 ("mlxsw: spectrum: Add initial support for Spectrum ASIC")
Signed-off-by: Amit Cohen <amitc@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2059,11 +2059,11 @@ mlxsw_sp_port_set_link_ksettings(struct
 	if (err)
 		return err;
 
+	mlxsw_sp_port->link.autoneg = autoneg;
+
 	if (!netif_running(dev))
 		return 0;
 
-	mlxsw_sp_port->link.autoneg = autoneg;
-
 	mlxsw_sp_port_admin_status_set(mlxsw_sp_port, false);
 	mlxsw_sp_port_admin_status_set(mlxsw_sp_port, true);
 


