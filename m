Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630C0C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3930722314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003459;
	bh=//md0SP1j14tlYgqQUFEa08cSupdWyzLqvhOB/J0sPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1JprQKnhwg7QsTzFr44749ej21kOg/fw9C0GhTd0XtuDtTSbzTR6w8i30a39ky5GZ
	 cd01Fhd9DB8Vy/3VmzOVGqLDWAdvEXQL/EiMWuwY9IB02aAY9RzrBwIST1rcPBk6jn
	 0HGiE4+92rhS9+JPkduOdP2lyhUXtiyOvXsgaLFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgABWRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:17:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbgABWRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:17:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E1421582;
        Thu,  2 Jan 2020 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003452;
        bh=//md0SP1j14tlYgqQUFEa08cSupdWyzLqvhOB/J0sPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VVfjvTm5iOrUSAaMiTcU0ExTEQtDfoB+HgkY7wIFb9gmzc36yJsEqOOQMmgC3zMQ6
         PM5iuRi0t2ksepxxQdjUea4wf+bGg5bHvUxdNv2M01bgHcP0wkny40vbG7wyUWphbd
         TL0wcBMT+JGtJkUQRRDSHXV29Y7g2TuGGzC3dCRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Alex Veber <alexve@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 166/191] mlxsw: spectrum: Use dedicated policer for VRRP packets
Date:   Thu,  2 Jan 2020 23:07:28 +0100
Message-Id: <20200102215847.131563257@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit acca789a358cc960be3937851d7de6591c79d6c2 ]

Currently, VRRP packets and packets that hit exceptions during routing
(e.g., MTU error) are policed using the same policer towards the CPU.
This means, for example, that misconfiguration of the MTU on a routed
interface can prevent VRRP packets from reaching the CPU, which in turn
can cause the VRRP daemon to assume it is the Master router.

Fix this by using a dedicated policer for VRRP packets.

Fixes: 11566d34f895 ("mlxsw: spectrum: Add VRRP traps")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alex Veber <alexve@mellanox.com>
Tested-by: Alex Veber <alexve@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h      |    1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -5421,6 +5421,7 @@ enum mlxsw_reg_htgt_trap_group {
 	MLXSW_REG_HTGT_TRAP_GROUP_SP_LBERROR,
 	MLXSW_REG_HTGT_TRAP_GROUP_SP_PTP0,
 	MLXSW_REG_HTGT_TRAP_GROUP_SP_PTP1,
+	MLXSW_REG_HTGT_TRAP_GROUP_SP_VRRP,
 
 	__MLXSW_REG_HTGT_TRAP_GROUP_MAX,
 	MLXSW_REG_HTGT_TRAP_GROUP_MAX = __MLXSW_REG_HTGT_TRAP_GROUP_MAX - 1
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4398,8 +4398,8 @@ static const struct mlxsw_listener mlxsw
 	MLXSW_SP_RXL_MARK(ROUTER_ALERT_IPV6, TRAP_TO_CPU, ROUTER_EXP, false),
 	MLXSW_SP_RXL_MARK(IPIP_DECAP_ERROR, TRAP_TO_CPU, ROUTER_EXP, false),
 	MLXSW_SP_RXL_MARK(DECAP_ECN0, TRAP_TO_CPU, ROUTER_EXP, false),
-	MLXSW_SP_RXL_MARK(IPV4_VRRP, TRAP_TO_CPU, ROUTER_EXP, false),
-	MLXSW_SP_RXL_MARK(IPV6_VRRP, TRAP_TO_CPU, ROUTER_EXP, false),
+	MLXSW_SP_RXL_MARK(IPV4_VRRP, TRAP_TO_CPU, VRRP, false),
+	MLXSW_SP_RXL_MARK(IPV6_VRRP, TRAP_TO_CPU, VRRP, false),
 	/* PKT Sample trap */
 	MLXSW_RXL(mlxsw_sp_rx_listener_sample_func, PKT_SAMPLE, MIRROR_TO_CPU,
 		  false, SP_IP2ME, DISCARD),
@@ -4483,6 +4483,10 @@ static int mlxsw_sp_cpu_policers_set(str
 			rate = 19 * 1024;
 			burst_size = 12;
 			break;
+		case MLXSW_REG_HTGT_TRAP_GROUP_SP_VRRP:
+			rate = 360;
+			burst_size = 7;
+			break;
 		default:
 			continue;
 		}
@@ -4522,6 +4526,7 @@ static int mlxsw_sp_trap_groups_set(stru
 		case MLXSW_REG_HTGT_TRAP_GROUP_SP_OSPF:
 		case MLXSW_REG_HTGT_TRAP_GROUP_SP_PIM:
 		case MLXSW_REG_HTGT_TRAP_GROUP_SP_PTP0:
+		case MLXSW_REG_HTGT_TRAP_GROUP_SP_VRRP:
 			priority = 5;
 			tc = 5;
 			break;


