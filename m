Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E2C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE692177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709910;
	bh=G3lsaZVnsAn9stcRdD1TEO+6ZzGaalYkdpwWE+LwnXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rX7oCPoqwI4W+5LZui2jRiKGKp4c/wAZUmDpMEGBomYj05dEdf28iIXIYb1wjelMd
	 3K34R8GcpxS39QV5Od+QLEYK2RdQ4TNiguF/mI+BLl8vfl3wZqr2Mzshs4fMg/+18o
	 IVyNzFVtIsOcHAJ9GDQ0dOSeDIu/DAoYFlBWxf/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfC0SFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbfC0SFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F15F217D9;
        Wed, 27 Mar 2019 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709899;
        bh=G3lsaZVnsAn9stcRdD1TEO+6ZzGaalYkdpwWE+LwnXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dESOzM4VYyI3V4XOzBXs2Xpg7RrRF/XD7S56m4yQEzeBIyA1rcx2Li+dT4NE/HXBW
         Ognayso9w1D60e/9RPnpBYaAHfrUGenY8mTX82UymaE7tzOefXF8mz8bA2SrZkiQvF
         QgTrLVs/kVNP3B4Rc2eQvHnCs+VLWHp2tFH0LGwo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 097/262] mlxsw: spectrum: Avoid -Wformat-truncation warnings
Date:   Wed, 27 Mar 2019 13:59:12 -0400
Message-Id: <20190327180158.10245-97-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

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
index b65e274b02e9..cbdee5164be7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2105,7 +2105,7 @@ static void mlxsw_sp_port_get_prio_strings(u8 **p, int prio)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_PRIO_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
 			 mlxsw_sp_port_hw_prio_stats[i].str, prio);
 		*p += ETH_GSTRING_LEN;
 	}
@@ -2116,7 +2116,7 @@ static void mlxsw_sp_port_get_tc_strings(u8 **p, int tc)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_TC_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%s_%d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
 			 mlxsw_sp_port_hw_tc_stats[i].str, tc);
 		*p += ETH_GSTRING_LEN;
 	}
-- 
2.19.1

