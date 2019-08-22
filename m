Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D43C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADDA233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493866;
	bh=DoT9S0gprPtByE9wu5OYh8hWRFkIVSatF+SD1AXibZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0pPiaCHkNNKUSEWguU06cvSewtgfKh3nFVmrJP9n5aNu03OSQoIM40j0sI8zB2R5R
	 2cVfyGdiStzCmIi60TPetWP4ldNKgjrqg1G/pR4jGvUMVLLwqhdpdEL5604JGAW5UW
	 0AQT56qL5ib77qOJB6mTQiDJjvzZ6+Dik7N2/Hvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390884AbfHVRLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390721AbfHVRJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:09:18 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0663D23404;
        Thu, 22 Aug 2019 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493757;
        bh=DoT9S0gprPtByE9wu5OYh8hWRFkIVSatF+SD1AXibZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eV5oyAIcwo/Wnz2epDMjVfKJl12QV18X41c1lm++vX5hxvMKNUp4JK409ozqO1dJj
         44W9maemEp7OLJEw3ei7ptKvUWULwrV2ur3dqo+289ZwCYrLzltS6WzpIJ0ZRj5TtK
         Jgf5eIL1EPWTtSe1F2d7dQ+fibjP7vlHhDD20r6o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 116/135] tipc: initialise addr_trail_end when setting node addresses
Date:   Thu, 22 Aug 2019 13:07:52 -0400
Message-Id: <20190822170811.13303-117-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

[ Upstream commit 8874ecae2977e5a2d4f0ba301364435b81c05938 ]

We set the field 'addr_trial_end' to 'jiffies', instead of the current
value 0, at the moment the node address is initialized. This guarantees
we don't inadvertently enter an address trial period when the node
address is explicitly set by the user.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/addr.c b/net/tipc/addr.c
index b88d48d009130..0f1eaed1bd1b3 100644
--- a/net/tipc/addr.c
+++ b/net/tipc/addr.c
@@ -75,6 +75,7 @@ void tipc_set_node_addr(struct net *net, u32 addr)
 		tipc_set_node_id(net, node_id);
 	}
 	tn->trial_addr = addr;
+	tn->addr_trial_end = jiffies;
 	pr_info("32-bit node address hash set to %x\n", addr);
 }
 
-- 
2.20.1

