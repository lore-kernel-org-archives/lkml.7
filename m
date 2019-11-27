Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCB5C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C9F21555
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888931;
	bh=Uqz+Pl5c/Di1mUQpPbEYuvi2Q8PKELQ8wd/LOIjO17k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LvbNxpjBBQDIlT0mvgLjBeT+0VQ+goCJRUqH6aaTjxLczoMe3hGe7HS/MU7Uu+nyy
	 XJLFHjyFM6nyTcETNQ0+X2KbLMuhTmBtyW7LCFoC6bd09I3ARRF6JRT2FUKKnxXW0t
	 0V1RZnem9NLqYJsaDXQXRXE3KvmAhQW71IsPYNTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbfK0VIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:08:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732372AbfK0VIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:08:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5982086A;
        Wed, 27 Nov 2019 21:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888923;
        bh=Uqz+Pl5c/Di1mUQpPbEYuvi2Q8PKELQ8wd/LOIjO17k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNLj5rBK/4Rzo4R8A4HBWyudDZeA2JUSbeHR9TiQzlQoflAOH/FeDqRBK1g+CX59L
         dxa8kfCUtvpksqI54Pfik74D8DIugmYkOygRsplqaBTbYmiG7YFrQ5DY9L/O2fPGPM
         wTDcUL/Ajb/Dp05AHizuelFVdV8GhgMo/IdEFe2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.3 16/95] net/mlx5e: Do not use non-EXT link modes in EXT mode
Date:   Wed, 27 Nov 2019 21:31:33 +0100
Message-Id: <20191127202850.246292290@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 24960574505c49b102ca1dfa6bf109669bca2a66 ]

On some old Firmwares, connector type value was not supported, and value
read from FW was 0. For those, driver used link mode in order to set
connector type in link_ksetting.

After FW exposed the connector type, driver translated the value to ethtool
definitions. However, as 0 is a valid value, before returning PORT_OTHER,
driver run the check of link mode in order to maintain backward
compatibility.

Cited patch added support to EXT mode.  With both features (connector type
and EXT link modes) ,if connector_type read from FW is 0 and EXT mode is
set, driver mistakenly compare EXT link modes to non-EXT link mode.
Fixed that by skipping this comparison if we are in EXT mode, as connector
type value is valid in this scenario.

Fixes: 6a897372417e ("net/mlx5: ethtool, Add ethtool support for 50Gbps per lane link modes")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Reviewed-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -708,9 +708,9 @@ static int get_fec_supported_advertised(
 
 static void ptys2ethtool_supported_advertised_port(struct ethtool_link_ksettings *link_ksettings,
 						   u32 eth_proto_cap,
-						   u8 connector_type)
+						   u8 connector_type, bool ext)
 {
-	if (!connector_type || connector_type >= MLX5E_CONNECTOR_TYPE_NUMBER) {
+	if ((!connector_type && !ext) || connector_type >= MLX5E_CONNECTOR_TYPE_NUMBER) {
 		if (eth_proto_cap & (MLX5E_PROT_MASK(MLX5E_10GBASE_CR)
 				   | MLX5E_PROT_MASK(MLX5E_10GBASE_SR)
 				   | MLX5E_PROT_MASK(MLX5E_40GBASE_CR4)
@@ -842,9 +842,9 @@ static int ptys2connector_type[MLX5E_CON
 		[MLX5E_PORT_OTHER]              = PORT_OTHER,
 	};
 
-static u8 get_connector_port(u32 eth_proto, u8 connector_type)
+static u8 get_connector_port(u32 eth_proto, u8 connector_type, bool ext)
 {
-	if (connector_type && connector_type < MLX5E_CONNECTOR_TYPE_NUMBER)
+	if ((connector_type || ext) && connector_type < MLX5E_CONNECTOR_TYPE_NUMBER)
 		return ptys2connector_type[connector_type];
 
 	if (eth_proto &
@@ -945,9 +945,9 @@ int mlx5e_ethtool_get_link_ksettings(str
 	eth_proto_oper = eth_proto_oper ? eth_proto_oper : eth_proto_cap;
 
 	link_ksettings->base.port = get_connector_port(eth_proto_oper,
-						       connector_type);
+						       connector_type, ext);
 	ptys2ethtool_supported_advertised_port(link_ksettings, eth_proto_admin,
-					       connector_type);
+					       connector_type, ext);
 	get_lp_advertising(mdev, eth_proto_lp, link_ksettings);
 
 	if (an_status == MLX5_AN_COMPLETE)


