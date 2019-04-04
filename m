Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412CD2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368515;
	bh=I2QDmcozZkWN7ngFiPiJpwPdvxcXMk91BkmYyiUw6HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NbtlqntMwzLzPafT9fyisRJ3B+WJ8u3NJp6BClI8zIB7lue9mCE717slFRDx6AIhM
	 4KbmeEmvYT64VMF6hrzht4wi9pzXnFqEWRHbVGABENDksNM41IpJBDcCadKdA+wCwt
	 tOnL9uV2qf3bHuSHxlH5vNOEMyYLJ3bLS+9NNgfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfDDJBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731493AbfDDJBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:01:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2344A2147C;
        Thu,  4 Apr 2019 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368510;
        bh=I2QDmcozZkWN7ngFiPiJpwPdvxcXMk91BkmYyiUw6HU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tk0gcQBMi3Ju5q4IrWy+EKI81vOBoA3gPKS/nFi2rrA5IlogEe2k74v/wX9e6sO8f
         pb3IPz5xGlvBR5eavxz3tvs1vwczIPrbVV4f1L2pWFzsCorxi9R5tJKqDeM73pC7Hk
         2vyMIo5FXqTJuOMcVSJPjLCYlcnsabPk/sl88oew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/187] mlxsw: spectrum: Avoid -Wformat-truncation warnings
Date:   Thu,  4 Apr 2019 10:46:43 +0200
Message-Id: <20190404084606.160318303@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ab2c4e2581ad32c28627235ff0ae8c5a5ea6899f ]

Give precision identifiers to the two snprintf() formatting the priority
and TC strings to avoid producing these two warnings:

drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function
'mlxsw_sp_port_get_prio_strings':
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2132:37: warning: '%d'
directive output may be truncated writing between 1 and 3 bytes into a
region of size between 0 and 31 [-Wformat-truncation=]
   snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
                                     ^~
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2132:3: note: 'snprintf'
output between 3 and 36 bytes into a destination of size 32
   snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     mlxsw_sp_port_hw_prio_stats[i].str, prio);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/mellanox/mlxsw/spectrum.c: In function
'mlxsw_sp_port_get_tc_strings':
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2143:37: warning: '%d'
directive output may be truncated writing between 1 and 11 bytes into a
region of size between 0 and 31 [-Wformat-truncation=]
   snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
                                     ^~
drivers/net/ethernet/mellanox/mlxsw/spectrum.c:2143:3: note: 'snprintf'
output between 3 and 44 bytes into a destination of size 32
   snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     mlxsw_sp_port_hw_tc_stats[i].str, tc);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index a12b5710891e..f9bef030ee05 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1988,7 +1988,7 @@ static void mlxsw_sp_port_get_prio_strings(u8 **p, int prio)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_PRIO_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
 			 mlxsw_sp_port_hw_prio_stats[i].str, prio);
 		*p += ETH_GSTRING_LEN;
 	}
@@ -1999,7 +1999,7 @@ static void mlxsw_sp_port_get_tc_strings(u8 **p, int tc)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_TC_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
 			 mlxsw_sp_port_hw_tc_stats[i].str, tc);
 		*p += ETH_GSTRING_LEN;
 	}
-- 
2.19.1



