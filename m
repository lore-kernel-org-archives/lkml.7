Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3153EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F333520651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355440;
	bh=N13sUF+BrxOZaRnEZ7PRG9eIL2Oxnp00gUVs+9JuIT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=djRCpmy1rkQAJnKeTsYRzBaeAv1a7LGSaGvhD7rQDO+DdiJZJIDgoPLDA9FGbPpqD
	 PuaPxJxspVaT9BPVYB7k3Xvlsbd+3G3a5HYMn2xuVCbuELjAC4GsMPynf13nP4C9DQ
	 ya/myVJZXG5aw7+0WfrcP87Ru/Pz7QLNkkDiLBTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfDOTKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730467AbfDOTKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A698421902;
        Mon, 15 Apr 2019 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355435;
        bh=N13sUF+BrxOZaRnEZ7PRG9eIL2Oxnp00gUVs+9JuIT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzDAU9weXJvSNXsoW4M2qk6ysxyEGGYkEiELVCLuYnw3g0vKHMpCD3CkTpHgfEcIg
         10Ife1lJVdvKeJ8jDzXs0KhDcZM83nlDBPkHCzXu3K3SG51/aqOOksnn6kpQj+zm/O
         w3ca30fhCMeGTHDa3lqmoJKyLaK3kTc4ZEyNuyBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Righi <andrea.righi@canonical.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 019/117] openvswitch: fix flow actions reallocation
Date:   Mon, 15 Apr 2019 20:59:49 +0200
Message-Id: <20190415183745.876779406@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f28cd2af22a0c134e4aa1c64a70f70d815d473fb ]

The flow action buffer can be resized if it's not big enough to contain
all the requested flow actions. However, this resize doesn't take into
account the new requested size, the buffer is only increased by a factor
of 2x. This might be not enough to contain the new data, causing a
buffer overflow, for example:

[   42.044472] =============================================================================
[   42.045608] BUG kmalloc-96 (Not tainted): Redzone overwritten
[   42.046415] -----------------------------------------------------------------------------

[   42.047715] Disabling lock debugging due to kernel taint
[   42.047716] INFO: 0x8bf2c4a5-0x720c0928. First byte 0x0 instead of 0xcc
[   42.048677] INFO: Slab 0xbc6d2040 objects=29 used=18 fp=0xdc07dec4 flags=0x2808101
[   42.049743] INFO: Object 0xd53a3464 @offset=2528 fp=0xccdcdebb

[   42.050747] Redzone 76f1b237: cc cc cc cc cc cc cc cc                          ........
[   42.051839] Object d53a3464: 6b 6b 6b 6b 6b 6b 6b 6b 0c 00 00 00 6c 00 00 00  kkkkkkkk....l...
[   42.053015] Object f49a30cc: 6c 00 0c 00 00 00 00 00 00 00 00 03 78 a3 15 f6  l...........x...
[   42.054203] Object acfe4220: 20 00 02 00 ff ff ff ff 00 00 00 00 00 00 00 00   ...............
[   42.055370] Object 21024e91: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   42.056541] Object 070e04c3: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   42.057797] Object 948a777a: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   42.059061] Redzone 8bf2c4a5: 00 00 00 00                                      ....
[   42.060189] Padding a681b46e: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ

Fix by making sure the new buffer is properly resized to contain all the
requested data.

BugLink: https://bugs.launchpad.net/bugs/1813244
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/flow_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 691da853bef5..4bdf5e3ac208 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2306,14 +2306,14 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
 
 	struct sw_flow_actions *acts;
 	int new_acts_size;
-	int req_size = NLA_ALIGN(attr_len);
+	size_t req_size = NLA_ALIGN(attr_len);
 	int next_offset = offsetof(struct sw_flow_actions, actions) +
 					(*sfa)->actions_len;
 
 	if (req_size <= (ksize(*sfa) - next_offset))
 		goto out;
 
-	new_acts_size = ksize(*sfa) * 2;
+	new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
 
 	if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
 		if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size) {
-- 
2.19.1



