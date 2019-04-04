Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D63C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30A3217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368185;
	bh=16veBeKGaJGiOt9OCMk5w8zdfxAvLZ+HXhx0K2To1lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1AkJt998CSjqgGSXjRN0Ir4GLStfJbcu1JoEa0httI/TLXj0wE3uEPiMJQsgzBWI+
	 LqSCT+4oq3ycQjl4BqjpPt+hRScTcHZnTXl4Q3rG4sBGo5jKxcj2YebBpm1hJIcqcu
	 hRhD38QZuD5kuDkCGla9GlQvt5AwwUE/QfKofadE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfDDI4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDI4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:56:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3024620693;
        Thu,  4 Apr 2019 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368179;
        bh=16veBeKGaJGiOt9OCMk5w8zdfxAvLZ+HXhx0K2To1lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQwTEsN7z6k72H9Gmx8xk6a+zyzgIPS8NKpo1ujehIxp/6ASiq3u+7jEArubE6FG6
         IURgBkEOwAwGEDl4uPbun8ZPtKrC1u+HTMJ077Lr1lOjYkNFRV+SZHN4siFnJO9IpH
         aFKpVOtl2/uIp6UBIPODw8GIeVCTEhhMx6bw57X4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 050/121] mlxsw: spectrum: Avoid -Wformat-truncation warnings
Date:   Thu,  4 Apr 2019 10:47:18 +0200
Message-Id: <20190404084547.965617683@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 8ff92649f9ce..29d37355d8c6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2019,7 +2019,7 @@ static void mlxsw_sp_port_get_prio_strings(u8 **p, int prio)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_PRIO_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
 			 mlxsw_sp_port_hw_prio_stats[i].str, prio);
 		*p += ETH_GSTRING_LEN;
 	}
@@ -2030,7 +2030,7 @@ static void mlxsw_sp_port_get_tc_strings(u8 **p, int tc)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_TC_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
 			 mlxsw_sp_port_hw_tc_stats[i].str, tc);
 		*p += ETH_GSTRING_LEN;
 	}
-- 
2.19.1



