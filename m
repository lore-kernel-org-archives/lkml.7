Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C37C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D245C2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563420091;
	bh=b7p+RJ6o2UgJrYQh8sPvZ0pKkdFTOBgNmJhKU2wALJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QQswFXz6TKlkIaAWKwp/eATapf2hwW2EdK9LA1bz02EUxEgK3fRS4F2HmfLj8VjcY
	 GJ08Kvkc3Mtehyxz0wgO+gb4EOIbkLZGcXXjvG1tTZf8osvMzWriBAEgCYKkL/5Yzh
	 nCTJy/0+Tj521GUN+H67eC9qBzjmNdrdzv7lr9og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389966AbfGRDJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403824AbfGRDJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:09:43 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49351205F4;
        Thu, 18 Jul 2019 03:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419382;
        bh=b7p+RJ6o2UgJrYQh8sPvZ0pKkdFTOBgNmJhKU2wALJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OERGpW2qRjIBS2LXRdZGggFmPAcI/Ouu+mUZ13S80OpJ9tbK2WnGp9wYkXkICYzdA
         ZeWr+buQ1IjzTgjbHFuYgfFNaOYE8u1NTQSdc7XyGe6NmFEwNTKmCoYh9xXydbcy5G
         SvwiTH92q/+Z8ILMi4BstFMp+uw1leBNMZ2of2mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/80] mlxsw: spectrum: Disallow prio-tagged packets when PVID is removed
Date:   Thu, 18 Jul 2019 12:01:16 +0900
Message-Id: <20190718030100.721989850@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4b14cc313f076c37b646cee06a85f0db59cf216c ]

When PVID is removed from a bridge port, the Linux bridge drops both
untagged and prio-tagged packets. Align mlxsw with this behavior.

Fixes: 148f472da5db ("mlxsw: reg: Add the Switch Port Acceptable Frame Types register")
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 5acfbe5b8b9d..8ab7a4f98a07 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -911,7 +911,7 @@ static inline void mlxsw_reg_spaft_pack(char *payload, u8 local_port,
 	MLXSW_REG_ZERO(spaft, payload);
 	mlxsw_reg_spaft_local_port_set(payload, local_port);
 	mlxsw_reg_spaft_allow_untagged_set(payload, allow_untagged);
-	mlxsw_reg_spaft_allow_prio_tagged_set(payload, true);
+	mlxsw_reg_spaft_allow_prio_tagged_set(payload, allow_untagged);
 	mlxsw_reg_spaft_allow_tagged_set(payload, true);
 }
 
-- 
2.20.1



