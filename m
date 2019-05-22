Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF091C282DE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949BC2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554713;
	bh=Buqndm3cxnXvPQ8zzQzt0Zoz3x/wpACFG1jlQ2chfdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R1wsvP1uon2D2PrvHkjqbftd177UspA4wzCq5f2pVCJYG/jFv69Dd0lphI9/2PN6H
	 k7YWN59imNisF1Nd8feqt1njL/v2+XXGuCh+7ARaIqztnq0R766ifoyeI6u0P38hf7
	 pKfQL/uHB9+CC952dY4YcOhsqqlPDJcUIkNLMZ+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbfEVT0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731923AbfEVT0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:26:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAA7217D7;
        Wed, 22 May 2019 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553176;
        bh=Buqndm3cxnXvPQ8zzQzt0Zoz3x/wpACFG1jlQ2chfdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HY+nEmXV0OP05yfvN+cBnyGu+lDjDNZGbWkHumTgk19zVWtMLh8usvbCuBKDKdmy/
         gVAk01UXK0ZuJQaUHRHC1jCeBpm8FlqfwGqvyBi0fMHHq45MpaccuSQzFU0v9cRcUA
         eM1i8jcNf6z3Xrn4PY0bVCJz4PTPyHFrnW8eNtA4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 095/317] mlxsw: spectrum_router: Prevent ipv6 gateway with v4 route via replace and append
Date:   Wed, 22 May 2019 15:19:56 -0400
Message-Id: <20190522192338.23715-95-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 7973d9e76727aa42f0824f5569e96248a572d50b ]

mlxsw currently does not support v6 gateways with v4 routes. Commit
19a9d136f198 ("ipv4: Flag fib_info with a fib_nh using IPv6 gateway")
prevents a route from being added, but nothing stops the replace or
append. Add a catch for them too.
    $ ip  ro add 172.16.2.0/24 via 10.99.1.2
    $ ip  ro replace 172.16.2.0/24 via inet6 fe80::202:ff:fe00:b dev swp1s0
    Error: mlxsw_spectrum: IPv6 gateway with IPv4 route is not supported.
    $ ip  ro append 172.16.2.0/24 via inet6 fe80::202:ff:fe00:b dev swp1s0
    Error: mlxsw_spectrum: IPv6 gateway with IPv4 route is not supported.

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 2f6afbfd689fd..3827f6288271a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -6065,6 +6065,8 @@ static int mlxsw_sp_router_fib_event(struct notifier_block *nb,
 			return notifier_from_errno(err);
 		break;
 	case FIB_EVENT_ENTRY_ADD:
+	case FIB_EVENT_ENTRY_REPLACE: /* fall through */
+	case FIB_EVENT_ENTRY_APPEND:  /* fall through */
 		if (router->aborted) {
 			NL_SET_ERR_MSG_MOD(info->extack, "FIB offload was aborted. Not configuring route");
 			return notifier_from_errno(-EINVAL);
-- 
2.20.1

